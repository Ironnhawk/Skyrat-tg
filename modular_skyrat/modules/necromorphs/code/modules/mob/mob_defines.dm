


/mob
	var/list/grabbed_by = list()
	var/view_range = 1

//Returns what percentage of the limbs we use for movement, are still attached
/mob/living/carbon/human/proc/get_locomotive_limb_percent()

	var/current = length(get_locomotion_limbs(FALSE))
	var/max = LAZYLEN(species.locomotion_limbs)

	if (max > 0)
		return current / max

	return 1


//This proc tells how many legs we have
/mob/proc/get_locomotion_limbs(include_stump = FALSE)
	return list()

/mob/living/carbon/human/species/necromorph
	var/step_count
	var/step_interval	= 2

/mob/proc/get_organ(zone)
	return null

/mob/living/carbon/human/get_organ(zone)
	return organs_by_name[check_zone(zone)]

/mob/proc/get_organ_by_type(type)

/mob/living/carbon/human/get_organ_by_type(type)
	for (var/tag in organs_by_name)
		var/obj/O = organs_by_name[tag]
		if (istype(O, type))
			return O

/mob/living/carbon/human/get_locomotion_limbs(include_stump = FALSE)
	var/found = list()
	for (var/organ_tag in species.locomotion_limbs)
		var/obj/item/organ/external/E = get_organ(organ_tag)
		if (!E)
			continue

		//if (!include_stump && E.is_stump())
			//continue

		found |= E

	return found


/mob/living/carbon/human/get_locomotion_limbs(var/include_stump = FALSE)
	var/found = list()
	for (var/organ_tag in species.locomotion_limbs)
		var/obj/item/organ/external/E = get_organ(organ_tag)
		if (!E)
			continue

		//if (!include_stump && E.is_stump())
			//continue

		found |= E

	return found


/mob/living/carbon/human/proc/has_organ(name)
	var/obj/item/organ/external/O = organs_by_name[name]
	return (O && !O.is_stump())


/mob/living/carbon/human/proc/has_organ_or_replacement(var/organ_tag)
	if (organ_tag in species.organ_substitutions)
		organ_tag = species.organ_substitutions[organ_tag]

	return has_organ(organ_tag)

/mob/living/carbon
	var/datum/species/species //Contains icon generation and language information, set during New().
// organ-related variables, see organ.dm and human_organs.dm
	//var/list/internal_organs = list()
	//var/list/organs = list()
	var/list/organs_by_name = list() // map organ names to organs
	var/list/internal_organs_by_name = list() // so internal organs have less ickiness too

/mob/living/carbon/human
	var/damage_multiplier = 1 //multiplies melee combat damage
