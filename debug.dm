//debug verbs
#define DEBUG



//What we need to do is run the game itself, and then when the bug occurs use this verb.


mob
	Host
		proc
			Debug()
				set category = "Hst Cmds"
				set desc = "Use this when the battle bug (no heads) occurs, and/or when the grant-icon command starts deleting verbs."
				src << "<b>Debugging verb list:</b>"
				for(var/V in src.verbs)
					src << "Verb: [V]"
				src << "<b>Debugging client overlays: [src.overlays.len] overlay\s</b>"
				src << "<b>Debugging world overlays:</b>"
				var/over
				for(var/atom/A in world)
					over += A.overlays.len
				//	src << "[A]'s overlays: [A.overlays.len]"
				usr << "[over] global overlay\s."
