
// General-purpose CC official. Can hear out grievances, investigate cases, issue demotions, etc.
/datum/job/ntnavyofficer
	title = JOB_TITLE_CCOFFICER
	flag = JOB_FLAG_CENTCOM
	department_flag = JOB_FLAG_CENTCOM // This gets its job as its own flag because admin jobs dont have flags
	total_positions = 5
	spawn_positions = 5
	supervisors = "the admins"
	selection_color = "#6865B3"
	access = list()
	minimal_access = list()
	admin_only = 1
	outfit = /datum/outfit/job/ntnavyofficer

/datum/job/ntnavyofficer/get_access()
	return get_centcom_access(title)

/datum/outfit/job/ntnavyofficer
	name = "Nanotrasen Navy Officer"
	jobtype = /datum/job/ntnavyofficer

	uniform = /obj/item/clothing/under/rank/centcom/officer
	gloves =  /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/centcom
	head = /obj/item/clothing/head/beret/centcom/officer
	l_ear = /obj/item/radio/headset/centcom
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	id = /obj/item/card/id/centcom
	pda = /obj/item/pda/centcom
	belt = /obj/item/gun/energy/pulse/pistol
	implants = list(
		/obj/item/implant/mindshield/ert,
		/obj/item/implant/dust
	)
	backpack = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/stamp/centcom = 1,
		/obj/item/stamp/ploho = 1,
		/obj/item/stamp/BIGdeny = 1,
	)
	box = /obj/item/storage/box/centcomofficer
	cybernetic_implants = list(
		/obj/item/organ/internal/cyberimp/chest/nutriment_old/plus
	)

/datum/outfit/job/ntnavyofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	H.mind?.offstation_role = TRUE

// НТ Оффицер для недовольных выходов с ЦК.
/datum/job/ntnavyofficer/field
	title = JOB_TITLE_CCFIELD
	outfit = /datum/outfit/job/ntnavyofficer/field

/datum/outfit/job/ntnavyofficer/field
	name = "Nanotrasen Navy Field Officer"
	jobtype = /datum/job/ntnavyofficer/field

	suit = /obj/item/clothing/suit/space/deathsquad/officer/field
	l_pocket = /obj/item/melee/baseball_bat/homerun/central_command

// CC Officials who lead ERTs, Death Squads, etc.
/datum/job/ntspecops
	title = JOB_TITLE_CCSPECOPS
	flag = JOB_FLAG_CENTCOM
	department_flag = JOB_FLAG_CENTCOM // This gets its job as its own flag because admin jobs dont have flags
	total_positions = 5
	spawn_positions = 5
	supervisors = "the admins"
	selection_color = "#6865B3"
	access = list()
	minimal_access = list()
	admin_only = 1
	spawn_ert = 1
	outfit = /datum/outfit/job/ntspecops

/datum/job/ntspecops/get_access()
	return get_centcom_access(title)

/datum/outfit/job/ntspecops
	name = "Special Operations Officer"
	jobtype = /datum/job/ntspecops
	uniform = /obj/item/clothing/under/rank/centcom/captain
	suit = /obj/item/clothing/suit/space/deathsquad/officer
	back = /obj/item/storage/backpack/ert/security
	belt = /obj/item/storage/belt/military/assault
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat
	mask = /obj/item/clothing/mask/cigarette/cigar/cohiba
	head = /obj/item/clothing/head/helmet/space/deathsquad/beret
	l_ear = /obj/item/radio/headset/centcom
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	id = /obj/item/card/id/centcom
	pda = /obj/item/pda/centcom
	r_pocket = /obj/item/storage/box/matches
	l_pocket = /obj/item/melee/baseball_bat/homerun/central_command
	box = /obj/item/storage/box/centcomofficer
	backpack = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/clothing/shoes/magboots/advance = 1,
		/obj/item/storage/box/zipties = 1
	)
	implants = list(
		/obj/item/implant/mindshield/ert,
		/obj/item/implant/dust
	)
	cybernetic_implants = list(
		/obj/item/organ/internal/cyberimp/eyes/xray,
		/obj/item/organ/internal/cyberimp/brain/anti_stun/hardened,
		/obj/item/organ/internal/cyberimp/chest/nutriment_old/plus,
		/obj/item/organ/internal/cyberimp/arm/combat/centcom
	)

/datum/outfit/job/ntspecops/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	H.mind?.offstation_role = TRUE

// Верховное командование для самых больших проблем
/datum/job/ntspecops/supreme
	title = JOB_TITLE_CCSUPREME
	outfit = /datum/outfit/job/ntspecops/supreme

/datum/outfit/job/ntspecops/supreme
	name = "Supreme Commander"
	jobtype = /datum/job/ntspecops/supreme

	suit = /obj/item/clothing/suit/space/deathsquad/officer/supreme
	head = /obj/item/clothing/head/helmet/space/deathsquad/beret/supreme
	shoes =	/obj/item/clothing/shoes/cowboy/white
	gloves = /obj/item/clothing/gloves/color/white
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/aviators
	backpack_contents = list(
		/obj/item/stamp/navcom = 1
	)

//Tran-Solar Federation General
/datum/job/ntspecops/solgovspecops
	title = JOB_TITLE_CCSOLGOV
	outfit = /datum/outfit/job/ntspecops/solgovspecops

/datum/outfit/job/ntspecops/solgovspecops
	name = "Solar Federation General"
	uniform = /obj/item/clothing/under/rank/centcom/captain/solgov
	suit = /obj/item/clothing/suit/space/deathsquad/officer/solgov
	head = /obj/item/clothing/head/helmet/space/deathsquad/beret/solgov
	l_ear = /obj/item/radio/headset/centcom/solgov

	implants = list(
		/obj/item/implant/dust
	)

	backpack_contents = list(
		/obj/item/stamp/solgov = 1,
	)

/datum/outfit/job/ntspecops/solgovspecops/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	var/obj/item/card/id/I = H.wear_id
	if(istype(I))
		apply_to_card(I, H, get_centcom_access(name), name, "lifetimeid")
	H.sec_hud_set_ID()
	H.mind?.offstation_role = TRUE
