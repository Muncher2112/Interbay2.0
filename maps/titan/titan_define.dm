
/datum/map/titan
	name = "Titan"
	full_name = "Frontier Underground Citadel Titan"
	path = "titan"

	lobby_icon = 'maps/Titan/titan_lobby.dmi'

	station_levels = list(1,2,3,4,5,6)
	admin_levels = list(7)
	contact_levels = list(1,2,3,4,5,6)
	player_levels = list(1,2,3,4,5,6)
	accessible_z_levels = list("1"=1,"2"=1,"3"=1,"4"=1,"5"=1,"6"=90) //Percentage of chance to get on this or that Z level as you drift through space.

	allowed_spawns = list("Arrivals Shuttle")

	station_name  = "Frontier Citadel Titan"
	station_short = "Titan"
	dock_name     = "Central Railroad Network"
	boss_name     = "Colonial Magistrate Council"
	boss_short    = "Council"
	company_name  = "Colonial Magistrate Authority"
	company_short = "CMA"
	system_name = "Solar System"

	id_hud_icons = 'maps/dreyfus/icons/assignment_hud.dmi'


	map_admin_faxes = list("Colonial Magistrate Authority")

	shuttle_docked_message = "The train has arrived."
	shuttle_leaving_dock = "The train has departed from train statoin."
	shuttle_called_message = "A scheduled train has been sent."
	shuttle_recall_message = "The train has been recalled"
	emergency_shuttle_docked_message = "The emergency train has arrived."
	emergency_shuttle_leaving_dock = "The emergency train has departed from %dock_name%."
	emergency_shuttle_called_message = "An emergency train has been dispatched to %station_name%."
	emergency_shuttle_recall_message = "The emergency train has been recalled"

	evac_controller_type = /datum/evacuation_controller/shuttle

/turf/simulated/floor/asteroid/
	initial_gas = list("oxygen" = MOLES_O2STANDARD, "nitrogen" = MOLES_N2STANDARD)