/datum/religion/messiah
	name = MESSIAH
	holy_item = new /obj/item/crucifix()
	shrine =/obj/old_god_shrine/messiah_shrine

/datum/old_god_spell/imbue
	name = "Imbue"
	requirments =  list("NORTH" = /obj/item/weapon/flame/candle/,
						"EAST" = /obj/item/weapon/flame/candle/,
						"WEST" = /obj/item/weapon/flame/candle/,
						"SOUTH" = /obj/item/weapon/flame/candle/)
	old_god = MESSIAH

	spell_effect(var/mob/living/user)
		for(var/obj/item/weapon/flame/candle/C in range(2, user))
			C.light("")
			for(var/obj/item/crucifix/x in user.contents)
				x.empowered = TRUE
				x.update_icon()

/datum/old_god_spell/blinding
	name = "Blind"
	requirments =  list("SOUTHWEST" = /obj/item/weapon/flame/candle/,
						"SOUTH" = /obj/item/weapon/flame/candle/,
						"SOUTHEAST" = /obj/item/weapon/flame/candle/,
						"WEST" = /obj/item/weapon/flame/candle/,
						"EAST" = /obj/item/weapon/flame/candle/)
	old_god = MESSIAH

	spell_effect(var/mob/living/user)
		for(var/obj/item/weapon/flame/candle/C in range(2, user))
			C.light("")
			for(var/obj/item/crucifix/x in user.contents)
				x.empowered = TRUE
				x.update_icon()

/obj/item/crucifix
	name = "Crucifix"
	desc = "A small strangly carved symbol of the old church"
	w_class = ITEM_SIZE_SMALL
	icon = 'icons/obj/religion.dmi'
	icon_state = "cross"
	w_class = ITEM_SIZE_SMALL
	var/empowered = FALSE

/obj/item/crucifix/update_icon()
	if(empowered)
		icon_state = "gcross"
	else
		icon_state = "cross"

/obj/item/crucifix/attack_self(var/mob/living/user)
	if(empowered)
		var/self = "You raise your Crucifix and chant as it begins to glow!."
		src.visible_message("<span class='warning'>\The [src] begins chanting as a briliant light begins to shine!</span>", "<span class='notice'>[self]</span>", "You hear a low hum.")
		var/turf/T = get_turf(src)
		playsound(T, "sound/weapons/flash.ogg",100,1)
		for(var/mob/living/carbon/M in oview(5))
			if(M.religion != MESSIAH)
				playsound(src.loc, 'sound/effects/bang.ogg', 50, 1, 30)
				var/safety = M.eyecheck()
				M.flash_eyes(FLASH_PROTECTION_MODERATE - safety)
				M.eye_blurry += 2
				M.Weaken(10)
		empowered = FALSE
		update_icon()
	
/obj/old_god_shrine/messiah_shrine
	name = "Jes shrine"
	icon_state = "woodcross"
