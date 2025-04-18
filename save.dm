var/const/max_characters_num = 4
mob
	proc
		character_screen(var/screen)
			switch(screen)
				if("character_load_delete")
					inmenu="character_load_delete"
					screen_background(12,16,8,10,0,0,10,"character_load_delete")
					screen_textl(13,16,9.5,9.5,0,0,11,,"Load","character_load_delete")
					screen_textl(13,16,8.5,8.5,0,0,11,,"Delete","character_load_delete")
					menuanswer=0
					menupos=1
					curser=new(client)
					curser.screen_loc="12,9:8"
					while(!menuanswer) sleep(5)
					close_screen("character_load_delete")
					del(curser)
					inmenu=screen
					if(menuanswer==1) return 1
					else return 0
				if("character_menu")
					inmenu="character_menu"
					//loading savefile
					var/savefile/F = new("saves/[copytext(ckey,1,2)]/[ckey].sav")
					//changing the savefile directory to display the saves
					F.cd = "/characters/"
					menulist=new()
					if(!curser) curser = new(client)
					if(!menuaction||menuaction=="Load")
						menuaction="Load"
						menupos=1
						curser.screen_loc = "1:16,14:8"
						screen_textl(3,8,16,15.5,0,16,4,,"Load Game","character_menu_type")
					else
						menuaction="Save"
						menupos=1
						curser.screen_loc = "3,13"
						screen_textl(3,8,16,15.5,0,16,4,,"Save Game","character_menu_type")
					screen_background(1,17,13,16,0,0,3,"character_menu_slot1")
					screen_background(1,17,9,12,0,0,3,"character_menu_slot2")
					screen_background(1,17,5,8,0,0,3,"character_menu_slot3")
					screen_background(1,17,1,4,0,0,3,"character_menu_slot4")
					screen_background(1,8,16,17,0,0,3,"character_menu_type")
					for(var/i=1,i<=max_characters_num,i++)
						if(F[i]&&F["[i]/name"])
							menulist+=i
							switch(i)
								if(1)
									for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="character_menu_slot1") del(O)
									screen_textl(3,12,14,13.5,0,16,4,,"Slot 1","character_menu_slot1")
									screen_portrait(6,13,16,16,4,F["[i]/type"],"character_menu_slot1")
									screen_textl(9,13,14.5,14.5,0,12,4,,F["[i]/name"],"character_menu_slot1")
									screen_textl(13.5,15.5,14.5,14.5,0,12,4,,"Lvl.","character_menu_slot1")
									screen_textr(15,16,14.5,14.5,0,12,4,,F["[i]/level"],"character_menu_slot1")
									screen_textl(9,16,14,14,0,10,4,,F["[i]/class"],"character_menu_slot1")
									screen_textl(9,12,13.5,13.5,0,8,4,,"Exp.","character_menu_slot1")
									screen_textr(12,16,13.5,13.5,0,8,4,,F["[i]/exp"],"character_menu_slot1")
									screen_textl(9,12,13,13,0,6,4,,"Gold","character_menu_slot1")
									screen_textr(12,16,13,13,0,6,4,,F["[i]/gold"],"character_menu_slot1")
								if(2)
									for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="character_menu_slot2") del(O)
									screen_textl(3,12,10,9.5,0,16,4,,"Slot 2","character_menu_slot2")
									screen_portrait(6,9,16,16,4,F["[i]/type"],"character_menu_slot2")
									screen_textl(9,13,10.5,10.5,0,12,4,,F["[i]/name"],"character_menu_slot2")
									screen_textl(13.5,15.5,10.5,10.5,0,12,4,,"Lvl.","character_menu_slot2")
									screen_textr(15,16,10.5,10.5,0,12,4,,F["[i]/level"],"character_menu_slot2")
									screen_textl(9,16,10,10,0,10,4,,F["[i]/class"],"character_menu_slot2")
									screen_textl(9,11,9.5,9.5,0,8,4,,"Exp.","character_menu_slot2")
									screen_textr(12,16,9.5,9.5,0,8,4,,F["[i]/exp"],"character_menu_slot2")
									screen_textl(9,12,9,9,0,6,4,,"Gold","character_menu_slot2")
									screen_textr(12,16,9,9,0,6,4,,F["[i]/gold"],"character_menu_slot2")
								if(3)
									for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="character_menu_slot3") del(O)
									screen_textl(3,12,6,5.5,0,16,4,,"Slot 3","character_menu_slot3")
									screen_portrait(6,5,16,16,4,F["[i]/type"],"character_menu_slot3")
									screen_textl(9,13,6.5,6.5,0,12,4,,F["[i]/name"],"character_menu_slot3")
									screen_textl(13.5,15.5,6.5,6.5,0,12,4,,"Lvl.","character_menu_slot3")
									screen_textr(15,16,6.5,6.5,0,12,4,,F["[i]/level"],"character_menu_slot3")
									screen_textl(9,16,6,6,0,10,4,,F["[i]/class"],"character_menu_slot3")
									screen_textl(9,11,5.5,5.5,0,8,4,,"Exp.","character_menu_slot3")
									screen_textr(11,16,5.5,5.5,0,8,4,,F["[i]/exp"],"character_menu_slot3")
									screen_textl(9,12,5,5,0,6,4,,"Gold","character_menu_slot3")
									screen_textr(12,16,5,5,0,6,4,,F["[i]/gold"],"character_menu_slot3")
								if(4)
									for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="character_menu_slot4") del(O)
									screen_textl(3,12,2,1.5,0,16,4,,"Slot 4","character_menu_slot4")
									screen_portrait(6,1,16,16,4,F["[i]/type"],"character_menu_slot4")
									screen_textl(9,13,2.5,2.5,0,12,4,,F["[i]/name"],"character_menu_slot4")
									screen_textl(13.5,15.5,2.5,2.5,0,12,4,,"Lvl.","character_menu_slot4")
									screen_textr(15,16,2.5,2.5,0,12,4,,F["[i]/level"],"character_menu_slot4")
									screen_textl(9,16,2,2,0,10,4,,F["[i]/class"],"character_menu_slot4")
									screen_textl(9,12,1.5,1.5,0,8,4,,"Exp.","character_menu_slot4")
									screen_textr(11,16,1.5,1.5,0,8,4,,F["[i]/exp"],"character_menu_slot4")
									screen_textl(9,12,1,1,0,6,4,,"Gold","character_menu_slot4")
									screen_textr(12,16,1,1,0,6,4,,F["[i]/gold"],"character_menu_slot4")
						else
							switch(i)
								if(1) screen_textl(3,12,14,13.5,0,16,4,,"Slot 1","character_menu_slot1")
								if(2) screen_textl(3,12,10,9.5,0,16,4,,"Slot 2","character_menu_slot2")
								if(3) screen_textl(3,12,6,5.5,0,16,4,,"Slot 3","character_menu_slot3")
								if(4) screen_textl(3,12,2,1.5,0,16,4,,"Slot 4","character_menu_slot4")
				if("character_create")
					inmenu="character_create"
					menulist=list("Paladin"=/mob/PC/paladin,
									"White Mage"=/mob/PC/wmage,
									"Dragoon"=/mob/PC/dragoon,
									"Mature Caller"=/mob/PC/mcaller,
									"Ninja"=/mob/PC/ninja,
									"Monk"=/mob/PC/monk,
									"Bard"=/mob/PC/bard,
									"Engineer"=/mob/PC/engineer,
									"White Twin"=/mob/PC/wtwin,
									"Black Twin"=/mob/PC/btwin,
									"Dark Knight"=/mob/PC/dknight,
									"Black Knight"=/mob/PC/bknight,
									"Lunarian"=/mob/PC/lunarian,
									"Young Caller"=/mob/PC/ycaller,
									"Sage"=/mob/PC/sage)


					menupos=1
					if(!curser) curser = new(client)
					curser.screen_loc = "1,14:16"


					screen_background(1,17,2,16,0,0,3,"character_create")
					screen_background(1,6,16,17,0,0,4,"character_create")
					screen_textl(2,9.15,16.5,14.5,0,2,4,,"New Game","character_create")


					screen_picon(2,14,0,16,5,,/mob/PC/paladin,"character_create")
					screen_picon(5,14,8,16,5,,/mob/PC/wmage,"character_create")
					screen_picon(8,14,16,16,5,,/mob/PC/dragoon,"character_create")
					screen_picon(11,14,24,16,5,,/mob/PC/mcaller,"character_create")
					screen_picon(15,14,0,16,5,,/mob/PC/ninja,"character_create")

					screen_picon(2,13,0,0,5,,/mob/PC/monk,"character_create")
					screen_picon(5,13,8,0,5,,/mob/PC/bard,"character_create")
					screen_picon(8,13,16,0,5,,/mob/PC/engineer,"character_create")
					screen_picon(11,13,24,0,5,,/mob/PC/wtwin,"character_create")
					screen_picon(15,13,0,0,5,,/mob/PC/btwin,"character_create")

					screen_picon(2,12,0,-16,5,1,/mob/PC/dknight,"character_create")
					screen_picon(5,12,8,-16,5,1,/mob/PC/bknight,"character_create")
					screen_picon(8,12,16,-16,5,1,/mob/PC/lunarian,"character_create")
					screen_picon(11,12,24,-16,5,1,/mob/PC/ycaller,"character_create")
					screen_picon(15,12,0,-16,5,1,/mob/PC/sage,"character_create")

					screen_textl(8,10,10,10,10,0,5,,"HP :","character_create")
					screen_textl(8,10,9,9,10,0,5,,"MP :","character_create")
					screen_textl(8,10,8,8,10,0,5,,"Str:","character_create")
					screen_textl(8,10,7,7,10,0,5,,"Agi:","character_create")
					screen_textl(8,10,6,6,10,0,5,,"Vit:","character_create")
					screen_textl(8,10,5,5,10,0,5,,"Wis:","character_create")
					screen_textl(8,10,4,4,10,0,5,,"Wil:","character_create")

					var/savefile/F = new("saves/[copytext(ckey,1,2)]/[ckey].sav")
					F.cd = "/bonus/"
					var/list/allowed_characters = new()
					F["characters"]>>allowed_characters
					if(isnull(allowed_characters)) allowed_characters = new()

					if(allowed_characters.Find("Dark Knight"))
						screen_picon(2,12,0,-16,6,,/mob/PC/dknight,"character_create")
					if(allowed_characters.Find("Black Knight"))
						screen_picon(5,12,8,-16,6,,/mob/PC/bknight,"character_create")
					if(allowed_characters.Find("Lunarian"))
						screen_picon(8,12,16,-16,6,,/mob/PC/lunarian,"character_create")
					if(allowed_characters.Find("Young Caller"))
						screen_picon(11,12,24,-16,6,,/mob/PC/ycaller,"character_create")
					if(allowed_characters.Find("Sage"))
						screen_picon(15,12,0,-16,6,,/mob/PC/sage,"character_create")

					screen_background(2,6,3,7,0,0,4,"character_create_info")

					character_screen("character_create_refresh")
				if("character_create_refresh")
					for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="character_create_info") del(O)
					for(var/obj/onscreen/portrait/O in client.screen) if(O.screentag=="character_create_info") del(O)


					if(length(menulist)>=menupos)
						if(menupos<11)
							var/mob/PC/C = menulist[menulist[menupos]]
							C = new C()
							//quick status
							screen_portrait(3,8,16,16,4,C,"character_create_info")
							screen_textl(1,8,10,10,16,16,6,,"[C.class]","character_create_info")
							if(C.action[1]) screen_textl(2.5,6.5,7,7,0,-8,6,,"[C.action[1]]","character_create_info")
							if(C.action[2]) screen_textl(2.5,6.5,6,6,0,-4,6,,"[C.action[2]]","character_create_info")
							if(C.action[3]) screen_textl(2.5,6.5,5,5,0,0,6,,"[C.action[3]]","character_create_info")
							if(C.action[4]) screen_textl(2.5,6.5,4,4,0,4,6,,"[C.action[4]]","character_create_info")
							if(C.action[5]) screen_textl(2.5,6.5,3,3,0,8,6,,"[C.action[5]]","character_create_info")

							screen_textl(10,12,10,10,10,0,5,,"[C.MaxHP]","character_create_info")
							screen_textl(10,12,9,9,10,0,5,,"[C.MaxMP]","character_create_info")
							screen_textl(10,12,8,8,10,0,5,,"[C.str]","character_create_info")
							screen_textl(10,12,7,7,10,0,5,,"[C.agi]","character_create_info")
							screen_textl(10,12,6,6,10,0,5,,"[C.vit]","character_create_info")
							screen_textl(10,12,5,5,10,0,5,,"[C.wis]","character_create_info")
							screen_textl(10,12,4,4,10,0,5,,"[C.wil]","character_create_info")

							del(C)
						if(menupos>10)
							var/savefile/F = new("saves/[copytext(ckey,1,2)]/[ckey].sav")
							F.cd = "/bonus/"
							var/list/allowed_characters = new()
							F["characters"]>>allowed_characters
							if(isnull(allowed_characters)) allowed_characters = new()
							var/mob/PC/C = menulist[menulist[menupos]]
							C = new C()
							if(allowed_characters.Find(C.class))
								//quick status
								screen_portrait(3,8,16,16,4,C,"character_create_info")
								screen_textl(1,8,10,10,16,16,5,,"[C.class]","character_create_info")

								screen_textl(10,12,10,10,10,0,5,,"[C.MaxHP]","character_create_info")
								screen_textl(10,12,9,9,10,0,5,,"[C.MaxMP]","character_create_info")
								screen_textl(10,12,8,8,10,0,5,,"[C.str]","character_create_info")
								screen_textl(10,12,7,7,10,0,5,,"[C.agi]","character_create_info")
								screen_textl(10,12,6,6,10,0,5,,"[C.vit]","character_create_info")
								screen_textl(10,12,5,5,10,0,5,,"[C.wis]","character_create_info")
								screen_textl(10,12,4,4,10,0,5,,"[C.wil]","character_create_info")
							if(C.action) for(var/i=1,i<=5,i++)
								var/y,yo
								switch(i)
									if(1){y=7;yo=-8}
									if(2){y=6;yo=-4}
									if(3){y=5;yo=0}
									if(4){y=4;yo=4}
									if(5){y=3;yo=8}
								if(C.action[i])
									if(allowed_characters.Find(C.class)) screen_textl(2.5,6.5,y,y,0,yo,5,,"[C.action[i]]","character_create_info")
									else {var/string;for(var/s=1,s<=length("[C.action[i]]"),s++) string+=ascii2text(63);screen_textl(2.5,6.5,y,y,0,yo,5,,string,"character_create_info")}
							del(C)


client
	var/last_used_slot
	Del()
		//save character (if possible).
		if(last_used_slot && istype(mob,/mob/PC)) character_save(last_used_slot)
		del(mob)
		..()
	proc
		character_new(var/C)
			var/mob/PC/new_mob = new C()
			new_mob.name = copytext(key,1,17)
			var/mob/PC/old_mob = mob
			//now, new_mob need a name
			new_mob.name = old_mob.namingway(new_mob)
			mob = new_mob
			del(old_mob)	//deleting thee old.
			//at the end.. custom?
			new_mob<<browse(file("faq.htm"))
			new_mob.msg("Be sure to read the FAQ!")
		character_save(var/s)
			if(!s) return
			var/savefile/F = new("saves/[copytext(ckey,1,2)]/[ckey].sav")
			var/mob/PC/M = mob
			F.cd = "/characters/"
			F["[s]/name"]<<M.name
			F["[s]/class"]<<M.class
			F["[s]/type"]<<M.type
			F["[s]/level"]<<num2text(M.level)
			F["[s]/exp"]<<num2text(M.exp,15)
			F["[s]/gold"]<<num2text(M.gold,10)
			F["[s]/mob"]<<mob
			F.cd = "/config/"
			F["chat_color"]<<M.chat_color
			F["ignore_list"]<<M.ignore_list
			F["chat_toggle"] << M.chat_toggle
		character_load(var/s)
			if(!s) return
			var/savefile/F = new("saves/[copytext(ckey,1,2)]/[ckey].sav")
			var/mob/PC/old_mob = mob
			var/mob/PC/new_mob
			F.cd = "/characters/"
			F["[s]/mob"]>>new_mob
			F["[s]/name"]>>new_mob.name
			mob = new_mob
			del(old_mob)
			F.cd = "/config/"
			if(F["chat_color"]) F["chat_color"]>>new_mob.chat_color
			if(F["ignore_list"]) F["ignore_list"]>>new_mob.ignore_list
			if(F["chat_toggle"]) F["chat_toggle"]>>new_mob.chat_toggle
		character_delete(var/s)
			if(!s) return
			var/savefile/F = new("saves/[copytext(ckey,1,2)]/[ckey].sav")
			F.cd = "/characters/"
			mob.screen_dialog("Delete [F["[s]/name"]]?","character_delete",null,1)
			if(mob.screen_yesno("character_delete")) F.dir.Remove(num2text(last_used_slot))
			last_used_slot = null
			mob.close_screen("character_delete")
			mob.menuaction = "Load"
			mob.character_screen("character_menu")
