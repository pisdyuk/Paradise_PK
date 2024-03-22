/obj/item/clothing/suit/space/hardsuit
	var/obj/item/hardsuit_taser_proof/taser_proof = null

/obj/item/clothing/suit/space/hardsuit/Initialize(mapload)
	. = ..()
	if(taser_proof && ispath(taser_proof))
		taser_proof = new taser_proof(src)
		taser_proof.hardsuit = src

/obj/item/clothing/suit/space/hardsuit/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/hardsuit_taser_proof))
		var/obj/item/hardsuit_taser_proof/new_taser_proof = I
		if(taser_proof)
			to_chat(user, "<span class='warning'>[src] already has a taser proof.</span>")
			return
		if(src == user.get_item_by_slot(slot_wear_suit)) //Make sure the player is not wearing the suit before applying the upgrade.
			to_chat(user, "<span class='warning'>You cannot install the upgrade to [src] while wearing it.</span>")
			return
		if(user.drop_transfer_item_to_loc(new_taser_proof, src))
			taser_proof = new_taser_proof
			taser_proof.hardsuit = src
			to_chat(user, "<span class='notice'>You successfully install the taser proof upgrade into [src].</span>")
			return

/obj/item/clothing/suit/space/hardsuit/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(taser_proof)
		var/blocked = taser_proof.hit_reaction(owner, hitby, attack_text, final_block_chance, damage, attack_type)
		if(blocked)
			return TRUE
	. = ..()

//////Taser-proof Hardsuits

/obj/item/clothing/suit/space/hardsuit/deathsquad
	taser_proof = /obj/item/hardsuit_taser_proof/ert_locked
