
/datum/map/alpha
	name = "Alpha"
	full_name = "Station Alpha"
	path = "alpha"

	lobby_icon = 'maps/alpha/alpha_lobby.dmi'

	station_levels = list(1,2,3)
	admin_levels = list(4)
	contact_levels = list(1,2,3)
	player_levels = list(1,2,3,5)
	accessible_z_levels = list("1"=1,"2"=1,"3"=1,"5"=90) //Percentage of chance to get on this or that Z level as you drift through space.

	allowed_spawns = list("Arrivals Shuttle")

	station_name  = "Space Station Alpha"
	station_short = "Alpha"
	dock_name     = "NAS Crescent"
	boss_name     = "Central Command"
	boss_short    = "Centcomm"
	company_name  = "NanoTrasen"
	company_short = "NT"
	system_name = "somewhere in space"

	map_admin_faxes = list("Colonial Magistrate Authority")

	shuttle_docked_message = "The shuttle has docked."
	shuttle_leaving_dock = "The shuttle has departed from home dock."
	shuttle_called_message = "A scheduled transfer shuttle has been sent."
	shuttle_recall_message = "The shuttle has been recalled"
	emergency_shuttle_docked_message = "The emergency escape shuttle has docked."
	emergency_shuttle_leaving_dock = "The emergency escape shuttle has departed from %dock_name%."
	emergency_shuttle_called_message = "An emergency escape shuttle has been sent."
	emergency_shuttle_recall_message = "The emergency shuttle has been recalled"

	evac_controller_type = /datum/evacuation_controller/shuttle


/datum/map/alpha/perform_map_generation()
	new /datum/random_map/automata/cave_system(null,1,1,1,200, 200) // Create the mining Z-level.
	new /datum/random_map/noise/ore(null,1,1,1,64, 64)
	return 1