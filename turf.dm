var/const/reaction_time = 8
// turf variables
turf
	var
		//battle stuff
		encounter_group
		bfield
		pvp_area
		worldmap
		//movement stuff
		direction
		dest_x
		dest_y
		dest_z
		//music change
		music
		sound
		//saved loc
		area/saved_location/saveloc
	Entered(mob/PC/p)
		//nothing for anything besides the players
		if(!p||!istype(p,/mob/PC)||!p.client) return
		//maybe it has a location?
		if(dest_x&&dest_y&&dest_z)
			//saving the loc?
			if(saveloc) for(var/mob/PC/M in p.party){M.last_area = saveloc;if(!M.visited_location.Find(saveloc)) M.visited_location += saveloc}
			//who says new location says new music, maybe?
			if(music) for(var/mob/PC/M in p.party){M<<sound(null);M.sound=music;M<<sound(M.sound,repeat=1,wait=0,channel=1,volume=50)}
			p.inmenu = "turf_teleport"
			p.density = 0
			for(var/mob/PC/M in p.party){M.pmoves=null;M.loc = locate(dest_x,dest_y,dest_z);M.dir = direction;M.icon_state = "normal"}
			p.density = 1
			spawn(reaction_time) if(p) p.inmenu = null
			return
		if(!encounter_group||!global.battle||!p.battle||p.Maxlev) return //check if battles are disabled, also if your 99
		if(p.inparty==1)	//only the party leader may encounter battles
			if(p.encounter_rate)
				p.encounter_rate--
				if(p.encounter_rate<=0&&!p.Maxlev) // you have to under 99 to get into a random encounter
					for(var/mob/PC/z in p.party) if(z.Maxlev) z.leave_party() // if your in a party, you get kicked out of the party!
					p.StartBattle(src)
			else p.encounter_rate = rand(round(encounter_rate/3),round(encounter_rate*1.2))
area/note
	icon='turf/note.dmi'
	layer=10
turf/Link2Areas
	icon='turf/Link2Areas.dmi'
	layer=10
// new intro
turf/newtitle
	ff
		icon = 'newff.dmi';density = 0;name = "letters"
		f11{icon_state = "1,1"}
		f12{icon_state = "1,2"}
		f13{icon_state = "1,3"}
		f14{icon_state = "1,4"}
		f15{icon_state = "1,5"}
		f16{icon_state = "1,6"}
		f17{icon_state = "1,7"}
		f18{icon_state = "1,8"}
		f19{icon_state = "1,9"}
		f19a{icon_state = "1,10"}
		f19b{icon_state = "1,11"}
		f19c{icon_state = "1,12"}
		f21{icon_state = "2,1"}
		f22{icon_state = "2,2"}
		f23{icon_state = "2,3"}
		f24{icon_state = "2,4"}
		f25{icon_state = "2,5"}
		f26{icon_state = "2,6"}
		f27{icon_state = "2,7"}
		f28{icon_state = "2,8"}
		f29{icon_state = "2,9"}
		f29a{icon_state = "2,10"}
		f29b{icon_state = "2,11"}
		f29c{icon_state = "2,12"}
		f31{icon_state = "3,1"}
		f32{icon_state = "3,2"}
		f33{icon_state = "3,3"}
		f34{icon_state = "3,4"}
		f35{icon_state = "3,5"}
		f36{icon_state = "3,6"}
		f37{icon_state = "3,7"}
		f38{icon_state = "3,8"}
		f39{icon_state = "3,9"}
		f39a{icon_state = "3,10"}
		f39b{icon_state = "3,11"}
		f39c{icon_state = "3,12"}
		l
			icon = 'newl.dmi';density = 0
			line{icon_state = "line"}
			f11{icon_state = "1,1"}
			f12{icon_state = "1,2"}
			f13{icon_state = "1,3"}
			f14{icon_state = "1,4"}
			f15{icon_state = "1,5"}
			f16{icon_state = "1,6"}
			f21{icon_state = "2,1"}
			f22{icon_state = "2,2"}
			f23{icon_state = "2,3"}
			f24{icon_state = "2,4"}
			f25{icon_state = "2,5"}
			f26{icon_state = "2,6"}
			c1/icon_state = "tl_crystal"
			c2/icon_state = "tr_crystal"
			c3/icon_state = "tlm_crystal"
			c4/icon_state = "trm_crystal"
			c5/icon_state = "lm_crystal"
			c6/icon_state = "rm_crystal"
			c7/icon_state = "blm_crystal"
			c8/icon_state = "brm_crystal"
			c9/icon_state = "bl_crystal"
			c10/icon_state = "br_crystal"
			c11/icon_state = "blc_crystal"
			c12/icon_state = "brc_crystal"
// misc images
turf/miscimg/intro
	name=null
	//icon='logo.png'
turf/miscimg/prologue
	name=null
	icon='prologue.png'

turf/miscimg/theend
	name=null
	icon='turf/theend.dmi'
	T/icon_state="T"
	h/icon_state="h"
	e/icon_state="e"
	E/icon_state="E"
	n/icon_state="n"
	d/icon_state="d"

turf/miscimg/bdnfg
	name="floor"
	icon='turf/bdnfg.dmi'
	pvp_area=1
	b12/icon_state="1,2"
	b13/icon_state="1,3"
	b14/icon_state="1,4"
	b15/icon_state="1,5"
	b16/icon_state="1,6"
	b17/icon_state="1,7"
	b21/icon_state="2,1"
	b22/icon_state="2,2"
	b23/icon_state="2,3"
	b24/icon_state="2,4"
	b25/icon_state="2,5"
	b26/icon_state="2,6"
	b27/icon_state="2,7"
	b28/icon_state="2,8"
	b31/icon_state="3,1"
	b32/icon_state="3,2"
	b33/icon_state="3,3"
	b36/icon_state="3,6"
	b37/icon_state="3,7"
	b38/icon_state="3,8"
	b41/icon_state="4,1"
	b42/icon_state="4,2"
	b47/icon_state="4,7"
	b48/icon_state="4,8"
	b51/icon_state="5,1"
	b52/icon_state="5,2"
	b57/icon_state="5,7"
	b58/icon_state="5,8"
	b61/icon_state="6,1"
	b62/icon_state="6,2"
	b63/icon_state="6,3"
	b66/icon_state="6,6"
	b67/icon_state="6,7"
	b68/icon_state="6,8"
	b71/icon_state="7,1"
	b72/icon_state="7,2"
	b73/icon_state="7,3"
	b74/icon_state="7,4"
	b75/icon_state="7,5"
	b76/icon_state="7,6"
	b77/icon_state="7,7"
	b78/icon_state="7,8"
	b82/icon_state="8,2"
	b83/icon_state="8,3"
	b84/icon_state="8,4"
	b85/icon_state="8,5"
	b86/icon_state="8,6"
	b87/icon_state="8,7"

// world turfs
turf/world/grass
	icon='turf/world/grass.dmi'
	bfield="grass"
	worldmap=1

turf/world/lightgrass
	name="grass"
	icon='turf/world/lightgrass.dmi'
	bfield="grass"
	worldmap=1
	nwlg/icon_state="northwest"
	nlg/icon_state="north"
	nelg/icon_state="northeast"
	wlg/icon_state="west"
	clg/icon_state="center"
	elg/icon_state="east"
	swlg/icon_state="southwest"
	slg/icon_state="south"
	selg/icon_state="southeast"
	nwclg/icon_state="northwestcorner"
	neclg/icon_state="northeastcorner"
	swclg/icon_state="southwestcorner"
	seclg/icon_state="southeastcorner"

turf/world/desert
	name="desert"
	icon='turf/world/desert.dmi'
	bfield="desert"
	worldmap=1
	nwd/icon_state="northwest"
	nd/icon_state="north"
	ned/icon_state="northeast"
	wd/icon_state="west"
	cd/icon_state="center"
	ed/icon_state="east"
	swd/icon_state="southwest"
	sd/icon_state="south"
	sed/icon_state="southeast"
	nwcd/icon_state="northwestcorner"
	necd/icon_state="northeastcorner"
	swcd/icon_state="southwestcorner"
	secd/icon_state="southeastcorner"

turf/world/forest
	name="forest"
	icon='turf/world/forest.dmi'
	bfield="forest"
	worldmap=1
	nwf/icon_state="northwest"
	nf/icon_state="north"
	nef/icon_state="northeast"
	wf/icon_state="west"
	cf/icon_state="center"
	ef/icon_state="east"
	swf/icon_state="southwest"
	sf/icon_state="south"
	sef/icon_state="southeast"
	Entered(var/mob/p)
		set src in view(1)
		if(istype(p,/mob/PC)||istype(p,/obj/NPC/vehicule))
			if(!istype(src,/turf/world/forest/nef)&&!istype(src,/turf/world/forest/nwf)&&!istype(src,/turf/world/forest/sef)&&!istype(src,/turf/world/forest/swf)) p.icon_state="in"
		..()
	Exited(var/mob/p)
		p.icon_state="normal"
		..()

turf/world/river
	name="river"
	icon='turf/world/river.dmi'
	density=1
	var/req_hover
	nwr/{icon_state="northwest";req_hover = 1}
	nr/{icon_state="north";req_hover = 1}
	ner/{icon_state="northeast";req_hover = 1}
	wr/{icon_state="west";req_hover = 1}
	cr/{icon_state="center";req_hover = 1}
	er/{icon_state="east";req_hover = 1}
	swr/{icon_state="southwest";req_hover = 1}
	sr/{icon_state="south";req_hover = 1}
	ser/{icon_state="southeast";req_hover = 1}
	hr/{icon_state="riverh";req_hover = 1}
	vr/{icon_state="riverv";req_hover = 1}
	wfall/{icon_state="waterfall";req_hover = 1}
	hb{icon_state="bridgeh";density=0}
	srs{icon_state="rock1";req_hover=1}
	drs{icon_state="rock2";req_hover=1}
	trs{icon_state="rock3";req_hover=1}
	Enter(var/mob/PC/M)
		set src in view(1)
		if(req_hover)
			var/hover_owners
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/Hvrcraft/O in p.contents) if(O.special == "Hover") hover_owners++
			if(hover_owners >= length(M.party))
				var/state
				var/I = 'mob/vehicule/hovercraft.dmi'
				if(I)
					var/icon/Q = new(I)
					var/list/P = list()
					P += Q.IconStates()
					P += "normal"
					state = "normal"
					var/R = "hovercraft"
					if(R)
						var/obj/C = new
						C.icon = I
						C.icon_state = state
						M.layer = TURF_LAYER-1
						usr.overlays += C
					P += Q.IconStates()
				return 1
			else return 0
		else return ..()
	Exit(var/mob/PC/M)
		set src in view(1)
		if(req_hover)
			var/hover_owners
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/Hvrcraft/O in p.contents) if(O.special == "Hover") hover_owners++
			if(hover_owners >= length(M.party))
				M.layer = TURF_LAYER+1
				var/I = 'mob/vehicule/hovercraft.dmi'
				var/R = "hovercraft"
				M.icon -= I
				M.icon_state = "normal"
				M.overlays -= R
				M.BtlFrm("normal")
				return 1
			else return 0
		else return ..()

turf/world/mountain
	name="mountain"
	icon='turf/world/mountain.dmi'
	bfield="grass"
	worldmap=1
	density=1
	nwm/icon_state="northwest"
	nm/icon_state="north"
	nem/icon_state="northeast"
	wm/icon_state="west"
	cm/icon_state="center"
	em/icon_state="east"
	swm/icon_state="southwest"
	sm/icon_state="south"
	sem/icon_state="southeast"
	cavem{icon_state="cavern";density=0}
	spathm{icon_state="spathm";density=0}
	cpathm/icon_state="cpathm"
	npathm/icon_state="npathm"
	dnwm/icon_state="northwest_"
	dnm/icon_state="north_"
	dnem/icon_state="northeast_"
	dwm/icon_state="west_"
	dem/icon_state="east_"
	dswm/icon_state="southwest_"
	dsm/icon_state="south_"
	dsem/icon_state="southeast_"

turf/world/highmountain
	name="highmountain"
	icon='turf/world/highmountain.dmi'
	density=1
	n1hm/icon_state="north1"
	n1ehm/icon_state="north1east"
	n1whm/icon_state="north1west"
	n2c1hm/icon_state="north2center1"
	n2c2hm/icon_state="north2center2"
	n2ehm/icon_state="north2east"
	n2whm/icon_state="north2west"
	s1chm/icon_state="south1center"
	s1ehm/icon_state="south1east"
	s1shm/icon_state="south1west"
	s2ehm/icon_state="south2east"
	s2whm/icon_state="south2west"

turf/world/sea
	name="sea"
	var/req_bchocobo
	var/req_hover
	icon='turf/world/sea.dmi'
	bfield="grass"
	worldmap=1
	density=1
	nws{icon_state="northwest";density=0}
	ns{icon_state="north";req_bchocobo=1}
	nes{icon_state="northeast";density=0}
	ws{icon_state="west";req_bchocobo=1}
	cs{icon_state="center";req_bchocobo=1}
	es{icon_state="east";req_bchocobo=1}
	sws{icon_state="southwest";density=0}
	ss{icon_state="south";req_bchocobo=1}
	ses{icon_state="southeast";density=0}
	nwcs{icon_state="nw_corner";req_bchocobo=1}
	necs{icon_state="ne_corner";req_bchocobo=1}
	swcs{icon_state="sw_corner";req_bchocobo=1}
	secs{icon_state="se_corner";req_bchocobo=1}
	Enter(var/mob/PC/M)
		set src in view(1)
		if(req_bchocobo)
			var/choco_owners
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/BlkChoco/O in p.contents) if(O.special == "Fly") choco_owners++
			if(choco_owners >= length(M.party))
				var/state
				var/I = 'mob/vehicule/b_choco.dmi'
				if(I)
					var/icon/Q = new(I)
					var/list/P = list()
					P += Q.IconStates()
					P += "fly"
					state = "fly"
					var/R = "nomral"
					if(R)
						var/obj/C = new
						C.icon = I
						C.icon_state=state
						M.layer = TURF_LAYER-1
						usr.overlays += C
					P += Q.IconStates()
				return 1
			else return 0
		else return ..()
	Exit(var/mob/PC/M)
		set src in view(1)
		if(req_bchocobo)
			var/choco_owners
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/BlkChoco/O in p.contents) if(O.special == "Fly") choco_owners++
			if(choco_owners >= length(M.party))
				M.layer = TURF_LAYER+1
				var/I = 'mob/vehicule/b_choco.dmi'
				var/R = "b_choco"
				M.icon -= I
				M.icon_state = "normal"
				M.overlays -= R
				M.BtlFrm("normal")
				return 1
			else return 0
		else return ..()

turf/world/town
	icon='turf/world/town.dmi'
	necastle1{name="castle";icon_state="necastle1"}
	nwcastle1{name="castle";icon_state="nwcastle1"}
	secastle1{name="castle";icon_state="secastle1"}
	swcastle1{name="castle";icon_state="swcastle1"}
	necastle2{name="ruinedcastle";icon_state="necastle2"}
	nwcastle2{name="ruinedcastle";icon_state="nwcastle2"}
	secastle2{name="ruinedcastle";icon_state="secastle2"}
	swcastle2{name="ruinedcastle";icon_state="swcastle2"}
	shouse{name="house";icon_state="shouse"}
	village1{name="village";icon_state="village1"}
	village2{name="village";icon_state="village2"}

turf/world/babil
	icon='turf/world/babil.dmi'
	density=1
	lt_top{name="Tower of Bab-il";icon_state="lt_top"}
	rt_top{name="Tower of Bab-il";icon_state="rt_top"}
	lt{name="Tower of Bab-il";icon_state="lt"}
	rt{name="Tower of Bab-il";icon_state="rt"}
	lt_bot{name="Tower of Bab-il";icon_state="lt_bot"}
	rt_bot{name="Tower of Bab-il";icon_state="rt_bot"}
	lt_botdark{name="Tower of Bab-il";icon_state="lt_bot_"}
	rt_botdark{name="Tower of Bab-il";icon_state="rt_bot_"}
	zlt_top{name="Tower of Zot";icon_state="zot_lt_top"}
	zrt_top{name="Tower of Zot";icon_state="zot_rt_top"}
	zlt{name="Tower of Zot";icon_state="zot_lt"}
	zrt{name="Tower of Zot";icon_state="zot_rt"}
	zlt_bot{name="Tower of Zot";icon_state="zot_lt_bot"}
	zrt_bot{name="Tower of Zot";icon_state="zot_rt_bot"}

// moon turfs
turf/moon/ground
	name="ground"
	icon='turf/moon/floor.dmi'
	face/icon_state="face"
	crater_small/icon_state="cratersmall"
	crater_se/icon_state="crater_se"
	crater_sw/icon_state="crater_sw"
	crater_ne/icon_state="crater_ne"
	crater_nw/icon_state="crater_nw"
	crater_se2/icon_state="crater_se2"
	crater_sw2/icon_state="crater_sw2"
	crater_ne2/icon_state="crater_ne2"
	crater_nw2/icon_state="crater_nw2"
	rocks_se/icon_state="rocks_se"
	rocks_nw/icon_state="rocks_nw"
	rock_se/icon_state="rock_se"
	rock_se2/icon_state="rock_se2"
	rock_se3/icon_state="rock_se3"
	rock_sw/icon_state="rock_sw"
	rock_sw2/icon_state="rock_sw2"
	rock_sw3/icon_state="rock_sw3"
	rock_ne/icon_state="rock_ne"
	rock_ne2/icon_state="rock_ne2"
	rock_ne3/icon_state="rock_ne3"
	rock_nw/icon_state="rock_nw"
	rock_nw2/icon_state="rock_nw2"
	rock_nw3/icon_state="rock_nw3"
	hole_nw/icon_state="hole_nw"
	hole_ne/icon_state="hole_ne"
	hole_se/icon_state="hole_se"
	hole_sw/icon_state="hole_sw"
	splat_nw/icon_state="splat_nw"
	splat_sw/icon_state="splat_sw"
	splat_ne/icon_state="splat_ne"
	splat_se/icon_state="splat_se"
	floor/icon_state="floor"

turf/moon/mountain
	name="mountain"
	icon='turf/moon/mountains.dmi'
	density=1
	n/icon_state="n"
	w/icon_state="w"
	e/icon_state="e"
	s/icon_state="s"
	nw/icon_state="nw"
	ne/icon_state="ne"
	sw/icon_state="sw"
	se/icon_state="se"
	c/icon_state="c"
	single/icon_state="single"

turf/moon/platau
	name="platau"
	density=1
	icon='turf/moon/platau.dmi'
	Enter()
		if(type==/turf/moon/platau/cave&&usr.dir==2) return 0
		return ..()
	Exit()
		if(type==/turf/moon/platau/cave&&usr.dir==8) return 0
		return ..()
	nw/icon_state="nw"
	nw2/icon_state="nw2"
	n/icon_state="n"
	ne/icon_state="ne"
	ne2/icon_state="ne2"
	nec/icon_state="swc"
	e/icon_state="e"
	w/icon_state="w"
	wc/icon_state="wc"
	se/icon_state="se"
	seb/icon_state="seb"
	s/icon_state="s"
	swb/icon_state="swb"
	sw/icon_state="sw"
	e_edge/icon_state="e_edge"
	w_edge/icon_state="w_edge"
	cave{icon_state="cavedoor";density=0}
	slope{icon_state="slope";density=0}
	c{icon_state="c";density=0}

turf/moon/lunartower
	name="Lunar Tower"
	density=1
	icon='turf/moon/lunartower.dmi'
	top{icon_state="top";layer=MOB_LAYER+1;density=0}
	midu/icon_state="mid2"
	midd/icon_state="mid1"
	bottom/icon_state="bottom"
	nm{icon_state="nm";density=0}

turf/moon/lunartower
	name="Lunar Tower"
	density=1
	icon='turf/moon/lunartower.dmi'
	top{icon_state="top";layer=MOB_LAYER+1;density=0}
	midu/icon_state="mid2"
	midd/icon_state="mid1"
	bottom/icon_state="bottom"
	nm{icon_state="nm";density=0}

// underground turfs
turf/underworld/ground
	icon='turf/undrwrld/ug-ground.dmi'
	town
		town1{name="town";icon_state="town1"}
		town2{name="town";icon_state="town2"}
	ground{name="ground";icon_state="ground"}
	cracks
		bfield="underworld"
		cracksa1{name="ground";icon_state="cracksa1"}
		cracksa2{name="ground";icon_state="cracksa2"}
		cracksa3{name="ground";icon_state="cracksa3"}
		cracksb1{name="ground";icon_state="cracksb1"}
		cracksb2{name="ground";icon_state="cracksb2"}
		cracksb3{name="ground";icon_state="cracksb3"}
		cracksc1{name="ground";icon_state="cracksc1"}
		cracksc2{name="ground";icon_state="cracksc2"}
		cracksc3{name="ground";icon_state="cracksc3"}
	castle
		castle_nw{name="castle";icon_state="castle1"}
		castle_ne{name="castle";icon_state="castle2"}
		castle_sw{name="castle";icon_state="castle3"}
		castle_se{name="castle";icon_state="castle4"}
	sand
		bfield="underworld"
		sand_nw{name="sand";icon_state="sand1"}
		sand_n{name="sand";icon_state="sand2"}
		sand_ne{name="sand";icon_state="sand3"}
		sand_l{name="sand";icon_state="sand4"}
		center{name="sand";icon_state="sand5"}
		sand_r{name="sand";icon_state="sand6"}
		sand_sw{name="sand";icon_state="sand7"}
		sand_s{name="sand";icon_state="sand8"}
		sand_se{name="sand";icon_state="sand9"}
turf/underworld/platau
	name="platau"
	icon='turf/undrwrld/ug-plat.dmi'
	density=1
	top
		top1/icon_state="top1"
		top2/icon_state="top2"
		top3/icon_state="top3"
	leftside
		left1/icon_state="left1"
		left2/icon_state="left2"
		left3/icon_state="left3"
		left4/icon_state="left4"
		left5/icon_state="left5"
		left6/icon_state="left6"
		left7/icon_state="left7"
	bottom
		bottom1/icon_state="bottom1"
		bottom2/icon_state="bottom2"
		bottom3/icon_state="bottom3"
	rightside
		right1/icon_state="right1"
turf/underworld/platau
	var/req_airship
	name="platau"
	icon='turf/undrwrld/ug-plat.dmi'
	bfield="underworld"
	density=1
	top
		top1/icon_state="top1";req_airship=1
		top2/icon_state="top2";req_airship=1
		top3/icon_state="top3";req_airship=1
	leftside
		left1/icon_state="left1";req_airship=1
		left2/icon_state="left2";req_airship=1
		left3/icon_state="left3";req_airship=1
		left4/icon_state="left4";req_airship=1
		left5/icon_state="left5";req_airship=1
		left6/icon_state="left6";req_airship=1
		left7/icon_state="left7";req_airship=1
	bottom
		bottom1/icon_state="bottom1";req_airship=1
		bottom2/icon_state="bottom2";req_airship=1
		bottom3/icon_state="bottom3";req_airship=1
	rightside
		right1/icon_state="right1";req_airship=1
		right2/icon_state="right2";req_airship=1
		right3/icon_state="right3";req_airship=1
		right4/icon_state="right4";req_airship=1
		right5/icon_state="right5";req_airship=1
	cave{density=0;icon_state="cave"}
	ontop/icon_state="ontop";req_airship=1
	ontoplleft/icon_state="ontop2";req_airship=1
	Enter(var/mob/PC/M)
		set src in view(1)
		if(req_airship)
			var/ship_owners
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/Airship/O in p.contents) if(O.special == "Fly") ship_owners++
			if(ship_owners >= length(M.party))
				var/state
				var/I = 'mob/vehicule/airship.dmi'
				if(I)
					var/icon/Q = new(I)
					var/list/P = list()
					P += Q.IconStates()
					P += "fly"
					state = "fly"
					var/R = "nomral"
					if(R)
						var/obj/C = new
						C.icon = I
						C.icon_state=state
						M.layer = TURF_LAYER-1
						usr.overlays += C
					P += Q.IconStates()
				return 1
			else return 0
		else return ..()
	Exit(var/mob/PC/M)
		set src in view(1)
		if(req_airship)
			var/ship_owners
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/Airship/O in p.contents) if(O.special == "Fly") ship_owners++
			if(ship_owners >= length(M.party))
				M.layer = TURF_LAYER+1
				var/I = 'mob/vehicule/airship.dmi'
				var/R = "airship"
				M.icon -= I
				M.icon_state = "normal"
				M.overlays -= R
				M.BtlFrm("normal")
				return 1
			else return 0
		else return ..()
turf/underworld/wall
	name="wall"
	icon='turf/undrwrld/ug-wall.dmi'
	density = 1
	topwall
		twall1/icon_state = "twall1"
		twall2/icon_state = "twall2"
		twall3/icon_state = "twall3"
		twall4/icon_state = "twall4"
		twalt1/icon_state = "twalt1"
		twalt2/icon_state = "twalt2"
		twalt3/icon_state = "twalt3"
		twalt4/icon_state = "twalt4"
		twalr1/icon_state = "twalr1"
		twalr2/icon_state = "twalr2"
		twalr3/icon_state = "twalr3"
		twalr4/icon_state = "twalr4"
		tleftlava/icon_state = "tleftlava"
		tmidlava/icon_state = "tmidlava"
		trightlava/icon_state = "trightlava"
	bottom
		bleft/icon_state = "bleft"
		bleftlava/icon_state = "bleftlava"
		btop/icon_state = "btop"
		bright/icon_state = "bright"
		brightlava/icon_state = "brightlava"
	justwall/icon_state = "wall"
turf/underworld/lavaedge
	var/req_airship
	name="ground"
	icon='turf/undrwrld/lavaedge.dmi'
	density=1
	lava_nw/icon_state = "top1"
	lava_n/icon_state = "top2"
	lava_ne/icon_state = "top3"
	lava_nwcorner/icon_state = "left1"
	lava_w/icon_state = "left2"
	lava_swcorner/icon_state = "left3"
	lava_sw/icon_state = "bottom1"
	lava_s/icon_state = "bottom2"
	lava_se/icon_state = "bottom3"
	lava_secorner/icon_state = "right1"
	lava_e/icon_state = "right2"
	lava_necorner/icon_state = "right3"
	lava/icon='turf/undrwrld/lava.dmi';icon_state="center";req_airship=1
	Enter(var/mob/PC/M)
		set src in view(1)
		if(req_airship)
			var/ship_owners
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/Airship/O in p.contents) if(O.special == "Fly") ship_owners++
			if(ship_owners >= length(M.party))
				var/state
				var/I = 'mob/vehicule/airship.dmi'
				if(I)
					var/icon/Q = new(I)
					var/list/P = list()
					P += Q.IconStates()
					P += "fly"
					state = "fly"
					var/R = "nomral"
					if(R)
						var/obj/C = new
						C.icon = I
						C.icon_state=state
						M.layer = TURF_LAYER-1
						usr.overlays += C
					P += Q.IconStates()
				return 1
			else return 0
		else return ..()
	Exit(var/mob/PC/M)
		set src in view(1)
		if(req_airship)
			var/ship_owners
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/Airship/O in p.contents) if(O.special == "Fly") ship_owners++
			if(ship_owners >= length(M.party))
				M.layer = TURF_LAYER+1
				var/I = 'mob/vehicule/airship.dmi'
				var/R = "airship"
				M.icon -= I
				M.icon_state = "normal"
				M.overlays -= R
				M.BtlFrm("normal")
				return 1
			else return 0
		else return ..()
turf/underworld/misc
	icon='turf/undrwrld/ug-misc.dmi'
	density=1
	tower
		tower1{name="tower";icon_state="tower1"}
		tower2{name="tower";icon_state="tower2"}
		tower3{name="tower";icon_state="tower3"}
		tower4{name="tower";icon_state="tower4"}
	crater
		cratert1{name="crater";icon_state="crater1"}
		cratert2{name="crater";icon_state="crater2"}
		craterm1{name="crater";icon_state="crater3"}
		craterm2{name="crater";icon_state="crater4"}
		craterm3{name="crater";icon_state="crater5"}
		craterb1{name="crater";icon_state="crater6"}
		craterb2{name="crater";icon_state="crater7"}


// village turfs
turf/village/outdoor/bush
	name="bush"
	icon='turf/village/outdoor/bush.dmi'
	cb/icon_state="center"
	neb/icon_state="northeast"
	nwb/icon_state="northwest"
	seb/icon_state="southeast"
	swb/icon_state="southwest"
	Entered(var/mob/p)
		set src in view(1)
		if(istype(p,/mob/PC)||istype(p,/obj/NPC/vehicule)) p.icon_state="in"
			//return ..()
		//else return 0
		..()
	Exited(var/mob/p)
		p.icon_state="normal"
		//return ..()
		..()

turf/village/outdoor/floor
	icon='turf/village/outdoor/floor.dmi'
	Enter()
		if(type==/turf/village/outdoor/floor/grassb&&usr.dir==1) return 0
		return ..()
	Exit()
		if(type==/turf/village/outdoor/floor/grassb&&usr.dir==2) return 0
		return ..()
	grassf{name="grass";icon_state="grass"}
	grassb{name="grass";icon_state="grassb";layer=MOB_LAYER+1}
	sgf{name="grass";icon_state="shadowgrass"}
	endsgf{name="grass";icon_state="endshadowgrass"}
	sand{name="sand";icon_state="sand"}
	rockf{name="rock";icon_state="rock"}
	srf{name="rock";icon_state="shadowrock"}
	endsrf{name="rock";icon_state="endshadowrock"}
	sstair{name="stair";icon_state="sstair"}
	stair{name="stair";icon_state="stair"}

turf/village/outdoor/house
	name="house"
	icon='turf/village/outdoor/house.dmi'
	density=1
	blrh/icon_state="blueleftroof"
	brrh/icon_state="bluerightroof"
	brh/icon_state="blueroof"
	fph/icon_state="fireplace"
	glrh/icon_state="greenleftroof"
	grrh/icon_state="greenrightroof"
	grh/icon_state="greenroof"
	lah/icon_state="leftarch"
	lrh/icon_state="leftroof"
	lwh/icon_state="leftwall"
	nlrh/icon_state="nleftroof"
	nrrh/icon_state="nrightroof"
	ntlh/icon_state="ntopleftroof"
	ntrh/icon_state="ntoprightroof"
	rlrh/icon_state="redleftroof"
	rrrh/icon_state="redrightroof"
	rdrh/icon_state="redroof"
	rah/icon_state="rightarch"
	rrh/icon_state="rightroof"
	rwh/icon_state="rightwall"
	rh/icon_state="roof"
	tlah/icon_state="topleftarch"
	tlrh/icon_state="topleftroof"
	tlwh/icon_state="topleftwall"
	trah/icon_state="toprightarch"
	trrh/icon_state="toprightroof"
	trwh/icon_state="toprightwall"
	trh/icon_state="toproof"
	twh/icon_state="topwall"
	twwh/icon_state="topwallwindow"
	wh/icon_state="wall"
	wwh/icon_state="wallwindow"

turf/village/outdoor/misc
	icon='turf/village/outdoor/misc.dmi'
	pot{icon_state="pot";density=1}
	tree{icon_state="tree";density=1}
	well{icon_state="well";density=1}

turf/village/outdoor/river
	Enter()
		if(istype(src,/turf/village/outdoor/river/riverhr)&&(usr.dir==1||usr.dir==2)) {return 0;src.verbs-=/mob/PC/proc/join_party}
		else if(istype(src,/turf/village/outdoor/river/rivervr)&&(usr.dir==4||usr.dir==8)) {return 0;src.verbs-=/mob/PC/proc/join_party}
		else if(istype(src,/turf/village/outdoor/river/ner)&&(usr.dir==2||usr.dir==8)) {return 0;src.verbs-=/mob/PC/proc/join_party}
		else if(istype(src,/turf/village/outdoor/river/nwr)&&(usr.dir==2||usr.dir==4)) {return 0;src.verbs-=/mob/PC/proc/join_party}
		else if(istype(src,/turf/village/outdoor/river/ser)&&(usr.dir==1||usr.dir==8)) {return 0;src.verbs-=/mob/PC/proc/join_party}
		else if(istype(src,/turf/village/outdoor/river/swr)&&(usr.dir==1||usr.dir==4)) {return 0;src.verbs-=/mob/PC/proc/join_party}
		else if(istype(src,/turf/village/outdoor/river/sr)&&(usr.dir==1)) {return 0;src.verbs-=/mob/PC/proc/join_party}
		else if(istype(src,/turf/village/outdoor/river/nr)&&(usr.dir==2)) {return 0;src.verbs-=/mob/PC/proc/join_party}
		else if(istype(src,/turf/village/outdoor/river/wr)&&(usr.dir==4)) {return 0;src.verbs-=/mob/PC/proc/join_party}
		else if(istype(src,/turf/village/outdoor/river/er)&&(usr.dir==8)) {return 0;src.verbs-=/mob/PC/proc/join_party}

		return ..()
	Exit()
		if(istype(src,/turf/village/outdoor/river/riverhr)&&(usr.dir==1||usr.dir==2)) return 0
		else if(istype(src,/turf/village/outdoor/river/rivervr)&&(usr.dir==4||usr.dir==8)) return 0
		else if(istype(src,/turf/village/outdoor/river/ner)&&(usr.dir==1||usr.dir==4)) return 0
		else if(istype(src,/turf/village/outdoor/river/nwr)&&(usr.dir==1||usr.dir==8)) return 0
		else if(istype(src,/turf/village/outdoor/river/ser)&&(usr.dir==2||usr.dir==4)) return 0
		else if(istype(src,/turf/village/outdoor/river/swr)&&(usr.dir==2||usr.dir==8)) return 0
		else if(istype(src,/turf/village/outdoor/river/sr)&&(usr.dir==2)) return 0
		else if(istype(src,/turf/village/outdoor/river/nr)&&(usr.dir==1)) return 0
		else if(istype(src,/turf/village/outdoor/river/wr)&&(usr.dir==8)) return 0
		else if(istype(src,/turf/village/outdoor/river/er)&&(usr.dir==4)) return 0
		return ..()
	name="river"
	icon='turf/village/outdoor/river.dmi'
	cr/icon_state="center"
	er/icon_state="east"
	nr/icon_state="north"
	ner/icon_state="northeast"
	nwr/icon_state="northwest"
	sr/icon_state="south"
	ser/icon_state="southeast"
	swr/icon_state="southwest"
	wr/icon_state="west"
	toriverr/icon_state="toriver"
	riverhr/icon_state="riverh"
	rivervr/icon_state="riverv"
	wfr/icon_state="waterfall"
	wfsr/icon_state="wfall_splash"
	Entered(var/mob/p)
		set src in view(1)
		if(istype(p,/mob/PC)||istype(p,/obj/NPC/vehicule)) p.icon_state="in"
		..()
	Exited(var/mob/p)
		p.icon_state="normal"

turf/village/outdoor/bridge
	name="bridge"
	icon='turf/village/outdoor/river.dmi'
	bridgehr/icon_state="bridgeh"
	bridgevr/icon_state="bridgev"

turf/village/outdoor/slope
	name="slope"
	icon='turf/village/outdoor/slope.dmi'
	density=1
	es/icon_state="east"
	ns/icon_state="north"
	nes/icon_state="northeast"
	nws/icon_state="northwest"
	ss/icon_state="south"
	ses/icon_state="southeast"
	secs/icon_state="southeastcorner"
	sws/icon_state="southwest"
	swcs/icon_state="southwestcorner"
	ws/icon_state="west"

turf/village/outdoor/tree
	name="tree"
	icon='turf/village/outdoor/tree.dmi'
	density=1
	ctree/icon_state="center"
	etree/icon_state="east"
	ntree/icon_state="north"
	singletree/icon_state="single"
	stree/icon_state="south"
	setree/icon_state="southeast"
	swtree/icon_state="southwest"
	wtree/icon_state="west"

turf/village/outdoor/wall
	name="wall"
	icon='turf/village/outdoor/wall.dmi'
	density=1
	cuwall{icon_state="center";layer=MOB_LAYER+1;density=0}
	cwall/icon_state="center"
	eewall/icon_state="eastend"
	lewall/icon_state="leftend"
	necwall/icon_state="northeastcorner"
	newall/icon_state="northend"
	nwcwall/icon_state="northwestcorner"
	rewall/icon_state="rightend"
	secwall/icon_state="southeastcorner"
	sewall/icon_state="southend"
	swcwall/icon_state="southwestcorner"
	whuwall{icon_state="wallh";layer=MOB_LAYER+1;density=0}
	whwall/icon_state="wallh"
	wvwall/icon_state="wallv"
	wewall/icon_state="westend"
	wwall/icon_state="window"

// house turfs
turf/village/indoor/carpet
	name="carpet"
	icon='turf/village/indoor/carpet.dmi'
	ccarpet/icon_state= "center"
	ecarpet/icon_state= "east"
	ncarpet/icon_state= "north"
	necarpet/icon_state= "northeast"
	nwcarpet/icon_state= "northwest"
	scarpet/icon_state= "south"
	secarpet/icon_state= "southeast"
	swcarpet/icon_state= "southwest"
	wcarpet/icon_state= "west"

turf/village/indoor/fireplace
	name="fireplace"
	icon='turf/village/indoor/fireplace.dmi'
	density=1
	cfp/icon_state="center"
	ffp/icon_state="fire"
	lfp/icon_state="left"
	rfp/icon_state="right"
	tfp/icon_state="top"
	tlfp/icon_state="topleft"
	trfp/icon_state="topright"

turf/village/indoor/floor
	icon='turf/village/indoor/floor.dmi'
	rock/icon_state= "rock"

turf/village/indoor/wall
	name="wall"
	icon='turf/village/indoor/wall.dmi'
	density=1
	candle{name="candle";icon_state="candle"}
	utopwall{icon_state="topwall"}
	topwall{icon_state="topwall";layer=MOB_LAYER+1}
	wall/icon_state="wall"
	halfwall{icon_state="halfwall";density=0}
	undertw{icon_state="topwall";density=0;layer=MOB_LAYER+1}
	underw{icon_state="wall";density=0;layer=MOB_LAYER+1}

// castle turfs
turf/castle/outdoor/floor
	name="floor"
	icon='turf/castle/outdoor/floor.dmi'
	bfield="castle"
	floor/icon_state="floor"
	sfloor/icon_state="shadow_floor"
	esfloor/icon_state="end_shadow_floor"
	bfloor/icon_state="broken_floor"
	stair/icon_state="stair"
	h_stair/icon_state="h_stair"
	grass/icon_state="grass"
	tgrass/icon_state="tallgrass"
	sand/icon_state="sand"
	st{icon_state="statue_top";density=1}
	sb{icon_state="statue_bottom";density=1}

turf/castle/outdoor/forest
	name="forest"
	density=1
	icon='turf/castle/outdoor/forest.dmi'
	n_forest/icon_state="n_forest"
	ne_forest/icon_state="ne_forest"
	nw_forest/icon_state="nw_forest"
	c_forest/icon_state="c_forest"
	s_forest/icon_state="s_forest"
	se_forest/icon_state="se_forest"
	sw_forest/icon_state="sw_forest"

turf/castle/outdoor/river
	name="river"
	icon='turf/castle/outdoor/river.dmi'
	density=0
	river/icon_state="river"
	corner/icon_state="corner"
	icorner/icon_state="inner_corner"
	north/icon_state="north_river"
	west/icon_state="west_river"
	Entered(var/mob/p)
		set src in view(1)
		if(istype(p,/mob/PC)||istype(p,/obj/NPC/vehicule)) p.icon_state="in"
			//return ..()
		//else return 0
		..()
	Exited(var/mob/p)
		p.icon_state="normal"
		//return ..()
		..()

turf/castle/outdoor/tower
	name="tower"
	icon='turf/castle/outdoor/tower.dmi'
	density=1
	bfield="castle"
	tult/icon_state="top_upper_left_tower"
	turt/icon_state="top_upper_right_tower"
	tllt/icon_state="top_lower_left_tower"
	tlrt/icon_state="top_lower_right_tower"
	lt/icon_state="left_tower"
	lwt/icon_state="left_window_tower"
	rt/icon_state="right_tower"
	rwt/icon_state="right_window_tower"
	blt/icon_state="bottom_left_tower"
	brt/icon_state="bottom_right_tower"

turf/castle/outdoor/tower2
	name="tower"
	icon='turf/castle/outdoor/tower2.dmi'
	density=1
	bfield="castle"
	tult/icon_state="top_upper_left_tower2"
	tut/icon_state="top_upper_tower2"
	turt/icon_state="top_upper_right_tower2"
	tllt/icon_state="top_lower_left_tower2"
	tlt/icon_state="top_lower_tower2"
	tlrt/icon_state="top_lower_right_tower2"
	lt/icon_state="left_tower2"
	t/icon_state="tower2"
	rt/icon_state="right_tower2"
	lwt/icon_state="left_window_tower2"
	wt/icon_state="window_tower2"
	rwt/icon_state="right_window_tower2"
	blt/icon_state="bottom_left_tower2"
	bt/icon_state="bottom_tower2"
	brt/icon_state="bottom_right_tower2"

turf/castle/outdoor/wall
	name="wall"
	icon='turf/castle/outdoor/wall.dmi'
	density=1
	bfield="castle"
	tulr/icon_state="top_upper_left_roof"
	tur/icon_state="top_upper_roof"
	undertur{icon_state="top_upper_roof";density=0;layer=MOB_LAYER+1}
	turr/icon_state="top_upper_right_roof"
	tlr/icon_state="top_left_roof"
	tr/icon_state="top_roof"
	undertr{icon_state="top_roof";density=0;layer=MOB_LAYER+1}
	trr/icon_state="top_right_roof"
	lw/icon_state="left_wall"
	w/icon_state="wall"
	underw{icon_state="wall";density=0;layer=MOB_LAYER+1}
	rw/icon_state="right_wall"
	lwe/icon_state="left_wall_end"
	sign/icon_state="sign"
	window/icon_state="window"
	htuw/icon_state="h_top_upper_wall"
	htb/icon_state="h_top_b"
	htw/icon_state="h_top_wall"
	hbw/icon_state="h_bottom_wall"
	vtb/icon_state="v_top_b"
	vtw/icon_state="v_top_wall"
	vtsw/icon_state="v_top_shadow_wall"
	tb{icon_state="top_barrier";density=0;layer=MOB_LAYER+1}
	bh{icon_state="bottom_barrier";density=0}
	tds/icon_state="top_doorstep"
	bds/icon_state="bottom_doorstep"
	torch/icon_state="torch"
	bvtw/icon_state="broken_v_top_wall"
	bvtb/icon_state="broken_v_top_b"
	bw/icon_state="broken_wall"

turf/castle/indoor/carpet
	name="carpet"
	icon='turf/castle/indoor/carpet.dmi'
	bfield="castle"
	lc/icon_state="left_carpet"
	c/icon_state="carpet"
	rc/icon_state="right_carpet"
	lcs/icon_state="left_carpet_stair"
	cs/icon_state="carpet_stair"
	rcs/icon_state="right_carpet_stair"

turf/castle/indoor/floor
	name="floor"
	icon='turf/castle/indoor/floor.dmi'
	bfield="castle"
	f/icon_state="floor"
	bf/icon_state="broken_floor"

turf/castle/indoor/pillar
	name="pillar"
	icon='turf/castle/indoor/pillar.dmi'
	layer=MOB_LAYER+1
	bfield="castle"
	lp{icon_state="lower_pillar";density=1}
	p/icon_state="pillar"
	tp/icon_state="top_pillar"
	bp/icon_state="broken_pillar"

turf/castle/indoor/throne
	name="throne"
	icon='turf/castle/indoor/throne.dmi'
	bfield="castle"
	tt{icon_state="top_throne";density=0}
	lt/icon_state="left_throne"
	t/icon_state="throne"
	rt/icon_state="right_throne"

turf/castle/indoor/underground
	name="wall"
	icon='turf/castle/indoor/underground.dmi'
	density=1
	bfield="castle"
	twall/icon_state="topwall"
	wall/icon_state="wall"
	torch/icon_state="torch"

turf/castle/indoor/wall
	name="wall"
	icon='turf/castle/indoor/wall.dmi'
	density=1
	bfield="castle"
	bh{icon_state="bottom_half";density=0}
	th/icon_state="top_half"
	sw/icon_state="side_wall"
	wall/icon_state="wall"
	b{icon_state="barrier";density=0}
	underw{icon_state="wall";density=0;layer=MOB_LAYER+1}
	topwall{icon_state="topwall";layer=MOB_LAYER+1}
	undertw{icon_state="topwall";density=0;layer=MOB_LAYER+1}
	torch/icon_state="torch"
	tb{icon_state="top_barrier";density=0;layer=MOB_LAYER+1}
	lb{icon_state="lower_barrier";layer=MOB_LAYER+1}
	tf/icon_state="top_flag"
	lf/icon_state="lower_flag"
	sign/icon_state="sign"
	tlbw/icon_state="top_left_broken_wall"
	trbw/icon_state="top_right_broken_wall"
	blbw/icon_state="bottom_left_broken_wall"
	brbw/icon_state="bottom_right_broken_wall"
	tbw/icon_state="top_broken_wall"
	bw/icon_state="broken_wall"

//cave turfs
turf/cave/floor
	name="ground"
	icon='turf/cave/floor.dmi'
	bfield="cave"
	ground/icon_state="ground"
	sground/icon_state="shadow_ground"
	stair/icon_state="stair"

turf/cave/river
	name="river"
	icon='turf/cave/river.dmi'
	bfield="river"
	density=0
	water/icon_state="water"
	waterfall{icon_state="waterfall";density=1;layer=MOB_LAYER+1}
	wfall_start{icon_state="wfall_start";density=1;layer=MOB_LAYER+1}
	wfall_splash/icon_state="wfall_splash"
	Entered(var/mob/p)
		set src in view(1)
		if(istype(src,/turf/cave/river)) p.icon_state="in"
		..()
	Exited(var/mob/p)
		p.icon_state="normal"
		..()


turf/cave/struct
	icon='turf/cave/struct.dmi'
	density=1
	bfield="cave"
	Enter()
		if(type==/turf/cave/struct/west&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/northwest&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/northwest&&usr.dir==2) return 0
		else if(type==/turf/cave/struct/north&&usr.dir==2) return 0
		else if(type==/turf/cave/struct/northeast&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/northeast&&usr.dir==2) return 0
		else if(type==/turf/cave/struct/east&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/southeast&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/southeast&&usr.dir==1) return 0
		else if(type==/turf/cave/struct/southwest&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/southwest&&usr.dir==1) return 0
		return ..()
	Exit()
		if(type==/turf/cave/struct/west&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/northwest&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/northwest&&usr.dir==1) return 0
		else if(type==/turf/cave/struct/north&&usr.dir==1) return 0
		else if(type==/turf/cave/struct/northeast&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/northeast&&usr.dir==1) return 0
		else if(type==/turf/cave/struct/east&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/southeast&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/southeast&&usr.dir==2) return 0
		else if(type==/turf/cave/struct/southwest&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/southwest&&usr.dir==2) return 0
		return ..()
	northwest{name="ground";icon_state="northwest";density=0}
	north{name="ground";icon_state="north";density=0}
	northeast{name="ground";icon_state="northeast";density=0}
	west{name="ground";icon_state="west";density=0}
	east{name="ground";icon_state="east";density=0}
	southwest{name="ground";icon_state="southwest";density=0}
	south{name="ground";icon_state="south";density=0}
	southeast{name="ground";icon_state="southeast";density=0}
	wall/icon_state="wall"
	lwall1{name="wall";icon_state="left_wall1"}
	rwall1{name="wall";icon_state="right_wall1"}
	lwall2{name="wall";icon_state="left_wall2"}
	rwall2{name="wall";icon_state="right_wall2"}
	blwall{name="wall";icon_state="bottom_left_wall"}
	bwall{name="wall";icon_state="bottom_wall"}
	brwall{name="wall";icon_state="bottom_right_wall"}
	blwall2_top{name="wall";icon_state="bottom_left_wall2_top"}
	blwall2_bottom{name="wall";icon_state="bottom_left_wall2_bottom"}
	bwall2{name="wall";icon_state="bottom_wall2"}
	brwall2_top{name="wall";icon_state="bottom_right_wall2_top"}
	brwall2_bottom{name="wall";icon_state="bottom_right_wall2_bottom"}
	outer_west{name="wall";icon_state="outer_west"}
	outer_west_bottom{name="wall";icon_state="outer_west_bottom"}
	outer_east{name="wall";icon_state="outer_east"}
	outer_east_bottom{name="wall";icon_state="outer_east_bottom"}

turf/cave/wall
	name="wall"
	icon='turf/cave/wall.dmi'
	density=1
	bfield="cave"
	northwest/icon_state="northwest"
	north/icon_state="north"
	northeast/icon_state="northeast"
	west/icon_state="west"
	east/icon_state="east"
	southwest/icon_state="southwest"
	south/icon_state="south"
	southeast/icon_state="southeast"
	northwestcorner/icon_state="northwestcorner"
	northeastcorner/icon_state="northeastcorner"
	southwestcorner/icon_state="southwestcorner"
	southeastcorner/icon_state="southeastcorner"
	left_wall/icon_state="left_wall"
	wall/icon_state="wall"
	right_wall/icon_state="right_wall"
	bottom_left_wall/icon_state="bottom_left_wall"
	bottom_wall/icon_state="bottom_wall"
	bottom_right_wall/icon_state="bottom_right_wall"
	top_north_passage{name="passage";icon_state="top_north_passage"}
	north_passage{name="passage";icon_state="north_passage";density=0}
	north_passage_top_stair{name="stair";icon_state="north_passage_top_stair";density=0}
	north_passage_bottom_stair{name="stair";icon_state="north_passage_bottom_stair";density=0}
	south_passage{name="passage";icon_state="south_passage"}
	south_passage_stair{name="stair";icon_state="south_passage_stair";density=0}

turf/cave/misc
	icon='turf/cave/misc.dmi'
	bfield="cave"
	Enter()
		if(istype(src,/turf/cave/misc/bridgeh)&&(usr.dir==1||usr.dir==2)) return 0
		else if(istype(src,/turf/cave/misc/bridgev)&&(usr.dir==4||usr.dir==8)) return 0
		return ..()
	Exit()
		if(istype(src,/turf/cave/misc/bridgeh)&&(usr.dir==1||usr.dir==2)) return 0
		else if(istype(src,/turf/cave/misc/bridgev)&&(usr.dir==4||usr.dir==8)) return 0
		return ..()
	rock{icon_state="rock";density=1}
	stair_top/icon_state="stair_top"
	stair/icon_state="stair"
	stair_bottom{name="stair";icon_state="stair_bottom"}
	bridgev{name="bridge";icon_state="bridgev"}
	bridgeh{name="bridge";icon_state="bridgeh"}
	bridgeh_basel{name="bridge";icon_state="bridgeh_basel";density=1}
	bridgeh_baser{name="bridge";icon_state="bridgeh_baser";density=1}
	fieldp{name="field pillar";icon_state="fieldp";density=1}

//magnes turfs
turf/elfcave
	encounter_group=17
	bfield="magnes"
	floor{name = "ground";icon = 'turf/elfcave/ground-cliff.dmi';icon_state = "ground";density = 0}

turf/elfcave/cliff
	name = "ground"
	icon = 'turf/elfcave/ground-cliff.dmi'
	density = 0
	north{icon_state = "n"}
	northeast1{icon_state = "ne1"}
	northeast2{icon_state = "ne2";name = "cliff"}
	east1{icon_state = "e1"}
	east2{icon_state = "e2"}
	southeast{icon_state = "se";name = "cliff"}
	southeast_bottom1{icon_state = "se-b1";density = 1;name = "cliff"}
	southeast_bottom2{icon_state = "se-b2";density = 1;name = "cliff"}
	south{icon_state = "s"}
	south_bottom1{icon_state = "s-b1";density = 1;name = "cliff"}
	south_bottom2{icon_state = "s-b2";density = 1;name = "cliff"}
	southwest{icon_state = "sw";name = "cliff"}
	southwest_bottom1{icon_state = "sw-b1";density = 1;name = "cliff"}
	southwest_bottom2{icon_state = "sw-b2";density = 1;name = "cliff"}
	west1{icon_state = "w1"}
	west2{icon_state = "w2"}
	northwest1{icon_state = "nw1"}
	northwest2{icon_state = "nw2"; name = "cliff"}

turf/elfcave/object
	icon = 'turf/elfcave/ground-cliff.dmi'
	density = 0
	bones1{icon_state = "skel-1"; name = "skeleton"}
	bones2{icon_state = "skel-2"; name = "skeleton"}
	rocks{icon_state = "rocks"; name = "rocks"}
	stalag_n{icon_state = "stalag-n"; name = "rock";density = 1}
	stalag_s{icon_state = "stalag-s"; name = "rock";density = 1}
	torch{icon = 'turf/elfcave/wall.dmi';icon_state = "torch";name = "torch";density = 1}
	bigtorch_n{icon_state = "bigtorch-n";layer = MOB_LAYER + 1;name = "torch"}
	bigtorch_mid{icon_state = "bigtorch-mid";density = 1;name = "torch"}
	bigtorch_s{icon_state = "bigtorch-s";name = "torch"}
	crate{icon_state = "crate"; name = "crate";density = 1}

turf/elfcave/bridge
	icon = 'turf/elfcave/bridge.dmi'
	density = 1
	name = "bridge"
	east_west{icon_state = "h";density = 0}
	north_south{icon_state = "v";density = 0}
	n_s_stairs{icon_state = "v-stairs";density = 0}
	n_s_half{icon_state = "vhalf";density = 0}
	supports
		northeast{icon_state = "ne"}
		northwest{icon_state = "nw"}
		east{icon_state = "e"}
		west{icon_state = "w"}
		southeast{icon_state = "se"}
		southwest{icon_state = "sw"}

turf/elfcave/wall
	icon = 'turf/elfcave/wall.dmi'
	density = 1
	name = "wall"
	roof
		north{icon_state = "roof-n"}
		northeast1{icon_state = "roof-ne1"}
		northeast2{icon_state = "roof-ne2"}
		northwest1{icon_state = "roof-nw1"}
		northwest2{icon_state = "roof-nw2"}
		west{icon_state = "roof-w"}
		east{icon_state = "roof-e"}
		southeast1{icon_state = "roof-se1";layer = MOB_LAYER + 1}
		southeast2{icon_state = "roof-se2"}
		southwest1{icon_state = "roof-sw1";layer = MOB_LAYER + 1}
		southwest2{icon_state = "roof-sw2"}
		south{icon_state = "roof-s"}
		roof{icon_state = "roof"}
		under_n{icon_state = "roof-u-n";layer = MOB_LAYER + 1;density = 0}
		under_s{icon_state = "roof-u-s";layer = MOB_LAYER + 1;density = 0}
		southeast3{icon_state = "roof-se3"}
		southwest3{icon_state = "roof-sw3"}
	eastedge1{icon_state = "e-edge1";layer = MOB_LAYER + 1}
	eastedge1a{icon_state = "e-edge1a";layer = MOB_LAYER + 1}
	eastedge2{icon_state = "e-edge2";layer = MOB_LAYER + 1; density = 0}
	eastedge3{icon_state = "e-edge3"}
	eastedge4{icon_state = "e-edge4";density = 0}
	westedge1{icon_state = "w-edge1";layer = MOB_LAYER + 1}
	westedge1a{icon_state = "w-edge1a";layer = MOB_LAYER + 1}
	westedge2{icon_state = "w-edge2";layer = MOB_LAYER + 1;density = 0}
	westedge3{icon_state = "w-edge3"}
	westedge4{icon_state = "w-edge4";density = 0}
	midwall1{icon_state = "wall1"}
	midwall2{icon_state = "wall2"}
	midwall3{icon_state = "wall3"; density = 0}
	westwall1{icon_state = "w-wall1"}
	westwall2{icon_state = "w-wall2"}
	westwall3{icon_state = "w-wall3"}
	eastwall1{icon_state = "ewall1"}
	eastwall2{icon_state = "ewall2"}
	eastwall3{icon_state = "ewall3"}

turf/elfcave/doors
	icon = 'turf/elfcave/doors.dmi'
	density = 0
	name = "passage"
	big_passage_s
		northwest{icon_state = "s-nw";density = 1}
		north{icon_state = "s-n";layer = MOB_LAYER + 1}
		northeast{icon_state = "s-ne";density = 1}
		west{icon_state = "s-w"; density = 1}
		middle{icon_state = "s-mid"}
		east{icon_state = "s-e"; density = 1}
		southwest{icon_state = "s-sw"; density = 1}
		south{icon_state = "s-s"}
		southeast{icon_state = "s-se"; density = 1}
	big_passage_n
		northwest{icon_state = "bign-nw";layer = MOB_LAYER + 1}
		northeast{icon_state = "bign-ne";layer = MOB_LAYER + 1}
		east{icon_state = "bign-e";density = 1}
		middle{icon_state = "bign-mid"}
		west{icon_state = "bign-w";density = 1}
		southwest{icon_state = "bign-sw";density = 1}
		south{icon_state = "bign-s";layer = MOB_LAYER + 1}
		southeast{icon_state = "bign-se";density = 1}
	passage_n
		west{icon_state = "n-w";density = 1}
		middle{icon_state = "n-mid";layer = MOB_LAYER + 1}
		east{icon_state = "n-e";density = 1}
		thingy{icon_state = "thingy";density = 1}
	door{icon_state = "door"}

//sealed cave

turf/sealedcave
	floor{name = "ground";icon = 'turf/sealedcave/ground-cliff.dmi';icon_state = "ground";density = 0;bfield="cavemagnes"}
	cliff
		name = "ground"
		icon = 'turf/sealedcave/ground-cliff.dmi'
		density = 0
		north{icon_state = "n"}
		northeast1{icon_state = "ne1"}
		northeast2{icon_state = "ne2";name = "cliff"}
		east1{icon_state = "e1"}
		east2{icon_state = "e2"}
		southeast{icon_state = "se";name = "cliff"}
		southeast_bottom1{icon_state = "se-b1";density = 1;name = "cliff"}
		southeast_bottom2{icon_state = "se-b2";density = 1;name = "cliff"}
		south{icon_state = "s"}
		south_bottom1{icon_state = "s-b1";density = 1;name = "cliff"}
		south_bottom2{icon_state = "s-b2";density = 1;name = "cliff"}
		southwest{icon_state = "sw";name = "cliff"}
		southwest_bottom1{icon_state = "sw-b1";density = 1;name = "cliff"}
		southwest_bottom2{icon_state = "sw-b2";density = 1;name = "cliff"}
		west1{icon_state = "w1"}
		west2{icon_state = "w2"}
		northwest1{icon_state = "nw1"}
		northwest2{icon_state = "nw2"; name = "cliff"}
	object
		icon = 'turf/sealedcave/ground-cliff.dmi'
		density = 0
		bones1{icon_state = "skel-1"; name = "skeleton"}
		bones2{icon_state = "skel-2"; name = "skeleton"}
		rocks{icon_state = "rocks"; name = "rocks"}
		stalag_n{icon_state = "stalag-n"; name = "rock";density = 1}
		stalag_s{icon_state = "stalag-s"; name = "rock";density = 1}
		torch{icon = 'turf/sealedcave/wall.dmi';icon_state = "torch";name = "torch";density = 1}
		bigtorch_n{icon_state = "bigtorch-n";layer = MOB_LAYER + 1;name = "torch"}
		bigtorch_mid{icon_state = "bigtorch-mid";density = 1;name = "torch"}
		bigtorch_s{icon_state = "bigtorch-s";name = "torch"}
		crate{icon_state = "crate"; name = "crate";density = 1}
	bridge
		icon = 'turf/sealedcave/bridge.dmi'
		bfield="cavemagnes"
		density = 1
		name = "bridge"
		rope{icon_state = "rope";density = 0;name = "rope"}
		rope_dropoff{icon_state = "rope-b"; name = "rope"; density = 0}
		rope_anchor{icon_state = "rope-s"; name = "rope"; density = 0}
		rope_north{icon_state = "rope-n"; name = "rope"; density = 0}
		east_west{icon_state = "h";density = 0}
		north_south{icon_state = "v";density = 0}
		n_s_stairs{icon_state = "v-stairs";density = 0}
		n_s_half{icon_state = "vhalf";density = 0}
		supports
			northeast{icon_state = "ne"}
			northwest{icon_state = "nw"}
			east{icon_state = "e"}
			west{icon_state = "w"}
			southeast{icon_state = "se"}
			southwest{icon_state = "sw"}
	wall
		icon = 'turf/sealedcave/wall.dmi'
		density = 1
		name = "wall"
		roof
			north{icon_state = "roof-n"}
			northeast1{icon_state = "roof-ne1"}
			northeast2{icon_state = "roof-ne2"}
			northwest1{icon_state = "roof-nw1"}
			northwest2{icon_state = "roof-nw2"}
			west{icon_state = "roof-w"}
			east{icon_state = "roof-e"}
			southeast1{icon_state = "roof-se1";layer = MOB_LAYER + 1}
			southeast2{icon_state = "roof-se2"}
			southwest1{icon_state = "roof-sw1";layer = MOB_LAYER + 1}
			southwest2{icon_state = "roof-sw2"}
			south{icon_state = "roof-s"}
			roof{icon_state = "roof"}
			under_n{icon_state = "roof-u-n";layer = MOB_LAYER + 1;density = 0}
			under_s{icon_state = "roof-u-s";layer = MOB_LAYER + 1;density = 0}
			southeast3{icon_state = "roof-se3"}
			southwest3{icon_state = "roof-sw3"}
		eastedge1{icon_state = "e-edge1";layer = MOB_LAYER + 1}
		eastedge1a{icon_state = "e-edge1a";layer = MOB_LAYER + 1}
		eastedge2{icon_state = "e-edge2";layer = MOB_LAYER + 1; density = 0}
		eastedge3{icon_state = "e-edge3"}
		eastedge4{icon_state = "e-edge4";density = 0}
		westedge1{icon_state = "w-edge1";layer = MOB_LAYER + 1}
		westedge1a{icon_state = "w-edge1a";layer = MOB_LAYER + 1}
		westedge2{icon_state = "w-edge2";layer = MOB_LAYER + 1;density = 0}
		westedge3{icon_state = "w-edge3"}
		westedge4{icon_state = "w-edge4";density = 0}
		midwall1{icon_state = "wall1"}
		midwall2{icon_state = "wall2"}
		midwall3{icon_state = "wall3"; density = 0}
		westwall1{icon_state = "w-wall1"}
		westwall2{icon_state = "w-wall2"}
		westwall3{icon_state = "w-wall3"}
		eastwall1{icon_state = "ewall1"}
		eastwall2{icon_state = "ewall2"}
		eastwall3{icon_state = "ewall3"}
	doors
		icon = 'turf/sealedcave/doors.dmi'
		density = 0
		name = "passage"
		big_passage_s
			northwest{icon_state = "s-nw";density = 1}
			north{icon_state = "s-n";layer = MOB_LAYER + 1}
			northeast{icon_state = "s-ne";density = 1}
			west{icon_state = "s-w"; density = 1}
			middle{icon_state = "s-mid"}
			east{icon_state = "s-e"; density = 1}
			southwest{icon_state = "s-sw"; density = 1}
			south{icon_state = "s-s"}
			southeast{icon_state = "s-se"; density = 1}
		big_passage_n
			northwest{icon_state = "bign-nw";layer = MOB_LAYER + 1}
			northeast{icon_state = "bign-ne";layer = MOB_LAYER + 1}
			east{icon_state = "bign-e";density = 1}
			middle{icon_state = "bign-mid"}
			west{icon_state = "bign-w";density = 1}
			southwest{icon_state = "bign-sw";density = 1}
			south{icon_state = "bign-s";layer = MOB_LAYER + 1}
			southeast{icon_state = "bign-se";density = 1}
		passage_n
			west{icon_state = "n-w";density = 1}
			middle{icon_state = "n-mid";layer = MOB_LAYER + 1}
			east{icon_state = "n-e";density = 1}
			thingy{icon_state = "thingy";density = 1}
		door{icon_state = "door"}

//eblan cave

turf/cave/eblancave/floor
	name="ground"
	bfield="eblancave"
	icon='turf/cave/eblancave/floor.dmi'
	ground/icon_state="ground"
	sground/icon_state="shadow_ground"
	stair/icon_state="stair"
turf/cave/eblancave/river
	name="river"
	icon='turf/cave/eblancave/river.dmi'
	water{icon_state="water";density=0}
	waterfall{icon_state="waterfall";density=1;layer=MOB_LAYER+1}
	wfall_start{icon_state="wfall_start";density=1;layer=MOB_LAYER+1}
	wfall_splash/icon_state="wfall_splash"
	Entered(var/mob/p)
		set src in view(1)
		if(istype(src,/turf/cave/river)) p.icon_state="in"
		..()
	Exited(var/mob/p)
		p.icon_state="normal"
		..()
turf/cave/eblancave/struct
	icon='turf/cave/eblancave/struct.dmi'
	density=1
	Enter()
		if(type==/turf/cave/struct/west&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/northwest&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/northwest&&usr.dir==2) return 0
		else if(type==/turf/cave/struct/north&&usr.dir==2) return 0
		else if(type==/turf/cave/struct/northeast&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/northeast&&usr.dir==2) return 0
		else if(type==/turf/cave/struct/east&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/southeast&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/southeast&&usr.dir==1) return 0
		else if(type==/turf/cave/struct/southwest&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/southwest&&usr.dir==1) return 0
		return ..()
	Exit()
		if(type==/turf/cave/struct/west&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/northwest&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/northwest&&usr.dir==1) return 0
		else if(type==/turf/cave/struct/north&&usr.dir==1) return 0
		else if(type==/turf/cave/struct/northeast&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/northeast&&usr.dir==1) return 0
		else if(type==/turf/cave/struct/east&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/southeast&&usr.dir==4) return 0
		else if(type==/turf/cave/struct/southeast&&usr.dir==2) return 0
		else if(type==/turf/cave/struct/southwest&&usr.dir==8) return 0
		else if(type==/turf/cave/struct/southwest&&usr.dir==2) return 0
		return ..()
	northwest{name="ground";icon_state="northwest";density=0}
	north{name="ground";icon_state="north";density=0}
	northeast{name="ground";icon_state="northeast";density=0}
	west{name="ground";icon_state="west";density=0}
	east{name="ground";icon_state="east";density=0}
	southwest{name="ground";icon_state="southwest";density=0}
	south{name="ground";icon_state="south";density=0}
	southeast{name="ground";icon_state="southeast";density=0}
	wall/icon_state="wall"
	lwall1{name="wall";icon_state="left_wall1"}
	rwall1{name="wall";icon_state="right_wall1"}
	lwall2{name="wall";icon_state="left_wall2"}
	rwall2{name="wall";icon_state="right_wall2"}
	blwall{name="wall";icon_state="bottom_left_wall"}
	bwall{name="wall";icon_state="bottom_wall"}
	brwall{name="wall";icon_state="bottom_right_wall"}
	blwall2_top{name="wall";icon_state="bottom_left_wall2_top"}
	blwall2_bottom{name="wall";icon_state="bottom_left_wall2_bottom"}
	bwall2{name="wall";icon_state="bottom_wall2"}
	brwall2_top{name="wall";icon_state="bottom_right_wall2_top"}
	brwall2_bottom{name="wall";icon_state="bottom_right_wall2_bottom"}
	outer_west{name="wall";icon_state="outer_west"}
	outer_west_bottom{name="wall";icon_state="outer_west_bottom"}
	outer_east{name="wall";icon_state="outer_east"}
	outer_east_bottom{name="wall";icon_state="outer_east_bottom"}
turf/cave/eblancave/wall
	name="wall"
	icon='turf/cave/eblancave/wall.dmi'
	density=1
	northwest/icon_state="northwest"
	north/icon_state="north"
	north2/icon_state="north2"
	northeast/icon_state="northeast"
	west/icon_state="west"
	east/icon_state="east"
	southwest/icon_state="southwest"
	south/icon_state="south"
	southeast/icon_state="southeast"
	northwestcorner/icon_state="northwestcorner"
	northeastcorner/icon_state="northeastcorner"
	southwestcorner/icon_state="southwestcorner"
	southeastcorner/icon_state="southeastcorner"
	left_wall/icon_state="left_wall"
	wall/icon_state="wall"
	right_wall/icon_state="right_wall"
	bottom_left_wall/icon_state="bottom_left_wall"
	bottom_wall/icon_state="bottom_wall"
	bottom_right_wall/icon_state="bottom_right_wall"
	top_north_passage{name="passage";icon_state="top_north_passage"}
	north_passage{name="passage";icon_state="north_passage";density=0}
	north_passage_top_stair{name="stair";icon_state="north_passage_top_stair";density=0}
	north_passage_bottom_stair{name="stair";icon_state="north_passage_bottom_stair";density=0}
	south_passage{name="passage";icon_state="south_passage"}
	south_passage_stair{name="stair";icon_state="south_passage_stair";density=0}
turf/cave/eblancave/misc
	icon='turf/cave/eblancave/misc.dmi'
	Enter()
		if(istype(src,/turf/cave/misc/bridgeh)&&(usr.dir==1||usr.dir==2)) return 0
		else if(istype(src,/turf/cave/misc/bridgev)&&(usr.dir==4||usr.dir==8)) return 0
		return ..()
	Exit()
		if(istype(src,/turf/cave/misc/bridgeh)&&(usr.dir==1||usr.dir==2)) return 0
		else if(istype(src,/turf/cave/misc/bridgev)&&(usr.dir==4||usr.dir==8)) return 0
		return ..()
	rock{icon_state="rock";density=1}
	stair_top/icon_state="stair_top"
	stair/icon_state="stair"
	stair_bottom{name="stair";icon_state="stair_bottom"}
	bridgev{name="bridge";icon_state="bridgev"}
	bridgeh{name="bridge";icon_state="bridgeh"}
	bridgeh_basel{name="bridge";icon_state="bridgeh_basel";density=1}
	bridgeh_baser{name="bridge";icon_state="bridgeh_baser";density=1}
	fieldp{name="field pillar";icon_state="fieldp";density=1}
	door{name="door";icon_state="door"}
	torch_top{name="torch";icon_state="torch_top";density=1}
	torch_bottom{name="torch";icon_state="torch_bottom";density=1}

//mountain turfs

turf/mountain/floor
	name="ground"
	icon='turf/mountain/floor.dmi'
	bfield="mountain"
	ground/icon_state="ground"
	dground/icon_state="dark_ground"
	sdground/icon_state="shadow_dark_ground"

turf/mountain/mountain
	name="mountain"
	icon='turf/mountain/mountain.dmi'
	density=1
	bfield="mountain"
	Enter()
		if(type==/turf/mountain/mountain/west&&usr.dir==4) return 0
		else if(type==/turf/mountain/mountain/northwest&&usr.dir==4) return 0
		else if(type==/turf/mountain/mountain/northwest&&usr.dir==2) return 0
		else if(type==/turf/mountain/mountain/north&&usr.dir==2) return 0
		else if(type==/turf/mountain/mountain/northeast&&usr.dir==8) return 0
		else if(type==/turf/mountain/mountain/northeast&&usr.dir==2) return 0
		else if(type==/turf/mountain/mountain/east&&usr.dir==8) return 0
		return ..()
	Exit()
		if(type==/turf/mountain/mountain/west&&usr.dir==8) return 0
		else if(type==/turf/mountain/mountain/northwest&&usr.dir==8) return 0
		else if(type==/turf/mountain/mountain/northwest&&usr.dir==1) return 0
		else if(type==/turf/mountain/mountain/north&&usr.dir==1) return 0
		else if(type==/turf/mountain/mountain/northeast&&usr.dir==4) return 0
		else if(type==/turf/mountain/mountain/northeast&&usr.dir==1) return 0
		else if(type==/turf/mountain/mountain/east&&usr.dir==4) return 0
		return ..()
	northwest{name="ground";icon_state="northwest";density=0}
	north{name="ground";icon_state="north";density=0}
	northeast{name="ground";icon_state="northeast";density=0}
	west{name="ground";icon_state="west";density=0}
	east{name="ground";icon_state="east";density=0}
	west2{name="ground";icon_state="west2";density=0}
	east2{name="ground";icon_state="east2";density=0}
	southwest{name="ground";icon_state="southwest";density=1}
	southwest2{name="ground";icon_state="southwest2";density=1}
	southwest2corner{name="wall";icon_state="southwest2corner";density=1}
	south{name="ground";icon_state="south";density=1}
	southeast{name="ground";icon_state="southeast";density=1}
	southeast2{name="ground";icon_state="southeast2";density=1}
	southeast2corner{name="wall";icon_state="southeast2corner";density=1}
	lwall{name="wall";icon_state="left_wall"}
	wall/icon_state="wall"
	rwall{name="wall";icon_state="right_wall"}
	blwall{name="wall";icon_state="bottom_left_wall"}
	bwall{name="wall";icon_state="bottom_wall"}
	brwall{name="wall";icon_state="bottom_right_wall"}
	blwall2_top{name="wall";icon_state="bottom_left_wall2_top"}
	blwall2_bottom{name="wall";icon_state="bottom_left_wall2_bottom"}
	brwall2_top{name="wall";icon_state="bottom_right_wall2_top"}
	brwall2_bottom{name="wall";icon_state="bottom_right_wall2_bottom"}

turf/mountain/misc
	icon='turf/mountain/misc.dmi'
	bfield="mountain"
	Exit()
		if(type==/turf/mountain/misc/bridgeh&&usr.dir==1) return 0
		else if(type==/turf/mountain/misc/bridgeh&&usr.dir==2) return 0
		else if(type==/turf/mountain/misc/bridgev&&usr.dir==4) return 0
		else if(type==/turf/mountain/misc/bridgev&&usr.dir==8) return 0
		return ..()
	background{name="forest";icon_state="background";density=1}
	rock{icon_state="rock";density=1}
	block{icon_state="block";density=1}
	rshrine{icon_state="shriner";density=1}
	lshrine{icon_state="shrinel";density=1}
	shrine{icon_state="shrine";density=1}
	bridgev{name="bridge";icon_state="bridgev"}
	bridgeh{name="bridge";icon_state="bridgeh"}
	bridgeh_basel{name="bridge";icon_state="bridgeh_basel";density=1}
	bridgeh_baser{name="bridge";icon_state="bridgeh_baser";density=1}
	fieldp{name="field pillar";icon_state="fieldp";density=1}
	left_stair{name="stair";icon_state="left_stair"}
	right_stair{name="stair";icon_state="right_stair"}
	bottom_left_stair{name="stair";icon_state="bottom_left_stair"}
	bottom_right_stair{name="stair";icon_state="bottom_right_stair"}
	top_passage{name="passage";icon_state="top_passage";density=1}
	passage/icon_state="passage"

//moon
turf/moon/core
	icon='turf/moon/core.dmi'
	density = 1
	floor{icon_state="floor";density=0}
	ufloor{name = "floor";icon_state="upper_floor";density=0}
	stair{icon_state="stair";density=0}
	teleport{icon_state="teleport";density=0}
	pillar_top{name="pillar";icon_state="pillar_top"}
	pillar_bottom{name="pillar";icon_state="pillar_bottom"}
	struct_top{name="struct";icon_state="struct_top"}
	struct_middle{name="struct";icon_state="struct_middle"}
	struct_bottom{name="struct";icon_state="struct_bottom"}
	struct_pillar{name="struct";icon_state="struct_pillar"}
	lstruct_bottom{name="struct";icon_state="left_struct_bottom"}
	lstruct_bottom_end{name="struct";icon_state="left_struct_bottom_end"}
	rstruct_bottom{name="struct";icon_state="right_struct_bottom"}
	rstruct_bottom_end{name="struct";icon_state="right_struct_bottom_end"}

//crystal room turf
turf/crystal/carpet
	icon='turf/crystal/carpet.dmi'
	name="carpet"
	top_carpet1/icon_state="top_carpet1"
	top_carpet2/icon_state="top_carpet2"
	carpet/icon_state="carpet"
	bot_carpet/icon_state="bot_carpet"

turf/crystal/floor
	icon='turf/crystal/floor.dmi'
	name="floor"
	floor1/icon_state="floor1"
	floor2/icon_state="floor2"
	floor3/icon_state="floor3"
	floor4/icon_state="floor4"
	stair_t/icon_state="stair_top"
	stair/icon_state="stair"
	stair_b/icon_state="stair_bot"
	gm_council
		icon_state = "floor4"
		Enter(mob/M)
			if(ismob(M))
				if(GMList.Find(M) || GAME_OWNER.Find(M.key) || GMList[M.key]=="Head Admin")
					return 0
				else
					return..()

turf/crystal/pedestal
	icon='turf/crystal/pedestal.dmi'
	name="pedestal"
	density=1
	nw/icon_state="northwest"
	n/icon_state="north"
	ne/icon_state="northeast"
	w/icon_state="west"
	e/icon_state="east"
	sw/icon_state="southwest"
	swc/icon_state="southwestcorner"
	swc2/icon_state="southwestcorner2"
	sec/icon_state="southeastcorner"
	sec2/icon_state="southeastcorner2"
	isec/icon_state="isoutheastcorner"
	iswc/icon_state="isouthwestcorner"
	se/icon_state="southeast"
	swpillar/icon_state="southwestpil"
	swstair/icon_state="southweststair"
	sestair/icon_state="southeaststair"
	sepillar/icon_state="southeastpil"
	swfloor{icon_state="southwestfloor";density=0}
	swfstair/icon_state="southwestfloorstair"
	sefloor{icon_state="southeastfloor";density=0}
	sefstair/icon_state="southeastfloorstair"
	swstair_b{icon_state="southweststair_bot";density=0}
	sestair_b{icon_state="southeaststair_bot";density=0}
	nw_stand/icon_state="northwest_stand"
	n_stand/icon_state="north_stand"
	ne_stand/icon_state="northeast_stand"
	w_stand/icon_state="west_stand"
	e_stand/icon_state="east_stand"
	s_stand{icon_state="south_stand";density=0}
	stand/icon_state="stand"
	seat{icon_state="seat";density=0}

turf/crystal/pillar
	icon='turf/crystal/pillar.dmi'
	name="pillar"
	density=1
	h_ltop{icon_state="h_ltop";density=0;layer=MOB_LAYER+1}
	h_rtop{icon_state="h_rtop";density=0;layer=MOB_LAYER+1}
	top1{icon_state="top1";density=0;layer=MOB_LAYER+1}
	top2{icon_state="top2";density=0;layer=MOB_LAYER+1}
	spillar_lt{icon_state="spillar_ltop";density=0;layer=MOB_LAYER+1}
	spillar_rt{icon_state="spillar_rtop";density=0;layer=MOB_LAYER+1}
	spillar_l{icon_state="spillar_left";density=0;layer=MOB_LAYER+1}
	spillar_r{icon_state="spillar_right";density=0;layer=MOB_LAYER+1}
	spillar_bl/icon_state="spillar_lbot"
	spillar_rb/icon_state="spillar_rbot"
	pillar1_t/icon_state="pillar1_top"
	pillar1/icon_state="pillar1"
	pillar1_tb/icon_state="pillar1_tbot"
	pillar1_b/icon_state="pillar1_bot"
	pillar2_t/icon_state="pillar2_top"
	pillar2/icon_state="pillar2"
	pillar2_tb/icon_state="pillar2_tbot"
	pillar2_b/icon_state="pillar2_bot"
	pillar3_t/icon_state="pillar3_top"
	pillar3/icon_state="pillar3"
	pillar3_tb/icon_state="pillar3_tbot"
	pillar3_b/icon_state="pillar3_bot"

turf/crystal/wall
	icon='turf/crystal/wall.dmi'
	name="wall"
	density=1
	nw/icon_state="northwest"
	n/icon_state="north"
	ne/icon_state="northeast"
	e/icon_state="east"
	se{icon_state="southeast";layer=MOB_LAYER+1}
	s{icon_state="south";layer=MOB_LAYER+1}
	sw{icon_state="southwest";layer=MOB_LAYER+1}
	w/icon_state="west"
	se_c/icon_state="se_corner"
	sw_c/icon_state="sw_corner"
	ne_c/icon_state="ne_corner"
	nw_c/icon_state="nw_corner"
	s_exit{icon_state="s_exit";density=0;layer=MOB_LAYER+1}
	n_exit{icon_state="n_exit";density=0;layer=MOB_LAYER+1}
	wall1_t/icon_state="wall1_top"
	wall1/icon_state="wall1"
	wall1_b/icon_state="wall1_bot"
	lswall_t/icon_state="lsidewall_top"
	lswall/icon_state="lsidewall"
	lswall_b/icon_state="lsidewall_bot"
	rswall_t/icon_state="rsidewall_top"
	rswall/icon_state="rsidewall"
	rswall_b/icon_state="rsidewall_bot"
	wall2_tl/icon_state="wall2_tl"
	wall2_l/icon_state="wall2_l"
	wall2_bl/icon_state="wall2_bl"
	wall2_t/icon_state="wall2_t"
	wall2/icon_state="wall2"
	wall2_b/icon_state="wall2_b"
	wall2_tr/icon_state="wall2_tr"
	wall2_r/icon_state="wall2_r"
	wall2_br/icon_state="wall2_br"
	transp{icon_state="transp";density=0;layer=MOB_LAYER+1}

//monster village turf
//indoor
turf/monster_village/indoor/counter
	icon='turf/mnstrvlg/indoor/counter.dmi'
	name="counter"
	density=1
	lcounter/icon_state="lcounter"
	counter/icon_state="counter"
	rcounter/icon_state="rcounter"
	counter_b{icon_state="counter_b";density=0}

turf/monster_village/indoor/floor
	icon='turf/mnstrvlg/indoor/floor.dmi'
	name="floor"
	floor/icon_state="floor"

turf/monster_village/indoor/misc
	icon='turf/mnstrvlg/indoor/misc.dmi'
	name="misc"
	density=1
	box{name="box";icon_state="box"}
	bookcase_b{name="bookcase";icon_state="bookcase_b"}
	bookcase_t{name="bookcase";icon_state="bookcase_t"}
	table{name="table";icon_state="table_t"}
	table_p{name="table";icon_state="table_p";density=0}
	seat{name="seat";icon_state="seat";density=0}
	bed_b{name="bed";icon_state="bed_b"}
	bed_t{name="bed";icon_state="bed_t";density=0}
	bed_t_o{name="bed";icon_state="bed_t_overlay";density=0;layer=MOB_LAYER+1}

turf/monster_village/indoor/wall
	icon='turf/mnstrvlg/indoor/wall.dmi'
	name="wall"
	density=1
	wall_l/icon_state="wall_l"
	wall_bl/icon_state="wall_bl"
	wall/icon_state="wall"
	uwall{icon_state="wall";density=0;layer=MOB_LAYER+1}
	wall_b/icon_state="wall_b"
	wall_r/icon_state="wall_r"
	wall_br/icon_state="wall_br"
	twall_i/icon_state="top_wall_intersection"
	twall_h/icon_state="top_wall_h"
	utwall_h{icon_state="top_wall_h";density=0;layer=MOB_LAYER+1}
	twall_v/icon_state="top_wall_v"
	window_b{name="window";icon_state="window_b"}
	window_t{name="window";icon_state="window_t"}

//Land of the Summoned Monsters (Cave)

turf/monstercave

	ground
		density = 0;name = "ground";icon = 'turf/monstercave/floor.dmi'
		ground{icon_state = "floor"}
		ground_lava{icon_state = "lavafloor"}
		teleporter{icon_state = "teleporter"}
		n_passage
			name = "passage"
			north{icon_state = "ndoor1"}
			middle{icon_state = "ndoor2"}
			south{icon_state = "ndoor3"}
		s_passage
			name = "passage"
			north{icon_state = "sdoor-n"}
			south{icon_state = "sdoor-s"}
			southeast{icon_state = "sdoor-se";density = 1}
			southwest{icon_state = "sdoor-sw";density = 1}

	wall
		density = 1;name = "wall";icon = 'turf/monstercave/wall.dmi'
		roof
			layer = MOB_LAYER + 1
			north{icon_state = "roof-n"}
			northwest{icon_state = "roof-nw1"}
			northwest_corner{icon_state = "roof-nw2"}
			west{icon_state = "roof-w"}
			southwest{icon_state = "roof-sw"}
			south{icon_state = "roof-s"}
			southeast{icon_state = "roof-se"}
			east{icon_state = "roof-e"}
			northeast_corner{icon_state = "roof-ne2"}
			northeast{icon_state = "roof-ne1"}
		secretpath
			name = "";density = 0;layer = MOB_LAYER + 1
			east{icon_state = "spath-e";name = "wall"}
			west{icon_state = "spath-w";name = "wall"}
			walkhere{icon_state = "spath"}
			nowalk{icon_state = "spath"; density = 1}
		eastwall1{icon_state = "e-wall1"}
		eastwall2{icon_state = "e-wall2"}
		eastwall3{icon_state = "e-wall3"}
		midwall1{icon_state = "midwall1"}
		midwall2{icon_state = "midwall2"}
		midwall3{icon_state = "midwall3"}
		westwall1{icon_state = "w-wall1"}
		westwall2{icon_state = "w-wall2"}
		westwall3{icon_state = "w-wall3"}

//Land of the Summoned Monsters (Village)

turf/monster_village/outdoor

	icon = 'turf/mnstrvlg/exterior.dmi'
	ground{density = 0;icon_state = "floor";name="floor"}
	roof
		density = 1
		name = "roof"
		north{icon_state = "roof-n"}
		northwest{icon_state = "roof-nw"}
		northeast{icon_state = "roof-ne"}
		west{icon_state = "roof-w"}
		east{icon_state = "roof-e"}
		southwest{icon_state = "roof-sw"}
		southeast{icon_state = "roof-se"}
		south{icon_state = "roof-s"}
		middle{icon_state = "roof"}
	jar{icon_state = "jar";name = "jar";density = 1}
	wooden_railing
		density = 1
		name = "railing"
		ew{icon_state = "ew"}
		ns_e{icon_state = "ns-e"}
		ns_w{icon_state = "ns-w"}
		ns_ecorner_n{icon_state = "nsecorner-n"}
		ns_ecorner_s{icon_state = "nsecorner-s"}
		ns_wcorner_n{icon_state = "nswcorner-n"}
		ns_wcorner_s{icon_state = "nswcorner-s"}
		ew_ncorner_e{icon_state = "ewncorner-e"}
		ew_ncorner_w{icon_state = "ewncorner-w"}
		ew_scorner_e{icon_state = "ewscorner-e"}
		ew_scorner_w{icon_state = "ewscorner-w"}
		support_withfloor{icon_state = "ledge-f"}
		support_nofloor{icon_state = "ledge-b"}
		ns_eunder{icon_state = "nsunder-e"}
		ns_wunder{icon_state = "nsunder-w"}
		ew_gap_e{icon_state = "gap-e"}
		ew_cornergap_e{icon_state = "gapcorner-e"}
		ew_gap_w{icon_state = "gap-w"}
		ew_cornergap_w{icon_state = "gapcorner-w"}
	stairs_small{icon_state = "stairs"}
	stairsb_n{icon_state = "bstairs-n"}
	stairsb_s{icon_state = "bstairs-s"}
	itemsign{icon_state = "itemsign"}
	weaponsign{icon_state = "weaponsign"}
	armorsign{icon_state = "armorsign"}

turf/monster_village/indoor/floor
	shadow_n{icon = 'turf/mnstrvlg/exterior.dmi';icon_state = "shadow-floorn";density = 0}
	shadow_s{icon = 'turf/mnstrvlg/exterior.dmi';icon_state = "shadow-floors";density = 0}

// sylph area

turf/sylphcave

	ground
		density = 0;name = "ground";icon = 'turf/sylvan/floor.dmi'
		ground{icon_state = "floor"}
		ground_lava{icon_state = "lavafloor"}
		teleporter{icon_state = "teleporter"}
		n_passage
			name = "passage"
			north{icon_state = "ndoor1"}
			middle{icon_state = "ndoor2"}
			south{icon_state = "ndoor3"}
		s_passage
			name = "passage"
			north{icon_state = "sdoor-n"}
			south{icon_state = "sdoor-s"}
			southeast{icon_state = "sdoor-se";density = 1}
			southwest{icon_state = "sdoor-sw";density = 1}

	wall
		density = 1;name = "wall";icon = 'turf/sylvan/wall.dmi'
		roof
			layer = MOB_LAYER + 1
			north{icon_state = "roof-n"}
			northwest{icon_state = "roof-nw1"}
			northwest_corner{icon_state = "roof-nw2"}
			west{icon_state = "roof-w"}
			southwest{icon_state = "roof-sw"}
			south{icon_state = "roof-s"}
			southeast{icon_state = "roof-se"}
			east{icon_state = "roof-e"}
			northeast_corner{icon_state = "roof-ne2"}
			northeast{icon_state = "roof-ne1"}
			eastandwest{icon_state = "roof-ew"}
		secretpath
			name = "";density = 0;layer = MOB_LAYER + 1
			east{icon_state = "spath-e";name = "wall"}
			west{icon_state = "spath-w";name = "wall"}
			walkhere{icon_state = "spath"}
			nowalk{icon = './turf/void.dmi';density = 1}
		eastwall1{icon_state = "e-wall1"}
		eastwall2{icon_state = "e-wall2"}
		eastwall3{icon_state = "e-wall3"}
		midwall1{icon_state = "midwall1"}
		midwall2{icon_state = "midwall2"}
		midwall3{icon_state = "midwall3"}
		westwall1{icon_state = "w-wall1"}
		westwall2{icon_state = "w-wall2"}
		westwall3{icon_state = "w-wall3"}

turf/monster_village/outdoor/roof
		onefuckingrooftile{name = "roof";density = 1;icon = 'turf/sylvan/wall.dmi';icon_state = "thistileisonlyusedonceinthewholefuckingame"}

//tower of zot turf
turf/zot/door
	icon='turf/zot/door.dmi'
	name="wall"
	density=1
	door_tl/icon_state="door_top_left"
	door_t/icon_state="door_top"
	door_tr/icon_state="door_top_right"
	door_mtl/icon_state="door_midtop_left"
	door_mt/icon_state="door_midtop"
	door_mtr/icon_state="door_midtop_right"
	door_mbl/icon_state="door_midbot_left"
	door_mb/icon_state="door_midbot"
	door_mbr/icon_state="door_midbot_right"
	door_bl/icon_state="door_bot_left"
	door_b{icon_state="door_bot";density=0}
	door_br/icon_state="door_bot_right"
	entrance/icon_state="entrance"
	top2{icon_state="door_top2";density=0}
	whale{name="door";icon_state="whale";density=0}

turf/zot/floor
	icon='turf/zot/floor.dmi'
	name="floor"
	floor/icon_state="floor"
	ft_floor_tl/icon_state="ft_floor_tl"
	ft_floor_tr/icon_state="ft_floor_tr"
	ft_floor_bl/icon_state="ft_floor_bl"
	ft_floor_br/icon_state="ft_floor_br"
	stair{name="stair";icon_state="stair"}
	stair_bot{name="stair";icon_state="stair_bot"}
	grid{name="grid";icon_state="grid"}
	girder{name="girder";icon_state="girder";density=1}
	girder2{name="girder";icon_state="girder2";density=1}
	girder3{name="girder";icon_state="girder3";density=1}
	wall{name="wall";icon_state="wall";density=1}
	lava{name="lava";icon_state="lava";density=1}
	slava{name="lava";icon_state="slava";density=1}
	grid_l{name="grid";icon_state="grid_l";density=1}
	grid_r{name="grid";icon_state="grid_r";density=1}
	object{name="girder";icon_state="object"}
	objectlongt{name="girder";icon_state="objectlongt"}
	objectlongb{name="girder";icon_state="objectlongb"}
	objectmidt{name="girder";icon_state="objectmidt"}
	objectmidb{name="girder";icon_state="objectmidb"}
	under{name="under";icon_state="under";density=1}
	under2{name="under";icon_state="under2";density=1}
	under3{name="under";icon_state="under3";density=1}
	underl{name="under";icon_state="underl";density=1}
	underr{name="under";icon_state="underr";density=1}
	underright{name="under";icon_state="underright";density=1}
	underleft{name="under";icon_state="underleft";density=1}

turf/zot/misc
	icon='turf/zot/misc.dmi'
	density=1
	t_bed{name="bed";icon_state="top_bed"}
	bedt{name="bed";icon_state="bedtop"}
	b_bed{name="bed";density=0;icon_state="bot_bed"}
	obstacle{name="obstacle";icon_state="obstacle"}
	chest_open{name="chest";icon_state="chest_open"}
	sign{name="sign";icon_state="sign"}
	signt{name="sign";icon_state="sign_top"}
	signb{name="sign";icon_state="sign_bot"}
	light1/icon_state="light1"
	crystal/icon_state="crystal"
	dcrystal/icon_state="dcrystal"
	ball/icon_state="ball"
	heavyball{name="heavyball";icon_state="heavyball"}
	heavyblade{name="heavyblade";icon_state="heavyblade"}
	cannonbl{name="cannonbl";icon_state="cannonbl"}
	cannonml{name="cannonml";icon_state="cannonml"}
	cannontl{name="cannontl";icon_state="cannontl"}
	cannonbr{name="cannonbr";icon_state="cannonbr"}
	cannonmr{name="cannonmr";icon_state="cannonmr"}
	cannontr{name="cannontr";icon_state="cannontr"}
	cannonmr2{name="cannonmr2";icon_state="cannonmr2"}
	controls{name="controls";icon_state="controls"}
	cr{name="crystal";icon_state="cright"}
	cl{name="crystal";icon_state="cleft"}
	cb{name="crystal";icon_state="cbot"}
	ct{name="crystal";icon_state="ctop"}
	ctl{name="crystal";icon_state="ctopleft"}
	ctr{name="crystal";icon_state="ctopright"}
	cbl{name="crystal";icon_state="cbotleft"}
	cbr{name="crystal";icon_state="cbotright"}

turf/zot/wall
	icon='turf/zot/wall.dmi'
	name="wall"
	density=1
	left/icon_state="left"
	center/icon_state="center"
	center1/icon_state="center1"
	center2/icon_state="center2"
	center3/icon_state="center3"
	right/icon_state="right"
	bot_left/icon_state="bottom_left"
	bot/icon_state="bottom"
	bot1/icon_state="bottom1"
	bot2/icon_state="bottom2"
	bot_right/icon_state="bottom_right"
	top_w/icon_state="top_west"
	top_nw/icon_state="top_northwest"
	top_n/icon_state="top_north"
	top_n2/icon_state="top_north2"
	top_n3/icon_state="top_north3"
	top_n4/icon_state="top_north4"
	top_n5/icon_state="top_north5"
	top_n6/icon_state="top_north6"
	top_ne/icon_state="top_northeast"
	top_e/icon_state="top_east"
	top_se/icon_state="top_southeast"
	top_s/icon_state="top_south"
	top_s1/icon_state="top_south1"
	top_sw/icon_state="top_southwest"
	topl/icon_state="top_left"
	topr/icon_state="top_right"
	topm/icon_state="top_middle"
	v_wall/icon_state="v_wall"
	ctop_nw/icon_state="ctop_northwest"
	ctop_ne/icon_state="ctop_northeast"
	ctop_sw/icon_state="ctop_southwest"
	ctop_se/icon_state="ctop_southeast"
	ictop_nw/icon_state="ictop_northwest"
	ictop_ne/icon_state="ictop_northeast"
	ictop_sw/icon_state="ictop_southwest"
	ictop_se/icon_state="ictop_southeast"
	misc/icon_state="misc"
	roof/icon_state="roof"
	roof2/icon_state="roof2"
	roof3/icon_state="roof3"
	roof4/icon_state="roof4"
	roof5/icon_state="roof5"
	roof6/icon_state="roof6"
	roof7/icon_state="roof7"
	tl/icon_state="tl"
	tr/icon_state="tr"
	b/icon_state="b"
	bl/icon_state="bl"
	br/icon_state="br"
	l/icon_state="l"
	r/icon_state="r"
	mwallt/icon_state="miscwall1"
	mwallb/icon_state="miscwall2"
	top_c/icon_state="top_connect"
	bot3/icon_state="bottom3"
	bot4/icon_state="bottom4"
	lred/icon_state="leftred"
	rred/icon_state="rightred"
	mcw/icon_state="misccenter"
	atop/icon_state="arch_top"
	amid/icon_state="arch_mid"
	abot/icon_state="arch_bot"
	bota/icon_state="botarch"

//dwarf village

turf/village/dwarf/floor
	icon='turf/village/dwarf/floor.dmi'
	sand{name="sand";icon_state="sand"}
	rockf{name="rock";icon_state="rock"}
	srf{name="rock";icon_state="shadowrock"}
	endsrf{name="rock";icon_state="endshadowrock"}
	sstair{name="stair";icon_state="sstair"}
	stair{name="stair";icon_state="stair"}

turf/village/dwarf/house
	name="house"
	icon='turf/village/dwarf/house.dmi'
	density=1
	fph/icon_state="fireplace"
	lah/icon_state="leftarch"
	lrh/icon_state="leftroof"
	lwh/icon_state="leftwall"
	lsr/icon_state="leftstoneroof"
	nlrh/icon_state="nleftroof"
	nrrh/icon_state="nrightroof"
	ntlh/icon_state="ntopleftroof"
	ntrh/icon_state="ntoprightroof"
	rah/icon_state="rightarch"
	rrh/icon_state="rightroof"
	rwh/icon_state="rightwall"
	rsr/icon_state="rightstoneroof"
	rh/icon_state="roof"
	srh/icon_state="stoneroof"
	tlah/icon_state="topleftarch"
	tlrh/icon_state="topleftroof"
	tlwh/icon_state="topleftwall"
	trah/icon_state="toprightarch"
	trrh/icon_state="toprightroof"
	trwh/icon_state="toprightwall"
	trh/icon_state="toproof"
	twh/icon_state="topwall"
	twwh/icon_state="topwallwindow"
	wh/icon_state="wall"
	wwh/icon_state="wallwindow"
	croof/icon_state="croof"
	door{name="door";icon_state="door";density=1}

turf/village/dwarf/river
	name="river"
	icon='turf/village/dwarf/river.dmi'
	density=1
	cr/icon_state="center"
	er/icon_state="east"
	nr/icon_state="north"
	ner/icon_state="northeast"
	nwr/icon_state="northwest"
	sr/icon_state="south"
	ser/icon_state="southeast"
	swr/icon_state="southwest"
	wr/icon_state="west"
	toriverr/icon_state="toriver"
	riverhr/icon_state="riverh"
	rivervr/icon_state="riverv"
	bridgehr{icon_state="bridgeh";density=0}
	bridgevr{icon_state="bridgev";density=0}
	wfr/icon_state="waterfall"
	wfsr/icon_state="wfall_splash"

turf/village/dwarf/wall
	name="wall"
	icon='turf/village/dwarf/wall.dmi'
	density=1
	cuwall{icon_state="center";layer=MOB_LAYER+1;density=0}
	cwall/icon_state="center"
	eewall/icon_state="eastend"
	lewall/icon_state="leftend"
	necwall/icon_state="northeastcorner"
	newall/icon_state="northend"
	nwcwall/icon_state="northwestcorner"
	rewall/icon_state="rightend"
	secwall/icon_state="southeastcorner"
	sewall/icon_state="southend"
	swcwall/icon_state="southwestcorner"
	whuwall{icon_state="wallh";layer=MOB_LAYER+1;density=0}
	whwall/icon_state="wallh"
	wvwall/icon_state="wallv"
	wewall/icon_state="westend"
	wwall/icon_state="window"
	tree/icon_state="tree"
	village_doorstep{icon_state="village_doorstep";density=0}

turf/village/dwarf/counter
	name="counter"
	icon='turf/village/dwarf/counter.dmi'
	density=1
	bc1c{icon_state="basecounter1";density = 0}
	bc2c{icon_state="basecounter2";density = 0}
	blcc{icon_state="baseleftcounter";density = 0}
	brcc{icon_state="baserightcounter";density = 0}
	chc/icon_state="counterh"
	csc{name="seat";icon_state="counterseat";density = 0}
	cvc/icon_state="counterv"
	cwpc/icon_state="counterwithpot"
	fipc1/icon_state="flower1"
	fipc2/icon_state="flower2"
	lcc/icon_state="leftcounter"
	rcc/icon_state="rightcounter"
	tlccc/icon_state="topleftcountercorner"
	trccc/icon_state="toprightcountercorner"
	lccc/icon_state="leftcountercorner"
	rccc/icon_state="rightcountercorner"
	tecc/icon_state="topendcounter"

turf/village/dwarf/misc
	density=1
	icon='turf/village/dwarf/misc.dmi'
	nomove
		name="turf"
		text="t"
		density = 1
	void{name="turf";text="t";icon='turf/void.dmi';density=1;opacity=1}
	bottle/icon_state="bottle"
	btm{name="bed";icon_state="bedtop";density=0}
	blm{name="bed";icon_state="bedtoplayer";layer=MOB_LAYER+1;density=0}
	bbm{name="bed";icon_state="bedbase"}
	btablem{name="bedtable";icon_state = "bedtable"}
	bullhead/icon_state="bullhead"
	clock/icon_state="clock"
	dbm{name="book";icon_state="deskbook"}
	dpm{name="pencil";icon_state="deskpencil"}
	fwm{name="firewood";icon_state="firewood"}
	ktm{name="kitchen table";icon_state="kitchentable"}
	kum{name="kitchen utensil";icon_state="kitchenutensil"}
	oven/icon_state="oven"
	vase/icon_state="vase"
	plate/icon_state="plate"
	weapon/icon_state="weapon"
	sm{name="seat";icon_state="seat";density=0}
	tm{name="table";icon_state="table"}
	tpawm{name="table";icon_state="tablepaw";density = 0}
	wallpaper/icon_state="wall_paper"
	tlbcm{name="bookcase";icon_state="top_left_bookcase";layer=MOB_LAYER+1;density=0}
	tlsm{name="shelf";icon_state="top_left_shelf"}
	trbcm{name="bookcase";icon_state="top_right_bookcase";layer=MOB_LAYER+1;density=0}
	trsm{name="shelf";icon_state="top_right_shelf"}
	lbcm{name="bookcase";icon_state="left_bookcase"}
	lsm{name="shelf";icon_state="left_shelf"}
	rbcm{name="bookcase";icon_state="right_bookcase"}
	rsm{name="shelf";icon_state="right_shelf"}
	savepoint{name="save point";icon_state="savepoint";density=0}
	inv{name="inv";icon_state="inv";pixel_y=32;density=0}
	pedestal/icon_state="pedestal"
	harp{name="harp";icon_state="harp";density=1}
	weapon2/icon_state="weapon2"
	stairdown{name="stairdown";icon_state="stairdown";density=0}
	stairup{name="stairup";icon_state="stairup";density=0}

turf/village/dwarf/carpet
	name="carpet"
	icon='turf/village/dwarf/carpet.dmi'
	ccarpet/icon_state= "center"
	ecarpet/icon_state= "east"
	ncarpet/icon_state= "north"
	necarpet/icon_state= "northeast"
	nwcarpet/icon_state= "northwest"
	scarpet/icon_state= "south"
	secarpet/icon_state= "southeast"
	swcarpet/icon_state= "southwest"
	wcarpet/icon_state= "west"

turf/village/dwarf/fireplace
	name="fireplace"
	icon='turf/village/dwarf/fireplace.dmi'
	density=1
	cfp/icon_state="center"
	ffp/icon_state="fire"
	lfp/icon_state="left"
	rfp/icon_state="right"
	tfp/icon_state="top"
	tlfp/icon_state="topleft"
	trfp/icon_state="topright"

turf/village/dwarf/infloor
	icon='turf/village/dwarf/infloor.dmi'
	rock/icon_state= "rock"

turf/village/dwarf/inwall
	name="wall"
	icon='turf/village/dwarf/inwall.dmi'
	density=1
	candle{name="candle";icon_state="candle"}
	utopwall{icon_state="topwall"}
	topwall{icon_state="topwall";layer=MOB_LAYER+1}
	wall/icon_state="wall"
	halfwall{icon_state="halfwall";density=0}
	undertw{icon_state="topwall";density=0;layer=MOB_LAYER+1}
	underw{icon_state="wall";density=0;layer=MOB_LAYER+1}

turf/village/dwarf/sign
	name = "sign"
	density = 1
	icon='turf/village/dwarf/sign.dmi'
	outdoor_inn/icon_state="outdoor_inn"
	outdoor_weapon/icon_state="outdoor_weapon"
	outdoor_armor/icon_state="outdoor_armor"
	outdoor_item/icon_state="outdoor_item"
	outdoor_pub/icon_state="outdoor_pub"

//dwarf castle
turf/castle/dwarf/floor
	name="floor"
	icon='turf/castle/dwarf/floor.dmi'
	floor/icon_state="floor"
	sfloor/icon_state="shadow_floor"
	esfloor/icon_state="end_shadow_floor"
	bfloor/icon_state="broken_floor"
	stair/icon_state="stair"
	h_stair/icon_state="h_stair"
	grass/icon_state="grass"
	tgrass/icon_state="tallgrass"
	sand/icon_state="sand"
	st{icon_state="statue_top";density=1}
	sb{icon_state="statue_bottom";density=1}

turf/castle/dwarf/forest
	name="forest"
	density=1
	icon='turf/castle/dwarf/forest.dmi'
	n_forest/icon_state="n_forest"
	ne_forest/icon_state="ne_forest"
	nw_forest/icon_state="nw_forest"
	c_forest/icon_state="c_forest"
	s_forest/icon_state="s_forest"
	se_forest/icon_state="se_forest"
	sw_forest/icon_state="sw_forest"

turf/castle/dwarf/river
	name="river"
	icon='turf/castle/dwarf/river.dmi'
	density=1
	river/icon_state="river"
	corner/icon_state="corner"
	icorner/icon_state="inner_corner"
	north/icon_state="north_river"
	west/icon_state="west_river"

turf/castle/dwarf/tower
	name="tower"
	icon='turf/castle/dwarf/tower.dmi'
	density=1
	tult/icon_state="top_upper_left_tower"
	turt/icon_state="top_upper_right_tower"
	tlltb/icon_state="top_lower_left_towerb"
	tllt/icon_state="top_lower_left_tower"
	tlrt/icon_state="top_lower_right_tower"
	ltb/icon_state="left_towerb"
	lt/icon_state="left_tower"
	lwt/icon_state="left_window_tower"
	rtb/icon_state="right_towerb"
	rt/icon_state="right_tower"
	rwt/icon_state="right_window_tower"
	blt/icon_state="bottom_left_tower"
	brt/icon_state="bottom_right_tower"

turf/castle/dwarf/tower2
	name="tower"
	icon='turf/castle/dwarf/tower2.dmi'
	density=1
	tult/icon_state="top_upper_left_tower2"
	tut/icon_state="top_upper_tower2"
	turt/icon_state="top_upper_right_tower2"
	tllt/icon_state="top_lower_left_tower2"
	tlt/icon_state="top_lower_tower2"
	tlrt/icon_state="top_lower_right_tower2"
	lt/icon_state="left_tower2"
	t/icon_state="tower2"
	rt/icon_state="right_tower2"
	lwt/icon_state="left_window_tower2"
	wt/icon_state="window_tower2"
	rwt/icon_state="right_window_tower2"
	blt/icon_state="bottom_left_tower2"
	bt/icon_state="bottom_tower2"
	brt/icon_state="bottom_right_tower2"

turf/castle/dwarf/wall
	name="wall"
	icon='turf/castle/dwarf/wall.dmi'
	density=1
	tulr/icon_state="top_upper_left_roof"
	tur/icon_state="top_upper_roof"
	undertur{icon_state="top_upper_roof";density=0;layer=MOB_LAYER+1}
	turr/icon_state="top_upper_right_roof"
	tlr/icon_state="top_left_roof"
	tr/icon_state="top_roof"
	undertr{icon_state="top_roof";density=0;layer=MOB_LAYER+1}
	trr/icon_state="top_right_roof"
	lw/icon_state="left_wall"
	w/icon_state="wall"
	underw{icon_state="wall";density=0;layer=MOB_LAYER+1}
	rw/icon_state="right_wall"
	lwe/icon_state="left_wall_end"
	sign/icon_state="sign"
	window/icon_state="window"
	htuw/icon_state="h_top_upper_wall"
	htb/icon_state="h_top_b"
	htw/icon_state="h_top_wall"
	hbw/icon_state="h_bottom_wall"
	vtb/icon_state="v_top_b"
	vtw/icon_state="v_top_wall"
	vtsw/icon_state="v_top_shadow_wall"
	tb{icon_state="top_barrier";density=0;layer=MOB_LAYER+1}
	bh{icon_state="bottom_barrier";density=0}
	tds/icon_state="top_doorstep"
	bds/icon_state="bottom_doorstep"
	torch/icon_state="torch"
	bvtw/icon_state="broken_v_top_wall"
	bvtb/icon_state="broken_v_top_b"
	bw/icon_state="broken_wall"

//misc turfs
turf/misc/background
	density=1
	icon='turf/bground.dmi'
	lblue_bground
		name="sky"
		icon_state="lblue_bground"
	orange_bground
		name="sky"
		icon_state="orange_bground"

// misc odds and ends
turf/door/crystal_door{icon_state="crystaldoor";density=0}
turf/misc/misc/weapon2/icon_state="weapon2"
turf/door/dwarf_castle_outdoor_close{icon_state="dwarf_castle_outdoor_close";density=0}
turf/misc/misc/harp{name="harp";icon_state="harp";density=1}
turf/misc/misc
	density=1
	icon='turf/misc.dmi'
	nomove
		name="turf"
		text="t"
		density = 1
		harp{name="harp";icon_state="harp";density=1}
		weapon2/icon_state="weapon2"

turf/misc/misc
	density=1
	icon='turf/misc.dmi'
	nomove
		name="turf"
		text="t"
		density = 1
	void{name="turf";text="t";icon='turf/void.dmi';layer=TURF_LAYER+1;density=1;opacity=1}
	bottle/icon_state="bottle"
	btm{name="bed";icon_state="bedtop";density=0}
	blm{name="bed";icon_state="bedtoplayer";layer=MOB_LAYER+1;density=0}
	bbm{name="bed";icon_state="bedbase"}
	btablem{name="bedtable";icon_state = "bedtable"}
	bullhead/icon_state="bullhead"
	clock/icon_state="clock"
	dbm{name="book";icon_state="deskbook"}
	dpm{name="pencil";icon_state="deskpencil"}
	fwm{name="firewood";icon_state="firewood"}
	ktm{name="kitchen table";icon_state="kitchentable"}
	kum{name="kitchen utensil";icon_state="kitchenutensil"}
	oven/icon_state="oven"
	vase/icon_state="vase"
	plate/icon_state="plate"
	weapon/icon_state="weapon"
	sm{name="seat";icon_state="seat";density=0}
	tm{name="table";icon_state="table"}
	tpawm{name="table";icon_state="tablepaw";density = 0}
	wallpaper/icon_state="wall_paper"
	tlbcm{name="bookcase";icon_state="top_left_bookcase";layer=MOB_LAYER+1;density=0}
	tlsm{name="shelf";icon_state="top_left_shelf"}
	trbcm{name="bookcase";icon_state="top_right_bookcase";layer=MOB_LAYER+1;density=0}
	trsm{name="shelf";icon_state="top_right_shelf"}
	lbcm{name="bookcase";icon_state="left_bookcase"}
	lsm{name="shelf";icon_state="left_shelf"}
	rbcm{name="bookcase";icon_state="right_bookcase"}
	rsm{name="shelf";icon_state="right_shelf"}
	savepoint{name="save point";icon_state="savepoint";density=0}
	savepoint2{name="save point";icon_state="savepoint_2";density=0}
	inv{name="inv";icon_state="inv";pixel_y=32;density=0}
	pedestal/icon_state="pedestal"

turf/misc/teleport
	var
		teleorb
	density=1
	icon='turf/teleport.dmi'
	teleport
		var/cost
		icon_state="teleport"
		density=0
		Entered(mob/PC/p)
			if(cost && !dest_x && !dest_y && !dest_z)
				p.inmenu="message"
				p.screen_dialog("It'll cost you [cost]GP to teleport.","message")
				if(p.screen_yesno("message"))
					if(p.gold<cost) p.screen_dialog("Not enough GP!","message",1)
					else {p.close_allscreen();p.gold-=cost;p.screen("teleport")}
				else
					if(p) p.close_allscreen()
	telepad
		icon_state="teleport"
		name="Serpent Road"
		density=0
	Enter(var/mob/PC/M)
		set src in view(1)
		if(teleorb)
			var/Orb_Holders
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/O in p.contents) if(O.special == teleorb) Orb_Holders++
			if(Orb_Holders >= length(M.party)) return 1
			else
				M.msg("Orb required.")
				return 0
		else return ..()
	tpedestal{icon_state="tpedestal";name="pedestal"}
	bpedestal{icon_state="bpedestal";name="pedestal"}

turf/misc/chest
	name="chest"
	icon='turf/chest.dmi'
	density=1
	futuristic_chest_close{name="chest";icon_state="futuristic_chest_close"}
	futuristic_chest_open{name="chest";icon_state="futuristic_chest_open"}
	brown_chest_close{name="chest";icon_state="brown_chest_close"}
	brown_chest_open{name="chest";icon_state="brown_chest_open"}
	red_chest_close{name="chest";icon_state="red_chest_close"}
	red_chest_open{name="chest";icon_state="red_chest_open"}
	blue_chest_close{name="chest";icon_state="blue_chest_close"}
	blue_chest_open{name="chest";icon_state="blue_chest_open"}

turf/misc/telescope
	name="telescope"
	icon='turf/telescope.dmi'
	density=1
	t/icon_state="top"
	m{icon_state="middle";layer=MOB_LAYER+1}
	b1{icon_state="bottom";density=0;layer=MOB_LAYER+1}
	b2/icon_state="tip"

turf/misc/counter
	name="counter"
	icon='turf/counter.dmi'
	density=1
	bc1c{icon_state="basecounter1";density = 0}
	bc2c{icon_state="basecounter2";density = 0}
	blcc{icon_state="baseleftcounter";density = 0}
	brcc{icon_state="baserightcounter";density = 0}
	chc/icon_state="counterh"
	csc{name="seat";icon_state="counterseat";density = 0}
	cvc/icon_state="counterv"
	cwg/icon_state="counterwithglobe"
	cwpc/icon_state="counterwithpot"
	fipc1/icon_state="flower1"
	fipc2/icon_state="flower2"
	lcc/icon_state="leftcounter"
	rcc/icon_state="rightcounter"
	tlccc/icon_state="topleftcountercorner"
	trccc/icon_state="toprightcountercorner"
	lccc/icon_state="leftcountercorner"
	rccc/icon_state="rightcountercorner"
	tecc/icon_state="topendcounter"

turf/misc/chocobo
	icon='turf/chcb.dmi'
	density=1
	floor{icon_state="floor";density=0}
	food/icon_state="food"
	barrier/icon_state="barrier"
	race_line{icon_state="race_line";density=0}

turf/misc/sign
	name = "sign"
	density = 1
	icon='turf/sign.dmi'
	outdoor_inn/icon_state="outdoor_inn"
	outdoor_weapon/icon_state="outdoor_weapon"
	outdoor_armor/icon_state="outdoor_armor"
	outdoor_item/icon_state="outdoor_item"
	outdoor_pub/icon_state="outdoor_pub"
	indoor_armor/icon_state="indoor_armor"
	indoor_inn/icon_state="indoor_inn"
	indoor_item/icon_state="indoor_item"
	indoor_shield/icon_state="indoor_shield"
	indoor_weapon/icon_state="indoor_weapon"
	indoor_pub/icon_state="indoor_pub"

turf/misc/stair
	name="stair"
	icon='turf/stair.dmi'
	dsb/icon_state="downstairbase"
	dst/icon_state="downstairtop"
	st/icon_state="stair"
	usb/icon_state="upstairbase"
	ust/icon_state="upstairtop"
	sd/icon_state="stairdown"
	su/icon_state="stairup"

turf/misc/boatyard
	brick_bottom

turf/misc/KnightRen
	name="wall"
	icon='turf/KnightRen.dmi'
	density=1
	wall_e/icon_state="wall_e"
	wall_n/icon_state="wall_n"
	wall_w/icon_state="wall_w"
	wall_s/icon_state="wall_s"
	wall_ne/icon_state="wall_ne"
	wall_nw/icon_state="wall_nw"
	wall_se/icon_state="wall_se"
	wall_sw/icon_state="wall_sw"
	wall_top/icon_state="wall_top"
	wall_bot/icon_state="wall_bot"
	window_l{name="window";icon_state="window_l"}
	window_r{name="window";icon_state="window_r"}
	floor{name="floor";icon_state="floor"}
	bookcase_t{name="bookcase";icon_state="bookcase_top"}
	bookcase{name="bookcase";icon_state="bookcase"}
	bookcase_b{name="bookcase";icon_state="bookcase_bot"}
	drawer{name="drawer";icon_state="drawer"}
	chest{name="chest";icon_state="chest"}
	plant_t{name="plant";icon_state="plant_top";density=0}
	plant_b{name="plant";icon_state="plant_bot"}
	bed_t{name="bed";icon_state="bed_top"}
	bed_b{name="bed";icon_state="bed_bot"}
	table{name="table";icon_state="table"}
	seat{name="seat";icon_state="seat";density=0}

turf/door/dswitch
	icon='turf/door.dmi'
	name="switch"
	dooroc = 1
	Enter()	use_switch()
	proc
		use_switch()
			if(!doortag) return
			for(var/turf/door/door in view())
				if(door.doortag == doortag)
					if(dooroc) door.openclose()
					else door.open()
	oswitch/icon_state="out_switch"
	iswitch/icon_state="in_switch"

turf/door/fswitch
	icon='turf/door.dmi'
	name="switch"
	density=0
	ifs/icon_state="in_floor_switch"
	hidden_fs/icon_state=null
	Enter()
		use_switch()
		return 1
	proc
		use_switch()
			if(!doortag) return
			for(var/turf/door/door in view())
				if(door.doortag == doortag)
					if(dooroc) door.openclose()
					else door.open()

turf/door
	icon='turf/door.dmi'
	name="door"
	density=1
	var
		dooroc
		doortag
		doorkey
	proc/openclose()
		switch(icon_state)
			if("out_top_left_door_open"){icon_state="out_top_left_door_close";density=1}
			if("out_top_right_door_open"){icon_state="out_top_right_door_close";density=1}
			if("out_bottom_left_door_open"){icon_state="out_bottom_left_door_close";density=1}
			if("out_bottom_right_door_open"){icon_state="out_bottom_right_door_close";density=1}
			if("out_top_left_door_close"){icon_state="out_top_left_door_open";density=0}
			if("out_top_right_door_close"){icon_state="out_top_right_door_open";density=0}
			if("out_bottom_left_door_close"){icon_state="out_bottom_left_door_open";density=0}
			if("out_bottom_right_door_close"){icon_state="out_bottom_right_door_open";density=0}
			if("in_top_left_door_open"){underlays=null;icon_state="in_top_left_door_close";density=1}
			if("in_top_right_door_open"){icon_state="in_top_right_door_close";density=1}
			if("in_bottom_left_door_open"){icon_state="in_bottom_left_door_close";density=1}
			if("in_bottom_right_door_open"){icon_state="in_bottom_right_door_close";density=1}
			if("in_top_left_door_close"){underlays+=/turf/door/ibldo;icon_state="in_top_left_door_open";density=0;layer=MOB_LAYER+1}
			if("in_top_right_door_close"){icon_state="in_top_right_door_open";density=1}
			if("in_bottom_left_door_close"){icon_state="in_bottom_left_door_open";density=0}
			if("in_bottom_right_door_close"){icon_state="in_bottom_right_door_open";density=1}
			if("castle_3x2_outdoor_close_ul") icon_state="castle_3x2_outdoor_open_ul"
			if("castle_3x2_outdoor_close_bl") icon_state="castle_3x2_outdoor_open_bl"
			if("castle_3x2_outdoor_close_u"){underlays+=/turf/castle/outdoor/wall/bh;icon_state="castle_3x2_outdoor_open_u";layer=MOB_LAYER+1;density=0}
			if("castle_3x2_outdoor_close_b"){icon_state="castle_3x2_outdoor_open_b";density=0}
			if("castle_3x2_outdoor_close_ur") icon_state="castle_3x2_outdoor_open_ur"
			if("castle_3x2_outdoor_close_br") icon_state="castle_3x2_outdoor_open_br"
			if("castle_3x2_outdoor_open_ul") icon_state="castle_3x2_outdoor_close_ul"
			if("castle_3x2_outdoor_open_bl") icon_state="castle_3x2_outdoor_close_bl"
			if("castle_3x2_outdoor_open_u"){underlays=null;icon_state="castle_3x2_outdoor_close_u";density=1}
			if("castle_3x2_outdoor_open_b"){icon_state="castle_3x2_outdoor_close_b";density=1}
			if("castle_3x2_outdoor_open_ur") icon_state="castle_3x2_outdoor_close_ur"
			if("castle_3x2_outdoor_open_br") icon_state="castle_3x2_outdoor_close_br"
	proc/open()
		switch(icon_state)
			if("out_top_left_door_close"){icon_state="out_top_left_door_open";density=0}
			if("out_top_right_door_close"){icon_state="out_top_right_door_open";density=0}
			if("out_bottom_left_door_close"){icon_state="out_bottom_left_door_open";density=0}
			if("out_bottom_right_door_close"){icon_state="out_bottom_right_door_open";density=0}
			if("in_top_left_door_close"){underlays+=/turf/door/ibldo;icon_state="in_top_left_door_open";density=0;layer=MOB_LAYER+1}
			if("in_top_right_door_close"){icon_state="in_top_right_door_open";density=1}
			if("in_bottom_left_door_close"){icon_state="in_bottom_left_door_open";density=0}
			if("in_bottom_right_door_close"){icon_state="in_bottom_right_door_open";density=1}
			if("castle_3x2_outdoor_close_ul") icon_state="castle_3x2_outdoor_open_ul"
			if("castle_3x2_outdoor_close_bl") icon_state="castle_3x2_outdoor_open_bl"
			if("castle_3x2_outdoor_close_u"){underlays+=/turf/castle/outdoor/wall/bh;icon_state="castle_3x2_outdoor_open_u";layer=MOB_LAYER+1;density=0}
			if("castle_3x2_outdoor_close_b"){icon_state="castle_3x2_outdoor_open_b";density=0}
			if("castle_3x2_outdoor_close_ur") icon_state="castle_3x2_outdoor_open_ur"
			if("castle_3x2_outdoor_close_br") icon_state="castle_3x2_outdoor_open_br"
	proc/close()
		switch(icon_state)
			if("out_top_left_door_open"){icon_state="out_top_left_door_close";density=1}
			if("out_top_right_door_open"){icon_state="out_top_right_door_close";density=1}
			if("out_bottom_left_door_open"){icon_state="out_bottom_left_door_close";density=1}
			if("out_bottom_right_door_open"){icon_state="out_bottom_right_door_close";density=1}
			if("in_top_left_door_open"){underlays=null;icon_state="in_top_left_door_close";density=1}
			if("in_top_right_door_open"){icon_state="in_top_right_door_close";density=1}
			if("in_bottom_left_door_open"){icon_state="in_bottom_left_door_close";density=1}
			if("in_bottom_right_door_open"){icon_state="in_bottom_right_door_close";density=1}
			if("castle_3x2_outdoor_open_ul") icon_state="castle_3x2_outdoor_close_ul"
			if("castle_3x2_outdoor_open_bl") icon_state="castle_3x2_outdoor_close_bl"
			if("castle_3x2_outdoor_open_u"){underlays=null;icon_state="castle_3x2_outdoor_close_u";density=1}
			if("castle_3x2_outdoor_open_b"){icon_state="castle_3x2_outdoor_close_b";density=1}
			if("castle_3x2_outdoor_open_ur") icon_state="castle_3x2_outdoor_close_ur"
			if("castle_3x2_outdoor_open_br") icon_state="castle_3x2_outdoor_close_br"
	//very big door
	castle_3x2_ouldc/icon_state="castle_3x2_outdoor_close_ul"
	castle_3x2_obldc/icon_state="castle_3x2_outdoor_close_bl"
	castle_3x2_oudc/icon_state="castle_3x2_outdoor_close_u"
	castle_3x2_obdc/icon_state="castle_3x2_outdoor_close_b"
	castle_3x2_ourdc/icon_state="castle_3x2_outdoor_close_ur"
	castle_3x2_obrdc/icon_state="castle_3x2_outdoor_close_br"
	castle_3x2_ouldo/icon_state="castle_3x2_outdoor_open_ul"
	castle_3x2_obldo/icon_state="castle_3x2_outdoor_open_bl"
	castle_3x2_oudo{icon_state="castle_3x2_outdoor_open_u";density=0}
	castle_3x2_obdo{icon_state="castle_3x2_outdoor_open_b";density=0}
	castle_3x2_ourdo/icon_state="castle_3x2_outdoor_open_ur"
	castle_3x2_obrdo/icon_state="castle_3x2_outdoor_open_br"
	//big door
	otldo{icon_state="out_top_left_door_open";density=0}
	otrdo{icon_state="out_top_right_door_open";density=0}
	obldo{icon_state="out_bottom_left_door_open";density=0}
	obrdo{icon_state="out_bottom_right_door_open";density=0}
	otldc/icon_state="out_top_left_door_close"
	otrdc/icon_state="out_top_right_door_close"
	obldc/icon_state="out_bottom_left_door_close"
	obrdc/icon_state="out_bottom_right_door_close"
	itldo{icon_state="in_top_left_door_open";density=0;layer=MOB_LAYER+1}
	itrdo/icon_state="in_top_right_door_open"
	ibldo{icon_state="in_bottom_left_door_open";density=0}
	ibrdo/icon_state="in_bottom_right_door_open"
	itldc/icon_state="in_top_left_door_close"
	itrdc/icon_state="in_top_right_door_close"
	ibldc/icon_state="in_bottom_left_door_close"
	ibrdc/icon_state="in_bottom_right_door_close"
	itld/icon_state="in_top_left_door"
	ibld/icon_state="in_bottom_left_door"
	itd{icon_state="in_top_door";density=0;layer=MOB_LAYER+1}
	itrd/icon_state="in_top_right_door"
	ibrd/icon_state="in_bottom_right_door"
	//small door
	castle_outdoor_close{icon_state="castle_outdoor_close";density=0}
	castle_outdoor_open{icon_state="castle_outdoor_open";density=0}
	castle_indoor_close{icon_state="castle_indoor_close";density=0}
	castle_indoor_open{icon_state="castle_indoor_open";density=0}
	village_outdoorstep{icon_state="village_doorstep";density=0}
	village_outdoor_open{icon_state="village_outdoor_open";density=0}
	village_outdoor_close{icon_state="village_outdoor_close";density=0}
	village_indoor_open{icon_state="village_outdoor_open";density=0}
	village_indoor_close{icon_state="village_indoor_close";density=0}
	cave_indoor_close{icon_state="cave_indoor_close";density=0}
	cave_indoor_open{icon_state="cave_indoor_open";density=0}
	monster_village_indoor_close{icon_state="monster_village_indoor_close";density=0}
	crystal_indoor_close{icon_state="crystal_indoor";density=0}
	Enter(var/mob/PC/M)
		set src in view(1)
		if(doorkey)
			var/Key_Holders
			for(var/mob/PC/p in M.party) for(var/obj/Key_Item/O in p.contents) if(O.special == doorkey) Key_Holders++
			if(Key_Holders >= length(M.party)) return 1
			else
				M.msg("It is locked.")
				return 0
		else return ..()

// battle backgrounds
turf/battle
	background
		grass
			name="grass"
			icon='turf/battle/bg-grass.dmi'
			bg11/icon_state="bg-1-1"
			bg12/icon_state="bg-1-2"
			bg13/icon_state="bg-1-3"
			bg21/icon_state="bg-2-1"
			bg22/icon_state="bg-2-2"
			bg23/icon_state="bg-2-3"
			bg31/icon_state="bg-3-1"
			bg32/icon_state="bg-3-2"
			bg33/icon_state="bg-3-3"
			bg41/icon_state="bg-4-1"
			bg42/icon_state="bg-4-2"
			bg43/icon_state="bg-4-3"
			grass/icon_state="grass"
			dirt/icon_state="dirt"
			dirt1/icon_state="dirt1"
			dirt2/icon_state="dirt2"
			dirt3/icon_state="dirt3"
			dirt4/icon_state="dirt4"
			dirt5/icon_state="dirt5"
			dirt6/icon_state="dirt6"
			dirt7/icon_state="dirt7"
			dirt8/icon_state="dirt8"
			dirt9/icon_state="dirt9"
			dirt10/icon_state="dirt10"
			dirt11/icon_state="dirt11"
			dirt12/icon_state="dirt12"
			dirt13/icon_state="dirt13"
			dirt14/icon_state="dirt14"
			dirt15/icon_state="dirt15"
			dirt16/icon_state="dirt16"
			dirt17/icon_state="dirt17"
			dirt18/icon_state="dirt18"
			dirt19/icon_state="dirt19"
			dirt20/icon_state="dirt20"
			dirt21/icon_state="dirt21"
			dirt22/icon_state="dirt22"
			dirt23/icon_state="dirt23"
			dirt24/icon_state="dirt24"
		forest
			name="forest"
			bgforest/icon='turf/battle/bg-forest.bmp'
			forest/icon='turf/battle/bg-forest.dmi'
		desert
			name="desert"
			icon='turf/battle/bg-desert.dmi'
			bg11/icon_state="bg-1-1"
			bg12/icon_state="bg-1-2"
			bg13/icon_state="bg-1-3"
			bg21/icon_state="bg-2-1"
			bg22/icon_state="bg-2-2"
			bg23/icon_state="bg-2-3"
			desert/icon_state="desert"
		cave
			name="cave"
			bgcave/icon='turf/battle/bg-cave.bmp'
			cave/icon='turf/battle/bg-cave.dmi'
		cavemagnes
			name="cave"
			bgcavemagnes/icon='turf/battle/magnes.png'
		zot_babil
			name="tech"
			zotbabil/icon='turf/battle/zotbabil.png'
		caveeblan
			name="eblan"
			caveeblan/icon='turf/battle/caveeblan.png'
		underworld
			name="underworld"
			underworld/icon='turf/battle/underworld.png'
		river
			name="river"
			icon='turf/battle/bg-river.dmi'
			bg11/icon_state="bg-1-1"
			bg12/icon_state="bg-1-2"
			bg13/icon_state="bg-1-3"
			bg21/icon_state="bg-2-1"
			bg22/icon_state="bg-2-2"
			bg23/icon_state="bg-2-3"
			river/icon_state="river"
		mountain
			name="mountain"
			icon='turf/battle/bg-mountain.dmi'
			bg11/icon_state="bg-1-1"
			bg12/icon_state="bg-1-2"
			bg13/icon_state="bg-1-3"
			bg21/icon_state="bg-2-1"
			bg22/icon_state="bg-2-2"
			bg23/icon_state="bg-2-3"
			bg24/icon_state="bg-2-4"
			bg25/icon_state="bg-2-5"
			mountain1/icon_state="mountain1"
			mountain2/icon_state="mountain2"
		castle
			name="castle"
			bgcastle/icon='turf/battle/bg-castle.bmp'
			floor/icon='turf/battle/bg-castle.dmi'
		airship
			name="airship"
			icon='turf/battle/bg-airship.dmi'
			bg11/icon_state="bg-1-1"
			bg12/icon_state="bg-1-2"
			bg13/icon_state="bg-1-3"
			bg21/icon_state="bg-2-1"
			bg22/icon_state="bg-2-2"
			bg23/icon_state="bg-2-3"
			bg31/icon_state="bg-3-1"
			bg32/icon_state="bg-3-2"
			bg33/icon_state="bg-3-3"
			floor/icon_state="floor"
		crystal
			name="crystal"
			icon='turf/battle/bg-crystal.dmi'
			bg11/icon_state="bg-1-1"
			bg12/icon_state="bg-1-2"
			bg13/icon_state="bg-1-3"
			bg21/icon_state="bg-2-1"
			bg22/icon_state="bg-2-2"
			bg23/icon_state="bg-2-3"
			floor/icon_state="floor"

turf/bigwhale
		name="Big Whale"
		icon='mob/vehicule/bigwhale.dmi'
		icon_state="bigwhale_s"
		density=0
		direction=4
		dir=4
		bigwhale_sw/icon_state="bigwhale_sw"
		bigwhale_se/icon_state="bigwhale_se"
		bigwhale_w{icon_state="bigwhale_w";layer=MOB_LAYER+1}
		bigwhale_c{icon_state="bigwhale_c";layer=MOB_LAYER+1}
		bigwhale_e{icon_state="bigwhale_e";layer=MOB_LAYER+1}
		bigwhale_nw{icon_state="bigwhale_nw";layer=MOB_LAYER+1}
		bigwhale_n{icon_state="bigwhale_n";layer=MOB_LAYER+1}
		bigwhale_ne{icon_state="bigwhale_ne";layer=MOB_LAYER+1}

turf/village/indoor/western
	floor
		name="floor"
		icon='turf/village/western/floor.dmi'
		density=0
		floor/icon_state="floor"
		sfloor/icon_state="sfloor"
		stair/icon_state="stair"
		stair_left{icon_state="stairl";density=1}
		stair_right{icon_state="stairr";density=1}
		stair_leftb2{icon_state="stairlb2";density=1}
		stair_leftb1/icon_state="stairlb1"
		stair_rightb2{icon_state="stairrb2";density=1}
		stair_rightb1/icon_state="stairrb1"
		stair_bot/icon_state="stairb"
	wall
		name="wall"
		icon='turf/village/western/wall.dmi'
		density=1
		swcorner/icon_state="swcorner"
		secorner/icon_state="secorner"
		nwcorner/icon_state="nwcorner"
		necorner/icon_state="necorner"
		s{icon_state="s";density=0;layer=MOB_LAYER+1}
		w/icon_state="w"
		e/icon_state="e"
		n/icon_state="n"
		leftwall/icon_state="lwall"
		leftwallb{icon_state="lwbot";density=0}
		leftwallt/icon_state="lwtop"
		wall/icon_state="wall"
		bwall{icon_state="bwall";density=0}
		twall/icon_state="wallt"
		exitl{icon_state="lexit";density=0;layer=MOB_LAYER+1}
		exitc{icon_state="cexit";density=0;layer=MOB_LAYER+1}
		exitr{icon_state="rexit";density=0;layer=MOB_LAYER+1}
		leftwallu/icon_state="lwallu"
		leftwallbu{icon_state="blwallu";density=0}
		rightwallu/icon_state="rwallu"
		rightwallbu{icon_state="brwallu";density=0}
		wallu/icon_state="wallu"
		bwallu{icon_state="bwallu";density=0}
	misc
		density=1
		icon='turf/village/western/misc.dmi'
		barrel{icon_state="barrel";name="barrel"}
		pot{icon_state="pot";name="pot"}
		wanted{icon_state="wanted";name="wanted poster"}
		stool{icon_state="stool";name="seat";density=0}
		stooltable{icon_state="stooltable";name="seat";density=0}
		ct1{icon_state="ctable1";name="table"}
		ct2{icon_state="ctable2";name="table"}
		ct3{icon_state="ctable3";name="table"}
		lt{icon_state="ltable";name="table";density=0;layer=MOB_LAYER+1}
		rt{icon_state="rtable";name="table";density=0;layer=MOB_LAYER+1}
		tt{icon_state="ttable";name="table";density=0;layer=MOB_LAYER+1}
		furnaceb{icon_state="furnaceb";density=0;name="furnace"}
		furnace{icon_state="furnace";name="furnace"}
		furnacev{icon_state="furnacev";name="furnace";density=0;layer=MOB_LAYER+1}
		furnacec{icon_state="furnacec";name="furnace";density=0;layer=MOB_LAYER+1}
		furnaceh{icon_state="furnaceh";name="furnace";density=0;layer=MOB_LAYER+1}
		door_bl{icon_state="bldoor";name="door";density=0}
		door_b{icon_state="bdoor";name="door";density=0}
		door_t{icon_state="tdoor";name="door"}
		door{icon_state="door";name="door"}
		door_l{icon_state="ldoor";name="door"}
		door_tl{icon_state="tldoor";name="door"}
		door_bl_u{icon_state="bldooru";name="door";density=0}
		door_b_u{icon_state="bdooru";name="door";density=0}
		door_t_u{icon_state="tdooru";name="door"}
		door_u{icon_state="dooru";name="door"}
		door_l_u{icon_state="ldooru";name="door"}
		door_tl_u{icon_state="tldooru";name="door"}
		painting_bot{icon_state="paintingb";name="painting"}
		painting_top{icon_state="paintingt";name="painting"}
		picture1{icon_state="picture1";name="picture"}
		picture2{icon_state="picture2";name="picture"}
		rail_l{icon_state="lrail";density=0;name="railing";layer=MOB_LAYER+1}
		rail_r{icon_state="rrail";density=0;name="railing";layer=MOB_LAYER+1}
		rail_1{icon_state="rail1";density=0;name="railing";layer=MOB_LAYER+1}
		rail_2{icon_state="rail2";density=0;name="railing";layer=MOB_LAYER+1}
		rail_3{icon_state="rail3";density=0;name="railing";layer=MOB_LAYER+1}
		stair_rail_l{icon_state="lstairrail";density=0;name="railing";layer=MOB_LAYER+1}
		stair_rail_r{icon_state="rstairrail";density=0;name="railing";layer=MOB_LAYER+1}
	counter
		name="counter"
		icon='turf/village/western/counter.dmi'
		l_counterm{icon_state="lcounterm";density=1}
		l_counterb{icon_state="lcounterb";density=0}
		l_countert{icon_state="lcountert";density=0;layer=MOB_LAYER+1}
		counter_b{icon_state="counterb";density=0}
		counter_t{icon_state="countert";density=0;layer=MOB_LAYER+1}
		r_counterb{icon_state="rcounterb";density=0}
		counter{icon_state="counterm";density=1}
		r_counterm{icon_state="rcounterm";density=1}
		r_countert{icon_state="rcountert";density=1}
		r_counters{icon_state="rcounters";density=1}
		r_counterst{icon_state="rcounterst";density=1}
		displayb{icon_state="displayb";density=0}
		displaym{icon_state="displaym";density=1}
		displayt{icon_state="displayt";density=1}



turf/world/clanroom