//## Ability
/*#####################################################
#(DK) #	Dark Knight	# Dark Wave												#
#(P)  #	Paladin			# Cover			White_									#
#(BK) #	Black Knight# Black			Summon								#
#(WM1)#	White Mage	# White			Prayer		Aim					#
#(WM2)#	White Twin	# White			Twin			Fake Tears	#
#(BM) #	Black Twin	# Black			Twin			Strengthen	#
#(S)  #	Sage				# White			Black			Remember		#
#(L)  #	Lunarian		# White			Black			Spirit Wave	#
#(YC) #	Y.Caller		# White			Black			Summon			#
#(MC) #	M.Caller		# Black			Summon								#
#(D)  #	Dragoon			# Jump														#
#(N)  #	Ninja				# Ninjutsu	Dart			Sneak				#
#(K)  #	Monk				# Build Up	Kick			Endure			#
#(B)  #	Bard				# Sing			Medicine	Show/Hide		#
#(E)  #	Engineer		# Peep			Tool									#
#######################################################
#	Select:	0 = auto					#	Can we select
#					1 = manual				# the target?
#############################
#	Target: 0 = any						#	Can we target
#					1 = single only		# single/all?
#					2 = all only			#
#############################
# DType : 0 = self					#
#					1 = all ally			#	Default type
#					2 = ally					# of target
#					3 = enemy					#
#					4	= all enemy			#
#############################
#	TType : 0 = self only			# What target
#					1 = enemy only		# is allowed.
#					2 = ally only			# (Limitation)
#					3 = any						#
#############################
# ATime : action's time	%		# 100 = full time
#############################
# ASType:	0 = parry					#	The 'stance'
#					1 = magic					# the ability
#					2 = special				#	should use.
#					3 = special2			#
#	AAType:	0 =	attack				# The 'attack'
#					1 =	victory				# the ability
#					2 =	special1			# should use.
#					3 = special2			#
#############################
# DmgType	0 = Direct/None		#
#					1 = Physical			#
#					2 = Magical				#
#					3 = Status				#
#############################
# Damage										#
#	Physical: Dmg % of base		# 200% = jump
#	Magical : Damage modifier # 800 = meteo
# Status  : Percentage			# 20% of instant-death
#############################
# DmgType:	0 = Status ONLY	#
#						1 = Physical		#
#						2 = Magical			#
#############################
# Modifier:									#
#						0 = Black				#
#						1 = White				#
#############################
# Status: 0 = none	#Setting#
## BAD Status								#
#			 (-)1 = POISON	(1-3)	# poison level - hp-=% each turn
#			 (-)2 = DARKNESS			# difficulties to hit
#			 (-)3 = MUTE					# unable to cast magic
#			 (-)4 = CURSE					# cheap attack power
#			 (-)5 = CONFUSE				# confused, random attack
#			 (-)6 = SLEEP					# sleeping
#			 (-)7 = SLOW		(1-2)	# slow level - slower
#			 (-)8 = HOLD					# paralyze -- cant move
#			 (-)9 = SWOON					# instant death
## GOOD Status							#
#			 (-)10= FLOAT	 (1,6)	# 0 = -FLOAT.. floatin' in theee sky
#			 (-)11= HASTE	 (1,5)	# 0 = -HASTE.. faster
#			 (-)12= PROTECT(1,3)	# 0 = -PROTECT.. protect against physical
#			 (-)13= SHELL	 (1,3)	# 0 = -SHELL.. protect against magical
#			 (-)14= REFLECT(1,2)	# 0 = -REFLECT.. same as shell + protect
#############################
# Attrib: 0 = none				  #
#					1 = slashing			#
#					2 = piercing			#
#					3 = fire					#
#					4 = ice						#
#					5 = bolt					#
#					6 = earth					#
#					7 = holy					#
#					8 = dark					#
#					9 = heal					#
#############################
#	HPHeal:	actual number			#
#	MPCost										#
# HPDrain: percentage				#
# MPDrain: of MaxHP/MP			#
#############################
# ClassNeed: class that can #
#						 use the action #
#############################
# LvlNeed: level needed to  #
#					 use that action. #
###########################*/

//## Targeting system
mob/PC/var/tmp
	obj/Ability/btl_action
	mob/btl_target

mob/PC/proc/btl_action(var/obj/Ability/ActionType)
	if(!ActionType) return	//no action!
	if(ActionType.Muteable) if(Mute) {src<<SOUND_WRONG;return}
	if(ActionType.Curseable) if(Curse) {src<<SOUND_WRONG;return}
	//basic skills
	if(istype(ActionType,/obj/Ability/Basic/Attack)||istype(ActionType,/obj/Ability/Skills)) btl_target(ActionType)
	else if(istype(ActionType,/obj/Ability/Basic/Parry)){BtlFrm("battle_parry");parry=1;gauge=atime(level)} //parryin'
	else if(istype(ActionType,/obj/Ability/Basic/Run)){escape=1;gauge=round(atime(level)/2)}
	else if(istype(ActionType,/obj/Ability/Basic/Item)) battle_screen("battle_item")
	else if(istype(ActionType,/obj/Ability/Basic/Dart)) battle_screen("battle_dart")
	//advanced/random skills
	else if(istype(ActionType,/obj/Ability/ASkills)) battle_screen("battle_askills",,ActionType)
	else if(istype(ActionType,/obj/Ability/RSkills)) battle_screen("battle_rskills",,ActionType)
	else return

mob/PC/proc/btl_raction(var/obj/Ability/ActionType)
	//here is for random actions, like Twin, Sing and such.
	//after done with, send to btl_target().
	src<<"* Command not implented."
	return

mob/PC/proc/btl_target(var/obj/Ability/Action,direction)
	if(!Action) return	//no action to proceed with..?
	inmenu = "battle_target"
	var/turf/battle/location/BLoc = locate(/turf/battle/location/) in view(src)
	if(!direction) //newly selected action, preparing everything for it
		btl_action = Action
		//creating the action's default list based on the action's possibilities/limitations
		menupos = 1
		menulist = new()
		menuaction = Action.DType
		if(!menuaction) menulist += src
		else if(BLoc.Attackers.Find(src))
			if(menuaction<=2) for(var/mob/T in BLoc.Attackers) if(T.HP>0||Action.Revive) menulist += T
			else if(menuaction>=3) for(var/mob/T in BLoc.Defenders) if(T.HP>0||Action.Revive) menulist += T
		else if(BLoc.Defenders.Find(src))
			if(menuaction<=2) for(var/mob/T in BLoc.Defenders) if(T.HP>0||Action.Revive) menulist += T
			else if(menuaction>=3) for(var/mob/T in BLoc.Attackers) if(T.HP>0||Action.Revive) menulist += T
		//manual or automatic targeting?
		if(!Action.Select){btl_target(btl_action,"C");return}
	else
		switch(direction) //there's a direction! woo!
			if("N")
				if(!menuaction&&!Action.TType) return //self only
				if(menuaction!=1&&menuaction!=4){menupos--;if(menupos<1) menupos = length(menulist)}
				else return
			if("S")
				if(!menuaction&&!Action.TType) return
				if(menuaction!=1&&menuaction!=4){menupos++;if(menupos>length(menulist)) menupos = 1}
				else return
			if("W")
				if(menuaction==4||!Action.TType) return
				else if(menuaction==3&&Action.Target==1){menupos--;if(menupos<1) menupos = length(menulist)}
				else if(menuaction==2&&Action.TType==2){menupos++;if(menupos>length(menulist)) menupos = 1}
				else if(menuaction==1&&Action.Target==2)
					if(Action.TType==3) menuaction = 4
					else return
				else {menupos=1;menuaction++}
			if("E")
				if(menuaction==1||!Action.TType) return
				else if(menuaction==2&&Action.Target==1){menupos++;if(menupos>length(menulist)) menupos = 1}
				else if(menuaction==3&&Action.TType==1){menupos--;if(menupos<1) menupos = length(menulist)}
				else if(menuaction==4&&Action.Target==2)
					if(Action.TType==3) menuaction = 1
					else return
				else {menupos=1;menuaction--}
			if("C")
				inmenu="panel"
				close_screen("battle_askills")
				close_screen("battle_askills_cost")
				close_screen("battle_menu")
				for(var/obj/onscreen/cursor/C in client.screen) del(C)
				if(!btl_action||!length(menulist)) return
				//setting the action's preparing time
				var/action_time=10
				if(btl_action.ATime) action_time = btl_action.ATime
				switch(btl_action.ASType)
					if(0)	BtlFrm("battle_parry")
					if(1)	BtlFrm("battle_magic_stance")
					if(2)	BtlFrm("battle_special_stance")
					if(3) BtlFrm("battle_special2_stance")
				//setting btl_target
				if(menuaction==1) btl_target = "all ally"
				else if(menuaction==4) btl_target = "all enemy"
				else btl_target = menulist[menupos]
				if(Action.jump_charge>=1) Jump_Charge=1
				gauge=action_time	//finally, setting the gauge status, so the battle continue!
				return	//fieww... end.
		//creating new list
		menulist = new()
		if(BLoc.Attackers.Find(src))
			if(menuaction<=2) for(var/mob/T in BLoc.Attackers) if(T.HP>0||Action.Revive) menulist += T
			else if(menuaction>=3) for(var/mob/T in BLoc.Defenders) if(T.HP>0||Action.Revive) menulist += T
		else if(BLoc.Defenders.Find(src))
			if(menuaction<=2) for(var/mob/T in BLoc.Defenders) if(T.HP>0||Action.Revive) menulist += T
			else if(menuaction>=3) for(var/mob/T in BLoc.Attackers) if(T.HP>0||Action.Revive) menulist += T
	//Target(s) acquired, displaying it (them).
	for(var/obj/onscreen/cursor/C in client.screen) del(C) //deleting all old cursors
	if(!length(menulist)) return //no one to target!
	var/list/TargList = new()
	if(menuaction==1||menuaction==4) for(var/mob/T in menulist) TargList += T
	else
		if(length(menulist)>=menupos) TargList += menulist[menupos]
		else client.Northwest()
	//creating the cursors
	for(var/mob/T in TargList)
		var/Mod = 1
		for(var/R in btl_attrib(Action)) if(T.Resist.Find(R)) Mod -= (T.Resist[R]/100)
		cursor=new(client)
		var/T_height = 1
		var/T_x
		if(!istype(T,/mob/PC))
			if(Mod<1) cursor.icon_state="bad"
			else if(Mod>1) cursor.icon_state="good"
			var/mob/monster/M = T
			T_x = M.monster_x_start
			T_height = M.monster_y_start + M.monster_y_end
		//calculating cursor position
		var/cursor_x = T.x - BLoc.x + T_x + 8
		var/cursor_y = T.y - BLoc.y + 10
		if(T_height)
			T_height/=2
			if(T_height!=round(T_height)){cursor_y+=round(T_height);T_height=16}
			else {cursor_y+=T_height;T_height=0}
		cursor.screen_loc="[cursor_x]:16,[cursor_y]:[T_height]"

obj/Ability
	var
		//target system
		Select
		Target
		DType
		TType
		//animation stuff
		ASType
		AAType
		//battle atime
		ATime
		//damage system
		DmgType			//(0 = Direct/None	;1 = Physical	;	2 = Magical	;3 = Summon Magic 4 = Sword Magic)
		Damage			//(	Damage Modifier	;Percent of Z ;	Damage Mod	;	Percent	 )
		Damage2			//(Used with DmgType 4; it adds Damage2 to Damage *Should be a small number
		HPDamage		//(Does Direct Damage aka ignore defense.
		HPHeal
		MPHeal
		MPCost
		HPDrain
		MPDrain
		Revive
		Modifier
		Death			//This has a small chance of killing something off. Shouldn't work on bosses.
		Suicide			//(Because this is an Online Game it doesn't actually suicide you just drop your HP to 1.)
		Weak			//This is for Tornado it has a chance of weakening an opponent by 2/3 1/2 or 1/3
		Dispell			//This removed every status effect but special ones aka Cover
		Esuna			//This removes every bad status effect and keeps all good ones.
		Protect			//Set to 1 inflicts Protect Status
		Shell			//Set to 1 inflicts Shell Status
		Reflect			//Set to 1 inflicts Reflect Status
		Haste			//Set to 1 inflicts Haste Status
		Float			//Set to 1 inflicts Float Status
		Blink			//Set to 1 inflicts Blink Status
		Berserk			//Set to 1 inflicts Beserk Status
		Darkness		//Set to 1 inflicts Darkness Status
		Slow			//Set to 1 inflicts Slow Status
		Poison			//Set to 1 inflicts Poison Status
		Regen			//Set to 1 inflicts Regen Status
		Cover			//Set to 1 and user covers the Target from physical damage
		Mute			//Set to 1 and user can't cast spells that are "muteable"
		Sleep			//Set to 1 inflicts Sleep Status
		Hold			//Set to 1 inflicts Hold Status
		Stone			//Set to 1 inflicts Stone Status
		Gradual_Petrify	//Set to 1 to start inflicting Gradual Petrify Status
		Curse			//Set to 1 inflicts Curse Status
		Strengthen		//Set to 1 to increase magical damage by 75%
		Cry				//Set to 1 to decrease physical damage by 25%
		Confuse			//Set to 1 inflicts Confuse Status
		Muteable		//Set to 1 if Skill is muteable(if Muted the user can't use anything that's muteable)
		Curseable		//Set to 1 if Skill is curseable(if Cursed the user can't use anything that's curseable)
		Asura			//This is for ASURA ONLY! it heals casts protect or shell on the party!
		Golem			//This is for GOLEM ONLY! it casts protect and blink on the party
		Pheonix			//This is for PHEONIX ONLY! it deals damage and lifes the party.
		Sylph			//This is for SYLPH ONLY! it deals damage and hp drains to all.
		Hades			//This is for HADES ONLY! it deals random status effects.
		Guard			//This is for the blue spell GUARD ONLY! it creats lots of positive status
		Difference		//This is for the blue spell ??? ONLY! it deals damage based on the difference of your MaxHP and Current HP.
		Countdown		//This starts a Death CountDown! well it doesn't cause death but it does bring their hp to 1 ^_^
		Curaja			//When this is used on one target it heals full HP if multiple it's close to cure 4.
		Demi			//Cuts hp by 25%
		Demi2			//Cuts hp by 50%
		Demi3			//Cuts hp by 75%
		Escape			//Set to 1 to have skill run for dear life!
		Steal			//Set to 1 for a chance to STEAL!
		Remember		//Set to 1 to cause a random spell to happen...
		Scan			//Set to 1 to scan a monster or player!
		jump_charge     //Set to 1 to make you invincible while charging! (Damn you Kain!!!!) ~Crimson
		list/Attrib = new()
		list/SEffect = new()
		list/ClsNeed = new()
		LvlNeed
		CanUse = 0		//(0 = Any	;1 = in Battle only	;2 = Out of Battle only	;3 = Overworld only)
		//visual/audio stuff
		Sound
	Basic
		ASType=0
		Attack
			Select=1
			Target=1
			DType=3
			TType=3
			AAType=0
			ATime=2
			Damage=100
			DmgType=1
		Parry
		Run
		Item
			AAType=1
			Cure1
				invicon="potion"
				value=30
				Select=1
				Target=1
				DType=2
				TType=2
				HPHeal=96
				ATime=2
				Sound=SOUND_POTION
			Cure2
				invicon="potion"
				value=150
				Select=1
				Target=1
				DType=2
				TType=2
				HPHeal=480
				ATime=2
				Sound=SOUND_POTION
			Cure3
				invicon="potion"
				value=1500
				Select=1
				Target=1
				DType=2
				TType=2
				HPHeal=1920
				ATime=2
				Sound=SOUND_POTION
			Life
				invicon="potion"
				value=150
				Select=1
				Target=1
				DType=2
				TType=2
				Revive=10
				ATime=2
				CanUse = 1
				Sound=SOUND_POTION
			Remedy
				invicon="potion"
				value=1000
				Select=1
				Target=1
				DType=2
				TType=2
				ATime=2
				Esuna=1
				CanUse = 1
				Sound=SOUND_POTION
			Ether1
				invicon="potion"
				value=1000
				Select=1
				Target=1
				DType=2
				TType=2
				MPHeal=48
				ATime=2
				Sound=SOUND_POTION
			Ether2
				invicon="potion"
				value=5000
				Select=1
				Target=1
				DType=2
				TType=2
				MPHeal=144
				ATime=2
				Sound=SOUND_POTION
			Elixir
				invicon="potion"
				value=50000
				Select=1
				Target=1
				DType=2
				TType=2
				HPHeal=9999
				MPHeal=999
				ATime=2
				Sound=SOUND_POTION
			Tent
				invicon="tentcab"
				value=800
				Select=1
				Target=1
				DType=0
				TType=0
				HPHeal=1000
				MPHeal=100
				CanUse = 3
			Cabin
				invicon="tentcab"
				value=4000
				Select=1
				Target=1
				DType=0
				TType=0
				HPHeal=9999
				MPHeal=999
				CanUse = 3
		Dart
			Shuriken
				invicon = "star"
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				DmgType = 1
				ATime = 2
				CanUse = 1
				ASType = 0
				AAType = 2
				value = 1000
				Damage = 110
			Boomerang
				invicon = "boomerang"
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				DmgType = 1
				ATime = 2
				CanUse = 1
				ASType = 0
				AAType = 2
				value = 3000
				Damage = 120
			FullMoon
				invicon = "boomerang"
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				DmgType = 1
				ATime = 2
				CanUse = 1
				ASType = 0
				AAType = 2
				value = 5000
				Damage = 130
			Fuma
				invicon = "star"
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				DmgType = 1
				ATime = 2
				CanUse = 1
				ASType = 0
				AAType = 2
				value = 7000
				Damage = 140
			Ninja
				invicon = "star"
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				DmgType = 1
				ATime = 2
				CanUse = 1
				ASType = 0
				AAType = 2
				value = 9000
				Damage = 150
		Key_Item
	Skills
		Curseable = 1
		DarkWave
			Select=1
			Target=2
			DType=4
			TType=1
			ASType=2
			AAType=2
			ATime=5
			DmgType = 5
			Damage=110
			HPDrain = -8
		Cover
			Select = 1
			Target = 1
			DType = 2
			TType = 1
			ASType = 0
			AAType = 2
			ATime = 4
			Cover = 1
		Prayer
			Select=0
			Target=2
			DType=1
			TType=2
			ASType=1
			AAType=2
			DmgType=3
			Damage=16
			Modifier=1
			Attrib = list("healing")
			ATime=4
		Aim
			Select = 1
			Target = 1
			DType = 3
			TType = 1
			ASType = 0
			AAType = 2
			DmgType = 1
			ATime = 3
			Damage = 150
		FakeTears
			Select = 0
			Target = 2
			DType = 4
			TType = 1
			ASType = 1
			AAType = 2
			ATime = 5
			Cry = 1
		Strengthen
			Select = 0
			Target = 1
			DType = 0
			TType = 0
			ASType = 1
			AAType = 2
			Strengthen = 1
		Remember
			Select = 1
			Target = 0
			DType = 3
			TType = 1
			ASType = 0
			AAType = 2
			Remember = 1
		SpiritWave
			Select=0
			Target=2
			DType=1
			TType=2
			ASType=1
			AAType=2
			DmgType=2
			ATime = 4
			Regen = 1
		Jump
			Select = 1
			Target = 1
			DType = 3
			TType = 1
			ASType = 2
			AAType = 2
			DmgType = 1
			ATime = 13
			jump_charge = 1
			Damage = 220
		Sneak
			Select = 1
			Target = 1
			DType = 3
			TType = 1
			ASType = 0
			AAType = 2
			Steal=1
		BuildUp
			Select = 1
			Target = 1
			DType = 3
			TType = 1
			ASType = 2
			AAType = 0
			DmgType = 1
			ATime = 6
			Damage = 165
		Kick
			Select = 0
			Target = 2
			DType = 4
			TType = 1
			ASType = 0
			AAType = 2
			DmgType = 1
			ATime = 8
			Damage = 100
		Endure
			Select = 0
			Target = 1
			DType = 0
			TType = 0
			ASType = 0
			AAType = 1
			Protect = 1
			ATime = 6
		Medicine
			Select=0
			Target=2
			DType=1
			TType=2
			ASType=0
			AAType=1
			DmgType=3
			Damage=16
			Modifier=1
			Attrib = list("healing")
			ATime=4
		Peep
			Select = 1
			Target = 1
			DType = 3
			TType = 3
			ASType=2
			AAType=2
			ATime=2
			Scan = 1
		Scorch
			Select=1
			Target=0
			DType=3
			TType=1
			ASType=2
			AAType=2
			ATime=10
			Damage=170
			DmgType=1
			Attrib = list("fire")
			HPDrain=-3
	ASkills
		ASType=1
		AAType=1
		DmgType=2
		CanUse = 1
		MgcSword
			Curseable = 1
			invicon = "sword"
			ASType = 1
			AAType = 0
			DmgType = 4
			Fire1
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 4
				Damage = 100
				Damage2 = 20
				Attrib = list("fire")
				MPCost = 3
				LvlNeed = 2
			Fire2
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 6
				Damage = 100
				Damage2 = 50
				Attrib = list("fire")
				MPCost = 15
				LvlNeed = 14
			Fire3
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 8
				Damage = 100
				Damage2 = 100
				Attrib = list("fire")
				MPCost = 30
				LvlNeed = 40
			Ice1
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 4
				Damage = 100
				Damage2 = 20
				Attrib = list("ice")
				MPCost = 3
				LvlNeed = 1
			Ice2
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 6
				Damage = 100
				Damage2 = 50
				Attrib = list("ice")
				MPCost = 15
				LvlNeed = 13
			Ice3
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 8
				Damage = 100
				Damage2 = 100
				Attrib = list("ice")
				MPCost = 30
				LvlNeed = 40
			Bolt1
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 4
				Damage = 100
				Damage2 = 20
				Attrib = list("bolt")
				MPCost = 3
				LvlNeed = 5
			Bolt2
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 6
				Damage = 100
				Damage2 = 50
				Attrib = list("bolt")
				MPCost = 15
				LvlNeed = 16
			Bolt3
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 8
				Damage = 100
				Damage2 = 100
				Attrib = list("bolt")
				MPCost = 30
				LvlNeed = 45
			Poison
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 2
				Damage = 100
				Poison = 1
				MPCost = 2
				LvlNeed = 10
				Poison=1
			Bio
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 6
				Damage = 100
				Damage2 = 75
				Poison = 1
				MPCost = 20
				LvlNeed = 26
				Poison=1
			Earth
				Select = 1
				Target = 2
				DType = 4
				TType = 1
				ATime = 8
				Damage = 100
				Damage2 = 125
				Attrib = list("earth")
				MPCost = 40
				LvlNeed = 48
			Tornado
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 8
				Damage = 100
				Damage2 = 85
				Attrib = list("wind")
				MPCost = 30
				LvlNeed = 51
			Sleep
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 3
				Damage = 100
				Sleep = 1
				MPCost = 12
				LvlNeed = 9
				Sleep=1
			Stop
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 5
				Damage = 100
				Hold = 1
				MPCost = 15
				LvlNeed = 18
				Hold=1
			Drain
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 4
				Damage = 75
				HPDrain = 20
				MPCost = 18
				LvlNeed = 36
			Asper
				Select = 1
				Target = 1
				DType = 1
				ATime = 4
				Damage = 50
				MPDrain = 10
				MPCost = 2
				LvlNeed = 32
			Death
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 5
				Damage = 100
				Death = 1
				MPCost = 35
				LvlNeed = 52
				Death=1
			Holy
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 10
				Damage = 100
				Damage2 = 150
				Attrib = list("holy")
				MPCost = 46
				LvlNeed = 55
			Flare
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 8
				Damage = 100
				Damage2 = 150
				Attrib = list("fire")
				MPCost = 50
				LvlNeed = 58
			Meteo
				Select = 1
				Target = 2
				DType = 4
				TType = 1
				ATime = 20
				Damage = 100
				Damage2 = 200
				Attrib = list("dark")
				HPDrain = -5
				MPCost = 99
				LvlNeed = 65
		Support
			Muteable = 1
			invicon = "other"
			ASType = 0
			AAType = 1
			Modifier=1
			Recover
				Select = 1
				Target = 2
				DType = 1
				TType = 3
				HPHeal = 300
				ATime = 4
				MPCost = 2
				LvlNeed = 1
			Recover2
				Select = 1
				Target = 2
				DType = 1
				TType = 3
				HPHeal = 700
				ATime = 6
				MPCost = 10
				LvlNeed = 10
			Recover3
				Select = 1
				Target = 2
				DType = 1
				TType = 3
				HPHeal = 2300
				ATime = 8
				MPCost = 20
				LvlNeed = 30
			Recover4
				Select = 1
				Target = 2
				DType = 1
				TType = 3
				HPHeal = 4200
				ATime = 10
				MPCost = 40
				LvlNeed = 50
			MindHeal1
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				MPHeal = 30
				ATime = 4
				HPDrain = -2
				LvlNeed = 5
			MindHeal2
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				MPHeal = 150
				ATime = 15
				HPDrain = -5
				LvlNeed = 25
			MindHeal3
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				MPHeal = 250
				ATime = 20
				HPDrain = -10
				LvlNeed = 40
			MindHeal4
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				MPHeal = 350
				ATime = 30
				HPDrain = -15
				LvlNeed = 60
			LifeAll
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				Revive = 20
				ATime = 8
				MPCost = 20
				LvlNeed = 20
			EsunaAll
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				Esuna = 1
				ATime = 8
				MPCost = 20
				LvlNeed = 25
			DispelAll
				Select = 1
				Target = 2
				DType = 4
				TType = 1
				Dispell = 1
				ATime = 10
				MPCost = 30
				LvlNeed = 30
			RegenAll
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				Regen = 1
				ATime = 10
				MPCost = 25
				LvlNeed = 25
		Black
			Muteable = 1
			invicon = "other"
			Fire1
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=2
				Damage=16
				Attrib = list("fire")
				MPCost=5
				LvlNeed=2
			Fire2
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=4
				Damage=64
				Attrib = list("fire")
				MPCost=15
				LvlNeed=14
			Fire3
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=8
				Damage=256
				Attrib = list("fire")
				MPCost=30
				LvlNeed=42
			Ice1
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=2
				Damage=16
				Attrib = list("ice")
				MPCost=5
				LvlNeed=1
			Ice2
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=4
				Damage=64
				Attrib = list("ice")
				MPCost=15
				LvlNeed=13
			Ice3
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=8
				Damage=256
				Attrib = list("ice")
				MPCost=30
				LvlNeed=40
			Bolt1
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=2
				Damage=16
				Attrib = list("bolt")
				MPCost=5
				LvlNeed=5
			Bolt2
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=4
				Damage=64
				Attrib = list("bolt")
				MPCost=15
				LvlNeed=16
			Bolt3
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=8
				Damage=256
				Attrib = list("bolt")
				MPCost=30
				LvlNeed=45
			Poison
				Select=1
				Target=0
				DType=3
				TType=1
				ATime=2
				Poison=1
				MPCost=2
				LvlNeed=10
			Bio
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=6
				Damage=128
				Poison=1
				MPCost=20
				LvlNeed=26
			Quake
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=8
				DmgType = 3
				Damage=200
				Attrib = list("earth")
				MPCost=40
				LvlNeed=48
			Tornado
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=6
				Weak = 1
				MPCost=20
				LvlNeed=51
			Sleep
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=3
				Sleep = 1
				MPCost=12
				LvlNeed=9
			Stop
				Select=1
				Target=1
				DType=3
				TType=3
				ATime=5
				Hold=1
				MPCost=15
				LvlNeed=18
			Dejon
				Select=1
				Target=2
				DType=4
				TType=2
				ATime=5
				Escape=1
				MPCost=4
				LvlNeed=12
			Drain
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=4
				HPDrain=30
				MPCost=18
				LvlNeed=36
			Osmose
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=4
				MPDrain=15
				MPCost=0
				LvlNeed=32
			Death
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=6
				Death=1
				MPCost=35
				LvlNeed=52
			Flare
				Select=1
				Target=1
				DType=3
				TType=3
				ATime=10
				Damage=336
				Attrib = list("fire")
				MPCost=50
				LvlNeed=58
			Meteo
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=30
				DmgType = 3
				Damage = 400
				Attrib = list("dark")
				MPCost=99
				HPDrain = -5
				LvlNeed=65
		Black_
			Muteable = 1
			invicon = "other"
			Fire1
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=2
				Damage=16
				Attrib = list("fire")
				MPCost=5
				LvlNeed=2
			Fire2
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=4
				Damage=64
				Attrib = list("fire")
				MPCost=15
				LvlNeed=14
			Ice1
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=2
				Damage=16
				Attrib = list("ice")
				MPCost=5
				LvlNeed=1
			Ice2
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=4
				Damage=64
				Attrib = list("ice")
				MPCost=15
				LvlNeed=13
			Bolt1
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=2
				Damage=16
				Attrib = list("bolt")
				MPCost=5
				LvlNeed=5
			Bolt2
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=4
				Damage=64
				Attrib = list("bolt")
				MPCost=15
				LvlNeed=16
			Poison
				Select=1
				Target=0
				DType=3
				TType=1
				ATime=2
				Poison=1
				MPCost=2
				LvlNeed=10
			Bio
				Select=1
				Target=0
				DType=3
				TType=3
				ATime=6
				Damage=128
				Poison=1
				MPCost=20
				LvlNeed=26
			Drain
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=4
				HPDrain=30
				MPCost=18
				LvlNeed=36
			Osmose
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=4
				MPDrain=15
				MPCost=0
				LvlNeed=32
			Death
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=6
				Death=1
				MPCost=35
				LvlNeed=52
			Meteo
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=40
				DmgType = 3
				Damage = 400
				Attrib = list("dark")
				MPCost=99
				HPDrain = -5
				LvlNeed=65
		White
			Muteable = 1
			Modifier=1
			Cure1
				Select=1
				Target=0
				DType=2
				TType=3
				ATime=2
				Damage=16
				Attrib = list("healing")
				MPCost=3
				LvlNeed=1
				CanUse = 0
			Cure2
				Select=1
				Target=0
				DType=2
				TType=3
				ATime=4
				Damage=48
				Attrib = list("healing")
				MPCost=9
				LvlNeed=14
				CanUse = 0
			Cure3
				Select=1
				Target=0
				DType=2
				TType=3
				ATime=6
				Damage=144
				Attrib = list("healing")
				MPCost=18
				LvlNeed=30
				CanUse = 0
			Cure4
				Select=1
				Target=0
				DType=2
				TType=3
				ATime=8
				Damage=288
				Attrib = list("healing")
				MPCost=50
				LvlNeed=38
				CanUse = 0
			Life1
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=4
				MPCost=8
				Revive=10
				LvlNeed=12
			Life2
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=9
				MPCost=52
				Revive=100
				LvlNeed=45
			Esuna
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=3
				Esuna=1
				MPCost=20
				LvlNeed=18
			Dispel
				Select=1
				Target=1
				DType=3
				TType=3
				ATime=5
				Dispell=1
				MPCost=12
				LvlNeed=31
			Reflect
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=6
				Reflect=1
				MPCost=30
				LvlNeed=36
			Libra
				Select=1
				Target=1
				DType=3
				TType=3
				ATime=4
				Scan=1
				MPCost=1
				LvlNeed=8
			Blink
				Select=1
				Target=1
				DType=2
				TType=2
				ATime=6
				Blink=1
				MPCost=8
				LvlNeed=23
			Levitate
				Select=1
				Target=1
				DType=0
				TType=3
				ATime=4
				Float=1
				MPCost=8
				LvlNeed=32
			Protect
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=6
				Protect=1
				MPCost=9
				LvlNeed=12
			Shell
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=6
				Shell=1
				MPCost=10
				LvlNeed=29
			Confuse
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=4
				Confuse = 1
				MPCost=10
				LvlNeed=24
			Silence
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=4
				Mute=1
				MPCost=6
				LvlNeed=15
			Slow
				Select=1
				Target=1
				DType=3
				TType=3
				ATime=4
				Slow = 1
				MPCost=14
				LvlNeed=10
			Haste
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=6
				Haste=1
				MPCost=25
				LvlNeed=33
			Hold
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=6
				Hold=1
				MPCost=5
				LvlNeed=7
			Teleport
				Select = 1
				Target = 1
				DType = 0
				TType = 0
				ATime = 6
				MPCost = 10
				LvlNeed = 20
				CanUse = 2
			Holy
				Select=1
				Target=1
				DType=3
				TType=3
				ATime=16
				Damage=336
				Attrib = list("holy")
				MPCost=46
				LvlNeed=55
		White_
			Muteable = 1
			Modifier=1
			Cure1
				Select=1
				Target=0
				DType=2
				TType=3
				ATime=2
				Damage=16
				Attrib = list("healing")
				MPCost=3
				LvlNeed=1
				CanUse = 0
			Cure2
				Select=1
				Target=0
				DType=2
				TType=3
				ATime=4
				Damage=48
				Attrib = list("healing")
				MPCost=9
				LvlNeed=14
				CanUse = 0
			Life1
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=4
				MPCost=8
				Revive=10
				LvlNeed=12
			Esuna
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=3
				Esuna=1
				MPCost=20
				LvlNeed=18
			Libra
				Select=1
				Target=1
				DType=3
				TType=3
				ATime=4
				Scan = 1
				MPCost=1
				LvlNeed=8
			Teleport
				Select = 1
				Target = 1
				DType = 0
				TType = 0
				ATime = 6
				MPCost = 10
				LvlNeed = 20
				CanUse = 2
		White__
			Muteable = 1
			Modifier=1
			Cure1
				Select=1
				Target=0
				DType=2
				TType=3
				ATime=2
				Damage=16
				Attrib = list("healing")
				MPCost=3
				LvlNeed=1
				CanUse = 0
			Libra
				Select=1
				Target=1
				DType=3
				TType=3
				ATime=4
				Scan = 1
				MPCost=1
				LvlNeed=8
			Hold
				Select=1
				Target=1
				DType=2
				TType=3
				ATime=6
				Hold=1
				MPCost=5
				LvlNeed=7
		Summon_
			Muteable = 1
			ASType=1
			AAType = 2
			Modifier = 0
			DmgType = 3
			CanUse = 1
			invicon = "other"
			BChocobo
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=4
				Damage=50
				Attrib = list("piercing")
				MPCost=10
				LvlNeed=1
			Bomb
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				DmgType = 2
				Suicide = 1
				ATime=2
				MPCost=15
				LvlNeed = 10
			SdwDragon
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=4
				Damage=100
				Hold = 1
				Death = 1
				Attrib = list("dark")
				MPCost = 20
				LvlNeed = 15
			Golem
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				ATime = 30
				Golem = 1
				MPCost = 50
				LvlNeed = 25
			Hades
				Select = 1
				Target = 2
				DType = 4
				TType = 1
				ATime = 10
				Damage = 240
				Darkness = 1
				Poison = 1
				Slow = 1
				Confuse = 1
				Curse = 1
				Countdown = 1
				Attrib = list("dark")
				MPCost = 50
				LvlNeed = 50
			DarkDrgn
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=16
				Damage=340
				Attrib = list("dark")
				MPCost=60
				LvlNeed=60
		Summon
			Muteable = 1
			ASType=1
			AAType = 2
			Modifier = 0
			DmgType = 3
			CanUse = 1
			invicon = "other"
			Imp
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				DmgType = 2
				ATime = 1
				Damage = 10
				MPCost=1
				LvlNeed = 1
			Chocobo
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=4
				Damage=40
				Attrib = list("piercing")
				MPCost=7
				LvlNeed=3
			Bomb
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				DmgType = 2
				Suicide = 1
				ATime=2
				MPCost=10
				LvlNeed = 10
			Flayer
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				DmgType = 2
				Damage = 50
				ATime=2
				Hold = 1
				Attrib = list("bolt")
				MPCost=18
				LvlNeed = 12
			Cocktric
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=2
				Stone = 1
				MPCost=15
			Sylph
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=10
				Damage = 100
				Sylph = 30
				Attrib = list("wind")
				MPCost=25
				LvlNeed = 40
			Mist
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=6
				Damage=100
				MPCost=20
				LvlNeed=10
			Shiva
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=8
				Damage=110
				Attrib = list("ice")
				MPCost=30
				LvlNeed=15
			Ifrit
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=8
				Damage=120
				Attrib = list("fire")
				MPCost=30
				LvlNeed=18
			Ramuh
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=8
				Damage=130
				Attrib = list("bolt")
				MPCost=30
				LvlNeed=23
			Titan
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=8
				Damage=160
				Attrib = list("earth")
				MPCost=40
				LvlNeed=28
			Odin
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=12
				Death = 1
				MPCost=42
				LvlNeed=40
			Leviathan
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=10
				Damage=220
				Attrib = list("water")
				MPCost=50
				LvlNeed=45
			Asura
				Select=1
				Target=2
				DType=1
				TType=2
				ATime=10
				Asura=1
				Attrib = list("healing")
				MPCost=50
				LvlNeed=50
			Pheonix
				Select = 1
				Target = 2
				DType = 4
				TType = 1
				ATime = 10
				Damage = 200
				Pheonix = 20
				Attrib = list("fire")
				MPCost = 80
				LvlNeed = 55
			Bahamut
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=16
				Damage=300
				Attrib = list("fire")
				MPCost=60
				LvlNeed=60
		Ninjutsu
			DmgType = 3
			Katon
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=6
				Damage=80
				Attrib = list("fire")
				ASType = 1
				AAType = 1
				Modifier = 0
				Muteable = 1
				CanUse = 1
				MPCost=15
				LvlNeed=22
			Suiton
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=6
				Damage=120
				ASType = 1
				AAType = 1
				Modifier = 0
				Muteable = 1
				CanUse = 1
				Attrib = list("water")
				MPCost=20
				LvlNeed=25
			Raijin
				Select=1
				Target=2
				DType=4
				TType=1
				ATime=6
				Damage=160
				ASType = 1
				AAType = 1
				Modifier = 0
				Muteable = 1
				CanUse=1
				Attrib = list("bolt")
				MPCost=25
				LvlNeed=30
			Needles
				Select=1
				Target=1
				DType=3
				TType=1
				ATime=4
				ASType = 1
				AAType = 1
				Curseable = 1
				Hold=1
				CanUse = 1
				MPCost=5
				LvlNeed=32
			Image
				Select=1
				Target=1
				DType=0
				TType=0
				ATime=4
				ASType = 1
				AAType = 1
				CanUse = 1
				Curseable = 1
				Blink = 1
				MPCost=6
				LvlNeed=40
			Smoke
				ASType = 1
				AAType = 1
				CanUse = 1
				Curseable = 1
				Escape = 1
				MPCost=10
				LvlNeed=35
		Sing
			ASType=0
			AAType=2
			Muteable = 1
			Praise
				Select = 1
				Target = 0
				DType = 2
				TType = 2
				Strengthen = 1
				ATime = 16
				LvlNeed = 10
			Courage
				Select = 1
				Target = 0
				DType = 2
				TType = 2
				Protect = 1
				ATime = 16
				LvlNeed = 15
			Wisdom
				Select = 1
				Target = 0
				DType = 2
				TType = 2
				Shell = 1
				ATime = 18
				LvlNeed = 25
			Strength
				Select = 1
				Target = 0
				DType = 2
				TType = 2
				Berserk = 1
				ATime = 22
				LvlNeed = 35
			Secrets
				Select = 1
				Target = 0
				DType = 2
				TType = 2
				Blink = 1
				ATime = 25
				LvlNeed = 40
			Inspire
				Select = 1
				Target = 0
				DType = 2
				TType = 2
				Haste = 1
				ATime = 15
				LvlNeed = 37
			Lullaby
				Select = 1
				Target = 0
				DType = 3
				TType = 1
				Sleep = 1
				ATime = 4
				LvlNeed = 1
			Weaken
				Select = 1
				Target = 0
				DType = 3
				TType = 1
				Cry = 1
				ATime = 18
				LvlNeed = 35
			Paralyze
				Select = 1
				Target = 0
				DType = 3
				TType = 1
				Hold = 1
				ATime = 12
				LvlNeed = 40
			Silence
				Select = 1
				Target = 0
				DType = 3
				TType = 1
				Mute = 1
				ATime = 10
				LvlNeed = 41
			Curses
				Select = 1
				Target = 0
				DType = 3
				TType = 1
				Curse = 1
				ATime = 10
				LvlNeed = 42
			Suffer
				Select = 1
				Target = 0
				DType = 3
				TType = 1
				Poison = 1
				ATime = 20
				LvlNeed = 43
		Twin
			Muteable = 1
			ASType=1
			AAType=2
			DmgType=2
			CanUse = 1
			Flare
				Select=1
				Target=1
				DType=3
				TType=3
				ATime=20
				Damage=150
				Attrib = list("fire")
				MPCost=10
				LvlNeed=10
			Comet
				Select=1
				Target=2
				DType=4
				TType=3
				ATime=28
				Damage=450
				Attrib = list("dark")
				MPCost=20
				LvlNeed=18
		Blue
			Modifier = 0
			invicon = "other"
			Aero
				Select = 1
				Target = 0
				DType = 3
				TType = 3
				ATime = 4
				Damage = 16
				Attrib = list("wind")
				MPCost = 5
				LvlNeed = 1
			Aero2
				Select = 1
				Target = 0
				DType = 3
				TType = 3
				ATime = 8
				Damage = 64
				Attrib = list("wind")
				MPCost = 15
				LvlNeed = 16
			Aero3
				Select = 1
				Target = 0
				DType = 3
				TType = 3
				ATime = 12
				Damage = 254
				Attrib = list("wind")
				MPCost = 30
				LvlNeed = 34
			Water1
				Select = 1
				Target = 0
				DType = 3
				TType = 3
				ATime = 4
				Damage = 16
				Attrib = list("water")
				MPCost = 5
				LvlNeed = 3
			Water2
				Select = 1
				Target = 0
				DType = 3
				TType = 3
				ATime = 8
				Damage = 64
				Attrib = list("water")
				MPCost = 15
				LvlNeed = 17
			Water3
				Select = 1
				Target = 0
				DType = 3
				TType = 3
				ATime = 12
				Damage = 254
				Attrib = list("water")
				MPCost = 30
				LvlNeed = 35
			Regen
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 20
				Regen = 1
				MPCost = 20
				LvlNeed = 20
			Berserk
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 10
				Berserk = 1
				MPCost = 25
				LvlNeed = 23
			Guard
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				ATime = 15
				Guard = 1
				MPCost = 99
				LvlNeed = 55
			Curse
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 5
				Curse=1
				MPCost = 15
				LvlNeed = 20
			Weaken
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 6
				Cry=1
				MPCost = 25
				LvlNeed = 25
			Doom
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 10
				Countdown = 1
				MPCost = 20
				LvlNeed = 35
			Petrify
				Select = 1
				Target = 1
				DType = 3
				TType = 1
				ATime = 15
				Stone = 1
				MPCost = 25
				LvlNeed = 32
			Difference
				name = "??????"
				Select = 1
				Target = 1
				DType = 3
				TType = 3
				ATime = 7
				Difference = 1
				MPCost = 10
				LvlNeed = 27
			Twister
				Select = 1
				Target = 1
				DType = 3
				TType = 3
				ATime = 20
				Damage = 300
				Confuse = 1
				Attrib = "wind"
				MPCost = 45
				LvlNeed = 52
			Eclipse
				Select = 1
				Target = 1
				DType = 3
				TType = 3
				ATime = 20
				Damage = 310
				Sleep = 1
				Attrib = "dark"
				MPCost = 50
				LvlNeed = 53
			Attack
				name = "2xAttack"
				Select = 1
				Target = 1
				DType = 3
				TType = 3
				ATime = 4
				ASType = 0
				AAType = 0
				Damage = 200
				DmgType = 1
				MPCost = 30
				LvlNeed = 45
			Astral
				Select = 1
				Target = 2
				DType = 4
				TType = 1
				ATime = 40
				DmgType = 3
				Damage = 350
				MPCost = 99
				LvlNeed = 65
		Create
			invicon = "potion"
			ASType = 0
			AAType = 1
			CanUse = 1
			Curseable = 1
			Cure1
				Select = 1
				Target = 1
				DType = 2
				TType = 2
				HPHeal = 100
				ATime = 4
				LvlNeed = 1
			Cure2
				Select = 1
				Target = 1
				DType = 2
				TType = 2
				HPHeal = 500
				ATime = 8
				LvlNeed = 10
			Cure3
				Select = 1
				Target = 1
				DType = 1
				TType = 2
				HPHeal = 2000
				ATime = 16
				LvlNeed = 30
			Life
				Select = 1
				Target = 1
				DType = 1
				TType = 2
				Revive = 10
				ATime = 10
				LvlNeed = 20
			Ether
				Select = 1
				Target = 1
				DType = 1
				TType = 2
				MPHeal = 50
				ATime = 40
				LvlNeed = 45
			Ether2
				Select = 1
				Target = 1
				DType = 1
				TType = 2
				MPHeal = 200
				ATime = 60
				LvlNeed = 50
			Heal
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				HPHeal = 100
				ATime = 5
				LvlNeed = 5
			Heal2
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				HPHeal = 500
				ATime = 10
				LvlNeed = 15
			Heal3
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				HPHeal = 2000
				ATime = 20
				LvlNeed = 40
			TEther
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				MPHeal = 50
				ATime = 70
				LvlNeed = 55
			TEther2
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				MPHeal = 200
				ATime = 80
				LvlNeed = 65
			Dispel
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				Dispell = 1
				ATime = 10
				LvlNeed = 17
			Remedy
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				Esuna = 1
				ATime = 10
				LvlNeed = 16
			Elixer
				Select = 1
				Target = 1
				DType= 1
				TType = 2
				HPHeal = 9999
				MPHeal = 999
				ATime = 90
				LvlNeed = 70
			MElixer
				Select = 1
				Target = 2
				DType = 1
				TType = 2
				HPHeal = 9999
				MPHeal = 999
				ATime = 100
				LvlNeed = 90
			Bomb1
				Select = 1
				Target = 0
				DType = 3
				TType = 1
				DmgType = 2
				Modifier = 0
				Damage = 50
				Attrib = list("fire")
				ATime = 3
				LvlNeed = 3
			Bomb2
				Select = 1
				Target = 0
				DType = 3
				TType = 1
				DmgType = 2
				Modifier = 0
				Damage = 100
				Attrib = list("fire")
				ATime = 6
				LvlNeed = 21
			Bomb3
				Select = 1
				Target = 0
				DType = 3
				TType = 1
				DmgType = 2
				Modifier = 0
				Damage = 200
				Attrib = list("fire")
				ATime = 10
				LvlNeed = 34
	RSkills


