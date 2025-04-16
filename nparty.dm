var/const/max_ppl_party = 5
mob/PC
	var/tmp/list/party
	var/tmp
		formation
		inparty
		pstatus
		pmoves
		bosspanel = 0
	proc
		move_party()
			for(var/mob/PC/p in party)
				var/mob/PC/leader
				p.density = 0
				p.pmoves = null
				if(p.inparty == 1) {p.density = 1;leader = 1}
				else p.loc = leader.loc
		lock_party()
			set category="Party"
			set desc="Lock the party so nobody can join"
			pstatus=0
			verbs+=/mob/PC/proc/unlock_party
			verbs-=/mob/PC/proc/lock_party
		unlock_party()
			set category="Party"
			set desc="Unlock the party so anyone can join"
			pstatus=1
			verbs+=/mob/PC/proc/lock_party
			verbs-=/mob/PC/proc/unlock_party
		kick_member()
			set category="Party"
			set desc="Kick a member from the party"
			if(party.len==1){info(,list(src),"No one to kick out.");return}
			else if(src!=party[1]){info(,list(src),"Only the party leader may do this.");return}
			var/mob/PC/pkick = input(src,"Kick whom from party?","Kick") as null|anything in party
			if(pkick==src){info(,list(src),"Kickin' yourself eh? Why don't you leave instead?");return}
			else if(pkick&&party.Find(pkick)) pkick.leave_party()
		setup_party()
			density=1
			party=list(src)
			inparty=1
			pstatus=0
			pmoves=null
			verbs+=/mob/PC/proc/join_party
			verbs+=/mob/PC/proc/unlock_party
			verbs-=/mob/PC/proc/leave_party
			verbs-=/mob/PC/proc/lock_party
			verbs-=/mob/PC/proc/kick_member
		update_party()
			var/party_slots
			for(var/mob/PC/p in party)
				party_slots++
				p.inparty=party_slots
				if(party_slots>1)
					p.density=0
					p.verbs-=/mob/PC/proc/join_party
					p.verbs-=/mob/PC/proc/unlock_party
					p.verbs+=/mob/PC/proc/leave_party
					p.verbs-=/mob/PC/proc/lock_party
					p.verbs-=/mob/PC/proc/kick_member
				else
					p.density=1
					if(length(party)>1){p.verbs-=/mob/PC/proc/join_party;p.verbs+=/mob/PC/proc/leave_party;p.verbs+=/mob/PC/proc/kick_member}
					else {p.verbs+=/mob/PC/proc/join_party;p.verbs-=/mob/PC/proc/leave_party;p.verbs-=/mob/PC/proc/kick_member}
					if(p.pstatus){p.verbs-=/mob/PC/proc/unlock_party;p.verbs+=/mob/PC/proc/lock_party}
					else {p.verbs-=/mob/PC/proc/lock_party;p.verbs+=/mob/PC/proc/unlock_party}
		join_party()
			set category="Party"
			set desc="Join someone's party"
			if(party.len>1){info(null,list(src),"Your already in a party.");return}
			for(var/mob/PC/M in get_step(src,dir))
				if(M&&M.inparty==1)
					if(!M.inmenu)
						if(!M.bosspanel&&!bosspanel) // new addition cancels joining parties again this is here to stop a huge crash when people are trying to join a party while someone is on a boss panel
							if(M.pstatus)
								if(length(M.party)<max_ppl_party)
									M.party+=src
									party = M.party
									M<<sound(SOUND_JOIN)
									for(var/mob/PC/p in M.party)
										if(p!=src) info(null,list(p),"[src] has joined the party.")
										else info(null,list(p),"You joined with [M] to fight against the evils!")
									M.update_party()
									M.party_gt()
									return
								else info(null,list(src),"Cannot join party (full).")
							else info(null,list(src),"Cannot join party (locked).")
						else info(null,list(src),"Cannot join party (boss).") //same reason for addition as stated above.
					else info(null,list(src),"Cannot join party (leader seems busy).")
		leave_party()
			set category="Party"
			set desc="Leave the current party"
			if(length(party) == 1)
				if(inbattle) EndBattle(list(src))
				return
			party-=src
			var/mob/PC/M = party[1] // setting new leader
			for(var/mob/PC/p in M.party)
				if(!p) continue
				if(!inbattle) p.close_allscreen()
				p.party-=src
				info(null,list(p),"[src] has left the party.")
			if(length(M.party)>1) M.update_party()	// updating the party
			else M.setup_party()
			setup_party()		// reseting source party
			info(,list(src),"You left the party.")
			// party is ok, now checking if in battle and stuff
			if(inbattle) EndBattle(list(src))
			else
				M.party_gt()
				close_allscreen()
		party_gt()
			if(!inmenu) inmenu="party_gt"
			for(var/mob/PC/p in party)
				walk_to(p,src,0)
				while("[p.x] [p.y] [p.z]"!="[src.x] [src.y] [src.z]") sleep(1)
				walk_to(p,0)
				p.dir = dir
				p.pmoves = null
			if(inmenu == "party_gt") inmenu=null

mob/PC/var/tmp
	isMoving = 0	//This is used to check if the player is moving. If so, further movement is not allowed until current movement stops and the var is reset.

mob/PC/Move()		// Overrides the base mob/Move specifically for PCs
	// --- Cooldown Check ---
	if (src.isMoving)
		return 0	// Block move if already moving

	// --- Set Cooldown ---
	src.isMoving = 1
	spawn(world.tick_lag) 		// Adjust multiplier based on animation speed
		if(src) src.isMoving = 0	// Reset after delay

	// --- Party Pre-Move Logic ---
	if(party && src == party[1] && !inbattle)
		for(var/mob/PC/p in party)
			if(p.inparty != 1)
				var/mob/PC/m = party[p.inparty - 1]
				if(get_dist(m, p) == 1) p.pmoves = m.dir
				else if(get_dist(m, p) >= 2) p.pmoves = "OUTOFSIGHT"
				else p.pmoves = null

	// --- Execute Original Move ---
	var/move_result = ..() // Calls the original mob/Move logic

	// --- Party Post-Move Logic ---
	if(party && src == party[1] && !inbattle)
		if (move_result == 1) // Only move followers if leader's move started
			for(var/mob/PC/p in party)
				if(p.inparty != 1)
					var/mob/PC/m = party[p.inparty - 1]
					if(p.pmoves == "OUTOFSIGHT")
						// Use step_to for smoother teleport/catch-up
						step_to(p, m, 0)
						p.dir = m.dir // Match direction
					else if(p.pmoves)
						step(p, p.pmoves)
					p.pmoves = null // Clear stored move
		else // Leader move failed, clear follower intentions
			for(var/mob/PC/p in party)
				if(p.inparty != 1) p.pmoves = null


	return move_result
