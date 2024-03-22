/*
 * Contains:
 *		Security
 *		Detective
 *		Head of Security
 */


/*
 * Security
 */
/obj/item/clothing/under/rank/warden
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for more robust protection. It has the word \"Warden\" written on the shoulders."
	name = "warden's jumpsuit"
	icon_state = "warden"
	item_state = "r_suit"
	item_color = "warden"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	strip_delay = 50

/obj/item/clothing/under/rank/warden/skirt
	desc = "Standard feminine fashion for a Warden. It is made of sturdier material than standard jumpskirts. It has the word \"Warden\" written on the shoulders."
	name = "warden's jumpskirt"
	icon_state = "wardenf"
	item_state = "r_suit"
	item_color = "wardenf"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/uniform.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/uniform.dmi'
	)

/obj/item/clothing/under/rank/security
	name = "security officer's jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "security"
	item_state = "r_suit"
	item_color = "secred"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	strip_delay = 50

/obj/item/clothing/under/rank/security/sensor
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/cadet
	name = "security cadet jumpsuit"
	icon_state = "cadet_s"
	item_color = "cadet"

/obj/item/clothing/under/rank/security/cadet/skirt
	name = "security cadet jumpskirt"
	icon_state = "cadetf_s"
	item_color = "cadetf"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/security/cadet/assistant
	name = "security assistant jumpsuit"
	icon_state = "sec_ass_s"
	item_color = "sec_ass"

/obj/item/clothing/under/rank/security/cadet/assistant/skirt
	name = "security assistant jumpskirt"
	icon_state = "sec_ass_f_s"
	item_color = "sec_ass_f"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/security/skirt
	name = "security officer's jumpskirt"
	desc = "Standard feminine fashion for Security Officers.  It's made of sturdier material than the standard jumpskirts."
	icon_state = "secredf"
	item_state = "r_suit"
	item_color = "secredf"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/uniform.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/uniform.dmi'
	)


/obj/item/clothing/under/rank/dispatch
	name = "dispatcher's uniform"
	desc = "A dress shirt and khakis with a security patch sewn on."
	icon_state = "dispatch"
	item_state = "dispatch"
	item_color = "dispatch"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/under/rank/security2
	name = "security officer's uniform"
	desc = "It's made of a slightly sturdier material, to allow for robust protection."
	icon_state = "redshirt2"
	item_state = "r_suit"
	item_color = "redshirt2"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/under/rank/security/corp
	icon_state = "sec_corporate"
	item_state = "sec_corporate"
	item_color = "sec_corporate"

/obj/item/clothing/under/rank/warden/corp
	icon_state = "warden_corporate"
	item_state = "warden_corporate"
	item_color = "warden_corporate"

/*
 * Detective
 */
/obj/item/clothing/under/det
	name = "hard-worn suit"
	desc = "Someone who wears this means business."
	icon_state = "detective"
	item_state = "det"
	item_color = "detective"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	strip_delay = 50

	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/uniform.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/uniform.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/uniform.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/uniform.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/uniform.dmi'
		)

/obj/item/clothing/under/det/skirt
	name = "hard-worn skirt"
	icon_state = "detective_skirt"
	item_color = "detective_skirt"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/uniform.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/uniform.dmi'
	)


/obj/item/clothing/under/det/noir
	name = "hard-worn black suit"
	desc = "Anyone who wears this is dealing in shady business."
	icon_state = "noirdet"
	item_state = "noir"
	item_color = "noirdet"

/obj/item/clothing/under/det/noir/skirt
	name = "hard-worn black skirt"
	desc = "Anyone who wears this is dealing in shady business."
	icon_state = "noirdet_skirt"
	item_state = "noir_skirt"
	item_color = "noirdet_skirt"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/uniform.dmi'
	)

/obj/item/clothing/under/det/alt_a
	icon_state = "detective_suit"
	item_color = "detectives_suit_grey"

/obj/item/clothing/under/det/alt_a/skirt
	name = "hard-worn skirt"
	icon_state = "detectives_skirt_grey"
	item_color = "detectives_skirt_grey"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/uniform.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/uniform.dmi',
		"Tajaran" = 'icons/mob/clothing/species/vulpkanin/uniform.dmi'
		)

/obj/item/clothing/under/det/alt_b
	icon_state = "detective_suit_alt"
	item_color = "detective_suit_alt"

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/head_of_security
	desc = "It's a jumpsuit worn by those few with the dedication to achieve the position of \"Head of Security\". It has additional armor to protect the wearer."
	name = "head of security's jumpsuit"
	icon_state = "hos"
	item_state = "r_suit"
	item_color = "hosred"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	strip_delay = 60

/obj/item/clothing/under/rank/head_of_security/skirt
	desc = "It's a fashionable jumpskirt worn by those few with the dedication to achieve the position of \"Head of Security\". It has additional armor to protect the wearer."
	name = "head of security's jumpskirt"
	icon_state = "hosredf"
	item_state = "r_suit"
	item_color = "hosredf"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/uniform.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/uniform.dmi'
	)

/obj/item/clothing/under/rank/head_of_security/corp
	icon_state = "hos_corporate"
	item_state = "hos_corporate"
	item_color = "hos_corporate"

/obj/item/clothing/under/rank/head_of_security/alt
	icon_state = "hosalt"
	item_state = "hosalt"
	item_color = "hosalt"

/obj/item/clothing/under/rank/head_of_security/alt/skirt
	icon_state = "hosalt_skirt"
	item_state = "hosalt_skirt"
	item_color = "hosalt_skirt"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/uniform.dmi'
	)

/obj/item/clothing/under/rank/head_of_security/paradef
	desc = "It's a fashionable jumpskirt worn by those few with the dedication to achieve the position of \"Head of Security\". It has additional armor to protect the wearer. Made for parades."
	name = "head of security's parade jumpskirt"
	icon_state = "hos_parade_fem"
	item_state = "hos_parade_fem"
	item_color = "hos_parade_fem"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/uniform.dmi'
	)

//Jensen cosplay gear

/obj/item/clothing/under/rank/head_of_security/jensen
	desc = "You never asked for anything that stylish."
	name = "head of security's jumpsuit"
	icon_state = "jensen"
	item_state = "jensen"
	item_color = "jensen"

//Paradise Station

/obj/item/clothing/suit/armor/hos/hosnavyjacket
	name = "head of security navy jacket"
	icon_state = "hosdnavyjacket"
	item_state = "hosdnavyjacket"

/obj/item/clothing/suit/armor/hos/hosbluejacket
	name = "head of security blue jacket"
	icon_state = "hosbluejacket"
	item_state = "hosbluejacket"

/obj/item/clothing/suit/armor/hos/officernavyjacket
	name = "officer's navy jacket"
	icon_state = "officernavyjacket"
	item_state = "officernavyjacket"

/obj/item/clothing/suit/armor/hos/officerbluejacket
	name = "officer's blue jacket"
	icon_state = "officerbluejacket"
	item_state = "officerbluejacket"

//TG Station

/obj/item/clothing/under/rank/security/formal
	name = "security suit"
	desc = "A formal security suit for officers complete with nanotrasen belt buckle."
	icon_state = "security_formal"
	item_state = "gy_suit"
	item_color = "security_formal"

/obj/item/clothing/under/rank/warden/formal
	name = "warden's suit"
	desc = "A formal security suit for the warden with blue desginations and '/Warden/' stiched into the shoulders."
	icon_state = "warden_formal"
	item_state = "gy_suit"
	item_color = "warden_formal"

/obj/item/clothing/under/rank/head_of_security/formal
	name = "head of security's suit"
	desc = "A security suit decorated for those few with the dedication to achieve the position of Head of Security."
	icon_state = "hos_formal"
	item_state = "gy_suit"
	item_color = "hos_formal"


//Brig Physician
/obj/item/clothing/under/rank/security/brigphys
	desc = "Jumpsuit for Brig Physician it has both medical and security protection."
	name = "brig physician's jumpsuit"
	icon_state = "brig_phys"
	item_state = "brig_phys"
	item_color = "brig_phys"
	permeability_coefficient = 0.50
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0, fire = 30, acid = 30)

/obj/item/clothing/under/rank/security/brigphys/skirt
	desc = "A skirted Brig Physician uniform. It has both security and medical protection."
	name = "brig physician's jumpskirt"
	icon_state = "brig_physf"
	item_state = "brig_physf"
	item_color = "brig_physf"
	permeability_coefficient = 0.50
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/uniform.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/uniform.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/uniform.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/uniform.dmi'
		)

/obj/item/clothing/under/rank/security/brigmedical
	desc = "Комбинезон медика СБ синего цвета 26-го века. Является компромиссом между санитарными нормами и стандартами защиты."
	name = "brig medical's jumpsuit"
	icon_state = "brig_medical"
	item_state = "brig_medical"
	item_color = "brig_medical"
	permeability_coefficient = 0.50
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0, fire = 30, acid = 30)

/obj/item/clothing/under/rank/security/brigmedical/skirt
	name = "brig medical's jumpskirt"
	icon_state = "brigmed_skirt"
	item_state = "brigmed_skirt"
	item_color = "brigmed_skirt"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/uniform.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/uniform.dmi'
	)

//Pod Pilot
/obj/item/clothing/under/rank/security/pod_pilot
	desc = "Suit for your regular pod pilot."
	name = "pod pilot's jumpsuit"
	icon_state = "pod_pilot"
	item_state = "pod_pilot"
	item_color = "pod_pilot"

/obj/item/clothing/under/rank/security/pod_pilot/skirt
	desc = "Skirt for your regular pod pilot."
	name = "pod pilot's jumpskirt"
	icon_state = "pod_pilotf"
	item_state = "pod_pilotf"
	item_color = "pod_pilotf"
