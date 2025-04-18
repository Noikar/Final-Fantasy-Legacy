//battle engine variables
var/global/battle=0
var/list/bfield_location[] = new()//the list of battlefield's locations
var/const/bfield_map_layer=3			//the map layer it search the battle fields
var/const/battle_wait_time=20			//how much time in seconds we wait for the player to attack
var/const/hunting_rate=8					//in steps
var/const/encounter_rate=22				//in steps

// Damage Type Constants
var/const/DMG_PHYSICAL = 1
var/const/DMG_MAGICAL = 2
var/const/DMG_SUMMON = 3
var/const/DMG_SWORD_MAGIC = 4
var/const/DMG_DWAVE = 5


// battle initialization
proc
	battle_initialize()
		bfield_location = new()
		for(var/turf/battle/location/BSearch in block(locate(1,1,bfield_map_layer),locate(world.maxx,world.maxy,bfield_map_layer)))
			if(!BSearch.active)
				if(!bfield_location.Find(BSearch.name)) bfield_location[BSearch.name] = new()
				bfield_location[BSearch.name]+=BSearch
		if(length(bfield_location)){global.battle=1;info(,world,"Battle engine; operational.")}
		else info(,world,"An error occured while initializing the battle engine.")
	battle_reset(var/turf/battle/location/bfield)
		//resetting its variables
		bfield.Attackers = list();bfield.Defenders = list();bfield.nAttackers=0;bfield.nDefenders=0
		bfield.exp_reward=0;bfield.gp_reward=0;bfield.obj_reward = list()
		for(var/mob/M in view(bfield))
			if(M&&M.client){var/mob/PC/p=M;p.inmenu = null;p.inbattle=0;p.close_allscreen();p.BtlFrm("normal");p.loc=locate(p.XLoc,p.YLoc,p.ZLoc)}
			else del(M)
		for(var/obj/onmap/dmgnum/O in view(bfield)) del(O)
		//battlefield is no longer active
		bfield.active=0
		//readding it to the list
		bfield_location[bfield.name]+=bfield

// character's animations
mob/PC/var/tmp/last_frame
mob/PC/proc/BtlFrm(var/frame)
	// setting init_icon, checking if user is using a custom one
	var/init_icon = init_icon()
	var/BA[0]
	if(frame=="normal")
		overlays=list()
		icon=init_icon
		icon_state="normal"
		layer = MOB_LAYER
		pixel_y=4
		pixel_x=0
		if(invisibility) BA+=/turf/misc/misc/inv
		spawn(){pixel_step_size=0;client.lazy_eye=0}
	else //a battle icon! woot!
		if(!inbattle){BtlFrm("normal");return}
		switch(frame)
			if("battle_stand")
				if(Poison) frame = "battle_venom"
				else if(HP>(MaxHP/4)) frame = "battle_walk"
				else if((HP<=MaxHP/4)&&HP>0) frame = "battle_ndead"
				else frame = "battle_dead"
			if("battle_hit") spawn(5) BtlFrm(last_frame)
			if("battle_lattack_stance","battle_rattack_stance","battle_lattack_attack","battle_rattack_attack")
				//weapon needed
				var/obj/W = new()	//the weapon
				var/icon/I 				//its icon
				switch(frame)
					if("battle_lattack_stance","battle_rattack_stance")
						//checking if it need to be stanced (swinged)
						if(frame=="battle_lattack_stance"&&(!lhand||!lhand.stance)) return
						else if(frame=="battle_rattack_stance"&&(!rhand||!rhand.stance)) return
						else
							if(frame=="battle_lattack_stance") I = new(lhand.icon,icon_state=lhand.icon_state)
							else I = new(rhand.icon,icon_state=rhand.icon_state)
							if(dir==EAST){I.Flip(EAST);W.pixel_x=-32}
							else W.pixel_x=32
							W.pixel_y=32
					if("battle_lattack_attack","battle_rattack_attack")
						if(frame=="battle_lattack_attack")
							if(!lhand) I = new('obj/other.dmi',icon_state="hand-free")
							else
								I = new(lhand.icon,icon_state=lhand.icon_state)
								if(lhand.stance) I.Turn(-90)
						else
							if(!rhand) I = new('obj/other.dmi',icon_state="hand-free")
							else
								I = new(rhand.icon,icon_state=rhand.icon_state)
								if(rhand.stance) I.Turn(-90)
						if(dir==EAST){I.Flip(EAST);W.pixel_x=24}
						else W.pixel_x=-24
						W.pixel_y=16
				W.icon = I
				W.layer=MOB_LAYER+1
				BA+=W
		//now to the character
		var/obj/O_BR = new()
		var/obj/O_TR = new()
		var/obj/O_BL = new()
		var/obj/O_TL = new()
		var/list/battleStates
		battleStates = icon_states(init_icon)
		var/icon/I_BR = null
		var/icon/I_TR = null
		var/icon/I_BL = null
		var/icon/I_TL = null
		if(battleStates.Find("[frame]1"))
			I_BR = new(init_icon,icon_state="[frame]1")
		if(battleStates.Find("[frame]2"))
			I_TR = new(init_icon,icon_state="[frame]2")
		if(battleStates.Find("[frame]3"))
			I_BL = new(init_icon,icon_state="[frame]3")
		if(battleStates.Find("[frame]4"))
			I_TL = new(init_icon,icon_state="[frame]4")
		if(dir==EAST)	//on the other side of the moon... ..not.
			I_BR.Flip(EAST);I_TR.Flip(EAST);I_BL.Flip(EAST);I_TL.Flip(EAST)
			O_BR.pixel_x=32;O_TR.pixel_x=32;O_TR.pixel_y=32;O_TL.pixel_y=32
			icon = I_BR;O_TL.icon = I_TR;O_BR.icon = I_BL;O_TR.icon = I_TL
			BA+=O_TL;BA+=O_BR;BA+=O_TR
		else
			O_TR.pixel_y=32;O_BL.pixel_x=-32;O_TL.pixel_x=-32;O_TL.pixel_y=32
			icon = I_BR;O_TR.icon = I_TR;O_BL.icon = I_BL;O_TL.icon = I_TL
			BA+=O_TR;BA+=O_BL;BA+=O_TL
		//now that the icons are made, and placed, just displaying them.
		if(frame!="battle_hit") last_frame = frame	//setting the last frame
	overlays=list()			//removing the old one
	overlays=BA					//adding the new one!

// battle location
turf/battle/location
	var
		active=0									// battlefield activity
		list/Attackers = new()		// list of attackers
		list/Defenders = new()		// list of defenders
		nAttackers=0							// number of attackers
		nDefenders=0							// number of defenders
		exp_reward=0							// exp reward
		gp_reward=0								// gold reward
		list/obj_reward[]	= new()	// monster's drop
	// type of battlefield
	grass/icon='turf/battle/battle.dmi'
	forest/icon='turf/battle/battle.dmi'
	desert/icon='turf/battle/battle.dmi'
	cave/icon='turf/battle/battle.dmi'
	river/icon='turf/battle/battle.dmi'
	mountain/icon='turf/battle/battle.dmi'
	airship/icon='turf/battle/battle.dmi'
	crystal/icon='turf/battle/battle.dmi'
	castle/icon='turf/battle/battle.dmi'
	magnes/icon='turf/battle/battle.dmi'
	zotbabil/icon='turf/battle/battle.dmi'
	eblancave/icon='turf/battle/battle.dmi'
	underworld/icon='turf/battle/battle.dmi'

// encounter rate
mob/PC/var/tmp/encounter_rate
mob/var/tmp
	battle=1	// allow battles
	parry=0		// if set to 1, player is parrying
	escape=0	// if set to 1, player runs
	gauge=0		// if reach 0, its player turn
	inbattle=0// if player is in battle, set to 1
	inbossbattle=0 //if player is in a boss battle set to 1
	addboss		// heh
	XLoc
	YLoc
	ZLoc			// old location on worldmap


mob/PC/proc/StartBattle(var/turf/Location)
	if(!Location.bfield||!Location.encounter_group) return
	for(var/mob/PC/p in party) p.inmenu="battle_start"
	//selecting a battle location
	var/turf/battle/location/BLoc
	if(bfield_location.Find(Location.bfield)&&length(bfield_location[Location.bfield])) BLoc = pick(bfield_location[Location.bfield])
	if(!BLoc){for(var/mob/PC/p in party) p.inmenu=null;return} //stopping battle since no location were found
	else {bfield_location[Location.bfield] -= BLoc;BLoc.active = 1}
	//got a location --> creating the monsters
	var/list/Monsters = new()
	Monsters = CreateEncounter(Location.encounter_group) // Call the new proc

	//compiling monsters list - This section is now handled within DetermineEncounter
	// if(Monster1) Monsters+=Monster1;if(Monster2) Monsters+=Monster2;if(Monster3) Monsters+=Monster3
	// if(Monster4) Monsters+=Monster4;if(Monster5) Monsters+=Monster5;if(Monster6) Monsters+=Monster6
	// if(Monster7) Monsters+=Monster7;if(Monster8) Monsters+=Monster8;if(Monster9) Monsters+=Monster9
	// if(Monster10) Monsters+=Monster10;if(Monster11) Monsters+=Monster11;if(Monster12) Monsters+=Monster12
	// if(Monster13) Monsters+=Monster13;if(Monster14) Monsters+=Monster14;if(Monster15) Monsters+=Monster15

	if(!length(Monsters)){for(var/mob/PC/p in party) p.inmenu=null;return} //no monsters? stopping.
	//sending nifty sounds
	party<<SOUND_BTLSTART
	party<<sound(MUSIC_BATTLE,1,0,1,volume=50)
	//everything done, lets rumble!
	Battle(BLoc,0,party,Monsters)


// ### Battle proc
// active-time
proc
	atime_jump(var/agi)
		switch(agi)
			if(1 to 10) return 90
			if(11 to 20) return 84
			if(21 to 30) return 78
			if(31 to 40) return 72
			if(41 to 50) return 66
			if(51 to 60) return 60
			if(61 to 70) return 54
			if(71 to 80) return 48
			if(81 to 90) return 42
			if(91 to 100) return 36
			if(101 to 255) return 30
	atime_slow(var/agi)
		switch(agi)
			if(1 to 10) return 75
			if(11 to 20) return 69
			if(21 to 30) return 63
			if(31 to 40) return 57
			if(41 to 50) return 51
			if(51 to 60) return 45
			if(61 to 70) return 39
			if(71 to 80) return 33
			if(81 to 90) return 27
			if(91 to 100) return 21
			if(101 to 255) return 15
	atime_haste(var/agi)
		switch(agi)
			if(1 to 10) return 25
			if(11 to 20) return 23
			if(21 to 30) return 21
			if(31 to 40) return 19
			if(41 to 50) return 17
			if(51 to 60) return 15
			if(61 to 70) return 13
			if(71 to 80) return 11
			if(81 to 90) return 9
			if(91 to 100) return 7
			if(101 to 255) return 5
	atime(var/agi)
		switch(agi)
			if(1 to 10) return 50
			if(11 to 20) return 46
			if(21 to 30) return 42
			if(31 to 40) return 38
			if(41 to 50) return 34
			if(51 to 60) return 30
			if(61 to 70) return 26
			if(71 to 80) return 22
			if(81 to 90) return 18
			if(91 to 100) return 14
			if(101 to 255) return 10



// battle engine core
proc/Battle(turf/battle/location/BLoc,BType,list/Attackers,list/Defenders)
	//positioning the Attackers on the battlefield
	var/mob/L = Attackers[1]
	var/Old_x = L.x
	var/Old_y = L.y
	var/Old_z = L.z
	for(var/mob/PC/p in Attackers)		//Attackers are ALWAYS mob/PC -> clients.
		if(p.client){p.close_allscreen();p.client.eye=locate(BLoc.x,BLoc.y-1,BLoc.z)}
		p.inbattle = 1
		p.XLoc = Old_x;p.YLoc = Old_y;p.ZLoc = Old_z	//old location

		// Determine horizontal position based on row
		var/pos_x
		if (p.row_position == 1) // Front Row
			pos_x = BLoc.x + 5
		else // Back Row (row_position == 2)
			pos_x = BLoc.x + 6 // Further back

		// Determine vertical position based on party order
		var/pos_y
		switch(Attackers.Find(p))
			if(1) pos_y = BLoc.y + 2
			if(2) pos_y = BLoc.y + 1
			if(3) pos_y = BLoc.y
			if(4) pos_y = BLoc.y - 1
			if(5) pos_y = BLoc.y - 2
			else  pos_y = BLoc.y // Default just in case

		p.loc = locate(pos_x, pos_y, BLoc.z) // Set location using calculated x and y

		p.dir=WEST
		p.BtlFrm("battle_stand")
		p.gauge = rand(round(atime(p.agi)/2),atime(p.agi))
		BLoc.Attackers+=p
		BLoc.nAttackers++

	//now for the defender
	L = Defenders[1];Old_x = L.x;Old_y = L.y;Old_z = L.z
	for(var/mob/M in Defenders)	//can be PCs, or Monsters.
		if(istype(M,/mob/PC))
			var/mob/PC/p = M
			if(p.client){p.close_allscreen();p.client.eye=locate(BLoc.x,BLoc.y-1,BLoc.z)}
			p.inbattle = 1
			p.XLoc = Old_x;p.YLoc = Old_y;p.ZLoc = Old_z

			// Determine horizontal position based on row
			var/pos_x
			if (p.row_position == 1) // Front Row
				pos_x = BLoc.x - 5
			else // Back Row (row_position == 2)
				pos_x = BLoc.x - 6 // Further back

			// Determine vertical position based on party order
			var/pos_y
			switch(Defenders.Find(p))
				if(1) pos_y = BLoc.y + 2
				if(2) pos_y = BLoc.y + 1
				if(3) pos_y = BLoc.y
				if(4) pos_y = BLoc.y - 1
				if(5) pos_y = BLoc.y - 2
				else  pos_y = BLoc.y // Default just in case

			p.loc = locate(pos_x, pos_y, BLoc.z) // Set location using calculated x and y

			p.dir=EAST
			p.BtlFrm("battle_stand")
		else // Monster positioning remains the same
			var/mob/monster/p = M
			p.loc = locate(BLoc.x+p.XLoc,BLoc.y+p.YLoc,BLoc.z)
			BLoc.exp_reward += p.give_exp
			BLoc.gp_reward += p.give_gold

		// Monster gauge calculation (kept as original)
		M.gauge = rand(round(atime(M.level)/2),atime(M.level))
		BLoc.Defenders+=M
		BLoc.nDefenders++

	//loading up the battle panel
	for(var/mob/PC/p in view(BLoc)) if(p.client) p.battle_screen("panel")
	//everything's ready, starting the engine.. *vroom* *vroom* *cough*
	var/battle_error
	BattleLoop
	if(!BLoc.active||battle_error>=3){battle_reset(BLoc);return}	//forcing the battle to end if no more active/bugged.
	sleep(20)
	//battle's end check
	if(BLoc.nAttackers<=0)	//Defenders wins
		GameOver(BLoc.Attackers)
		for(var/mob/M in BLoc.Defenders)
			if(istype(M,/mob/PC)&&M.client){Victory(BLoc.Defenders,BLoc.exp_reward,BLoc.gp_reward);break}
			else del(M)
		battle_reset(BLoc)	//the battlefield is ready to use
		return
	else if(BLoc.nDefenders<=0)	//Attackers wins
		for(var/mob/M in BLoc.Defenders)
			if(istype(M,/mob/PC)&&M.client){GameOver(BLoc.Defenders);break}
			else del(M)
		Victory(BLoc.Attackers,BLoc.exp_reward,BLoc.gp_reward)
		battle_reset(BLoc)
		return
	//we need someone to do something now
	var/mob/NP
	for(var/mob/M in view(BLoc)) if(M.HP>0) if((!NP||NP.gauge>M.gauge)||(NP.gauge==M.gauge&&prob(50))) NP=M
	if(!NP){battle_error++;goto BattleLoop}
	var/rem_gauge = NP.gauge
	for(var/mob/M in view(BLoc)) if(M.HP>0) M.gauge -= rem_gauge
	//ready to execute that someone's something.
	if(NP.escape)
		if(istype(NP,/mob/PC))
			var/mob/PC/p = NP
			//counting the chances
			if(!BType&&prob(40+round(p.level/4))){EndBattle(BLoc.Attackers);EndBattle(BLoc.Defenders);battle_reset(BLoc);return}
			else {var/old_dir = p.dir;if(old_dir==EAST) p.dir=WEST;else p.dir=EAST;p.BtlFrm("battle_walk");sleep(5);p.BtlFrm("battle_dead");sleep(10);p.dir = old_dir;p.BtlFrm("battle_stand");p.escape = 0;p.gauge = atime(p.level)}
		else {BLoc.Defenders-=NP;BLoc.nDefenders--;del(NP)}
	else
		if(istype(NP,/mob/PC))
			var/mob/PC/p = NP
			if(p.Stone)
				p.stone_counter++
				if(p.stone_counter>stone_count) {p.Stone=null;p.stone_counter=0}
				if(p.Poison) p.Poison=null
				if(p.Regen) p.Regen=null
				if(p.Countdown) p.Countdown=null
				if(p.btl_action&&p.btl_target) {p.btl_action=null;p.btl_target=null}
				if(p.Mute) p.Mute=null
				if(p.Curse) p.Curse=null
				else if(p.Haste) p.Haste=null
				else if(p.Slow) p.Slow=null
				else if(!p.Haste && !p.Slow) p.gauge=atime(p.level)
			else if(p.Sleep)
				p.sleep_counter++
				if(p.sleep_counter>sleep_count) {p.Sleep=null;p.sleep_counter=0}
				if(p.Poison)
					var/Psn = round((p.MaxHP*5)/100)
					p.HP -= Psn
					if(p.HP<=1) p.HP=1
				if(p.Regen)
					var/Reg = round(p.MaxHP/10)
					p.HP += Reg
					if(p.HP > p.MaxHP) p.HP = p.MaxHP
				if(p.Mute)
					p.mute_counter++
					if(p.mute_counter>=mute_count) {p.Mute=null;p.mute_counter=0}
				if(p.Curse)
					p.curse_counter++
					if(p.curse_counter>=curse_count) {p.Curse=null;p.curse_counter=0}
				if(p.Countdown)
					p.countdown_counter++
					if(p.countdown_counter==countdown_count) {p.HP = 1;p.countdown_counter=0}
				else if(p.Haste)
					p.haste_counter++
					if(p.haste_counter>haste_count) {p.Haste=null;p.haste_counter=0}
					else p.gauge=atime_haste(p.level)
				else if(p.Slow)
					p.slow_counter++
					if(p.slow_counter>slow_count) {p.Slow=null;p.slow_counter=0}
					else p.gauge=atime_slow(p.level)
				else if(!p.Haste && !p.Slow) p.gauge=atime(p.level)
			else if(p.Hold)
				p.hold_counter++
				if(p.hold_counter>=hold_count) {p.Hold=null;p.hold_counter=0}
				if(p.Poison)
					var/Psn = round((p.MaxHP*5)/100)
					p.HP -= Psn
					if(p.HP < 1) p.HP=1
				if(p.Regen)
					var/Reg = round(p.MaxHP/10)
					p.HP += Reg
					if(p.HP > p.MaxHP) p.HP = p.MaxHP
				if(p.Mute)
					p.mute_counter++
					if(p.mute_counter>=mute_count) {p.Mute=null;p.mute_counter=0}
				if(p.Curse)
					p.curse_counter++
					if(p.curse_counter>=curse_count) {p.Curse=null;p.curse_counter=0}
				if(p.Countdown)
					p.countdown_counter++
					if(p.countdown_counter==countdown_count) {p.HP = 1;p.countdown_counter=0}
				if(p.btl_action&&p.btl_target) {p.btl_action=null;p.btl_target=null}
				else if(p.Haste)
					p.haste_counter++
					if(p.haste_counter>haste_count) {p.Haste=null;p.haste_counter=0}
					else p.gauge=atime_haste(p.level)
				else if(p.Slow)
					p.slow_counter++
					if(p.slow_counter>slow_count) {p.Slow=null;p.slow_counter=0}
					else p.gauge=atime_slow(p.level)
				else if(!p.Haste && !p.Slow) p.gauge=atime(p.level)
			//does it have something to do, or not yet ready
			else if(p.btl_action&&p.btl_target)
				p.battle_action(p.btl_action,p.btl_target)					//sending the info to battle_action()
				p.btl_action = null;p.btl_target = null;p.parry = 0	//cleaning old variables
			else if(!p.Sleep && !p.Hold)
				//the mob has no action to do!
				p.BtlFrm("battle_stand")
				p<<SOUND_BTLREADY	//little sound to notify the user
				if(p.Poison)
					var/Psn = round((p.MaxHP*5)/100)
					p.HP -= Psn
					if(p.HP<=1) p.HP = 1
				if(p.Regen)
					var/Reg = round(p.MaxHP/10)
					p.HP += Reg
					if(p.HP>=p.MaxMP) p.HP=p.MaxHP
				if(p.Mute)
					p.mute_counter++
					if(p.mute_counter>=mute_count) {p.Mute=null;p.mute_counter=0}
				if(p.Curse)
					p.curse_counter++
					if(p.curse_counter>=curse_count) {p.Curse=null;p.curse_counter=0}
				if(p.Countdown)
					p.countdown_counter++
					if(p.countdown_counter==countdown_count) {p.HP = 1;p.countdown_counter=0}
				p.battle_screen("battle_menu")
				//refreshing the panels
				if(BLoc.Attackers.Find(p)) for(var/mob/PC/PC in Attackers) PC.battle_screen("right_panel_refresh","rpanel[BLoc.Attackers.Find(p)]")
				else if(BLoc.Defenders.Find(p)) for(var/mob/PC/PC in Defenders) PC.battle_screen("right_panel_refresh","rpanel[BLoc.Defenders.Find(p)]")
				//then, waiting for him to select something
				var/wait_time
				while(p&&p.client&&!p.gauge)
					if(wait_time>=battle_wait_time||BLoc.nAttackers<=0||BLoc.nDefenders<=0)
						//closing all windows
						p.inmenu="panel"
						for(var/obj/onscreen/cursor/C in p.client.screen) del(C)
						p.close_screen("battle_item");p.close_screen("battle_dart");p.close_screen("battle_askills");p.close_screen("battle_askills_cost");p.close_screen("battle_left_menu");p.close_screen("battle_right_menu");p.close_screen("battle_menu");p.close_screen("left_battle_attack_message");p.close_screen("right_battle_attack_message")
						if(p.Haste)
							p.haste_counter++
							if(p.haste_counter>haste_count) {p.Haste=null;p.haste_counter=0}
							else p.gauge = atime_haste(p.level)
						else if(p.Slow)
							p.slow_counter++
							if(p.slow_counter>slow_count) {p.Slow=null;p.slow_counter=0}
							else p.gauge = atime_slow(p.level)
						else if(!p.Haste && !p.Slow) p.gauge = atime(p.level)
					sleep(10)
					wait_time++
			if(BLoc.Attackers.Find(p)) for(var/mob/PC/PC in Attackers) PC.battle_screen("right_panel_refresh","rpanel[BLoc.Attackers.Find(p)]")
			else if(BLoc.Defenders.Find(p)) for(var/mob/PC/PC in Defenders) PC.battle_screen("right_panel_refresh","rpanel[BLoc.Defenders.Find(p)]")
		else NP.AiAttack()
	goto BattleLoop


//proc that end the battles
proc/EndBattle(list/Losers)
	var/turf/battle/location/BLoc
	for(var/mob/M in Losers)
		if(istype(M,/mob/PC))
			var/mob/PC/p = M
			if(!BLoc) BLoc = locate(/turf/battle/location) in view(p)
			//removing from battle's config
			if(BLoc.Attackers.Find(p)){if(p.HP>0) BLoc.nAttackers--;BLoc.Attackers-=p}
			else if(BLoc.Defenders.Find(p)){if(p.HP>0) BLoc.nDefenders--;BLoc.Defenders-=p}
			//refreshing the battle panel
			if(p.client)
				p.close_allscreen()
				p.client.lazy_eye=0
				p.menupos=null
				p.BtlFrm("normal")
				p<<sound(null)
				p<<sound(p.sound,1,0,1)
				p.inbattle=0
				p.client.eye=p
				p.gauge=0
				p.parry=0
				p.escape=0
				p.btl_action=null
				p.btl_target=null
				Status_Counter_Null(p)
				Full_Status_Null(p)
				if(p.inbossbattle) p.inbossbattle=null
				if(p.addboss) p.addboss=null
				if(p.HP<1) p.HP=1
				if(p.inparty==1) p.density=0
				p.loc = locate(p.XLoc,p.YLoc,p.ZLoc)
				if(p.inparty==1) p.density=1
				p.dir=SOUTH
		else del(M)
	//refreshing the battle panel
	if(BLoc&&length(BLoc.Attackers)&&length(BLoc.Defenders))
		for(var/mob/PC/p in BLoc.Attackers){p.battle_screen("left_panel_refresh");p.battle_screen("right_panel_refresh")}
		for(var/mob/PC/p in BLoc.Defenders){p.battle_screen("left_panel_refresh");p.battle_screen("right_panel_refresh")}

proc/Victory(list/Winners,exp_reward,gp_reward)
	Winners<<sound(null)
	Winners<<sound(MUSIC_VICTORY,1,0,1,volume=50)
	for(var/mob/PC/p in Winners)
		if(p&&p.client)
			p.inmenu="panel"
			for(var/obj/onscreen/cursor/C in p.client.screen) del(C)
			p.close_screen("battle_item");p.close_screen("battle_dart");p.close_screen("battle_askills");p.close_screen("battle_askills_cost")
			p.close_screen("battle_left_menu");p.close_screen("battle_right_menu");p.close_screen("battle_menu")
			p.close_screen("left_battle_attack_message");p.close_screen("right_battle_attack_message")
	//This is where the parties experience is calculated...
	var/plength
	for(var/mob/PC/p in Winners) if(p&&p.client&&p.HP>0&&!p.Stone) plength++
	if(plength>1)
		gp_reward = round(gp_reward + (((exp_reward*5)/100)*plength)/plength)
		exp_reward = round(exp_reward + (((exp_reward*5)/100)*plength))
	//dancin'!
	for(var/i=0,i<=20,i++)
		switch(i)
			if(0) for(var/mob/PC/p in Winners) if(p&&p.client&&p.HP>0){p.battle_screen("battle_message","Received [gp_reward] GP!");p.gold+=gp_reward;if(p.gold>GPLimit) p.gold=GPLimit}
			if(6) for(var/mob/PC/p in Winners) if(p&&p.client&&p.HP>0){p.battle_screen("battle_message","Received [exp_reward] EXP!");p.exp+=exp_reward}
			if(12) for(var/mob/PC/p in Winners) if(p&&p.client&&p.level_up()){p.battle_screen("battle_message","You gained a level!")}
			if(5,11,17) for(var/mob/PC/p in Winners) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
		for(var/mob/PC/p in Winners) if(p&&p.client&&!p.Stone) p.BtlFrm("battle_item")
		sleep(3)
		for(var/mob/PC/p in Winners) if(p&&p.client&&!p.Stone) p.BtlFrm("battle_walk")
		sleep(3)
	//monster's drop..
	var/turf/battle/location/BLoc = locate(/turf/battle/location) in view()
	if(BLoc && length(BLoc.obj_reward))
		for(var/mob/PC/p in Winners) if(!p.Stone) p.battle_screen("monster_drop")
		Drop_Loop
		var/drop_done = length(Winners)
		for(var/mob/PC/p in Winners) if(p.inmenu == "panel"&&!p.Stone) drop_done--
		if(drop_done){sleep(10);goto Drop_Loop}
		//distributing
		for(var/obj/O in BLoc.obj_reward)
			if(BLoc.obj_reward[O])
				var/mob/PC/p = BLoc.obj_reward[O]
				if(istype(O,/obj/Ability/Basic/Item))
					var/obj/Ability/Basic/Item/I = locate(O.type) in p.contents
					if(I) if(text2num(I.suffix)<max_grouped_item) I.suffix="[(text2num(I.suffix)) + 1]"
					else if(length(p.contents)<inventory_size){p.contents += O;O.suffix=num2text(1)}
				else if(length(p.contents)<inventory_size) p.contents += O
	//ending the scene
	for(var/mob/PC/p in Winners)
		if(p&&p.client)
			p.close_allscreen()
			p.client.lazy_eye=0
			p.menupos=null
			p.BtlFrm("normal")
			p<<sound(null)
			p<<sound(p.sound,1,0,1)
			p.client.eye=p
			p.inbattle=0
			p.gauge=0
			p.parry=0
			p.escape=0
			p.btl_action=null
			p.btl_target=null
			Status_Counter_Null(p)
			Full_Status_Null(p)
			if(p.inbossbattle) p.inbossbattle=null
			if(p.addboss) {p.boss_fight += p.addboss;p.addboss=null}
			if(p.HP<1) p.HP=1
			if(p.inparty==1) p.density=0
			p.loc = locate(p.XLoc,p.YLoc,p.ZLoc)
			if(p.inparty==1) p.density=1
			p.dir=SOUTH

proc/GameOver(list/Losers)
	for(var/mob/PC/p in Losers)
		if(p&&p.client)
			p.leave_party()
			p.close_allscreen()
			p.client.lazy_eye=0
			p.menupos=null
			p.BtlFrm("normal")
			p.bosspanel=0
			p<<sound(null)
			p<<sound(p.sound,1,0,1)
			p.client.eye=p
			p.inbattle=0
			p.gauge=0
			p.parry=0
			p.escape=0
			p.btl_action=null
			p.btl_target=null
			Status_Counter_Null(p)
			Full_Status_Null(p)
			if(p.inbossbattle) p.inbossbattle=null
			if(p.addboss) p.addboss=null
			p.HP=p.MaxHP
			p.MP=p.MaxMP
			if(p.level>min_level) p.gold=round((p.gold*3)/5)
			p.GotoLoc(p.last_area)
			p.dir=SOUTH


// battle engine status effects
// this handle every type of mob
var/const/STATUS_NUL=0;var/const/STATUS_ADD=1
var/const/STATUS_REM=2;var/const/STATUS_ACT=3
var/const/S_POISON=1;var/const/S_DARKNESS=2
var/const/S_MUTE=3;var/const/S_CURSE=4
var/const/S_CONFUSE=5;var/const/S_SLEEP=6
var/const/S_SLOW=7;var/const/S_HOLD=8
var/const/S_SWOON=9;var/const/S_FLOAT=10
var/const/S_HASTE=11;var/const/S_PROTECT=12
var/const/S_SHELL=13;var/const/S_REFLECT=14
// status effect variables
var/const/S_POISON_MAX = 12 //maximum percentage 'S_POISON' will inflict
var/const/S_SWOON_MLEN = 60	//max length of 'swoon' in turn value (1:1).

mob
	var/tmp/list/status_effect[] = new()
	proc/btl_status(status,effect,se_power)
		switch(status)
			if(STATUS_NUL) status_effect = new()
			if(STATUS_ADD)
				switch(effect)
					if(S_POISON) status_effect[status] = min((status_effect[status] + se_power),S_POISON_MAX)
					if(S_DARKNESS,S_MUTE,S_CONFUSE,S_CURSE) status_effect[status]=1
					if(S_SWOON)
						if(status_effect[status]) status_effect[status] = round(status_effect[status]/2)
						else status_effect[status] = 60
					//for SLEEP, SLOW, HASTE, HOLD, FLOAT, PROTECT, SHELL, REFLECT.
					else status_effect[status] = se_power
			if(STATUS_REM)
				switch(effect)
					if(S_POISON,S_DARKNESS,S_MUTE,S_CONFUSE,S_CURSE) status_effect[status]=0
					if(S_SWOON)
						status_effect[status]-=se_power
						if(status_effect[S_SWOON]<=0) btl_status(STATUS_ACT,effect)
					//for SLEEP, SLOW, HASTE, HOLD, FLOAT, PROTECT, SHELL, REFLECT.
					else status_effect[status]--
			if(STATUS_ACT)
				switch(effect)
					if(S_POISON)
						var/p_dmg = ((status_effect[status]/100) * se_power)
						Damage(null,list(src=rand(round(p_dmg/2),p_dmg)))
					if(S_CONFUSE) //random attack among anything on view(BLoc)
					if(S_SWOON) Damage(null,list(src=HP))

/*how to use;
 to poison someone;
 btl_status(STATUS_ADD,S_POISON,SE_VALUE)
 SE_VALUE should be a damage relative to what you want to inflict to someone
 ..btl_status(STATUS_ADD,S_SWOON)

 btl_status(STATUS_REM,S_WHATEVER) to remove a status ailment
 btl_status(STATUS_NUL) to clear the status state
 btl_status(STATUS_ACT) when its time to do something related to the status (POISON damage, SWOONness, CONFUSED)
*/

// battle engine action procedures
// most of the engine rely on this
mob/PC/proc/battle_action(obj/Ability/Action,mob/Target)
	if(HP<=0||!Action||!Target) return
	var/turf/battle/location/BLoc = locate(/turf/battle/location/) in view(src)
	if(!istype(Action,/obj/Ability/Basic))
		if(BLoc.Attackers.Find(src))
			for(var/mob/PC/p in view(BLoc))
				if(p.client)
					if(Action.invicon) p.battle_invicon("right_attack_message",Action)
					else p.battle_screen("right_battle_attack_message","[Action]")
		else if(BLoc.Defenders.Find(src))
			for(var/mob/PC/p in view(BLoc))
				if(p.client)
					if(Action.invicon) p.battle_invicon("left_attack_message",Action)
					else p.battle_screen("left_battle_attack_message","[Action]")
	//icon_statin'
	switch(Action.AAType)
		if(0)
			// attack animation
			if(istype(rhand,/obj/weapon)||(!lhand&&!rhand))
				BtlFrm("battle_rattack_stance")
				sleep(2)
				BtlFrm("battle_rattack_attack")
				sleep(2)
			if(istype(lhand,/obj/weapon)||(!lhand&&!rhand))
				BtlFrm("battle_lattack_stance")
				sleep(2)
				BtlFrm("battle_lattack_attack")
				sleep(2)
			BtlFrm("battle_stand")
		if(1){BtlFrm("battle_item");spawn(10) BtlFrm("battle_stand")}
		if(2){BtlFrm("battle_special_attack");spawn(10) BtlFrm("battle_stand")}
		if(3){BtlFrm("battle_special2_attack");spawn(10) BtlFrm("battle_stand")}
		if(4){BtlFrm("battle_parry");spawn(10) BtlFrm("battle_stand")}
	//converting Target to TargList
	var/list/TargList = new()
	switch(Target)
		if("all ally")
			if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) TargList+=M
			else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) TargList+=M
		if("all enemy")
			if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Defenders) TargList+=M
			else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Attackers) TargList+=M
		else TargList+=Target
	if(!length(TargList)) return
	//preparing the damage
	switch(Action.DmgType)
		if(DMG_PHYSICAL)	// PHYSICAL ATTACK
			var/base = att()
			var/xAtt = xatt()
			var/Attp = attp()
			//multiplier.., like that we force the user to at least hit average.
			var/xA_base = max(1,round(xAtt/2))
			//using TargList..
			for(var/mob/T in TargList)
				if(src.Confuse)
					var/list/RandAttackList = list()
					for(var/mob/R in view(BLoc)) if(R != src) RandAttackList.Add(R)
					var/RandAttack = rand(1,length(RandAttackList))
					T = RandAttackList[RandAttack]
				if(T.Covered) for(var/mob/PC/P in view(BLoc)) if(P.Cover == T&&P.HP>0) T = P
				var/Damage = round(((base + rand(base/(3/4),base))) / length(TargList)) * (Action.Damage/100)
				var/xA = xA_base
				for(var/i=xAtt,i!=max(1,round(xAtt/2)),i--)
					if(T.Darkness)
						T.dark_counter++
						if(T.dark_counter>=5) T.Darkness=null
						else if(prob(Attp/2)) xA++
					else if(prob(Attp)) xA++
				var/Mod = 1
				for(var/M in btl_attrib(Action)) if(T.Resist.Find(M)) Mod -= (T.Resist[M]/100)
				if(!Mod){TargList[T]=0;continue}
				else if(Mod<0){TargList[T]=round(rand(round(Damage*0.75),Damage)*Mod*xA);continue}	//cannot defend against healing!
				//defending
				var/dbase
				var/xDef
				var/Defp
				if(istype(T,/mob/PC)){var/mob/PC/p = T;dbase = p.def();xDef = p.xdef();Defp = p.defp()}
				else {var/mob/monster/M = T;dbase = (M.defense*(M.level/8));xDef = round(M.level/8);Defp = round(30 + (M.level/4))}
				var/Defense = rand(0,dbase)
				if(Defense>Damage){Damage = 0;TargList[T]=0;continue}
				var/xD = round(xDef/4)
				for(var/i=xDef,i>round(xDef/4),i--) if(prob(Defp)) xD++
				if(xA<=xD){TargList[T]=0;continue} //miss
				Damage = ((Damage - Defense) * (xA - xD)) * Mod
				if (src.row_position == 2) Damage = round(Damage / 2) // Back Row damage reduction
				for(var/mob/Z in TargList) if(Z.Jump_Charge>=1) Damage=0 // So you do not get any damage while charging jump. ~Crimson
				if(T.Protect)
					T.protect_counter++
					if(T.protect_counter>protect_count) {T.Protect=null;T.protect_counter=0}
					else Damage=Damage/2
				if(T.Sleep) T.Sleep=null
				if(T.Confuse) T.Confuse=null
				if(T.Hold)
					T.hold_counter++
					if(T.hold_counter>hold_count) T.Hold=null
				if(T.Float&&Action.Attrib.Find("earth")) Damage=0
				if(T.Blink)
					T.blink_counter++
					if(T.blink_counter>blink_count) T.Blink=null
					else Damage=0
				if(src.Berserk)
					src.berserk_counter++
					if(src.berserk_counter>berserk_count) src.Berserk=null
					else Damage = round((Damage*25)/100)
				if(src.Cry)
					src.cry_counter++
					if(src.cry_counter>cry_count) src.Cry=null
					else Damage = Damage/2
				TargList[T]=round(Damage)
		if(DMG_MAGICAL)	// MAGICAL ATTACK
			var/base = Action.Damage
			var/xM
			if(Action.Modifier) xM = xWhite()
			else xM = xBlack()
			for(var/mob/T in TargList)
				if(src.Confuse)
					var/list/RandAttackList = list()
					for(var/mob/R in view(BLoc)) if(R != src) RandAttackList.Add(R)
					var/RandAttack = rand(1,length(RandAttackList))
					T = RandAttackList[RandAttack]
				if(T.Reflect)
					T.reflect_counter++
					if(T.reflect_counter>reflect_count) T.Reflect=null
					var/list/PartyList = list()
					if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList+=M
					else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList+=M
					if(T in PartyList)
						var/list/AttackList = list()
						for(var/mob/M in view(BLoc)) if(!PartyList.Find(M)) AttackList.Add(M)
						var/RandAttack = rand(1,length(AttackList))
						T = AttackList[RandAttack]
					else
						var/list/AttackList = list()
						for(var/mob/M in view(BLoc)) if(PartyList.Find(M)) AttackList.Add(M)
						var/RandAttack = rand(1,length(AttackList))
						T = AttackList[RandAttack]
				var/Damage = round(((base/2) + rand(round(base/4),min(round(base/2),255))) /length(TargList))
				var/Mod = 1
				for(var/M in btl_attrib(Action)) if(T.Resist.Find(M)) Mod -= (T.Resist[M]/100)
				if(!Mod){TargList[T]=0;continue}
				else if(Mod<0){TargList[T]=round(rand(round(Damage*0.75),Damage)*Mod*xM);continue}	//cannot defend against healing!
				//defending now
				var/mDef
				var/mxDef
				var/mDefp
				if(istype(T,/mob/PC)){var/mob/PC/p = T;mDef = p.magdef();mxDef = p.xmagdef();mDefp=p.magdefp()}
				else{var/mob/monster/M = T;mDef = (M.defense*(M.level/8));mxDef = round(M.level/8);mDefp = 15 + round(M.level/4)}
				var/Defense = rand(0,mDef)
				if(Defense>Damage){Damage = 0;TargList[T]=0;continue}
				var/xMD = round(mxDef/2)
				for(var/i=mxDef,i>round(mxDef/2),i--) if(prob(mDefp)) xMD++
				if(xM<=xMD){TargList[T]=0;continue}	//miss meh
				//calculating the damage done
				Damage = ((Damage - Defense) * (xM - xMD)) * Mod
				for(var/mob/Z in TargList) if(Z.Jump_Charge>=1) Damage=0 // So you do not get any damage while charging jump. ~Crimson
				if(T.Shell)
					T.shell_counter++
					if(T.shell_counter>shell_count) {T.Shell=null;T.shell_counter=0}
					else Damage=Damage/2
				if(T.Float&&Action.Attrib.Find("earth")) Damage = 0
				if(src.Strengthen)
					T.strengthen_counter++
					if(T.strengthen_counter>strengthen_count) {T.Strengthen=null;T.strengthen_counter=0}
					else Damage = Damage*3/2
				TargList[T]=round(Damage)
		if(DMG_SUMMON)  //SUMMONING MAGIC
			var/base = Action.Damage
			var/xM
			if(Action.Modifier) xM = xWhite()
			else xM = xBlack()
			for(var/mob/T in TargList)
				if(src.Confuse)
					var/list/RandAttackList = list()
					for(var/mob/R in view(BLoc)) if(R != src) RandAttackList.Add(R)
					var/RandAttack = rand(1,length(RandAttackList))
					T = RandAttackList[RandAttack]
				var/Damage = round(((base/2) + rand(round(base/4),min(round(base/2),255))))
				var/Mod = 1
				for(var/M in btl_attrib(Action)) if(T.Resist.Find(M)) Mod -= (T.Resist[M]/100)
				if(!Mod){TargList[T]=0;continue}
				else if(Mod<0){TargList[T]=round(rand(round(Damage*0.75),Damage)*Mod*xM);continue}	//cannot defend against healing!
				//defending now
				var/mDef
				var/mxDef
				var/mDefp
				if(istype(T,/mob/PC)){var/mob/PC/p = T;mDef = p.magdef();mxDef = p.xmagdef();mDefp=p.magdefp()}
				else{var/mob/monster/M = T;mDef = (M.defense*(M.level/8));mxDef = round(M.level/8);mDefp = 15 + round(M.level/4)}
				var/Defense = rand(0,mDef)
				if(Defense>Damage){Damage = 0;TargList[T]=0;continue}
				var/xMD = round(mxDef/2)
				for(var/i=mxDef,i>round(mxDef/2),i--) if(prob(mDefp)) xMD++
				if(xM<=xMD){TargList[T]=0;continue}	//miss meh
				//calculating the damage done
				Damage = ((Damage - Defense) * (xM - xMD)) * Mod
				for(var/mob/Z in TargList) if(Z.Jump_Charge>=1) Damage=0 // So you do not get any damage while charging jump. ~Crimson
				if(T.Shell)
					T.shell_counter++
					if(T.shell_counter>shell_count) {T.Shell=null;T.shell_counter=0}
					else Damage=Damage/2
				if(T.Float&&Action.Attrib.Find("earth")) Damage = 0
				TargList[T]=round(Damage)
		if(DMG_SWORD_MAGIC)//Sword && Magic Damage
			var/base = att()
			var/xAtt = xatt()
			var/Attp = attp()
			var/xA_base = max(1,round(xAtt/2))
			var/base2 = Action.Damage2
			var/xM
			if(Action.Modifier) xM = xWhite()
			else xM=xBlack()
			for(var/mob/T in TargList)
				if(Confuse)
					var/list/RandAttackList = list()
					for(var/mob/R in view(BLoc)) if(R != src) RandAttackList.Add(R)
					var/RandAttack = rand(1,length(RandAttackList))
					T = RandAttackList[RandAttack]
				if(T.Covered) for(var/mob/PC/P in view(BLoc)) if(P.Cover == T&&P.HP>0) T = P
				var/Damage = round(((base + rand(0,min(round(base/2),255))) / length(TargList)) * (Action.Damage/100))
				var/Damage2 = round(((base2/2) + rand(round(base2/4),min(round(base2/2),255))) / length(TargList))
				var/xA = xA_base
				for(var/i=xAtt,i!=max(1,round(xAtt/2)),i--)
					if(T.Darkness)
						T.dark_counter++
						if(T.dark_counter>=5) {T.Darkness=null;T.dark_counter=0}
						else if(prob(Attp/2)) xA++
					else if(prob(Attp)) xA++
				var/Mod = 1
				for(var/M in btl_attrib(Action)) if(T.Resist.Find(M)) Mod -= (T.Resist[M]/100)
				if(!Mod){TargList[T]=0;continue}
				else if(Mod<0) {TargList[T]=round(rand(round(Damage*0.75),Damage)*Mod*xA);continue}
				//Physical Defense
				var/dbase
				var/xDef
				var/Defp
				if(istype(T,/mob/PC)){var/mob/PC/p = T;dbase = p.def();xDef = p.xdef();Defp = p.defp()}
				else {var/mob/monster/M = T;dbase = (M.defense*(M.level/8));xDef = round(M.level/8);Defp = round(30 + (M.level/4))}
				var/Defense = rand(0,dbase)
				if(Defense>Damage){Damage = 0;TargList[T]=0;continue}
				var/xD = round(xDef/4)
				for(var/i=xDef,i>round(xDef/4),i--) if(prob(Defp)) xD++
				if(xA<=xD){TargList[T]=0;continue} //miss
				Damage = ((Damage - Defense) * (xA - xD)) * Mod
				for(var/mob/Z in TargList) if(Z.Jump_Charge>=1) Damage=0 // So you do not get any damage while charging jump. ~Crimson
				//Magical Defense
				var/mDef
				var/mxDef
				var/mDefp
				if(istype(T,/mob/PC)){var/mob/PC/p = T;mDef = p.magdef();mxDef = p.xmagdef();mDefp = p.magdefp()}
				else{var/mob/monster/M = T;mDef = (M.defense*(M.level/8));mxDef = round(M.level/8);mDefp = 15 + round(M.level/4)}
				var/Defense2 = rand(0,mDef)
				if(Defense2>Damage2){Damage2=0;TargList[T]=0;continue}
				var/xMD = round(mxDef/2)
				for(var/i=mxDef,i>round(mxDef/2),i--) if(prob(mDefp)) xMD++
				if(xM<=xMD){TargList[T]=0;continue} //miss
				Damage2 = ((Damage2 - Defense2) *(xM - xMD) * Mod)
				var/TDamage = (Damage + Damage2)
				if(T.Protect)
					T.protect_counter++
					if(T.protect_counter>protect_count) {T.Protect=null;T.protect_counter=0}
					else TDamage = Damage/2
				if(T.Sleep) T.Sleep=null
				if(T.Confuse) T.Confuse=null
				if(T.Hold)
					T.hold_counter++
					if(T.hold_counter>hold_count) {T.Hold=null;T.hold_counter=0}
				if(T.Float&&Action.Attrib.Find("earth")) TDamage = 0
				if(T.Blink)
					T.blink_counter++
					if(T.blink_counter>blink_count) {T.Blink=null;T.blink_counter=0}
					else TDamage = 0
				if(src.Berserk)
					src.berserk_counter++
					if(src.berserk_counter>berserk_count) {src.Berserk=null;src.berserk_counter=0}
					else TDamage = round((TDamage*25)/100)
				if(src.Cry)
					src.cry_counter++
					if(src.cry_counter>cry_count) {src.Cry=null;src.cry_counter=0}
					else TDamage = round(TDamage/2)
				TargList[T]=round(TDamage)
		if(DMG_DWAVE)	// DWave damage
			var/base = Action.Damage
			var/xM
			xM = xBlack()+xatt()
			for(var/mob/T in TargList)
				if(src.Confuse)
					var/list/RandAttackList = list()
					for(var/mob/R in view(BLoc)) if(R != src) RandAttackList.Add(R)
					var/RandAttack = rand(1,length(RandAttackList))
					T = RandAttackList[RandAttack]
				var/Damage = round(((base/2) + rand(round(base/4),min(round(base/2),255))))
				var/Mod = 1
				for(var/M in btl_attrib(Action)) if(T.Resist.Find(M)) Mod -= (T.Resist[M]/100)
				if(!Mod){TargList[T]=0;continue}
				else if(Mod<0){TargList[T]=round(rand(round(Damage*0.75),Damage)*Mod*xM);continue}	//cannot defend against healing!
				//defending now
				var/Def
				var/xDef
				var/Defp
				if(istype(T,/mob/PC)){var/mob/PC/p = T;Def = p.def();xDef = p.xdef();Defp=p.defp()}
				else{var/mob/monster/M = T;Def = (M.defense*(M.level/8));xDef = round(M.level/8);Defp = 15 + round(M.level/4)}
				var/Defense = rand(0,Def)
				if(Defense>Damage){Damage = 0;TargList[T]=0;continue}
				var/xD = round(xDef/2)
				for(var/i=xDef,i>round(xDef/2),i--) if(prob(Defp)) xD++
				if(xM<=xD){TargList[T]=0;continue}	//miss meh
				//calculating the damage done
				Damage = ((Damage - Defense) * (xM - xD)) * Mod
				for(var/mob/Z in TargList) if(Z.Jump_Charge>=1) Damage=0 // So you do not get any damage while charging jump. ~Crimson
				if(T.Shell)
					T.shell_counter++
					if(T.shell_counter>shell_count) {T.Shell=null;T.shell_counter=0}
					else Damage=Damage/2
				if(T.Float&&Action.Attrib.Find("earth")) Damage = 0
				TargList[T]=round(Damage)
	if(Action.HPDrain)
		if(Action.HPDrain>0)
			for(var/mob/T in TargList)
				var/Drain = round((T.HP*Action.HPDrain)/100)
				Drain = rand((Drain/2),Drain)
				if(istype(T,/mob/monster/undead)) Drain = -Drain
				if(Drain>0){TargList[T]+=Drain;TargList[src]+=-Drain}
				else {TargList[T]+=-Drain;TargList[src]+=Drain}
		else
			var/Drain = round((MaxHP/100) * Action.HPDrain)
			TargList[src]+=abs(Drain)
	if(Action.Sylph)
		for(var/mob/T in TargList)
			if(T.HP>0)
				var/Drain = round((T.HP*Action.Sylph)/100)
				Drain = rand((Drain/2),Drain)
				if(Drain>0)TargList[T]+=Drain
				var/list/PartyList=list()
				if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList.Add(M)
				if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList.Add(M)
				for(var/mob/P in PartyList) PartyList[P]+=-Drain
				Damage(Action,PartyList)
	if(Action.MPDrain)
		var/Drain
		for(var/mob/T in TargList)
			var/D = round((T.MP*Action.MPDrain)/100)
			D = rand((D/2),D)
			if(D>T.MP) D = T.MP
			if(D<0) D = 0
			if(!TargList[T]) TargList-=T
			Drain += D
			if(T.Shell)
				T.shell_counter++
				if(T.shell_counter>shell_count) {T.Shell=null;T.shell_counter=0}
				else Drain = D/2
			if(prob(50)) T.MP -= Drain
		MP += Drain
		if(MP>MaxMP) MP=MaxMP
		MP += Drain
		if(MP>MaxMP) MP=MaxMP
	if(Action.Revive) for(var/mob/T in TargList) TargList[T]+=-round((T.MaxHP/100)*Action.Revive)
	if(Action.HPHeal) for(var/mob/T in TargList) TargList[T]+=-Action.HPHeal
	if(Action.HPDamage) for(var/mob/T in TargList) TargList[T]-=-Action.HPDamage
	if(Action.MPHeal) for(var/mob/T in TargList){T.MP+=Action.MPHeal;if(T.MP>T.MaxMP) T.MP = T.MaxMP;if(!TargList[T]) TargList-=T}
	if(Action.MPCost) MP-=Action.MPCost
	if(Action.Strengthen) for(var/mob/T in TargList) {T.Strengthen=1;T.strengthen_counter=0}
	if(Action.Suicide) for(var/mob/T in TargList) {TargList[T]+=src.HP;src.HP = 1}
	if(Action.Muteable) if(src.Mute) return
	if(Action.Curseable) if(src.Curse) return
	if(Action.Dispell) for(var/mob/T in TargList) Status_Null(T)
	if(Action.Esuna) for(var/mob/T in TargList) Bad_Status_Null(T)
	if(Action.Cry)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(prob(50))
					if(T.Berserk) {T.Berserk=null;T.berserk_counter=0}
					else {T.Cry=1;T.cry_counter=0}
			else
				if(prob(70))
					if(T.Berserk) {T.Berserk=0;T.berserk_counter=0}
					else {T.Berserk=1;T.berserk_counter=0}
	if(Action.Remember)
		var/list/AttribList = list()
		switch(rand(1,10))
			if(1) AttribList.Add("fire")
			if(2) AttribList.Add("ice")
			if(3) AttribList.Add("bolt")
			if(4) AttribList.Add("water")
			if(5) AttribList.Add("earth")
			if(6) AttribList.Add("wind")
			if(7) AttribList.Add("holy")
			if(8) AttribList.Add("dark")
			if(9) AttribList.Add("piercing")
			if(10) AttribList.Add("healing")
		var/BASE
		if(src.level>0&&src.level<10)
			BASE = rand(16,25)
		if(src.level>10&&src.level<20)
			BASE = rand(25,50)
		if(src.level>20&&src.level<30)
			BASE = rand(50,75)
		if(src.level>30&&src.level<40)
			BASE = rand(75,95)
		if(src.level>40&&src.level<50)
			BASE = rand(75,125)
		if(src.level>50&&src.level<60)
			BASE = rand(75,150)
		if(src.level>60&&src.level<70)
			BASE = rand(75,175)
		if(src.level>70&&src.level<80)
			BASE = rand(75,190)
		if(src.level>80&&src.level<90)
			BASE = rand(75,200)
		if(src.level>90&&src.level<100)
			BASE = rand(75,210)
		var/base = BASE
		var/xM
		switch(rand(1,2))
			if(1) xM = xWhite()
			if(2) xM = xBlack()
		for(var/mob/T in TargList)
			if(src.Confuse)
				var/list/RandAttackList = list()
				for(var/mob/R in view(BLoc)) if(R != src) RandAttackList.Add(R)
				var/RandAttack = rand(1,length(RandAttackList))
				T = RandAttackList[RandAttack]
				if(T.Reflect)
					T.reflect_counter++
					if(T.reflect_counter>reflect_count) T.Reflect=null
					var/list/PartyList = list()
					if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList+=M
					else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList+=M
					if(T in PartyList)
						var/list/AttackList = list()
						for(var/mob/M in view(BLoc)) if(!PartyList.Find(M)) AttackList.Add(M)
						RandAttack = rand(1,length(AttackList))
						T = AttackList[RandAttack]
					else
						var/list/AttackList = list()
						for(var/mob/M in view(BLoc)) if(PartyList.Find(M)) AttackList.Add(M)
						RandAttack = rand(1,length(AttackList))
						T = AttackList[RandAttack]
			var/Damage = round(((base/2) + rand(round(base/4),min(round(base/2),255))) /length(TargList))
			var/Mod = 1
			for(var/M in AttribList) if(T.Resist.Find(M)) Mod -= (T.Resist[M]/100)
			if(!Mod){TargList[T]=0;continue}
			else if(Mod<0){TargList[T]=round(rand(round(Damage*0.75),Damage)*Mod*xM);continue}	//cannot defend against healing!
			//defending now
			var/mDef
			var/mxDef
			var/mDefp
			if(istype(T,/mob/PC)){var/mob/PC/p = T;mDef = p.magdef();mxDef = p.xmagdef();mDefp=p.magdefp()}
			else{var/mob/monster/M = T;mDef = (M.defense*(M.level/8));mxDef = round(M.level/8);mDefp = 15 + round(M.level/4)}
			var/Defense = rand(0,mDef)
			if(Defense>Damage){Damage = 0;TargList[T]=0;continue}
			var/xMD = round(mxDef/2)
			for(var/i=mxDef,i>round(mxDef/2),i--) if(prob(mDefp)) xMD++
			if(xM<=xMD){TargList[T]=0;continue}	//miss meh
			//calculating the damage done
			Damage = ((Damage - Defense) * (xM - xMD)) * Mod
			if(T.Float&&Action.Attrib.Find("earth")) Damage = 0
			if(src.Strengthen)
				T.strengthen_counter++
				if(T.strengthen_counter>strengthen_count) {T.Strengthen=null;T.strengthen_counter=0}
				else Damage = Damage*3/2
			TargList[T]=round(Damage)
	if(Action.Demi)
		for(var/mob/T in TargList)
			if(istype(T,/mob/monster/Boss)) TargList[T]=0
			else
				if(TargList.len>1) if(prob(50)) TargList[T]+=round((T.HP*25)/100)
				else if(prob(75)) TargList[T]+=round((T.HP*25)/100)
	if(Action.Demi2)
		for(var/mob/T in TargList)
			if(istype(T,/mob/monster/Boss)) TargList[T]=0
			else
				if(TargList.len>1) if(prob(50)) TargList[T]+=round((T.HP*50)/100)
				else if(prob(75)) TargList[T]+=round((T.HP*50)/100)
	if(Action.Demi3)
		for(var/mob/T in TargList)
			if(istype(T,/mob/monster/Boss)) TargList[T]=0
			else
				if(TargList.len>1) if(prob(50)) TargList[T]+=round((T.HP*75)/100)
				else if(prob(75)) TargList[T]+=round((T.HP*75)/100)
	if(Action.Curaja)
		if(TargList.len>1)
			var/base = 300
			var/xM
			if(Action.Modifier) xM = xWhite()
			else xM = xBlack()
			for(var/mob/T in TargList)
				if(src.Confuse)
					var/list/RandAttackList = list()
					for(var/mob/R in view(BLoc)) if(R != src) RandAttackList.Add(R)
					var/RandAttack = rand(1,length(RandAttackList))
					T = RandAttackList[RandAttack]
				if(T.Reflect)
					T.reflect_counter++
					if(T.reflect_counter>reflect_count) T.Reflect=null
					var/list/PartyList = list()
					if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList+=M
					else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList+=M
					if(T in PartyList)
						var/list/AttackList = list()
						for(var/mob/M in view(BLoc)) if(!PartyList.Find(M)) AttackList.Add(M)
						var/RandAttack = rand(1,length(AttackList))
						T = AttackList[RandAttack]
					else
						var/list/AttackList = list()
						for(var/mob/M in view(BLoc)) if(PartyList.Find(M)) AttackList.Add(M)
						var/RandAttack = rand(1,length(AttackList))
						T = AttackList[RandAttack]
				var/Damage = round(((base/2) + rand(round(base/4),min(round(base/2),255))) /length(TargList))
				var/Mod = 1
				for(var/M in btl_attrib(Action)) if(T.Resist.Find(M)) Mod -= (T.Resist[M]/100)
				if(!Mod){TargList[T]=0;continue}
				else if(Mod<0){TargList[T]=round(rand(round(Damage*0.75),Damage)*Mod*xM);continue}	//cannot defend against healing!
				//defending now
				var/mDef
				var/mxDef
				var/mDefp
				if(istype(T,/mob/PC)){var/mob/PC/p = T;mDef = p.magdef();mxDef = p.xmagdef();mDefp=p.magdefp()}
				else{var/mob/monster/M = T;mDef = (M.defense*(M.level/8));mxDef = round(M.level/8);mDefp = 15 + round(M.level/4)}
				var/Defense = rand(0,mDef)
				if(Defense>Damage){Damage = 0;TargList[T]=0;continue}
				var/xMD = round(mxDef/2)
				for(var/i=mxDef,i>round(mxDef/2),i--) if(prob(mDefp)) xMD++
				if(xM<=xMD){TargList[T]=0;continue}	//miss meh
				//calculating the damage done
				Damage = ((Damage - Defense) * (xM - xMD)) * Mod
				if(T.Shell)
					T.shell_counter++
					if(T.shell_counter>shell_count) {T.Shell=null;T.shell_counter=0}
					else Damage=Damage/2
				if(T.Float&&Action.Attrib.Find("earth")) Damage = 0
				if(src.Strengthen)
					T.strengthen_counter++
					if(T.strengthen_counter>strengthen_count) {T.Strengthen=null;T.strengthen_counter=0}
					else Damage = Damage*3/2
				TargList[T]=round(Damage)
		else
			for(var/mob/T in TargList)
				if(src.Confuse)
					var/list/RandAttackList = list()
					for(var/mob/R in view(BLoc)) if(R != src) RandAttackList.Add(R)
					var/RandAttack = rand(1,length(RandAttackList))
					T = RandAttackList[RandAttack]
				if(T.Reflect)
					T.reflect_counter++
					if(T.reflect_counter>reflect_count) T.Reflect=null
					var/list/PartyList = list()
					if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList+=M
					else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList+=M
					if(T in PartyList)
						var/list/AttackList = list()
						for(var/mob/M in view(BLoc)) if(!PartyList.Find(M)) AttackList.Add(M)
						var/RandAttack = rand(1,length(AttackList))
						T = AttackList[RandAttack]
					else
						var/list/AttackList = list()
						for(var/mob/M in view(BLoc)) if(PartyList.Find(M)) AttackList.Add(M)
						var/RandAttack = rand(1,length(AttackList))
						T = AttackList[RandAttack]
				TargList[T]+=-T.MaxHP
	if(Action.Berserk)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Berserk"))
					if(prob(T.StatResist["Berserk"]/2))
						if(T.Cry) {T.Cry=null;T.cry_counter=0}
						else {T.Berserk=1;T.berserk_counter=0}
				else
					if(prob(35))
						if(T.Cry) {T.Cry=null;T.cry_counter=0}
						else {T.Berserk=1;T.berserk_counter=0}
			else
				if(T.StatResist.Find("Berserk")) if(prob(T.StatResist["Berserk"]/2)) {T.Berserk=1;T.berserk_counter=0}
				else if(prob(70)) {T.Berserk=1;T.berserk_counter=0}
	if(Action.Protect)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Protect")) if(prob(T.StatResist["Protect"]/2)){T.Protect=1;T.protect_counter=0}
				else if(prob(35)){T.Protect=1;T.protect_counter=0}
			else
				if(T.StatResist.Find("Protect")) if(prob(T.StatResist["Protect"])){T.Protect=1;T.protect_counter=0}
				else if(prob(70)){T.Protect=1;T.protect_counter=0}
	if(Action.Blink)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Blink")) if(prob(T.StatResist["Blink"]/2)){T.Blink=1;T.blink_counter=0}
				else if(prob(35)){T.Blink=1;T.blink_counter=0}
			else
				if(T.StatResist.Find("Blink")) if(prob(T.StatResist["Blink"])){T.Blink=1;T.blink_counter=0}
				else if(prob(70)){T.Blink=1;T.blink_counter=0}
	if(Action.Shell)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Shell")) if(prob(T.StatResist["Shell"]/2)){T.Shell=1;T.shell_counter=0}
				else if(prob(35)){T.Shell=1;T.shell_counter=0}
			else
				if(T.StatResist.Find("Shell")) if(prob(T.StatResist["Shell"])){T.Shell=1;T.shell_counter=0}
				else if(prob(70)){T.Shell=1;T.shell_counter=0}
	if(Action.Reflect)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Reflect")) if(prob(T.StatResist["Reflect"]/2)){T.Reflect=1;T.reflect_counter=0}
				else if(prob(35)){T.Reflect=1;T.reflect_counter=0}
			else
				if(T.StatResist.Find("Reflect")) if(prob(T.StatResist["Reflect"])){T.Reflect=1;T.reflect_counter=0}
				else if(prob(70)){T.Shell=1;T.shell_counter=0}
	if(Action.Float)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Float")) if(prob(T.StatResist["Float"]/2)) T.Float=1
				else if(prob(35)) T.Float=1
			else
				if(T.StatResist.Find("Float")) if(prob(T.StatResist["Float"])) T.Float=1
				else if(prob(70)) T.Float=1
	if(Action.Mute)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Mute")) if(prob(T.StatResist["Mute"]/2)) {T.Mute=1;mute_counter=0}
				else if(prob(25)) {T.Mute=1;T.mute_counter=0}
			else
				if(T.StatResist.Find("Mute")) if(prob(T.StatResist["Mute"])) {T.Mute=1;mute_counter=0}
				else if(prob(50)) {T.Mute=1;T.mute_counter=0}
	if(Action.Curse)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Curse")) if(prob(T.StatResist["Curse"]/2)) {T.Curse=1;curse_counter=0}
				else if(prob(25)) {T.Curse=1;T.curse_counter=0}
			else
				if(T.StatResist.Find("Curse")) if(prob(T.StatResist["Curse"])) {T.Curse=1;curse_counter=0}
				else if(prob(50)) {T.Curse=1;T.curse_counter=0}
	if(Action.Darkness)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Darkness")) if(prob(T.StatResist["Darkness"]/2)) {T.Darkness=1;dark_counter=0}
				else if(prob(25)) {T.Darkness=1;dark_counter=0}
			else
				if(T.StatResist.Find("Darkness")) if(prob(T.StatResist["Darkness"])) {T.Darkness=1;dark_counter=0}
				else if(prob(50)) {T.Darkness=1;T.dark_counter=0}
	if(Action.Confuse)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Confuse")) if(prob(T.StatResist["Confuse"]/2)) T.Confuse=1
				else if(prob(25)) T.Confuse=1
			else
				if(T.StatResist.Find("Confuse")) if(prob(T.StatResist["Confuse"])) T.Confuse=1
				else if(prob(50)) T.Confuse=1
	if(Action.Sleep)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Sleep")) if(prob(T.StatResist["Sleep"]/2)) {T.Sleep=1;T.sleep_counter=0}
				else if(prob(25)) {T.Sleep=1;T.sleep_counter=0}
			else
				if(T.StatResist.Find("Sleep")) if(prob(T.StatResist["Sleep"])) {T.Sleep=1;T.sleep_counter=0}
				else if(prob(50)) {T.Sleep=1;T.sleep_counter=0}
	if(Action.Hold)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Hold")) if(prob(T.StatResist["Hold"]/2)) {T.Hold=1;T.hold_counter=0}
				else if(prob(25)) {T.Hold=1;T.hold_counter=0}
			else
				if(T.StatResist.Find("Hold")) if(prob(T.StatResist["Hold"])) {T.Hold=1;T.hold_counter=0}
				else if(prob(50)) {T.Hold=1;T.hold_counter=0}
	if(Action.Countdown)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Countdown")) if(prob(T.StatResist["Countdown"])){T.Countdown=1;T.countdown_counter=0}
				else if(prob(70)) {T.Countdown=1;T.countdown_counter=0}
			else
				if(T.StatResist.Find("Countdown")) if(prob(T.StatResist["Countdown"])){T.Countdown=1;T.countdown_counter=0}
				else if(prob(70)) {T.Countdown=1;T.countdown_counter=0}
	if(Action.Escape)
		var/list/PartyList = list()
		if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList.Add(M)
		else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList.Add(M)
		for(var/mob/T in TargList)
			if(src.inbossbattle)
				sleep(15)
				for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't Run.")
				spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			else spawn(15){EndBattle(BLoc.Attackers);EndBattle(BLoc.Defenders);battle_reset(BLoc);return}
	if(Action.Asura)
		switch(rand(1,3))
			if(1)
				var/base = 200
				var/xM
				if(Action.Modifier) xM = xWhite()
				else xM = xBlack()
				for(var/mob/T in TargList)
					var/Damage = round(((base/2) + rand(round(base/4),min(round(base/2),255))))
					var/Mod = 1
					for(var/M in btl_attrib(Action)) if(T.Resist.Find(M)) Mod -= (T.Resist[M]/100)
					if(!Mod){TargList[T]=0;continue}
					else if(Mod<0){TargList[T]=round(rand(round(Damage*0.75),Damage)*Mod*xM);continue}	//cannot defend against healing!
					//defending now
					var/mDef
					var/mxDef
					var/mDefp
					if(istype(T,/mob/PC)){var/mob/PC/p = T;mDef = p.magdef();mxDef = p.xmagdef();mDefp=p.magdefp()}
					else{var/mob/monster/M = T;mDef = (M.defense*(M.level/8));mxDef = round(M.level/8);mDefp = 15 + round(M.level/4)}
					var/Defense = rand(0,mDef)
					if(Defense>Damage){Damage = 0;TargList[T]=0;continue}
					var/xMD = round(mxDef/2)
					for(var/i=mxDef,i>round(mxDef/2),i--) if(prob(mDefp)) xMD++
					if(xM<=xMD){TargList[T]=0;continue}	//miss meh
					//calculating the damage done
					Damage = ((Damage - Defense) * (xM - xMD)) * Mod
					TargList[T]=round(Damage)
			if(2) for(var/mob/T in TargList) if(prob(90)) T.Protect=1
			if(3) for(var/mob/T in TargList) if(prob(90)) T.Shell=1
	if(Action.Pheonix)
		var/list/PartyList=list()
		if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList+=M
		else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList+=M
		for(var/mob/T in PartyList) PartyList[T]+=-round((T.MaxHP/100)*Action.Pheonix)
		Damage(Action,PartyList)
	if(Action.Golem)
		for(var/mob/T in TargList)
			T.Protect=1
			T.protect_counter=0
			T.Blink=1
			T.blink_counter=0
	if(Action.Hades)
		for(var/mob/T in TargList)
			switch(rand(1,10))
				if(1)
					if(prob(50))
						if(T.Regen) T.Regen=0
						else T.Poison=1
				if(2) if(prob(50)) T.Mute=1
				if(3) if(prob(50)) T.Sleep=1
				if(5) if(prob(50)) T.Confuse=1
				if(6) if(prob(50)) T.Countdown=1
	if(Action.Weak)
		for(var/mob/T in TargList)
			if(istype(T,/mob/monster/Boss))
				TargList[T]=0
				continue
			else
				switch(rand(1,10))
					if(1)
						var/Damage = round((T.HP*25)/100)
						TargList[T]+=Damage
					if(2)
						var/Damage = round((T.HP*40)/100)
						TargList[T]+=Damage
					if(3)
						var/Damage = round((T.HP*50)/100)
						TargList[T]+=Damage
					if(4)
						var/Damage = round((T.HP*75)/100)
						TargList[T]+=Damage
					if(5)
						var/Damage = round((T.HP*85)/100)
						TargList[T]+=Damage
					if(6)
						var/Damage = round((T.HP*95)/100)
						TargList[T]+=Damage
					if(7 to 10)
						TargList[T]=0
	if(Action.Haste)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Haste"))
					if(prob(T.StatResist["Haste"]/2))
						if(T.Slow) T.Slow=1
						else {T.Haste=1;T.haste_counter=0}
				else
					if(prob(35))
						if(T.Slow) T.Slow=1
						else {T.Haste=1;T.haste_counter=0}
			else
				if(T.StatResist.Find("Haste"))
					if(prob(T.StatResist["Haste"]))
						if(T.Slow) T.Slow=1
						else {T.Haste=1;T.haste_counter=0}
				else
					if(prob(70))
						if(T.Slow) T.Slow=1
						else {T.Haste=1;T.haste_counter=0}
	if(Action.Slow)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Slow"))
					if(prob(T.StatResist["Slow"]/2))
						if(T.Haste) T.Haste=0
						else {T.Slow=1;T.slow_counter=0}
				else
					if(prob(25))
						if(T.Haste) T.Haste=0
						else {T.Slow=1;T.slow_counter=0}
			else
				if(T.StatResist.Find("Slow"))
					if(prob(T.StatResist["Slow"]))
						if(T.Haste) T.Haste=0
						else {T.Slow=1;T.slow_counter=0}
				else
					if(prob(50))
						if(T.Haste) T.Haste=0
						else {T.Slow=1;T.slow_counter=0}
	if(Action.Poison)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Poison"))
					if(prob(T.StatResist["Poison"]/2))
						if(T.Regen) T.Regen=0
						else T.Poison = 1
				else
					if(prob(25))
						if(T.Regen) T.Regen=0
						else T.Poison = 1
			else
				if(T.StatResist.Find("Poison"))
					if(prob(T.StatResist["Poison"]))
						if(T.Regen) T.Regen=0
						else T.Poison = 1
				else
					if(prob(50))
						if(T.Regen) T.Regen=0
						else T.Poison = 1
	if(Action.Regen)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Regen"))
					if(prob(T.StatResist["Regen"]/2))
						if(T.Poison) T.Poison = 0
						else T.Regen = 1
				else
					if(prob(35))
						if(T.Poison) T.Poison = 0
						else T.Regen = 1
			else
				if(T.StatResist.Find("Regen"))
					if(prob(T.StatResist["Regen"]))
						if(T.Poison) T.Poison=0
						else T.Regen=1
				else
					if(prob(70))
						if(T.Poison) T.Poison=0
						else T.Regen=1

	if(Action.Cover)
		for(var/mob/T in TargList)
			if(src.Cover)
				for(var/mob/P in view(BLoc)) if(P.Covered == src) P.Covered=null
				src.Cover=null
			T.Covered = src
			src.Cover = T
	if(Action.Death)
		for(var/mob/T in TargList)
			if(T.StatResist.Find("Death")) if(prob(T.StatResist["Death"])) TargList[T]+=T.MaxHP
			else if(prob(50)) TargList[T]+=T.MaxHP

	if(Action.Stone)
		for(var/mob/T in TargList)
			if(TargList.len>1)
				if(T.StatResist.Find("Stone"))
					if(prob(T.StatResist["Stone"]/2))
						if(istype(T,/mob/monster)) TargList[T]+=T.MaxHP
						else T.Stone=1
				else
					if(prob(25))
						if(istype(T,/mob/monster)) TargList[T]+=T.MaxHP
						else T.Stone=1
			else
				if(T.StatResist.Find("Stone"))
					if(prob(T.StatResist["Stone"]))
						if(istype(T,/mob/monster)) TargList[T]+=T.MaxHP
						else T.Stone = 1
				else
					if(prob(50))
						if(istype(T,/mob/monster)) TargList[T]+=T.MaxHP
						else T.Stone=1
	if(Action.Guard)
		for(var/mob/T in TargList)
			T.Protect=1
			T.Shell=1
			if(T.Slow) T.Slow=null
			else T.Haste=1
			if(T.Poison) T.Poison=null
			else T.Regen=1

	if(Action.Gradual_Petrify)
		for(var/mob/T in TargList)
			T.gradual_petrify_counter++
			if(T.gradual_petrify_counter>=gradual_petrify_count) T.Stone=1
	if(Action.Difference)
		for(var/mob/T in TargList)
			var/mob/PC/P = src
			var/Damage = round(P.MaxHP-P.HP)
			TargList[T]+=Damage
	if(Action.Scan)
		for(var/mob/monster/T in TargList)
			var/list/PartyList = list()
			if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList.Add(M)
			else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList.Add(M)
			sleep(15)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Name: [T]")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Level: [T.level]")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","HP: [T.HP]/[T.MaxHP] MP: [T.MP]/[T.MaxMP]")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Attack: [T.attack] Defense: [T.defense]")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Exp: [T.give_exp] GP: [T.give_gold]")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
		for(var/mob/PC/T in TargList)
			var/list/PartyList = list()
			if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList.Add(M)
			else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList.Add(M)
			sleep(15)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Name: [T]")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Level: [T.level]")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Class: [T.class]")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Attack: [T.xatt()]x[T.att()] Att%: [T.attp()]%")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Defense: [T.xdef()]x[T.def()] Def%: [T.defp()]%")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","MDefense: [T.xmagdef()]x[T.magdef()] MDef%: [T.magdefp()]%")
			sleep(30)
			for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")


/*	if(Action.Steal)
		for(var/mob/PC/T in TargList)
			var/list/PartyList = list()
			if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList.Add(M)
			else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList.Add(M)
			spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Can't steal.")
			spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
		for(var/mob/monster/T in TargList)
			var/list/PartyList = list()
			if(BLoc.Attackers.Find(src)) for(var/mob/M in BLoc.Attackers) PartyList.Add(M)
			else if(BLoc.Defenders.Find(src)) for(var/mob/M in BLoc.Defenders) PartyList.Add(M)
			switch(rand(0,32))
				if(1-11)
					if(prob(90))
						src.stoleitem++
						if(src.stoleitem>stoleitem_count)
							spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't steal.")
							spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
						else
							if(T.obj_drop[1])
								var/obj/item2 = T.obj_drop[1]
								var/obj/Ability/Basic/Item/O = locate(item2) in src.contents
								if(O) O.suffix = "[(text2num(O.suffix)) +1]"
								else if(src.contents.len>=20)
									spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't hold the item.")
									spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
								else {var/obj/Ability/Basic/item = new item2;src.contents+=item;item.suffix="1"}
								spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Steal successful!")
								spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
							else
								spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't steal.")
								spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
					else
						spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't steal.")
						spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
				if(12-32)
					if(prob(70))
						src.stoleitem++
						if(src.stoleitem>stoleitem_count)
							spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't steal.")
							spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
						else
							if(T.obj_drop[2])
								var/obj/item2 = T.obj_drop[2]
								var/obj/Ability/Basic/Item/O = locate(item2) in src.contents
								if(O) O.suffix = "[(text2num(O.suffix)) +1]"
								else if(src.contents.len>=20)
									spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't hold the item.")
									spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
								else {var/obj/Ability/Basic/item = new item2;src.contents+=item;item.suffix="1"}
								spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Steal successful!")
								spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
							else
								spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't steal.")
								spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
					else
						spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't steal.")
						spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
				else
					if(prob(50))
						src.stoleitem++
						if(src.stoleitem>stoleitem_count)
							spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't steal.")
							spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
						else
							if(T.obj_drop[3])
								var/obj/item2 = T.obj_drop[3]
								var/obj/Ability/Basic/Item/O = locate(item2) in src.contents
								if(O) O.suffix = "[(text2num(O.suffix)) +1]"
								else if(src.contents.len>=20)
									spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't hold the item.")
									spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
								else {var/obj/Ability/Basic/item = new item2;src.contents+=item;item.suffix="1"}
								spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Steal successful!")
								spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
							else
								spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't steal.")
								spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")
					else
						spawn(15) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.battle_screen("battle_message","Couldn't steal.")
						spawn(30) for(var/mob/PC/p in PartyList) if(p&&p.client&&p.HP>0) p.close_screen("battle_message")

*/

	if(length(TargList)) Damage(Action,TargList)
	//was it an item?
	if(istype(Action,/obj/Ability/Basic/Item)||istype(Action,/obj/Ability/Basic/Dart))
		src<<Action.Sound
		var/numitem = text2num(Action.suffix)
		numitem--
		if(numitem<1) del(Action)
		else Action.suffix="[numitem]"
	if(src.Haste)
		src.haste_counter++
		if(src.haste_counter>haste_count) {src.Haste=null;src.haste_counter=0}
		else gauge = atime_haste(level)
	else if(Slow)
		src.slow_counter++
		if(src.slow_counter>slow_count) {src.Slow=null;src.slow_counter=0}
		else gauge = atime_slow(level)
	else if(!Haste && !Slow) gauge = atime(level)

//NPC's action in battle
mob/proc/AiAttack()
	var/turf/battle/location/BLoc = locate(/turf/battle/location/) in view(src)
	if(!length(BLoc.Attackers)) Damage(src,MaxHP)
	else
		var/list/AttackList = new()
		if(src.Confuse) for(var/mob/monster/p in view(BLoc)) if(p.HP>0) AttackList+=p
		else for(var/mob/PC/p in view(BLoc)) if(p.client&&p.HP>0) AttackList+=p
		if(!length(AttackList))
			if(Haste) {gauge = atime_haste(level);return}
			else if(Slow) {gauge = atime_slow(level);return}
			else if(!Haste && !Slow) {gauge=atime(level);return}
		//choosing an attack from the monster's action list
		var/mob/monster/M = src
		var/Attack
		switch(rand(1,100))
			if(1 to 49) if(length(M.action)>=1) Attack = M.action[1]
			if(50 to 78) if(length(M.action)>=2) Attack = M.action[2]
			if(79 to 91) if(length(M.action)>=3) Attack = M.action[3]
			if(92 to 100) if(length(M.action)>=4) Attack = M.action[4]
		//displaying the attack's name
		if(Attack!="Attack") for(var/mob/PC/p in view(BLoc)) if(p.client) p.battle_screen("left_battle_attack_message","[Attack]")
		var/AttackType		//0 = sacrifice self // 1 = normal attack // 2 = normal attack on all
		var/AttackDef		//0 = cannot defend against // 1 = can defend against
		var/AttackEffect	//0 = Neither physical or Magical // 1 = Physical // 2 = Magical
		var/NumAttack		//number of attack	//length(AttackList) to attack them all
		var/Damage			//number of damage
		var/Drain			//number to hp drain
		var/ini_Dispell		//Inflict Dispell
		var/ini_Weak		//Inflict Weaken Damage
		var/ini_Darkness	//Inflict Darkness
		var/ini_Slow		//Inflict Slow
		var/ini_Poison		//Inflict Poison
		var/ini_Mute		//Inflict Mute
		var/ini_Sleep		//Inflict Sleep
		var/ini_Hold		//Inflict Hold
		var/ini_Stone		//Inflict Stone
		var/ini_Confuse		//Inflict Confuse
		var/ini_Countdown	//Inflict Countdown
		switch(Attack)
			if("Attack"){AttackType = 1;AttackDef = 1;AttackEffect=1;NumAttack = 1;Damage = (M.attack * (round(M.level/4) + 1))}
			if("Wave")
				AttackType = 1
				AttackDef = 1
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = (500+round(M.attack))/NumAttack
			if("Tidal Wave")
				AttackType = 1
				AttackDef = 0
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = 1000
			if("Fire2")
				AttackType = 1
				AttackDef = 1
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = (300+round(M.attack))/NumAttack
			if("Ice2")
				AttackType = 1
				AttackDef = 1
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = (300+round(M.attack))/NumAttack
			if("Bolt2")
				AttackType = 1
				AttackDef = 1
				AttackEffect = 2
				NumAttack = 1
				Damage = 300+M.attack
			if("Fire3")
				AttackType = 1
				AttackDef = 1
				AttackEffect = 2
				NumAttack = 1
				Damage = 1256
			if("Ice3")
				AttackType = 1
				AttackDef = 1
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = (1500+round(M.attack))/NumAttack
			if("Bolt3")
				AttackType = 1
				AttackDef = 1
				AttackEffect = 2
				NumAttack = 1
				Damage = 1500
			if("Meteo")
				AttackType = 2
				AttackDef = 1
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = (M.attack*round(M.level))
			if("2xAttack")
				AttackType = 1
				AttackDef = 1
				AttackEffect = 1
				NumAttack = 2
				Damage = (M.attack*round(M.level/4))
			if("Disrupt")
				AttackType = 1
				AttackDef = 0
				AttackEffect = 1
				NumAttack = length(AttackList)
				Damage = ((M.attack*round(M.level/2))/NumAttack)
			if("Explode")
				AttackType = 0
				AttackDef = 0
				AttackEffect = 2
				NumAttack = 1
				Damage = HP
			if("Digest","Needle")
				AttackType = 1
				AttackDef = 1
				AttackEffect = 1
				NumAttack = 1
				Damage = (M.attack*round(M.level/4))
			if("Bluster")
				AttackType = 2
				AttackDef = 0
				AttackEffect = 0
				NumAttack = length(AttackList)
				Damage = HP/80
			if("Tornado")
				AttackType = 2
				AttackDef = 0
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = HP/20
			if("ColdMist","DarkWave")
				AttackType = 2
				AttackDef = 0
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = (M.attack*round(M.level/4))/NumAttack
			if("Serpant Wave")
				AttackType = 2
				AttackDef = 0
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = 1500
			if("Nuke")
				AttackType = 1
				AttackDef = 0
				AttackEffect = 0
				NumAttack = 1
				Damage = 9999
			if("AirCut")
				AttackType = 2
				AttackDef = 0
				AttackEffect = 2
				NumAttack = length(AttackList)
				Damage = (M.attack*round(M.level/2))/NumAttack
			if("Drain")
				AttackType = 2
				AttackDef = 1
				AttackEffect = 2
				NumAttack = 1
				Poison = 1
				Damage = (M.attack*round(M.level/5))
				Drain = M.level/2


/*		if(!length(AttackList))
			if(Haste) {gauge = atime_haste(level);return}
			else if(Slow) {gauge = atime_slow(level);return}
			else if(!Haste && !Slow) {gauge=atime(level);return}*/

		//Preparing for Damage().
		var/list/TargList = new()
		if(!AttackType) TargList[src]=MaxHP
		for(var/i=NumAttack,i,i--) //for every attack..
			var/mob/Defender
			var/RandAttack = rand(1,length(AttackList))
			Defender = AttackList[RandAttack]
			if(AttackType==2) AttackList-=Defender //removing Defender from the list, if its an 'all' attack
			var/Dmg = Damage
			if(AttackEffect==1 && Defender.Covered) for(var/mob/P in view(BLoc)) if(P.Cover == Defender&&P.HP>0) Defender = P
			if(AttackDef)	//target can defend against the attack
				if(AttackEffect == 1)
					var/Def
					var/xDef
					var/Defp
					if(istype(Defender,/mob/PC)){var/mob/PC/p = Defender;Def = p.def();xDef = p.xdef();Defp=p.defp()}
					else{var/mob/monster/T = Defender;Def = (T.defense*(T.level/8));xDef = round(T.level/8);Defp = round(30 + (T.level/8))}
					var/Defense = rand(0,Def)
					Dmg -= Defense
					if(Dmg<=0){TargList[Defender]=0;continue} //miss
					var/xD = round(xDef/2)
					for(var/id=xDef,id>round(xDef/2),id--) if(prob(Defp)) xD++
					if(xD) Dmg/=xD
				else if(AttackEffect == 2)
					var/MDef
					var/xMDef
					var/MDefp
					if(istype(Defender,/mob/PC)){var/mob/PC/p = Defender;MDef = p.magdef();xMDef = p.xmagdef();MDefp = p.magdefp()}
					else{var/mob/monster/T = Defender;MDef = (T.defense*(T.level/8));xMDef = round(T.level/8);MDefp = round(30 + (T.level/8))}
					var/Defense = rand(0,MDef)
					Dmg -= Defense
					if(Dmg<=0){TargList[Defender]=0;continue}
					var/xMD = round(xMDef/2)
					for(var/id=xMDef,id>round(xMDef/2),id--) if(prob(MDefp)) xMD++
					if(xMD) Damage/=xMD
			if(ini_Dispell)
				Status_Null(Defender)
			if(ini_Weak)
				switch(rand(1,6))
					if(1) TargList[Defender]+=round((Defender.HP*25)/100)
					if(2) TargList[Defender]+=round((Defender.HP*35)/100)
					if(3) TargList[Defender]+=round((Defender.HP*50)/100)
					if(4) TargList[Defender]+=round((Defender.HP*75)/100)
					if(5) TargList[Defender]+=round((Defender.HP*85)/100)
					if(6) TargList[Defender]+=round((Defender.HP*90)/100)
			if(ini_Darkness)
				if(prob(70)) Defender.Darkness=1
			if(ini_Slow)
				if(prob(70))
					if(Defender.Haste)
						Defender.Haste=null
					else
						Defender.Slow=1
			if(ini_Poison)
				if(prob(60)) Defender.Poison=1
			if(ini_Mute)
				if(prob(50)) Defender.Mute=1
			if(ini_Sleep)
				if(prob(60)) Defender.Sleep=1
			if(ini_Hold)
				if(prob(50)) Defender.Hold=1
			if(ini_Stone)
				if(prob(30)) Defender.Stone=1
			if(ini_Confuse)
				if(prob(70)) Defender.Confuse=1
			if(ini_Countdown)
				if(prob(90)) Defender.Countdown=1
			//Damaging
			if(AttackEffect==1 && Defender.Blink)
				Defender.blink_counter++
				if(Defender.blink_counter>blink_count) {Defender.Blink=null;Defender.blink_counter=0}
				else Dmg=0
			if(AttackEffect==1 && Defender.Protect)
				Defender.protect_counter++
				if(Defender.protect_counter>protect_count) {Defender.Protect=null;Defender.protect_counter=0}
				else Dmg/=2
			if(AttackEffect==1 && Defender.Sleep)
				Defender.Sleep=null
			if(AttackEffect==1 && src.Cry)
				src.cry_counter++
				if(src.cry_counter>cry_count) {src.Cry=null;src.cry_counter=0}
				else Dmg/=2
			if(AttackEffect==1 && src.Berserk)
				src.berserk_counter++
				if(src.berserk_counter>berserk_count) {src.Berserk=null;src.berserk_counter=0}
				else Dmg = round((Dmg*25)/100)
			if(AttackEffect==2 && Defender.Shell)
				Defender.shell_counter++
				if(Defender.shell_counter>shell_count) {Defender.Shell=null;Defender.shell_counter=0}
				else Dmg/=2
			if(AttackEffect==2 && Defender.Reflect)
				Defender.reflect_counter++
				if(Defender.reflect_counter>reflect_count) {Defender.Reflect=null;Defender.reflect_counter=0}
				else Defender = src
			if(M.Poison)
				var/Psn = MaxHP/10
				TargList[M]=Psn
			if(M.Countdown)
				countdown_counter++
				if(countdown_counter==countdown_count)
					TargList[M]=MaxHP
			if(Drain)
				var/Drn = (Defender.HP*Drain)/100
				TargList[M]+=-Drn
			TargList[Defender]=Dmg
		if(M.Mute && AttackEffect==2)
			M.mute_counter++
			if(M.mute_counter>mute_count) {M.Mute=null;M.mute_counter=0}
			else
				if(M.Haste) gauge=atime_haste(M.level)
				else if(M.Slow) gauge=atime_slow(M.level)
				else if(!M.Haste && !M.Slow) gauge=atime(M.level)
		else if(M.Sleep)
			M.sleep_counter++
			if(M.sleep_counter>sleep_count) {M.Sleep=null;M.sleep_counter=0}
			else
				if(M.Haste) gauge=atime_haste(M.level)
				else if(M.Slow) gauge=atime_slow(M.level)
				else if(!M.Haste && !M.Slow) gauge=atime(M.level)
		else if(Hold)
			M.hold_counter++
			if(M.hold_counter>hold_count) {M.Hold=null;M.hold_counter=0}
			else
				if(M.Haste) gauge=atime_haste(M.level)
				else if(M.Slow) gauge=atime_slow(M.level)
				else if(!M.Haste && !M.Slow) gauge=atime(M.level)
		else if(!M.Sleep && !M.Hold)
			AIDamage(null,TargList)
			if(M.Haste) gauge=atime_haste(M.level)
			else if(M.Slow) gauge=atime_slow(M.level)
			else if(!M.Haste && !M.Slow) gauge=atime(M.level)


//Damage procedures, every damage are done here
mob/proc/Damage(obj/Ability/Action, list/TargList)
	if(!length(TargList)) return
	var/turf/battle/location/BLoc = locate(/turf/battle/location/) in view(src)
	var/mob/PC/Z=usr
	if(Z.Jump_Charge>=1) Z.Jump_Charge=0 // so the invincibility does not last. ~Crimson
	for(var/mob/Target in TargList)
		if(!Target) continue
		var/Damage = round(TargList[Target])
		if(!Inflict_Status_Check(Action,Target)) if(!Damage){disp_dmg(Target,"miss");continue}
		if(Damage>9999) Damage=9999
		if(Damage<-9999) Damage=-9999
		if(Target.Stone) Damage=0
		if(Target.Jump_Charge) Damage=0
		//status effect stuff
		for(var/E in btl_seffect(Action))
			if(E>0) Target.btl_status(STATUS_ADD,E,Action.SEffect[E])
			else Target.btl_status(STATUS_REM,E)
		if(Action.Muteable&&src.Mute) {disp_dmg(Target,"miss");continue}
		if(Action.Curseable&&src.Curse) {disp_dmg(Target,"miss");continue}
		if(istype(Target,/mob/PC))
			var/mob/PC/T = Target
			if(T.row_position == 2 && Action && Action.DmgType == DMG_PHYSICAL) // 1 = physical
				Damage = round(Damage / 2)
			if(Damage<0)
				if(T.HP<=0&&Action.Revive)
					if(BLoc.Attackers.Find(T)) BLoc.nAttackers++
					else if(BLoc.Defenders.Find(T)) BLoc.nDefenders++
				else if(T.HP<=0&&Action.Pheonix)
					if(BLoc.Attackers.Find(T)) BLoc.nAttackers++
					else if(BLoc.Defenders.Find(T)) BLoc.nDefenders++
				else if(T.HP>0&&Action.Revive||T.HP<=0&&!Action.Revive||T.HP>0&&Action.Pheonix||T.HP<=0&&!Action.Pheonix){disp_dmg(Target,"miss");continue}
				T.HP-=Damage
			else if(Damage>0 && T.HP <= 0) continue
			else
				if(Inflict_Status_Check(Action,Target))
					if(Damage) {T.HP-=Damage;T.BtlFrm("battle_hit")}
				else{T.HP-=Damage;T.BtlFrm("battle_hit")}
		else Target.HP-=Damage
		if(Damage) disp_dmg(Target,"[Damage]")
		if(!Damage) continue
		//death check
		if(Target.HP>Target.MaxHP) Target.HP = Target.MaxHP
		else if(Target.HP<=0||Target.Stone)
			if(!Target.Stone) Target.HP=0
			//cycling throught everyone's Target to replace the dead one
			var/list/TargLeft = new()
			if(BLoc.Attackers.Find(Target)){BLoc.nAttackers--;for(var/mob/M in BLoc.Attackers) if(M.HP>0) TargLeft+=M}
			else if(BLoc.Defenders.Find(Target)){BLoc.nDefenders--;for(var/mob/M in BLoc.Defenders) if(M.HP>0) TargLeft+=M}
			if(length(TargLeft)) for(var/mob/PC/M in view(BLoc)) if(M.HP>0&&M.btl_target==Target) M.btl_target = pick(TargLeft)
			if(istype(Target,/mob/monster))
				//##insert monster's death sound in here##
				spawn(10){BLoc.Defenders-=Target;Target.Del(src);for(var/mob/PC/p in BLoc.Attackers) if(p.client) p.battle_screen("left_panel_refresh")}
				continue
			else if(istype(Target,/mob/PC))
				var/mob/PC/p = Target
				p.BtlFrm("battle_dead")
				p.btl_action = null;p.btl_target = null
				if(Action.jump_charge) p.gauge = atime_jump(p.level)
				if(p.Haste) p.gauge = atime_haste(p.level)
				else if(p.Slow) p.gauge = atime_slow(p.level)
				else if(!p.Haste && !p.Slow) p.gauge = atime(p.level)
		//refreshing the panel
		if(BLoc.Attackers.Find(Target)) for(var/mob/PC/p in BLoc.Attackers) if(p.client) p.battle_screen("right_panel_refresh","rpanel[BLoc.Attackers.Find(Target)]")
		if(BLoc.Defenders.Find(Target)) if(Target.client&&istype(Target,/mob/PC)) for(var/mob/PC/p in BLoc.Defenders) p.battle_screen("right_panel_refresh","rpanel[BLoc.Defenders.Find(Target)]")

mob/proc/AIDamage(obj/Ability/Action,list/TargList)
	if(!length(TargList)) return
	var/turf/battle/location/BLoc = locate(/turf/battle/location/) in view(src)
	for(var/mob/Target in TargList)
		if(!Target) continue
		var/Damage = round(TargList[Target])
		if(Target.Jump_Charge>=1) Damage=0 // So you do not get any damage while charging jump. ~Crimson
		if(!Damage){disp_dmg(Target,"miss");continue}
		else if(Damage>9999) Damage=9999
		else if(Damage<-9999) Damage=-9999
		if(istype(Target,/mob/PC))
			var/mob/PC/T = Target
			if(Damage<0)
				if(T.HP<=0&&Action.Revive)
					if(BLoc.Attackers.Find(T)) BLoc.nAttackers++
					else if(BLoc.Defenders.Find(T)) BLoc.nDefenders++
				else if(T.HP>0&&Action.Revive||T.HP<=0&&!Action.Revive){disp_dmg(Target,"miss");continue}
				T.HP-=Damage
				T.BtlFrm("battle_stand")
			else if(Damage>0 && T.HP <= 0) continue
			else {T.HP-=Damage;T.BtlFrm("battle_hit")}
		else Target.HP-=Damage
		disp_dmg(Target,"[Damage]")
		//death check
		if(Target.HP>Target.MaxHP) Target.HP = Target.MaxHP
		else if(Target.HP<=0)
			Target.HP=0
			//cycling throught everyone's Target to replace the dead one
			var/list/TargLeft = new()
			if(BLoc.Attackers.Find(Target)){BLoc.nAttackers--;for(var/mob/M in BLoc.Attackers) if(M.HP>0) TargLeft+=M}
			else if(BLoc.Defenders.Find(Target)){BLoc.nDefenders--;for(var/mob/M in BLoc.Defenders) if(M.HP>0) TargLeft+=M}
			if(length(TargLeft)) for(var/mob/PC/M in view(BLoc)) if(M.HP>0&&M.btl_target==Target) M.btl_target = pick(TargLeft)
			if(istype(Target,/mob/monster))
				//##insert monster's death sound in here##
				spawn(10){BLoc.Defenders-=Target;Target.Del(src);for(var/mob/PC/p in BLoc.Attackers) if(p.client) p.battle_screen("left_panel_refresh")}
				continue
			else if(istype(Target,/mob/PC))
				var/mob/PC/p = Target
				p.BtlFrm("battle_dead")
				p.btl_action = null;p.btl_target = null
				if(p.Haste) p.gauge = atime_haste(p.level)
				else if(p.Slow) p.gauge = atime_slow(p.level)
				else if(!p.Haste && !p.Slow) p.gauge = atime(p.level)
		//refreshing the panel
		if(BLoc.Attackers.Find(Target)) for(var/mob/PC/p in BLoc.Attackers) if(p.client) p.battle_screen("right_panel_refresh","rpanel[BLoc.Attackers.Find(Target)]")
		if(BLoc.Defenders.Find(Target)) if(Target.client&&istype(Target,/mob/PC)) for(var/mob/PC/p in BLoc.Defenders) p.battle_screen("right_panel_refresh","rpanel[BLoc.Defenders.Find(Target)]")

//battle attributes/effects..
mob
	proc/btl_attrib(obj/Ability/Action)
		if(Action)
			var/list/attrib = new()
			if(Action.DmgType == DMG_PHYSICAL)
				if(istype(src,/mob/PC))
					var/mob/PC/p = src
					if(istype(p.lhand,/obj/weapon)) for(var/X in p.lhand.attrib) attrib+=X
					if(istype(p.rhand,/obj/weapon)) for(var/X in p.rhand.attrib) attrib+=X
				else if(istype(src,/mob/monster))
					var/mob/monster/p = src
					for(var/X in p.phys_attrib) attrib+=X
			for(var/X in Action.Attrib) attrib+=X
			return attrib
	proc/btl_seffect(obj/Ability/Action)
		if(Action)
			var/list/seffect = new()
			if(Action.DmgType == DMG_PHYSICAL)
				if(istype(src,/mob/PC))
					var/mob/PC/p = src
					if(istype(p.lhand,/obj/weapon)) for(var/X in p.lhand.effect) seffect+=X
					if(istype(p.rhand,/obj/weapon)) for(var/X in p.rhand.effect) seffect+=X
				else if(istype(src,/mob/monster))
					var/mob/monster/p = src
					for(var/X in p.phys_effect) seffect+=X
			for(var/X in Action.SEffect) seffect+=X
			return seffect

//battle engine menus, Action invicons are displayed using this...
mob/PC/proc/battle_invicon(var/screen,var/obj/Ability/Action)
	if(screen=="right_attack_message"&&Action)
		var/obj/Ability/O
		O = Action
		close_screen("right_attack_message")
		screen_sbackground(11,15,16,16,8,"right_attack_message")
		screen_invicon(11.5,15.5,0,9,,O.invicon,"right_attack_message")
		screen_textl(12,17,15.5,15.5,0,0,9,,O.name,"right_attack_message")
		spawn(15) close_screen("right_attack_message")
	else if(screen=="left_attack_message"&&Action)
		var/obj/Ability/O
		O = Action
		close_screen("right_attack_message")
		screen_sbackground(2,15,7,16,8,"left_attack_message")
		screen_invicon(2.5,15.5,0,9,,O.invicon,"left_attack_message")
		screen_textl(3,8,15.5,15.5,0,0,9,,O.name,"left_attack_message")
		spawn(15) close_screen("left_battle_attack_message")
//battle engine menus, everything display on client's screen is here
mob/PC/proc/battle_screen(var/screen,var/slot,var/obj/Ability/ActionType)
	if(screen=="battle_message")
		screen_background(2,16,15,16,0,0,4,"battle_message")
		screen_textl(3,16,15.5,15,0,0,5,,slot,"battle_message")
	else if(screen=="battle_menu")
		inmenu="battle_menu"
		menupos=1
		screen_background(4,9,2,6,0,0,6,"battle_menu")
		if(action[1]) screen_textl(4.5,12,6,6,0,-8,7,,"[action[1]]","battle_menu")
		if(action[2]) screen_textl(4.5,12,5,5,0,-4,7,,"[action[2]]","battle_menu")
		if(action[3]) screen_textl(4.5,12,4,4,0,0,7,,"[action[3]]","battle_menu")
		if(action[4]) screen_textl(4.5,12,3,3,0,4,7,,"[action[4]]","battle_menu")
		if(action[5]) screen_textl(4.5,12,2,2,0,8,7,,"[action[5]]","battle_menu")
		menupos=1
		cursor=new(client)
		cursor.screen_loc="3:16,6:-8"
	else if(screen=="battle_left_menu")
		inmenu="battle_left_menu"
		screen_sbackground(3,5,6,6,8,"battle_left_menu")
		screen_textl(4,7,5.5,5.5,0,0,9,,"Run","battle_left_menu")
		cursor.screen_loc="3,5:16"
	else if(screen=="battle_right_menu")
		inmenu="battle_right_menu"
		screen_sbackground(8,5,11,6,8,"battle_right_menu")
		screen_textl(9,12,5.5,5.5,0,0,9,,"Parry","battle_right_menu")
		cursor.screen_loc="8,5:16"
	else if(screen=="left_battle_attack_message"&&slot)
		close_screen("left_battle_attack_message")
		screen_sbackground(2,15,7,16,8,"left_battle_attack_message")
		screen_textl(3,8,15.5,15.5,0,0,9,,"[slot]","left_battle_attack_message")
		spawn(15) close_screen("left_battle_attack_message")
	else if(screen=="right_battle_attack_message"&&slot)
		close_screen("right_battle_attack_message")
		screen_sbackground(11,15,16,16,8,"right_battle_attack_message")
		screen_textl(12,17,15.5,15.5,0,0,9,,"[slot]","right_battle_attack_message")
		spawn(15) close_screen("right_battle_attack_message")
	else if(screen=="battle_item")
		inmenu="battle_item"
		screen_background(6,12,5,10,0,0,8,"battle_item")
		menulist = new()
		// 'sorting' item in list for battle
		for(var/obj/Ability/Basic/Item/I in src.contents) menulist+=I
		for(var/obj/Ability/Basic/Dart/I in src.contents) menulist+=I // this is the new addition
		for(var/obj/Key_Item/K in src.contents) menulist+=K
		for(var/obj/O in src.contents) if(!menulist.Find(O)) menulist+=O
		battle_screen("battle_item_refresh",1)
	else if(screen=="battle_dart")
		inmenu="battle_dart"
		screen_background(6,12,5,10,0,0,8,"battle_dart")
		menulist = new()
		// 'sorting' item in list for battle
		for(var/obj/Ability/Basic/Dart/D in src.contents) menulist+=D
		for(var/obj/Ability/Basic/Item/I in src.contents) menulist+=I
		for(var/obj/Key_Item/K in src.contents) menulist+=K
		for(var/obj/O in src.contents) if(!menulist.Find(O)) menulist+=O
		battle_screen("battle_dart_refresh",1)
	else if(screen=="battle_item_refresh"&&slot)
		for(var/obj/onscreen/invicon/O in client.screen) if(O.screentag=="battle_item") del(O)
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="battle_item") del(O)
		menuaction=slot
		var/itemslot=0
		for(var/i=menuaction,i<=menuaction+5,i++)
			var/obj/Ability/O
			var/Color
			if(length(menulist)>=i)
				O = menulist[i]
				//coloring
				if(istype(O,/obj/Ability/Basic/Item) && O.CanUse != 2 && O.CanUse != 3) Color=0
				else if(istype(O,/obj/Key_Item)) Color=1
				else Color=2
				itemslot++
				switch(itemslot)
					if(1)
						screen_invicon(6.5,9.5,0,9,Color,O.invicon,"battle_item")
						screen_textl(7,11,9.5,9.5,0,0,9,Color,O.name,"battle_item")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,9.5,9.5,0,0,9,Color,":","battle_item")
							screen_textr(11,12,9.5,9.5,0,0,9,Color,O.suffix,"battle_item")
					if(2)
						screen_invicon(6.5,8.5,0,9,Color,O.invicon,"battle_item")
						screen_textl(7,11,8.5,8.5,0,0,9,Color,O.name,"battle_item")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,8.5,8.5,0,0,9,Color,":","battle_item")
							screen_textr(11,12,8.5,8.5,0,0,9,Color,O.suffix,"battle_item")
					if(3)
						screen_invicon(6.5,7.5,0,9,Color,O.invicon,"battle_item")
						screen_textl(7,11,7.5,7.5,0,0,9,Color,O.name,"battle_item")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,7.5,7.5,0,0,9,Color,":","battle_item")
							screen_textr(11,12,7.5,7.5,0,0,9,Color,O.suffix,"battle_item")
					if(4)
						screen_invicon(6.5,6.5,0,9,Color,O.invicon,"battle_item")
						screen_textl(7,11,6.5,6.5,0,0,9,Color,O.name,"battle_item")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,6.5,6.5,0,0,9,Color,":","battle_item")
							screen_textr(11,12,6.5,6.5,0,0,9,Color,O.suffix,"battle_item")
					if(5)
						screen_invicon(6.5,5.5,0,9,Color,O.invicon,"battle_item")
						screen_textl(7,11,5.5,5.5,0,0,9,Color,O.name,"battle_item")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,5.5,5.5,0,0,9,Color,":","battle_item")
							screen_textr(11,12,5.5,5.5,0,0,9,Color,O.suffix,"battle_item")
		if(menuaction>1) screen_textl(6.5,2,5,5,0,0,9,,"<","battle_item")
		if(length(menulist)>=menuaction+5) screen_textl(12,2,5,5,0,0,9,,">","battle_item")
		menupos=1
		cursor.screen_loc="5:16,9:8"
	else if(screen=="battle_dart_refresh"&&slot)
		for(var/obj/onscreen/invicon/O in client.screen) if(O.screentag=="battle_dart") del(O)
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="battle_dart") del(O)
		menuaction=slot
		var/itemslot=0
		for(var/i=menuaction,i<=menuaction+5,i++)
			var/obj/Ability/O
			var/Color
			if(length(menulist)>=i)
				O = menulist[i]
				//coloring
				if(istype(O,/obj/Ability/Basic/Dart) && O.CanUse != 2 && O.CanUse != 3) Color=0
				else if(istype(O,/obj/Key_Item)) Color=1
				else Color=2
				itemslot++
				switch(itemslot)
					if(1)
						screen_invicon(6.5,9.5,0,9,Color,O.invicon,"battle_dart")
						screen_textl(7,11,9.5,9.5,0,0,9,Color,O.name,"battle_dart")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,9.5,9.5,0,0,9,Color,":","battle_dart")
							screen_textr(11,12,9.5,9.5,0,0,9,Color,O.suffix,"battle_dart")
					if(2)
						screen_invicon(6.5,8.5,0,9,Color,O.invicon,"battle_dart")
						screen_textl(7,11,8.5,8.5,0,0,9,Color,O.name,"battle_dart")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,8.5,8.5,0,0,9,Color,":","battle_dart")
							screen_textr(11,12,8.5,8.5,0,0,9,Color,O.suffix,"battle_dart")
					if(3)
						screen_invicon(6.5,7.5,0,9,Color,O.invicon,"battle_dart")
						screen_textl(7,11,7.5,7.5,0,0,9,Color,O.name,"battle_dart")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,7.5,7.5,0,0,9,Color,":","battle_dart")
							screen_textr(11,12,7.5,7.5,0,0,9,Color,O.suffix,"battle_dart")
					if(4)
						screen_invicon(6.5,6.5,0,9,Color,O.invicon,"battle_dart")
						screen_textl(7,11,6.5,6.5,0,0,9,Color,O.name,"battle_dart")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,6.5,6.5,0,0,9,Color,":","battle_dart")
							screen_textr(11,12,6.5,6.5,0,0,9,Color,O.suffix,"battle_dart")
					if(5)
						screen_invicon(6.5,5.5,0,9,Color,O.invicon,"battle_dart")
						screen_textl(7,11,5.5,5.5,0,0,9,Color,O.name,"battle_dart")
						if(istype(O,/obj/Ability/Basic))
							screen_textl(11,11.5,5.5,5.5,0,0,9,Color,":","battle_dart")
							screen_textr(11,12,5.5,5.5,0,0,9,Color,O.suffix,"battle_dart")
		if(menuaction>1) screen_textl(6.5,2,5,5,0,0,9,,"<","battle_dart")
		if(length(menulist)>=menuaction+5) screen_textl(12,2,5,5,0,0,9,,">","battle_dart")
		menupos=1
		cursor.screen_loc="5:16,9:8"
	else if(screen=="battle_askills"&&ActionType)
		menupos = 1
		menulist = new()
		for(var/A in typesof(ActionType))
			if(A!=ActionType.type)
				var/obj/Ability/O = new A
				if(level>=O.LvlNeed) menulist+=O
		if(!length(menulist)){src<<SOUND_WRONG;return}
		//list is done.. displaying!
		inmenu="battle_askills"
		screen_background(2,16,3,7,0,0,8,"battle_askills")
		screen_sbackground(7,1,16,2,8,"battle_askills")
		screen_textl(7.5,10,1.5,1.5,0,0,9,0,"Cost:","battle_askills")
		screen_textl(12.5,14,1.5,1.5,0,0,9,0,"MP:","battle_askills")
		screen_textr(14,15.5,1.5,1.5,0,0,9,0,"[MP]","battle_askills")
		var/X=0
		var/Y=0
		var/YO=0
		for(var/obj/Ability/O in menulist)
			var/Color = 0
			if(O.CanUse == 2 || O.CanUse == 3) Color = 2
			switch(menulist.Find(O))
				if(1){X=2.5;Y=6.5;YO=8};if(2){X=7;Y=6.5;YO=8};if(3){X=11.5;Y=6.5;YO=8}
				if(4){X=2.5;Y=6;YO=6};if(5){X=7;Y=6;YO=6};if(6){X=11.5;Y=6;YO=6}
				if(7){X=2.5;Y=5.5;YO=4};if(8){X=7;Y=5.5;YO=4};if(9){X=11.5;Y=5.5;YO=4}
				if(10){X=2.5;Y=5;YO=2};if(11){X=7;Y=5;YO=2};if(12){X=11.5;Y=5;YO=2}
				if(13){X=2.5;Y=4.5;YO=0};if(14){X=7;Y=4.5;YO=0};if(15){X=11.5;Y=4.5;YO=0}
				if(16){X=2.5;Y=4;YO=-2};if(17){X=7;Y=4;YO=-2};if(18){X=11.5;Y=4;YO=-2}
				if(19){X=2.5;Y=3.5;YO=-4};if(20){X=7;Y=3.5;YO=-4};if(21){X=11.5;Y=3.5;YO=-4}
			//displaying
			screen_invicon(X,Y,YO,9,Color,O.invicon,"battle_askills")
			screen_textl(X+0.5,X+4,Y,Y,0,YO,9,Color,O.name,"battle_askills")
			battle_screen("battle_askills_cost_refresh")
			if(!cursor) cursor = new(client)
			cursor.screen_loc="2,6:16"
	else if(screen=="battle_askills_cost_refresh")
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag == "battle_askills_cost") del(O)
		if(length(menulist)>=menupos)
			var/obj/Ability/O = menulist[menupos]
			screen_textr(10,11,1.5,1.5,0,0,9,0,"[O.MPCost]","battle_askills_cost")
	else if(screen=="panel")
		inmenu="panel"
		battle_screen("left_panel_refresh")
		battle_screen("right_panel_refresh")
	else if(screen=="left_panel_refresh")
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="left_panel") del(O)
		var/list/left_panel[] = new()
		var/turf/battle/location/BLoc = locate(/turf/battle/location/) in view(src)
		if(!BLoc) return
		//compiling the listah
		if(BLoc.Attackers.Find(src))
			for(var/mob/M in BLoc.Defenders)
				if(left_panel.Find(M.name)) left_panel[M.name]++
				else left_panel[M.name]=1
		else if(BLoc.Defenders.Find(src))
			for(var/mob/M in BLoc.Attackers)
				if(left_panel.Find(M.name)) left_panel[M.name]++
				else left_panel[M.name]=1
		if(!length(left_panel)) return
		var/left_panel_slot
		for(var/N in left_panel)
			left_panel_slot++
			switch(left_panel_slot)
				if(1){screen_textl(2.5,7,6,6,0,-8,5,,N,"left_panel");if(left_panel[N]>1) screen_textl(7,7.5,6,6,0,-8,5,,num2text(left_panel[N]),"left_panel")}
				if(2){screen_textl(2.5,7,5,5,0,-4,5,,N,"left_panel");if(left_panel[N]>1) screen_textl(7,7.5,5,5,0,-4,5,,num2text(left_panel[N]),"left_panel")}
				if(3){screen_textl(2.5,7,4,4,0,0,5,,N,"left_panel");if(left_panel[N]>1) screen_textl(7,7.5,4,4,0,0,5,,num2text(left_panel[N]),"left_panel")}
				if(4){screen_textl(2.5,7,3,3,0,4,5,,N,"left_panel");if(left_panel[N]>1) screen_textl(7,7.5,3,3,0,4,5,,num2text(left_panel[N]),"left_panel")}
				if(5){screen_textl(2.5,7,2,2,0,8,5,,N,"left_panel");if(left_panel[N]>1) screen_textl(7,7.5,2,2,0,8,5,,num2text(left_panel[N]),"left_panel")}
	else if(screen=="right_panel_refresh")
		if(!slot) for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="rpanel1"||O.screentag=="rpanel2"||O.screentag=="rpanel3"||O.screentag=="rpanel4"||O.screentag=="rpanel5") del(O)
		else for(var/obj/onscreen/text/O in client.screen) if(O.screentag==slot) del(O)
		var/turf/battle/location/BLoc = locate(/turf/battle/location) in view(src)
		if(!BLoc) return
		if(!slot||slot=="rpanel1")
			var/mob/PC/p
			if(BLoc.Attackers.Find(src)) p = BLoc.Attackers[1]
			else p = BLoc.Defenders[1]
			if(!p) return
			var/color=0
			if(p.gauge<=0) color=1
			screen_textl(8.5,12,6,6,0,-8,5,color,p.name,"rpanel1")
			screen_textr(11.5,16,6,6,0,-8,5,0,"[p.HP]/[p.MaxHP]","rpanel1")
		if((BLoc.Attackers.Find(src)&&length(BLoc.Attackers)<2)||(BLoc.Defenders.Find(src)&&length(BLoc.Defenders)<2)) return
		if(!slot||slot=="rpanel2")
			var/mob/PC/p
			if(BLoc.Attackers.Find(src)) p = BLoc.Attackers[2]
			else p = BLoc.Defenders[2]
			if(!p) return
			var/color=0
			if(p.gauge<=0) color=1
			screen_textl(8.5,12,5,5,0,-4,5,color,p.name,"rpanel2")
			screen_textr(11.5,16,5,5,0,-4,5,0,"[p.HP]/[p.MaxHP]","rpanel2")
		if((BLoc.Attackers.Find(src)&&length(BLoc.Attackers)<3)||(BLoc.Defenders.Find(src)&&length(BLoc.Defenders)<3)) return
		if(!slot||slot=="rpanel3")
			var/mob/PC/p
			if(BLoc.Attackers.Find(src)) p = BLoc.Attackers[3]
			else p = BLoc.Defenders[3]
			if(!p) return
			var/color=0
			if(p.gauge<=0) color=1
			screen_textl(8.5,12,4,4,0,0,5,color,p.name,"rpanel3")
			screen_textr(11.5,16,4,4,0,0,5,0,"[p.HP]/[p.MaxHP]","rpanel3")
		if((BLoc.Attackers.Find(src)&&length(BLoc.Attackers)<4)||(BLoc.Defenders.Find(src)&&length(BLoc.Defenders)<4)) return
		if(!slot||slot=="rpanel4")
			var/mob/PC/p
			if(BLoc.Attackers.Find(src)) p = BLoc.Attackers[4]
			else p = BLoc.Defenders[4]
			if(!p) return
			var/color=0
			if(p.gauge<=0) color=1
			screen_textl(8.5,12,3,3,0,4,5,color,p.name,"rpanel4")
			screen_textr(11.5,16,3,3,0,4,5,0,"[p.HP]/[p.MaxHP]","rpanel4")
		if((BLoc.Attackers.Find(src)&&length(BLoc.Attackers)<5)||(BLoc.Defenders.Find(src)&&length(BLoc.Defenders)<5)) return
		if(!slot||slot=="rpanel5")
			var/mob/PC/p
			if(BLoc.Attackers.Find(src)) p = BLoc.Attackers[5]
			else p = BLoc.Defenders[5]
			if(!p) return
			var/color=0
			if(p.gauge<=0) color=1
			screen_textl(8.5,12,2,2,0,8,5,color,p.name,"rpanel5")
			screen_textr(11.5,16,2,2,0,8,5,0,"[p.HP]/[p.MaxHP]","rpanel5")
	else if(screen=="monster_drop")
		inmenu = "monster_drop"
		//menu
		screen_sbackground(9,14,15,15,7,"monster_drop_menu")
		screen_textl(10,12,14.5,14.5,0,0,8,0,"Take","monster_drop_menu")
		screen_textl(13,15,14.5,14.5,0,0,8,0,"Pass","monster_drop_menu")
		//list
		screen_background(3,15,8,13,0,0,7,"monster_drop")
		var/turf/battle/location/BLoc = locate(/turf/battle/location) in view(src)
		var/obj_slot
		for(var/obj/O in BLoc.obj_reward){obj_slot++;battle_screen("monster_drop_list",obj_slot)}
		menupos = 1
		cursor = new(client)
		cursor.screen_loc = "3,12:8"
	else if(screen=="monster_drop_list"&&slot)
		for(var/obj/onscreen/O in client.screen) if(O.screentag == "monster_drop[slot]") del(O)
		var/turf/battle/location/BLoc = locate(/turf/battle/location) in view(src)
		var/obj/O = BLoc.obj_reward[slot]
		var/X,Y,Color
		if(!BLoc.obj_reward[O]) Color = 1
		else if(BLoc.obj_reward[O] != src) Color = 2
		switch(slot)
			if(1){X=4;Y=12}
			if(2){X=10;Y=12}
			if(3){X=4;Y=11}
			if(4){X=10;Y=11}
			if(5){X=4;Y=10}
			if(6){X=10;Y=10}
			if(7){X=4;Y=9}
			if(8){X=10;Y=9}
			if(9){X=4;Y=8}
			if(10){X=10;Y=8}
		screen_invicon(X,Y,16,8,Color,O.invicon,"monster_drop[slot]")
		screen_textl(X+0.5,X+4.5,Y,Y,0,16,8,Color,O.name,"monster_drop[slot]")
	else if(screen=="monster_drop_tp" && slot)
		inmenu = "monster_drop_tp"
		menuanswer = menupos
		menupos = 1
		cursor.screen_loc = "9,14:8"