//////////////////////////////////////////////////////////////////////////
//This is the file where all the stats and skills procs are kept.	    //
//The system is kinda barebones now but I hope to rewrite it to  	    //
//be betting in the near future. 								 	    //
//																 	    //
//Stats are pretty generic, skills are kind of specific. 				//
//You should just be able to plop in the proc call wherever you want.   //
//I tried to make it versitile.											//
// - Matt 																//
//////////////////////////////////////////////////////////////////////////

//defines
#define CRIT_SUCCESS_NORM 1
#define CRIT_FAILURE_NORM 1
#define CRIT_SUCCESS 2
#define CRIT_FAILURE 3


//I am aware this is probably the worst possible way of doing it but I'm using this method till I get a better one. - Matt
/mob
/*
	var/str = 10    //strength - used for hitting and lifting.
	var/dex = 10    //dexterity - used for dodging and parrying.
	var/int = 10    //intelligence - use for reading, engineering and crafting
	var/con = 10    //consitution - used for healing, blood regen, and poison effectivness
*/
	//Stats are now going into a list.  It may use more space in mem,  but having them as freefloating variables makes them a pain to access as a whole
	var/stats = list(str = 10, dex = 10, int = 10, con = 10)

    //skills
	var/melee_skill = 50
	var/ranged_skill = 50
	var/medical_skill = 20
	var/engineering_skill = 50

	//crit shit
	var/crit_success_chance = CRIT_SUCCESS_NORM
	var/crit_failure_chance = CRIT_FAILURE_NORM
	var/crit_success_modifier = 0
	var/crit_failure_modifier = 0
	var/crit_mood_modifier = 0


/mob/proc/get_success_chance()
	return crit_success_chance + crit_success_modifier + crit_mood_modifier

/mob/proc/get_failure_chance()
	return crit_failure_chance + crit_failure_modifier + crit_mood_modifier




/mob/proc/skillcheck(var/skill, var/requirement, var/show_message, var/message = "I have failed to do this.")//1 - 100
	if(skill >= requirement)//If we already surpass the skill requirements no need to roll.
		if(prob(get_success_chance()))//Only thing we roll for is a crit success.
			return CRIT_SUCCESS
		return 1
	else
		if(prob(skill + src.mood_affect(0, 1)))//Otherwise we roll to see if we pass.
			if(prob(get_success_chance()))//And again to see if we get a crit scucess.
				return CRIT_SUCCESS
			return 1
		else
			if(show_message)//If we don't pass then we return failure
				to_chat(src, "<span class = 'warning'>[message]</span>")
			if(prob(get_failure_chance()))//And roll for a crit failure.
				return CRIT_FAILURE
			return 0

/*
/mob/proc/statscheck(var/stat, var/requirement, var/show_message, var/message = "I have failed to do this.")//Requirement needs to be 1 through 20
	if(stat < requirement)
		var/H = rand(1,20)// our "dice"
		H += mood_affect(1)// our skill modifier
		if(stat >= H)//Rolling that d20
			//world << "Rolled and passed."
			return 1
		else
			if(show_message)//If we fail then print this message and return 0.
				to_chat(src, "<span class = 'warning'>[message]</span>")
			return 0
	else
		//world << "Didn't roll and passed."
		return 1
*/

// I want to test making stats more D&D-esque.  This means every stat check makes a roll, and your (stat - 10 / 2) is added to the role, and checked.
// This could lead to skills being only for advantage/disadvantage (Roll two dice take higher/lower)
// This will need *major* playtesting

// Takes a stat
/mob/proc/statscheck(var/stat, var/requirement, var/message = null, var/type = null)//Requirement needs to be 1 through 20
	var/roll = rand(1,20)// our "dice"
	to_world("Roll: [roll], Mood affect: (-)[mood_affect(1)], Ability modifier [stat_to_modifier(stat)]") //Debuging
	to_world("Rolled a [roll] against a DC [requirement] [type] check")  //debug
	roll -= mood_affect(1)// our mood
	roll += stat_to_modifier(stat) //our stat mod
	if(roll >= requirement)//We met the DC requirement
		//world << "Rolled and passed."
		return 1
	else
		if(message)
			to_chat(src, "<span class = 'warning'>[message]</span>")
		return 0
	return 1

//having a bad mood fucks your shit up fam.
/mob/proc/mood_affect(var/stat, var/skill)
	//Just check this first
	if(!iscarbon(src))
		return 0
	var/mob/living/carbon/C = src
	// We return the mood, based on MOOD_LEVEL_NEUTRAL or whatever
	if(stat)
		return C.happiness * -0.2 /* 1/5th of our happiness This will be SUBTRACTED from the stat roll.  Goes from +4 to -4 */
	if(skill)
		return C.happiness //This will be ADDED to the skill roll.  Goes from +20 - -20  *PENDING REWORK&*
	return 0

proc/strToDamageModifier(var/strength)
	return strength * 0.05  //This is better then division

proc/strToSpeedModifier(var/strength, var/w_class)//Looks messy. Is messy. Is also only used once. But I don't give a fuuuuuuuuck.
	switch(strength)
		if(1 to 5)
			if(w_class > ITEM_SIZE_NORMAL)
				return 20

proc/stat_to_modifier(var/stat)
	return round((stat - 10) * 0.5)

//Stats helpers.

/mob/proc/add_stats(var/stre, var/dexe, var/inti, var/cons)//To make adding stats quicker.
	if(stre)
		stats["str"] = stre
	if(dexe)
		stats["dex"] = dexe
	if(inti)
		stats["int"] = inti
	if(cons)
		stats["con"] = cons

//Different way of generating stats.  Takes a "main_stat" argument.
// Totals top 3 D6 for stats.  Then puts the top stat in the "main_stat" and the rest randomly
/mob/proc/generate_stats(var/main_stat)
	var/list/rand_stats = list()
	var/top_stat = 0
	//Roll a new random roll for each stat
	for(var/stat in stats)
		rand_stats += (rand(1,6) + rand(1,6) + rand(1,6))
	rand_stats = insertion_sort_numeric_list_descending(rand_stats)
	top_stat = rand_stats[1]
	rand_stats.Remove(top_stat)
	for(var/stat in stats - main_stat)
		stats[stat] = pick(rand_stats)
		rand_stats.Remove(stats[stat])

/mob/proc/adjustStrength(var/num)
	stats["str"] += num

/mob/proc/adjustDexterity(var/num)
	stats["dex"] += num

/mob/proc/adjustInteligence(var/num)
	stats["int"] += num


/mob/proc/temporary_stat_adjust(var/stat, var/modifier, var/time)
	if(stats[stat] && modifier && time)//In case you somehow call this without using all three vars.
		stats[stat] += modifier
		spawn(time)
			stats[stat] -= modifier



//Skill helpers.
/mob/proc/skillnumtodesc(var/skill)
	switch(skill)
		if(0 to 25)
			return "<small><i>unskilled</i></small>"
		if(25 to 45)
			return "alright"
		if(45 to 60)
			return "skilled"
		if(60 to 80)
			return "professional"
		if(80 to INFINITY)
			return "<b>godlike</b>"

/mob/proc/add_skills(var/melee, var/ranged, var/medical, var/engineering)//To make adding skills quicker.
	if(melee)
		melee_skill = melee
	if(ranged)
		ranged_skill = ranged
	if(medical)
		medical_skill = medical
	if(engineering)
		engineering_skill = engineering

/mob/living/carbon/human/verb/check_skills()//Debug tool for checking skills until I add the icon for it to the HUD.
	set name = "Check Skills"
	set category = "IC"

	var/message = "<big><b>Skills:</b></big>\n"
	message += "I am <b>[skillnumtodesc(melee_skill)]</b> at melee.\n"
	message += "I am <b>[skillnumtodesc(ranged_skill)]</b> with guns.</b></i>\n"
	message += "I am <b>[skillnumtodesc(medical_skill)]</b> with medicine.</b></i>\n"
	message += "I am <b>[skillnumtodesc(engineering_skill)]</b> at engineering.</b></i>\n"

	to_chat(src, message)