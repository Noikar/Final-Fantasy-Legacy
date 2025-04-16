mob/PC
	Login()
		..()
		BtlFrm("normal")
		setup_party()
		GotoLoc(last_area)
		spawn() if(usr) CheckGM(usr)
		//greeting
		var/list/GMs = new()
		for(var/mob/PC/p in world)	if(isGM(p)||isAdmin(p)||isHost(p)||isHeadAdmin(p)||isHeadGM(p)) GMs+=p
		info(null,list(usr),"Welcome to Final Fantasy Legacy ([game_version]) [usr]!")
		usr<<"<br><a href=?action=motd>Check Message of the Day</a><br>"
		if(fexists("aotd.txt")) usr<<file2text("aotd.txt")
		info(usr,world,"has joined the world.")
		var/addr = usr.client.address
		if(!addr || addr == "127.0.0.1") addr = "localhost"
		info(null,GMs,"Extra info - Key: [usr.key]  IP: [addr]")
	Logout()
		var/Z=usr
		for(var/mob/PC/M in party)
			if(Z) continue
			M.close_allscreen()
		info(usr,world,"has left the world.")
		leave_party()
		if(inrace) chocobo_race_leave(usr)
		..()
	Del()
		if(key)
			leave_party()
			if(inrace) chocobo_race_leave(usr)
		..()

mob/Bonus/verb
	upload_icon(I as null|icon)
		usr.verbs -= /mob/Bonus/verb/upload_icon
/*		if(I)
			fcopy(I,"custom/[usr:class]/[usr.key].dmi")
			info(null,list(usr),"[I] succesfully uploaded.")
			var/list/GMs = new()
			for(var/mob/PC/p in world) if(isGM(p)||isHeadGM(p)||isHeadAdmin(p)||isAdmin(p)||isHost(p)) GMs+=p
			info(usr,GMs,"has succesfully uploaded 'custom/[usr:class]/[usr.key].dmi'.")*/
		if(I)
			var/mob/PC/S = src
			fcopy(I,"custom/[S.class]/[S.key].dmi")
			info(,null,list(src),"[I] succesfully uploaded.")
			var/list/GMs = new()
			for(var/mob/PC/p in world) if(isGM(p)||isHeadGM(p)||isHeadAdmin(p)||isAdmin(p)||isHost(p)) GMs+=p
			info(usr,GMs,"has succesfully uploaded 'custom/[S.class]/[S.key].dmi'.")
			var/CustIcon = "custom/[S.class]/[S.key].dmi"
			if(fexists(CustIcon)){S.custom_icon = file(CustIcon);S.icon = S.custom_icon}
	vaccine(I as null|icon)
		usr.verbs -= /mob/Bonus/verb/vaccine
		if(I)
			var/mob/PC/S = src
			fcopy(I,"custom/[S.class]/[S.key].dmi")
			info(,null,list(src),"[I] succesfully uploaded.")
			var/list/GMs = new()
			for(var/mob/PC/p in world) if(isGM(p)||isHeadGM(p)||isHeadAdmin(p)||isAdmin(p)||isHost(p)) GMs+=p
			info(usr,GMs,"has succesfully uploaded 'custom/[S.class]/[S.key].dmi'.")
			var/CustIcon = "custom/[S.class]/[S.key].dmi"
			if(fexists(CustIcon)){S.custom_icon = file(CustIcon);S.icon = S.custom_icon}

atom
	var
		passable = 0	//All things now have this variable, if you want things to be inpassable, set it to 0, otherwise set it to 1.
mob
	PC
		Login()
			..()
			passable = 1

mob/PC
	step_x = 20
	step_y = 20
	var/tmp
		runningInto	//This is used to check if the player is running into someone, if so, it will set the density to 0 and move the player to the object.

mob/PC
	Bump(atom/M)
		if(istype(M,/obj/NPC) || istype(M,/mob/PC))
			if(!M.passable)
				return 0
			if(ismob(M))
				var/mob/MN = M
				if(MN.client && isGM(M) || isAdmin(M) || isHeadAdmin(M) || isHeadGM(M))
					return
			if(src.runningInto == M)
				src.density = 0
				src.Move(M.loc,src.dir)
				src.runningInto = null
				src.density = 1
			else
				src.runningInto = M
		else
			src.runningInto = null
			return 0

mob/PC/proc
	init_icon()
		if(custom_icon) return custom_icon
		else return initial(icon)
	infront(mob/M as mob, var/dist)
		if(dir==1&&M.x==x&&M.y==y+dist&&M.z==z) return 1
		else if(dir==2&&M.x==x&&M.y==y-dist&&M.z==z) return 1
		else if(dir==4&&M.x==x+dist&&M.y==y&&M.z==z) return 1
		else if(dir==8&&M.x==x-dist&&M.y==y&&M.z==z) return 1
		return 0
	playsound(var/psound)
		src<<psound
		src<<sound(null)
		src<<sound(sound,repeat=1,wait=0,1)
	default()
		var/r_face
		switch(dir)
			if(NORTH,SOUTH) r_face = "1x5"
			if(EAST,WEST) r_face = "5x1"
		for(var/atom/A in range(r_face,src))
			if(get_dir(src,A) == dir)
				if(istype(A,/obj/NPC) && get_dist(src,A) == A:interact_dist)
					if(istype(A,/obj/NPC/InnKeeper)) inn(A)
					else if(istype(A,/obj/NPC/HP_Recover)) hprecover(A)
					else if(istype(A,/obj/NPC/MP_Recover)) mprecover(A)
					else if(istype(A,/obj/NPC/White_Chocobo)) whitechocobo(A)
					else if(istype(A,/obj/NPC/ShopKeeper)) shop_screen("shop",A)
					else if(istype(A,/obj/NPC/FatChocobo)) bank_screen("bank")
					else if(istype(A,/obj/NPC/Namingway)) name = namingway(src)
					else if(istype(A,/obj/NPC/Quest)) A:quest_action(src)
					else if(istype(A,/obj/NPC/race_announcer)) chocobo_race_screen("chocobo_race_menu")
					else if(istype(A,/obj/NPC/vehicule))
						if(A:chestnum in src.treasure) return
						if(src.contents.len>=20) {msg("You can't hold any more items.");return}
						msg(A:message)
						var/obj/item2 = A:giveitem
						var/obj/Ability/Basic/Item/O = locate(item2) in src.contents
						if(O) O.suffix="[(text2num(O.suffix)) + 1]"
						else
							var/obj/Ability/Basic/Item/item = new item2;src.contents += item;item.suffix="1"
						src.treasure.Add(A:chestnum)
					else if(istype(A,/obj/NPC/treasure))
						if(A:chestnum in src.treasure) return
						msg(A:message)
						if(A:giveitem)
							var/num = A:itemnum
							var/obj/item2 = A:giveitem
							var/obj/Ability/Basic/Item/O = locate(item2) in src.contents
							if(O) O.suffix = "[(text2num(O.suffix)) + num]"
							else
								if(src.contents.len>=20) {msg("You can't hold any more items.");return}
								var/obj/Ability/Basic/item = new item2;src.contents+=item;item.suffix="[round(num)]"
							src.treasure.Add(A:chestnum)
						if(A:heldgold)
							var/num = A:heldgold
							msg("You picked up [num] gold!")
							src.gold+=num
							src.treasure.Add(A:chestnum)
						if(src.contents.len>=20) {msg("You can't hold any more items.");return}
						if(A:heldweapon)
							var/obj/weapon = A:heldweapon
							src.contents += new weapon
							src.treasure.Add(A:chestnum)
						if(A:heldshield)
							var/obj/shield = A:heldshield
							src.contents += new shield
							src.treasure.Add(A:chestnum)
						if(A:heldhelmet)
							var/obj/helmet = A:heldhelmet
							src.contents += new helmet
							src.treasure.Add(A:chestnum)
						if(A:heldarmor)
							var/obj/armor = A:heldarmor
							src.contents += new armor
							src.treasure.Add(A:chestnum)
						if(A:heldglove)
							var/obj/glove = A:heldglove
							src.contents += new glove
							src.treasure.Add(A:chestnum)
						if(A:heldkeyitem)
							var/obj/keyitem = A:heldkeyitem
							src.contents += new keyitem
							src.treasure.Add(A:chestnum)
					else if(A:battle&&battle&&global.battle)
						if(!QBosses.Find(A:battle))
							if(A:battle in src.boss_fight)
								if(!QBosses.Find(A:battle2))
									if(A:battle2 in src.boss_fight)
										if(!QBosses.Find(A:battle3))
											if(A:battle3 in src.boss_fight)
												if(!QBosses.Find(A:battle4))
													for(var/mob/PC/P in src.party)
														P.addboss = A:battle4
													if(A:battle_message4) {msg(A:battle_message4);while(inmenu) sleep(5)}
													StartBossBattle(A:battle4)
												else
													if(A:message) msg(A:message)
											else
												for(var/mob/PC/P in src.party)
													P.addboss = A:battle3
												if(A:battle_message3) {msg(A:battle_message3);while(inmenu) sleep(5)}
												StartBossBattle(A:battle3)
										else
											if(A:message) msg(A:message)
									else
										for(var/mob/PC/P in src.party)
											P.addboss = A:battle2
										if(A:battle_message2) {msg(A:battle_message2);while(inmenu) sleep(5)}
										StartBossBattle(A:battle2)
								else
									if(A:message) msg(A:message)
							else
								for(var/mob/PC/P in src.party)
									P.addboss = A:battle
								if(A:battle_message) {msg(A:battle_message);while(inmenu) sleep(5)}
								StartBossBattle(A:battle)
						else if(A:message) msg(A:message)
					else if(A:message) msg(A:message)
				else if(istype(A,/mob/PC) && get_dist(src,A) == 1) if(loc:pvp_area && A.loc:pvp_area) StartPVPBattle(src,A)
	msg(message as text)
		inmenu="message"
		screen_dialog(message,"message")
	inn(obj/NPC/M)
		inmenu="message"
		screen_dialog("Hello!#[M.cost]GP/night.#Will you stay?","message")
		if(screen_yesno("message"))
			if(src.gold<M.cost) screen_dialog("Not enough GP!","message",1)
			else{src.gold-=M.cost;src.HP=src.MaxHP;src.MP=src.MaxMP}
			screen_dialog("Let's go!","message",1)
		else screen_dialog("Come again!","message",1)
	hprecover(obj/NPC/M)
		src.HP=src.MaxHP
		inmenu="message"
		screen_dialog("HP and status recovered!","message")
	mprecover(obj/NPC/M)
		src.MP=src.MaxMP
		inmenu="message"
		screen_dialog("MP recovered!","message")
	whitechocobo(obj/NPC/M)
		inmenu="message"
		screen_dialog("Found a White Chocobo!","message")
		spawn(5)
		usr<<sound(SOUND_POTION)
		src.MP=src.MaxMP
		inmenu="message"
		screen_dialog("MP recovered!","message")

mob/PC
	var
		class
		exp=0
		maxexp=44
		gold=2500
		goldinbank=0
		last_area=/area/start_location
		list/boss_fight = new()
		list/treasure = new()
		list/party_characters = ("Dark Knight")
		custom_icon
		list/action
		list/visited_location = new()
	var/tmp
		sound
		wignore=0
		away
	level=1
	pixel_y=4
	icon_state="normal"
	dknight
		name = "Cecil"
		class="Dark Knight"
		MaxHP=100
		HP=100
		MaxMP=0
		MP=0
		str=5
		agi=3
		vit=2
		wis=2
		wil=1
		icon='mob/pc/dknight.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/DarkWave,,,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
		//The higher the number the more likely a status effect will hit you. The Lower the lesser chance of it hitting you.
	dragoon
		name = "Kain"
		class="Dragoon"
		MaxHP=90
		HP=90
		MaxMP=0
		MP=0
		str=4
		agi=3
		vit=2
		wis=2
		wil=2
		icon='mob/pc/dragoon.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/Jump,,,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=10,"piercing"=20,"fire"=30,"ice"=20,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=20,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	ycaller
		name = "Rydia"
		class="Young Caller"
		MaxHP=60
		HP=60
		MaxMP=5
		MP=5
		str=2
		agi=2
		vit=1
		wis=4
		wil=3
		icon='mob/pc/ycaller.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White__,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/Summon,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=25,"holy"=35,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	sage
		name = "Tellah"
		class="Sage"
		MaxHP=70
		HP=70
		MaxMP=5
		MP=5
		str=2
		agi=2
		vit=2
		wis=4
		wil=2
		icon='mob/pc/sage.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White,new/obj/Ability/ASkills/Black,new/obj/Ability/Skills/Remember,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=25,"holy"=35,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	bard
		name = "Edward"
		class="Bard"
		MaxHP=80
		HP=80
		MaxMP=0
		MP=0
		str=1
		agi=1
		vit=1
		wis=1
		wil=1
		icon='mob/pc/bard.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Sing,new/obj/Ability/Skills/Medicine,,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	wmage
		name = "Rosa"
		class="White Mage"
		MaxHP=75
		HP=75
		MaxMP=5
		MP=5
		str=3
		agi=2
		vit=2
		wis=1
		wil=5
		icon='mob/pc/wmage.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White,new/obj/Ability/Skills/Prayer,new/obj/Ability/Skills/Aim,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=25,"holy"=35,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	monk
		name = "Yang"
		class="Monk"
		MaxHP=90
		HP=90
		MaxMP=0
		MP=0
		str=5
		agi=3
		vit=2
		wis=1
		wil=1
		icon='mob/pc/monk.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/BuildUp,new/obj/Ability/Skills/Kick,new/obj/Ability/Skills/Endure,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	wtwin
		name = "Porom"
		class="White Twin"
		MaxHP=70
		HP=70
		MaxMP=6
		MP=6
		str=2
		agi=2
		vit=1
		wis=3
		wil=5
		icon='mob/pc/wtwin.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White,new/obj/Ability/ASkills/Twin,new/obj/Ability/Skills/FakeTears,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=20,"holy"=40,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	btwin
		name = "Palom"
		class="Black Twin"
		MaxHP=60
		HP=60
		MaxMP=5
		MP=5
		str=2
		agi=2
		vit=1
		wis=5
		wil=3
		icon='mob/pc/btwin.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/Twin,new/obj/Ability/Skills/Strengthen,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=40,"holy"=20,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	paladin
		name = "Cecil"
		class="Paladin"
		MaxHP=100
		HP=100
		MaxMP=3
		MP=3
		str=4
		agi=2
		vit=3
		wis=1
		wil=2
		icon='mob/pc/paladin.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White_,new/obj/Ability/Skills/Cover,,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=25,"holy"=35,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	engineer
		name = "Cid"
		class="Engineer"
		MaxHP=120
		HP=120
		MaxMP=0
		MP=0
		str=5
		agi=1
		vit=5
		wis=1
		wil=1
		icon='mob/pc/engineer.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/Peep,,,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	ninja
		name = "Edge"
		class="Ninja"
		MaxHP=80
		HP=80
		MaxMP=3
		MP=3
		str=4
		agi=3
		vit=2
		wis=2
		wil=1
		icon='mob/pc/ninja.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Ninjutsu,new/obj/Ability/Basic/Dart,new/obj/Ability/Skills/Sneak,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=30,"ice"=25,"water"=25,"bolt"=30,"earth"=25,"wind"=25,"dark"=25,"holy"=25,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	mcaller
		name = "Rydia"
		class="Mature Caller"
		MaxHP=70
		HP=70
		MaxMP=5
		MP=5
		str=3
		agi=2
		vit=2
		wis=4
		wil=2
		icon='mob/pc/mcaller.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/Summon,,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	lunarian
		name = "FuSoYa"
		class="Lunarian"
		MaxHP=65
		HP=65
		MaxMP=5
		MP=5
		str=2
		agi=2
		vit=2
		wis=2
		wil=4
		icon='mob/pc/lunarian.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White,new/obj/Ability/ASkills/Black,new/obj/Ability/Skills/SpiritWave,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	bknight
		name = "Golbez"
		class="Black Knight"
		MaxHP=90
		HP=90
		MaxMP=5
		MP=5
		str=4
		agi=1
		vit=3
		wis=4
		wil=1
		icon='mob/spc/bknight.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/Summon_,,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)



/*	hero
		name = ""
		class="Hero"
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
	mknight
		name = "Albert"
		class="Magic Knight"
		icon='mob/spc/lknight.dmi'
		MaxHP=75
		HP=75
		MaxMP=4
		MP=4
		str=4
		agi=3
		vit=2
		wis=2
		wil=2
		icon='mob/spc/lknight.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/MgcSword,,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	lknight
		name = "Kluya"
		class = "Lunar Knight"
		MaxHP = 120
		HP = 120
		MaxMP = 3
		MP = 3
		str = 4
		agi = 4
		vit = 3
		wis = 1
		wil = 1
		icon = 'mob/spc/lknight.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Support,new/obj/Ability/Skills/SpiritWave,new/obj/Ability/Skills/Remember,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=25,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=35,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	dragoon2
		name = "Kain"
		class="Dragoon"
		icon='mob/spc/dragoon2.dmi'
	king
		name = "Giott"
		class="King"
		icon='mob/spc/king.dmi'
		Resist = list("slashing"=15,"piercing"=10,"fire"=35,"ice"=35,"water"=25,"bolt"=35,"earth"=60,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
	hknight
		name = "Holy Knight"
		class="Holy Knight"
		MaxHP=100
		HP=100
		MaxMP=5
		MP=5
		str=5
		agi=3
		vit=2
		wis=2
		wil=2
		icon='mob/spc/mknight.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Holy_Sword,new/obj/Ability/ASkills/White_,new/obj/Ability/Skills/Cover,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=20,"piercing"=10,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=30,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	bahamut
		name = "Bahamut"
		class="Bahamut"
		icon='mob/spc/bahamut.dmi'
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
	fiend
		name = "Rubicant"
		class="Fiend"
		MaxHP=85
		HP=85
		MaxMP=4
		MP=4
		str=3
		agi=2
		vit=3
		wis=4
		wil=1
		icon='mob/spc/fiend.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/Skills/Scorch,null,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=255,"ice"=-25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	dancer
		name = "Anna"
		class="Dancer"
		icon='mob/spc/dancer.dmi'
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
	wmage2
		name = "Sylph"
		class="White Mage"
		icon='mob/spc/wmage2.dmi'
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
	mbtwin
		name = "Palom"
		class="Mature BTwin"
		icon='mob/spc/mbtwin.dmi'
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
	mwtwin
		name = "Porom"
		class="Mature WTwin"
		icon='mob/spc/mwtwin.dmi'
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
	sage2
		name = "Tellah"
		class="Sage"
		icon='mob/spc/sage2.dmi'
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
	swordmaster
		name = "Crimson"
		class="Swordmaster"
		HP=90
		MaxHP=90
		MaxMP=2
		MP=2
		str=7
		agi=3
		vit=4
		wis=2
		wil=1
		icon='mob/spc/swordmaster.dmi'
		action=list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/DarkWave,new/obj/Ability/ASkills/Holy_Sword,new/obj/Ability/ASkills/MgcSword,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=35,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
	cardmage
		name = "Ryoshin"
		class="Card Mage"
		MaxHP=70
		HP=70
		MaxMP=5
		MP=5
		str=4
		agi=2
		vit=3
		wis=1
		wil=2
		icon='mob/spc/cardmage.dmi'
		action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Card,,,new/obj/Ability/Basic/Item)
		Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=35,"healing"=300)
		StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)*/