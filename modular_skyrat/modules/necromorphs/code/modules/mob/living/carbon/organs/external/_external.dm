/****************************************************
				EXTERNAL ORGANS
****************************************************/
/obj/item/organ/external
	name = "external"
	dir = SOUTH
	//organ_tag = "limb"
	appearance_flags = PIXEL_SCALE

	var/mob/living/simple_animal/necromorph/divider_component/divider_component_type = /mob/living/simple_animal/necromorph/divider_component/arm
	var/min_broken_damage = 30        // Damage before becoming broken
	var/max_damage = 30               // Damage cap
	var/can_regrow = TRUE			  // If false, this organ cannot be regrown using regeneration effects, once severed or destroyed					//How much biomass this organ is worth to the marker.
	var/locomotion = FALSE	//If true, this organ is being used for the locomotion of its owner

	// Strings
	var/broken_description             // fracture string if any.
	var/damage_state = "00"            // Modifier used for generating the on-mob damage overlay for this limb.

	// Damage vars.
	var/brute_dam = 0                  // Actual current brute damage.
	var/brute_ratio = 0                // Ratio of current brute damage to max damage.
	var/burn_dam = 0                   // Actual current burn damage.
	var/burn_ratio = 0                 // Ratio of current burn damage to max damage.
	var/last_dam = -1                  // used in healing/processing calculations.
	var/pain = 0                       // How much the limb hurts.
	var/pain_disability_threshold      // Point at which a limb becomes unusable due to pain.
	var/defensive_group	= null	   // If set, this dictates which set of limbs will be used in an attempt to shield this bodypart from attack. Should only be set on core parts, not limbs
	var/block_reduction = 3			   // When this limb is used to block a strike, this flat number is subtracted from the damage of the incoming hit


	// Physics
	var/vector2/limb_height = new /vector2(0,1)	//Height is a range of where the limb extends vertically. The first value is the lower bound, second is the upper
	//Height values assume the mob is in its normal pose standing on the ground
	//All height values are in metres, and also tiles. A turf is 1 metre by 1 metre


	//Retraction handling
	var/retracted	=	FALSE			//	Is this limb retracted into its parent?  If true, the limb is not rendered and all hits are passed to parent
	var/retract_timer					//	A timer handle used for temporary retractions or extensions
	var/default_extend_time = 10 SECONDS	//When autoextended, how long should this organ be left out for if no time is specified?


	// A bitfield for a collection of limb behavior flags.
	var/limb_flags = ORGAN_EXTERNAL

	// Appearance vars.
	var/icon_name = null               // Icon state base.
	var/body_part = null               // Part flag
	var/icon_position = 0              // Used in mob overlay layering calculations.
	var/model                          // Used when caching robolimb icons.
	var/force_icon                     // Used to force override of species-specific limb icons (for prosthetics).
	var/icon/mob_icon                  // Cached icon for use in mob overlays.
	var/s_tone                         // Skin tone.
	var/s_base = ""                    // Skin base.
	var/list/s_col                     // skin colour
	var/s_col_blend = ICON_ADD         // How the skin colour is applied.
	var/list/h_col                     // hair colour
	var/body_hair                      // Icon blend for body hair if any.
	var/list/markings = list()         // Markings (body_markings) to apply to the icon
	var/best_direction	=	EAST		//When severed, draw the icon facing in this direction

	// Wound and structural data.
	var/wound_update_accuracy = 1      // how often wounds should be updated, a higher number means less often
	var/list/wounds = list()           // wound datum list.
	var/number_wounds = 0              // number of wounds, which is NOT wounds.len!
	var/obj/item/organ/external/parent // Master-limb.
	var/list/children                  // Sub-limbs.
	var/list/internal_organs = list()  // Internal organs of this body part
	var/list/implants = list()         // Currently implanted objects.
	var/base_miss_chance = 0          // Chance of missing.
	var/genetic_degradation = 0
	biomass = 2	//By default, external organs are worth 2kg of biomass. Hella inaccurate, could find more exact values


	//Forensics stuff
	var/list/autopsy_data = list()    // Trauma data for forensics.

	// Joint/state stuff.
	var/joint = "joint"                // Descriptive string used in dislocation.
	var/amputation_point               // Descriptive string used in amputation.
	var/dislocated = 0                 // If you target a joint, you can dislocate the limb, causing temporary damage to the organ.
	var/encased                        // Needs to be opened with a saw to access the organs.
	var/artery_name = "artery"         // Flavour text for cartoid artery, aorta, etc.
	var/arterial_bleed_severity = 1    // Multiplier for bleeding in a limb.
	var/tendon_name = "tendon"         // Flavour text for Achilles tendon, etc.
	var/cavity_name = "cavity"

	// Surgery vars.
	var/cavity_max_w_class = 0
	var/hatch_state = 0
	var/stage = 0
	var/cavity = 0
	var/atom/movable/applied_pressure
	var/atom/movable/splinted

	// HUD element variable, see organ_icon.dm get_damage_hud_image()
	var/image/hud_damage_image

/*
/obj/item/organ/external/get_biomass()
	. = biomass
	for (var/obj/item/organ/internal/I in internal_organs)
		. += I.get_biomass()

*/

/**
 *  Get a list of contents of this organ and all the child organs
 */
/obj/item/organ/external/proc/get_contents_recursive()
	var/list/all_items = list()

	all_items.Add(implants)
	all_items.Add(internal_organs)

	for(var/obj/item/organ/external/child in children)
		all_items.Add(child.get_contents_recursive())

	return all_items

/****************************************************
			HELPERS
****************************************************/

/obj/item/organ/external/proc/is_stump()
	return 0

//Adds a new child organ to this one. Can pass either a type to create, or an existing organ to insert
/obj/item/organ/external/proc/add_child(var/newtype)
	var/obj/item/organ/external/E = newtype
	if (ispath(newtype))
		E = new newtype(src)

	E.forceMove(src)
	LAZYADD(children,E)
	E.parent = src

/obj/item/organ/external/proc/extend(var/update = TRUE)
	deltimer(retract_timer)
	if (!retracted)
		return
	retracted = FALSE
	.=TRUE
	if (update && owner)
		owner.update_body(TRUE)



/obj/item/organ/external/proc/retract(var/update = TRUE)
	deltimer(retract_timer)
	if (retracted)
		return
	retracted = TRUE
	.=TRUE
	if (update && owner)
		owner.update_body(TRUE)

/obj/item/organ/external/proc/extend_for(var/time)
	if (!time)
		time = default_extend_time
	extend()

	retract_timer = addtimer(CALLBACK(src, /obj/item/organ/external/proc/retract), time, TIMER_STOPPABLE)

/obj/item/organ/external/proc/retract_for(var/time)
	if (!time)
		time = default_extend_time
	retract()

	retract_timer = addtimer(CALLBACK(src, /obj/item/organ/external/proc/extend), time, TIMER_STOPPABLE)
