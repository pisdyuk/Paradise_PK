/obj/item/clothing/head/wizard
	name = "wizard hat"
	desc = "Strange-looking hat-wear that most certainly belongs to a real magic user."
	icon_state = "wizard"
	gas_transfer_coefficient = 0.01 // IT'S MAGICAL OKAY JEEZ +1 TO NOT DIE
	permeability_coefficient = 0.01
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	//Not given any special protective value since the magic robes are full-body protection --NEO
	strip_delay = 50
	put_on_delay = 50
	magical = TRUE
	dog_fashion = /datum/dog_fashion/head/blue_wizard

/obj/item/clothing/head/wizard/red
	name = "red wizard hat"
	desc = "Strange-looking, red, hat-wear that most certainly belongs to a real magic user."
	icon_state = "redwizard"
	dog_fashion = /datum/dog_fashion/head/red_wizard

/obj/item/clothing/head/wizard/black
	name = "black wizard hat"
	desc = "Strange-looking black hat-wear that most certainly belongs to a real skeleton. Spooky."
	icon_state = "blackwizard"
	dog_fashion = null

/obj/item/clothing/head/wizard/clown
	name = "purple wizard hat"
	desc = "Strange-looking purple hat-wear that most certainly belongs to a real magic user."
	icon_state = "wizhatclown"
	item_state = "wizhatclown" // cheating
	dog_fashion = null

/obj/item/clothing/head/wizard/mime
	name = "magical beret"
	desc = "A magical red beret."
	icon_state = "wizhatmime"
	item_state = "wizhatmime"
	dog_fashion = null
	sprite_sheets = list(
		"Plasmaman" = 'icons/mob/clothing/species/plasmaman/suit.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/head.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/head.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
		)

/obj/item/clothing/head/wizard/fake
	name = "wizard hat"
	desc = "It has WIZZARD written across it in sequins. Comes with a cool beard."
	icon_state = "wizard-fake"
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	magical = FALSE
	resistance_flags = FLAMMABLE
	dog_fashion = /datum/dog_fashion/head/blue_wizard
	sprite_sheets = list(
		"Plasmaman" = 'icons/mob/clothing/species/plasmaman/suit.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi'
	)

/obj/item/clothing/head/wizard/marisa
	name = "Witch Hat"
	desc = "Strange-looking hat-wear, makes you want to cast fireballs."
	icon_state = "marisa"
	dog_fashion = null

/obj/item/clothing/head/wizard/magus
	name = "Magus Helm"
	desc = "A mysterious helmet that hums with an unearthly power"
	icon_state = "magus"
	item_state = "magus"
	dog_fashion = null
	flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES

/obj/item/clothing/head/wizard/magusdefender
	name = "Magus Helm"
	desc = "A mysterious helmet that hums with an unearthly power"
	icon_state = "magusdefender"
	item_state = "magusdefender"
	dog_fashion = null
	flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/head.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/head.dmi',
		"Tajaran" = 'icons/mob/clothing/species/tajaran/head.dmi'
	)

/obj/item/clothing/head/wizard/necromage
	name = "Necronat Mask"
	desc = "A mysterious mask made from the skull of the previous owner."
	icon_state = "necromage"
	item_state = "necromage"
	dog_fashion = null
	flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/head.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/head.dmi',
		"Tajaran" = 'icons/mob/clothing/species/tajaran/head.dmi'
	)

/obj/item/clothing/head/wizard/artmage
	name = "Wizard Sculptor's Beret"
	desc = "The classic beret of the followers of the school of sculpture allows you to look like a real artist."
	icon_state = "artmage"
	item_state = "artmage"
	dog_fashion = null
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/head.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi'
	)

/obj/item/clothing/head/wizard/visionmage
	name = "Golden tiara"
	desc = "Golden tiara with a third eye, don't look directly into it."
	icon_state = "visionmage"
	item_state = "visionmage"
	dog_fashion = null
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/head.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi'
	)

/obj/item/clothing/head/wizard/healmage
	name = "Healer's Hat"
	desc = "The magical hat of a healer's robe that protects against leprosy."
	icon_state = "healmage"
	item_state = "healmage"
	dog_fashion = null
	sprite_sheets = list(
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi'
	)

/obj/item/clothing/head/wizard/amp
	name = "psychic amplifier"
	desc = "A crown-of-thorns psychic amplifier. Kind of looks like a tiara having sex with an industrial robot."
	icon_state = "amp"
	dog_fashion = null

/obj/item/clothing/suit/wizrobe
	name = "wizard robe"
	desc = "A magnificant, gem-lined robe that seems to radiate power."
	icon_state = "wizard"
	item_state = "wizrobe"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 100, "acid" = 100)
	allowed = list(/obj/item/teleportation_scroll)
	flags_inv = HIDEJUMPSUIT
	strip_delay = 50
	put_on_delay = 50
	resistance_flags = FIRE_PROOF | ACID_PROOF
	magical = TRUE

/obj/item/clothing/suit/wizrobe/red
	name = "red wizard robe"
	desc = "A magnificant, red, gem-lined robe that seems to radiate power."
	icon_state = "redwizard"
	item_state = "redwizrobe"

/obj/item/clothing/suit/wizrobe/black
	name = "black wizard robe"
	desc = "An unnerving black gem-lined robe that reeks of death and decay."
	icon_state = "blackwizard"
	item_state = "blackwizrobe"

/obj/item/clothing/suit/wizrobe/clown
	name = "clown robe"
	desc = "A set of armoured robes that seem to radiate a dark power. That, and bad fashion decisions."
	icon_state = "wizzclown"
	item_state = "wizzclown"

/obj/item/clothing/suit/wizrobe/mime
	name = "mime robe"
	desc = "Red, black, and white robes. There is not much else to say about them."
	icon_state = "wizzmime"
	item_state = "wizzmime"
	sprite_sheets = list(
		"Plasmaman" = 'icons/mob/clothing/species/plasmaman/suit.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/suit.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/suit.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/suit.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/suit.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/suit.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/suit.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/suit.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/suit.dmi'
		)

/obj/item/clothing/suit/wizrobe/marisa
	name = "Witch Robe"
	desc = "Magic is all about the spell power, ZE!"
	icon_state = "marisa"
	item_state = "marisarobe"

/obj/item/clothing/suit/wizrobe/magusblue
	name = "Magus Robe"
	desc = "A set of armoured robes that seem to radiate a dark power"
	icon_state = "magusblue"
	item_state = "magusblue"
	sprite_sheets = list(
		"Plasmaman" = 'icons/mob/clothing/species/plasmaman/suit.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/suit.dmi'
		)

/obj/item/clothing/suit/wizrobe/magusred
	name = "Magus Robe"
	desc = "A set of armoured robes that seem to radiate a dark power"
	icon_state = "magusred"
	item_state = "magusred"
	sprite_sheets = list(
		"Plasmaman" = 'icons/mob/clothing/species/plasmaman/suit.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/suit.dmi'
		)

/obj/item/clothing/suit/wizrobe/magusdefender
	name = "Magus Robe"
	desc = "A set of armoured robes that seem to radiate a dark power."
	icon_state = "magusdefender"
	item_state = "magusdefender"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/suit.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/suit.dmi'
		)

/obj/item/clothing/suit/wizrobe/necromage
	name = "Necronat Robe"
	desc = "Black and toxic green robes that seem to radiate a dark power and scent of death."
	icon_state = "necromage"
	item_state = "necromage"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/suit.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/suit.dmi'
		)

/obj/item/clothing/suit/wizrobe/artmage
	name = "Wizard Sculptor's Apron"
	desc = "A classic apron of followers of the school of sculpture, it protects well from flying clay."
	icon_state = "artmage"
	item_state = "artmage"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/suit.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/suit.dmi'
		)

/obj/item/clothing/suit/wizrobe/visionmage
	name = "Dark robe"
	desc = "A dark seer's robe woven from otherworldly threads. Emits dark energy."
	icon_state = "visionmage"
	item_state = "visionmage"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/suit.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/suit.dmi'
		)

/obj/item/clothing/suit/wizrobe/healmage
	name = "Healer's Robe"
	desc = "Magical robe of a healing servant that protects against leprosy."
	icon_state = "healmage"
	item_state = "healmage"
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/suit.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/suit.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/suit.dmi'
		)

/obj/item/clothing/suit/wizrobe/psypurple
	name = "purple robes"
	desc = "Heavy, royal purple robes threaded with psychic amplifiers and weird, bulbous lenses. Do not machine wash."
	icon_state = "psyamp"
	item_state = "psyamp"

/obj/item/clothing/suit/wizrobe/fake
	name = "wizard robe"
	desc = "A rather dull, blue robe meant to mimick real wizard robes."
	icon_state = "wizard-fake"
	item_state = "wizrobe"
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = FLAMMABLE
	magical = FALSE

/obj/item/clothing/head/wizard/marisa/fake
	name = "Witch Hat"
	desc = "Strange-looking hat-wear, makes you want to cast fireballs."
	icon_state = "marisa"
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = FLAMMABLE
	magical = FALSE

/obj/item/clothing/head/wizard/marisa/fake/alt
	icon_state = "marisa_alt"
	item_state = "marisa_alt"

/obj/item/clothing/suit/wizrobe/marisa/fake
	name = "Witch Robe"
	desc = "Magic is all about the spell power, ZE!"
	icon_state = "marisa"
	item_state = "marisarobe"
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = FLAMMABLE
	magical = FALSE

/obj/item/clothing/suit/space/hardsuit/wizard
	name = "battlemage armour"
	desc = "Not all wizards are afraid of getting up close and personal. Not spaceproof despite its appearance."
	icon_state = "hardsuit-wiz"
	item_state = "wiz_hardsuit"
	armor = list(melee = 30, bullet = 20, laser = 20, energy = 20, bomb = 20, bio = 20, rad = 20, fire = 100, acid = 100)
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/wizard
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	slowdown = 0
	magical = TRUE

/obj/item/clothing/head/helmet/space/hardsuit/wizard
	name = "battlemage helmet"
	desc = "A suitably impressive helmet."
	icon_state = "hardsuit0-wiz"
	item_state = "wiz_helm"
	armor = list(melee = 30, bullet = 20, laser = 20, energy = 20, bomb = 20, bio = 20, rad = 20, fire = 100, acid = 100)
	item_color = "wiz"
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	actions_types = null //No inbuilt light
	magical = TRUE

/obj/item/clothing/head/helmet/space/hardsuit/wizard/attack_self(mob/user)
	return

/obj/item/clothing/suit/space/hardsuit/wizard/arch
	desc = "For the arch wizard in need of additional protection."
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/wizard/arch

/obj/item/clothing/head/helmet/space/hardsuit/wizard/arch
	desc = "A truly protective helmet."
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
