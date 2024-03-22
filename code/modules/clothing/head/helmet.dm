/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "helmetmaterials"
	w_class = WEIGHT_CLASS_NORMAL
	flags = HEADBANGPROTECT
	flags_cover = HEADCOVERSEYES
	item_state = "helmetmaterials"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	flags_inv = HIDEHEADSETS|HIDEGLASSES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	dog_fashion = /datum/dog_fashion/head/helmet
	pickup_sound = 'sound/items/handling/helmet_pickup.ogg'
	drop_sound = 'sound/items/handling/helmet_drop.ogg'
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/helmet.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/helmet.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/helmet.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
	)


/obj/item/clothing/head/helmet/adjust_headgear(mob/user)
	. = ..()
	if(.)
		flags ^= visor_flags
		flags_inv ^= visor_flags_inv

/obj/item/clothing/head/helmet/visor
	name = "visor helmet"
	desc = "A helmet with a built-in visor. It doesn't seem to do anything, but it sure looks cool!"
	icon_state = "helmetgoggles"

/obj/item/clothing/head/helmet/thermal
	name = "thermal visor helmet"
	desc = "A helmet with a built-in thermal scanning visor."
	icon_state = "helmetthermals"
	vision_flags = SEE_MOBS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE

/obj/item/clothing/head/helmet/meson
	name = "meson visor helmet"
	desc = "A helmet with a built-in meson scanning visor."
	icon_state = "helmetmesons"
	vision_flags = SEE_TURFS

/obj/item/clothing/head/helmet/material
	name = "material visor helmet"
	desc = "A helmet with a built-in material scanning visor."
	icon_state = "helmetmaterials"
	vision_flags = SEE_OBJS

/obj/item/clothing/head/helmet/night
	name = "night-vision helmet"
	desc = "A helmet with a built-in pair of night vision goggles."
	icon_state = "helmetNVG"
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE //don't render darkness while wearing these

/obj/item/clothing/head/helmet/alt
	name = "bulletproof helmet"
	desc = "A bulletproof helmet that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	icon_state = "swat"
	item_state = "swat-alt"
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	dog_fashion = null
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/helmet.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
		)

/obj/item/clothing/head/helmet/riot
	name = "riot helmet"
	desc = "It's a helmet specifically designed to protect against close range attacks."
	icon_state = "riot"
	item_state = "helmet"
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	flags_inv = HIDEHEADSETS
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	strip_delay = 80
	dog_fashion = null
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/helmet.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
		)

/obj/item/clothing/head/helmet/riot/knight
	name = "medieval helmet"
	desc = "A classic metal helmet."
	icon_state = "knight_green"
	item_state = "knight_green"
	flags = BLOCKHAIR
	flags_inv = HIDEMASK|HIDEHEADSETS|HIDEGLASSES|HIDENAME
	dog_fashion = null
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
		)

/obj/item/clothing/head/helmet/justice
	name = "helmet of justice"
	desc = "WEEEEOOO. WEEEEEOOO. WEEEEOOOO."
	icon_state = "justice"
	toggle_on_message = "You turn off the lights on"
	toggle_off_message = "You turn on the lights on"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	can_toggle = TRUE
	toggle_cooldown = 20
	active_sound = 'sound/items/weeoo1.ogg'
	dog_fashion = null

/obj/item/clothing/head/helmet/justice/escape
	name = "alarm helmet"
	desc = "WEEEEOOO. WEEEEEOOO. STOP THAT MONKEY. WEEEOOOO."
	icon_state = "justice2"
	toggle_on_message = "You turn off the light on"
	toggle_off_message = "You turn on the light on"


/obj/item/clothing/head/helmet/swat
	name = "\improper SWAT helmet"
	desc = "They're often used by highly trained Swat Members."
	icon_state = "swat"
	item_state = "swat"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 30, "bomb" = 50, "bio" = 90, "rad" = 20, "fire" = 50, "acid" = 50)
	flags = null
	flags_inv = HIDEHEADSETS|HIDEGLASSES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	strip_delay = 80
	dog_fashion = null
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/helmet.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
		)

/obj/item/clothing/head/helmet/swat/syndicate
	name = "blood-red helmet"
	desc = "An extremely robust, space-worthy helmet without a visor to allow for goggle usage underneath. Property of Gorlex Marauders."
	icon_state = "helmetsyndi"
	item_state = "helmet"

/obj/item/clothing/head/helmet/thunderdome
	name = "\improper Thunderdome helmet"
	desc = "<i>'Let the battle commence!'</i>"
	icon_state = "thunderdome"
	flags = null
	item_state = "thunderdome"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	strip_delay = 80
	dog_fashion = null

/obj/item/clothing/head/helmet/roman
	name = "roman helmet"
	desc = "An ancient helmet made of bronze and leather."
	flags = null
	armor = list("melee" = 25, "bullet" = 0, "laser" = 25, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	icon_state = "roman"
	item_state = "roman"
	strip_delay = 100
	dog_fashion = null

/obj/item/clothing/head/helmet/roman/fake
	desc = "An ancient helmet made of plastic and leather."
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0)

/obj/item/clothing/head/helmet/roman/legionaire
	name = "roman legionaire helmet"
	desc = "An ancient helmet made of bronze and leather. Has a red crest on top of it."
	icon_state = "roman_c"
	item_state = "roman_c"

/obj/item/clothing/head/helmet/roman/legionaire/fake
	desc = "An ancient helmet made of plastic and leather. Has a red crest on top of it."
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0)

/obj/item/clothing/head/helmet/gladiator
	name = "gladiator helmet"
	desc = "Ave, Imperator, morituri te salutant."
	icon_state = "gladiator"
	flags = BLOCKHAIR
	item_state = "gladiator"
	flags_inv = HIDEMASK|HIDEHEADSETS|HIDEGLASSES
	toggle_on_message = "You attach the face shield to the"
	toggle_off_message = "You remove the face shield from the"
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	can_toggle = TRUE
	toggle_cooldown = 20
	toggle_sound = 'sound/items/zippoclose.ogg'
	dog_fashion = null

/obj/item/clothing/head/helmet/redtaghelm
	name = "red laser tag helmet"
	desc = "They have chosen their own end."
	icon_state = "redtaghelm"
	flags = null
	item_state = "redtaghelm"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 20,"energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	// Offer about the same protection as a hardhat.
	flags_inv = HIDEHEADSETS|HIDEGLASSES
	dog_fashion = null

/obj/item/clothing/head/helmet/bluetaghelm
	name = "blue laser tag helmet"
	desc = "They'll need more men."
	icon_state = "bluetaghelm"
	flags = null
	item_state = "bluetaghelm"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 20,"energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	// Offer about the same protection as a hardhat.
	flags_inv = HIDEHEADSETS|HIDEGLASSES
	dog_fashion = null

/obj/item/clothing/head/blob
	name = "blob hat"
	desc = "A collectible hat handed out at the latest Blob Family Reunion."
	icon_state = "blobhat"
	item_state = "blobhat"
	flags_inv = HIDEMASK|HIDEHEADSETS|HIDEGLASSES
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/helmet.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)

/obj/item/clothing/head/helmet/riot/knight/blue
	icon_state = "knight_blue"
	item_state = "knight_blue"
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
		)

/obj/item/clothing/head/helmet/riot/knight/yellow
	icon_state = "knight_yellow"
	item_state = "knight_yellow"
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
		)

/obj/item/clothing/head/helmet/riot/knight/red
	icon_state = "knight_red"
	item_state = "knight_red"
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
		)

/obj/item/clothing/head/helmet/riot/knight/templar
	name = "crusader helmet"
	desc = "Deus Vult."
	icon_state = "knight_templar"
	item_state = "knight_templar"
	armor = list(melee = 20, bullet = 7, laser = 2, energy = 2, bomb = 2, bio = 2, rad = 0, fire = 80, acid = 80)
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
		)

/obj/item/clothing/head/helmet/skull
	name = "skull helmet"
	desc = "An intimidating tribal helmet, it doesn't look very comfortable."
	flags_inv = HIDEMASK|HIDEHEADSETS|HIDEGLASSES|HIDENAME
	flags_cover = HEADCOVERSEYES
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	icon_state = "skull"
	item_state = "skull"
	strip_delay = 100
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi',
    	"Grey" = 'icons/mob/clothing/species/grey/helmet.dmi'
    	)

/obj/item/clothing/head/helmet/skull/Yorick
	name = "Йорик"
	desc = "Бедный Йорик..."
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi',
    	"Grey" = 'icons/mob/clothing/species/grey/helmet.dmi'
    	)

/obj/item/clothing/head/helmet/durathread
	name = "durathread helmet"
	desc = "A helmet made from durathread and leather."
	icon_state = "durathread"
	item_state = "durathread"
	resistance_flags = FLAMMABLE
	armor = list("melee" = 20, "bullet" = 10, "laser" = 30, "energy" = 5, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 50)
	strip_delay = 60

//Commander
/obj/item/clothing/head/helmet/ert/command
	flags = BLOCKHAIR
	name = "emergency response team commander helmet"
	desc = "An in-atmosphere helmet worn by the commander of a Nanotrasen Emergency Response Team. Has blue highlights."
	icon_state = "erthelmet_cmd"
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi'
	)

//Security
/obj/item/clothing/head/helmet/ert/security
	flags = BLOCKHAIR
	name = "emergency response team security helmet"
	desc = "An in-atmosphere helmet worn by security members of the Nanotrasen Emergency Response Team. Has red highlights."
	icon_state = "erthelmet_sec"
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi'
	)

/obj/item/clothing/head/helmet/ert/security/paranormal
	flags = BLOCKHAIR
	name = "paranormal emergency response team helmet"
	desc = "An in-atmosphere helmet worn by paranormal members of the Nanotrasen Emergency Response Team. Has crusader sigils."
	icon_state = "knight_templar"
	item_state = "knight_templar"
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi'
		)

//Engineer
/obj/item/clothing/head/helmet/ert/engineer
	flags = BLOCKHAIR
	name = "emergency response team engineer helmet"
	desc = "An in-atmosphere helmet worn by engineering members of the Nanotrasen Emergency Response Team. Has orange highlights."
	icon_state = "erthelmet_eng"
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi'
	)

//Medical
/obj/item/clothing/head/helmet/ert/medical
	flags = BLOCKHAIR
	name = "emergency response team medical helmet"
	desc = "A set of armor worn by medical members of the Nanotrasen Emergency Response Team. Has red and white highlights."
	icon_state = "erthelmet_med"
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi'
	)

//Janitorial
/obj/item/clothing/head/helmet/ert/janitor
	flags = BLOCKHAIR
	name = "emergency response team janitor helmet"
	desc = "A set of armor worn by janitorial members of the Nanotrasen Emergency Response Team. Has red and white highlights."
	icon_state = "erthelmet_jan"
	sprite_sheets = list(
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/head.dmi'
	)

/obj/item/clothing/head/helmet/buckhelm
	name = "buckhelm"
	desc = "Makesheft bucket helmet. Now you can call yourself as Knight of mop and soap."
	icon_state = "buckhelm"
	item_state = "buckhelm"
	flags_inv = HIDEHEADSETS
	resistance_flags = FIRE_PROOF
	armor = list("melee" = 8, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	strip_delay = 7 SECONDS
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/helmet.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/helmet.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/helmet.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Draconid" = 'icons/mob/clothing/species/unathi/helmet.dmi',
		"Tajaran" = 'icons/mob/clothing/species/tajaran/helmet.dmi',
		"Vulpkanin" = 'icons/mob/clothing/species/vulpkanin/helmet.dmi',
		"Kidan" = 'icons/mob/clothing/species/kidan/head.dmi',
		"Nian" = 'icons/mob/clothing/species/nian/helmet.dmi',
		"Machine" = 'icons/mob/clothing/species/machine/helmet.dmi',
		"Skrell" = 'icons/mob/clothing/species/skrell/helmet.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)

//Dredd
/obj/item/clothing/head/helmet/street_judge
	name = "Judge's helmet"
	desc = "Commonly used security headgear for the more theatrically inclined. Wear this in hostage situations to make everything worse."
	icon_state = "streetjudge_helmet"
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	species_restricted = list("Human", "Slime People", "Skeleton", "Nucleation", "Machine")

/obj/item/clothing/head/helmet/lightweighthelmet
	name = "lightweight helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "lightweighthelmet"
	item_state = "lightweighthelmet"
	flags_inv = HIDEHEADSETS
	strip_delay = 60
	flags = BLOCKHEADHAIR
	flags_cover = null
	dog_fashion = null
	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/helmet.dmi',
		"Drask" = 'icons/mob/clothing/species/drask/helmet.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/helmet.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)
