/obj/item/glow_stone
	name = "Glow stone"
	desc = "A strange glowing rock used by followers of Zin, the lightbringer"
	w_class = ITEM_SIZE_SMALL
	icon = 'icons/obj/old_god.dmi'
	icon_state = "light_shard"
	item_state = "flashlight"

/obj/item/glow_stone/Initialize()
	. = ..()
	set_light(3)

/datum/religion/lightbringer
	name = "Zin the lightbringer"
	holy_item = /obj/item/glow_stone
	shrine = /obj/machinery/old_god_shrine/lightbringer_shrine
	favor = 0

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

/obj/machinery/old_god_shrine/lightbringer_shrine/proc/process()
	if (candles.len == 0)
		Destroy()
	for(var/obj/item/weapon/flame/candle/C in candles) //Check for candles around
		if(C.lit)
			GLOB.all_religions["Zin the lightbringer"].favor += 0.5
		else
			candles -= C