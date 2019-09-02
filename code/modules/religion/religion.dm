//PUTTING RELIGIOUS RELATED STUFF IN IT'S ON MODULES FOLDER FROM NOW ON. - Matt

//PROCS

/datum/religion
	var/name = "NONE"
	var/favor = 0
	var/followers = list()
	var/territories = list()


/datum/religion/machina
	name = "Deo Machina"
	favor = 0

/datum/religion/old_gods
	name = "Old Gods"
	favor = 0

/datum/religion/narsie
	name = "Narsie"
	favor = 0

//PROCS

/datum/religion/proc/claim_territory(area/territory,var/religion)
	GLOB.all_religions[religion].territories += territory.name

/datum/religion/proc/lose_territory(area/territory,var/religion)
	GLOB.all_religions[religion].territories -= territory.name

/datum/religion/proc/territory_claimed(area/territory, mob/user)
	for (var/name in GLOB.all_religions)
		if(territory.name in GLOB.all_religions[name].territories)
			return name
	return null

/datum/religion/old_gods/proc/can_claim_for_gods(mob/user, atom/target)
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

//PRAYER
var/accepted_prayer //The prayer that all those who are not heretics will have.

proc/generate_random_prayer()//This generates a new one.
	var/prayer = pick("Oh great AI. ", "Oh our Lord Verina. ", "Verina, our Lord and Saviour. ")
	prayer += pick("You bathe us in your glow. ", "You bathe our minds in you omniscient wisdom. ", "You bathe our [pick("outpost","kingdom","cities")] in your wealth. ")
	prayer += pick("Verina be praised. ", "Verina save us all. ", "Verina guide us all. ")
	prayer += "Amen."
	return prayer

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
	
/mob/living/proc/recite_prayer()
	set category = "Deo Machina"
	set name = "Recite the prayer"
	say(mind.prayer)

/obj/item/weapon/pen/crayon/chalk
	name = "consecrated chalk"
	icon = 'icons/effects/religion.dmi'
	desc = "Heretical chalk used by Old God worshipers."
	icon_state = "chalk"
	colour = "#FFFFF"
	shadeColour = "#454545"
	colourName = "grey"

/mob/proc/make_old_god_rune(var/rune)
	var/turf/T = get_turf(src)
	//You need you chalk to draw runes
	if(!istype(get_active_hand(), /obj/item/weapon/pen/crayon/chalk) && !istype(get_inactive_hand(), /obj/item/weapon/pen/crayon/chalk))
		to_chat(src, "<span class='warning'>You can't draw old god runes without your blessed chalk!</span>")
		return
	var/self = "You quickly draw out the rune in your consecrated chalk."
	var/timer = 20
	//TODO: Make this a check tied to INT?
	visible_message("<span class='warning'>\The [src] quickly draws on the floor and begins to whisper quietly to themselves.</span>", "<span class='notice'>[self]</span>", "You hear scratching.")
	if(do_after(src, timer))
		if(locate(/obj/effect/rune) in T)
			return
		//These variables used to just be functions that returned a hard coded value.  So don't blame me, this is actually faster.
		var/obj/effect/rune/R = new rune(T, "#FFFFFF", "Chalk")
		var/area/A = get_area(R)
		log_and_message_admins("created \an [R.cultname] rune at \the [A.name] - [loc.x]-[loc.y]-[loc.z].")
		R.add_fingerprint(src)
		return 1
	return 0