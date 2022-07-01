#define LEAP_SHOCKWAVE_DAMAGE	10
#define LEAP_CONE_DAMAGE	15
#define LEAP_CONE_WEAKEN	3
#define LEAP_REDUCED_COOLDOWN	3 SECONDS
#define TONGUE_EXTEND_TIME 5 SECONDS	//How long the tongue stays out and visible after any tongue move
#define ARM_SWING_RANGE_TRIPOD 4

//These are used to position the arm sprite during swing
#define TONGUE_OFFSETS	list(S_NORTH = new /vector2(6, 16), S_SOUTH = new /vector2(-2, 8), S_EAST = new /vector2(26, 10), S_WEST = new /vector2(-14, 10))


/*
	Tripod variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

/datum/species/necromorph/tripod
	name = SPECIES_NECROMORPH_TRIPOD
	id = SPECIES_NECROMORPH_TRIPOD
	can_have_genitals = FALSE
	say_mod = "hisses"
	limbs_id = "tripod"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/tripod.dmi'
	pixel_offset_x = -54
	biomass = 400
	//require_total_biomass	=	BIOMASS_REQ_T3
	mass = 250
	biomass_reclamation_time	=	15 MINUTES
	marker_spawnable = TRUE

//	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/tripod/fleshy.dmi'
	//eyes_icon = 'modular_skyrat/master_files/icons/mob/species/vox_eyes.dmi'
//	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/tripod/fleshy.dmi'
//	mutant_bodyparts = list()

	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		NO_UNDERWEAR,
		FACEHAIR
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID

/*
	Tripod variant. Damage Calculation and Effects
*/

	damage_overlay_type = "xeno"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	attack_verb = "slash"

	attack_effect = ATTACK_EFFECT_CLAW

/*
	Tripod variant. Traits
*/

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_RESISTHEAT,
		TRAIT_NOBREATH,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOHUNGER,
		TRAIT_EASYDISMEMBER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_XENO_IMMUNE,
		TRAIT_NOCLONELOSS,
	)


/*
	Tripod variant. Mutant Parts
*/
/*
	has_limbs = list(BP_CHEST =  list("path" = /obj/item/organ/external/chest/giant, "height" = new /vector2(0, 2.5)),
	BP_HEAD = list("path" = /obj/item/organ/external/arm/tentacle/tripod_tongue, "height" = new /vector2(1.5, 2.5)),	//The tripod is tall and all of its limbs are too
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/giant, "height" = new /vector2(0, 2.0)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/giant, "height" = new /vector2(0, 2.0))
	)
*/
	locomotion_limbs = list(BP_R_ARM, BP_L_ARM)

	//grasping_limbs = list(BP_R_ARM, BP_L_ARM)

	mutanteyes = /obj/item/organ/eyes/night_vision
	mutanttongue = /obj/item/organ/tongue/zombie

	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)

	bodypart_overides = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph)


	//Audio

	step_volume = VOLUME_QUIET //Tripod stomps are low pitched and resonant, don't want them loud
	step_range = 4
	step_priority = 5
	pain_audio_threshold = 0.03 //Gotta set this low to compensate for his high health

	species_audio = list(SOUND_FOOTSTEP = list('modular_skyrat/modules/necromorphs/sound/effects/footstep/tripod_footstep_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/tripod_footstep_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/tripod_footstep_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/tripod_footstep_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/tripod_footstep_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/tripod_footstep_6.ogg'),
	SOUND_ATTACK = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_7.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_8.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_9.ogg'),
	SOUND_DEATH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_death_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_death_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_death_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_death_4.ogg'),
	SOUND_PAIN = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_1.ogg',
	 'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_2.ogg',
	 'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_3.ogg',
	 'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_4.ogg',
	 'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_5.ogg',),
	SOUND_SHOUT = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_6.ogg'),
	SOUND_SHOUT_LONG = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_6.ogg')
	)


#undef LEAP_SHOCKWAVE_DAMAGE
#undef LEAP_CONE_DAMAGE
#undef LEAP_CONE_WEAKEN
#undef LEAP_REDUCED_COOLDOWN
#undef TONGUE_EXTEND_TIME

#undef TONGUE_OFFSETS
