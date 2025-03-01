/client
		//////////////////////
		//BLACK MAGIC THINGS//
		//////////////////////
	parent_type = /datum
		////////////////
		//ADMIN THINGS//
		////////////////
	var/datum/admins/holder = null

	var/last_message	= "" //contains the last message sent by this client - used to protect against copy-paste spamming.
	var/last_message_count = 0 //contains a number of how many times a message identical to last_message was sent.
	var/last_message_time = 0 //holds the last time (based on world.time) a message was sent
	var/datum/pm_tracker/pm_tracker = new()

		/////////
		//OTHER//
		/////////
	var/datum/preferences/prefs = null
	var/move_delay		= 1
	var/current_move_delay = 0
	var/moving			= null
	var/area			= null
	var/time_joined_as_mouse = null //when the client last spawned as a mouse

	var/typing = FALSE // Prevents typing window stacking

	var/adminhelped = 0

		///////////////
		//SOUND STUFF//
		///////////////
	var/ambience_playing = FALSE

		////////////
		//SECURITY//
		////////////

	///Used for limiting the rate of topic sends by the client to avoid abuse
	var/list/topiclimiter

	// comment out the line below when debugging locally to enable the options & messages menu
	control_freak = CONTROL_FREAK_ALL

	var/ssd_warning_acknowledged = FALSE

		////////////////////////////////////
		//things that require the database//
		////////////////////////////////////
	var/player_age = "--"	//So admins know why it isn't working - Used to determine how old the account is - in days.
	var/list/related_accounts_ip = list()	//So admins know why it isn't working - Used to determine what other accounts previously logged in from this ip
	var/list/related_accounts_cid = list()	//So admins know why it isn't working - Used to determine what other accounts previously logged in from this computer id

	preload_rsc = 0 // This is 0 so we can set it to an URL once the player logs in and have them download the resources from a different server.

	var/obj/screen/click_catcher/void

	var/karma = 0
	var/karma_spent = 0
	var/karma_tab = 0


	var/ip_intel = "Disabled"

	var/datum/click_intercept/click_intercept = null

	/// Overlay for showing debug info
	var/obj/screen/debugtextholder/debug_text_overlay

	var/datum/geoip_data/geoip = null

	//datum that controls the displaying and hiding of tooltips
	var/datum/tooltip/tooltips

	// Their chat window, sort of important.
	// See /goon/code/datums/browserOutput.dm
	var/datum/chatOutput/chatOutput

	// Donator stuff.
	var/donator_level = 0

	// If set to true, this client can interact with atoms such as buttons and doors on top of regular machinery interaction
	var/advanced_admin_interaction = FALSE

	var/client_keysend_amount = 0
	var/next_keysend_reset = 0
	var/next_keysend_trip_reset = 0
	var/keysend_tripped = FALSE

	/// Messages currently seen by this client
	var/list/seen_messages

	var/fullscreen = FALSE

	// Last world.time that the player tried to request their resources.
	var/last_ui_resource_send = 0

	/// If true, client cannot ready up, late join, or observe. Used for players with EXTREMELY old byond versions.
	var/version_blocked = FALSE

	/// Date the client registered their BYOND account on
	var/byondacc_date
	/// Days since the client's BYOND account was created
	var/byondacc_age = 0

	///Last ping of the client
	var/lastping = 0
	///Average ping of the client
	var/avgping = 0
	///world.time they connected
	var/connection_time
	///world.realtime they connected
	var/connection_realtime
	///world.timeofday they connected
	var/connection_timeofday

	// Do not attempt to merge these vars together. They are for different things
	/// Last world.time that a PM was send to discord by a player
	var/last_discord_pm_time = 0

	/// Last world/time that a PM was sent to the player by an admin
	var/received_discord_pm = -99999 // Yes this super low number is intentional

	/// Has the client accepted the TOS about data collection and other stuff
	var/tos_consent = FALSE

	var/url

	/// Input datum, what the client is pressing.
	var/datum/input_data/input_data = new()
	/// The client's active keybindings, depending on their active mob.
	var/list/active_keybindings = list()
	/// The client's movement keybindings to directions, which work regardless of modifiers.
	var/list/movement_kb_dirs = list()

/client/vv_edit_var(var_name, var_value)
	switch(var_name)
		// I know we will never be in a world where admins are editing client vars to let people bypass TOS
		// But guess what, if I have the ability to overengineer something, I am going to do it
		if("tos_consent")
			return FALSE
	return ..()
