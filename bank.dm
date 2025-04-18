obj/NPC/FatChocobo
	name="FatChocobo"
	icon='mob/npc/fatchoco.dmi'
	FC_bl/icon_state="bl"
	FC_br/icon_state="br"
	FC_ul/icon_state="ul"
	FC_ur/icon_state="ur"

mob/PC/var/list/iteminbank = newlist()
mob/PC/proc/bank(var/action,var/obj/what)
	switch(action)
		if("item give")
			if(istype(what,/obj/Ability/Basic))
				var/obj/Ability/Basic/O = locate(what.type) in src.iteminbank
				if(O)
					if(text2num(O.suffix)>=max_grouped_item)
						inmenu="bank_message"
						for(var/obj/onscreen/text/S in client.screen) if(S.screentag=="bankmessage") del S
						screen_textl(3,16,15.5,15.5,0,0,5,,"I can't hold more.","bankmessage")
						spawn(20)
							for(var/obj/onscreen/text/S in client.screen) if(S.screentag=="bankmessage") del S
							screen_textl(3,16,15.5,15.5,0,0,5,,"Give what?","bankmessage")
							inmenu="bank_item"
						return
					else
						var/givenum = max_grouped_item - text2num(O.suffix)
						if(givenum>=text2num(what.suffix)){givenum = text2num(what.suffix);del(what)}
						if(what) what.suffix = "[(text2num(what.suffix)) - givenum]"
						O.suffix = "[(text2num(O.suffix)) + givenum]"
						goto End
			src.contents-=what
			iteminbank+=what
		if("item take")
			if(istype(what,/obj/Ability/Basic))
				var/obj/Ability/Basic/O = locate(what.type) in src.contents
				if(O)
					if(text2num(O.suffix)>=max_grouped_item)
						inmenu="bank_message"
						for(var/obj/onscreen/text/S in client.screen) if(S.screentag=="bankmessage") del S
						screen_textl(3,16,15.5,15.5,0,0,5,,"You can't hold more.","bankmessage")
						spawn(20)
							for(var/obj/onscreen/text/S in client.screen) if(S.screentag=="bankmessage") del S
							screen_textl(3,16,15.5,15.5,0,0,5,,"Give what?","bankmessage")
							inmenu="bank_item"
						return
					else
						var/takenum = max_grouped_item - text2num(O.suffix)
						if(takenum>=text2num(what.suffix)){takenum = text2num(what.suffix);del(what)}
						if(what) what.suffix = "[(text2num(what.suffix)) - takenum]"
						O.suffix = "[(text2num(O.suffix)) + takenum]"
						goto End
			src.iteminbank-=what
			src.contents+=what
		if("gold give"){src.gold-=what;src.goldinbank+=what}
		if("gold take"){src.goldinbank-=what;src.gold+=what}
	End
	if(action=="item give"||action=="item take")
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="bank_item") del O
		for(var/obj/onscreen/invicon/O in client.screen) if(O.screentag=="bank_item") del O
		bank_screen("bankaction",action)
	else
		close_screen("bank_gold")
		close_screen("bank_gold_numbox")
		menuaction="gold"
		inmenu="bankaction"
		menupos=1
		cursor.screen_loc="2,13:8"
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="bankmessage") del O
		screen_textl(3,16,15.5,15.5,0,0,5,,"What do you want?","bankmessage")

mob/PC/proc/bank_screen(var/screen,var/ext)
	if(screen=="bank")
		inmenu="bank"
		//message panel
		screen_background(2,16,15,16,0,0,4,"bankmessage")
		screen_textl(3,16,15.5,15.5,0,0,5,,"What do you want?","bankmessage")
		//selection panel
		screen_background(2,9,13,14,0,0,4,"bank")
		screen_textl(3,5,13.5,13.5,0,0,5,,"Item","bank")
		screen_textl(6.5,8.5,13.5,13.5,0,0,5,,"Gold","bank")
		menupos=1
		cursor=new(client)
		cursor.screen_loc="2,13:8"
	else if((screen=="bankaction")&&(ext=="item"||ext=="gold"))
		inmenu="bankaction"
		menuaction=ext
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="bank") del O
		screen_textl(3,5,13.5,13.5,0,0,5,,"Give","bankaction")
		screen_textl(6.5,8.5,13.5,13.5,0,0,5,,"Take","bankaction")
		menupos=1
		cursor.screen_loc="2,13:8"
	else if((screen=="bankaction")&&(ext=="item give")||(ext=="item take"))
		if(inmenu!="bank_item")
			screen_background(2,16,2,12,0,0,4,"bank_item")
			inmenu="bank_item"
			menuaction=ext
			// Associating list source
			menulist = new()
			var/prefix
			if(ext=="item give"){menulist=src.contents;prefix="Give"}
			else {menulist=src.iteminbank;prefix="Take"}
			// Message box
			for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="bankmessage") del O
			screen_textl(3,16,15.5,15.5,0,0,5,,"[prefix] what?","bankmessage")
			menupos=1
			cursor.screen_loc="2,11:8"
		// Creating list in menu
		var/itemslot=0
		for(var/obj/O in menulist)
			itemslot++
			switch(itemslot)
				if(1)
					screen_invicon(3,11.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,11.5,11.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,11.5,11.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,11.5,11.5,0,0,5,,O.suffix,"bank_item")
				if(2)
					screen_invicon(10,11.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,11.5,11.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,11.5,11.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,11.5,11.5,0,0,5,,O.suffix,"bank_item")
				if(3)
					screen_invicon(3,10.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,10.5,10.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,10.5,10.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,10.5,10.5,0,0,5,,O.suffix,"bank_item")
				if(4)
					screen_invicon(10,10.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,10.5,10.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,10.5,10.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,10.5,10.5,0,0,5,,O.suffix,"bank_item")
				if(5)
					screen_invicon(3,9.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,9.5,9.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,9.5,9.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,9.5,9.5,0,0,5,,O.suffix,"bank_item")
				if(6)
					screen_invicon(10,9.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,9.5,9.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,9.5,9.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,9.5,9.5,0,0,5,,O.suffix,"bank_item")
				if(7)
					screen_invicon(3,8.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,8.5,8.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,8.5,8.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,8.5,8.5,0,0,5,,O.suffix,"bank_item")
				if(8)
					screen_invicon(10,8.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,8.5,8.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,8.5,8.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,8.5,8.5,0,0,5,,O.suffix,"bank_item")
				if(9)
					screen_invicon(3,7.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,7.5,7.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,7.5,7.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,7.5,7.5,0,0,5,,O.suffix,"bank_item")
				if(10)
					screen_invicon(10,7.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,7.5,7.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,7.5,7.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,7.5,7.5,0,0,5,,O.suffix,"bank_item")
				if(11)
					screen_invicon(3,6.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,6.5,6.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,6.5,6.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,6.5,6.5,0,0,5,,O.suffix,"bank_item")
				if(12)
					screen_invicon(10,6.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,6.5,6.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,6.5,6.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,6.5,6.5,0,0,5,,O.suffix,"bank_item")
				if(13)
					screen_invicon(3,5.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,5.5,5.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,5.5,5.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,5.5,5.5,0,0,5,,O.suffix,"bank_item")
				if(14)
					screen_invicon(10,5.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,5.5,5.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,5.5,5.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,5.5,5.5,0,0,5,,O.suffix,"bank_item")
				if(15)
					screen_invicon(3,4.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,4.5,4.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,4.5,4.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,4.5,4.5,0,0,5,,O.suffix,"bank_item")
				if(16)
					screen_invicon(10,4.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,4.5,4.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,4.5,4.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,4.5,4.5,0,0,5,,O.suffix,"bank_item")
				if(17)
					screen_invicon(3,3.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,3.5,3.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,3.5,3.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,3.5,3.5,0,0,5,,O.suffix,"bank_item")
				if(18)
					screen_invicon(10,3.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,3.5,3.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,3.5,3.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,3.5,3.5,0,0,5,,O.suffix,"bank_item")
				if(19)
					screen_invicon(3,2.5,0,5,,O.invicon,"bank_item")
					screen_textl(3.5,7.5,2.5,2.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(7.5,8,2.5,2.5,0,0,5,,":","bank_item")
						screen_textr(7.5,8.5,2.5,2.5,0,0,5,,O.suffix,"bank_item")
				if(20)
					screen_invicon(10,2.5,0,5,,O.invicon,"bank_item")
					screen_textl(10.5,14.5,2.5,2.5,0,0,5,,O.name,"bank_item")
					if(istype(O,/obj/Ability/Basic))
						screen_textl(14.5,15,2.5,2.5,0,0,5,,":","bank_item")
						screen_textr(14.5,15.5,2.5,2.5,0,0,5,,O.suffix,"bank_item")
	else if((screen=="bankaction")&&(ext=="gold give")||(ext=="gold take"))
		inmenu="bank_gold"
		menuaction=ext
		input_box=0
		var/prefix,gpbox
		if(ext=="gold give"){prefix="Give";gpbox=gold}
		else {prefix="Take";gpbox=goldinbank}
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="bankmessage") del O
		screen_textl(3,16,15.5,15.5,0,0,5,,"[prefix] how much?","bankmessage")
		screen_background(10,16,13,14,0,0,4,"bank_gold")
		screen_textr(10.5,16,13.5,13.5,0,0,5,,"[num2text(gpbox,10)]GP","bank_gold")
		screen_background(6,11,11,12,0,0,4,"bank_gold_numbox")
		screen_textr(6.5,11,11.5,11.5,0,0,5,,"0GP","bank_gold_numbox")
		menupos=1
		cursor.screen_loc="6,11:8"
	else if(screen=="bank_gold_refresh")
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="bank_gold_numbox") del(O)
		screen_textr(6.5,11,11.5,11.5,0,0,5,,"[num2text(input_box,10)]GP","bank_gold_numbox")