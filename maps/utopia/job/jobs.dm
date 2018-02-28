/datum/map/utopia
	allowed_jobs = list(
						/datum/job/assistant,
						/datum/job/captain,
						/datum/job/hop,
						/datum/job/doctor,
						/datum/job/chemist,
						/datum/job/officer,
						/datum/job/qm,
						/datum/job/engineer,
						/datum/job/cargo_tech,
						/datum/job/mining,
						/datum/job/chef,
						/datum/job/chaplain,
						/datum/job/janitor,
						/datum/job/Paramedic,
						/datum/job/bartender
						///datum/job/rd,
						///datum/job/scientist,
						)

/datum/job/assistant
	title = "Assistant"
	department = "Civilian"
	department_flag = CIV
	total_positions = -1
	spawn_positions = -1
	supervisors = "absolutely everyone"
	selection_color = "#515151"
	economic_modifier = 1
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	alt_titles = list("Technical Assistant","Medical Intern","Research Assistant","Visitor")
	outfit_type = /decl/hierarchy/outfit/job/assistant

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(6,13), rand(6,13), rand(5,9))
		H.add_skills(rand(20, 60), rand(0,40), rand(0, 50), rand(0, 50))

/datum/job/captain
	title = "Captain"
	department = "Command"
	head_position = 1
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	supervisors = "company officials and Corporate Regulations"
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	economic_modifier = 20
	outfit_type = /decl/hierarchy/outfit/job/captain

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(8,15), rand(8,15), rand(8,15))
		H.add_skills(rand(50, 80), rand(50,80), rand(50, 75), rand(50, 75))

/datum/job/captain/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(src)

/datum/job/hop
	title = "Head of Personnel"
	head_position = 1
	department_flag = COM|CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#2f2f7f"
	req_admin_notify = 1
	minimal_player_age = 14
	economic_modifier = 10
	ideal_character_age = 50
	access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)
	minimal_access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)

	outfit_type = /decl/hierarchy/outfit/job/hop

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(8,13), rand(8,13), rand(8,13))
		H.add_skills(rand(20, 60), rand(20,60), 50, 50)

/datum/job/doctor
	title = "Medical Doctor"
	department = "Medical"
	department_flag = MED
	minimal_player_age = 3
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	economic_modifier = 7
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_virology)
	outfit_type = /decl/hierarchy/outfit/job/medical/doctor

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(5,8), rand(5,8), rand(9,14))
		H.add_skills(rand(20, 60), rand(20,60), 50, 80)

/datum/job/chemist
	title = "Chemist"
	department = "Medical"
	department_flag = MED

	minimal_player_age = 7
	total_positions = 1
	spawn_positions = 1
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	economic_modifier = 5
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics)
	minimal_access = list(access_medical, access_medical_equip, access_chemistry)
	outfit_type = /decl/hierarchy/outfit/job/medical/chemist

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(5,8), rand(5,8), rand(9,14))
		H.add_skills(rand(20, 60), rand(20,60), 50, 80)

/datum/job/officer
	title = "Security Officer"
	department = "Security"
	department_flag = SEC
	total_positions = 3
	spawn_positions = 3
	supervisors = "the head of security"
	selection_color = "#601c1c"
	economic_modifier = 4
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/security/officer

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(9,18), rand(10,15), rand(7,10))
		H.add_skills(rand(50, 80), rand(50,80))

/datum/job/qm
	title = "Quartermaster"
	department = "Supply"
	department_flag = SUP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	economic_modifier = 5
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_player_age = 3
	ideal_character_age = 40
	outfit_type = /decl/hierarchy/outfit/job/cargo/qm

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(5,12), rand(5,11), rand(8,15))

/datum/job/cargo_tech
	title = "Cargo Technician"
	department = "Supply"
	department_flag = SUP
	total_positions = 2
	spawn_positions = 2
	supervisors = "the quartermaster and the head of personnel"
	selection_color = "#515151"
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)
	outfit_type = /decl/hierarchy/outfit/job/cargo/cargo_tech

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(8,14), rand(8,12), rand(5,11))
		H.add_skills(rand(30, 60), rand(30,60))

/datum/job/mining
	title = "Shaft Miner"
	department = "Supply"
	department_flag = SUP
	total_positions = 3
	spawn_positions = 3
	supervisors = "the quartermaster and the head of personnel"
	selection_color = "#515151"
	economic_modifier = 5
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_mining, access_mining_station, access_mailsorting)
	outfit_type = /decl/hierarchy/outfit/job/cargo/mining

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(8,15), rand(8,11), rand(5,10))
		H.add_skills(rand(40, 70), rand(30,60))

/datum/job/chef
	title = "Chef"
	department = "Service"
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_kitchen)
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/service/chef

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,12), rand(6,12), rand(5,11))
		H.add_skills(rand(25, 75), rand(5,40))

/datum/job/chaplain
	title = "Chaplain"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_morgue, access_chapel_office, access_crematorium, access_maint_tunnels)
	minimal_access = list(access_morgue, access_chapel_office, access_crematorium)
	outfit_type = /decl/hierarchy/outfit/job/chaplain

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,10), rand(3,12), rand(8,15))
		H.add_skills(rand(5, 50), rand(5,50))

/datum/job/janitor
	title = "Janitor"
	department = "Service"
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_janitor, access_maint_tunnels, access_engine, access_research, access_sec_doors, access_medical)
	minimal_access = list(access_janitor, access_maint_tunnels, access_engine, access_research, access_sec_doors, access_medical)
	outfit_type = /decl/hierarchy/outfit/job/service/janitor

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,10), rand(8,15), rand(8,12))

/datum/job/Paramedic
	title = "Paramedic"
	department = "Medical"
	department_flag = MED
	total_positions = 1
	spawn_positions = 1
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	economic_modifier = 4
	minimal_player_age = 7
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_eva, access_maint_tunnels, access_external_airlocks, access_psychiatrist)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_eva, access_maint_tunnels, access_external_airlocks)
	outfit_type = /decl/hierarchy/outfit/job/medical/paramedic

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(8,13), rand(8,13), rand(8,15))
		H.add_skills(rand(20, 60), rand(20,60), 50, 80)

/datum/job/bartender
	title = "Bartender"
	department = "Service"
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	minimal_access = list(access_bar, access_kitchen, access_hydroponics)
	outfit_type = /decl/hierarchy/outfit/job/service/bartender

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,12), rand(6,12), rand(5,11))
		H.add_skills(rand(5, 40), rand(25,70))