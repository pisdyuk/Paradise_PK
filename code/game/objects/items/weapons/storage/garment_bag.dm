/*	This is for Heads and some miscjobs clothes in closets
 *	In fact this is kinda TG or other bild thing
 *	But i dont have it code in original, so ive made it self
 *	All clothes stolen from /obj/structure/closet/secure_closet
*/

/obj/item/storage/garmentbag
	name = "Garmentbag"
	desc = "This is where all your clothes are stored."
	icon_state = "garment_bag"
	lefthand_file = 'icons/mob/inhands/clothing_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing_righthand.dmi'
	w_class = WEIGHT_CLASS_GIGANTIC	//so you cant put this bag in other bag
	max_combined_w_class = 63	//3*21
	storage_slots = 21	//based on captains stuff
	can_hold = list(					//no gloves, glasses, accessory, masks and suits
		/obj/item/clothing/head,		//thats made to restrict players with abusing this bag(HighRisk stuff)
		/obj/item/clothing/neck,		//reactive armor, krav maga
		/obj/item/clothing/under,
		/obj/item/clothing/shoes,
		/obj/item/clothing/suit/captunic,	//captains
		/obj/item/clothing/suit/hop_jacket,	//hop
		/obj/item/clothing/suit/storage,
		/obj/item/clothing/suit/armor/vest,
		/obj/item/clothing/suit/armor/hos,	//hos
		/obj/item/clothing/accessory/black,	//detective
		/obj/item/clothing/accessory/blue,	//blueshield
		/obj/item/clothing/accessory/red,
		/obj/item/clothing/accessory/scarf,
		/obj/item/clothing/accessory/armband,
		/obj/item/clothing/gloves/color/white,	// ntrep, magistrare
		/obj/item/clothing/suit/judgerobe,
		/obj/item/clothing/gloves/color/latex,	//RD, CMO
		/obj/item/clothing/suit/bio_suit,
		/obj/item/clothing/gloves/fingerless,	//QM
		/obj/item/clothing/suit/fire,
		/obj/item/clothing/suit/hooded,	//chaplain
		/obj/item/clothing/suit/witchhunter,
		/obj/item/clothing/suit/holidaypriest,
		/obj/item/clothing/suit/armor/riot/knight
	)

/obj/item/storage/garmentbag/captains/populate_contents()
	new /obj/item/clothing/head/caphat/parade(src)
	new /obj/item/clothing/head/caphat/blue(src)
	new /obj/item/clothing/head/caphat/office(src)
	new /obj/item/clothing/head/caphat/beret(src)
	new /obj/item/clothing/neck/mantle/captain(src)
	new /obj/item/clothing/neck/cloak/captain(src)
	new /obj/item/clothing/suit/captunic(src)
	new /obj/item/clothing/suit/captunic/coat(src)
	new /obj/item/clothing/suit/captunic/parade(src)
	new /obj/item/clothing/suit/captunic/parade/alt(src)
	new /obj/item/clothing/suit/captunic/bomber(src)
	new /obj/item/clothing/suit/captunic/jacket(src)
	new /obj/item/clothing/suit/armor/vest/capcarapace/alt(src)
	new /obj/item/clothing/under/captainparade(src)
	new /obj/item/clothing/under/rank/captain(src)
	new /obj/item/clothing/under/dress/dress_cap(src)
	new /obj/item/clothing/under/captainparade/alt(src)
	new /obj/item/clothing/under/captainparade/dress(src)
	new /obj/item/clothing/under/captainparade/office(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/shoes/laceup/cap(src)
	new /obj/item/clothing/suit/hooded/wintercoat/captain(src)

/obj/item/storage/garmentbag/hop/populate_contents()
	new /obj/item/clothing/head/hopcap(src)
	new /obj/item/clothing/neck/mantle/head_of_personnel(src)
	new /obj/item/clothing/neck/cloak/head_of_personnel(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/suit/hop_jacket(src)
	new /obj/item/clothing/suit/hop_jacket/female(src)
	new /obj/item/clothing/under/dress/dress_hr(src)
	new /obj/item/clothing/under/lawyer/female(src)
	new /obj/item/clothing/under/lawyer/black(src)
	new /obj/item/clothing/under/lawyer/red(src)
	new /obj/item/clothing/under/lawyer/oldman(src)
	new /obj/item/clothing/under/rank/head_of_personnel_whimsy(src)
	new /obj/item/clothing/under/rank/head_of_personnel_alt(src)
	new /obj/item/clothing/under/rank/head_of_personnel_f(src)
	new /obj/item/clothing/shoes/leather(src)	//added here deleted on maps
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/suit/hooded/wintercoat/hop(src)

/obj/item/storage/garmentbag/hos/populate_contents()
	new /obj/item/clothing/head/HoS(src)
	new /obj/item/clothing/head/HoS/beret(src)
	new /obj/item/clothing/suit/armor/hos(src)
	new /obj/item/clothing/suit/armor/hos/alt(src)
	new /obj/item/clothing/neck/mantle/head_of_security(src)
	new /obj/item/clothing/neck/cloak/head_of_security(src)
	new /obj/item/clothing/under/rank/head_of_security(src)
	new /obj/item/clothing/under/rank/head_of_security/formal(src)
	new /obj/item/clothing/under/rank/head_of_security/corp(src)
	new /obj/item/clothing/under/rank/head_of_security/skirt(src)
	new /obj/item/clothing/under/rank/head_of_security/alt(src)
	new /obj/item/clothing/suit/hooded/wintercoat/security/hos(src)
	new /obj/item/clothing/under/rank/head_of_security/alt/skirt(src)
	new /obj/item/clothing/under/rank/head_of_security/paradef(src)

/obj/item/storage/garmentbag/warden/populate_contents()
	new /obj/item/clothing/head/warden(src)
	new /obj/item/clothing/head/beret/sec/warden(src)
	new /obj/item/clothing/suit/armor/vest/warden/alt(src)
	new /obj/item/clothing/suit/armor/vest/warden(src)
	new /obj/item/clothing/under/rank/warden(src)
	new /obj/item/clothing/under/rank/warden/formal(src)
	new /obj/item/clothing/under/rank/warden/corp(src)
	new /obj/item/clothing/under/rank/warden/skirt(src)

/obj/item/storage/garmentbag/blueshield/populate_contents()
	new /obj/item/clothing/head/beret/centcom/officer(src)
	new /obj/item/clothing/head/beret/centcom/officer/navy(src)
	new /obj/item/clothing/neck/cloak/blueshield(src)
	new /obj/item/clothing/suit/armor/vest/blueshield(src)
	new /obj/item/clothing/suit/storage/blueshield(src)
	new /obj/item/clothing/under/rank/centcom/blueshield(src)
	new /obj/item/clothing/under/fluff/jay_turtleneck(src)
	new /obj/item/clothing/shoes/centcom(src)
	new /obj/item/clothing/shoes/jackboots/jacksandals(src)
	new /obj/item/clothing/accessory/blue(src)
	new /obj/item/clothing/under/rank/blueshield/skirt(src)

/obj/item/storage/garmentbag/ntrep/populate_contents()
	new /obj/item/clothing/head/ntrep(src)
	new /obj/item/clothing/neck/cloak/nanotrasen_representative(src)
	new /obj/item/clothing/under/lawyer/oldman(src)
	new /obj/item/clothing/under/lawyer/black(src)
	new /obj/item/clothing/under/lawyer/female(src)
	new /obj/item/clothing/under/rank/centcom/representative(src)
	new /obj/item/clothing/gloves/color/white(src)
	new /obj/item/clothing/shoes/sandal/fancy(src)
	new /obj/item/clothing/shoes/centcom(src)
	new /obj/item/clothing/under/rank/ntrep/skirt(src)
	new /obj/item/clothing/accessory/ntrjacket(src)

/obj/item/storage/garmentbag/detective/populate_contents()
	new /obj/item/clothing/head/det_hat(src)
	new /obj/item/clothing/head/det_hat/black(src)
	new /obj/item/clothing/head/det_hat/brown(src)
	new /obj/item/clothing/head/det_hat/grey(src)
	new /obj/item/clothing/suit/storage/det_suit(src)
	new /obj/item/clothing/suit/storage/det_suit/black(src)
	new /obj/item/clothing/suit/storage/det_suit/forensics/blue(src)
	new /obj/item/clothing/suit/storage/det_suit/forensics/red(src)
	new /obj/item/clothing/suit/storage/det_suit/forensics/blaser(src)
	new /obj/item/clothing/suit/storage/det_suit/forensics/blaser/brown(src)
	new /obj/item/clothing/suit/storage/det_suit/forensics/blaser/grey(src)
	new /obj/item/clothing/suit/armor/vest/det_suit(src)
	new /obj/item/clothing/under/det(src)
	new /obj/item/clothing/under/det/skirt(src)
	new /obj/item/clothing/under/det/alt_a(src)
	new /obj/item/clothing/under/det/alt_a/skirt(src)
	new /obj/item/clothing/under/det/alt_b(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/accessory/black(src)
	new /obj/item/clothing/suit/suspenders(src)
	new /obj/item/clothing/suit/wcoat(src)
	new /obj/item/clothing/accessory/blue(src)
	new /obj/item/clothing/accessory/red(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/under/det/noir(src)
	new /obj/item/clothing/under/det/noir/skirt(src)

/obj/item/storage/garmentbag/magistrate/populate_contents()
	new /obj/item/clothing/head/powdered_wig(src)
	new /obj/item/clothing/head/justice_wig(src)
	new /obj/item/clothing/suit/judgerobe(src)
	new /obj/item/clothing/under/suit_jacket/really_black(src)
	new /obj/item/clothing/under/rank/centcom/magistrate(src)
	new /obj/item/clothing/gloves/color/white(src)
	new /obj/item/clothing/shoes/centcom(src)

/obj/item/storage/garmentbag/RD/populate_contents()
	new /obj/item/clothing/head/bio_hood/scientist(src)
	new /obj/item/clothing/head/beret/purple/rd(src)
	new /obj/item/clothing/neck/mantle/research_director(src)
	new /obj/item/clothing/neck/cloak/research_director(src)
	new /obj/item/clothing/suit/bio_suit/scientist(src)
	new /obj/item/clothing/suit/storage/labcoat(src)
	new /obj/item/clothing/under/rank/research_director(src)
	new /obj/item/clothing/gloves/color/latex(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/suit/hooded/wintercoat/medical/science/rd(src)

/obj/item/storage/garmentbag/CMO/populate_contents()
	new /obj/item/clothing/head/bio_hood/cmo(src)
	new /obj/item/clothing/head/beret/elo(src)
	new /obj/item/clothing/neck/mantle/chief_medical_officer(src)
	new /obj/item/clothing/neck/cloak/chief_medical_officer(src)
	new /obj/item/clothing/suit/bio_suit/cmo(src)
	new /obj/item/clothing/suit/storage/labcoat/cmo(src)
	new /obj/item/clothing/under/rank/chief_medical_officer(src)
	new /obj/item/clothing/gloves/color/latex/nitrile(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/suit/hooded/wintercoat/medical/cmo(src)

/obj/item/storage/garmentbag/engineering_chief/populate_contents()
	new /obj/item/clothing/head/beret/ce(src)
	new /obj/item/clothing/head/beret/eng(src)
	new /obj/item/clothing/head/hardhat/white(src)
	new /obj/item/clothing/neck/mantle/chief_engineer(src)
	new /obj/item/clothing/neck/cloak/chief_engineer/white(src)
	new /obj/item/clothing/neck/cloak/chief_engineer(src)
	new /obj/item/clothing/suit/storage/hazardvest(src)
	new /obj/item/clothing/under/rank/chief_engineer(src)
	new /obj/item/clothing/under/rank/chief_engineer/skirt(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/suit/hooded/wintercoat/engineering/ce(src)

/obj/item/storage/garmentbag/chaplain/populate_contents()
	new /obj/item/clothing/head/bishopmitre(src)
	new /obj/item/clothing/head/blackbishopmitre(src)
	new /obj/item/clothing/head/witchhunter_hat(src)
	new /obj/item/clothing/head/helmet/riot/knight/templar(src)
	new /obj/item/clothing/neck/cloak/bishopblack(src)
	new /obj/item/clothing/neck/cloak/bishop(src)
	new /obj/item/clothing/suit/hooded/nun(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/monk(src)
	new /obj/item/clothing/suit/witchhunter(src)
	new /obj/item/clothing/suit/holidaypriest(src)
	new /obj/item/clothing/suit/armor/riot/knight/templar(src)
	new /obj/item/clothing/under/wedding/bride_white(src)
	new /obj/item/clothing/under/rank/chaplain(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/under/rank/chaplain/skirt(src)

/obj/item/storage/garmentbag/quartermaster/populate_contents()
	new /obj/item/clothing/head/soft(src)
	new /obj/item/clothing/neck/cloak/quartermaster(src)
	new /obj/item/clothing/suit/fire/firefighter(src)
	new /obj/item/clothing/suit/storage/qm(src)
	new /obj/item/clothing/under/rank/cargo(src)
	new /obj/item/clothing/under/rank/cargo/skirt(src)
	new /obj/item/clothing/under/rank/cargo/official(src)
	new /obj/item/clothing/gloves/fingerless(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/suit/hooded/wintercoat/cargo/qm(src)
	new /obj/item/clothing/under/rank/cargo/alt(src)
