mob/PC/proc/screen(screen,ext)
	if(screen=="menu")
		inmenu="menu"
		//menu panel
		screen_background(13,17,8,17,0,0,4,"menu")
		screen_textl(14,17,16.5,16.5,0,0,5,,"Item","menu")
		screen_textl(14,17,15.5,15.5,0,0,5,,"Magic","menu")
		screen_textl(14,17,14.5,14.5,0,0,5,,"Equip","menu")
		screen_textl(14,17,13.5,13.5,0,0,5,,"Status","menu")
		screen_textl(14,17,12.5,12.5,0,0,5,,"Form","menu")
		screen_textl(14,17,11.5,11.5,0,0,5,,"Change","menu")
		screen_textl(14,17,10.5,10.5,0,0,5,,"Custom","menu")
		screen_textl(14,17,9.5,9.5,0,0,5,,"Trade","menu")
		screen_textl(14,17,8.5,8.5,0,0,5,,"Save","menu")
		menupos=1
		curser=new(client)
		curser.screen_loc="13,16:8"
		//play time
		screen_background(13,17,4,7,0,0,4,"menu")
		screen_textl(14,17,6.5,6.5,0,0,5,,"Time","menu")
		screen_textr(13.5,17.5,5.5,5.5,0,0,5,,"[time2text(world.timeofday,"hh:mm")] ","menu")
		//gold panel
		screen_background(12,17,1,3,0,0,4,"menu")
		screen_textr(12.5,16.5,2.5,2.5,0,0,5,,"[num2text(gold,10)]","menu")
		screen_textl(16,17,1.5,1.5,0,0,5,,"GP","menu")
		//party panel
		var
			menu_bg
			menu_txt
			mob/PC/p
		switch(length(party))
			if(1){menu_bg = 1;menu_txt = 0}
			if(2){menu_bg = 1;menu_txt = 12}
			if(3){menu_bg = 1;menu_txt = 8}
			if(4){menu_bg = 1;menu_txt = 4}
			if(5){menu_bg = 1;menu_txt = 0}
		p = party[1]
		screen_background(1,13,menu_bg,17,0,0,3,"menu")
		screen_portrait(1,14,16,menu_txt,5,p.icon,"menu")
		screen_textl(5,11.5,15.5,15.5,0,menu_txt - 8,5,,p.class,"menu")
		screen_textl(5, 8.5,15,15,0,menu_txt - 8,5,,p.name,"menu")
		screen_textl(9,11.5,15,15,0,menu_txt - 8,5,,"Lv.[p.level]","menu")
		screen_textl(5.5,6.5,14.5,14.5,0,menu_txt - 8,5,,"HP","menu")
		screen_textr(6.5, 11,14.5,14.5,0,menu_txt - 8,5,,"[p.HP]/[p.MaxHP]","menu_s1")
		screen_textl(5.5,6.5,14,14,0,menu_txt - 8,5,,"MP","menu")
		screen_textr(6.5, 11,14,14,0,menu_txt - 8,5,,"[p.MP]/[p.MaxMP]","menu_s1")
		if(length(party)>=2)
			p = party[2]
			screen_portrait(2,11,16,8 + menu_txt,5,p.icon,"menu")
			screen_textl(5,11.5,12.5,12.5,0,menu_txt,5,,p.class,"menu")
			screen_textl(5, 8.5,12,12,0,menu_txt,5,,p.name,"menu")
			screen_textl(9,11.5,12,12,0,menu_txt,5,,"Lv.[p.level]","menu")
			screen_textl(5.5,6.5,11.5,11.5,0,menu_txt,5,,"HP","menu")
			screen_textr(6.5, 11,11.5,11.5,0,menu_txt,5,,"[p.HP]/[p.MaxHP]","menu_s2")
			screen_textl(5.5,6.5,11,11,0,menu_txt,5,,"MP","menu")
			screen_textr(6.5, 11,11,11,0,menu_txt,5,,"[p.MP]/[p.MaxMP]","menu_s2")
		if(length(party)>=3)
			p = party[3]
			screen_portrait(1,8 ,16,16 + menu_txt,5,p.icon,"menu")
			screen_textl(5,11.5,9.5,9.5,0,8 + menu_txt,5,,p.class,"menu")
			screen_textl(5, 8.5,9,9,0,8 + menu_txt,5,,p.name,"menu")
			screen_textl(9,11.5,9,9,0,8 + menu_txt,5,,"Lv.[p.level]","menu")
			screen_textl(5.5,6.5,8.5,8.5,0,8 + menu_txt,5,,"HP","menu")
			screen_textr(6.5, 11,8.5,8.5,0,8 + menu_txt,5,,"[p.HP]/[p.MaxHP]","menu_s3")
			screen_textl(5.5,6.5,8,8,0,8 + menu_txt,5,,"MP","menu")
			screen_textr(6.5, 11,8,8,0,8 + menu_txt,5,,"[p.MP]/[p.MaxMP]","menu_s3")
		if(length(party)>=4)
			p = party[4]
			screen_portrait(2,5 ,16,24 + menu_txt,5,p.icon,"menu")
			screen_textl(5,11.5,6.5,6.5,0,16 + menu_txt,5,,p.class,"menu")
			screen_textl(5, 8.5,6,6,0,16 + menu_txt,5,,p.name,"menu")
			screen_textl(9,11.5,6,6,0,16 + menu_txt,5,,"Lv.[p.level]","menu")
			screen_textl(5.5,6.5,5.5,5.5,0,16 + menu_txt,5,,"HP","menu")
			screen_textr(6.5, 11,5.5,5.5,0,16 + menu_txt,5,,"[p.HP]/[p.MaxHP]","menu_s4")
			screen_textl(5.5,6.5,5,5,0,16 + menu_txt,5,,"MP","menu")
			screen_textr(6.5, 11,5,5,0,16 + menu_txt,5,,"[p.MP]/[p.MaxMP]","menu_s4")
		if(length(party)>=5)
			p = party[5]
			screen_portrait(1,3 ,16,menu_txt,5,p.icon,"menu")
			screen_textl(5,11.5,4.5,4.5,0,menu_txt - 8,5,,p.class,"menu")
			screen_textl(5, 8.5,4,4,0,menu_txt - 8,5,,p.name,"menu")
			screen_textl(9,11.5,4,4,0,menu_txt - 8,5,,"Lv.[p.level]","menu")
			screen_textl(5.5,6.5,3.5,3.5,0,menu_txt - 8,5,,"HP","menu")
			screen_textr(6.5, 11,3.5,3.5,0,menu_txt - 8,5,,"[p.HP]/[p.MaxHP]","menu_s5")
			screen_textl(5.5,6.5,3,3,0,menu_txt - 8,5,,"MP","menu")
			screen_textr(6.5, 11,3,3,0,menu_txt - 8,5,,"[p.MP]/[p.MaxMP]","menu_s5")
	else if(screen=="menu_srefresh" && ext)
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="menu_s[ext]") del(O)
		var/mob/PC/p = party[ext]
		var/menu_txt
		switch(length(party)){if(1) menu_txt = 0;if(2) menu_txt = 12;if(3) menu_txt = 8;if(4) menu_txt = 4;if(5) menu_txt = 0}
		switch(ext)
			if(1){screen_textr(6.5, 11,14.5,14.5,0,menu_txt - 8,5,,"[p.HP]/[p.MaxHP]","menu_s1");screen_textr(6.5, 11,14,14,0,menu_txt - 8,5,,"[p.MP]/[p.MaxMP]","menu_s1")}
			if(2){screen_textr(6.5, 11,11.5,11.5,0,menu_txt,5,,"[p.HP]/[p.MaxHP]","menu_s2");screen_textr(6.5, 11,11,11,0,menu_txt,5,,"[p.MP]/[p.MaxMP]","menu_s2")}
			if(3){screen_textr(6.5, 11,8.5,8.5,0,8 + menu_txt,5,,"[p.HP]/[p.MaxHP]","menu_s3");screen_textr(6.5, 11,8,8,0,8 + menu_txt,5,,"[p.MP]/[p.MaxMP]","menu_s3")}
			if(4){screen_textr(6.5, 11,5.5,5.5,0,16 + menu_txt,5,,"[p.HP]/[p.MaxHP]","menu_s4");screen_textr(6.5, 11,5,5,0,16 + menu_txt,5,,"[p.MP]/[p.MaxMP]","menu_s4")}
			if(5){screen_textr(6.5, 11,3.5,3.5,0,menu_txt - 8,5,,"[p.HP]/[p.MaxHP]","menu_s5");screen_textr(6.5, 11,3,3,0,menu_txt - 8,5,,"[p.MP]/[p.MaxMP]","menu_s5")}
	else if(screen=="item")
		inmenu="item"
		screen_background(1,17,1,15,0,0,7,"item")
		//stuff at the top
		screen_background(1,5,16,17,0,0,7,"item")
		screen_textl(2,7,16.5,1.5,0,0,8,,"Item","item")
		//descriptions
		screen_background(5,17,16,17,0,0,7,"item")
		// Creating list in menu
		var/itemslot=0
		var/turf/T = loc
		for(var/obj/O in src.contents)
			itemslot++
			var/Color
			if(istype(O,/obj/Ability/Basic/Item) && (!O:CanUse || O:CanUse == 2 || (O:CanUse == 3&&T.worldmap))) Color=0
			else if(istype(O,/obj/Key_Item)) Color=1
			else Color=2
			switch(itemslot)
				if(1)
					screen_invicon(2,14.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,14.5,14.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,14.5,14.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,14.5,14.5,0,0,8,Color,O.suffix,"item")
				if(2)
					screen_invicon(10,14.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,14.5,14.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,14.5,14.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,14.5,14.5,0,0,8,Color,O.suffix,"item")
				if(3)
					screen_invicon(2,13.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,13.5,13.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,13.5,13.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,13.5,13.5,0,0,8,Color,O.suffix,"item")
				if(4)
					screen_invicon(10,13.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,13.5,13.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,13.5,13.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,13.5,13.5,0,0,8,Color,O.suffix,"item")
				if(5)
					screen_invicon(2,12.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,12.5,12.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,12.5,12.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,12.5,12.5,0,0,8,Color,O.suffix,"item")
				if(6)
					screen_invicon(10,12.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,12.5,12.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,12.5,12.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,12.5,12.5,0,0,8,Color,O.suffix,"item")
				if(7)
					screen_invicon(2,11.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,11.5,11.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,11.5,11.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,11.5,11.5,0,0,8,Color,O.suffix,"item")
				if(8)
					screen_invicon(10,11.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,11.5,11.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,11.5,11.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,11.5,11.5,0,0,8,Color,O.suffix,"item")
				if(9)
					screen_invicon(2,10.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,10.5,10.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,10.5,10.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,10.5,10.5,0,0,8,Color,O.suffix,"item")
				if(10)
					screen_invicon(10,10.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,10.5,10.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,10.5,10.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,10.5,10.5,0,0,8,Color,O.suffix,"item")
				if(11)
					screen_invicon(2,9.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,9.5,9.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,9.5,9.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,9.5,9.5,0,0,8,Color,O.suffix,"item")
				if(12)
					screen_invicon(10,9.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,9.5,9.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,9.5,9.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,9.5,9.5,0,0,8,Color,O.suffix,"item")
				if(13)
					screen_invicon(2,8.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,8.5,8.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,8.5,8.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,8.5,8.5,0,0,8,Color,O.suffix,"item")
				if(14)
					screen_invicon(10,8.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,8.5,8.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,8.5,8.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,8.5,8.5,0,0,8,Color,O.suffix,"item")
				if(15)
					screen_invicon(2,7.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,7.5,7.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,7.5,7.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,7.5,7.5,0,0,8,Color,O.suffix,"item")
				if(16)
					screen_invicon(10,7.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,7.5,7.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,7.5,7.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,7.5,7.5,0,0,8,Color,O.suffix,"item")
				if(17)
					screen_invicon(2,6.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,6.5,6.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,6.5,6.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,6.5,6.5,0,0,8,Color,O.suffix,"item")
				if(18)
					screen_invicon(10,6.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,6.5,6.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,6.5,6.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,6.5,6.5,0,0,8,Color,O.suffix,"item")
				if(19)
					screen_invicon(2,5.5,0,8,Color,O.invicon,"item")
					screen_textl(2.5,7.5,5.5,5.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(7.5,8,5.5,5.5,0,0,8,Color,":","item")
						screen_textr(7.5,8.5,5.5,5.5,0,0,8,Color,O.suffix,"item")
				if(20)
					screen_invicon(10,5.5,0,8,Color,O.invicon,"item")
					screen_textl(10.5,14.5,5.5,5.5,0,0,8,Color,O.name,"item")
					if(istype(O,/obj/Ability/Basic/Item))
						screen_textl(15.5,16,5.5,5.5,0,0,8,Color,":","item")
						screen_textr(14.5,16.5,5.5,5.5,0,0,8,Color,O.suffix,"item")
		menupos=1
		curser.screen_loc="1,14:8"
	else if(screen=="magic_type")
		inmenu = "magic_type"
		screen_background(1,6,14,17,0,0,7,"magic_type")
		screen_textl(2,6,16.5,16.5,16,8,8,0,"[action[2]]","magic_type")
		screen_textl(2,6,15.5,15.5,16,12,8,0,"[action[3]]","magic_type")
		screen_textl(2,6,14.5,14.5,16,16,8,0,"[action[4]]","magic_type")
		menupos=1
		curser.screen_loc="1:16,16:16"
		//info
		screen_background(7,17,14,17,0,0,7,"magic_type")
		screen_portrait(8,15,13,8,8,icon,"magic_type")
		screen_textl(11,16.5,16.5,16.5,0,0,8,,class,"magic_type")
		screen_textl(11,14.5,16,16,0,0,8,,name,"magic_type")
		screen_textl(15,17.5,16,16,0,0,8,,"Lv.[level]","magic_type")
		screen_textl(11.5,13.5,15.5,15.5,0,0,8,,"HP","magic_type")
		screen_textr(12.5,17,15.5,15.5,0,0,8,,"[HP]/[MaxHP]","magic_type")
		screen_textl(11.5,13.5,15,15,0,0,8,,"MP","magic_type")
		screen_textr(12.5,17,15,15,0,0,8,,"[MP]/[MaxMP]","magic_type")
		screen_textl(11,16.5,14.5,14.5,0,0,8,,"Need MP...","magic_type")
		//magic area
		screen_background(1,17,1,13,0,0,7,"magic_type")
	else if(screen=="magic" && ext)
		menulist = new()
		var/obj/Ability/ActionType = action[ext]
		for(var/A in typesof(action[ext]))
			if(A!=ActionType.type)
				var/obj/Ability/O = new A
				if(level>=O.LvlNeed) menulist+=O
		if(!length(menulist)){src<<SOUND_WRONG;return}
		//displaying..
		inmenu = "magic"
		var/X=0
		var/Y=0
		var/YO=0
		var/turf/T = loc
		for(var/obj/Ability/O in menulist)
			var/Color=0
			if(O.CanUse == 1 ||(O.CanUse == 3 && !T.worldmap)) Color = 2
			switch(menulist.Find(O))
				if(1){X=3;Y=11;YO=24};if(2){X=7.5;Y=11;YO=24};if(3){X=12;Y=11;YO=24}
				if(4){X=3;Y=11;YO=0};if(5){X=7.5;Y=11;YO=0};if(6){X=12;Y=11;YO=0}
				if(7){X=3;Y=10;YO=8};if(8){X=7.5;Y=10;YO=8};if(9){X=12;Y=10;YO=8}
				if(10){X=3;Y=9;YO=16};if(11){X=7.5;Y=9;YO=16};if(12){X=12;Y=9;YO=16}
				if(13){X=3;Y=8;YO=24};if(14){X=7.5;Y=8;YO=24};if(15){X=12;Y=8;YO=24}
				if(16){X=3;Y=8;YO=0};if(17){X=7.5;Y=8;YO=0};if(18){X=12;Y=8;YO=0}
				if(19){X=3;Y=7;YO=8};if(20){X=7.5;Y=7;YO=8};if(21){X=12;Y=7;YO=8}
			screen_invicon(X,Y,YO,8,Color,O.invicon,"magic")
			screen_textl(X+0.5,X+4,Y,Y,0,YO,8,Color,O.name,"magic")
		menupos = 1
		curser.screen_loc="2:8,11:16"
		screen("magic_cost")
	else if(screen=="magic_cost")
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag == "magic_cost") del(O)
		if(length(menulist) >= menupos)
			var/obj/Ability/O = menulist[menupos]
			screen_textl(16,17.5,14.5,14.5,0,0,8,,"[O.MPCost]","magic_cost")
	else if(screen=="equip")
		inmenu="equip"
		screen_background(1,17,12,17,0,0,7,"equip")
		screen_portrait(2,15,13,8,8,icon,"equip")
		screen_textl(2,7,12.5,12.5,0,0,8,,"Both Hands","equip")
		screen_textl(2,7,13.5,13.5,0,0,8,,"[name]","equip")
		screen_textl(5.5,7.5,16.5,16.5,0,0,8,,"[att()]","equip")
		screen_invicon(5,16,16.5,16.5,0,"longsword","equip")
		screen_textl(5.5,7,15.5,15.5,0,0,8,,"[def()]","equip")
		screen_invicon(5,15,15,15,0,"shield","equip")
		screen_textl(5.5,7,14.5,14.5,0,0,8,,"[magdef()]","equip")
		screen_invicon(5,14,14,14,0,"other","equip")
		screen_textl(8,11,16.5,16.5,0,0,8,,"RHand","equip")
		screen_textl(8,11,15.5,15.5,0,0,8,,"LHand","equip")
		screen_textl(8,11,14.5,14.5,0,0,8,,"Head","equip")
		screen_textl(8,11,13.5,13.5,0,0,8,,"Body","equip")
		screen_textl(8,11,12.5,12.5,0,0,8,,"Arms","equip")
		if(rhand)
			screen_invicon(11,16.5,0,8,,rhand.invicon,"equip")
			screen_textl(11.5,16.5,16.5,16.5,0,0,8,,rhand.name,"equip")
		if(lhand)
			screen_invicon(11,15.5,0,8,,lhand.invicon,"equip")
			screen_textl(11.5,16.5,15.5,15.5,0,0,8,,lhand.name,"equip")
		if(helmet)
			screen_invicon(11,14.5,0,8,,helmet.invicon,"equip")
			screen_textl(11.5,16.5,14.5,14.5,0,0,8,,helmet.name,"equip")
		if(armor)
			screen_invicon(11,13.5,0,8,,armor.invicon,"equip")
			screen_textl(11.5,16.5,13.5,13.5,0,0,8,,armor.name,"equip")
		if(arm)
			screen_invicon(11,12.5,0,8,,arm.invicon,"equip")
			screen_textl(11.5,16.5,12.5,12.5,0,0,8,,arm.name,"equip")
		menupos=1
		curser.screen_loc="7,16:8"
	else if(screen=="equiprefresh")
		inmenu="equip"
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="equip") del O
		for(var/obj/onscreen/invicon/O in client.screen) if(O.screentag=="equip") del O
		screen_textl(2,7,12.5,12.5,0,0,8,,"Both Hands","equip")
		screen_textl(2,7,13.5,13.5,0,0,8,,"[name]","equip")
		screen_textl(5.5,7.5,16.5,16.5,0,0,8,,"[att()]","equip")
		screen_invicon(5,16,16.5,16.5,0,"longsword","equip")
		screen_textl(5.5,7,15.5,15.5,0,0,8,,"[def()]","equip")
		screen_invicon(5,15,15,15,0,"shield","equip")
		screen_textl(5.5,7,14.5,14.5,0,0,8,,"[magdef()]","equip")
		screen_invicon(5,14,14,14,0,"other","equip")
		screen_textl(8,11,16.5,16.5,0,0,8,,"RHand","equip")
		screen_textl(8,11,15.5,15.5,0,0,8,,"LHand","equip")
		screen_textl(8,11,14.5,14.5,0,0,8,,"Head","equip")
		screen_textl(8,11,13.5,13.5,0,0,8,,"Body","equip")
		screen_textl(8,11,12.5,12.5,0,0,8,,"Arms","equip")
		if(rhand)
			screen_invicon(11,16.5,0,8,,rhand.invicon,"equip")
			screen_textl(11.5,16.5,16.5,16.5,0,0,8,,rhand.name,"equip")
		if(lhand)
			screen_invicon(11,15.5,0,8,,lhand.invicon,"equip")
			screen_textl(11.5,16.5,15.5,15.5,0,0,8,,lhand.name,"equip")
		if(helmet)
			screen_invicon(11,14.5,0,8,,helmet.invicon,"equip")
			screen_textl(11.5,16.5,14.5,14.5,0,0,8,,helmet.name,"equip")
		if(armor)
			screen_invicon(11,13.5,0,8,,armor.invicon,"equip")
			screen_textl(11.5,16.5,13.5,13.5,0,0,8,,armor.name,"equip")
		if(arm)
			screen_invicon(11,12.5,0,8,,arm.invicon,"equip")
			screen_textl(11.5,16.5,12.5,12.5,0,0,8,,arm.name,"equip")
		menupos=1
		curser.screen_loc="7,16:8"
	else if(screen=="equiplist"&&ext)
		inmenu="equiplist"
		screen_background(1,17,1,11,0,0,7,"equiplist")
		menuaction=ext
		menulist=new()
		if(ext=="rhand"||ext=="lhand")
			for(var/obj/weapon/O in usr.contents) if(!O.suffix) menulist+=O
			for(var/obj/shield/O in usr.contents) if(!O.suffix) menulist+=O
		else if(ext=="head") for(var/obj/helmet/O in usr.contents) if(!O.suffix) menulist+=O
		else if(ext=="body") for(var/obj/armor/O in usr.contents) if(!O.suffix) menulist+=O
		else if(ext=="arms") for(var/obj/arm/O in usr.contents) if(!O.suffix) menulist+=O
		// Creating list in menu
		var/equipslot=0
		for(var/obj/O in menulist)
			equipslot++
			switch(equipslot)
				if(1){screen_invicon(2,9.5,0,8,,O.invicon,"equiplist");screen_textl(2.5,9,9.5,9.5,0,0,8,,O.name,"equiplist")}
				if(2){screen_invicon(10,9.5,0,8,,O.invicon,"equiplist");screen_textl(10.5,16,9.5,9.5,0,0,8,,O.name,"equiplist")}
				if(3){screen_invicon(2,8.5,0,8,,O.invicon,"equiplist");screen_textl(2.5,9,8.5,8.5,0,0,8,,O.name,"equiplist")}
				if(4){screen_invicon(10,8.5,0,8,,O.invicon,"equiplist");screen_textl(10.5,16,8.5,8.5,0,0,8,,O.name,"equiplist")}
				if(5){screen_invicon(2,7.5,0,8,,O.invicon,"equiplist");screen_textl(2.5,9,7.5,7.5,0,0,8,,O.name,"equiplist")}
				if(6){screen_invicon(10,7.5,0,8,,O.invicon,"equiplist");screen_textl(10.5,16,7.5,7.5,0,0,8,,O.name,"equiplist")}
				if(7){screen_invicon(2,6.5,0,8,,O.invicon,"equiplist");screen_textl(2.5,9,6.5,6.5,0,0,8,,O.name,"equiplist")}
				if(8){screen_invicon(10,6.5,0,8,,O.invicon,"equiplist");screen_textl(10.5,16,6.5,6.5,0,0,8,,O.name,"equiplist")}
				if(9){screen_invicon(2,5.5,0,8,,O.invicon,"equiplist");screen_textl(2.5,9,5.5,5.5,0,0,8,,O.name,"equiplist")}
				if(10){screen_invicon(10,5.5,0,8,,O.invicon,"equiplist");screen_textl(10.5,16,5.5,5.5,0,0,8,,O.name,"equiplist")}
		menupos=1
		curser.screen_loc="1,9:8"
	else if(screen=="status")
		inmenu="status"
		//status tab
		screen_background(12,17,15,17,0,0,8,"status")
		screen_portrait(12,15,16,16,9,icon,"status")
		screen_textl(14,17.5,16.5,16.5,0,0,9,," Status","status")
		//main stuff
		screen_background(1,17,1,16,0,16,7,"status")
		screen_textl(2,10.5,16,16,0,-6,8,,name,"status")
		screen_textl(3,8,15,15,0,-6,8,,class,"status")
		screen_textl(9,12,15,15,0,-6,8,,"Lv.[level]","status")
		screen_textl(3,8,14,14,0,-6,8,,"Both Hands","status")
		screen_textl(10,14,14,14,10,-6,8,,"Exp.","status")
		screen_textr(7,15,13.5,13.5,10,-8,8,,"[num2text(exp,10)]","status")
		screen_textl(10,17,12,12,10,0,8,,"For level up","status")
		if(level<99)
			screen_textr(7,15,11.5,11.5,10,2,8,,"[maxexp-exp]","status")
		if(level>=99)
			screen_textr(7,15,11.5,11.5,10,0,8,,"0","status")
		screen_textl(3,4,13,13,0,-8,8,,"HP","status")
		screen_textr(2,5,12.5,12.5,16,-10,8,,"[HP]","status")
		screen_textl(6,7,12.5,12.5,0,-10,8,,"/","status")
		screen_textr(6,8,12.5,12.5,0,-10,8,,"[MaxHP]","status")
		screen_textl(3,4,12,12,0,-12,8,,"MP","status")
		screen_textr(2,5,11.5,11.5,16,-14,8,,"[MP]","status")
		screen_textl(6,7,11.5,11.5,0,-14,8,,"/","status")
		screen_textr(6,8,11.5,11.5,0,-14,8,,"[MaxMP]","status")
		screen_textl(2,10,9,9,0,0,8,,"Ability","status")
		screen_textl(3,6,8,8,0,-8,8,,"Str.","status")
		screen_textl(6,7,8,8,-10,-8,8,,"�","status")
		screen_textr(6,7,8,8,0,-8,8,,"[min(str,99)]","status")
		screen_textl(3,6,7,7,0,-16,8,,"Agil.","status")
		screen_textl(6,7,7,7,-10,-16,8,,"�","status")
		screen_textr(6,7,7,7,0,-16,8,,"[min(agi,99)]","status")
		screen_textl(3,6,6,6,0,-24,8,,"Vit.","status")
		screen_textl(6,7,6,6,-10,-24,8,,"�","status")
		screen_textr(6,7,6,6,0,-24,8,,"[min(vit,99)]","status")
		screen_textl(3,6,4,4,0,0,8,,"Wis.","status")
		screen_textl(6,7,4,4,-10,0,8,,"�","status")
		screen_textr(6,7,4,4,0,0,8,,"[min(wis,99)]","status")
		screen_textl(3,6,3,3,0,-8,8,,"Will","status")
		screen_textl(6,7,3,3,-10,-8,8,,"�","status")
		screen_textr(6,7,3,3,0,-8,8,,"[min(wil,99)]","status")
		screen_textl(9,13,9,9,0,0,8,,"Attack","status")
		screen_textr(13,15,9,9,0,0,8,,"[xatt()]x �","status")
		screen_textr(15,16,9,9,16,0,8,,"[att()]","status")
		screen_textl(9,13,8,8,0,-8,8,,"Attack%","status")
		screen_textr(13,15,8,8,0,-8,8,,"�","status")
		screen_textr(15,16,8,8,16,-8,8,,"[attp()]%","status")
		screen_textl(9,13,7,7,0,-16,8,,"Defense","status")
		screen_textr(13,15,7,7,0,-16,8,,"[xdef()]x �","status")
		screen_textr(15,16,7,7,16,-16,8,,"[def()]","status")
		screen_textl(9,13,6,6,0,-24,8,,"Defense%","status")
		screen_textr(13,15,6,6,0,-24,8,,"�","status")
		screen_textr(15,16,6,6,16,-24,8,,"[defp()]%","status")
		screen_textl(9,13,4,4,0,0,8,,"Mag Def","status")
		screen_textr(13,15,4,4,0,0,8,,"[xmagdef()]x �","status")
		screen_textr(15,16,4,4,16,0,8,,"[magdef()]","status")
		screen_textl(9,13,3,3,0,-8,8,,"Mag Def%","status")
		screen_textr(13,15,3,3,0,-8,8,,"�","status")
		screen_textr(15,16,3,3,16,-8,8,,"[magdefp()]","status")


	else if(screen=="teleport")
		inmenu = "teleport"
		if(!ext)
			screen_background(3,9,6,12,0,0,8,"teleport")
			menulist = new()
			for(var/L in visited_location)
				var/area/saved_location/A = locate(L) in world
				menulist += A
				for(var/mob/PC/p in party) if(!p.visited_location.Find(A.type)){menulist -= A;break}
			if(!curser) curser = new(client)
			curser.screen_loc = "3,11:16"
			screen("teleport",1)
		else
			for(var/obj/onscreen/text/O in client.screen) if(O.screentag == "teleport") del(O)
			menuaction = ext
			var/i,Y,YO
			for(i = menuaction,i != (menuaction+6),i++)
				if(length(menulist) < i) break
				switch(i % 6)
					if(1){Y=11;YO=16}
					if(2){Y=10;YO=16}
					if(3){Y=9;YO=16}
					if(4){Y=8;YO=16}
					if(5){Y=7;YO=16}
					if(0){Y=6;YO=16}
				var/area/A = menulist[i]
				screen_textl(4,8,Y,Y,0,YO,9,0,A.desc,"teleport")
			if(menuaction>1) screen_textl(3.5,4,6,6,0,0,9,,"<","teleport")
			if(length(menulist)>=i) screen_textl(9,9.5,6,6,0,0,9,,">","teleport")

mob/PC/proc
	menu_target(direction)
		if(!direction)
			inmenu = "menu_target"
			//setting action
			if(menuaction == "item") btl_action = contents[menupos]
			else if(menuaction == "magic") btl_action = menulist[menupos]
			//creating default selection
			menulist = new()
			if(!btl_action.DType) menulist += src
			else for(var/mob/T in party) menulist += T
			menupos = party.Find(src)
		else switch(direction)
			if("N"){menupos--;if(menupos<1) menupos = length(menulist)}
			if("S"){menupos++;if(menupos>length(menulist)) menupos = 1}
			if("W","E")
				if(!btl_action.Target)
					if(menupos == "all") menupos = party.Find(src)
					else menupos = "all"
				else src<<SOUND_WRONG
			if("C")
				var/list/TargList = new()
				if(menupos == "all") for(var/mob/T in menulist) TargList += T
				else if(length(menulist) >= menupos) TargList += menulist[menupos]
				else src<<SOUND_WRONG
				if(menuaction == "item") item(TargList,btl_action)
				else if(menuaction == "magic"){magic(TargList,btl_action);if(!TargList.Find(src)) TargList += src}
				else close_allscreen()
				for(var/mob/T in TargList) screen("menu_srefresh",party.Find(T))
				return
		if(!length(menulist)) return //no one to target!
		//creating TargList
		var/list/C_List = new()
		if(menupos == "all") for(var/mob/T in menulist) C_List += T
		else
			if(length(menulist) >= menupos) C_List += menulist[menupos]
			else return
		for(var/obj/onscreen/curser/C in client.screen) del(C) //deleting all old cursers
		//creating new cursers
		for(var/mob/T in C_List)
			curser = new(client)
			switch(party.Find(T))
				if(1) curser.screen_loc="2,14:8"
				if(2) curser.screen_loc="2,11:16"
				if(3) curser.screen_loc="2,8:24"
				if(4) curser.screen_loc="2,6:0"
				if(5) curser.screen_loc="2,3:8"
	equip(var/where,var/obj/what)
		if(where=="rhand")
			if(istype(what,/obj/weapon)&&istype(lhand,/obj/weapon))
				if(istype(src,/mob/PC/ninja)||istype(src,/mob/PC/monk))
					if(class in what.equip)
						var/obj/old = rhand
						if(old) old.suffix=null
						what.suffix="Equipped"
						rhand=what
						close_screen("equiplist")
						screen("equiprefresh")
					else src<<SOUND_WRONG
					return
				else src<<SOUND_WRONG
				return
			else if(istype(what,/obj/weapon/Wrench)&&istype(lhand,/obj/shield)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Knife)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Sword)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Spear)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Katana)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Axe)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Claw)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Whip)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Wrench)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Harp)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Rod)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(lhand,/obj/weapon/Staff)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield)&&istype(lhand,/obj/weapon/Wrench)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Knife)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Sword)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Spear)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Katana)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Axe)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Claw)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Whip)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Wrench)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Harp)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Rod)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Staff)&&istype(lhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield)&&istype(lhand,/obj/shield)){src<<SOUND_WRONG;return}
			else
				if(class in what.equip)
					var/obj/old = rhand
					if(old) old.suffix=null
					what.suffix="Equipped"
					rhand=what
					close_screen("equiplist")
					screen("equiprefresh")
				else src<<SOUND_WRONG
				return
		else if(where=="lhand")
			if(istype(what,/obj/weapon)&&istype(rhand,/obj/weapon))
				if(istype(src,/mob/PC/ninja)||istype(src,/mob/PC/monk))
					if(class in what.equip)
						var/obj/old = lhand
						if(old) old.suffix=null
						what.suffix="Equipped"
						lhand=what
						close_screen("equiplist")
						screen("equiprefresh")
					else src<<SOUND_WRONG
					return
				else src<<SOUND_WRONG
				return
			else if(istype(what,/obj/weapon/Wrench)&&istype(rhand,/obj/shield)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Knife)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Sword)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Spear)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Katana)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Axe)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Claw)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Whip)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Wrench)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Harp)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Rod)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield/Arrow)&&istype(rhand,/obj/weapon/Staff)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield)&&istype(rhand,/obj/shield)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/shield)&&istype(rhand,/obj/weapon/Wrench)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Knife)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Sword)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Spear)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Katana)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Axe)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Claw)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Whip)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Wrench)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Harp)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Rod)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else if(istype(what,/obj/weapon/Staff)&&istype(rhand,/obj/shield/Arrow)){src<<SOUND_WRONG;return}
			else
				if(class in what.equip)
					var/obj/old = lhand
					if(old) old.suffix=null
					what.suffix="Equipped"
					lhand=what
					close_screen("equiplist")
					screen("equiprefresh")
				else src<<SOUND_WRONG
				return
		else if(where=="head")
			if(class in what.equip)
				var/obj/old = helmet
				if(old) old.suffix=null
				what.suffix="Equipped"
				helmet=what
				close_screen("equiplist")
				screen("equiprefresh")
			else src<<SOUND_WRONG
			return
		else if(where=="body")
			if(class in what.equip)
				var/obj/old = armor
				if(old) old.suffix=null
				what.suffix="Equipped"
				armor=what
				close_screen("equiplist")
				screen("equiprefresh")
			else src<<SOUND_WRONG
			return
		else if(where=="arms")
			if(class in what.equip)
				var/obj/old = arm
				if(old) old.suffix=null
				what.suffix="Equipped"
				arm=what
				close_screen("equiplist")
				screen("equiprefresh")
			else src<<SOUND_WRONG
			return
	unequip(var/where)
		if(where=="rhand")
			var/obj/what = rhand
			if(what) what.suffix=null
			rhand=null
			close_screen("equiplist")
			screen("equiprefresh")
			return
		else if(where=="lhand")
			var/obj/what = lhand
			if(what) what.suffix=null
			lhand=null
			close_screen("equiplist")
			screen("equiprefresh")
			return
		else if(where=="head")
			var/obj/what = helmet
			if(what) what.suffix=null
			helmet=null
			close_screen("equiplist")
			screen("equiprefresh")
			return
		else if(where=="body")
			var/obj/what = armor
			if(what) what.suffix=null
			armor=null
			close_screen("equiplist")
			screen("equiprefresh")
			return
		else if(where=="arms")
			var/obj/what = arm
			if(what) what.suffix=null
			arm=null
			close_screen("equiplist")
			screen("equiprefresh")
			return
	item(list/TargList,obj/Ability/I)
		for(var/mob/PC/p in TargList)
			p.HP+=I.HPHeal
			if(p.HP>p.MaxHP) p.HP=p.MaxHP
			p.MP+=I.MPHeal
			if(p.MP>p.MaxMP) p.MP=p.MaxMP
		if(I.Sound) src<<I.Sound
		var/numitem = text2num(I.suffix)
		numitem--
		if(numitem<1){del(I);client.Northwest()}
		else I.suffix="[numitem]"
	magic(list/TargList,obj/Ability/M)
		if(istype(M,/obj/Ability/ASkills/White/Teleport)){close_allscreen();screen("teleport");return}
		if(istype(M,/obj/Ability/ASkills/White_/Teleport)){close_allscreen();screen("teleport");return}
		if(M.MPCost>MP){src<<SOUND_WRONG;return}
		else MP-=M.MPCost
		var/xM
		if(M.Modifier) xM = wil
		else xM = wis
		var/Heal = round(((round(xM/8)+2) * (round(xM/2)+M.Damage)) / length(TargList))
		for(var/mob/PC/p in TargList){p.HP+=Heal;if(p.HP>p.MaxHP) p.HP=p.MaxHP}

