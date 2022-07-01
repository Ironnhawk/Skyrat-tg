/obj/structure/necromorph/growth/special/node
	name = "Growth"
	icon = 'modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi'
	icon_state = "growth"
	desc = "Corruption spreads out in all directions from this horrible mass."
	max_integrity = MARKER_NODE_MAX_HP
	health_regen = MARKER_NODE_HP_REGEN
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 65, ACID = 90)
	point_return = MARKER_REFUND_NODE_COST
	claim_range = MARKER_NODE_CLAIM_RANGE
	pulse_range = MARKER_NODE_PULSE_RANGE
	expand_range = MARKER_NODE_EXPAND_RANGE
	resistance_flags = LAVA_PROOF
	max_slashers = MARKER_NODE_MAX_SLASHERS
	ignore_syncmesh_share = TRUE

/obj/structure/necromorph/growth/special/node/Initialize()
	GLOB.growth_nodes += src
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/necromorph/growth/special/node/scannerreport()
	return "This node acts as a heart for corruption spread, allowing it to extend out up to [MARKER_NODE_EXPAND_RANGE] tiles in all directions from the node. It must be placed on existing corruption from another propagator node, or from the marker."

/obj/structure/necromorph/growth/special/node/update_icon()
	color = null
	return ..()

/obj/structure/necromorph/growth/special/node/update_overlays()
	. = ..()
	var/mutable_appearance/marker_overlay = mutable_appearance('icons/mob/blob.dmi', "blob")
	if(master)
		marker_overlay.color = COLOR_MARKER_RED
	. += marker_overlay
	. += mutable_appearance('modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi', "growth")

/obj/structure/necromorph/growth/special/node/creation_action()
	if(master)
		master.node_growths += src

/obj/structure/necromorph/growth/special/node/Destroy()
	GLOB.growth_nodes -= src
	STOP_PROCESSING(SSobj, src)
	if(master)
		master.node_growths -= src
	return ..()

/obj/structure/necromorph/growth/special/node/process(delta_time)
	if(master)
		pulse_area(master, claim_range, pulse_range, expand_range)
		//reinforce_area(delta_time)
		//produce_slashers()
