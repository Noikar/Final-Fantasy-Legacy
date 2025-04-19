var/const/max_ppl_party = 5
mob/PC
	var/row_position = 1 // 1 = Front Row, 2 = Back Row
	var/tmp
		list/party
		formation
		inparty
		pstatus
		pmoves
		bosspanel = 0
		tmp_reorder_member

	proc
		ToggleRow()
			if(!party || party.len <= 1)
				row_position = (row_position == 1) ? 2 : 1
				info(src, null, "Your row position has been toggled.")
				return

			if(src != party[1])
				src << "<span class='warning'>Only the party leader can change the party's row formation.</span>"
				return

			alternate_rows( (party[1].row_position == 1) ? 2 : 1 )
			info(src, party, "Party row formation has been toggled.")
			
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
			alternate_rows(1) // Always start with front row
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
									M.alternate_rows( M.row_position )
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

		alternate_rows(start_row = 1) // Accepts 1 (front) or 2 (back)
			for(var/i = 1, i <= party.len, i++)
				var/mob/PC/p = party[i]
				if(p)
					if(start_row == 1) // Start with Front
						p.row_position = (i % 2 == 1) ? 1 : 2 // Odd index = front (1), Even index = back (2)
					else // Start with Back (start_row == 2)
						p.row_position = (i % 2 == 1) ? 2 : 1 // Odd index = back (2), Even index = front (1)

		ReorderParty()
			// --- Checks ---
			if (!party || party.len <= 1)
				src << "<span class='warning'>You need more than one member to reorder the party.</span>"
				return
			if (src != party[1])
				src << "<span class='warning'>Only the party leader can reorder members.</span>"
				return
			if (inbattle)
				src << "<span class='warning'>Cannot reorder party during battle.</span>"
				return
			// --- End Checks ---

			// --- Select Member to Move ---
			var/list/movable_members = party.Copy()
			movable_members.Remove(src) // Leader always stays first

			if (!movable_members.len)
				src << "<span class='warning'>No other members to reorder.</span>"
				return

			// Use input() to select the member to potentially move
			var/mob/PC/member_to_move = input(src, "Select member to move:", "Reorder Party") as null|anything in movable_members
			if (!member_to_move || !party.Find(member_to_move)) // Check if cancelled or member somehow invalid
				return

			// --- Initiate Target Position Selection ---
			tmp_reorder_member = member_to_move // Store the member being moved
			inmenu = "reorder_target"           // Set the new menu state
			menupos = party.Find(member_to_move) // Start cursor at current position
			menu_target_position(null)           // Call proc to create cursor and handle targeting
			return						

		menu_target_position(direction)
			if (!tmp_reorder_member) // Safety check if called incorrectly
				close_allscreen()
				return

			var/old_position_index = party.Find(tmp_reorder_member)

			if (!direction) // Initial call - set cursor position
				menupos = old_position_index
			else // Handle N/S/C/X input
				switch(direction)
					if("N") // Move Cursor Up
						menupos--
						if (menupos < 2) menupos = party.len // Wrap around (skip leader pos 1)
					if("S") // Move Cursor Down
						menupos++
						if (menupos > party.len) menupos = 2 // Wrap around (skip leader pos 1)
					if("C") // Confirm Selection (Swap Logic)
						var/new_position_index = menupos

						if (old_position_index == new_position_index)
							src << "<span class='notice'>They're already in that position.</span>"

							// No change needed, just reset state and exit
							tmp_reorder_member = null
							inmenu = "menu"
							if(cursor) del(cursor)
							screen("menu") // Go back to main menu
							return

						// --- Perform SWAP ---
						var/mob/PC/member_at_new_pos = party[new_position_index] // Get member at target slot
						party[new_position_index] = tmp_reorder_member          // Put selected member in target slot
						party[old_position_index] = member_at_new_pos          // Put target slot member in selected member's old slot

						// --- Update Party State ---
						update_party() // This handles updating inparty numbers based on new list order

						// Re-apply row alternation based on leader's current preference
						alternate_rows( party[1].row_position ) // Pass leader's current row (1 or 2)

						// Refresh menu for all party members
						for (var/mob/PC/p in party)
							if (p.client && (p.inmenu == "menu" || p.inmenu == "reorder_target") )
								p.screen("menu") // Redraw the main menu

						info(src, party, "Party order updated.")

						// --- Cleanup ---
						tmp_reorder_member = null
						inmenu = "menu" // Go back to main menu state
						if(cursor) del(cursor)
						// screen("menu") is called within the loop above
						return // Exit after confirmation

					if("X") // Cancel
						tmp_reorder_member = null
						inmenu = "menu"
						if(cursor) del(cursor)
						screen("menu") // Go back to main menu
						return

			// --- Update Cursor Position ---
			if(!cursor) cursor = new(client)

			// Map menupos (party index 2-5) to screen Y coordinate for cursor
			var/cursor_y
			switch(menupos)
				// Position 1 is leader, not selectable here
				if(2) cursor_y = 11 // Y-coord for 2nd member on menu
				if(3) cursor_y = 8  // Y-coord for 3rd member on menu
				if(4) cursor_y = 5  // Y-coord for 4th member on menu
				if(5) cursor_y = 3  // Y-coord for 5th member on menu
				else cursor_y = 11 // Default fallback (shouldn't happen with wrapping)

			// Place cursor to the left of the portrait area (adjust X as needed)
			cursor.screen_loc = "1,[cursor_y]:8"


mob/PC/var/tmp
	isMoving = 0	//This is used to check if the player is moving. If so, further movement is not allowed until current movement stops and the var is reset.

mob/PC/Move()
	if (src.isMoving)
		return 0

	src.isMoving = 1
	spawn(world.tick_lag)
		if(src) src.isMoving = 0

	var/original_x = src.x
	var/original_y = src.y
	var/original_z = src.z

	var/move_result = ..()

	if (move_result == 1 && party && src == party[1] && !inbattle)
		var/leader_moved_dir = get_dir(locate(original_x, original_y, original_z), src)
		var/moved_dir = leader_moved_dir

		for(var/i = 2; i <= party.len; i++)
			var/mob/PC/p = party[i]
			var/mob/PC/m = party[i-1]

			if(!p || !m) continue

			if(get_dist(p, m) >= 2 || get_dist(p, src) > i)
				step_to(p, m, 0)
				p.dir = m.dir
				moved_dir = null
			else if (moved_dir)
				if (step(p, moved_dir))
					// Keep moved_dir for the next follower
					continue
				else
					moved_dir = null // Stop chain if blocked
			else
				moved_dir = null // Ensure chain stops if previous didn't move via direction

	return move_result