/**
 * Two Handed Component
 *
 * When applied to an item it will make it two handed
 *
 */
/datum/component/two_handed
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS // Only one of the component can exist on an item
	/// Are we holding the two handed item properly
	var/wielded = FALSE
	/// The multiplier applied to force when wielded, does not work with force_wielded, and force_unwielded
	var/force_multiplier = 0
	/// The force of the item when weilded
	var/force_wielded = 0
	/// The force of the item when unweilded
	var/force_unwielded = 0
	/// Item will be sharp only when wielded
	var/sharp_when_wielded = FALSE
	/// Play sound when wielded
	var/wieldsound = FALSE
	/// Play sound when unwielded
	var/unwieldsound = FALSE
	/// Play sound on attack when wielded
	var/attacksound = FALSE
	/// Does it have to be held in both hands
	var/require_twohands = FALSE
	/// The icon that will be used when wielded
	var/icon_wielded = FALSE
	/// Reference to the offhand created for the item
	var/obj/item/twohanded/offhand/offhand_item = null
	/// A callback on the parent to be called when the item is wielded
	var/datum/callback/wield_callback
	/// A callback on the parent to be called when the item is unwielded
	var/datum/callback/unwield_callback
	/// To prevent message spamming
	var/antispam_timer = 0


/**
 * Two Handed component
 *
 * Arguments:
 * * require_twohands (optional) Does the item need both hands to be carried
 * * wieldsound (optional) The sound to play when wielded
 * * unwieldsound (optional) The sound to play when unwielded
 * * attacksound (optional) The sound to play when wielded and attacking
 * * force_multiplier (optional) The force multiplier when wielded, do not use with force_wielded, and force_unwielded
 * * force_wielded (optional) The force setting when the item is wielded, do not use with force_multiplier
 * * force_unwielded (optional) The force setting when the item is unwielded, do not use with force_multiplier
 * * icon_wielded (optional) The icon to be used when wielded
 */
/datum/component/two_handed/Initialize(require_twohands=FALSE, wieldsound=FALSE, unwieldsound=FALSE, attacksound=FALSE, \
										force_multiplier=0, force_wielded=0, force_unwielded=0, sharp_when_wielded = FALSE, \
										icon_wielded=FALSE, datum/callback/wield_callback, datum/callback/unwield_callback)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.require_twohands = require_twohands
	src.wieldsound = wieldsound
	src.unwieldsound = unwieldsound
	src.attacksound = attacksound
	src.force_multiplier = force_multiplier
	src.force_wielded = force_wielded
	src.force_unwielded = force_unwielded
	src.sharp_when_wielded = sharp_when_wielded
	src.icon_wielded = icon_wielded
	src.wield_callback = wield_callback
	src.unwield_callback = unwield_callback

	if(require_twohands)
		ADD_TRAIT(parent, TRAIT_NEEDS_TWO_HANDS, ABSTRACT_ITEM_TRAIT)


// Inherit the new values passed to the component
/datum/component/two_handed/InheritComponent(datum/component/two_handed/new_comp, original, require_twohands, wieldsound, unwieldsound, \
											force_multiplier, force_wielded, force_unwielded, sharp_when_wielded, icon_wielded, \
											datum/callback/wield_callback, datum/callback/unwield_callback)
	if(!original)
		return
	if(require_twohands)
		src.require_twohands = require_twohands
	if(wieldsound)
		src.wieldsound = wieldsound
	if(unwieldsound)
		src.unwieldsound = unwieldsound
	if(attacksound)
		src.attacksound = attacksound
	if(force_multiplier)
		src.force_multiplier = force_multiplier
	if(force_wielded)
		src.force_wielded = force_wielded
	if(force_unwielded)
		src.force_unwielded = force_unwielded
	if(sharp_when_wielded)
		src.sharp_when_wielded = sharp_when_wielded
	if(icon_wielded)
		src.icon_wielded = icon_wielded
	if(wield_callback)
		src.wield_callback = wield_callback
	if(unwield_callback)
		src.unwield_callback = unwield_callback


// register signals withthe parent item
/datum/component/two_handed/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_attack_self))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(on_attack))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_ICON, PROC_REF(on_update_icon))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))


// Remove all siginals registered to the parent item
/datum/component/two_handed/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED,
								COMSIG_ITEM_DROPPED,
								COMSIG_ITEM_ATTACK_SELF,
								COMSIG_ITEM_ATTACK,
								COMSIG_ATOM_UPDATE_ICON,
								COMSIG_MOVABLE_MOVED))


/// Triggered on equip of the item containing the component
/datum/component/two_handed/proc/on_equip(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	if(require_twohands && (slot == slot_l_hand || slot == slot_r_hand)) // force equip the item
		wield(user)
	if(!require_twohands && wielded && !user.is_in_hands(parent))
		unwield(user)


/// Triggered on drop of item containing the component and its offhand part
/datum/component/two_handed/proc/on_drop(datum/source, mob/user)
	SIGNAL_HANDLER

	if(require_twohands) //Don't let the item fall to the ground and cause bugs if it's actually being equipped on another slot.
		unwield(user, FALSE, FALSE)
	if(wielded)
		unwield(user)
	if(source == offhand_item && !QDELETED(source))
		offhand_item = null
		qdel(source)


/// Triggered on destroy of the component's offhand
/datum/component/two_handed/proc/on_destroy(datum/source)
	SIGNAL_HANDLER

	offhand_item = null


/// Triggered on attack self of the item containing the component
/datum/component/two_handed/proc/on_attack_self(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!require_twohands)
		if(wielded)
			unwield(user)
		else if(user.is_in_hands(parent))
			wield(user)


/**
 * Wield the two handed item in both hands
 *
 * Arguments:
 * * user The mob/living/carbon that is wielding the item
 */
/datum/component/two_handed/proc/wield(mob/living/carbon/user)
	SIGNAL_HANDLER

	var/obj/item/check = parent
	var/abstract_check = !(check.flags & ABSTRACT)
	if(wielded)
		return

	if(issmall(user))
		if(require_twohands)
			if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
				antispam_timer = world.time
				to_chat(user, span_warning("[parent] слишком тяжел и громоздок для Вас!"))
			user.drop_item_ground(parent, force = TRUE)
		else
			if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
				antispam_timer = world.time
				to_chat(user, span_warning("Ваши руки для этого не приспособлены."))
		return

	if(user.get_inactive_hand())
		if(require_twohands)
			if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
				antispam_timer = world.time
				to_chat(user, span_warning("[parent] слишком громоздок, чтобы носить в одной руке!"))
			user.drop_item_ground(parent, force = TRUE)
		else
			if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
				antispam_timer = world.time
				to_chat(user, span_warning("Вторая рука должна быть свободна!"))
		return

	if(user.l_arm_broken() || user.r_arm_broken())
		if(require_twohands)
			user.drop_item_ground(parent, force = TRUE)
		if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
			antispam_timer = world.time
			to_chat(user, span_warning("Вы чувствуете как двигаются кости, когда пытаетесь взять [parent] в обе руки."))
		return

	if(!user.has_left_hand() || !user.has_right_hand())
		if(require_twohands)
			user.drop_item_ground(parent, force = TRUE)
		if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
			antispam_timer = world.time
			to_chat(user, span_warning("У Вас отсутствует вторая рука!"))
		return

	// wield update status
	if(SEND_SIGNAL(parent, COMSIG_TWOHANDED_WIELD, user) & COMPONENT_TWOHANDED_BLOCK_WIELD)
		return // blocked wield from item

	wielded = TRUE

	//Dont ask
	var/obj/item/twohanded/item = parent
	if(istype(item))
		item.wielded = TRUE

	ADD_TRAIT(parent, TRAIT_WIELDED, src)
	RegisterSignal(user, COMSIG_MOB_SWAPPING_HANDS, PROC_REF(on_swapping_hands))
	wield_callback?.Invoke(parent, user)

	// update item stats and name
	var/obj/item/parent_item = parent
	if(force_multiplier)
		parent_item.force *= force_multiplier
	else if(force_wielded)
		parent_item.force = force_wielded
	var/datum/component/sharpening/sharpening = item.GetComponent(/datum/component/sharpening)
	if(sharpening)
		parent_item.force += sharpening.damage_increase
	if(sharp_when_wielded)
		parent_item.sharp = TRUE

	var/original_name = parent_item.name
	parent_item.name = "[original_name] (Wielded)"
	parent_item.update_appearance()
	if(user)
		user.update_inv_hands()

	if(isrobot(user))
		if(world.time > antispam_timer + 0.1 SECONDS)
			antispam_timer = world.time
			to_chat(user, span_notice("Вы сконцентировались на поддержании [original_name]."))
	else
		if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
			antispam_timer = world.time
			to_chat(user, span_notice("Вы взяли [original_name] в обе руки."))

	// Play sound if one is set
	if(wieldsound)
		playsound(parent_item.loc, wieldsound, 50, TRUE)

	// Let's reserve the other hand
	offhand_item = new(user)
	offhand_item.name = "[original_name] - offhand"
	offhand_item.desc = "Your second grip on [original_name]."
	offhand_item.wielded = TRUE
	RegisterSignal(offhand_item, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(offhand_item, COMSIG_PARENT_QDELETING, PROC_REF(on_destroy))
	user.put_in_inactive_hand(offhand_item)


/**
 * Unwield the two handed item
 *
 * Arguments:
 * * user The mob/living/carbon that is unwielding the item
 * * show_message (option) show a message to chat on unwield
 * * can_drop (option) whether 'drop_item_ground' can be called or not.
 */
/datum/component/two_handed/proc/unwield(mob/living/carbon/user, show_message = TRUE, can_drop = TRUE)
	SIGNAL_HANDLER

	if(!wielded)
		return

	//Dont ask
	var/obj/item/twohanded/item = parent
	if(istype(item))
		item.wielded = FALSE

	// wield update status
	wielded = FALSE
	UnregisterSignal(user, COMSIG_MOB_SWAPPING_HANDS)
	SEND_SIGNAL(parent, COMSIG_TWOHANDED_UNWIELD, user)
	REMOVE_TRAIT(parent, TRAIT_WIELDED, src)
	unwield_callback?.Invoke(parent, user)

	// update item stats
	var/obj/item/parent_item = parent
	var/datum/component/sharpening/sharpening = item.GetComponent(/datum/component/sharpening)
	if(sharpening)
		parent_item.force -= sharpening.damage_increase
	if(force_multiplier)
		parent_item.force /= force_multiplier
	else
		parent_item.force = force_unwielded
	if(sharp_when_wielded)
		parent_item.sharp = FALSE

	// update the items name to remove the wielded status
	var/sf = findtext(parent_item.name, " (Wielded)", -10) // 10 == length(" (Wielded)")
	if(sf)
		parent_item.name = copytext(parent_item.name, 1, sf)
	else
		parent_item.name = "[initial(parent_item.name)]"

	// Update icons
	parent_item.update_appearance()

	if(istype(user)) // tk showed that we might not have a mob here
		user.update_inv_hands()

		// if the item requires two handed drop the item on unwield
		if(require_twohands && can_drop)
			user.drop_item_ground(parent_item, force = TRUE)

		// Show message if requested
		if(show_message)
			var/abstract_check = !(item.flags & ABSTRACT)
			if(isrobot(parent))
				to_chat(user, span_notice("Вы снизили нагрузку на [parent_item]."))
			else
				if(require_twohands || parent_item.loc != user)
					if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
						antispam_timer = world.time
						to_chat(user, span_notice("Вы уронили [parent_item]."))
				if(parent_item.loc == user && user.is_in_hands(parent_item))
					if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
						antispam_timer = world.time
						to_chat(user, span_notice("Теперь вы держите [parent_item] одной рукой."))
				if(parent_item.loc == user && !user.is_in_hands(parent_item))
					if(abstract_check && (world.time > antispam_timer + 0.1 SECONDS))
						antispam_timer = world.time
						to_chat(user, span_notice("Вы экипировали [parent_item]."))

	// Play sound if set
	if(unwieldsound)
		playsound(parent_item.loc, unwieldsound, 50, TRUE)

	// Remove the object in the offhand
	if(offhand_item)
		UnregisterSignal(offhand_item, list(COMSIG_ITEM_DROPPED, COMSIG_PARENT_QDELETING))
		qdel(offhand_item)
	// Clear any old refrence to an item that should be gone now
	offhand_item = null


/**
 * on_attack triggers on attack with the parent item
 */
/datum/component/two_handed/proc/on_attack(obj/item/source, mob/living/target, mob/living/user)
	SIGNAL_HANDLER

	if(wielded && attacksound)
		//var/obj/item/parent_item = parent
		playsound(source.loc, attacksound, 50, TRUE)


/**
 * on_update_icon triggers on call to update parent items icon
 *
 * Updates the icon using icon_wielded if set
 */
/datum/component/two_handed/proc/on_update_icon(obj/item/source)
	SIGNAL_HANDLER

	if(!wielded)
		return NONE
	if(!icon_wielded)
		return NONE
	source.icon_state = icon_wielded
	return COMSIG_ATOM_NO_UPDATE_ICON_STATE


/**
 * on_moved Triggers on item moved
 */
/datum/component/two_handed/proc/on_moved(datum/source, mob/user, dir)
	SIGNAL_HANDLER

	unwield(user, can_drop = FALSE)


/**
 * on_swap_hands Triggers on swapping hands, blocks swap if the other hand is busy
 */
/datum/component/two_handed/proc/on_swapping_hands(mob/user, obj/item/held_item)
	SIGNAL_HANDLER

	if(!held_item)
		return
	if(held_item == parent)
		return COMPONENT_BLOCK_SWAP


/**
 * The offhand dummy item for two handed items
 *
 */
/obj/item/twohanded/offhand
	name = "offhand"
	icon = 'icons/obj/items.dmi'
	icon_state = "offhand"
	w_class = WEIGHT_CLASS_HUGE
	flags = ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	wielded = FALSE // Off Hand tracking of wielded status

/obj/item/twohanded/offhand/Initialize(mapload)
	. = ..()
	flags |= NODROP

/obj/item/twohanded/offhand/Destroy()
	wielded = FALSE
	return ..()

/obj/item/twohanded/offhand/equipped(mob/user, slot)
	. = ..()
	if(wielded && !user.is_in_hands(src) && !QDELETED(src))
		qdel(src)
