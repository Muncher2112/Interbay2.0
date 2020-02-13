//This file is responsible for all kind of spell casting with old god stuff.  Hopefully it will be implimented in such a way that all someone needs to do to adds a spell is define a spell object with
// - Ingredients and 3x3 locations
// - Verb to call


//Old god "shrines" are whatever a cultists uses to cast magic.  Magic is cast by laying the correct objects in the correct configuration around a shrine, in a 3x3 patter, or
// X  X  X
// X  X  X
// X  X  X
/obj/old_god_shrine
	name = "Old God Shrine"
	icon = 'icons/obj/religion.dmi'
	icon_state = "woodcross"
	density = 1
	anchored = 1

/obj/old_god_shrine/New()
	return

// DONT OVERRIDE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
//  This does all the decoding from old_god_shrine datum -> actual spell
//  It looks up all spells with your God's tag, and then checks the requirments.  If you meet them, runs the spell's
/obj/old_god_shrine/proc/activate(var/mob/living/user)
	var/list/spells = list()
	for(var/S in GLOB.all_spells)
		if(GLOB.all_spells[S].old_god == user.religion)
			spells += GLOB.all_spells[S]
	var/datum/old_god_spell/selected_spell = input(user, "What spell will we use?") as null|anything in spells
	for(var/direction in selected_spell.requirments)
		// First check if it's empty
		var/found = FALSE
		//get turf contents
		for(var/obj/item/a in get_step(src, DIRECTION_TO_VAL(direction)).contents)
			if(istype(a, selected_spell.requirments[direction]))
				found = TRUE
		if (found == FALSE)
			visible_message("<span class='notice'>\The [src] glows faintly, then falls dark</span>")
			return
	if(selected_spell.requirments)
		selected_spell.spell_effect(user)

/obj/old_god_shrine/attack_hand(var/mob/living/user)
	activate(user)

/obj/old_god_shrine/proc/near_camera()
	if (!isturf(loc))
		return 0
	else if(!cameranet.is_visible(src))
		return 0
	GLOB.global_headset.autosay("Heretical Shrine detected in [get_area(src)]","Verina","Inquisition")
	return 1