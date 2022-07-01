/obj/structure/necromorph/growth/special // Generic type for nodes/factories/cores/resource
	// Core and node vars: claiming, pulsing and expanding
	/// The radius inside which (previously dead) marker tiles are 'claimed' again by the pulsing master. Very rarely used.
	var/claim_range = 0
	/// The radius inside which markers are pulsed by this master. Does stuff like expanding, making marker slashers from factories, make resources from nodes etc.
	var/pulse_range = 0
	/// The radius up to which this special structure naturally grows normal markers.
	var/expand_range = 0

	// Slasher production vars: for core, factories, and nodes (with s)

	var/mob/living/simple_animal/hostile/necromorph/slasher = null
	var/mob/living/simple_animal/hostile/necromorph/brute = null

	var/max_slashers = 0
	var/list/slashers = list()
	COOLDOWN_DECLARE(slasher_delay)
	var/slasher_cooldown = MARKERMOB_SLASHER_SPAWN_COOLDOWN

	// Area reinforcement vars: used by cores and nodes, for s to modify
	/// Range this marker free upgrades to strong markers at: for the core, and for s
	var/strong_reinforce_range = 0
	/// Range this marker free upgrades to reflector markers at: for the core, and for s
	var/reflector_reinforce_range = 0
/*
/obj/structure/necromorph/growth/special/update_icon()
	.=..()
	var/matrix/M = matrix()
	M = M.Scale(default_scale)	//We scale up the sprite so it slightly overlaps neighboring corruption tiles
	M = turn(M, get_rotation())
	if (randpixel)
		pixel_x = default_pixel_x + rand_between(-randpixel, randpixel)
		pixel_y = default_pixel_y + rand_between(-randpixel, randpixel)
	transform = M

//
/obj/structure/necromorph/growth/special/proc/get_rotation()
	if (!random_rotation)
		return 0
	default_rotation = pick(list(0,45,90,135,180,225,270,315))//Randomly rotate it

	return default_rotation
*/
/obj/structure/necromorph/growth/special/proc/pulse_area(mob/camera/marker/pulsing_master, claim_range = 10, pulse_range = 3, expand_range = 2)
	if(QDELETED(pulsing_master))
		pulsing_master = master
	Be_Pulsed()
	var/expanded = FALSE
	if(prob(70*(1/MARKER_EXPAND_CHANCE_MULTIPLIER)) && expand())
		expanded = TRUE
	var/list/markers_to_affect = list()
	for(var/obj/structure/necromorph/growth/B in urange(claim_range, src, 1))
		markers_to_affect += B
	shuffle_inplace(markers_to_affect)
	for(var/L in markers_to_affect)
		var/obj/structure/necromorph/growth/B = L
		if(!B.master && prob(30))
			B.master = pulsing_master //reclaim unclaimed, non-core markers.
			B.update_appearance()
		var/distance = get_dist(get_turf(src), get_turf(B))
		var/expand_probablity = max(20 - distance * 8, 1)
		if(B.Adjacent(src))
			expand_probablity = 20
		if(distance <= expand_range)
			var/can_expand = TRUE
			if(markers_to_affect.len >= 120 && !(COOLDOWN_FINISHED(B, heal_timestamp)))
				can_expand = FALSE
			if(can_expand && COOLDOWN_FINISHED(B, pulse_timestamp) && prob(expand_probablity*MARKER_EXPAND_CHANCE_MULTIPLIER))
				if(!expanded)
					var/obj/structure/necromorph/growth/newB = B.expand(null, null, !expanded) //expansion falls off with range but is faster near the marker causing the expansion
					if(newB)
						expanded = TRUE
		if(distance <= pulse_range)
			B.Be_Pulsed()
/*
	Remove Old Blob Spawn Method

/obj/structure/necromorph/growth/special/proc/produce_slashers()
	if(brute)
		return
	if(slashers.len >= max_slashers)
		return
	if(!COOLDOWN_FINISHED(src, slasher_delay))
		return
	COOLDOWN_START(src, slasher_delay, slasher_cooldown)
	var/mob/living/simple_animal/hostile/necromorph/slasher/BS = new (loc, src)
	if(master) //if we don't have an master, we don't need to do anything but make a slasher
		BS.master = master
		BS.update_icons()
		master.marker_mobs.Add(BS)
*/

// /obj/structure/necromorph/growth/special/proc/produce_spores()
// 	if(brute)
// 		return
// 	if(slashers.len >= max_slashers)
// 		return
// 	if(!COOLDOWN_FINISHED(src, slasher_delay))
// 		return
// 	COOLDOWN_START(src, slasher_delay, slasher_cooldown)
// 	var/mob/living/simple_animal/hostile/necromorph/slasher/BS = new (loc, src)
// 	if(master) //if we don't have an master, we don't need to do anything but make a slasher
// 		BS.master = master
// 		BS.update_icons()
// 		master.marker_mobs.Add(BS)
