// saveloc mob proc
mob/PC/proc/GotoLoc(location)
	density=0
	loc=locate(location)
	if(inparty==1) density=1
	switch(location)
		if(/area/start_location){last_area=/area/saved_location/baron_area;sound = MUSIC_TOWN}
		if(/area/saved_location/baron_area) sound = MUSIC_WORLD
		if(/area/saved_location/mist_area) sound = MUSIC_WORLD
		if(/area/saved_location/kaipo_area) sound = MUSIC_WORLD
		if(/area/saved_location/damcyan_area) sound = MUSIC_WORLD
		if(/area/saved_location/fabul_area) sound = MUSIC_WORLD
		if(/area/saved_location/mysdia_area) sound = MUSIC_WORLD
		if(/area/saved_location/mount_hobbs_area) sound = MUSIC_MOUNTAIN
		if(/area/saved_location/mount_ordeals_area) sound = MUSIC_MOUNTAIN
		if(/area/saved_location/antlion_area) sound = MUSIC_CAVE
		if(/area/saved_location/water_cave_area) sound = MUSIC_CAVE
		if(/area/saved_location/toroia_area) sound = MUSIC_WORLD
		if(/area/saved_location/legacy_area) sound = MUSIC_WORLD
	usr<<sound(sound,1,0,1)

// area vars
area
	intro_screen
	prologue_screen
	start_location
	saved_location
		baron_area/desc="Baron"
		mist_area/desc="Mist"
		kaipo_area/desc="Kaipo"
		damcyan_area/desc="Damcyan"
		fabul_area/desc="Fabul"
		mount_hobbs_area/desc="Hobbs"
		mount_ordeals_area/desc="Ordeals"
		antlion_area/desc="Antlion"
		mysdia_area/desc="Mysidia"
		water_cave_area/desc="Waterway"
		toroia_area/desc="Toroia"
		royal_area/desc="Royal"
		gm_room_area/desc="GM Room"
		b3_magnes_cave_area/desc="MagnesB3"
		b4_magnes_cave_area/desc="MagnesB4"
		b2_sealed_cave_area/desc="SealedB2"
		b3_sealed_cave_area/desc="SealedB3"
		legacy_area/desc="Legacy"
		dwarf_castle_area/desc="Dwarf"
		agart_area/desc="Agart"
		silvera_area/desc="Silvera"
		eblan_area/desc="Eblan"
		zot_area/desc="Zot"
		f4_babil_area/desc="Ba-bil4F"
		f7_babil_area/desc="Ba-bil7F"
		b3_babil_area/desc="Ba-bilB3"
		eblan_cave_area/desc="C. Eblan"
		tomra_area/desc="Tomra"
		monsters_area/desc="Monsters"
		babil_giant_area/desc="B. Giant"
		lunar_area/desc="Lunar"
		b5_lunar_area/desc="LunarB5"
		b7_lunar_area/desc="LunarB7"
		paigey_area
		trigger_area
		//bases
		baron_base_area/desc="ClanBase"
		toroia_base_area/desc="ClanBase"
		ryoshin_castle_area/desc="Ryoshin"
		//thrones
		ryoshin_castle_throne/desc="Ryo's Throne"
// under-walking area
	under_area
		var/u_passage_dir					//0 = vertical | 1 = horizontal
		Enter(mob/M)
			if((!u_passage_dir && M.dir == 1)||(!u_passage_dir && M.dir == 2)||(u_passage_dir && M.dir == 4)||(u_passage_dir && M.dir == 8))
				M.layer = TURF_LAYER-1
				M.density = 0
				return 1
			return ..()
		Exit(mob/PC/M)
			if(M.layer != MOB_LAYER)
				if((!u_passage_dir && M.dir == 1)||(!u_passage_dir && M.dir == 2)||(u_passage_dir && M.dir == 4)||(u_passage_dir && M.dir == 8))
					if(M.party[1] == M) M.density = 1
					M.layer = MOB_LAYER
					return 1
				else return 0
			return ..()
// npc walking area
	npc_area
		Exit(obj/O)
			if(istype(O,/obj/NPC)) return 0
			else return ..()

// specific areas
	clan_specfic
		var
			clan_req
		Enter(var/mob/PC/M)
			set src in view(1)
			if(M.client)
				if(M.clan == clan_req)
					if(M.party.len)
						M.leave_party()
					return ..()
				else
					return 0
			else return ..()

	class_specfic
		var
			class_req
		Enter(var/mob/PC/M)
			set src in view(1)
			if(M.client)
				if(M.class == class_req)
					if(M.party.len)
						M.leave_party()
					return ..()
				else
					return 0
			else return ..()

	lvl_specfic
		var
			lvl_req
		Enter(var/mob/PC/M)
			set src in view(1)
			if(M.client)
				if(M.level == lvl_req)
					if(M.party.len)
						M.leave_party()
					return ..()
				else
					return 0
			else return ..()

	key_specific
		var
			key_req
		Enter(var/mob/PC/M)
			set src in view(1)
			if(M.client)
				if(M.key == key_req)
					if(M.party.len)
						M.leave_party()
					return ..()
				else
					M.msg("Only [key_req] can pass.")
					return 0
			else return ..()
//easy pvp area
