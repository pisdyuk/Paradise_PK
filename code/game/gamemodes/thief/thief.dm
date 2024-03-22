/datum/game_mode
	var/list/datum/mind/thieves = list()


/datum/game_mode/thief
	name = "thief"
	config_tag = "thief"
	restricted_jobs = list("AI", "Cyborg")
	protected_jobs = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Blueshield", "Nanotrasen Representative", "Security Pod Pilot", "Magistrate", "Brig Physician", "Internal Affairs Agent", "Nanotrasen Navy Officer", "Nanotrasen Navy Field Officer", "Special Operations Officer", "Supreme Commander", "Syndicate Officer")
	required_players = 0
	required_enemies = 1
	recommended_enemies = 3
	/// List of minds of soon to be thieves
	var/list/datum/mind/pre_thieves = list()


/datum/game_mode/thief/announce()
	to_chat(world, "<B>The current game mode is - thief!</B>")
	to_chat(world, "<B>На станции зафиксирована деятельность гильдии воров. Не допустите кражу дорогостоящего оборудования!</B>")


/datum/game_mode/thief/pre_setup()

	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		restricted_jobs += protected_jobs

	var/list/datum/mind/possible_thieves = get_players_for_role(ROLE_THIEF, list(SPECIES_VOX = 4))

	var/thieves_scale = 15
	if(CONFIG_GET(number/traitor_scaling))
		thieves_scale = CONFIG_GET(number/traitor_scaling)
	var/thieves_amount = 1 + round(num_players() / thieves_scale)
	add_game_logs("Number of  thieves chosen: [thieves_amount]")

	if(length(possible_thieves))
		for(var/i in 1 to thieves_amount)
			if(!length(possible_thieves))
				break
			var/datum/mind/thief = pick(possible_thieves)
			listclearduplicates(thief, possible_thieves)
			pre_thieves += thief
			thief.special_role = SPECIAL_ROLE_THIEF
			thief.restricted_roles = restricted_jobs
		..()
		return TRUE
	else
		return FALSE


/datum/game_mode/thief/post_setup()
	for(var/datum/mind/thief in pre_thieves)
		thief.add_antag_datum(/datum/antagonist/thief)
	..()


/datum/game_mode/proc/auto_declare_completion_thief()
	if(!length(thieves))
		return

	var/text = "<FONT size = 2><B>Воры в розыске:</B></FONT><br>"
	for(var/datum/mind/thief in thieves)

		text += printplayer(thief) + "<br>"

		var/list/all_objectives = thief.get_all_objectives()
		if(!length(all_objectives))
			continue

		var/count = 1
		var/thiefwin = TRUE
		for(var/datum/objective/objective in all_objectives)
			if(objective.check_completion())
				text += "<br><B>Цель #[count]</B>: [objective.explanation_text] <font color='green'><B>Выполнена!</B></font>"
				SSblackbox.record_feedback("nested tally", "thief_objective", 1, list("[objective.type]", "SUCCESS"))
			else
				text += "<br><B>Цель #[count]</B>: [objective.explanation_text] <font color='red'>Провалена.</font>"
				SSblackbox.record_feedback("nested tally", "thief_objective", 1, list("[objective.type]", "FAIL"))
				thiefwin = FALSE
			count++

		if(thiefwin)
			text += "<br><font color='green'><B>Вор преуспел!</B></font><br>"
			SSblackbox.record_feedback("tally", "thief_success", 1, "SUCCESS")
		else
			text += "<br><font color='red'><B>Вор провалился.</B></font><br>"
			SSblackbox.record_feedback("tally", "thief_success", 1, "FAIL")

	to_chat(world, text)
	return TRUE

