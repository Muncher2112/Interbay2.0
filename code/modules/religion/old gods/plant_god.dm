/datum/religion/plant_god
	name = "Fedhas Madash"
	holy_item = new /obj/item/weapon/reagent_containers/food/snacks/grown/ambrosiadeus()
	shrine = /obj/machinery/old_god_shrine/plant_god_shrine
	favor = 0
	var/datum/seed/seed

//Needed for setting up vine ssed
/datum/religion/plant_god/New()
	..()
	seed = new()
	seed.set_trait(TRAIT_PLANT_ICON,"flower")
	seed.set_trait(TRAIT_PRODUCT_ICON,"flower2")
	seed.set_trait(TRAIT_PRODUCT_COLOUR,"#4d4dff")
	seed.set_trait(TRAIT_SPREAD,2)
	seed.name = "heirlooms"
	seed.seed_name = "heirloom"
	seed.display_name = "vines"
	seed.chems = list(/datum/reagent/nutriment = list(1,20))

/datum/religion/plant_god/add_spells(mob/target)
	target.verbs += /mob/living/proc/grasping_vines
	target.verbs += /mob/living/proc/cultivate_plant

/obj/machinery/old_god_shrine/plant_god_shrine
	name = "Fedhas Madash shrine"
	icon_state = "plant_god"

/obj/machinery/old_god_shrine/plant_god_shrine/New(l,d=0)
	to_world("Does nothing right now")

/obj/machinery/old_god_shrine/plant_god_shrine/Process()
	STOP_PROCESSING(SSmachines, src)  //This doesn't need any processing right now

/obj/machinery/old_god_shrine/plant_god_shrine/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/reagent_containers/food/snacks/grown))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/P = I
		GLOB.all_religions[PLANTGOD].favor += P.potency
		qdel(P)
	else 
		to_chat(user,"Fedhas Madash has no interest in this.")

/mob/living/proc/cultivate_plant()
	set category = "Old God Magic"
	set name = "Cultivate plant"
	var/plants = list()
	var/datum/religion/user_religion = GLOB.all_religions[religion]
	if(!istype(get_active_hand(), user_religion.holy_item) && !istype(get_inactive_hand(), user_religion.holy_item))
		to_chat(src, "<span class='warning'>You can't use this without your [user_religion.holy_item]!</span>")
		return
	if(GLOB.all_religions[PLANTGOD].favor < 25)
		to_chat(src, "<span class='notice'>Fedhas Madash expects more devotion from you first.</span>")
		return FALSE
	user_religion.favor -= 25
	for(var/obj/machinery/portable_atmospherics/hydroponics/P in oview(1))
		if(P.seed)
			plants += P
	var/obj/machinery/portable_atmospherics/hydroponics/T = input(src, "What plant to cultivate?") as null|anything in plants
	T.health += 5
	T.nutrilevel += 5
	T.seed.set_trait(TRAIT_POTENCY, T.seed.get_trait(TRAIT_POTENCY) + 1)

/mob/living/proc/grasping_vines()
	set category = "Old God Magic"
	set name = "Grasping Vines"
	var/turf/T = get_turf(src)
	var/datum/religion/user_religion = GLOB.all_religions[religion]
	//You need your god's item to do this
	if(!istype(get_active_hand(), user_religion.holy_item) && !istype(get_inactive_hand(), user_religion.holy_item))
		to_chat(src, "<span class='warning'>You can't use this without your [user_religion.holy_item]!</span>")
		return
	if(GLOB.all_religions[PLANTGOD].favor < 100)
		to_chat(src, "<span class='notice'>Fedhas Madash expects more devotion from you first.</span>")
		return FALSE
	if(!doing_something)
		doing_something = 1
		user_religion.favor -= 100
		var/timer = 10
		var/self = "You raise your [user_religion.holy_item] and chant!."
		visible_message("<span class='warning'>\The [src] begins chanting as vines begin growing from the floor!!</span>", "<span class='notice'>[self]</span>", "You hear a low hum.")
		if(do_after(src, timer))
			doing_something = 0
			playsound(T, "sound/items/herb_drop.ogg",100,1)
			for(var/mob/living/carbon/M in oviewers(5, null))
				T = get_turf(M)
				if(M.religion != PLANTGOD)
					var/obj/effect/vine/single/P = new(T,GLOB.all_religions[PLANTGOD].seed, start_matured =1)
					P.can_buckle = 1
					P.buckle_mob(M)
					M.set_dir(pick(GLOB.cardinal))
					M.visible_message("<span class='danger'>[P] appear from the floor, spinning around \the [M] tightly!</span>")
		else 
			doing_something = 0
	return 0