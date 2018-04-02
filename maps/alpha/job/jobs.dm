/datum/map/alpha
	allowed_jobs = list(
						/datum/job/assistant,
						/datum/job/hydro,
						/datum/job/bartender,
						/datum/job/captain,
						/datum/job/cargo_tech,
						/datum/job/chemist,
						/datum/job/chef,
						/datum/job/chaplain,
						/datum/job/chief_engineer,
						/datum/job/detective,
						/datum/job/engineer,
						/datum/job/hop,
						/datum/job/hos,
						/datum/job/janitor,
						/datum/job/librarian,
						/datum/job/doctor,
						/datum/job/Paramedic,
						/datum/job/qm,
						/datum/job/roboticist,
						/datum/job/officer,
						/datum/job/mining,
						/datum/job/scientist,
						/datum/job/warden,
						/datum/job/xenobiologist
						///datum/job/rd,
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

/datum/job/hydro
	title = "Botanic"
	department = "Service"
	department_flag = SRV
	total_positions = 2
	spawn_positions = 2
	supervisors = "the head of personnel"
	selection_color = "#515151"
	minimal_access = list(access_hydroponics)
	alt_titles = list("Hydroponicist")
	outfit_type = /decl/hierarchy/outfit/job/service/gardener

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(6,11), rand(6,15), rand(5,11))
		H.add_skills(rand(20, 60), rand(0,40), rand(0, 50), rand(0, 50))

/datum/job/bartender
	title = "Bartender"
	department = "Service"
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	minimal_access = list(access_bar)
	outfit_type = /decl/hierarchy/outfit/job/service/bartender

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,12), rand(6,12), rand(5,11))
		H.add_skills(rand(5, 40), rand(25,70))

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

/datum/job/chief_engineer
	title = "Chief Engineer"
	head_position = 1
	department = "Engineering"
	department_flag = ENG|COM
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#7f6e2c"
	req_admin_notify = 1
	economic_modifier = 10
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload)
	outfit_type = /decl/hierarchy/outfit/job/engineering/chief_engineer

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10,15), rand(5,11), rand(9,15))
		H.add_skills(rand(20, 60), rand(20,60), 30, rand(50,100))

/datum/job/detective
	title = "Detective"
	department = "Security"
	department_flag = SEC

	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security"
	selection_color = "#601c1c"
	alt_titles = list("Forensic Technician" = /decl/hierarchy/outfit/job/security/detective/forensic)
	economic_modifier = 5
	minimal_access = list(access_brig, access_security, access_sec_doors, access_forensics_lockers, access_morgue, access_maint_tunnels)
	outfit_type = /decl/hierarchy/outfit/job/security/detective

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(6,14), rand(10,18), rand(7,13))
		H.add_skills(rand(20, 60), rand(50,80), rand(20,60))

/datum/job/engineer
	title = "Engineer"
	department = "Engineering"
	department_flag = ENG

	total_positions = 8
	spawn_positions = 7
	supervisors = "the chief engineer"
	selection_color = "#5b4d20"
	economic_modifier = 5
	minimal_player_age = 7
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	minimal_access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	alt_titles = list("Maintenance Technician","Engine Technician","Electrician",
		"Atmospheric Technician" = /decl/hierarchy/outfit/job/engineering/atmos)
	outfit_type = /decl/hierarchy/outfit/job/engineering/engineer

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(8,15), rand(5,11), rand(7,14))
		H.add_skills(rand(20, 60), rand(20,60), 20, rand(40,75))

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

/datum/job/hos
	title = "Head of Security"
	head_position = 1
	department = "Security"
	department_flag = SEC|COM
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#8e2929"
	req_admin_notify = 1
	economic_modifier = 10
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	outfit_type = /decl/hierarchy/outfit/job/security/hos

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10,20), rand(12,18), rand(10,15))
		H.add_skills(rand(40, 100), rand(40,100))

/datum/job/hos/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(H)

/datum/job/janitor
	title = "Janitor"
	department = "Service"
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_janitor, access_maint_tunnels, access_engine, access_research, access_sec_doors, access_medical)
	minimal_access = list(access_janitor, access_maint_tunnels)
	outfit_type = /decl/hierarchy/outfit/job/service/janitor

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,10), rand(8,15), rand(8,12))

/datum/job/librarian
	title = "Librarian"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_library, access_maint_tunnels)
	minimal_access = list(access_library)
	alt_titles = list("Journalist")
	outfit_type = /decl/hierarchy/outfit/job/librarian

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(2,10), rand(8,15), rand(10,18))

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
		H.add_skills(rand(0, 60), rand(0,60), 50, 80)

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
		H.add_stats(rand(6,13), rand(8,15), rand(8,15))
		H.add_skills(rand(0, 60), rand(0,60), 80, 50)

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

/datum/job/roboticist
	title = "Roboticist"
	department = "Science"
	department_flag = SCI
	total_positions = 1
	spawn_positions = 1
	supervisors = "research director"
	selection_color = "#633d63"
	economic_modifier = 5
	minimal_access = list(access_robotics, access_tech_storage, access_morgue, access_research)
	minimal_player_age = 3
	outfit_type = /decl/hierarchy/outfit/job/science/roboticist

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(6,14), rand(5,8), rand(9,16))
		H.add_skills(rand(10, 60), rand(0,40), 50, 70)

/datum/job/officer
	title = "Security Officer"
	department = "Security"
	department_flag = SEC
	total_positions = 4
	spawn_positions = 4
	supervisors = "the head of security"
	selection_color = "#601c1c"
	economic_modifier = 4
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/security/officer

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(9,16), rand(10,15), rand(7,10))
		H.add_skills(rand(40, 70), rand(30,70))

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

/datum/job/scientist
	title = "Scientist"
	department = "Science"
	department_flag = SCI
	total_positions = 2
	spawn_positions = 2
	supervisors = "the research director"
	selection_color = "#633d63"
	economic_modifier = 7
	minimal_access = list(access_tox, access_tox_storage, access_research, access_xenoarch)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/science/scientist

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(5,8), rand(5,8), rand(9,14))
		H.add_skills(rand(0, 40), rand(0,40), rand(30,80), rand(30,80))

/datum/job/warden
	title = "Warden"
	department = "Security"
	department_flag = SEC

	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security"
	selection_color = "#601c1c"
	economic_modifier = 5
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/security/warden

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,15), rand(8,14), rand(8,12))
		H.add_skills(rand(20,60), rand(50,90))

/datum/job/xenobiologist
	title = "Xenobiologist"
	department = "Science"
	department_flag = SCI

	total_positions = 3
	spawn_positions = 2
	supervisors = "the research director"
	selection_color = "#633d63"
	economic_modifier = 7
	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology, access_hydroponics)
	minimal_access = list(access_research, access_xenobiology, access_hydroponics)
	alt_titles = list("Xenobotanist")
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/science/xenobiologist

	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(5,8), rand(5,8), rand(9,14))
		H.add_skills(rand(0, 40), rand(0,40), rand(30,80), rand(30,80))




