// world var/proc for race
//wait time between races in ticks (600 = 60sec/1min)
var/const/race_wait_time = 300
//max_racers by races
var/const/max_racers = 5
//race cost
var/const/race_cost = 200
//min/max point by stat
var/const/min_accel = 6
var/const/max_accel = 16
var/const/min_speed = 10
var/const/max_speed = 24
var/const/min_turn = 5
var/const/max_turn = 12
//when a player buy a seed, divide those 'max_stat' by the number of
//seed you want them to buy in order to reach the max_stat
var/const/chocobo_stat_divider=40
//point needed for each rank
var/const/SS_rank = 52
var/const/S_rank = 44
var/const/A_rank = 36
var/const/B_rank = 28
// race area, controlling the race
area/misc
	race_area
		var
			list/race_racers = new()//do not mofify
			race_owner=0						//which announcers take care of that race
			race_status=0						//do not modify
			race_type								//race area, based on chocobo's stats
			race_lap								//how much lap the race has
	chocobo_race_exit
	chocobo_race
		var
			chktype
			chkpoint
		Exit(mob/PC/p)
			if(chktype&&chkpoint==p.chkpt)
				var/area/misc/race_area/l = locate(/area/misc/race_area/) in view()
				p.chkpt=0
				if(l.race_lap == p.lap)
					p.lap=1
					p.close_screen("chocobo_race_lap")
					p.close_screen("chocobo_race_chkpt")
					p<<"Won the race, and [length(l.race_racers)*race_cost] GP!"
					p.gold+=(length(l.race_racers)*race_cost)
					if(p.gold>9999999) p.gold = 9999999
					//waiting 3 seconds
					spawn(30)
						for(var/mob/PC/P in l.race_racers)
							P.close_allscreen()
							chocobo_race_leave(P)
						//clearing race's old settings.
						l.race_racers = null
						l.race_status=0
				else
					p.lap++
					p.chocobo_race_screen("chocobo_race_lap")
					p.chocobo_race_screen("chocobo_race_chkpt")
			else if(chkpoint==(p.chkpt+1))
				p.chkpt=chkpoint
				p.chocobo_race_screen("chocobo_race_chkpt")
			return ..()

obj/NPC/race_announcer
	interact_dist = 2
	var/race_owner=0

mob/PC
	var
		//initial = 6/10/5	-- max should be around = 16/24/12
		acceleration=6
		top_speed=10
		turning=5
	var/tmp
		area/misc/race_area/inrace
		lap=1
		chkpt=0
		pixelx
		pixely
		direction=180
		current_speed=0
	proc
		race()
			if(!inrace) return
			if(round(direction)<=0) direction = 360
			else if(round(direction)>=360) direction = 0
			control(round(direction))
			spawn(1) race()
		race_icon(var/angle)
			var/speed
			if(current_speed>=((max_speed/4)*3)) speed = "fast"
			else if(current_speed>=(max_speed/2)) speed = "med"
			else if(current_speed>0) speed = "slow"
			if(icon_state!="[speed][angle]") icon_state="[speed][angle]"
		chocobo_buy(var/buy)
			switch(buy)
				if(0) return //bought a chocobo -- 2500GP.
				if(1)
					if(gold<350) chocobo_race_screen("chocobo_race_menu_error","You do not have|enough GP.")
					else
						gold-=350
						top_speed+=((max_speed-min_speed)/chocobo_stat_divider)
						if(top_speed>=max_speed)
							top_speed = max_speed
							chocobo_race_screen("chocobo_race_menu_error","You don't see any|change on your|chocobo.")
				if(2)
					if(gold<350) chocobo_race_screen("chocobo_race_menu_error","You do not have|enough GP.")
					else
						gold-=350
						acceleration+=((max_accel-min_accel)/chocobo_stat_divider)
						if(acceleration>=max_accel)
							acceleration = max_accel
							chocobo_race_screen("chocobo_race_menu_error","You don't see any|change on your|chocobo.")
				if(3)
					if(gold<350) chocobo_race_screen("chocobo_race_menu_error","You do not have|enough GP.")
					else
						gold-=350
						turning+=((max_turn-min_turn)/chocobo_stat_divider)
						if(turning>=max_turn)
							turning = max_turn
							chocobo_race_screen("chocobo_race_menu_error","You don't see any|change on your|chocobo.")
				if(4)
					if(gold<450) chocobo_race_screen("chocobo_race_menu_error","You do not have|enough GP.")
					else
						gold-=450
						top_speed+=((max_speed-min_speed)/(chocobo_stat_divider*2))
						acceleration+=((max_accel-min_accel)/(chocobo_stat_divider*2))
						turning+=((max_turn-min_turn)/(chocobo_stat_divider*2))
						if(top_speed>=max_speed) top_speed = max_speed
						if(acceleration>=max_accel) acceleration = max_accel
						if(turning>=max_turn) turning = max_turn
						if(top_speed>=max_speed&&acceleration>=max_accel&&turning>=max_turn)
							chocobo_race_screen("chocobo_race_menu_error","You don't see any|change on your|chocobo.")
				if(5)
					if(gold<800) chocobo_race_screen("chocobo_race_menu_error","You do not have|enough GP.")
					else
						gold-=800
						top_speed+=((max_speed-min_speed)/chocobo_stat_divider)
						acceleration+=((max_accel-min_accel)/chocobo_stat_divider)
						turning+=((max_turn-min_turn)/chocobo_stat_divider)
						if(top_speed>=max_speed) top_speed = max_speed
						if(acceleration>=max_accel) acceleration = max_accel
						if(turning>=max_turn) turning = max_turn
						if(top_speed>=max_speed&&acceleration>=max_accel&&turning>=max_turn)
							chocobo_race_screen("chocobo_race_menu_error","You don't see any|change on your|chocobo.")
			//refreshing gold panel
			for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="chocobo_race_menu_gold") del(O)
			screen_textr(11.5,15.5,3.5,3.5,0,0,5,,"[num2text(gold,10)]","chocobo_race_menu_gold")
			screen_textl(15,16,2.5,2.5,0,0,5,,"GP","chocobo_race_menu_gold")
		chocobo_rank()
			var/rank = acceleration + top_speed + turning
			if(rank>=SS_rank) return "SS"
			else if(rank>=S_rank) return "S"
			else if(rank>=A_rank) return "A"
			else if(rank>=B_rank) return "B"
			else return "C"
		control(var/angle)
			if(!inrace) return
			switch(angle)
				//NW
				if(8 to 22)
					var/atom/N = locate(x,y+1,z)
					var/atom/W = locate(x-1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/6
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/6*5
					//race_icon(15)
				if(23 to 37)
					var/atom/N = locate(x,y+1,z)
					var/atom/W = locate(x-1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/6*2
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/6*4
					race_icon(30)
				if(38 to 52)
					var/atom/N = locate(x,y+1,z)
					var/atom/W = locate(x-1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/2
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/2
					//race_icon(45)
				if(53 to 67)
					var/atom/N = locate(x,y+1,z)
					var/atom/W = locate(x-1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/6*4
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/6*2
					race_icon(60)
				if(68 to 82)
					var/atom/N = locate(x,y+1,z)
					var/atom/W = locate(x-1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/6*5
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/6
					//race_icon(75)
				if(83 to 97) //NORTH
					var/atom/N = locate(x,y+1,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed
					race_icon(90)
				//NE
				if(98 to 112)
					var/atom/N = locate(x,y+1,z)
					var/atom/E = locate(x+1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/6*5
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/6
					//race_icon(105)
				if(113 to 127)
					var/atom/N = locate(x,y+1,z)
					var/atom/E = locate(x+1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/6*4
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/6*2
					race_icon(120)
				if(128 to 142)
					var/atom/N = locate(x,y+1,z)
					var/atom/E = locate(x+1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/2
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/2
					//race_icon(135)
				if(143 to 157)
					var/atom/N = locate(x,y+1,z)
					var/atom/E = locate(x+1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/6*2
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/6*4
					race_icon(150)
				if(158 to 172)
					var/atom/N = locate(x,y+1,z)
					var/atom/E = locate(x+1,y,z)
					if(N.density&&pixely>=0) pixely=0
					else pixely+=current_speed/6
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/6*5
					//race_icon(165)
				if(173 to 187) //EAST
					var/atom/E = locate(x+1,y,z)
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed
					race_icon(180)
				//SE
				if(188 to 202)
					var/atom/S = locate(x,y-1,z)
					var/atom/E = locate(x+1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/6
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/6*5
					//race_icon(195)
				if(203 to 217)
					var/atom/S = locate(x,y-1,z)
					var/atom/E = locate(x+1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/6*2
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/6*4
					race_icon(210)
				if(218 to 232)
					var/atom/S = locate(x,y-1,z)
					var/atom/E = locate(x+1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/2
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/2
					//race_icon(225)
				if(233 to 247)
					var/atom/S = locate(x,y-1,z)
					var/atom/E = locate(x+1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/6*4
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/6*2
					race_icon(240)
				if(248 to 262)
					var/atom/S = locate(x,y-1,z)
					var/atom/E = locate(x+1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/6*5
					if(E.density&&pixelx>=0) pixelx=0
					else pixelx+=current_speed/6
					//race_icon(255)
				if(263 to 277) //SOUTH
					var/atom/S = locate(x,y-1,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed
					race_icon(270)
				//SW
				if(278 to 292)
					var/atom/S = locate(x,y-1,z)
					var/atom/W = locate(x-1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/6*5
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/6
					//race_icon(285)
				if(293 to 307)
					var/atom/S = locate(x,y-1,z)
					var/atom/W = locate(x-1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/6*4
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/6*2
					race_icon(300)
				if(308 to 322)
					var/atom/S = locate(x,y-1,z)
					var/atom/W = locate(x-1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/2
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/2
					//race_icon(315)
				if(323 to 337)
					var/atom/S = locate(x,y-1,z)
					var/atom/W = locate(x-1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/6*2
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/6*4
					race_icon(330)
				if(338 to 352)
					var/atom/S = locate(x,y-1,z)
					var/atom/W = locate(x-1,y,z)
					if(S.density&&pixely<=0) pixely=0
					else pixely-=current_speed/6
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed/6*5
					//race_icon(345)
				else //WEST
					var/atom/W = locate(x-1,y,z)
					if(W.density&&pixelx<=0) pixelx=0
					else pixelx-=current_speed
					race_icon(0)
				// END
			// proceeding to the 'real' movement.
			if(round(pixelx)>=32){step(src,EAST);pixelx-=32}
			else if(round(pixelx)<=-32){step(src,WEST);pixelx+=32}
			if(round(pixely)>=32){step(src,NORTH);pixely-=32}
			else if(round(pixely)<=-32){step(src,SOUTH);pixely+=32}
			// proceeding to the 'fake' movement.
			pixel_x = round(pixelx)
			pixel_y = round(pixely)

// chocobo race proc
mob/PC/proc/chocobo_race_screen(var/screen,var/message)
	switch(screen)
		if("chocobo_race_menu")
			inmenu="chocobo_race_menu"
			//create a nice looking window
			screen_background(4,14,10,16,0,0,4,"chocobo_race_menu")
			// with text
			screen_textl(4.5,14,15.5,13.5,0,0,5,0,"Welcome!##Want to race?","chocobo_race_menu")
			// and options
			screen_textl(5.5,14,12.5,12.5,0,0,5,0,"Register to race","chocobo_race_menu")
			screen_textl(5.5,14,11.5,11.5,0,0,5,0,"Feed my chocobo","chocobo_race_menu")
			screen_textl(5.5,14,10.5,10.5,0,0,5,0,"Nothing","chocobo_race_menu")
			menupos=1
			cursor = new(client)
			cursor.screen_loc="4:16,12:8"
			//gold panel
			screen_background(11,16,2,4,0,0,4,"chocobo_race_menu_gold")
			screen_textr(11.5,15.5,3.5,3.5,0,0,5,,"[num2text(gold,10)]","chocobo_race_menu_gold")
			screen_textl(15,16,2.5,2.5,0,0,5,,"GP","chocobo_race_menu_gold")
		if("chocobo_race_menu_race")
			inmenu="chocobo_race_menu_race"
			del(cursor)
			//setting the rank
			var/rank = chocobo_rank()
			//asking to race
			screen_dialog("It'll cost you [race_cost]GP to race. Your chocobo will be registered [rank]-rank. Register to race?","chocobo_race_menu_race",0,1)
			if(screen_yesno("chocobo_race_menu_race"))
				if(src.gold<race_cost)
					screen_dialog("Not enough GP!","chocobo_race_menu_race",1,1)
					spawn(20)
						for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="chocobo_race_menu_race") del(O)
						for(var/obj/onscreen/back/O in client.screen) if(O.screentag=="chocobo_race_menu_race") del(O)
						inmenu="chocobo_race_menu"
						menupos=1
						cursor = new(client)
						cursor.screen_loc="4:16,12:8"
				else
					if(chocobo_race_join(src,rank))
						src.gold-=race_cost
						close_screen("chocobo_race_menu_race")
						close_screen("chocobo_race_menu_gold")
						close_screen("chocobo_race_menu")
					else
						screen_dialog("All the race are filled!","chocobo_race_menu_race",1,1)
						spawn(20)
							for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="chocobo_race_menu_race") del(O)
							for(var/obj/onscreen/back/O in client.screen) if(O.screentag=="chocobo_race_menu_race") del(O)
							inmenu="chocobo_race_menu"
							menupos=1
							cursor = new(client)
							cursor.screen_loc="4:16,12:8"
			else
				for(var/obj/onscreen/text/O in client.screen) if(O.screentag=="chocobo_race_menu_race") del(O)
				for(var/obj/onscreen/back/O in client.screen) if(O.screentag=="chocobo_race_menu_race") del(O)
				inmenu="chocobo_race_menu"
				menupos=1
				cursor = new(client)
				cursor.screen_loc="4:16,12:8"
		if("chocobo_race_menu_error")
			var/current_inmenu = inmenu
			inmenu="chocobo_race_menu_error"
			screen_background(4,14,7,9,0,0,11,"chocobo_race_menu_error")
			screen_npctext(5,14,9,8,0,0,12,"[message]","chocobo_race_menu_error",1)
			//screen_ntext(5,14,9,8,0,12,"[message]","chocobo_race_menu_error")
			spawn(30)
				close_screen("chocobo_race_menu_error")
				inmenu = current_inmenu
		if("chocobo_race_menu_feed")
			inmenu="chocobo_race_menu_feed"
			screen_background(5,13,7,14,0,0,6,"chocobo_race_menu_feed")
			screen_npctext(5.5,12,13.5,13.5,0,0,7,"Which seed?","chocobo_race_menu_feed",1)
			screen_textl(6,13,12.5,12.5,0,0,7,0,"Gysahl   350GP","chocobo_race_menu_feed")
			screen_textl(6,13,11.5,11.5,0,0,7,0,"Reagan   350GP","chocobo_race_menu_feed")
			screen_textl(6,13,10.5,10.5,0,0,7,0,"Krakka   350GP","chocobo_race_menu_feed")
			screen_textl(6,13,9.5,9.5,0,0,7,0,"Tantal   450GP","chocobo_race_menu_feed")
			screen_textl(6,13,8.5,8.5,0,0,7,0,"Sylkis   800GP","chocobo_race_menu_feed")
			screen_textl(6,13,7.5,7.5,0,0,7,0,"Nevermind","chocobo_race_menu_feed")
			menupos=1
			cursor.screen_loc="5,12:8"
		if("chocobo_race_lap")
			close_screen("chocobo_race_lap")
			screen_textr(12,17,15.5,15.5,0,0,2,"Lap [lap]","chocobo_race_lap")
		if("chocobo_race_chkpt")
			close_screen("chocobo_race_chkpt")
			screen_textr(12,17,15,15,0,0,2,"Chkpoint [chkpt]","chocobo_race_chkpt")

/*	       5 6 7 8 9 0 1 2 3
17|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|
16|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|
15|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|
14|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|
13|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|
12|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|
11|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|¯|
   ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯
*/
proc
	chocobo_race_leave(var/mob/PC/p)
		var/area/misc/race_area/RaceLoc = p.inrace
		if(length(RaceLoc.race_racers)==1&&RaceLoc.race_status) RaceLoc.race_status=0
		RaceLoc.race_racers-=p
		p.BtlFrm("normal")
		p.density=0
		p.loc = locate(/area/misc/chocobo_race_exit) in world
		p.density=1
		p.inrace = null
		if(!length(RaceLoc.race_racers)) RaceLoc.race_racers = new()
	chocobo_race_join(var/mob/PC/p,rank)
		for(var/area/misc/race_area/RaceLoc in world)
			if((!rank||RaceLoc.race_type==rank)&&length(RaceLoc.race_racers)<max_racers&&!RaceLoc.race_status)
				if(!length(RaceLoc.race_racers)) RaceLoc.race_racers = new()
				p.pixel_x=0
				p.pixel_y=0
				p.pixel_step_size=64
				p.client.lazy_eye=4
				p.icon='feats/race/race_yellow_chocobo.dmi'
				p.icon_state="180"
				p.density=0
				p.loc=RaceLoc
				p.density=1
				p.inmenu="chocobo_race_wait"
				RaceLoc.race_racers+=p
				p.inrace=RaceLoc
				if(length(RaceLoc.race_racers)==1)
					spawn(race_wait_time) chocobo_race_start(RaceLoc)	//time before the race start
					//now we need to announce that there's a race going on
					for(var/obj/NPC/race_announcer/R in world)
						if(RaceLoc.race_owner==R.race_owner)
							for(var/mob/PC/wp in view(R,20))
								if(!wp.inmenu&&(!rank||wp.chocobo_rank()==rank))
									wp.screen_dialog("Race for rank [rank] will#start in about [race_wait_time/10] seconds")
									wp.inmenu="message"
				else if(length(RaceLoc.race_racers)>=max_racers) chocobo_race_start(RaceLoc) //forcin' the race to start.
				return 1
	chocobo_race_start(var/area/misc/race_area/RaceLoc)
		if(RaceLoc.race_status) return //race has already started.
		if(!length(RaceLoc.race_racers)) return //no one in the race o_O
		for(var/mob/PC/p in RaceLoc.race_racers)
			RaceLoc.race_status=1
			p.inmenu="chocobo_race"
			p.chocobo_race_screen("chocobo_race_lap")
			p.chocobo_race_screen("chocobo_race_chkpt")
			p.race()