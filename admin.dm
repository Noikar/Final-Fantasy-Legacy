var/const/wr_wait = 300
var/tmp
	rebooting = 0
	shutting_down = 0
	shutdown_time = 0
//### ADMIN CODE
proc
	GMLog(T)
		text2file(T,"GMLog.txt")
	GMSayLog(T)
		text2file(T,"GMSayLog.txt")
	ModSayLog(T)
		text2file(T,"ModSayLog.txt")
	ReportDate()
		var/format = "MM/DD/YYYY"
		return time2text(world.realtime, format)
	WorldSave()
		var/savefile/World = new("saves/world.sav")
		World["GMList"] << GMList
		World["MuteList"] << MuteList
		World["IPMuteList"] << IPMuteList
		World["BanList"] << BanList
		World["IPBanList"] << IPBanList
		World["WCensor"] << WCensor
mob/Host/proc

	Create_Clan()
		set category = "Hst Cmds"
		set desc = "Create a Clan"
		var/list/People[] = list()
		for(var/mob/PC/P in world)
			if(P.clan != "None")
				People -= P
			else
				People["[P]([P.key])"] += P
		var/mob/M = People[input(src,"Who would you like to give a clan to?","Give Clan") in People + list("<Cancel>")]
		if(M == People["<Cancel>"])
			return
		else
			var/clanname = input("What's the name of the clan?","Clan Name") as null
			if(!clanname)return
			var/savefile/F = new("clans/[ckey(clanname)].cln")
			F.cd = ".."
			F.cd = "clan"
			F["leader"] << M.key
			F["clan_name"] << clanname
			F.cd = ".."
			F.cd = "members/[ckey(M.key)]"
			F["name"] << M.key
			F["title"] << "Leader"
			F["rank"] << 4
			F.cd = ".."
			F.cd = "clan"
			M.clan = clanname
			M.title = "Leader"
			M.rank = 4
	ClanCheck()
		set category = "Hst Cmds"
		set desc = "Change the Clan Check"
		var/newCC = input(src,"Clan Check","What would you like to change the Clan Check to?",ClanCheck) as message | null
		if(!isnull(newCC))
			global.ClanCheck = newCC
			fdel("ClanCheck.htm");
			text2file(global.ClanCheck,"ClanCheck.htm");
	Junk()
		set category = "Hst Cmds"
		set desc = "Create junk"
		if(isHost(src))
			var/list/Weapons = list()
			var/list/Shields = list()
			var/list/Helmets = list()
			var/list/Armors = list()
			var/list/Arms = list()
			var/list/Items = list()
			var/list/Stars = list()
			var/list/Key_Items = list()
			var/list/People[] = list()
			for(var/obj in typesof(/obj/weapon))
				Weapons.Add(obj)
			for(var/obj in typesof(/obj/armor))
				Armors.Add(obj)
			for(var/obj in typesof(/obj/helmet))
				Helmets.Add(obj)
			for(var/obj in typesof(/obj/shield))
				Shields.Add(obj)
			for(var/obj in typesof(/obj/arm))
				Arms.Add(obj)
			for(var/obj in typesof(/obj/Ability/Basic/Item))
				Items.Add(obj)
			for(var/obj in typesof(/obj/Ability/Basic/Dart))
				Stars.Add(obj)
			for(var/obj in typesof(/obj/Key_Item))
				Key_Items.Add(obj)
			for(var/mob/PC/P in world)
				People["[P]([P.key])"] += P
			var/create = input("Create which type of item?","Create")as null|anything in list("Weapons","Shields","Helmets","Armors","Arms","Items",,"Stars","Key Items")
			if(!create) return
			if(create == "Weapons")
				var/mob/PC/M = People[input(src,"Who would you like to give a weapon to?","Create Weapon")as null|anything in People]
				if(!M) return
				if(M.contents.len >= 20) {info(M,list(src),"can't hold a new weapon.");return}
				var/give_weapon = input(src,"What weapon would you like to give to [M]?","Create Weapon")as null|anything in Weapons
				if(!give_weapon) return
				M.contents += new give_weapon
				info(src,list(M),"has sexified you with [give_weapon].")
			if(create == "Shields")
				var/mob/PC/M = People[input(src,"Who would you like to give a shield to?","Create Shield")as null|anything in People]
				if(!M) return
				if(M.contents.len >= 20) {info(M,list(src),"can't hold a new shield.");return}
				var/give_shield = input(src,"What shield would you like to give to [M]?","Create Shield")as null|anything in Shields
				if(!give_shield) return
				M.contents += new give_shield
				info(src,list(M),"has sexified you with [give_shield].")
			if(create == "Helmets")
				var/mob/PC/M = People[input(src,"Who would you like to give a helmet to?","Create Helmet")as null|anything in People]
				if(!M) return
				if(M.contents.len >= 20) {info(M,list(src),"can't hold a new helmet.");return}
				var/give_helmet = input(src,"What helmet would you like to give to [M]?","Create Helmet")as null|anything in Helmets
				if(!give_helmet) return
				M.contents += new give_helmet
				info(src,list(M),"has sexified you with [give_helmet].")
			if(create == "Armors")
				var/mob/PC/M = People[input(src,"Who would you like to give an armor to?","Create Armor")as null|anything in People]
				if(!M) return
				if(M.contents.len >= 20) {info(M,list(src),"can't hold a new armor.");return}
				var/give_armor = input(src,"What armor would you like to give to [M]?","Create Armor")as null|anything in Armors
				if(!give_armor) return
				M.contents += new give_armor
				info(src,list(M),"has sexified you with [give_armor].")
			if(create == "Arms")
				var/mob/PC/M = People[input(src,"Who would you like to give an arm to?","Create Arm")as null|anything in People]
				if(!M) return
				if(M.contents.len >= 20) {info(M,list(src),"can't hold a new arm.");return}
				var/give_arm = input(src,"What arm would you like to give to [M]?","Create Arm")as null|anything in Arms
				if(!give_arm) return
				M.contents += new give_arm
				info(src,list(M),"has sexified you with [give_arm].")
			if(create == "Items")
				var/mob/PC/M = People[input(src,"Who would you like to give an item to?","Create Item")as null|anything in People]
				if(!M) return
				var/give_item = input(src,"What item would you like to give to [M]?","Create Item")as null|anything in Items
				if(!give_item) return
				var/num = input(src,"How many of [give_item] would you like to give to [M]?","Create Item")as null|num
				if(!num) return
				if(num>99) num = 99
				if(num<0) return
				var/obj/item = give_item
				var/obj/Ability/Basic/Item/O = locate(item) in M.contents
				if(O) O.suffix="[(text2num(O.suffix)) + num]"
				else
					if(M.contents.len >= 20) {info(M,list(src),"can't hold a new item.");return}
					var/obj/Ability/Basic/Item/item2 = new item;M.contents += item2;item2.suffix="[round(num)]" // New Addition Fix
				info(src,list(M),"has sexified you with [round(num)][give_item].")
			if(create == "Stars")
				var/mob/PC/M = People[input(src,"Who would you like to give an item to?","Create Stars")as null|anything in People]
				if(!M) return
				var/give_star = input(src,"What item would you like to give to [M]?","Create Stars")as null|anything in Stars
				if(!give_star) return
				var/num = input(src,"How many of [give_star] would you like to give to [M]?","Create Star")as null|num
				if(!num) return
				if(num>99) num = 99
				if(num<0) return
				var/obj/star = give_star
				var/obj/Ability/Basic/Dart/O = locate(star) in M.contents
				if(O) O.suffix="[(text2num(O.suffix)) + num]"
				else
					if(M.contents.len >= 20) {info(M,list(src),"can't hold a new item.");return}
					var/obj/Ability/Basic/Dart/star2 = new star;M.contents += star2;star2.suffix="[round(num)]"
				info(src,list(M),"has sexified you with [round(num)][give_star].")
			if(create == "Key Items")
				var/mob/PC/M = People[input(src,"Who would you like to give a key item to?","Create Key Item")as null|anything in People]
				if(!M) return
				if(M.contents.len >= 20) {info(M,list(src),"can't hold a new key item.");return}
				var/give_key_item = input(src,"What key item would you like to give to [M]?","Create Key Item")as null|anything in Key_Items
				if(!give_key_item) return
				M.contents += new give_key_item
				info(src,list(M),"has sexified you with [give_key_item].")
	NoIcon()
		set category = "Hst Cmds"
		set desc="Removes someones icon even if they are offline."
		var/key_name = input("What key do you want to remove custom icons from?")
		if(!fexists("saves/[ckey(copytext(key_name,1,2))]/[ckey(key_name)].sav"))
			src << "That player doesn't exist."
			return
		var/savefile/F = new("saves/[ckey(copytext(key_name,1,2))]/[ckey(key_name)].sav")
		F.cd = "/characters/"
		for(var/C in F.dir)
			F.cd = "[C]/mob/.0"
			if(F["custom_icon"])
				src << "* Removed [F["custom_icon"]]"
				F["custom_icon"] << null
			else
				src << "* No custom icon found under [C]"
			F.cd = "../../.."
		for(var/mob/PC/ch in world)
			if(ch.ckey == ckey(key_name))
				ch << "* Your custom icon was revoked."
				ch.custom_icon = null
				ch.icon = initial(ch.icon)
	Change_icon()
		set category="Hst Cmds"
		set desc="Change someone's icon"
		var/list/PCList = new()
		for(var/mob/PC/p in world) PCList+=p
		var/mob/PC/CustPC = input(src,"Change who's icon?","Custom icon") as null|mob in PCList
		if(!CustPC) return
		switch(alert(src,"Change [CustPC]'s icon to?","Change icon","Set to Custom","Set to Default","Cancel"))
			if("Set to Custom")
				if(!CustPC) return
				var/CustIcon = "custom/[CustPC.class]/[CustPC.key].dmi"
				if(fexists(CustIcon)){CustPC.custom_icon = file(CustIcon);CustPC.icon = CustPC.custom_icon}
				else info(null,list(src),"No custom were found for [CustPC] ([CustPC.key]) with the class [CustPC.class].")
			if("Set to Default") if(CustPC){CustPC.custom_icon = null;CustPC.icon = initial(CustPC.icon)}
	World_Shutdown()
		set category = "Hst Cmds"
		set desc = "Shutdown the world."
		if(!isHeadAdmin(src)){info(,list(src),"Jerk Off.");return}
		if(shutting_down)
			info(,world,"Shutdown cancelled.")
			shutting_down = 0
			shutdown_time = 0
			return
		var/countdown = input("How long until the shutdown?","World Shutdown")as null|num
		if(!countdown) return
		var
			count_dupe
			list/reboot_total_time = list("hours" = 0,"minutes" = 0,"seconds" = 0)
		switch(alert(src,"Are you SURE that you want to do this?","World Shutdown","Yes","No"))
			if("Yes")
				count_dupe = countdown
				while(count_dupe >= 60)
					reboot_total_time["minutes"]++
					if(reboot_total_time["minutes"] >= 60)
						reboot_total_time["hours"]++
						reboot_total_time["minutes"] = 0
					count_dupe -= 60
				if(count_dupe)
					reboot_total_time["seconds"] += count_dupe
				info(,world,"World is shutting down in [reboot_total_time["hours"]] hour\s, [reboot_total_time["minutes"]] minute\s, and [reboot_total_time["seconds"]] second\s.")
				shutting_down = 1
				GMLog("[ReportDate()] [src] ([src.key]) shutdown the server.")
				while(shutting_down && countdown)
					sleep(10)
					countdown--
					if(countdown == 10)
						info(,world,"World is shutting down in 10 seconds.")
					if(countdown == 5)
						info(,world,"World is shutting down in 5 seconds.")
					if(countdown == 4)
						info(,world,"World is shutting down in 4 seconds.")
					if(countdown == 3)
						info(,world,"World is shutting down in 3 seconds.")
					if(countdown == 2)
						info(,world,"World is shutting down in 2 seconds.")
					if(countdown == 1)
						info(,world,"World is shutting down in 1 seconds.")
					if(countdown <= 1)
						shutting_down = 0
						world.Del()
					shutdown_time = countdown
				shutting_down = 0

	Hax(var/mob/PC/O in world)
		set category = "Hst Cmds"
		var/variable = input("Which var?","Var") in O:vars + list("Cancel")
		if(variable == "Cancel")
			return
		var/default
		var/typeof = O:vars[variable]
		if(isnull(typeof))
			default = "Text"
		else if(isnum(typeof))
			default = "Num"
			dir = 1
		else if(istext(typeof))
			default = "Text"
		else if(isloc(typeof))
			default = "Reference"
		else if(isicon(typeof))
			typeof = "\icon[typeof]"
			default = "Icon"
		else if(istype(typeof,/atom) || istype(typeof,/datum))
			default = "Type"
		else if(istype(typeof,/list))
			default = "List"
		else if(istype(typeof,/client))
			default = "Cancel"
		else
			default = "File"
		var/class = input("What kind of variable?","Variable Type",default) in list("Text","Num","Type","Reference","Icon","File","Restore to default","List","Null","Cancel")
		switch(class)
			if("Cancel")
				return
			if("Restore to default")
				O:vars[variable] = initial(O:vars[variable])
			if("Text")
				O:vars[variable] = input("Enter new text:","Text",O:vars[variable]) as text
			if("Num")
				O:vars[variable] = input("Enter new number:","Num",O:vars[variable]) as num
			if("Type")
				O:vars[variable] = input("Enter type:","Type",O:vars[variable]) in typesof(/mob)
			if("Reference")
				O:vars[variable] = input("Select reference:","Reference",O:vars[variable]) as mob in world
			if("File")
				O:vars[variable] = input("Pick file:","File",O:vars[variable]) as file
			if("Icon")
				O:vars[variable] = input("Pick icon:","Icon",O:vars[variable]) as icon
			if("List")
				input("This is what's in [variable]") in O:vars[variable] + list("Close")
			if("Null")
				if(alert("Are you sure you want to clear this variable?","Null","Yes","No") == "Yes")
					O:vars[variable] = null

	File_edit()
		set category = "Hst Cmds"
		set desc = "Edit a document for the world"
		if(!isHeadAdmin(src)){info(,list(src),"Jerk Off.");return}
		var/edit_list = input(src,"Which file would you like to edit?","Edit File")as null|anything in list("FAQ","GMFAQ")
		if(edit_list == "FAQ")
			var/FAQ = file2text("faq.htm")
			var/edit_faq = input(src,"Edit the FAQ.","Edit FAQ",FAQ)as null|message
			if(edit_faq)
				fdel("faq.htm")
				text2file(edit_faq,"faq.htm")
				info(,world,"<a href=?action = faq STYLE=\"text-decoration: none\">FAQ</a> has been changed.")
		if(edit_list == "GMFAQ")
			var/GMFAQ = file2text("gmfaq.htm")
			var/edit_gmfaq = input(src,"Edit the GMFAQ.","Edit GMFAQ",GMFAQ)as null|message
			if(edit_gmfaq)
				fdel("gmfaq.htm")
				text2file(edit_gmfaq,"gmfaq.htm")
				var/list/Staff = list()
				for(var/mob/PC/P in world) if(isHeadAdmin(P) || isAdmin(P) || isHeadGM(P) || isGM(P) || isMod(P)) Staff.Add(P)
				info(,Staff,"<a href=?action = gmfaq STYPE=\"text-decoration: none\">GMFAQ</a> has been changed.")
	World_Lag()
		set category = "Hst Cmds"
		set desc = "Adjust World.tick_lag setting (CPU/Bandwidth usage)"
		if(!isHeadAdmin(src)){info(,list(src),"Jerk Off.");return}
		var/list/PRIORITY[] = new()
		for(var/P in list(HIGH_PRIORITY,NORMAL_PRIORITY,LOW_PRIORITY,VERYLOW_PRIORITY))
			var/priority_name = P
			if(P == DEFAULT_PRIORITY) priority_name = "[priority_name] (DEFAULT)"
			if(P == world.tick_lag) priority_name = "[priority_name] (ACTIVE)"
			PRIORITY["[priority_name]"] = P
		var/new_priority = PRIORITY[input(src,"Select the new priority level","Priority")as null|anything in PRIORITY]
		if(new_priority)
			world.tick_lag = new_priority
	World_Visibility()
		set category = "Hst Cmds"
		set desc = "Toggle the server's visibility from the hub on/off."
		if(!isHeadAdmin(src)){info(,list(src),"Jerk Off.");return}
		var/state = "Shown"
		if(!world.visibility) state = "Not Shown"
		switch(alert(src,"The world is currently [state] on BYOND's hub,toggle?","World Visibility","Yes","No"))
			if("Yes")
				if(world.visibility)
					world.visibility = 0
				else
					world.visibility = 1
			if("No") return
	World_Status()
		set category = "Hst Cmds"
		set desc = "Change the world's status"
		if(!isHeadAdmin(src)){info(,list(src),"Jerk Off.");return}
		var/newstatus = input(src,"Current world.status is: [world.status]","Change World Status",world.status)as null|text
		if(newstatus)
			world.status="[newstatus] (v.[game_version])"
			GMLog("[ReportDate()] [src] ([src.key]) has changed world.status to [newstatus].")
	World_Save()
		set category = "Hst Cmds"
		set desc = "Save the World's config(GM/Mute/Ban/Censor)"
		if(!isHeadAdmin(src) && !isAdmin(src)){info(,list(src),"Jerk Off");return}
		WorldSave()
		info(,list(src),"World's config saved.")

mob/Head_Admin/proc
	Heal()
		set category="GM Cmds"
		set desc="Heal someone (Don't use this without a good reason)"
		if(!isHeadAdmin(src)){info(,list(src),"Jerk off.");return}
		var/list/PCList[] = new()
		for(var/mob/PC/p in world) if(p.client) PCList["[p] ([p.key])"]=p
		var/mob/PC/p = PCList[input(src,"Heal who?","Heal") as null|anything in PCList]
		if(p){info(p,list(src,p),"has been healed.");p.HP=p.MaxHP;p.MP=p.MaxMP}
/*	Create_Key()
		set category="GM Cmds"
		set desc="Create a key to the GM Castle!"
		if(!isAdmin(src)){info(,list(src),"Jerk off.");return}
		var/list/Key = new()
		for(var/mob/PC/p in world) Key+=p
		if(!length(Key)) return
		var/mob/PC/GiveKey = input(src,"Give a key to who?","GM Castle key") as null|anything in Key
		if(!GiveKey) return
		for(var/obj/Key_Item/I in GiveKey.contents) if(I.name == "Castle"){info(,list(src),"has already a key to the GM Castle.");return}
		var/obj/Key_Item/O = new(GiveKey)
		O.name="Castle"
		O.special="GM_Castle"*/
	Clear_Log()
		set category = "GM Cmds"
		set desc = "Clear the GM Log"
		if(!isHeadAdmin(src)){info(,list(src),"Jerk Off.");return}
		if(fexists("GMLog.txt"))
			fdel("GMLog.txt")
			GMLog("[ReportDate()] [src] ([src.key]) has cleared the GM Log.")
			var/list/Staff = list()
			for(var/mob/PC/P in world) if(isHeadAdmin(P) || isAdmin(P) || isHeadGM(P)) Staff.Add(P)
			info(usr,Staff,"has cleared the GM Log.")


mob/Admin/proc
	Big_whale()
		set category="GM Cmds"
		set desc="Summon the Big Whale!"
		if(!isHeadAdmin(src) && !isAdmin(src)){info(,list(src),"Jerk Off");return}
		var/obj/NPC/vehicule/bigwhale/BW = locate(/obj/NPC/vehicule/bigwhale) in range(src)
		if(!BW){info(,list(src),"No big whale nearby to summon.");return}
		for(var/mob/PC/p in range(BW)) p.playsound(MUSIC_BIGWHALE,1,0,1,volume=50)
		for(var/obj/misc/swirl/swirl/s in range(BW)) s.invisibility=0
		spawn(50)
			for(var/obj/misc/swirl/splash/a in range(BW)) a.invisibility=0
			spawn(25)
				for(var/i=0,i<=384,i+=4)
					if(i<=128)
						BW.pixel_y+=4
						if(i==64){BW.y+=2;BW.pixel_y-=64;for(var/obj/misc/swirl/splash/a in range(BW)) a.invisibility=100}
					else if(i>=256)
						BW.pixel_y-=4
						if(i==320){BW.y-=2;BW.pixel_y+=64;for(var/obj/misc/swirl/splash/a in range(BW)) a.invisibility=0}
					else sleep(4)
					sleep(1)
				for(var/obj/misc/swirl/splash/a in range(BW)) a.invisibility=100
				spawn(20) for(var/obj/misc/swirl/swirl/s in range(BW)) s.invisibility=100
	Grant_icon()
		set category="GM Cmds"
		set desc="Allow a player to upload an icon on the server"
		if(!isHeadAdmin(src) && !isAdmin(src)){info(,list(src),"Jerk Off");return}
		var/list/PCList[] = new()
		for(var/mob/PC/p in world) PCList["[p] ([p.key])"] = p
		var/mob/PC/p = PCList[input(src,"Who's gonna be allowed to upload an icon?","Custom icon") as null|anything in PCList]
		if(p)
			p.verbs += /mob/Bonus/verb/upload_icon
			info(null,list(p),"You can now upload a custom icon on the server using the 'icon upload' verb, keep in mind that using this verb might crash DreamSeeker.")
	Spy()
		set category = "GM Cmds"
		set desc = "View another player"
		if(!isHeadAdmin(src) && !isAdmin(src)){info(,list(src),"Jerk Off");return}
		if(src.client.eye != src)
			src.client.eye = src
			src.client.perspective = MOB_PERSPECTIVE
			return
		var/list/PC_List = list()
		for(var/mob/PC/P)
			if(P.client && P != src)
				PC_List.Add("[P.name] ([P.key])")
				PC_List["[P.name] ([P.key])"] = P.ckey
		var/selected_player = input("Who do you want to watch?")in PC_List+"<Cancel>"
		if(selected_player == "<Cancel>")
			return
		for(var/mob/PC/sel)
			if(sel.ckey == PC_List[selected_player])
				info(,list(src),"You are now viewing [sel] to stop viewing use this command again.")
				src.client.eye = sel
				src.client.perspective = EYE_PERSPECTIVE
	EXP()
		set category = "GM Cmds"
		set desc = "Give yourself exp"
		if(!isHeadAdmin(src) && !isAdmin(src)){info(,list(src),"Jerk Off");return}
		if(isHeadAdmin(src))
			var/list/People[] = list()
			for(var/mob/PC/P in world) People["[P] ([P.key])"] += P
			var/mob/PC/M = People[input(src,"Who would you like to give exp to?","Give XP")as null|anything in People]
			if(M)
				var/expnum = input(src,"How much exp to give [M]?","Give XP")as null|num
				if(expnum>99999999) expnum = 99999999
				if(expnum<0) return
				if(M && expnum) {M.exp += expnum;M.level_up()}
		else
			var/mob/PC/M = src
			var/expnum = input(src,"How much exp do you want?","How Much?")as null|num
			if(expnum>99999999) expnum = 99999999
			if(expnum<0) return
			if(expnum)
				M.exp += expnum
				M.level_up()
	Rename()
		set category = "GM Cmds"
		set desc = "Rename someone"
		if(!isHeadAdmin(src) && !isAdmin(src)) {info(,list(src),"Jerk Off");return}
		var/list/People[] = list()
		for(var/mob/PC/P in world) People["[P] ([P.key])"] += P
		var/mob/PC/M = People[input(src,"Who would you like to rename?","Rename")as null|anything in People]
		if(M)
			var/new_name = input(src,"Rename [M] to what?","Rename",M.name)as null|text
			if(new_name)
				switch(alert(src,"Are you sure about renaming [M] to [new_name]?","Rename","Yes","No"))
					if("Yes")
						if(M)
							M.name = new_name
					if("No")
						return
	Censor()
		set category="GM Cmds"
		set desc="Word Censoring"
		if(!isAdmin(src)&&!isHeadAdmin(src)){info(,list(src),"Jerk off.");return}
		else WordCensor(src)
	WInfo()
		set category = "GM Cmds"
		set desc = "See the server's information"
		if(!isHeadAdmin(src) && !isAdmin(src)) {info(,list(src),"Jerk Off");return}
		info(,list(src),"Server information")
		info(,list(src),"\tAddress\t\t: [world.address]:[world.port] on [world.system_type]",1)
		info(,list(src),"\tCPU Usage\t: [world.cpu]",1)
		info(,list(src),"\tUptime\t\t: [duration(world.time)]",1)
		info(,list(src),"\tStatus\t\t: [world.status]",1)
	Reboot()
		set category = "GM Cmds"
		set desc = "Reboot the world"
		if(!isHeadAdmin(src) && !isAdmin(src)){info(,list(src),"Jerk Off");return}
		if(rebooting)
			info(,world,"Reboot Cancelled")
			rebooting = 0
			return
		var/countdown = input(src,"How long until a reboot? (In Seconds, enter -1 to cancel, 0 to reboot now)","Reboot")as null|num
		if(!countdown) return
		var/list/reboot_total_time = list("hours" = 0,"minutes" = 0,"seconds" = 0)
		var/count_duplicate
		if(countdown == -1)
			return
		if(countdown != -1 && countdown<= 0)
			countdown = 1
		switch(alert(src,"Reboot the world?","World Reboot","Yes","No"))
			if("No")
				return
			if("Yes")
				count_duplicate = countdown
				while(count_duplicate >= 60)
					reboot_total_time["minutes"]++
					if(reboot_total_time["minutes"] >= 60)
						reboot_total_time["hours"]++
						reboot_total_time["minutes"] = 0
					count_duplicate -= 60
				if(count_duplicate)
					reboot_total_time["seconds"] += count_duplicate
				info(,world,"World is rebooting in [reboot_total_time["hours"]] hour\s, [reboot_total_time["minutes"]] minute\s, [reboot_total_time["seconds"]] second\s.")
				GMLog("[ReportDate()] [src] ([src.key]) is rebooting the server.")
				rebooting = 1
				while(rebooting && countdown)
					sleep(10)
					countdown --
					if(countdown == 10)
						info(,world,"World is rebooting in 10 seconds.")
					if(countdown == 5)
						info(,world,"World is rebooting in 5 seconds.")
					if(countdown == 4)
						info(,world,"World is rebooting in 4 seconds.")
					if(countdown == 3)
						info(,world,"World is rebooting in 3 seconds.")
					if(countdown == 2)
						info(,world,"World is rebooting in 2 seconds.")
					if(countdown == 1)
						info(,world,"World is rebooting in 1 second.")
					if(countdown <= 1)
						world.Reboot()
				rebooting = 0
	MotD()
		set category = "GM Cmds"
		set desc = "Change the Message of the Day"
		if(!isHeadAdmin(src) && !isAdmin(src)){info(,list(src),"Jerk Off");return}
		var/old_msg = file2text("motd.txt")
		var/new_msg = input(src,"What do you want to change it to?","Change:",old_msg)as null|message
		if(new_msg)
			switch(alert(src,"Are you sure about changing the MotD?","Change MotD?","Yes","No"))
				if("Yes")
					fdel("motd.txt")
					text2file(new_msg,"motd.txt")
					info(,world,"The <a href=?action=motd>Message of the Day</a> has been changed.")
					GMLog("[ReportDate()] [src] ([src.key]) changed the MotD.")
				if("No")
					return

mob/Head_GM/proc
	Staff_Management()
		set category = "GM Cmds"
		set desc = "Make changes to the staff!"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src)){info(,list(src),"Jerk Off");return}
		switch(alert(src,"Which would you like to do?","Add/Remove","Add","Remove","Cancel"))
			if("Cancel")
				return
			if("Add")
				switch(alert(src,"Add by which method?","Add Staff","Player","Key","Cancel"))
					if("Cancel")
						return
					if("Key")
						var/newstaff = input(src,"Enter the exact key of the new staff member.","Add Staff")as null|text
						var/Assign
						if(newstaff)
							if(isHeadAdmin(src))
								switch(alert(src,"Assign [newstaff] to which position?","Add Staff","Admin","GM","Mod"))
									if("Admin")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "Admin"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
									if("GM")
										switch(alert(src,"What level of GM?","Add Staff","GM","Head GM","Cancel"))
											if("Cancel")
												return
											if("Head GM")
												if(GMList.Find(newstaff)) GMList -= newstaff
												Assign = "Head GM"
												GMList[newstaff] = Assign
												info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
												GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
												WorldSave()
											if("GM")
												if(GMList.Find(newstaff)) GMList -= newstaff
												Assign = "GM"
												GMList[newstaff] = Assign
												info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
												GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
												WorldSave()
									if("Mod")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "Mod"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
							if(isAdmin(src))
								switch(alert(src,"Assign [newstaff] to which position?","Add Staff","GM","Mod","Cancel"))
									if("Cancel")
										return
									if("GM")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "GM"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
									if("Mod")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "Mod"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
							else
								switch(alert(src,"Are you sure?","Confirm","Yes","No"))
									if("Yes")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "Mod"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
									if("No")
										return
					if("Player")
						var/list/People[] = list()
						for(var/mob/PC/P in world) if(!isHeadAdmin(P)||!isAdmin(P)) People["[P] ([P.key])"] += P
						var/mob/PC/M = People[input(src,"Who would you like to add as Staff?","Add Staff")as null|anything in People]
						if(M)
							var/Assign = "Admin"
							var/newstaff = M.key
							if(isHeadAdmin(src))
								switch(alert(src,"Assign [newstaff] to which position?","Add Staff","Admin","GM","Mod"))
									if("Admin")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "Admin"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
									if("GM")
										switch(alert(src,"What level of GM?","Add Staff","GM","Head GM","Cancel"))
											if("Cancel")
												return
											if("Head GM")
												if(GMList.Find(newstaff)) GMList -= newstaff
												Assign = "Head GM"
												GMList[newstaff] = Assign
												info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
												GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
												WorldSave()
											if("GM")
												if(GMList.Find(newstaff)) GMList -= newstaff
												Assign = "GM"
												GMList[newstaff] = Assign
												info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
												GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
												WorldSave()
									if("Mod")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "Mod"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
							if(isAdmin(src))
								switch(alert(src,"Assign [newstaff] to which position?","Add Staff","GM","Mod","Cancel"))
									if("Cancel")
										return
									if("GM")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "GM"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
									if("Mod")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "Mod"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
							else
								switch(alert(src,"Are you sure?","Confirm","Yes","No"))
									if("Yes")
										if(GMList.Find(newstaff)) GMList -= newstaff
										Assign = "Mod"
										GMList[newstaff] = Assign
										info(,list(src),"<B>[newstaff]</b> has been assigned <b>[Assign]</b>.")
										GMLog("[ReportDate()] [src] ([src.key]) added [newstaff] as [Assign].")
										WorldSave()
									if("No")
										return
			if("Remove")
				if(isHeadAdmin(src))
					var/list/Removal[] = list()
					for(var/M in GMList) if(GMList[M] == "Admin"||GMList[M] == "Head GM"||GMList[M] == "GM"||GMList[M] == "Mod") Removal["[M] - [GMList[M]]"] += M
					if(!Removal.len){info(,list(src),"No Staff to remove.");return}
					var/RemStaff = Removal[input(src,"Remove who?","Remove")as null|anything in Removal]
					if(RemStaff)
						switch(alert(src,"Are you sure?","Confirm","Yes","No"))
							if("Yes")
								info(,list(src),"<b>[RemStaff]</b> has been removed from being <b>[GMList[RemStaff]]</b>.")
								GMLog("[ReportDate()] [src] ([src.key]) removed [RemStaff] from being [GMList[RemStaff]]")
								GMList -= RemStaff
								WorldSave()
							if("No")
								return
				if(isAdmin(src))
					var/list/Removal[] = list()
					for(var/M in GMList) if(GMList[M] == "GM"||GMList[M] == "Mod") Removal["[M] - [GMList[M]]"] += M
					if(!Removal.len){info(,list(src),"No Staff to remove.");return}
					var/RemStaff = Removal[input(src,"Remove who?","Remove")as null|anything in Removal]
					if(RemStaff)
						switch(alert(src,"Are you sure?","Confirm","Yes","No"))
							if("Yes")
								info(,list(src),"<b>[RemStaff]</b> has been removed from being <b>[GMList[RemStaff]]</b>.")
								GMLog("[ReportDate()] [src] ([src.key]) removed [RemStaff] from being [GMList[RemStaff]]")
								GMList -= RemStaff
								WorldSave()
							if("No")
								return
				else
					var/list/Removal[] = list()
					for(var/M in GMList) if(GMList[M] == "Mod") Removal["[M] - [GMList[M]]"] += M
					if(!Removal.len){info(,list(src),"No Staff to remove.");return}
					var/RemStaff = Removal[input(src,"Remove who?","Remove")as null|anything in Removal]
					if(RemStaff)
						switch(alert(src,"Are you sure?","Confirm","Yes","No"))
							if("Yes")
								info(,list(src),"<b>[RemStaff]</b> has been removed from being <b>[GMList[RemStaff]]</b>.")
								GMLog("[ReportDate()] [src] ([src.key]) removed [RemStaff] from being [GMList[RemStaff]]")
								GMList -= RemStaff
								WorldSave()
							if("No")
								return
	Equipment()
		set category="GM Cmds"
		set desc="Create special equipment!"
		if(!isAdmin(src)&&!isHeadAdmin(src)&&!isHeadGM(src)){info(,list(src),"Jerk off.");return}
		if(isAdmin(src)||isHeadAdmin(src))
			switch(alert(src,"Create what type?","Equipment","GM","Admin","Cancel"))
				if("Cancel")
					return
				if("GM")
					if(src.contents.len >= 16){info(,list(src),"You don't have enough room in your inventory.");return}
					contents+=new /obj/weapon/Sword/Judgement
					contents+=new /obj/shield/Judgement
					contents+=new /obj/helmet/Judgement
					contents+=new /obj/armor/Armor/Judgement
					contents+=new /obj/arm/Glove/Judgement
				if("Admin")
					if(src.contents.len >= 16){info(,list(src),"You don't have enough room in your inventory.");return}
					contents+=new /obj/weapon/Sword/Royal
					contents+=new /obj/shield/Tower
					contents+=new /obj/helmet/Crown
					contents+=new /obj/armor/Armor/Mythril
					contents+=new /obj/arm/Glove/Gauntlet
		else
			if(src.contents.len >= 16){info(,list(src),"You don't have enough room in your inventory.");return}
			contents+=new /obj/weapon/Sword/Judgement
			contents+=new /obj/shield/Judgement
			contents+=new /obj/helmet/Judgement
			contents+=new /obj/armor/Armor/Judgement
			contents+=new /obj/arm/Glove/Judgement
	GP()
		set category = "GM Cmds"
		set desc = "Free GP"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src)){info(,list(src),"Jerk Off");return}
		if(isHeadAdmin(src)||isAdmin(src))
			var/list/People[] = list()
			for(var/mob/PC/P in world) People["[P] ([P.key])"] += P
			var/mob/PC/M = People[input(src,"Who would you like to give GP to?","Give GP") as null|anything in People]
			if(M)
				var/gpnum = input(src,"How much GP to give [M]?","Give GP")as null|num
				if(gpnum>9999999) gpnum = 9999999
				if(gpnum<0) return
				if(M && gpnum) M.gold += gpnum
				if(M.gold>GPLimit) M.gold = GPLimit
		else
			var/mob/PC/M = src
			var/gpnum = input(src,"Get how much GP?","Get GP")as null|num
			if(gpnum)
				M.gold += gpnum
			if(M.gold > GPLimit)
				M.gold = GPLimit
	Announce()
		set category = "GM Cmds"
		set desc = "Useful to make an announcent"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src)){info(,list(src),"Jerk Off");return}
		var/announce = input(src,"Announcement:","Announce (html_allowed)")as null|message
		if(announce)
			global.chat = 0
			spawn(announce_wait_time/5)info(,world,"<center>### <b>Announcement</b> ###<br>[announce]<br>~[src.key]</center>")
			spawn(announce_wait_time) global.chat = 1
	Global()
		set category = "GM Cmds"
		set desc = "Toggle world battle on/off"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src)){info(,list(src),"Jerk Off");return}
		switch(alert(src,"Toggle which global function?","Toggle Which?","Chat","Battles","Cancel"))
			if("Cancel")
				return
			if("Battles")
				var/State = "OFF"
				if(global.battle == 1) State = "ON"
				switch(alert(src,"Current Global Battle State: [State]","Toggle Global Battle","Toggle On","Toggle Off","Cancel"))
					if("Cancel") return
					if("Toggle On"){global.battle = 1;info(,world,"Battles are now enabled.");GMLog("[ReportDate()] [src] ([src.key]) has toggled global battle ON.")}
					if("Toggle Off"){global.battle = 0;info(,world,"Battles are now disabled.");GMLog("[ReportDate()] [src] ([src.key]) has toggled global battle OFF.")}
			if("Chat")
				var/State = "OFF"
				if(global.chat == 1) State = "ON"
				switch(alert(src,"Current global chat state: [State]","Toggle Global Chat","Toggle On","Toggle Off","Cancel"))
					if("Cancel") return
					if("Toggle On"){global.chat = 1;info(,world,"Chat is now enabled.");GMLog("[ReportDate()] [src] ([src.key]) has toggled global chat on.")}
					if("Toggle Off"){global.chat = 0;info(,world,"Chat is now disabled.");GMLog("[ReportDate()] [src] ([src.key]) has toggled global chat off.")}
	Staff_Actions()
		set category="GM Cmds"
		set desc="Look at your teams past actions."
		if(!isAdmin(src)&&!isHeadAdmin(src)&&!isGM(src)&&!isHeadGM(src)){info(,list(src),"Jerk off.");return}
		if(fexists("gmlog.txt"))
			src<<browse("<small>[replace_text(file2text("gmlog.txt"),"\n","<br />")]</small>")

mob/GM/proc
	Push()
		set category="GM Cmds"
		set desc="Push someone using the force!"
		if(!isAdmin(src)&&!isHeadAdmin(src)&&!isGM(src)&&!isHeadGM(src)){info(,list(src),"Jerk off.");return}
		for(var/mob/PC/p in get_step(src,src.dir))
			if(!isGM(p)&&!isHeadAdmin(p)&&!isHeadGM(p)&&!isAdmin(p)) step(p,src.dir)
			else info(,list(src),"Get your hands off [p] you pervert.")
	Toggle()
		set category="GM Cmds"
		set desc="Toggle self battles or visibility"
		if(!isAdmin(src)&&!isHeadAdmin(src)&&!isGM(src)&&!isHeadGM(src)){info(,list(src),"Jerk off.");return}
		switch(alert(src,"Toggle which?","Toggle Self","Visibility","Battles","Cancel"))
			if("Cancel")
				return
			if("Visibility")
				var/State = "Visible"
				if(invisibility) State = "Invisible"
				switch(alert(src,"Your currently [State], Toggle?","Toggle Visibility","Yes","No"))
					if("Yes")
						if(invisibility){invisibility=0;density = 1}
						else
							invisibility = 25
							if(isHeadAdmin(src)||isAdmin(src)) density = 0
						var/mob/PC/P = src
						P.BtlFrm("normal")
					if("No") return
			if("Battles")
				var/state="OFF"
				if(src.battle==1) state="ON"
				switch(alert(src,"Current self battle state: [state]","Toggle self battle","Toggle ON","Toggle OFF","Cancel"))
					if("Cancel") return
					if("Toggle ON"){src.battle=1;info(,list(src),"Your battle are now enabled.")}
					if("Toggle OFF"){src.battle=0;info(,list(src),"Your battle are now disabled.")}
	Search()
		set category="GM Cmds"
		set desc="Search for user information by Key/IP"
		if(!isAdmin(src)&&!isHeadAdmin(src)&&!isGM(src)&&!isHeadGM(src)){info(,list(src),"Jerk off.");return}
		var/list/S_IPList = new()
		var/list/S_KeyList = new()
		switch(alert(src,"Search by...","Search","by Key","by IP","Cancel"))
			if("by Key")
				var/Key = input(src,"Enter the Key you want information from","Search by Key") as null|text
				if(!Key) return
				info(null,list(src),"Searching information about [Key];")
				CR_Key.cd = "/[Key]"
				for(var/IP in CR_Key.dir) if(IP != Key)
					S_IPList += IP
					CR_IP.cd = "/[IP]"
					for(var/K in CR_IP.dir) if(K != IP && !S_KeyList.Find(K)) S_KeyList += K
					CR_IP.cd = "/"
				CR_Key.cd = "/"
			if("by IP")
				var/ip_addr = input(src,"Enter the IP you want information from","Search by IP") as null|text
				if(!ip_addr) return
				info(null,list(src),"Searching information about [ip_addr];")
				CR_IP.cd = "/[ip_addr]"
				for(var/Key in CR_IP.dir) if(Key != ip_addr)
					S_KeyList += Key
					CR_Key.cd = "/[Key]"
					for(var/I in CR_Key.dir) if(I != Key && !S_IPList.Find(I)) S_IPList += I
					CR_Key.cd = "/"
				CR_IP.cd = "/"
		if(length(S_KeyList))
			var/S_KeyText
			for(var/T in S_KeyList) S_KeyText += "[T] "
			info(null,list(src),"Known Key(s): [S_KeyText]",1)
		else info(null,list(src),"No other Key could be found.",1)
		if(length(S_IPList))
			var/S_IPText
			for(var/T in S_IPList) S_IPText += "[T] "
			info(null,list(src),"Known IP(s): [S_IPText]",1)
		else info(null,list(src),"Couldnt find any information.",1)
	AWho()
		set category="GM Cmds"
		set desc="Advanced who"
		if(!isAdmin(src)&&!isHeadAdmin(src)&&!isGM(src)&&!isHeadGM(src)){info(,list(src),"Jerk off.");return}
		var/html="<html><body bgcolor=#000000 text=#A0A0DD link=blue vlink=blue alink=blue>"
		html+="<B>Advanced who</B>:"
		html+="<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=1 WIDTH=100%>"
		html+="<TR><TD ALIGN=center WIDTH=25%>Name</TD><TD ALIGN=center WIDTH=25%>Key</TD><TD ALIGN=center WIDTH=20%>IP Address</TD><TD ALIGN=center WIDTH=30%>Idle time</TD></TR>"
		for(var/mob/PC/p in world) if(p.client) html+="<TR><TD ALIGN=center WIDTH=30%>[p]</TD><TD ALIGN=center WIDTH=20%>[p.key]</TD><TD ALIGN=center WIDTH=20%>[p.client.address]</TD><TD ALIGN=center WIDTH=30%>[duration(p.client.inactivity,"HMS")]</TD></TR>"
		html+="</TABLE></HTML>"
		src<<browse(html)
/*	Enable_special_class()
		set category = "GM Cmds"
		set desc = "Enable any bonus class"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		var/s_class = input("Which class?") in list("Dark Knight","Black Knight","Lunarian","Young Caller","Sage")
		var/savefile/F = new("saves/[copytext(src.ckey,1,2)]/[src.ckey].sav")
		F.cd = "/bonus/"
		var/list/allowed_characters = new()
		if(F["characters"]) F["characters"] >> allowed_characters
		if(!allowed_characters.Find(s_class))
			allowed_characters += s_class
			F["characters"] << allowed_characters
		else info(,list(src),"You already have this class unlocked.")*/
mob/Mod/proc
	Ban()
		set category = "GM Cmds"
		set desc = "Ban Someone"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		var/list/People[] = list()
		for(var/mob/PC/P in world) if(!isHeadAdmin(P) || !isAdmin(P) || !isHeadGM(P) || !isGM(P)) People["[P] ([P.key])"] += P
		if(!People.len){info(,list(src),"No one to ban.");return}
		var/mob/PC/M = People[input(src,"Ban who?","Ban")as null|anything in People]
		if(M)
			var/BanKey = M.key
			var/BanIP = M.client.address
			if(BanIP && alert(src,"Optimize IP Ban for [BanIP]?","Ban","Yes","No") == "Yes") BanIP = get_token(BanIP,"1-3",46) + ascii2text(42)
			AddBan(BanKey,BanIP)
			var/reason = input(src,"Why are you banning?","Ban Reason")as null|text
			if(!reason) reason = "No reason supplied."
			GMLog("[ReportDate()] [src] ([src.key]) has banned [BanKey] ([BanIP]) for [reason].")
			if(M){info(M,world,"has left the world.");del(M)}
			ChartList(src)
			WorldSave()
	OBan()
		set category = "GM Cmds"
		set desc = "Ban Someone"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		if(isAdmin(src)||isHeadAdmin(src))
			switch(alert(src,"Ban which?","Ban","Key","IP","Cancel"))
				if("Cancel")
					return
				if("Key")
					var/BanKey = input(src,"Enter the exact key to ban.","Ban Key")as null|text
					if(BanKey && !GMList.Find(BanKey))
						AddBan(BanKey,null)
						var/reason = input(src,"Why are you banning [BanKey]?","Ban Key")as null|text
						if(!reason) reason = "No reason supplied"
						GMLog("[ReportDate()] [src] ([src.key]) has banned [BanKey] for [reason].")
						for(var/mob/PC/P in world) if(P.key == BanKey) {info(P,world,"has left the world.");del(P)}
						ChartList(src)
						WorldSave()
				if("IP")
					var/BanIP = input(src,"Enter the exact IP to ban.","Ban IP")as null|text
					if(BanIP)
						if(!findtextEx(BanIP,ascii2text(42)) && alert(src,"Optimize IP Ban for [BanIP]?","Ban","Yes","No") == "Yes") BanIP = get_token(BanIP,"1-3",46) + ascii2text(42)
						AddBan(null,BanIP)
						var/reason = input(src,"Why are you banning?","Ban IP")as null|text
						if(!reason)
							reason = "No Reason Supplied"
						GMLog("[ReportDate()] [src] ([src.key] has ip-banned [BanIP] for [reason].")
						for(var/mob/PC/P in world) if(P.client.address == BanIP || (get_token(P.client.address,"1-3",46) + ascii2text(42) == BanIP)) {info(P,world,"has left the world.");del(P)}
						WorldSave()
						ChartList(src)
		else
			var/BanKey = input(src,"Enter the exact key to ban.","Ban Key")as null|text
			if(BanKey && !GMList.Find(BanKey))
				AddBan(BanKey,null)
				var/reason = input(src,"Why are you banning [BanKey]?","Ban Key")as null|text
				if(!reason) reason = "No reason supplied"
				GMLog("[ReportDate()] [src] ([src.key]) has banned [BanKey] for [reason].")
				for(var/mob/PC/P in world) if(P.key == BanKey) {info(P,world,"has left the world.");del(P)}
				ChartList(src)
				WorldSave()
	GMSay(msg as text)
		set category = "Social"
		set name = "GMSay"
		set desc = "Send a private message to all GM's online."
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		var/list/GMs = list()
		for(var/mob/PC/P in world)
			if(isHeadAdmin(P) || isAdmin(P) || isHeadGM(P) || isGM(P) || isMod(P))
				GMs.Add(P)
		chat("GMSay",src,GMs,msg)
		GMSayLog("[ReportDate()] [src] ([src.key]):[msg]")
	Teleport()
		set category = "GM Cmds"
		set desc = "Teleport to Someone"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		var/mob/PC/S = src
		if(S.party.len>1){info(,list(src),"You cannot teleport while in a party.");return}
		if(S.inbattle){info(,list(src),"You cannot teleport while in a battle.");return}
		switch(alert(src,"Teleport to a player or an area?","Teleport","Player","Area","Cancel"))
			if("Cancel") return
			if("Player")
				var/list/People[] = list()
				for(var/mob/PC/P in world) if(P != src) People["[P] ([P.key])"] += P
				if(!People.len){info(,list(src),"No one to teleport to.");return}
				var/mob/PC/M = People[input(src,"Teleport to who?","Teleport")as null|anything in People]
				if(!M||M.inbattle||src.inbattle){info(,list(src),"Teleportation failed.");return}
				else {info(,list(src),"Teleporting to [M].");density=0;src.loc = M.loc;density = 1;src.icon_state = M.icon_state;return}
			if("Area")
				var/list/TPLoc = list()
				for(var/area/saved_location/T in world) TPLoc.Add(T)
				if(!TPLoc.len){info(,list(src),"No area to teleport to.");return}
				var/area = input(src,"Teleport where?","Teleport Area")as null|anything in TPLoc
				if(!area||src.inbattle) return
				else {info(,list(src),"Teleporting to [area].");density = 0;loc = area;density = 1;icon_state = "normal";return}
	Chart()
		set category="GM Cmds"
		set desc="Add, edit, view notes. A must use!"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		ChartList(src)
	Unban()
		set category = "GM Cmds"
		set name = "Unban"
		set desc = "Unban someone"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		switch(alert(src,"Unbanning by...","Unban","Key","IP","Cancel"))
			if("Key")
				if(!BanList.len){info(,list(src),"The Ban list is empty.")}
				var/UnbanKey = input(src,"Unban which key?","Unban a Key")as null|anything in BanList
				if(UnbanKey)
					for(var/Key_IP in BanList[UnbanKey]) IPBanList -= Key_IP
					BanList -= UnbanKey
					info(,list(src),"[UnbanKey] has been unbanned.")
					GMLog("[ReportDate()] [src] ([src.key]) unbanned [UnbanKey].")
					WorldSave()
			if("IP")
				if(!length(IPBanList)){info(null,src,"The IP Ban List is empty.");return}
				var/UnbanIP = input(src,"Unban which IP ?","Unban an IP") as null|anything in IPBanList
				if(UnbanIP)
					for(var/IP_Key in IPBanList[UnbanIP]) BanList -= IP_Key
					IPBanList-=UnbanIP
					info(null,src,"[UnbanIP] has been unbanned.")
					GMLog("[ReportDate()] [src] ([src.key]) has unbanned [UnbanIP]")
					WorldSave()
	Summon()
		set category = "GM Cmds"
		set desc = "Summon someone to you."
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		var/list/People[] = list()
		for(var/mob/PC/P in world) if(P != src) People["[P] ([P.key])"] += P
		var/mob/PC/M = People[input(src,"Summon who?","Summon")as null|anything in People]
		if(!M||M.party.len>1||M.inmenu){info(,list(src),"Summoning failed.");return}
		info(,list(src),"Summoning [M].");M.density = 0;M.loc = src.loc;M.density = 1;M.icon_state = src.icon_state;return
	Reports()
		set category = "GM Cmds"
		set desc = "Before logging off, let us know of any actions you've made (mute, ban, kick)"
		if(isHeadAdmin(src)||isAdmin(src))
			SubmitLogList(usr)
		else
			var/S_Type = alert(usr,"Report Log","Submit","Report","Suggestion","Cancel")
			if(S_Type && S_Type != "Cancel")
				var/S_Text = input(usr,"Text for [S_Type].","[S_Type]") as null|message
				if(S_Text) SubmitLogAdd(usr,S_Type,S_Text)
	Kick()
		set category = "GM Cmds"
		set desc = "Kick someone out"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		var/list/People[] = list()
		for(var/mob/PC/P in world)
			if(isHeadAdmin(src) || isAdmin(src) || isHeadGM(src) || isGM(src))
				if(!isHeadAdmin(P) || !isAdmin(P) || !isHeadGM(P) || !isGM(P))
					People["[P] ([P.key])"] += P
			if(isMod(src))
				if(!isHeadAdmin(P) || !isAdmin(P) || !isHeadGM(P) || !isGM(P) || !isMod(P))
					People["[P] ([P.key])"] += P
		var/mob/PC/M = People[input(src,"Who would you like to kick?","Kick")as null|anything in People]
		if(M)
			var/reason = input(src,"Why are you kicking [M]?","Kick Reason") as null|text
			if(!reason) reason = "No reason supplied"
			if(M){info(M,world,"has been kicked.([reason]).");GMLog("[ReportDate()] [src] ([src.key]) has kicked [M] for [reason].");M.client.character_save(M.client.last_used_slot);del(M)}
	Mute()
		set category = "GM Cmds"
		set desc = "Mute Someone"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		var/list/People[] = list()
		for(var/mob/PC/P in world)
			if(isHeadAdmin(src) || isAdmin(src) || isHeadGM(src) || isGM(src))
				if(!isHeadAdmin(P) || !isAdmin(P) || !isHeadGM(P) || !isGM(P))
					People["[P] ([P.key])"] += P
			if(isMod(src))
				if(!isHeadAdmin(P) || !isAdmin(P) || !isHeadGM(P) || !isGM(P) || !isMod(P))
					People["[P] ([P.key])"] += P
		var/mob/PC/M = People[input(src,"Who would you like to Mute?","Mute")as null|anything in People]
		if(M)
			var/MuteKey = M.key
			var/MuteIP = M.client.address
			if(MuteIP && alert(src,"Optimize IP Mute for [MuteIP]?","Mute","Yes","No") == "Yes") MuteIP = get_token(MuteIP,"1-3",46) + ascii2text(42)
			AddMute(MuteKey,MuteIP)
			var/reason = input(src,"Why are you muting [MuteKey]?","Mute Reason")as null|text
			if(!reason) reason = "No reason supplied."
			GMLog("[ReportDate()] [src] ([src.key]) has muted [MuteKey] ([MuteIP]) for [reason].")
			if(M) info(M,world,"has been muted.([reason])")
			WorldSave()
	OMute()
		set category = "GM Cmds"
		set desc = "Optional Mute method"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		if(isGM(src)||isHeadGM(src)||isAdmin(src)||isHeadAdmin(src))
			switch(alert(src,"Mute which?","Mute","Key","IP","Cancel"))
				if("Cancel")
					return
				if("Key")
					var/MuteKey = input(src,"Type in the exact key to mute.","Mute Key")as null|text
					if(MuteKey&&!GMList.Find(MuteKey))
						AddMute(MuteKey,null)
						var/reason = input(src,"Why are you muting [MuteKey]?","Mute Key")as null|text
						if(!reason) reason = "No reason supplied."
						GMLog("[ReportDate()] [src] ([src.key]) has muted [MuteKey] for [reason].")
						for(var/mob/PC/P in world) if(P.key == MuteKey) info(P,world,"has been muted.([reason]).")
						WorldSave()
				if("IP")
					var/MuteIP = input(src,"Type in the exact ip to mute.","Mute IP")as null|text
					if(MuteIP)
						if(MuteIP && alert(src,"Optimize IP Mute for [MuteIP]?","Mute","Yes","No") == "Yes") MuteIP = get_token(MuteIP,"1-3",46) + ascii2text(42)
						AddMute(null,MuteIP)
						var/reason = input(src,"Why are you muting [MuteIP]?","Mute IP")as null|text
						if(!reason) reason = "No reason supplied."
						GMLog("[ReportDate()] [src] ([src.key]) has muted [MuteIP] for [reason].")
						for(var/mob/PC/P in world) if(P.client.address == MuteIP || (get_token(P.client.address,"1-3",46) + ascii2text(42) == MuteIP)) info(P,world,"has been muted.([reason])")
						WorldSave()
		else
			var/MuteKey = input(src,"Type in the exact key to mute.","Mute Key")as null|text
			if(MuteKey&&!GMList.Find(MuteKey))
				AddMute(MuteKey,null)
				var/reason = input(src,"Why are you muting [MuteKey]?","Mute Key")as null|text
				if(!reason) reason = "No reason supplied."
				GMLog("[ReportDate()] [src] ([src.key]) has muted [MuteKey] for [reason].")
				for(var/mob/PC/P in world) if(P.key == MuteKey) info(P,world,"has been muted.([reason]).")
				WorldSave()
	Unmute()
		set category = "GM Cmds"
		set desc = "Unmute a key/IP"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		switch(alert(src,"Unmuting which?","Unmute","Key","IP","Cancel"))
			if("Cancel") return
			if("Key")
				if(!MuteList.len){info(,list(src),"The MuteList is empty.");return}
				var/UnmuteKey = input(src,"Unmute which key?","Unmute by Key")as null|anything in MuteList
				if(UnmuteKey)
					for(var/Key_IP in MuteList[UnmuteKey]) IPMuteList -= Key_IP
					MuteList -= UnmuteKey
					info(,src,"[UnmuteKey] has been key-unmuted.")
					GMLog("[ReportDate()] [src] ([src.key]) has unmuted [UnmuteKey].")
					WorldSave()
			if("IP")
				if(!IPMuteList.len){info(,list(src),"The IPMuteList is empty.");return}
				var/UnmuteIP = input(src,"Unmute which IP?","Unmute by IP")as null|anything in IPMuteList
				if(UnmuteIP)
					for(var/IP_Key in IPMuteList[UnmuteIP]) MuteList -= IP_Key
					IPMuteList -= UnmuteIP
					GMLog("[ReportDate()] [src] ([src.key]) has unmuted [UnmuteIP].")
					WorldSave()
	GM_FAQ()
		set category = "GM Cmds"
		set desc = "This year's best-seller, a must-read!"
		if(!isHeadAdmin(src) && !isAdmin(src) && !isHeadGM(src) && !isGM(src) && !isMod(src)){info(,list(src),"Jerk Off");return}
		if(fexists("gmfaq.htm")) usr << browse(file("gmfaq.htm"))


mob/Scat_Man/proc
	Push()
		set category="Scat Man"
		set desc="Push someone using the force!"
		for(var/mob/PC/p in get_step(src,src.dir))
			if(!isGM(p)&&!isHeadAdmin(p)&&!isHeadGM(p)&&!isAdmin(p)) step(p,src.dir)
			else info(,list(src),"Get your hands off [p] you pervert.")
	Toggle_battle()
		set category="Scat Man"
		set desc="Toggle self battle on/off"
		var/state="OFF"
		if(src.battle==1) state="ON"
		switch(alert(src,"Current self battle state: [state]","Toggle self battle","Toggle ON","Toggle OFF","Cancel"))
			if("Cancel") return
			if("Toggle ON"){src.battle=1;info(,list(src),"Your battle are now enabled.")}
			if("Toggle OFF"){src.battle=0;info(,list(src),"Your battle are now disabled.")}
	Teleport()
		set category="Scat Man"
		set desc = "Teleport to Someone"
		var/mob/PC/S = src
		if(S.party.len>1){info(,list(src),"You cannot teleport while in a party.");return}
		if(S.inbattle){info(,list(src),"You cannot teleport while in a battle.");return}
		switch(alert(src,"Teleport to a player or an area?","Teleport","Player","Area","Cancel"))
			if("Cancel") return
			if("Player")
				var/list/People[] = list()
				for(var/mob/PC/P in world) if(P != src) People["[P] ([P.key])"] += P
				if(!People.len){info(,list(src),"No one to teleport to.");return}
				var/mob/PC/M = People[input(src,"Teleport to who?","Teleport")as null|anything in People]
				if(!M||M.inbattle||src.inbattle){info(,list(src),"Teleportation failed.");return}
				else {info(,list(src),"Teleporting to [M].");density=0;src.loc = M.loc;density = 1;src.icon_state = M.icon_state;return}
			if("Area")
				var/list/TPLoc = list()
				for(var/area/saved_location/T in world) TPLoc.Add(T)
				if(!TPLoc.len){info(,list(src),"No area to teleport to.");return}
				var/area = input(src,"Teleport where?","Teleport Area")as null|anything in TPLoc
				if(!area||src.inbattle) return
				else {info(,list(src),"Teleporting to [area].");density = 0;loc = area;density = 1;icon_state = "normal";return}
	GP()
		set category = "Scat Man"
		set name = "Get GP"
		set desc = "Give yourself some gold."
		var/mob/PC/M = src
		var/gpnum = input(src,"Get how much GP?","Get GP")as null|num
		if(gpnum)
			M.gold += gpnum
		if(M.gold > GPLimit)
			M.gold = GPLimit
	Equipment()
		set category="Scat Man"
		set desc="Create GM's equipment!"
		if(src.contents.len >= 16){info(,list(src),"You don't have enough room in your inventory.");return}
		contents+=new /obj/weapon/Sword/Judgement
		contents+=new /obj/shield/Judgement
		contents+=new /obj/helmet/Judgement
		contents+=new /obj/armor/Armor/Judgement
		contents+=new /obj/arm/Glove/Judgement
	XP()
		set category = "Scat Man"
		set desc = "Give yourself exp"
		var/mob/PC/M = src
		var/expnum = input(src,"How much exp do you want?","How Much?")as null|num
		if(expnum>99999999) expnum = 99999999
		if(expnum<0) return
		if(expnum)
			M.exp += expnum
			M.level_up()
	Heal()
		set category="Scat Man"
		set desc="Heal yourself"
		src.HP=src.MaxHP;src.MP=src.MaxMP
	Icon(I as null|icon)
		if(I)
			var/mob/PC/S = src
			fcopy(I,"custom/[S.class]/[S.key].dmi")
			info(,null,list(src),"[I] succesfully uploaded.")
			var/list/GMs = new()
			for(var/mob/PC/p in world) if(isGM(p)||isHeadGM(p)||isHeadAdmin(p)||isAdmin(p)||isHost(p)) GMs+=p
			info(usr,GMs,"has succesfully uploaded 'custom/[S.class]/[S.key].dmi'.")
			var/CustIcon = "custom/[S.class]/[S.key].dmi"
			if(fexists(CustIcon)){S.custom_icon = file(CustIcon);S.icon = S.custom_icon}
	Hack()
		set category = "Scat Man"
		set desc = "Hack yourself"
		var/mob/PC/M = src
		var/variable = input("Which Variable?","Hack Self")as null|anything in M:vars
		if(!variable) return
		var/default
		var/typeof = M:vars[variable]
		if(isnull(typeof))
			default = "Text"
		else if(isnum(typeof))
			default = "Num"
			dir = 1
		else if(istext(typeof))
			default = "Text"
		else if(isloc(typeof))
			default = "Reference"
		else if(isicon(typeof))
			typeof = "\icon[typeof]"
			default = "Icon"
		else if(istype(typeof,/atom) || istype(typeof,/datum))
			default = "Type"
		else if(istype(typeof,/list))
			default = "List"
		else if(istype(typeof,/client))
			default = "Cancel"
		else
			default = "File"
		var/class = input("What kind of variable?","Variable Type",default) in list("Text","Num","Type","Reference","Icon","File","Restore to default","List","Null","Cancel")
		switch(class)
			if("Cancel")
				return
			if("Restore to default")
				M:vars[variable] = initial(M:vars[variable])
			if("Text")
				M:vars[variable] = input("Enter new text:","Text",M:vars[variable]) as null|text
			if("Num")
				M:vars[variable] = input("Enter new number:","Num",M:vars[variable]) as null|num
			if("Type")
				M:vars[variable] = input("Enter type:","Type",M:vars[variable]) in typesof(/mob)
			if("Reference")
				M:vars[variable] = input("Select reference:","Reference",M:vars[variable]) as mob in world
			if("File")
				M:vars[variable] = input("Pick file:","File",M:vars[variable]) as null|file
			if("Icon")
				M:vars[variable] = input("Pick icon:","Icon",M:vars[variable]) as null|icon
			if("List")
				input("This is what's in [variable]")as null|anything in M:vars[variable]
			if("Null")
				if(alert("Are you sure you want to clear this variable?","Null","Yes","No") == "Yes")
					M:vars[variable] = null
