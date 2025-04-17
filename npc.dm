obj/NPC
	InnKeeper{name="Inn";interact_dist = 2}
	HP_Recover{name="HP Recoverer"}
	MP_Recover{name="MP Recoverer"}
	White_Chocobo{name="White Chocobo";icon='mob/vehicule/w_choco.dmi';icon_state="normal"}
	Namingway{name="Namingway";icon='mob/npc/namingway.dmi'}
	density=1
	var
		message
		cost
		ai=75
		speed=20
		last_move
		interact_dist = 1
		wander
		dance
		giveitem
		itemnum
		heldweapon
		heldshield
		heldhelmet
		heldarmor
		heldglove
		heldkeyitem
		heldgold
		chestnum
		battle
		battle2
		battle3
		battle4
		battle_message
		battle_message2
		battle_message3
		battle_message4
	New()
		.=..()
		if(wander) spawn(speed) Wander()
		else if(dance) spawn(speed) Dance()
	proc/Wander()
		var/list/step_to_list = list(NORTH,WEST,SOUTH,EAST)
		for(var/step_rand in step_to_list)
			var/atom/step_to = get_step(src,step_rand)
			if(step_to&&step_to.density) step_to_list-=step_rand
			for(var/atom/M in step_to) if(M.density) step_to_list-=step_rand
		if(length(step_to_list))
			if(last_move&&(last_move in step_to_list)&&prob(ai)) step(src,last_move)
			else{last_move = pick(step_to_list);step(src,last_move)}
		spawn(speed) Wander()
	proc/Dance()
		var/dance = rand(1,2)
		if(dance==1){var/angle = rand(1,2);if(angle==1) angle = 90;else angle = -90;dir = turn(src.dir, angle);sleep(2);dir = turn(src.dir, angle);sleep(2);dir = turn(src.dir, angle);sleep(2);dir = turn(src.dir, angle)}
		if(dance==2)
			var/jump
			var/angle = rand(1,2)
			if(angle==1) angle = 90
			else angle = -90
			for(jump=1, jump<=16, jump++)
				if(jump <= 8) src.pixel_y+=4
				else src.pixel_y-=4
				if(jump==6||jump==8||jump==10||jump==12){dir = turn(dir,angle)}
				sleep(1)
		spawn(20) Dance()
	pixel_y=4
	beardedman_purple
		name="Bearded man"
		icon='mob/npc/beardedman.dmi'
		icon_state="purple"
	beardedman_blue
		name="Bearded man"
		icon='mob/npc/beardedman.dmi'
		icon_state="blue"
	beardedman_red
		name="Bearded man"
		icon='mob/npc/beardedman.dmi'
		icon_state="red"
	blackmage
		name="Black mage"
		icon='mob/npc/blackmage.dmi'
	boy_purple
		name="Boy"
		icon='mob/npc/boy.dmi'
		icon_state="purple"
	boy_blue
		name="Boy"
		icon='mob/npc/boy.dmi'
		icon_state="blue"
	boy_red
		name="Boy"
		icon='mob/npc/boy.dmi'
		icon_state="red"
	dancer_purple
		name="Dancer"
		icon='mob/npc/dancer.dmi'
		icon_state="purple"
	dancer_blue
		name="Dancer"
		icon='mob/npc/dancer.dmi'
		icon_state="blue"
	dancer_red
		name="Dancer"
		icon='mob/npc/dancer.dmi'
		icon_state="red"
	dancer_nude
		name="Dancer"
		icon='mob/npc/dancer.dmi'
		icon_state="nude"
	dwarf_purple
		name="Dwarf"
		icon='mob/npc/dwarf.dmi'
		icon_state="purple"
	dwarf_blue
		name="Dwarf"
		icon='mob/npc/dwarf.dmi'
		icon_state="blue"
	dwarf_red
		name="Dwarf"
		icon='mob/npc/dwarf.dmi'
		icon_state="red"
	elder
		name="Town Elder"
		icon='mob/npc/oldman.dmi'
		icon_state="elder"
	engineer
		name="Engineer"
		icon='mob/npc/engineer.dmi'
	girl_purple
		name="Girl"
		icon='mob/npc/girl.dmi'
		icon_state="purple"
	girl_blue
		name="Girl"
		icon='mob/npc/girl.dmi'
		icon_state="blue"
	girl_red
		name="Girl"
		icon='mob/npc/girl.dmi'
		icon_state="red"
	karateman_purple
		name="Karate man"
		icon='mob/npc/karateman.dmi'
		icon_state="purple"
	karateman_blue
		name="Karate man"
		icon='mob/npc/karateman.dmi'
		icon_state="blue"
	king_blue
		name="King"
		icon='mob/npc/king.dmi'
		icon_state="blue"
	king_red
		name="King"
		icon='mob/npc/king.dmi'
		icon_state="red"
	king_dwarf
		name="Giott"
		icon='mob/npc/king.dmi'
		icon_state="dwarf"
	guard_blue
		name="Guard"
		icon='mob/npc/guard.dmi'
		icon_state="blue"
	guard_red
		name="Guard"
		icon='mob/npc/guard.dmi'
		icon_state="red"
	man_purple
		name="Peasant"
		icon='mob/npc/man.dmi'
		icon_state="purple"
	man_blue
		name="Peasant"
		icon='mob/npc/man.dmi'
		icon_state="blue"
	man_red
		name="Peasant"
		icon='mob/npc/man.dmi'
		icon_state="red"
	midget_red
		name="Midget"
		icon='mob/npc/midget.dmi'
		icon_state="red"
	midget_blue
		name="Midget"
		icon='mob/npc/midget.dmi'
		icon_state="blue"
	namingway
		name="Namingway"
		icon='mob/npc/namingway.dmi'
	oldman_purple
		name="Oldman"
		icon='mob/npc/oldman.dmi'
		icon_state="purple"
	oldman_blue
		name="Oldman"
		icon='mob/npc/oldman.dmi'
		icon_state="blue"
	oldman_red
		name="Oldman"
		icon='mob/npc/oldman.dmi'
		icon_state="red"
	oldwoman_purple
		name="Oldwoman"
		icon='mob/npc/oldwoman.dmi'
		icon_state="purple"
	oldwoman_blue
		name="Oldwoman"
		icon='mob/npc/oldwoman.dmi'
		icon_state="blue"
	oldwoman_red
		name="Oldwoman"
		icon='mob/npc/oldwoman.dmi'
		icon_state="red"
	pbomb
		name="Summon"
		icon='mob/npc/pbomb.dmi'
	princess
		name="Princess"
		icon='mob/npc/princess.dmi'
	scholar_blue
		name="Scholar"
		icon='mob/npc/scholar.dmi'
		icon_state="blue"
	scholar_red
		name="Scholar"
		icon='mob/npc/scholar.dmi'
		icon_state="red"
	soldat_blue
		name="Soldat"
		icon='mob/npc/soldat.dmi'
		icon_state="blue"
	soldat_red
		name="Soldat"
		icon='mob/npc/soldat.dmi'
		icon_state="red"
	sylph
		name="Sylph"
		icon='mob/npc/sylph.dmi'
	wall_paper
		name="Notice"
		icon='mob/npc/stuff.dmi'
		icon_state="wall_paper"
	whitemage
		name="White mage"
		icon='mob/npc/whitemage.dmi'
	woman_purple
		name="Woman"
		icon='mob/npc/woman.dmi'
		icon_state="purple"
	woman_blue
		name="Woman"
		icon='mob/npc/woman.dmi'
		icon_state="blue"
	woman_red
		name="Woman"
		icon='mob/npc/woman.dmi'
		icon_state="red"

obj/NPC
	dress
		name="Dancer's dress"
		icon='mob/npc/dancer.dmi'
		icon_state="dress"

obj/NPC/Special
	icon='mob/npc/special.dmi'
	Kain
		name="Kain"
		icon_state="kain"
	Rosa
		name="Rosa"
		icon_state="rosa"
	DW4_Hero
		name="Hero"
		icon_state="dw4hero"
	Dark_Elf
		name="Dark Elf"
		icon_state="darkelf"
	Milon
		name="Milon"
		icon_state="milon"
	Barbari
		name="Barbari"
		icon_state="barbari"
	Zemus
		name="Zemus"
		icon_state="zemus"
	Zemus_dead
		name="Zemus"
		icon_state="zemus_dead"
	Archimus
		name="Archimus"
		icon_state="zeromus"

obj/NPC/Class
	icon='mob/npc/classboss.dmi'
	Ixia
		name="Ixia"
		icon_state="ixia"
	Loud
		name="Loud"
		icon_state="loud"
	Roogle
		name="Roogle"
		icon_state="roogle"
	Rooki
		name="Rooki"
		icon_state="rooki"
	Sonder
		name="Sonder"
		icon_state="sonder"
	Shadow
		name="Shadow"
		icon_state="shadow"
	Saber
		name="Saber"
		icon_state="saber"
	DQueen
		name="Darkness Queen"
		icon_state="dqueen"
	Chu
		name="Chuy :o"
		icon_state="chu"
	Sanyu
		name="Sanyu"
		icon_state="sanyu"

obj/NPC/ARanger
	icon='mob/npc/admin.dmi'
	Frank
		name="Frank"
		icon_state="frank"
	Rog
		name="Rog"
		icon_state="rog"
	Ren
		name="Ren"
		icon_state="ren"
	Texter
		name="Texter"
		icon_state="texter"

/obj/NPC/Rogabo
	RB_ul
	RB_ur
	RB_bl
	RB_br

obj/NPC/misc/statue/nadrew


obj/NPC/DevRoom
	icon='mob/npc/admin.dmi'
	Frank
		name="Frank"
		icon_state="frank"
	Rog
		name="Rog"
		icon_state="rog"
	Ren
		name="Ren"
		icon_state="ren"
	Texter
		name="Texter"
		icon_state="texter"
	HolyKnight
		name="Holy Knight"
		icon_state="hk"
	Loud
		name="Loud"
		icon_state="loud"
	Elias
		name="Elias"
		icon_state="elias"
	Benjamin
		name="Benjamin"
		icon_state="benjamin"
	Benjamin2
		name="Benjamin"
		icon_state="benjamin2"
	Paige
		name="Paige"
		icon_state="paige"
	Shinkinrui
		name="Shinkinrui"
		icon_state="shink"
	Nielz
		name="Nielz"
		icon_state="nielz"
	Maru
		name="Maru"
		icon_state="maru"
	NobuoUematsu
		name="Nobuo Uematsu"
		icon_state="nobuo"
	Tifa
		name="Tifa"
		icon_state="tifa"
	Merrith
		name="Merrith"
		icon_state="merrith"
	Saber
		name="Saber"
		icon_state="saber"
	Lord_Seph
		name="Justin"
		icon_state="justin"

obj/NPC/Leviathan
	icon='mob/npc/leviathan.dmi'
	head/icon_state="head"
	neck/icon_state="neck"
	wing/icon_state="wing"
	tail/icon_state="tail"

obj/NPC/misc/statue
	icon='obj/statue.dmi'
	pixel_y=18
	layer=MOB_LAYER+1
	loud/icon_state="loud"
	Asguard/icon_state="Asguard"
	KnightRen/icon_state="KnightRen"
	dark_knight/icon_state="dark knight"
	paladin/icon_state="paladin"
	white_mage/icon_state="white mage"
	young_caller/icon_state="young caller"
	mature_caller/icon_state="mature caller"
	ninja/icon_state="ninja"
	dragoon/icon_state="dragoon"
	sage/icon_state="sage"
	engineer/icon_state="engineer"
	monk/icon_state="monk"
	bard/icon_state="bard"
	lunarian/icon_state="lunarian"
	black_twin/icon_state="black twin"
	white_twin/icon_state="white twin"
	bard_harp/icon_state="bard_harp"
	frank/icon_state="frank"
	shinkinrui/icon_state="shink"

obj/NPC/treasure
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

// vehicule obj
obj/NPC/vehicule
	chocobo_yellow
		name="Chocobo"
		icon='mob/vehicule/y_choco.dmi'
		icon_state="normal"
	chocobo_white
		name="White Chocobo"
		icon='mob/vehicule/w_choco.dmi'
		icon_state="normal"
	chocobo_black
		name="Black Chocobo"
		icon='mob/vehicule/b_choco.dmi'
		icon_state="normal"
	airship
		name="Enterprise"
		icon='mob/vehicule/airship.dmi'
		icon_state="normal"
		pixel_y=0
	bigwhale
		var/dest_x
		var/dest_y
		var/dest_z
		var/music
		var/direction
		name="Big Whale"
		icon='mob/vehicule/bigwhale.dmi'
		icon_state="bigwhale_s"
		density=0
		pixel_y=0
		bigwhale_sw{icon_state="bigwhale_sw";pixel_x=-32;New()}
		bigwhale_se{icon_state="bigwhale_se";pixel_x=32;New()}
		bigwhale_w{icon_state="bigwhale_w";layer=MOB_LAYER+1;pixel_x=-32;pixel_y=32;New()}
		bigwhale_c{icon_state="bigwhale_c";layer=MOB_LAYER+1;pixel_y=32;New()}
		bigwhale_e{icon_state="bigwhale_e";layer=MOB_LAYER+1;pixel_x=32;pixel_y=32;New()}
		bigwhale_nw{icon_state="bigwhale_nw";layer=MOB_LAYER+1;pixel_x=-32;pixel_y=64;New()}
		bigwhale_n{icon_state="bigwhale_n";layer=MOB_LAYER+1;pixel_y=64;New()}
		bigwhale_ne{icon_state="bigwhale_ne";layer=MOB_LAYER+1;pixel_x=32;pixel_y=64;New()}

		New()
			overlays+=new/obj/NPC/vehicule/bigwhale/bigwhale_sw
			overlays+=new/obj/NPC/vehicule/bigwhale/bigwhale_se
			overlays+=new/obj/NPC/vehicule/bigwhale/bigwhale_w
			overlays+=new/obj/NPC/vehicule/bigwhale/bigwhale_c
			overlays+=new/obj/NPC/vehicule/bigwhale/bigwhale_e
			overlays+=new/obj/NPC/vehicule/bigwhale/bigwhale_nw
			overlays+=new/obj/NPC/vehicule/bigwhale/bigwhale_n
			overlays+=new/obj/NPC/vehicule/bigwhale/bigwhale_ne
			..()