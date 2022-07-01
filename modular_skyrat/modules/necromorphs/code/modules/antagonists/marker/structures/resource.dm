/obj/structure/necromorph/growth/special/resource
	name = "resource marker"
	icon = 'icons/mob/blob.dmi'
	icon_state = "blob_resource"
	color = COLOR_MARKER_RED
	desc = "A thin spire of slightly swaying tendrils."
	max_integrity = MARKER_RESOURCE_MAX_HP
	point_return = MARKER_REFUND_RESOURCE_COST
	resistance_flags = LAVA_PROOF
	var/resource_delay = 0

/obj/structure/necromorph/growth/special/resource/scannerreport()
	return "Gradually supplies the marker with resources, increasing the rate of expansion."

/obj/structure/necromorph/growth/special/resource/creation_action()
	if(master)
		master.resource_growths += src

/obj/structure/necromorph/growth/special/resource/Destroy()
	if(master)
		master.resource_growths -= src
	return ..()

/obj/structure/necromorph/growth/special/resource/Be_Pulsed()
	. = ..()
	if(resource_delay > world.time)
		return
	flick("marker_resource_glow", src)
	if(master)
		master.add_points(MARKER_RESOURCE_GATHER_AMOUNT)
		resource_delay = world.time + MARKER_RESOURCE_GATHER_DELAY + master.resource_growths.len * MARKER_RESOURCE_GATHER_ADDED_DELAY //4 seconds plus a quarter second for each resource marker the master has
	else
		resource_delay = world.time + MARKER_RESOURCE_GATHER_DELAY
