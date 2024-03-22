/datum/gear/neck
	subtype_path = /datum/gear/neck
	slot = slot_neck
	sort_category = "Neck"

//Mantles
/datum/gear/neck/mantle
	display_name = "mantle, color"
	path = /obj/item/clothing/neck/mantle

/datum/gear/neck/mantle/New()
	..()
	gear_tweaks += new /datum/gear_tweak/color(parent = src)

/datum/gear/neck/old_scarf
	display_name = "old scarf"
	path = /obj/item/clothing/neck/mantle/old

/datum/gear/neck/regal_shawl
	display_name = "regal shawl"
	path = /obj/item/clothing/neck/mantle/regal

/datum/gear/neck/cowboy_mantle
	display_name = "old wrappings"
	path = /obj/item/clothing/neck/mantle/cowboy

/datum/gear/neck/mantle/job
	subtype_path = /datum/gear/neck/mantle/job
	subtype_cost_overlap = FALSE

/datum/gear/neck/mantle/job/captain
	display_name = "mantle, captain"
	path = /obj/item/clothing/neck/mantle/captain
	allowed_roles = list("Captain")

/datum/gear/neck/mantle/job/chief_engineer
	display_name = "mantle, chief engineer"
	path = /obj/item/clothing/neck/mantle/chief_engineer
	allowed_roles = list("Chief Engineer")

/datum/gear/neck/mantle/job/chief_medical_officer
	display_name = "mantle, chief medical officer"
	path = /obj/item/clothing/neck/mantle/chief_medical_officer
	allowed_roles = list("Chief Medical Officer")

/datum/gear/neck/mantle/job/head_of_security
	display_name = "mantle, head of security"
	path = /obj/item/clothing/neck/mantle/head_of_security
	allowed_roles = list("Head of Security")

/datum/gear/neck/mantle/job/head_of_personnel
	display_name = "mantle, head of personnel"
	path = /obj/item/clothing/neck/mantle/head_of_personnel
	allowed_roles = list("Head of Personnel")

/datum/gear/neck/mantle/job/research_director
	display_name = "mantle, research director"
	path = /obj/item/clothing/neck/mantle/research_director
	allowed_roles = list("Research Director")

//Cloaks
/datum/gear/neck/cloak
	display_name = "cloak, color"
	path = /obj/item/clothing/neck/cloak/grey

/datum/gear/neck/cloak/New()
	..()
	gear_tweaks += new /datum/gear_tweak/color(parent = src)

/datum/gear/neck/cloakjob
	subtype_path = /datum/gear/neck/cloakjob
	subtype_cost_overlap = FALSE

/datum/gear/neck/cloakjob/healer
	display_name = "cloak, healer"
	path = /obj/item/clothing/neck/cloak/healer
	allowed_roles = list("Chief Medical Officer", "Medical Doctor", "Intern", "Paramedic", "Brig Physician")

/datum/gear/neck/cloakjob/captain
	display_name = "cloak, captain"
	path = /obj/item/clothing/neck/cloak/captain
	allowed_roles = list("Captain")

/datum/gear/neck/cloakjob/nanotrasen_representative
	display_name = "cloak, nanotrasen representative"
	path = /obj/item/clothing/neck/cloak/nanotrasen_representative
	allowed_roles = list("Nanotrasen Representative")

/datum/gear/neck/cloakjob/blueshield
	display_name = "cloak, blueshield"
	path = /obj/item/clothing/neck/cloak/blueshield
	allowed_roles = list("Blueshield")

/datum/gear/neck/cloakjob/chief_engineer
	display_name = "cloak, chief engineer"
	path = /obj/item/clothing/neck/cloak/chief_engineer
	allowed_roles = list("Chief Engineer")

/datum/gear/neck/cloakjob/chief_engineer/white
	display_name = "cloak, chief engineer, white"
	path = /obj/item/clothing/neck/cloak/chief_engineer/white
	allowed_roles = list("Chief Engineer")

/datum/gear/neck/cloakjob/chief_medical_officer
	display_name = "cloak, chief medical officer"
	path = /obj/item/clothing/neck/cloak/chief_medical_officer
	allowed_roles = list("Chief Medical Officer")

/datum/gear/neck/cloakjob/head_of_security
	display_name = "cloak, head of security"
	path = /obj/item/clothing/neck/cloak/head_of_security
	allowed_roles = list("Head of Security")

/datum/gear/neck/cloaksecurity
	display_name = "cloak, security officer"
	path = /obj/item/clothing/neck/cloak/security
	allowed_roles = list("Head of Security", "Security Officer", "Warden", "Security Pod Pilot")

/datum/gear/neck/cloakjob/head_of_personnel
	display_name = "cloak, head of personnel"
	path = /obj/item/clothing/neck/cloak/head_of_personnel
	allowed_roles = list("Head of Personnel")

/datum/gear/neck/cloakjob/research_director
	display_name = "cloak, research director"
	path = /obj/item/clothing/neck/cloak/research_director
	allowed_roles = list("Research Director")

/datum/gear/neck/cloakjob/quartermaster
	display_name = "cloak, quartermaster"
	path = /obj/item/clothing/neck/cloak/quartermaster
	allowed_roles = list("Quartermaster")

//Ponchos
/datum/gear/neck/poncho
	display_name = "poncho, classic"
	path = /obj/item/clothing/neck/poncho

/datum/gear/neck/poncho/security
	display_name = "poncho, corporate"
	path = /obj/item/clothing/neck/poncho/security
	allowed_roles = list("Head of Security", "Security Officer", "Warden", "Security Pod Pilot")

