//PUTTING RELIGIOUS RELATED STUFF IN IT'S ON MODULES FOLDER FROM NOW ON. - Matt

//PROCS

/datum/religion
	var/name = "NONE"
	var/favor = 0
	var/holy_item = null
	var/shrine = null
	var/religion_verbs = list()
	var/followers = list()
	var/territories = list()


/datum/religion/machina
	name = "Deo Machina"
	holy_item = /obj/item/weapon/brander
	favor = 0

/datum/religion/old_gods
	name = "Old Gods"
	favor = 0

/*
/datum/religion/narsie
	name = "Narsie"
	holy_item = /obj/item/weapon/book/tome
	favor = 0
*/

/* GENERAL RELIGION PROCS */

//Stupidly simplistic? Probably. But I'm too tired to write something more complex.
/mob/living/proc/religion_is_legal()
	if(religion != LEGAL_RELIGION)
		return 0
	return 1

//Reveals self as a heretic
/mob/living/proc/reveal_self()
	var/msg = ""
	if (religion_is_legal())  //Non-heretics will still deny
		msg = "I'm not one I swear it!"
	else 
		msg = "Yes!  I'm a heretic!"
	agony_scream()
	say(NewStutter(msg))

/* LEGAL RELIIGON PROCS */
//PRAYER
var/accepted_prayer //The prayer that all those who are not heretics will have.

proc/generate_random_prayer()//This generates a new one.
	var/prayer = pick("Oh great AI. ", "Oh our Lord Verina. ", "Verina, our Lord and Saviour. ")
	prayer += pick("You bathe us in your glow. ", "You bathe our minds in you omniscient wisdom. ", "You bathe our [pick("outpost","kingdom","cities")] in your wealth. ")
	prayer += pick("Verina be praised. ", "Verina save us all. ", "Verina guide us all. ")
	prayer += "Amen."
	return prayer

/mob/living/proc/recite_prayer()
	set category = "Deo Machina"
	set name = "Recite the prayer"
	say(mind.prayer)

//Reveals a random heretic
/mob/living/proc/reveal_heretics()
	to_world("In reveal heretics")
	var/msg = " is one of them!"
	var/name = ""
	if (religion_is_legal())  //Non-heretics will say nothing
		msg = "I dont know!"
		say(NewStutter(msg))
		return
	else
		name = pick(GLOB.all_religions[ILLEGAL_RELIGION].followers)  //Wow the datums saves us an entire for loop
		if(name)
			say(NewStutter("[name] is one of them!"))
		else 
			say("I'm the only one!")

/mob/living/proc/accuse_heretic()
	set category = "Deo Machina"
	set name = "Accuse Heretic"
	var/list/victims = list()
	for(var/mob/living/carbon/human/C in oview(1))
		victims += C
	var/mob/living/carbon/human/T = input(src, "Who will we accuse?") as null|anything in victims
	if(!T)
		return
	say("[T] are you a heretic!?")
	var/organ_pain = 0
	for(var/obj/item/organ/external/org in T.organs)
		organ_pain += org.get_pain() + org.get_damage()
	if(prob(organ_pain - T.stats["con"]))  //Higher con helps your resist torture
		T.reveal_self()

/mob/living/proc/question_heretic()
	set category = "Deo Machina"
	set name = "Question Heretic"
	var/list/victims = list()
	for(var/mob/living/carbon/human/C in oview(1))
		victims += C
	var/mob/living/carbon/human/T = input(src, "Who will we question?") as null|anything in victims
	if(!T)
		return
	say("[T], who is working in your cult!")
	var/organ_pain = 0
	for(var/obj/item/organ/external/org in T.organs)
		organ_pain += org.get_pain() + org.get_damage()
	if(prob(organ_pain - T.stats["con"]))  //Higher con helps your resist torture
		T.reveal_heretics()

/* ILLEGAL RELIGION PROCS */
/datum/religion/proc/claim_territory(area/territory,var/religion)
	GLOB.all_religions[religion].territories += territory.name

/datum/religion/proc/lose_territory(area/territory,var/religion)
	GLOB.all_religions[religion].territories -= territory.name

/datum/religion/proc/territory_claimed(area/territory, mob/user)
	for (var/name in GLOB.all_religions)
		if(territory.name in GLOB.all_religions[name].territories)
			return name
	return null

/datum/religion/proc/can_claim_for_gods(mob/user, atom/target)
	//Check the area for if there's another shrine already, or the arbiters have already claimed it with TODO:?????
	var/area/A = get_area(target)
	if(!A)
		to_chat(user, "<span class='warning'>The old god's refuse your petty offering</span>")
		return FALSE

	var/occupying_religion = territory_claimed(A, user)
	if(occupying_religion == ILLEGAL_RELIGION)
		to_chat(user,"<span class='danger'>There is already a shrine in this area!</span>")
		return FALSE

	if(occupying_religion)
		to_chat(user, "<span class='danger'>Something in the area is blocking your connection to the Old Gods!  FInd it and destory it!</span>")
		return FALSE

	// If you pass the gaunlet of checks, you're good to proceed
	return TRUE

/mob/living/proc/praise_god()
	set category = "Old God Magic"
	set name = "Praise god"
	var/turf/T = get_turf(src)
	var/datum/religion/user_religion = GLOB.all_religions[religion]
	//You need your god's item to do this
	if(!istype(get_active_hand(), user_religion.holy_item) && !istype(get_inactive_hand(), user_religion.holy_item))
		to_chat(src, "<span class='warning'>You can't praise god without your [user_religion.holy_item]!</span>")
		return
	var/timer = 20
	var/self = "You raise your [user_religion.holy_item] and chant praise to your god."
	visible_message("<span class='warning'>\The [src] begins speaking praise for thier god.</span>", "<span class='notice'>[self]</span>", "You hear scratching.")
	var/praise_sound = "sound/effects/badmood[pick(1,4)].ogg"
	playsound(T, praise_sound,20,1)
	if(do_after(src, timer))
		//These variables used to just be functions that returned a hard coded value.  So don't blame me, this is actually faster.
		user_religion.favor += 10
		return 1
	return 0


/mob/living/proc/make_shrine()
	set category = "Old God Magic"
	set name = "Create shrine"
	var/turf/T = get_turf(src)
	var/datum/religion/user_religion = GLOB.all_religions[religion]
	//You need your god's item to do this
	if(!istype(get_active_hand(), user_religion.holy_item) && !istype(get_inactive_hand(), user_religion.holy_item))
		to_chat(src, "<span class='warning'>You can't draw old god runes without your [user_religion.holy_item]!</span>")
		return
	var/self = "You deftly use your [user_religion.holy_item] to create the shrine."
	var/timer = 20
	visible_message("<span class='warning'>\The [src] quickly draws on the floor and begins to whisper quietly to themselves.</span>", "<span class='notice'>[self]</span>", "You hear scratching.")
	if(do_after(src, timer))
		//These variables used to just be functions that returned a hard coded value.  So don't blame me, this is actually faster.
		var/obj/machinery/old_god_shrine/S = new user_religion.shrine(T)
		var/area/A = get_area(S)
		log_and_message_admins("created \an [S.name] rune at \the [A.name] - [loc.x]-[loc.y]-[loc.z].")
		S.add_fingerprint(src)
		return 1
	return 0

