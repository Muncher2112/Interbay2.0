
//The main controller of verina.  Will manage a few small subsystems, and manage what they are doing based on crew input
SUBSYSTEM_DEF(verina)
	name = "Verina"
	wait = 300  //30 seconds
	priority = 20
	flags = SS_BACKGROUND
	var/request_type = /obj/item/stack/material/phoron
	var/obj/request_item = null
	var/request_amount = -1
	var/request_time = -1
	var/visible_shrines = list()
	var/list/requestable_items = list(/obj/item/stack/material/phoron)
	var/list/bannable_items = list()
	var/list/rewards = list()

/datum/controller/subsystem/verina/New()
	NEW_SS_GLOBAL(SSverina)
	rewards = typesof(/datum/reward) - /datum/reward

/datum/controller/subsystem/verina/fire()
	if(!rewards)  //I hope this doesn't happen every time
		rewards = typesof(/datum/reward) - /datum/reward
	if(state == SS_RUNNING)
		if(request_item)
			request_time -= 30
			if(request_amount <= 0)
				reward()
				generate_request()
			else if (request_time <= 0)
				punish()
				generate_request()
			else
				to_world("Request for [request_amount] [request_item]s in [round(request_time/60)] minutes")

		if(!request_item) //Only generate if a request isn't set
			generate_request()

/datum/controller/subsystem/verina/Initialize(time = null)
	to_world("Good morning!  Your station's Deo Machina sactioned AI is starting up!  The time is [time]")
	..()

/datum/controller/subsystem/verina/stat_entry(msg)
	..("Verina is here")

/datum/controller/subsystem/verina/Recover()
	to_world("Verina is recovering!")

/datum/controller/subsystem/verina/proc/get_shrine_locations()
	var/shrine_locations = list()
	for(var/obj/machinery/old_god_shrine/S in visible_shrines)
		shrine_locations += get_area(S)
	return shrine_locations

/datum/controller/subsystem/verina/proc/generate_request()
	request_type = pick(requestable_items)
	request_item = new request_type
	request_amount = rand(5,30)
	request_time = rand(180,600)

/datum/controller/subsystem/verina/proc/reward()
	rewards = typesof(/datum/reward) - /datum/reward
	var/datum/reward/reward = pick(rewards)
	reward = new reward
	reward.do_reward()

/*	Rewards get defined individually with thier own special verb
	All reward code should be self contained.  All the actual "reward" function will do is
	pick a reward and run it's verb
*/
/datum/reward/
	var/name = null
	var/value = null //Having these gated by value might be useful at some point, doing it out of 100 right now because I don't know cargo values

/datum/reward/proc/do_reward()
	to_world("You should not be seeing this!")
	
/datum/reward/random_crate
	name = "Random Crate"
	value = 50

/datum/reward/random_crate/do_reward()
	var/datum/supply_order/supply_reward = pick(supply_controller.master_supply_list)
	var/datum/supply_order/O = new /datum/supply_order()
	//I pulled this out of supply stuff, but it should be a seperate function, like god damn
	supply_controller.ordernum++
	O.ordernum = supply_controller.ordernum
	O.object = supply_reward
	O.orderedby = "Verina"
	O.reason = "For completing Verina's request!"
	O.orderedrank = "God"
	O.comment = "#[O.ordernum] Well done servant of Verina." // crates will be labeled with this.
	supply_controller.shoppinglist += O

/datum/controller/subsystem/verina/proc/punish()
	log_debug("Punihsments do nothing")