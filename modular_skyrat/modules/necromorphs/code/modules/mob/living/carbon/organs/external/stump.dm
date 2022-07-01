/obj/item/organ/external/stump
	name = "limb stump"
	icon_name = ""
	dislocated = -1
	base_miss_chance = 15	//Small target
	biomass = 0

/obj/item/organ/external/stump/New(var/mob/living/carbon/holder, var/internal, var/obj/item/organ/external/limb)
	if(istype(limb))
		organ_tag = limb.organ_tag
		body_part = limb.body_part
		amputation_point = limb.amputation_point
		joint = limb.joint
		parent_organ = limb.parent_organ
	..(holder, internal)
	if(istype(limb))
		max_damage = limb.max_damage

/obj/item/organ/external/stump/is_stump()
	return 1
