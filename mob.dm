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
		if(fexists("aotd.txt")) usr<<file2text("motd.txt")
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