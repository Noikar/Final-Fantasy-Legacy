var/const/dmgnum_time=20
mob/var/tmp
	inmenu
	menuaction
	menuanswer
	menupos=1
	input_box=0
	sleep_in_message
	list/menulist = new()
	list/text_list = new()
	obj/onscreen/cursor/cursor

mob/proc
	//common proc
	screen_dialog(text,screen,refresh,quick)
		if(!screen) screen="message"
		if(!refresh) screen_background(2,16,12,16,0,0,10,screen)
		screen_npctext(3,15.5,15,12,0,16,11,text,screen,quick)
	screen_yesno(var/screen)
		while(text_list) sleep(5)
		inmenu="yesno"
		screen_background(2,5,9,11,0,0,10,"yesno")
		screen_textl(3,5.5,10.5,10.5,0,0,11,,"Yes","yesno")
		screen_textl(3,5.5,9.5,9.5,0,0,11,,"No","yesno")
		menuanswer=0
		menupos=1
		cursor=new(client)
		cursor.screen_loc="2,10:8"
		while(!menuanswer) sleep(5)
		close_screen("yesno")
		del(cursor)
		inmenu=screen
		if(menuanswer==1) return 1
		else return 0
	//close proc
	close_allscreen()
		if(!client) return
		for(var/obj/onscreen/O in client.screen) del O
		menulist = list()
		inmenu = null
		menupos = 1
	close_screen(var/screentag)
		for(var/obj/onscreen/O in client.screen) if(O.screentag == screentag) del O
	//listing proc
	screentext2listl(var/text)
		var/list/textlist = new()
		for(var/a=1,a<=length(text),a++) textlist+=copytext(text,a,a+1)
		return textlist
	//menu creation proc
	screen_background(XC1,XC2,YC1,YC2,XO,YO,layr,screentag)
		for(var/XC=XC1,XC<=XC2,XC++)
			for(var/YC=YC1,YC<=YC2,YC++)
				var/obj/onscreen/back/BG=new(client,layr,screentag)
				if(XC==XC1) BG.icon_state="l"
				else if(XC==XC2) BG.icon_state="r"
				else if(YC==YC1) BG.icon_state="b"
				else if(YC==YC2) BG.icon_state="t"
				if(XC==XC1&&YC==YC1) BG.icon_state="ll"
				else if(XC==XC2&&YC==YC2) BG.icon_state="ur"
				else if(XC==XC1&&YC==YC2) BG.icon_state="ul"
				else if(XC==XC2&&YC==YC1) BG.icon_state="lr"
				BG.screen_loc="[XC]:[XO],[YC]:[YO]"
	screen_sbackground(XC1,YC1,XC2,YC2,layr,screentag)
		for(var/XC=XC1,XC<=XC2,XC++)
			for(var/YC=YC1,YC<=YC2,YC++)
				var/obj/onscreen/sback/BG=new(client,layr,screentag)
				if(YC==YC1) BG.icon_state="l"
				else if(YC==YC2) BG.icon_state="u"
				if(XC==XC1&&YC==YC1) BG.icon_state="ll"
				else if(XC==XC2&&YC==YC2) BG.icon_state="ur"
				else if(XC==XC1&&YC==YC2) BG.icon_state="ul"
				else if(XC==XC2&&YC==YC1) BG.icon_state="lr"
				BG.screen_loc="[XC],[YC]"
	screen_portrait(var/XC,YC,XO,YO,layr,portrait,screentag)
		var/obj/onscreen/portrait/T1=new(client,layr,screentag)
		var/obj/onscreen/portrait/T2=new(client,layr,screentag)
		var/obj/onscreen/portrait/T3=new(client,layr,screentag)
		var/obj/onscreen/portrait/T4=new(client,layr,screentag)
		T1.screen_loc="[XC]:[XO],[YC]:[YO]";T1.icon=portrait;T1.icon_state="portrait1"
		T2.screen_loc="[XC]:[XO],[YC+1]:[YO]";T2.icon=portrait;T2.icon_state="portrait2"
		T3.screen_loc="[XC+1]:[XO],[YC]:[YO]";T3.icon=portrait;T3.icon_state="portrait3"
		T4.screen_loc="[XC+1]:[XO],[YC+1]:[YO]";T4.icon=portrait;T4.icon_state="portrait4"
	screen_picon(var/XC,YC,XO,YO,layr,color,playericon,screentag)
		var/obj/onscreen/playericon/T1=new(client,layr,screentag)
		T1.screen_loc="[XC]:[XO],[YC]:[YO]";T1.icon=playericon;T1.icon_state="normal"
		if(color==1)T1.icon-=rgb(255,255,255)
	screen_player(var/XC,YC,XO,YO,layr,player,iconstate,screentag)
		var/obj/onscreen/player/T1=new(client,layr,screentag)
		var/obj/onscreen/player/T2=new(client,layr,screentag)
		var/obj/onscreen/player/T3=new(client,layr,screentag)
		var/obj/onscreen/player/T4=new(client,layr,screentag)
		T1.screen_loc="[XC]:[XO],[YC]:[YO]";T1.icon=player;T1.icon_state=iconstate+"1"
		T2.screen_loc="[XC]:[XO],[YC+1]:[YO]";T2.icon=player;T2.icon_state=iconstate+"2"
		T3.screen_loc="[XC-1]:[XO],[YC]:[YO]";T3.icon=player;T3.icon_state=iconstate+"3"
		T4.screen_loc="[XC-1]:[XO],[YC+1]:[YO]";T4.icon=player;T4.icon_state=iconstate+"4"
	screen_invicon(var/XC,YC,YO,layr,color,invicon,screentag)
		var/obj/onscreen/invicon/T=new(client,layr,screentag)
		if(XC==round(XC)&&YC==round(YC)) T.screen_loc="[XC],[YC]:[YO]"
		else if(XC!=round(XC)&&YC==round(YC)) T.screen_loc="[XC-0.5]:16,[YC]:[YO]"
		else if(XC==round(XC)&&YC!=round(YC)) T.screen_loc="[XC],[YC-0.5]:[16+YO]"
		else if(XC!=round(XC)&&YC!=round(YC)) T.screen_loc="[XC-0.5]:16,[YC-0.5]:[16+YO]"
		if(color==1){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(248,216,0));T.icon=I}
		else if(color==2){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(120,120,120));I.SwapColor(rgb(112,112,112),rgb(64,64,64));T.icon=I}
		T.icon_state=invicon
	screen_npctext(XC1,XC2,YC1,YC2,XO,YO,layr,text,screentag,quick)
		for(var/obj/onscreen/text/O in client.screen) if(O.screentag==screentag) del(O)
		if(text) text_list = screentext2listl(text)
		else if(text_list) for(var/L in text_list) text+=L
		else return //nothing to display
		var
			XC=XC1
			YC=YC1
		if(!quick) sleep_in_message = 1
		var/C=1
		for(C,C<=length(text_list),C++)
			//spacin', paragraph..
			if(text_list[C]==ascii2text(35)){XC=XC1;YC-=1;continue}
			else if(text_list[C]==ascii2text(32))	//a space
				//do we have enough place for the next word? looking for '#' or ' '. x_x
				var/space_left = (((XC2-XC1)-(XC-XC1))*2)
				if(length(copytext(text,C+1,findtext(text,ascii2text(32),C+1,0)))>space_left&&length(copytext(text,C+1,findtext(text,ascii2text(35),C+1,0)))>space_left){XC=XC1;YC-=1;continue}
				if(XC==XC1) continue //is it the beginning of a line? x_x
			//paragraph
			if(XC>XC2){XC=XC1;YC-=1}
			if(YC<YC2)
				text_list.Cut(1,C)
				var/obj/onscreen/text/N = new(client,layr,screentag)
				N.screen_loc="16,12"
				N.icon_state=ascii2text(62)
				sleep_in_message = 0
				return
			//creating the obj/icon
			var/obj/onscreen/text/T = new(client,layr,screentag)
			if(XC==round(XC)&&YC==round(YC)) T.screen_loc="[XC]:[XO],[YC]:[YO]"
			else if(XC!=round(XC)&&YC==round(YC)) T.screen_loc="[XC-0.5]:[16+XO],[YC]:[YO]"
			else if(XC==round(XC)&&YC!=round(YC)) T.screen_loc="[XC]:[XO],[YC-0.5]:[16+YO]"
			else if(XC!=round(XC)&&YC!=round(YC)) T.screen_loc="[XC-0.5]:[16+XO],[YC-0.5]:[16+YO]"
			T.icon_state = text_list[C]
			//end of creation
			if(sleep_in_message) sleep(1)
			XC+=0.5
		text_list = null
		sleep_in_message = 0
	screen_textl(var/XC1,XC2,YC1,YC2,XO,YO,layr,color,text,screentag)
		var XC=XC1,YC=YC1
		for(var/i=1,i<=length(text),i++)
			var/C = copytext(text,i,i+1)
			if(C==ascii2text(35)){XC=XC1;YC-=0.5;continue}
			var/obj/onscreen/text/T=new(client,layr,screentag)
			if(XC==round(XC)&&YC==round(YC)) T.screen_loc="[XC]:[XO],[YC]:[YO]"
			else if(XC!=round(XC)&&YC==round(YC)) T.screen_loc="[XC-0.5]:[XO+16],[YC]:[YO]"
			else if(XC==round(XC)&&YC!=round(YC)) T.screen_loc="[XC]:[XO],[YC-0.5]:[16+YO]"
			else if(XC!=round(XC)&&YC!=round(YC)) T.screen_loc="[XC-0.5]:[XO+16],[YC-0.5]:[16+YO]"
			if(color==1){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(248,216,0));T.icon=I}
			else if(color==2){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(120,120,120));T.icon=I}
			T.icon_state="[C]"
			XC+=0.5
			if(XC>=XC2){XC=XC1;YC-=0.5}
			if(YC<=YC2-0.5) break
	screen_textr(var/XC1,XC2,YC1,YC2,XO,YO,layr,color,text,screentag)
		var XC=XC2,YC=YC2
		for(var/i=length(text),i>=1,i--)
			var/C = copytext(text,i,i+1)
			if(C==ascii2text(35)){XC=XC2;YC+=0.5;continue}
			var/obj/onscreen/text/T=new(client,layr,screentag)
			if(XC==round(XC)&&YC==round(YC)) T.screen_loc="[XC]:[XO],[YC]:[YO]"
			else if(XC!=round(XC)&&YC==round(YC)) T.screen_loc="[XC-0.5]:[XO+16],[YC]:[YO]"
			else if(XC==round(XC)&&YC!=round(YC)) T.screen_loc="[XC]:[XO],[YC-0.5]:[16+YO]"
			else if(XC!=round(XC)&&YC!=round(YC)) T.screen_loc="[XC-0.5]:[XO+16],[YC-0.5]:[16+YO]"
			if(color==1){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(248,216,0));T.icon=I}
			else if(color==2){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(120,120,120));T.icon=I}
			T.icon_state="[C]"
			XC-=0.5
			if(XC<=XC1){XC=XC2;YC+=0.5}
			if(YC>=YC1+0.5) break
		//onmap stuff
	map_textl(var/XC1,XC2,YC1,YC2,YO,layr,color,text,screentag)
		var XC=XC1,YC=YC1
		for(var/i=1,i<=length(text),i++)
			var/C = copytext(text,i,i+1)
			if(C==ascii2text(35)){XC=XC1;YC-=0.5;continue}
			var/obj/onscreen/text/T=new(client,layr,screentag)
			if(XC==round(XC)&&YC==round(YC)) T.screen_loc="[XC],[YC]:[YO]"
			else if(XC!=round(XC)&&YC==round(YC)) T.screen_loc="[XC-0.5]:16,[YC]:[YO]"
			else if(XC==round(XC)&&YC!=round(YC)) T.screen_loc="[XC],[YC-0.5]:[16+YO]"
			else if(XC!=round(XC)&&YC!=round(YC)) T.screen_loc="[XC-0.5]:16,[YC-0.5]:[16+YO]"
			if(color==1){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(248,216,0));T.icon=I}
			else if(color==2){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(120,120,120));T.icon=I}
			T.icon_state="[C]"
			XC+=0.5
			if(XC>=XC2){XC=XC1;YC-=0.5}
			if(YC<=YC2-0.5) break
	map_textc(var/XC1,XC2,YC1,YC2,YO,layr,color,text,screentag)
		var XC=XC1,YC=YC1
		for(var/i=1,i<=length(text),i++)
			var/C = copytext(text,i,i+1)
			if(C==ascii2text(35)){XC=XC1;YC-=0.5;continue}
			var/obj/onscreen/text/T=new(client,layr,screentag)
			if(XC==round(XC)&&YC==round(YC)) T.screen_loc="[XC],[YC]:[YO]"
			else if(XC!=round(XC)&&YC==round(YC)) T.screen_loc="[XC-0.5]:16,[YC]:[YO]"
			else if(XC==round(XC)&&YC!=round(YC)) T.screen_loc="[XC],[YC-0.5]:[16+YO]"
			else if(XC!=round(XC)&&YC!=round(YC)) T.screen_loc="[XC-0.5]:16,[YC-0.5]:[16+YO]"
			if(color==1){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(248,216,0));T.icon=I}
			else if(color==2){var/icon/I = new(T.icon);I.SwapColor(rgb(248,248,248),rgb(120,120,120));T.icon=I}
			T.icon_state="[C]"
			XC+=0.5
			if(XC>=XC2){XC=XC1;YC-=0.5}
			if(YC<=YC2-0.5) break

proc
	disp_dmg(var/mob/Target,DmgNum)
		var/turf/battle/location/BLoc = locate(/turf/battle/location/) in view(src)
		for(var/obj/onmap/dmgnum/O in view(BLoc)) if(O.screentag==Target) del(O)
		var/DmgPos = 0
		var/DmgPosX = Target.x
		var/DmgPosY = Target.y
		if(istype(Target,/mob/monster))
			var/mob/monster/T = Target
			DmgPosX += round((T.monster_x_start + T.monster_x_end) / 2)
			DmgPosY = DmgPosY + T.monster_y_start
			DmgPos = abs(((T.monster_x_start + T.monster_x_end) / 2) * 32) % 32
		if(DmgNum=="miss")
			var/obj/onmap/dmgnum/D=new(locate(DmgPosX,DmgPosY,Target.z))
			D.pixel_x = DmgPos
			D.icon_state="[DmgNum]"
			D.screentag=Target
		else
			var/color=0
			if(text2num(DmgNum)!=abs(text2num(DmgNum))){color=1;DmgNum=num2text(abs(text2num(DmgNum)))}
			if(length(DmgNum) == 1){DmgPos+=16;if(DmgPos>16){DmgPosX++;DmgPos=0}}
			else if(length(DmgNum) == 4){DmgPos-=16;if(DmgPos<0){DmgPosX--;DmgPos=16}}
			for(var/i=1,i<=length(DmgNum),i++)
				var/obj/onmap/dmgnum/D=new(locate(DmgPosX,DmgPosY,Target.z))
				if(color){var/icon/I = new(D.icon);I.SwapColor(rgb(248,248,248),rgb(48,248,48));D.icon=I}
				D.pixel_x = DmgPos
				D.icon_state="[copytext(DmgNum,i,i+1)]"
				D.screentag=Target
				if(DmgPos){DmgPosX++;DmgPos=0}
				else DmgPos=16
		spawn(dmgnum_time) for(var/obj/onmap/dmgnum/O in view(BLoc)) if(O.screentag==Target) del(O)

obj/onscreen
	var/screentag
	back
		icon='screen/back.dmi'
		layer=MOB_LAYER+4
	sback
		icon='screen/sback.dmi'
		layer=MOB_LAYER+4
	text
		icon='screen/text.dmi'
		layer=MOB_LAYER+5
	invicon
		icon='screen/invicon.dmi'
		layer=MOB_LAYER+5
	portrait
		layer=MOB_LAYER+5
	player
		layer=MOB_LAYER+5
	playericon
		layer=MOB_LAYER+5
	cursor
		icon='screen/cursor.dmi'
		layer=MOB_LAYER+10
	New(client/C,layr,stag)
		C.screen+=src
		if(layr) layer = MOB_LAYER+layr
		if(stag) screentag = stag
		..()

obj/onmap
	var/screentag
	back
		icon='screen/back.dmi'
		layer=MOB_LAYER+4
	text
		icon='screen/text.dmi'
		layer=MOB_LAYER+5
	dmgnum
		icon='screen/dmgnum.dmi'
		layer=MOB_LAYER+5