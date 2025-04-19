// bosses stuff
area/boss_fight
	var/boss
	var/boss2
	var/boss3
	var/boss4
	Entered(mob/PC/M)
		set src in view(1)
		if(boss&&M.battle&&global.battle)
			var/hasnotfought
			for(var/mob/PC/P in M.party) if(!P.boss_fight.Find(boss)) hasnotfought++
			if(hasnotfought<=(M.party))
				for(var/mob/PC/Party in M.party) Party.addboss = boss
				M.StartBossBattle(boss)
	Exit(mob/PC/M)
		set src in view(1)
		if(boss&&M.battle&&global.battle)
			var/hasfought
			var/hasnotfought
			for(var/mob/PC/P in M.party)
				if(P.boss_fight.Find(boss)) hasfought++
				else hasnotfought++
			if(hasnotfought>=length(M.party))
				for(var/mob/PC/Party in M.party) Party.addboss = boss
				M.StartBossBattle(boss)
			else if(hasfought==length(M.party))
				if(boss2&&M.battle&&global.battle)
					hasfought = 0
					hasnotfought = 0
					for(var/mob/PC/P in M.party)
						if(P.boss_fight.Find(boss2)) hasfought++
						else hasnotfought++
					if(hasnotfought>=length(M.party))
						for(var/mob/PC/Party in M.party) Party.addboss = boss2
						M.StartBossBattle(boss2)
					else if(hasfought==length(M.party))
						if(boss3&&M.battle&&global.battle)
							hasfought = 0
							hasnotfought = 0
							for(var/mob/PC/P in M.party)
								if(P.boss_fight.Find(boss3)) hasfought++
								else hasnotfought++
							if(hasnotfought>=length(M.party))
								for(var/mob/PC/Party in M.party) Party.addboss = boss3
								M.StartBossBattle(boss3)
							else if(hasfought==length(M.party))
								if(boss4&&M.battle&&global.battle)
									hasfought = 0
									hasnotfought = 0
									for(var/mob/PC/P in M.party)
										if(P.boss_fight.Find(boss4)) hasfought++
										else hasnotfought++
									if(hasnotfought>=length(M.party))
										for(var/mob/PC/Party in M.party) Party.addboss = boss4
										M.StartBossBattle(boss4)
									else if(hasfought==length(M.party))
										for(var/mob/PC/P in M.party) P.bosspanel = 0
										return ..()
									else return 0
								else
									for(var/mob/PC/P in M.party) P.bosspanel=0
									return ..()
							else return 0
						else
							for(var/mob/PC/P in M.party) P.bosspanel=0
							return ..()
					else return 0
				else
					for(var/mob/PC/P in M.party) P.bosspanel=0
					return ..()
			else return 0
		else
			for(var/mob/PC/P in M.party) P.bosspanel = 0
			return ..()

mob/PC
	var/list/QBosses = new()
	proc/StartBossBattle(boss)
		inbossbattle=1
		for(var/mob/PC/p in party) p.inmenu="battle_start"
		var/BField
		var/Music = MUSIC_BOSSBATTLE
		var/mob/monster/Boss1,var/mob/monster/Boss2,var/mob/monster/Boss3
		var/mob/monster/Boss4,var/mob/monster/Boss5,var/mob/monster/Boss6
		switch(boss)
			if("MistDrag"){BField="cave";Boss1=new/mob/monster/Boss/MistDrag;Boss1.XLoc=-2;Music = MUSIC_BOSSBATTLE}
			if("Octommth"){BField="river";Boss1=new/mob/monster/Boss/Octommth;Boss1.XLoc=-2;Music = MUSIC_BOSSBATTLE}
			if("Milon"){BField="mountain";Boss1=new/mob/monster/Boss/Milon;Boss1.XLoc=-4;Boss1.YLoc=-1;Boss2=new/mob/monster/undead/Revenant;Boss2.XLoc=-6;Boss2.YLoc=1;Boss3=new/mob/monster/undead/Revenant;Boss3.XLoc=-3;Boss3.YLoc=1;Boss4=new/mob/monster/undead/Revenant;Boss4.XLoc=0;Boss4.YLoc=1;Boss5=new/mob/monster/undead/Revenant;Boss5.XLoc=-2;Boss5.YLoc=-2;Boss6=new/mob/monster/undead/Revenant;Boss6.XLoc=1;Boss6.YLoc=-2;Music = MUSIC_BOSSBATTLE}
			if("Milon Z"){BField="mountain";Boss1=new/mob/monster/Boss/Milon_Z;Boss1.XLoc=-2;Music = MUSIC_BOSSBATTLE}
			if("Dark Elf"){BField="crystal";Boss1=new/mob/monster/Boss/Dark_Elf;Boss1.XLoc=-2;Music = MUSIC_BOSSBATTLE}
			if("Dark Dragon"){BField="crystal";Boss1=new/mob/monster/Boss/DarkDragon;Boss1.XLoc=-2;Music = MUSIC_EDWARD}
			if("Antlion"){BField="cave";Boss1=new/mob/monster/Boss/Antlion;Boss1.XLoc=-1;Music = MUSIC_BOSSBATTLE}
			if("MomBomb"){BField="mountain";Boss1=new/mob/monster/Boss/MomBomb;Boss1.XLoc=-3;Boss1.YLoc=1;Boss2=new/mob/monster/GrayBomb;Boss2.XLoc=0;Boss2.YLoc=2;Boss3=new/mob/monster/Bomb;Boss3.XLoc=1;Boss3.YLoc=0;Boss4=new/mob/monster/GrayBomb;Boss4.XLoc=0;Boss4.YLoc=-2;Music = MUSIC_BOSSBATTLE}
			if("Archimus"){BField="castle";Boss1=new/mob/monster/Boss/Archimus;Boss1.XLoc=-2;Music=MUSIC_ARCHIMUS}
			if("Archimus"){BField="crystal";Boss1=new/mob/monster/Boss/Archimus;Boss1.XLoc=-2;Music=MUSIC_ARCHIMUS}
			if("DarkKnight"){BField="crystal";Boss1=new/mob/monster/Boss/DarkKnight;Boss1.XLoc=-5;Boss1.YLoc=2;Music=MUSIC_BOSSBATTLE}
			if("Cagnazzo"){BField="cave";Boss1=new/mob/monster/Boss/Cagnazzo;Boss1.XLoc=-2;Music=MUSIC_FIENDBATTLE}
			if("Magus"){BField="zotbabil";Boss3=new/mob/monster/Boss/Cindy;Boss3.XLoc=-4;Boss3.YLoc=-1;Boss2=new/mob/monster/Boss/Sandy;Boss2.XLoc=-1;Boss2.YLoc=-1;Boss1=new/mob/monster/Boss/Mindy;Boss1.XLoc=2;Boss1.YLoc=-2;Music = MUSIC_BOSSBATTLE}
			if("Valvalis"){BField="zotbabil";Boss1=new/mob/monster/Boss/Valvalis;Boss1.XLoc=-2;Music = MUSIC_FIENDBATTLE}
			if("Rubicant_"){BField="cave";Boss1=new/mob/monster/Boss/Rubicant_;Boss1.XLoc=-2;Boss1.YLoc=2;Music=MUSIC_BOSSBATTLE}
			if("Golbeze"){BField="cave";Boss1=new/mob/monster/Boss/Golbeze;Boss1.YLoc=3;Music = MUSIC_GOLBEZ}
			if("Rubicant"){BField="zotbabil";Boss1=new/mob/monster/Boss/Rubicant;Boss1.XLoc=-2;Music=MUSIC_BOSSBATTLE}
			if("Valvalis"){BField="castle";Boss1=new/mob/monster/Boss/Valvalis;Boss1.XLoc=-2;Music=MUSIC_BOSSBATTLE}
			if("DarkKnight"){BField="crystal";Boss1=new/mob/monster/Boss/DarkKnight;Boss1.XLoc=-5;Boss1.YLoc=2;Music=MUSIC_BOSSBATTLE}
			if("BalnabX"){BField="zotbabil";Boss1=new/mob/monster/Boss/BalnabX;Boss1.XLoc=-2;Boss1.YLoc=1;Music=MUSIC_BOSSBATTLE}
			if("Cagnazzo"){BField="cave";Boss1=new/mob/monster/Boss/Cagnazzo;Boss1.XLoc=-2;Music=MUSIC_FIENDBATTLE}
			if("Magus"){BField="zotbabil";Boss3=new/mob/monster/Boss/Cindy;Boss3.XLoc=-4;Boss3.YLoc=-1;Boss2=new/mob/monster/Boss/Sandy;Boss2.XLoc=-1;Boss2.YLoc=-1;Boss1=new/mob/monster/Boss/Mindy;Boss1.XLoc=2;Boss1.YLoc=-2;Music = MUSIC_BOSSBATTLE}
			if("Lugae"){BField="zotbabil";Boss2=new/mob/monster/Boss/Lugae;Boss2.XLoc=-4;Boss2.YLoc=1;Boss1=new/mob/monster/Boss/Balnab;Boss1.XLoc=-1;Boss1.YLoc=1;Music=MUSIC_BOSSBATTLE}
			if("EvilWall"){BField="magnes";Boss1=new/mob/monster/Boss/EvilWall;Music = MUSIC_BOSSBATTLE}
			if("Calbrena"){BField="crystal";Boss1=new/mob/monster/Boss/Calbrena;Boss1.XLoc=-3;Boss1.YLoc=-2;Music = MUSIC_BOSSBATTLE}
	//Mimic Fights for the Sealed Cave
			if("Mimic1"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic2"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic3"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic4"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic5"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic6"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic7"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic8"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic9"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic10"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic11"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic12"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic13"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic14"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			if("Mimic15"){BField="magnes";Boss1=new/mob/monster/Boss/Mimic;Boss1.XLoc=0}
			else {inmenu = null;return}
		//compiling boss's list
		var/list/Bosses = new()
		if(Boss1) Bosses+=Boss1;if(Boss2) Bosses+=Boss2;if(Boss3)	Bosses+=Boss3
		if(Boss4) Bosses+=Boss4;if(Boss5) Bosses+=Boss5;if(Boss6)	Bosses+=Boss6
		//selecting a battlefield
		var/turf/battle/location/BLoc
		if(bfield_location.Find(BField)&&length(bfield_location[BField]))
			BLoc=pick(bfield_location[BField])
			bfield_location[BField]-=BLoc
		if(!BLoc){for(var/mob/PC/p in party) p.inmenu=null;return}
		else BLoc.active = 1
		party<<sound(null)
		party<<SOUND_BTLSTART
		party<<sound(Music,1,0,1,volume=BGM_VOL)
		Battle(BLoc,1,party,Bosses)

//### PVP Stuff ###
mob/PC/proc/StartPVPBattle(mob/PC/p,mob/PC/s)
	if(p.inparty != 1 || s.inparty != 1) return
	for(var/mob/PC/pp in p.party) pp.inmenu="pvp_start"
	for(var/mob/PC/sp in s.party) sp.inmenu="pvp_start"
	//selecting a battlefield
	var/bfd = p.loc:bfield
	var/turf/battle/location/BLoc
	if(bfield_location.Find(bfd)&&length(bfield_location[bfd]))
		BLoc=pick(bfield_location[bfd])
		bfield_location[bfd]-=BLoc
	if(!BLoc){for(var/mob/PC/pp in p.party) pp.inmenu=null;for(var/mob/PC/sp in s.party) sp.inmenu=null;return}
	else BLoc.active = 1
	p.sound<<sound(null);p.party<<SOUND_BTLSTART;s.party<<SOUND_BTLSTART
	p.party<<sound(MUSIC_FIENDBATTLE,1,0,1,volume=BGM_VOL);s.party<<sound(MUSIC_FIENDBATTLE,1,0,1,volume=BGM_VOL)
	Battle(BLoc,1,p.party,s.party)

//### NPC Quest Stuff ###
mob/PC/var/list/Quest = new()		//for key that you can do only one time
obj/NPC/Quest
	King_of_Fabul
		icon='mob/npc/king.dmi'
		icon_state="blue"
		proc/quest_action(mob/PC/p)
			p.inmenu="message"
			var/obj/O = locate(/obj/Key_Item/SRoadEssence) in p.contents
			if(O)
				p.screen_dialog("Quick... Go..now...","message")
			else
				p.screen_dialog("Welcome to Fabul, Plague-Bearer. I see that you, too have come seeking the Orb to Mysidia. The King of Baron entrusted to me its mysterious powers. I shall lend you the essence of it, for I cannot simply give you the orb. The consequences could be dire! Go now, I know what you seek to do. Good luck on your quest.","message")
				if(p.screen_yesno("message")){p.contents+=new/obj/Key_Item/SRoadEssence;p.screen_dialog("You recieved the Serpent Road's Essence.","message",1)}
				else p.screen_dialog("The Serpent Road connects Baron to Mysidia.","message",1)
	guard
		icon='mob/npc/soldat.dmi'
		icon_state="purple"
		proc/quest_action(mob/PC/p)
			p.inmenu="message"
			var/obj/O = locate(/obj/Key_Item/Hvrcraft) in p.contents
			if(O)
				p.screen_dialog("Use it to cross the shallows north-east of here,")
			else
				p.screen_dialog("Greetings Plague-bearer, if you are going to Fabul, you'll be needing this Hovercraft! Here take one.","message")
				p.contents+=new/obj/Key_Item/Hvrcraft;p.screen_dialog("You recieved the Hovercraft!","message",1)
	plague_investigator
		icon='mob/npc/scholar.dmi'
		icon_state="blue"
		proc/quest_action(mob/PC/p)
			p.inmenu="message"
			var/obj/O = locate(/obj/Key_Item/ArchBlood) in p.contents
			if(O)
				p.screen_dialog("You may now use the vaccine command in your social tab to upload your true form","message")
				p.contents-=O
				p.verbs += /mob/Bonus/verb/vaccine
			else p.screen_dialog("I've done it! I have found a cure for this plague which has been spreading. An evil being created this plague and for me to create the vaccine, I'll need a sample of it's blood.","message")
	crystal1
		var/direction=2
		var/dest_x=164
		var/dest_y=131
		var/dest_z=5
		proc/quest_action(mob/PC/p)
			p.inmenu="message"
			p.msg("The Big Whale has landed on the Moon,")
			if(dest_x&&dest_y&&dest_z)
				p.inmenu = "turf_teleport"
				p.density = 0
				for(var/mob/PC/M in p.party){M.pmoves=null;M.loc = locate(dest_x,dest_y,dest_z);M.dir = direction;M.icon_state = "normal"}
				p.density = 1
				spawn(reaction_time) if(p) p.inmenu = null
				return
	crystal2
		var/direction=2
		var/dest_x=148
		var/dest_y=131
		var/dest_z=5
		proc/quest_action(mob/PC/p)
			p.inmenu="message"
			p.msg("The Big Whale has landed on Earth,")
			if(dest_x&&dest_y&&dest_z)
				p.inmenu = "turf_teleport"
				p.density = 0
				for(var/mob/PC/M in p.party){M.pmoves=null;M.loc = locate(dest_x,dest_y,dest_z);M.dir = direction;M.icon_state = "normal"}
				p.density = 1
				spawn(reaction_time) if(p) p.inmenu = null
				return
	Tail_Collector
		icon='mob/npc/midget.dmi'
		icon_state="blue"
		dir=1
		proc/quest_action(mob/PC/p)
			p.inmenu="message"
			var/obj/O = locate(/obj/Key_Item/Pink_Tail) in p.contents
			if(O)
				p.screen_dialog("It's a Pink Tail I've been looking for! Will you trade it for a piece of ore?","message")
				if(p.screen_yesno("message")){p.contents-=O;p.contents+=new/obj/Key_Item/Adamant;p.screen_dialog("Thanks! Take the ore!","message",1)}
				else p.screen_dialog("Come back when you changed mind.","message",1)
			else p.screen_dialog("I don't wanna talk to you unless you have a tail for me!","message")
	Smith
		icon='mob/npc/dwarf.dmi'
		icon_state="purple"
		proc/quest_action(mob/PC/p)
			p.inmenu="message"
			var/obj/O = locate(/obj/Key_Item/Adamant) in p.contents
			if(O)
				p.screen_dialog("This! The Adamant! I can make you a good armor with it, Lali!","message")
				if(p.screen_yesno("message")){p.contents-=O;p.contents+=new/obj/armor/Armor/Adamant;p.screen_dialog("Here it is, I told you I'd become the greatest blacksmith, Lali-oh!","message",1)}
				else p.screen_dialog("Come back when you changed mind, Lali!","message",1)
			else p.screen_dialog("I could make you a great armor with a piece of Adamant, Lali!","message")
	Engineer
		icon='mob/npc/engineer.dmi'
		proc/quest_action(mob/PC/p)
			p.inmenu="message"
			var/obj/O = locate(/obj/Key_Item/Airship) in p.contents
			if(O)
				p.screen_dialog("Use it to cross the lava down here,")
			else
				p.screen_dialog("Hey, me and my team just finished building a series of airships. They are on break, but feel free to take one. Here!.","message")
				p.contents+=new/obj/Key_Item/Airship;p.screen_dialog("You recieved the Airship!","message",1)
/*	Mysterious_Guy
		icon='mob/npc/special.dmi'
		icon_state="dw4hero"
		proc/quest_action(mob/PC/p)
			p.inmenu="message"
			var/obj/O = locate(/obj/Key_Item/BKnight) in p.contents
			if(O)
				p.screen_dialog("You have unlocked Black Knight","message")
				p.contents-=O
				var/savefile/F = new("saves/[copytext(p.ckey,1,2)]/[p.ckey].sav")
				F.cd = "/bonus/"
				var/list/allowed_characters = new()
				if(F["characters"]) F["characters"]>>allowed_characters
				if(!allowed_characters.Find("Black Knight"))
					allowed_characters+="Black Knight"
					//saving the change
					F["characters"]<<allowed_characters
				else info(,list(src),"You already access to Black Knight.")
			else p.screen_dialog("...","message")
*/
	Rod_Crafter
		icon='mob/npc/blackmage.dmi'
	Katana_Smith
	Sword_Smith
	Harp_Crafter
	Whip_Crafter
	Smith3
	Tail_Collector1
	Tail_Collector2
	Spear_Smith
	Hammer_Smith
	Staff_Crafter
	Claw_Smith
	Smith2
