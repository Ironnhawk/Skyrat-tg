/*
	A node that provides light and nothing else.
	Its just an organic lightbulb
*/
/obj/structure/necromorph/growth/special/bioluminescence
	name = "bioluminescent nodule"
	desc = "A candle to light the way home"
	icon = 'modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi'
	icon_state = "light"
	max_integrity = MARKER_REGULAR_MAX_HP
	point_return = CORRUPTION_REFUND_BIOLUMINESCENCE_COST
	resistance_flags = LAVA_PROOF
	default_scale = 1.6
	light_range = 8
	marker_spawnable = FALSE



/obj/structure/necromorph/growth/special/bioluminescence/Initialize()
	GLOB.growth_special += src
	START_PROCESSING(SSobj, src)
	set_light(1, 1, light_range, 2, COLOR_BIOLUMINESCENT_ORANGE)
	. = ..()

/obj/structure/necromorph/growth/special/bioluminescence/update_icon()
	color = null
	return ..()

/obj/structure/necromorph/growth/special/bioluminescence/update_overlays()
	. = ..()
	var/mutable_appearance/marker_overlay = mutable_appearance('icons/mob/blob.dmi', "blob")
	if(master)
		marker_overlay.color = COLOR_MARKER_RED
	. += marker_overlay
	. += mutable_appearance('modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi', "light")


/obj/structure/necromorph/growth/special/bioluminescence/scannerreport()
	return "Gradually supplies the marker with resources, increasing the rate of expansion."

/obj/structure/necromorph/growth/special/bioluminescence/get_blurb()
	. = "This node is effectively an organic lightbulb. <br>\
	It illuminates an 8 tile radius with a soft orange glow, allowing people (especially necromorphs) to see where they're going in the dark.<br>\
	<br>\
	Providing light is all it does, there is no other function."

/obj/structure/necromorph/growth/special/bioluminescence/creation_action()
	if(master)
		master.bioluminescence_corruption += src

/obj/structure/necromorph/growth/special/bioluminescence/Destroy()
	if(master)
		master.bioluminescence_corruption -= src
	return ..()

