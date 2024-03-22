/**
	Ninja Chameleon Helper

	This component is used to rerender chameleon disguise on a ninja if icon rerendering occurs
 */
/datum/component/ninja_chameleon_helper
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// the suit reference
	var/obj/item/clothing/suit/space/space_ninja/my_suit

/datum/component/ninja_chameleon_helper/Initialize(ninja_suit)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	if(!istype(ninja_suit, /obj/item/clothing/suit/space/space_ninja))
		return COMPONENT_INCOMPATIBLE
	my_suit = ninja_suit

/datum/component/ninja_chameleon_helper/RegisterWithParent()
	RegisterSignal(parent, COMSIG_HUMAN_APPLY_OVERLAY, PROC_REF(restart_chameleon))


/datum/component/ninja_chameleon_helper/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_HUMAN_APPLY_OVERLAY)

/datum/component/ninja_chameleon_helper/proc/restart_chameleon()
	if(my_suit.disguise_active)
		my_suit.toggle_chameleon(FALSE)
