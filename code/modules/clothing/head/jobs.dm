
//Bartender
/obj/item/clothing/head/chefhat
	name = "chef's hat"
	desc = "It's a hat used by chefs to keep hair out of your food. Judging by the food in the mess, they don't work."
	icon_state = "chef"
	item_state = "chef"
	desc = "The commander in chef's head wear."
	strip_delay = 10
	put_on_delay = 10
	dog_fashion = /datum/dog_fashion/head/chef

//Captain
/obj/item/clothing/head/caphat
	name = "captain's hat"
	icon_state = "captain"
	desc = "It's good being the king."
	item_state = "caphat"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	strip_delay = 60
	dog_fashion = /datum/dog_fashion/head/captain

//Captain: no longer space-worthy
/obj/item/clothing/head/caphat/parade
	name = "captain's parade cap"
	desc = "Worn only by Captains with an abundance of class."
	icon_state = "capcap"
	item_state = "capcap"
	dog_fashion = null

/obj/item/clothing/head/caphat/blue
	icon_state = "cap_parade_alt"
	item_state = "cap_parade_alt"
	dog_fashion = null

/obj/item/clothing/head/caphat/office
	icon_state = "cap_office"
	item_state = "cap_office"
	dog_fashion = null

/obj/item/clothing/head/caphat/beret
	name = "captain's beret"
	icon_state = "cap_beret"
	item_state = "cap_beret"

//Head of Personnel
/obj/item/clothing/head/hopcap
	name = "head of personnel's cap"
	icon_state = "hopcap"
	desc = "The symbol of true bureaucratic micromanagement."
	armor = list("melee" = 25, "bullet" = 15, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	dog_fashion = /datum/dog_fashion/head/hop

//Nanotrasen Representative
/obj/item/clothing/head/ntrep
	name = "Nanotrasen Representative's hat"
	desc = "A cap issued to Nanotrasen Representatives."
	icon_state = "ntrep"

//Research Director
/obj/item/clothing/head/beret/purple
	name = "scientist beret"
	desc = "For science!"
	icon_state = "beret_purple"
	item_state = "purpleberet"

/obj/item/clothing/head/beret/purple/rd
	name = "research director's beret"
	desc = "A purple beret, with a small golden crescent moon sewn onto it. Smells like plasma."

//Chaplain
/obj/item/clothing/head/hooded/chaplain_hood
	name = "chaplain's hood"
	desc = "It's hood that covers the head. It keeps you warm during the space winters."
	icon_state = "chaplain_hood"
	flags = BLOCKHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/hooded/chaplain_hood/no_name
	name = "dark robe's hood"
	desc = "It's hood that covers the head. It keeps you warm during the space winters."
	icon_state = "chaplain_hood"
	flags = BLOCKHAIR
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDENAME

//Chaplain
/obj/item/clothing/head/hooded/nun_hood
	name = "nun hood"
	desc = "Maximum piety in this star system."
	icon_state = "nun_hood"
	flags = BLOCKHAIR
	flags_cover = HEADCOVERSEYES

//Chaplain
/obj/item/clothing/head/hooded/monk_hood
	name = "monk hood"
	desc = "Wooden board not included."
	icon_state = "monk_hood"
	flags = BLOCKHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/witchhunter_hat
	name = "witchhunter hat"
	desc = "This hat saw much use back in the day."
	icon_state = "witchhunterhat"
	item_state = "witchhunterhat"
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/bishopmitre
	name = "bishop mitre"
	desc = "An opulent hat that functions as a radio to God. Or as a lightning rod, depending on who you ask."
	icon_state = "bishopmitre"
	item_state = "bishopmitre"

/obj/item/clothing/head/blackbishopmitre
	name = "black bishop mitre"
	desc = "An opulent hat that functions as a radio to God. Or as a lightning rod, depending on who you ask."
	icon_state = "blackbishopmitre"
	item_state = "blackbishopmitre"

/obj/item/clothing/head/det_hat
	name = "hat"
	desc = "Someone who wears this will look very smart."
	icon_state = "detective"
	allowed = list(/obj/item/reagent_containers/food/snacks/candy/candy_corn, /obj/item/pen)
	armor = list("melee" = 25, "bullet" = 5, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 50)
	dog_fashion = /datum/dog_fashion/head/detective
	muhtar_fashion = /datum/muhtar_fashion/head/detective

	sprite_sheets = list(
		"Vox" = 'icons/mob/clothing/species/vox/head.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
	)

/obj/item/clothing/head/det_hat/black
	icon_state = "detective_coolhat_black"

/obj/item/clothing/head/det_hat/brown
	icon_state = "detective_coolhat_brown"

/obj/item/clothing/head/det_hat/grey
	icon_state = "detective_coolhat_grey"

//Mime
/obj/item/clothing/head/beret
	name = "beret"
	desc = "A beret, an artists favorite headwear."
	icon_state = "beret"
	dog_fashion = /datum/dog_fashion/head/beret

/obj/item/clothing/head/beret/durathread
	name = "durathread beret"
	desc =  "A beret made from durathread, its resilient fibres provide some protection to the wearer."
	icon_state = "beretdurathread"
	item_color = null
	armor = list("melee" = 15, "bullet" = 5, "laser" = 15, "energy" = 5, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 5)

//Security
/obj/item/clothing/head/HoS
	name = "head of security cap"
	desc = "The robust standard-issue cap of the Head of Security. For showing the officers who's in charge."
	icon_state = "hoscap"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 10, "rad" = 0, "fire" = 50, "acid" = 60)
	strip_delay = 80

/obj/item/clothing/head/HoS/beret
	name = "head of security beret"
	desc = "A robust beret for the Head of Security, for looking stylish while not sacrificing protection."
	icon_state = "beret_hos_black"
	snake_fashion = /datum/snake_fashion/head/beret_hos_black

/obj/item/clothing/head/warden
	name = "warden's police hat"
	desc = "It's a special armored hat issued to the Warden of a security force. Protects the head from impacts."
	icon_state = "policehelm"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 60)
	strip_delay = 60
	dog_fashion = /datum/dog_fashion/head/warden

/obj/item/clothing/head/officer
	name = "officer's cap"
	desc = "A red cap with an old-fashioned badge on the front for establishing that you are, in fact, the law."
	icon_state = "customshelm"
	item_state = "customshelm"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 50)
	strip_delay = 60

/obj/item/clothing/head/beret/sec
	name = "security beret"
	desc = "A beret with the security insignia emblazoned on it. For officers that are more inclined towards style than safety."
	icon_state = "beret_officer"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 50)
	strip_delay = 60
	dog_fashion = null
	muhtar_fashion = /datum/muhtar_fashion/head/beret

/obj/item/clothing/head/beret/sec/black
	name = "black security beret"
	desc = "A beret with the security insignia emblazoned on it. For officers that are more inclined towards style than safety."
	icon_state = "beret_officer_black"

/obj/item/clothing/head/beret/sec/warden
	name = "warden's beret"
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	icon_state = "beret_warden"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 50)

/obj/item/clothing/head/beret/brigphys
	name = "brigphys's beret"
	desc = "Берет медика службы безопасности"
	icon_state = "brigphysberet"

/obj/item/clothing/head/beret/eng
	name = "engineering beret"
	desc = "A beret with the engineering insignia emblazoned on it. For engineers that are more inclined towards style than safety."
	icon_state = "beret_engineering"

/obj/item/clothing/head/beret/atmos
	name = "atmospherics beret"
	desc = "A beret for those who have shown immaculate proficienty in piping. Or plumbing."
	icon_state = "beret_atmospherics"

/obj/item/clothing/head/beret/ce
	name = "chief engineer beret"
	desc = "A white beret with the engineering insignia emblazoned on it. Its owner knows what they're doing. Probably."
	icon_state = "beret_ce"

/obj/item/clothing/head/beret/sci
	name = "science beret"
	desc = "A purple beret with the science insignia emblazoned on it. It has that authentic burning plasma smell."
	icon_state = "beret_sci"

//Medical
/obj/item/clothing/head/beret/med
	name = "medical beret"
	desc = "A white beret with a green cross finely threaded into it. It has that sterile smell about it."
	icon_state = "beret_med"

//CMO
/obj/item/clothing/head/beret/elo
	name = "chief medical officer beret"
	desc = "Stylish beret of the Chief Medical Officer. You can smell a faint antiseptic smell coming from it."
	icon = 'icons/obj/custom_items.dmi'
	icon_state = "elo-beret"

/obj/item/clothing/head/surgery
	name = "surgical cap"
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs."
	icon_state = "surgcap_blue"
	flags = BLOCKHEADHAIR
	sprite_sheets = list(
		"Drask" = 'icons/mob/clothing/species/drask/head.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/head.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/head.dmi'
		)

/obj/item/clothing/head/surgery/purple
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs. This one is deep purple."
	icon_state = "surgcap_purple"

/obj/item/clothing/head/surgery/blue
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs. This one is baby blue."
	icon_state = "surgcap_blue"

/obj/item/clothing/head/surgery/green
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs. This one is dark green."
	icon_state = "surgcap_darkgreen"

/obj/item/clothing/head/surgery/lightgreen
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs. This one is green."
	icon_state = "surgcap_green"

/obj/item/clothing/head/surgery/black
	desc = "A cap coroners wear during autopsies. Keeps their hair from falling into the cadavers.  It is as dark than the coroner's humor."
	icon_state = "surgcap_black"

//SolGov
/obj/item/clothing/head/beret/solgov/command
	name = "\improper Trans-Solar Federation Lieutenant's beret"
	desc = "A beret worn by marines of the Trans-Solar Federation. The insignia signifies the wearer bears the rank of a Lieutenant."
	icon_state = "solgov_beret"
	dog_fashion = null
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 50)
	strip_delay = 80

/obj/item/clothing/head/beret/solgov/command/elite
	name = "\improper Trans-Solar Federation Specops Lieutenant's beret"
	desc = "A beret worn by marines of the Trans-Solar Federation Specops division. The insignia signifies the wearer bears the rank of a Lieutenant."
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 10, "rad" = 0, "fire" = 50, "acid" = 60)
	icon_state = "solgov_elite_beret"

//Culinary Artist
/obj/item/clothing/head/chefcap
	name = "chef's red cap"
	desc = "Red cap for people who want show who`s really boss of this kitchen"
	item_state = "redchefcap"
	icon_state = "redchefcap"
