//Old god spells.  Defines rrequirements and effect if the spell is cast
// REQUIRMENTS: All spells require specific items in a specific location on a 3x3 grid.  there are specified as:
// NORTHWEST | NORTH | NORTHEAST
// WEST      | CENTER | EAST
// SOUTHWEST | SOUTH | SOUTHEAST

// spell_effect: All spells have an effect when they are activated and the requirments are met.  Define anything you want the spell to do here.

// THESE ARE THE ONLY THINGS YOU NEED TO DO TO CREATE A NEW OLD GOD SPELL.  THERE ARE SOME THINGS NOT TO DO
// DO NOT OVERRIDE 


/datum/old_god_spell
	var/name = "old god spell"
	var/list/requirments = list()
	var/old_god = "None"

	proc/spell_effect(var/mob/living/user)
		to_world("Something is fucked up, you should not be seeing this.  It's from old god spell code, go tell a coder.")

/datum/old_god_spell/smoke_example
	name = "Simple puff of smoke to demonstrate"
	requirments = list("NORTH" = /obj/item/weapon/paper)
	old_god = "None"

	spell_effect(var/mob/living/user)
		to_world("The smoke fucking worked?  Maybe the rest will (it won't")
		var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
		smoke.set_up(5, 0, user.loc)
		smoke.attach(user)
		smoke.start()

//Yeah this is fucking stupid, but I can't make associatve lists like list(NORTH=1) because fucking byond, so we need to do list("NORTH"=1) and pass through here.  
proc/DIRECTION_TO_VAL(var/direction)
	switch(direction)
		if("NORTH") return NORTH
		if("NORTHEAST") return NORTHEAST
		if("EAST") return EAST
		if("SOUTHEAST") return SOUTHEAST
		if("SOUTH") return SOUTH
		if("SOUTHWEST") return SOUTHWEST
		if("WEST") return WEST
		if("NORTHWEST") return NORTHWEST
	return null
