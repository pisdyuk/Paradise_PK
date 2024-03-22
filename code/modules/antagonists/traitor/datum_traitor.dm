#define EXCHANGE_OBJECTIVE_TRAITORS_REQUIRED	8

// For "Actual traitors"
/datum/antagonist/traitor
	name = "Traitor"
	roundend_category = "traitors"
	job_rank = ROLE_TRAITOR
	special_role = SPECIAL_ROLE_TRAITOR
	antag_hud_name = "hudsyndicate"
	antag_hud_type = ANTAG_HUD_TRAITOR
	wiki_page_name = "Traitor"
	russian_wiki_name = "Предатель"
	clown_gain_text = "Your training has allowed you to overcome your clownish nature, allowing you to wield weapons without harming yourself."
	clown_removal_text = "You lose your syndicate training and return to your own clumsy, clownish self."
	/// Should the traitor get codewords?
	var/give_codewords = TRUE
	/// Whether the traitor should get his uplink.
	var/give_uplink = TRUE
	/// Whether the traitor can specialize into a contractor.
	var/is_contractor = FALSE
	/// Whether the traitor will receive only hijack objective.
	var/is_hijacker = FALSE
	/// The associated traitor's uplink. Only present if `give_uplink` is set to `TRUE`.
	var/obj/item/uplink/hidden/hidden_uplink = null


/datum/antagonist/traitor/on_gain()
	// Create this in case the traitor wants to mindslaves someone.
	if(!owner.som)
		owner.som = new /datum/mindslaves

	owner.som.masters += owner
	return ..()


/datum/antagonist/traitor/Destroy(force, ...)
	// Remove contractor if present
	var/datum/antagonist/contractor/contractor_datum = owner?.has_antag_datum(/datum/antagonist/contractor)
	if(contractor_datum)
		contractor_datum.silent = TRUE
		owner.remove_antag_datum(contractor_datum)

	// Leave the mindslave hud.
	if(owner.som)
		var/datum/mindslaves/slaved = owner.som
		slaved.masters -= owner
		slaved.serv -= owner
		slaved.leave_serv_hud(owner)
		owner.som = null

	owner.current.client?.chatOutput?.clear_syndicate_codes()

	if(hidden_uplink)
		var/obj/item/uplink_holder = hidden_uplink.loc
		if(!QDELETED(uplink_holder))
			uplink_holder.hidden_uplink = null

		QDEL_NULL(hidden_uplink)

		for(var/obj/item/implant/uplink/uplink_implant in owner.current.contents)
			if(QDELETED(uplink_implant))
				continue

			qdel(uplink_implant)

	return ..()


/datum/antagonist/traitor/add_owner_to_gamemode()
	SSticker.mode.traitors |= owner


/datum/antagonist/traitor/remove_owner_from_gamemode()
	SSticker.mode.traitors -= owner


/datum/antagonist/traitor/add_antag_hud(mob/living/antag_mob)
	if(locate(/datum/objective/hijack) in owner.get_all_objectives())
		antag_hud_name = "hudhijack"
	else
		antag_hud_name = "hudsyndicate"
	return ..()


/datum/antagonist/traitor/give_objectives()

	// delete these start

	var/hijacker_antag = (GLOB.master_mode == "antag-paradise" || GLOB.secret_force_mode == "antag-paradise") ? is_hijacker : prob(10)

	// delete these end


	var/objective_count = hijacker_antag 			//Hijacking counts towards number of objectives
	if(!SSticker.mode.exchange_blue && SSticker.mode.traitors.len >= EXCHANGE_OBJECTIVE_TRAITORS_REQUIRED) 	//Set up an exchange if there are enough traitors
		if(!SSticker.mode.exchange_red)
			SSticker.mode.exchange_red = owner
		else
			SSticker.mode.exchange_blue = owner
			assign_exchange_role(SSticker.mode.exchange_red)
			assign_exchange_role(SSticker.mode.exchange_blue)
		objective_count += 1					//Exchange counts towards number of objectives

	var/objective_amount = CONFIG_GET(number/traitor_objectives_amount)

	if(hijacker_antag && objective_count <= objective_amount) //Don't assign hijack if it would exceed the number of objectives set in CONFIG_GET(number/traitor_objectives_amount)
		if(!(locate(/datum/objective/hijack) in owner.get_all_objectives()))
			add_objective(/datum/objective/hijack)
			return

	for(var/i = objective_count, i < objective_amount)
		forge_single_human_objective()
		i += 1

	var/martyr_compatibility = TRUE //You can't succeed in stealing if you're dead.
	for(var/datum/objective/O in owner.get_all_objectives())
		if(!O.martyr_compatible)
			martyr_compatibility = FALSE
			break

	if(martyr_compatibility && prob(20))
		if(!(locate(/datum/objective/die) in owner.get_all_objectives()))
			add_objective(/datum/objective/die)
			return

	// Give them an escape objective if they don't have one already.
	var/all_objectives = owner.get_all_objectives()
	if(!(locate(/datum/objective/escape) in all_objectives) && !(locate(/datum/objective/survive) in all_objectives))
		add_objective(/datum/objective/escape)


/**
 * Assigning exchange role.
 */
/datum/antagonist/traitor/proc/assign_exchange_role(datum/mind/exchange_role)
	//set faction
	var/faction = "red"
	if(exchange_role == SSticker.mode.exchange_blue)
		faction = "blue"

	//Assign objectives
	var/datum/objective/steal/exchange/exchange_objective = new
	exchange_objective.set_faction(faction, ((faction == "red") ? SSticker.mode.exchange_blue : SSticker.mode.exchange_red))
	exchange_objective.owner = owner
	objectives += exchange_objective

	if(prob(20))
		var/datum/objective/steal/exchange/backstab/backstab_objective = new
		backstab_objective.set_faction(faction)
		backstab_objective.owner = owner
		objectives += backstab_objective

	//Spawn and equip documents
	var/mob/living/carbon/human/mob = owner.current

	var/obj/item/folder/syndicate/folder
	if(exchange_role == SSticker.mode.exchange_red)
		folder = new/obj/item/folder/syndicate/red(mob.locs)
	else
		folder = new/obj/item/folder/syndicate/blue(mob.locs)

	var/list/slots = list (
		"backpack" = slot_in_backpack,
		"left pocket" = slot_l_store,
		"right pocket" = slot_r_store,
		"left hand" = slot_l_hand,
		"right hand" = slot_r_hand,
	)

	var/where = "At your feet"
	var/equipped_slot = mob.equip_in_one_of_slots(folder, slots, qdel_on_fail = TRUE)
	if(equipped_slot)
		where = "In your [equipped_slot]"
	to_chat(mob, "<BR><BR><span class='info'>[where] is a folder containing <b>secret documents</b> that another Syndicate group wants. We have set up a meeting with one of their agents on station to make an exchange. Exercise extreme caution as they cannot be trusted and may be hostile.</span><BR>")
	mob.update_icons()


/**
 * Create and assign a single randomized traitor objective.
 */
/datum/antagonist/traitor/proc/forge_single_human_objective()
	if(prob(50))
		if(length(active_ais()) && prob(100 / length(GLOB.player_list)))
			add_objective(/datum/objective/destroy)

		else if(prob(5))
			add_objective(/datum/objective/debrain)

		else if(prob(30))
			add_objective(/datum/objective/pain_hunter)

		else if(prob(20))
			add_objective(/datum/objective/protect)

		else
			add_objective(/datum/objective/maroon)

	else
		add_objective(/datum/objective/steal)


/**
 * Give traitors their uplink. Play the traitor an alert sound.
 */
/datum/antagonist/traitor/finalize_antag()
	var/list/messages = list()
	if(give_codewords)
		messages.Add(give_codewords())

	if(give_uplink)
		give_uplink()

	announce_uplink_info()

	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/tatoralert.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

	if(is_contractor)
		addtimer(CALLBACK(owner, TYPE_PROC_REF(/datum/mind, add_antag_datum), /datum/antagonist/contractor), 1)

	return messages

/**
 * Notify the traitor of their codewords and write them to `antag_memory` (notes).
 */
/datum/antagonist/traitor/proc/give_codewords()
	if(!owner.current)
		return

	var/mob/traitor_mob = owner.current

	var/phrases = jointext(GLOB.syndicate_code_phrase, ", ")
	var/responses = jointext(GLOB.syndicate_code_response, ", ")

	antag_memory += "<b>Code Phrase</b>: <span class='red'>[phrases]</span><br>"
	antag_memory += "<b>Code Response</b>: <span class='red'>[responses]</span><br>"
	traitor_mob.client.chatOutput?.notify_syndicate_codes()

	var/list/messages = list()
	if(!silent)
		messages.Add("<U><B>The Syndicate have provided you with the following codewords to identify fellow agents:</B></U>")
		messages.Add("<span class='bold body'>Code Phrase: <span class='codephrases'>[phrases]</span></span>")
		messages.Add("<span class='bold body'>Code Response: <span class='coderesponses'>[responses]</span></span>")
		messages.Add("Use the codewords during regular conversation to identify other agents. Proceed with caution, however, as everyone is a potential foe.")
		messages.Add("<b><font color=red>You memorize the codewords, allowing you to recognize them when heard.</font></b>")

	return messages

/**
 * Gives a traitor their uplink, and uplink code.
 */
/datum/antagonist/traitor/proc/give_uplink()
	if(isAI(owner.current))
		return FALSE

	var/mob/living/carbon/human/traitor_mob = owner.current
	var/uplink_pref = traitor_mob.client?.prefs?.uplink_pref
	if(!uplink_pref)
		uplink_pref = "pda"

	var/obj/item/uplink_holder = null
	// find a radio! toolbox(es), backpack, belt, headset
	if(uplink_pref == "pda")
		uplink_holder = locate(/obj/item/pda) in traitor_mob.contents //Hide the uplink in a PDA if available, otherwise radio
		if(!uplink_holder)
			uplink_holder = locate(/obj/item/radio) in traitor_mob.contents
	else
		uplink_holder = locate(/obj/item/radio) in traitor_mob.contents //Hide the uplink in a radio if available, otherwise PDA
		if(!uplink_holder)
			uplink_holder = locate(/obj/item/pda) in traitor_mob.contents

	if(!uplink_holder)
		return FALSE

	if(isradio(uplink_holder))
		// generate list of radio freqs
		var/obj/item/radio/target_radio = uplink_holder
		var/freq = PUBLIC_LOW_FREQ
		var/list/freqlist = list()
		while(freq <= PUBLIC_HIGH_FREQ)
			if(freq < 1451 || freq > 1459)
				freqlist += freq
			freq += 2
			if((freq % 2) == 0)
				freq += 1
		freq = freqlist[rand(1, freqlist.len)]

		var/obj/item/uplink/hidden/new_uplink = new(target_radio)
		hidden_uplink = new_uplink
		target_radio.hidden_uplink = new_uplink
		new_uplink.uplink_owner = "[traitor_mob.key]"
		target_radio.traitor_frequency = freq
		antag_memory += ("<B>Radio Freq:</B> [format_frequency(freq)] ([target_radio.name]).")
		return TRUE

	if(ispda(uplink_holder))
		// generate a passcode if the uplink is hidden in a PDA
		var/obj/item/pda/target_pda = uplink_holder
		var/obj/item/uplink/hidden/new_uplink = new(target_pda)
		hidden_uplink = new_uplink
		target_pda.hidden_uplink = new_uplink
		new_uplink.uplink_owner = "[traitor_mob.key]"

		target_pda.lock_code = "[rand(100,999)] [pick("Alpha","Bravo","Delta","Omega")]"

		antag_memory += ("<B>Uplink Passcode:</B> [target_pda.lock_code] ([uplink_holder.name].")
		return TRUE

	return FALSE


/datum/antagonist/traitor/roundend_report_footer()
	var/phrases = jointext(GLOB.syndicate_code_phrase, ", ")
	var/responses = jointext(GLOB.syndicate_code_response, ", ")

	var/message = "<br><b>The code phrases were:</b> <span class='bluetext'>[phrases]</span><br>\
					<b>The code responses were:</b> <span class='redtext'>[responses]</span><br>"

	return message


/datum/antagonist/traitor/proc/announce_uplink_info()

	if(!hidden_uplink)
		return

	var/obj/item/uplink_holder = hidden_uplink.loc

	if(ispda(uplink_holder))
		var/obj/item/pda/pda_uplink = uplink_holder
		to_chat(owner.current, "The Syndicate have cunningly disguised a Syndicate Uplink as your [uplink_holder.name]. Simply enter the code \"[pda_uplink.lock_code]\" into the ringtone select to unlock its hidden features.")

	else if(isradio(uplink_holder))
		var/obj/item/radio/radio_uplink = uplink_holder
		to_chat(owner.current, "The Syndicate have cunningly disguised a Syndicate Uplink as your [uplink_holder.name]. Simply dial the frequency [format_frequency(radio_uplink.traitor_frequency)] to unlock its hidden features.")

	else
		to_chat(owner.current, span_warning("Unfortunately, the Syndicate wasn't able to get you a radio."))


#undef EXCHANGE_OBJECTIVE_TRAITORS_REQUIRED
