/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

#define SLASHER_DODGE_EVASION	60
#define SLASHER_DODGE_DURATION	1.5 SECONDS

/datum/species/necromorph/slasher
	name = SPECIES_NECROMORPH_SLASHER
	id = SPECIES_NECROMORPH_SLASHER
	can_have_genitals = FALSE
	say_mod = "hisses"

	//unarmed_types = list(/datum/unarmed_attack/blades, /datum/unarmed_attack/bite/weak) //Bite attack is a backup if blades are severed
	//total_health = 100
	biomass = 50
	mass = 70

	biomass_reclamation_time	=	7 MINUTES
	//spawner_spawnable = TRUE


/*
	Slasher, Icon Controllers
*/

//	icon = 'modular_skyrat/modules/horrorform/icons/mob/animal.dmi'
//	icon_state = "horror"
//	icon_living = "horror"
//	icon_dead = "horror_dead"
	pixel_offset_x = -8
	limbs_id = "slasher"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	//body_position_pixel_x_offset = 0
	//body_position_pixel_y_offset = 0

	//icon_template = 'icons/mob/necromorph/slasher/fleshy.dmi'
	//damage_mask = 'icons/mob/necromorph/slasher/damage_mask.dmi'
	//icon_lying = "_lying"

/*
	Slasher Combat. Damage Calculation and Effects
*/
	//evasion = 0	//No natural evasion
	damage_overlay_type = "xeno"
	attack_sound = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_7.ogg')
	miss_sound = 'sound/weapons/slashmiss.ogg'
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	//ventcrawl = FALSE //temporarily disabled until rebalanced.
	//ventcrawl_time = 10 SECONDS //They're huge....


/*
	Slasher variant. Traits
*/

	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID

/*
	Slasher variant. Mutant Parts
*/
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


	//Slashers hold their arms up in an overhead pose, so they override height too
	mutant_bodyparts = list(
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/blade, "height" = new /vector2(1.6,2)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/blade/right, "height" = new /vector2(1.6,2))
	)


	species_audio = list(
	SOUND_ATTACK = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_7.ogg'),
	SOUND_DEATH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_4.ogg'),
	SOUND_PAIN = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_6.ogg'),
	SOUND_SHOUT = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_4.ogg'),
	SOUND_SHOUT_LONG = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_4.ogg'),
	SOUND_SPEECH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_speech_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_speech_2.ogg')
	)

	//inherent_verbs = list(/atom/movable/proc/slasher_charge, /mob/living/proc/slasher_dodge, /mob/living/proc/slasher_fend, /mob/proc/shout)
	//modifier_verbs = list(KEY_CTRLALT = list(/atom/movable/proc/slasher_charge),
	//KEY_ALT = list(/mob/living/proc/slasher_dodge),
	//KEY_MIDDLE = list(/mob/living/proc/slasher_dodge))


	variants = list(SPECIES_NECROMORPH_SLASHER = list(WEIGHT = 8),
	SPECIES_NECROMORPH_SLASHER_DESICCATED = list(WEIGHT = 2),
	SPECIES_NECROMORPH_SLASHER_CARRION = list(WEIGHT = 0.1))

	abilities = list(
		/datum/action/cooldown/mob_cooldown/charge/necro = list(cooldown = 20 SECONDS, delay = 1 SECONDS, past = 1, distance = 20, speed = 2, damage = 15, destroy = FALSE, shake = 30),
		/datum/action/cooldown/necro/shout = list(),
		/datum/action/cooldown/necro/shout/long = list(),
		/datum/action/cooldown/necro/dodge = list(),
		/datum/action/cooldown/necro/active/gallop = list(),
		/datum/action/cooldown/necro/high_leap = list(),
		/datum/action/cooldown/necro/active/taunt = list(),
		/datum/element/twitch = list(),
		/datum/action/cooldown/mob_cooldown/fire_breath = list()
	)

	/*
	Use /datum/outfit here

	outfits = list(/datum/outfit = list(),
	/decl/hierarchy/outfit/necromorph/planet_cracker = list(),
	/decl/hierarchy/outfit/necromorph/security = list(),
	/decl/hierarchy/outfit/necromorph/biosuit = list(),
	/decl/hierarchy/outfit/necromorph/biosuit/earthgov = list( PATRON = TRUE),
	/decl/hierarchy/outfit/necromorph/doctor = list(),
	/decl/hierarchy/outfit/necromorph/command = list(),
	/decl/hierarchy/outfit/necromorph/mining = list(),
	/decl/hierarchy/outfit/necromorph/engi = list())
	*/

/datum/species/necromorph/slasher/desiccated
	name = SPECIES_NECROMORPH_SLASHER_DESICCATED
	//icon_template = 'icons/mob/necromorph/slasher/desiccated.dmi'
	NECROMORPH_VISUAL_VARIANT
	limbs_id = "desiccated_slasher"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/desiccated.dmi'

/*
/datum/species/necromorph/slasher/carrion
	name = SPECIES_NECROMORPH_SLASHER_CARRION
	//icon_template = 'icons/mob/necromorph/slasher/carrion.dmi'
	NECROMORPH_VISUAL_VARIANT
	//icon_lying = null
	//lying_rotation = 90

	outfits = list()	//This thing has a different shape and can't wear clothing
	bodytype = SPECIES_NECROMORPH_SLASHER_CARRION	//Does NOT share the same base bodytype, cannot wear slasher outfits
	hud_type = /datum/hud_data/necromorph
*/
/datum/species/necromorph/slasher/enhanced
	name = SPECIES_NECROMORPH_SLASHER_ENHANCED
	limbs_id = "eslasher"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/enhanced.dmi'

	species_audio = list(
	SOUND_ATTACK = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_7.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_8.ogg'),
	SOUND_DEATH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_3.ogg'),
	SOUND_PAIN = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_extreme.ogg' = 0.2),
	SOUND_SHOUT = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_6.ogg'),
	SOUND_SHOUT_LONG = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_6.ogg'),
	SOUND_SPEECH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_4.ogg')
	)

/*
	Blade Arm
*/
/obj/item/organ/external/arm/blade/slasher
	//limb_height = new /vector2(1.6,2)	//Slashers hold their blade arms high

/obj/item/organ/external/arm/blade/slasher/right
	//organ_tag = BP_R_ARM
	name = "right arm"
	//icon_name = "r_arm"
	//body_part = ARM_RIGHT
	//joint = "right elbow"
	//amputation_point = "right shoulder"



/* Unarmed attacks*/
/*
/datum/unarmed_attack/blades
	name = "Scything blades"
	desc = "These colossal blades can cleave a man in half."
	attack_verb = list("slashed", "scythed", "cleaved")
	attack_noun = list("slash", "cut", "cleave", "chop", "stab")
	eye_attack_text = "impales"
	eye_attack_text_victim = "blade"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	sharp = TRUE
	edge = TRUE
	shredding = TRUE
	damage = 16
	delay = 15
	airlock_force_power = 2
	armor_penetration = 5
*/

#define SLASHER_CHARGE_DESC	"<h2>Charge:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 20 seconds</h3><br>\
The user screams for a few seconds, then runs towards the target at high speed. If they successfully hit the target, they deal two free melee attacks on impact.<br>\
Charge has some autoaim, clicking within 1 tile of a living mob is enough to target them. It will also attempt to home in on targets, but will not path around obstacles<br>\
If the user hits a solid obstacle while charging, they will be stunned and take some minor damage. The obstacle will also be hit hard, and destroyed in some cases. <br>\
<br>\
Charge is a great move to initiate a fight, or to damage obstacles blocking your path. If you manage to land that first hit on a human, it is devastating, and often fatal."


#define SLASHER_DODGE_DESC "<h2>Dodge:</h2><br>\
<h3>Hotkey: Middle Mouse Click</h3><br>\
<h3>Cooldown: 6 seconds</h3><br>\
A simple trick, dodge causes the user to leap one tile to the side, and gain a large but brief bonus to evasion, making them almost impossible to hit.<br>\
The evasion bonus only lasts 1.5 seconds, so it's best used while an enemy is already firing at you. <br>\

Dodge is a skill that requires careful timing, but if used correctly, it can allow you to assault an entrenched firing line, and get close enough to land a few hits."

#define SLASHER_FEND_DESC "<h2>Fend:</h2><br>\
<h3>Hotkey: Alt+Click</h3><br>\
A toggleable ability, the slasher shields its body with its claws, trading off movespeed for defensive ability. Fend gives an active block that flatly reduces damage of hits\n\
The block chance is slightly random, but is most effective with melee attacks, aimed at the upper body, and from the front. If a blocked projectile is weak enough, it will bounce off\n\
Weak melee attacks will provoke a devastating counterattack instead.\n\
In addition, fend grants a 20% reduction to all incoming damage while active, but it halves your movespeed.\n\
Fend automatically cancels when you perform a charge or a melee attack. Dodge will not interrupt it though, and those two can be comboed together to approach enemies."

/*
/datum/species/necromorph/slasher/get_ability_descriptions()
	.= ""
	. += SLASHER_CHARGE_DESC
	. += "<hr>"
	. += SLASHER_DODGE_DESC
	. += "<hr>"
	. += SLASHER_FEND_DESC
*/
/*
//Can't slash things without arms
/datum/unarmed_attack/blades/is_usable(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target, var/zone)
	if(!user.has_organ(BP_R_ARM) && !user.has_organ(BP_L_ARM))
		return FALSE
	return TRUE

/datum/unarmed_attack/blades/show_attack(var/datum/strike/strike)
	//Fend is cancelled when you charge or attack
	strike.user.toggle_extension(/datum/extension/ability/toggled/fend, FALSE, FALSE, TRUE)
	.=..()

/datum/unarmed_attack/blades/strong
	damage = 22.4
	delay = 14
	airlock_force_power = 3
	armor_penetration = 8

/*
	Abilities
*/
/atom/movable/proc/slasher_charge(var/mob/living/A)
	set name = "Charge"
	set category = "Abilities"

	//Charge autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 2, src, 999)

	//Fend is cancelled when you charge or attack
	toggle_extension(/datum/extension/ability/toggled/fend, FALSE, FALSE, TRUE)

	.= charge_attack(A, _delay = 1 SECONDS, _speed = 5.0, _lifespan = 4 SECONDS)
	if (.)
		var/mob/H = src
		if (istype(H))
			H.face_atom(A)

			//Long shout when targeting mobs, normal when targeting objects
			if (ismob(A))
				H.play_species_audio(src, SOUND_SHOUT_LONG, VOLUME_HIGH, 1, 3)
			else
				H.play_species_audio(src, SOUND_SHOUT, VOLUME_HIGH, 1, 3)
		shake_animation(30)


/atom/movable/proc/slasher_charge_enhanced(var/mob/living/A)
	set name = "Charge"
	set category = "Abilities"

	//Charge autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 2, src, 999)

	.= charge_attack(A, _delay = 0.75 SECONDS, _speed = 5.5, _lifespan = 4 SECONDS)
	if (.)
		var/mob/H = src
		if (istype(H))
			H.face_atom(A)

			//Long shout when targeting mobs, normal when targeting objects
			if (ismob(A))
				H.play_species_audio(src, SOUND_SHOUT_LONG, VOLUME_HIGH, 1, 3)
			else
				H.play_species_audio(src, SOUND_SHOUT, VOLUME_HIGH, 1, 3)
		shake_animation(30)


/mob/living/proc/slasher_dodge()
	set name = "Dodge"
	set category = "Abilities"


	.= dodge_ability(_duration = SLASHER_DODGE_DURATION, _cooldown = 6 SECONDS, _power = SLASHER_DODGE_EVASION)


/mob/living/proc/slasher_dodge_enhanced()
	set name = "Dodge"
	set category = "Abilities"


	.= dodge_ability(_duration = SLASHER_DODGE_DURATION, _cooldown = 5 SECONDS, _power = SLASHER_DODGE_EVASION*1.2)

/*
	Slashers have a special charge impact. Each of their blade arms gets a free hit on impact with the primary target

	However, to limit the power of this, these hits are mostly randomised in terms of where they land on the body.
*/
/datum/species/necromorph/slasher/charge_impact(var/datum/extension/charge/charge)
	if (charge.last_target_type == CHARGE_TARGET_PRIMARY && isliving(charge.last_obstacle))
		var/mob/living/carbon/human/H = charge.user
		var/mob/living/L = charge.last_obstacle

		var/current_target_zone = H.get_zone_sel()


		//This is a bit of a hack because unarmed attacks are poorly coded:
			//We'll set the user's last attack to some time in the past so they can attack again
		if (H.has_organ(BP_R_ARM))
			H.last_attack = 0

			//50% chance to hit the zone you're targeting, otherwise random target zone
			if (prob(50))
				H.set_random_zone()
			H.UnarmedAttack(L)

		if (H.has_organ(BP_L_ARM))
			H.last_attack = 0

			//Second hit is always a random target
			H.set_random_zone()
			H.UnarmedAttack(L)

		//Return the target zone to normal
		H.set_zone_sel(current_target_zone)
		return FALSE
	else
		return ..()



/mob/living/proc/slasher_fend()
	set name = "Fend"
	set category = "Abilities"

	toggle_extension(/datum/extension/ability/toggled/fend)



//Special death condition: Slashers die when they lose both blade arms
/datum/species/necromorph/slasher/handle_death_check(var/mob/living/carbon/human/H)
	.=..()
	if (!.)
		if (!H.has_organ(BP_L_ARM) && !H.has_organ(BP_R_ARM))
			return TRUE

#undef SLASHER_DODGE_EVASION
#undef SLASHER_DODGE_DURATION


*/


/*---------------------
	Wallcrawling
-----------------------*/
///datum/species/necromorph/slasher/setup_movement(var/mob/living/carbon/human/H)
//	H.AddComponent(/datum/component/wallrun/slasher)

/datum/component/wallrun/slasher/mount_to_atom(var/atom/target)
	.=..()

/datum/component/wallrun/slasher/unmount()
	.=..()

