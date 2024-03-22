/////////////////////////////////////////
/////////////////Mining//////////////////
/////////////////////////////////////////
/datum/design/drill
	name = "Mining Drill"
	desc = "Yours is the drill that will pierce through the rock walls."
	id = "drill"
	req_tech = list("materials" = 2, "powerstorage" = 2, "engineering" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 6000, MAT_GLASS = 1000)
	build_path = /obj/item/pickaxe/drill
	category = list("Mining")

/datum/design/drill_diamond
	name = "Diamond Mining Drill"
	desc = "Yours is the drill that will pierce the heavens!"
	id = "drill_diamond"
	req_tech = list("materials" = 6, "powerstorage" = 5, "engineering" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000, MAT_GLASS = 1000, MAT_DIAMOND = 2000) //Yes, a whole diamond is needed.
	build_path = /obj/item/pickaxe/drill/diamonddrill
	category = list("Mining")


/datum/design/plasmacutter_adv
	name = "Advanced Plasma Cutter"
	desc = "It's an advanced plasma cutter, oh my god."
	id = "plasmacutter_adv"
	req_tech = list("materials" = 5, "plasmatech" = 6, "engineering" = 6, "combat" = 3, "magnets" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000, MAT_GLASS = 1000, MAT_PLASMA = 2000, MAT_GOLD = 500)
	build_path = /obj/item/gun/energy/plasmacutter/adv
	category = list("Mining")

/datum/design/plasmacutter_shotgun
	name = "Plasma Cutter Shotgun"
	desc = "An industrial-grade heavy-duty mining shotgun."
	id = "plasmacutter_shotgun"
	req_tech = list("materials" = 7, "powerstorage" = 5, "plasmatech" = 7, "engineering" = 7, "combat" = 6, "magnets" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 6000, MAT_GLASS = 2000, MAT_PLASMA = 2000, MAT_GOLD = 2000, MAT_DIAMOND = 3000)
	build_path = /obj/item/gun/energy/plasmacutter/shotgun
	category = list("Mining")

/datum/design/jackhammer
	name = "Sonic Jackhammer"
	desc = "Essentially a handheld planet-cracker. Can drill through walls with ease as well."
	id = "jackhammer"
	req_tech = list("materials" = 7, "powerstorage" = 5, "engineering" = 6, "magnets" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 6000, MAT_GLASS = 2000, MAT_SILVER = 2000, MAT_DIAMOND = 6000)
	build_path = /obj/item/pickaxe/drill/jackhammer
	category = list("Mining")

/datum/design/superresonator
	name = "Upgraded Resonator"
	desc = "An upgraded version of the resonator that allows more fields to be active at once."
	id = "superresonator"
	req_tech = list("materials" = 4, "powerstorage" = 3, "engineering" = 3, "magnets" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 4000, MAT_GLASS = 1500, MAT_SILVER = 1000, MAT_URANIUM = 1000)
	build_path = /obj/item/resonator/upgraded
	category = list("Mining")

/datum/design/trigger_guard_mod
	name = "Kinetic Accelerator Trigger Guard Mod"
	desc = "A device which allows kinetic accelerators to be wielded by any organism."
	id = "triggermod"
	req_tech = list("materials" = 5, "powerstorage" = 4, "engineering" = 4, "magnets" = 4, "combat" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 1500, MAT_GOLD = 1500, MAT_URANIUM = 1000)
	build_path = /obj/item/borg/upgrade/modkit/trigger_guard
	category = list("Mining")

/datum/design/aoe_turf_mod
	name = "Kinetic Accelerator Mining AoE Mod"
	desc = "A modification kit for Kinetic Accelerators which causes it to fire AoE blasts that destroy rock."
	id = "hypermod"
	req_tech = list("materials" = 7, "powerstorage" = 5, "engineering" = 5, "magnets" = 5, "combat" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 8000, MAT_GLASS = 1500, MAT_SILVER = 2000, MAT_GOLD = 2000, MAT_DIAMOND = 2000)
	build_path = /obj/item/borg/upgrade/modkit/aoe/turfs
	category = list("Mining")

/datum/design/kineticexperimental
	name = "Experimental Kinetic Accelerator"
	desc = "A modified version of the proto-kinetic accelerator, with twice the modkit space of the standard version."
	id = "expkinac"
	req_tech = list("materials" = 4, "powerstorage" = 4, "engineering" = 6, "combat" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_TITANIUM = 8000, MAT_BLUESPACE = 1000, MAT_DIAMOND = 2000, )
	build_path = /obj/item/gun/energy/kinetic_accelerator/experimental
	category = list("Mining")

/datum/design/f_rods
	name = "Fireproof Rods"
	desc = "Iron (x2) + Plasma + Titanium"
	id = "f_rods"
	req_tech = list("materials" = 6, "engineering" = 3, "plasmatech" = 4)
	build_type = PROTOLATHE | SMELTER
	materials = list(MAT_METAL = 2000, MAT_PLASMA = 500, MAT_TITANIUM = 1000)
	build_path = /obj/item/stack/fireproof_rods
	category = list("Mining")

/datum/design/mining_charge
	name = "Experimental Mining Charge"
	desc = "An experimental mining charge"
	id = "megacharge"
	req_tech = list("materials" = 5, "engineering" = 5, "plasmatech" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 4000, MAT_PLASMA = 6000, MAT_URANIUM = 1000)
	build_path = /obj/item/grenade/plastic/miningcharge/mega
	category = list("Mining")
