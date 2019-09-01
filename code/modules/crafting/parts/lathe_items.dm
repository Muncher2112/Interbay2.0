/obj/item/reciever
	name = "Reciever"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is a reciever."
	icon_state = "reciever"
	matter = list(DEFAULT_WALL_MATERIAL = 500)

/obj/item/action
	name = "Action"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is a action."
	icon_state = "action"
	matter = list(DEFAULT_WALL_MATERIAL = 400)

/obj/item/metal_bar
	name = "Metal Bar"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is a metal bar.  Can be made into lots of stuff"
	icon_state = "metal_bar"
	matter = list(DEFAULT_WALL_MATERIAL = 300)

	mill()
		return /obj/item/pipe
	press()
		return /obj/item/weapon/crowbar


/obj/item/glass_bar
	name = "Glass Bar"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is a glass bar.  Can be made into lots of stuff"
	icon_state = "glass_bar"
	matter = list("glass" = 300)

	mill()
		return /obj/item/glass_tube

/obj/item/glass_tube
	name = "Glass Tube"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "A hollow glass bar.  Looks like it would fit perfectly as a tube light."
	icon_state = "glass_tube"
	matter = list("glass" = 200)


/obj/item/metal_shiv
	name = "Metal shiv"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is a metal shiv. It can be made into many things."
	icon_state = "metal_shiv"
	matter = list(DEFAULT_WALL_MATERIAL = 300)

	press()
		return /obj/item/screwdriver_head

/obj/item/screwdriver_head
	name = "Screwdriver head"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is the top of a screwdriver"
	icon_state = "screwdriver_head"

/obj/item/wrench_head
	name = "Top of a wrench"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is a top of a wrench."
	icon_state = "wrench_head"
	matter = list(DEFAULT_WALL_MATERIAL = 800)

/obj/item/glass_handle
	name = "Glass handle"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is a piece of glass.  It could be used as a handle"
	icon_state = "glass_handle"
	matter = list("glass" = 400)

/obj/item/cylinder
	var/chambers = 0
	name = "cylinder"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is a makeshift cylinder.  It has zero holes drilled into it"
	icon_state = "cylinder_0"
	matter = list(DEFAULT_WALL_MATERIAL = 500)

	mill(var/mob/user)
		switch(chambers)
			if(0)
				if (user.skillcheck(user.skills["crafting"], 30, 1, message = "You mill to far into the cynlinder, and it falls apart"))
					return /obj/item/cylinder/one_slot
			if(1)
				if (user.skillcheck(user.skills["crafting"], 50, 1, message = "You nick another hole, and the cylinder falls apart."))
					return /obj/item/cylinder/two_slot
			if(2)
				if (user.skillcheck(user.skills["crafting"], 70, 1, message = "You nick another hole, and the cylinder falls apart."))
					return /obj/item/cylinder/three_slot
			if(3)
				if (user.skillcheck(user.skills["crafting"], 80, 1, message = "You nick another hole, and the cylinder falls apart."))
					return /obj/item/cylinder/four_slot
			if(4)
				to_chat(usr, "<span class='notice'>You nick another hole, and the cylinder falls apart.</span>")
				return /obj/item/weapon/ore/slag
		return /obj/item/weapon/ore/slag

	press()
		return /obj/item/wrench_head

/obj/item/cylinder/one_slot
	chambers = 1
	icon_state = "cylinder_1"
	desc = "This is a makeshift cylinder.  It has one hole drilled into it"

/obj/item/cylinder/two_slot
	chambers = 2
	icon_state = "cylinder_2"
	desc = "This is a makeshift cylinder.  It has two holes drilled into it"

/obj/item/cylinder/three_slot
	chambers = 3
	icon_state = "cylinder_3"
	desc = "This is a makeshift cylinder.  It has three holes drilled into it"

/obj/item/cylinder/four_slot
	chambers = 4
	desc = "This is a makeshift cylinder.  It has four holes drilled into it"
	icon_state = "cylinder_4"

/obj/item/stock
	name = "stock"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_NORMAL
	desc = "This is reciever."
	icon_state = "stock"

/obj/item/solid_bullet_casing
	name = "Solid Bullet Casing"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_SMALL
	desc = "This is a  solid bullet casing."
	icon_state = "solid_ammo_casing"
	matter = list(DEFAULT_WALL_MATERIAL = 200)

	mill(var/mob/user)
		return /obj/item/bullet_casing

/obj/item/bullet_casing
	name = "Bullet Casing"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_SMALL
	desc = "This is a bullet casing.  It doesn't have a bullet in it yet."
	icon_state = "milled_ammo_casing"
	matter = list(DEFAULT_WALL_MATERIAL = 50)

/obj/item/bullet_38
	name = "Bullet"
	icon = 'icons/obj/crafting.dmi'
	w_class = ITEM_SIZE_SMALL
	desc = "This is a small ball of metal.  Can probably work as a bullet"
	icon_state = ".38_bullet"
	matter = list(DEFAULT_WALL_MATERIAL = 200)