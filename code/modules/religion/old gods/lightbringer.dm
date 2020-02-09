/obj/item/device/glow_stone
	name = "Glow stone"
	desc = "A strange glowing rock used by followers of Zin, the lightbringer"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "light_shard"
	item_state = "flashlight"
	w_class = ITEM_SIZE_SMALL
	var/brightness_on = 3
	var/on = FALSE

/obj/item/device/glow_stone/Process()
	if(GLOB.all_religions[LIGHTBRINGER].favor > 0)
		GLOB.all_religions[LIGHTBRINGER].favor -= 1
	else 
		on = FALSE
		STOP_PROCESSING(SSobj, src)

/obj/item/device/glow_stone/update_icon()
	if(on)
		icon_state = "[initial(icon_state)]-on"
		set_light(brightness_on)
	else
		icon_state = "[initial(icon_state)]"
		set_light(0)

/obj/item/device/glow_stone/attack_self(mob/user)
	if(!on)
		if(turn_on(user))
			user.visible_message("<span class='notice'>\The [user] whsipers into \the [src].</span>", "<span class='notice'>You whisper into the glow stone, activating it!</span>")
	else 
		turn_off(user)

/obj/item/device/glow_stone/proc/turn_off()
	on = FALSE
	STOP_PROCESSING(SSobj, src)
	update_icon()

/obj/item/device/glow_stone/proc/turn_on(mob/user)
	//First do a religion check
	if(isliving(user))
		var/mob/living/L = user
		if(L.religion == LIGHTBRINGER)
			if(!GLOB.all_religions[LIGHTBRINGER].favor)
				to_chat(user, "<span class='notice'>Zin expects something from you first</span>")
				return FALSE
			on = TRUE
			START_PROCESSING(SSobj, src)
			update_icon()
			return TRUE
	to_chat(user, "<span class='notice'>The shard does nothing</span>")
	return FALSE


/datum/religion/lightbringer
	name = "Zin the lightbringer"
	holy_item = new /obj/item/device/glow_stone()
	shrine = /obj/machinery/old_god_shrine/lightbringer_shrine
	favor = 0

/datum/religion/lightbringer/add_spells(mob/target)
	target.verbs += /mob/living/proc/defending_light

/obj/machinery/old_god_shrine/lightbringer_shrine
	name = "Lightbringer shrine"
	icon_state = "lightbringer"
	var/list/candles = list()

/obj/machinery/old_god_shrine/lightbringer_shrine/New(l,d=0)
	for(var/obj/item/weapon/flame/candle/C in range(1, src))
		candles += C
		C.light("Zin lights the candle")
	if(candles.len > 0)
		..()
	else 
		visible_message("<span class='warning'>Zin demands light around his shrine!</span>")
		Destroy()

/obj/machinery/old_god_shrine/lightbringer_shrine/Process()
	if (candles.len == 0)
		Destroy()
	for(var/obj/item/weapon/flame/candle/C in candles) //Check for candles around
		if(C.lit)
			GLOB.all_religions[LIGHTBRINGER].favor += 1
		else
			candles -= C

/mob/living/proc/defending_light()
	set category = "Old God Magic"
	set name = "Sheltering Light"
	var/turf/T = get_turf(src)
	var/datum/religion/user_religion = GLOB.all_religions[religion]
	//You need your god's item to do this
	if(!istype(get_active_hand(), user_religion.holy_item) && !istype(get_inactive_hand(), user_religion.holy_item))
		to_chat(src, "<span class='warning'>You can't use this without your [user_religion.holy_item]!</span>")
		return
	if(GLOB.all_religions[LIGHTBRINGER].favor < 100)
		to_chat(src, "<span class='notice'>Zin expects more devotion from you first.</span>")
		return FALSE
	user_religion.favor -= 100
	var/timer = 10
	var/self = "You raise your [user_religion.holy_item] and chant as it begins to glow!."
	visible_message("<span class='warning'>\The [src] begins chanting as a briliant light begins to shine!</span>", "<span class='notice'>[self]</span>", "You hear a low hum.")
	playsound(T, "sound/weapons/flash.ogg",100,1)
	if(do_after(src, timer))
		for(var/mob/living/carbon/M in oviewers(5, null))
			if(M.religion != LIGHTBRINGER)
				playsound(src.loc, 'sound/effects/bang.ogg', 50, 1, 30)
				if(!M.blinded)
					M.flash_eyes()
					M.eye_blurry += 2
					M.Stun(2)
