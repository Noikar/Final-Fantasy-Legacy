//# world setting
world
//	status="Official FFL server"
	hub = "Lunaofthemoon.FinalFantasyLegacy"
	name = "FINAL FANTASY Legacy"
	tick_lag=DEFAULT_PRIORITY
	mob=/mob/character
	view=8
	New()
		..()
		//loading world settings
		var/savefile/World = new("saves/world.sav")
		if(World["GMList"]) World["GMList"]>>GMList
		if(World["MuteList"]) World["MuteList"]>>MuteList
		if(World["WSayBanList"]) World["WSayBanList"]>>WSayBanList
		if(World["IPMuteList"]) World["MuteList"]>>IPMuteList
		if(World["BanList"]) World["BanList"]>>BanList
		if(World["IPBanList"]) World["BanList"]>>IPBanList
		if(World["WCensor"]) World["WCensor"]>>WCensor
		//initializing..
		spawn()
			battle_initialize()
			ferry_initialize()
		if(fexists("ClanCheck.htm"))
			ClanCheck = file2text("ClanCheck.htm")
	Del()
		//saving world settings
		var/savefile/World = new("saves/world.sav")
		if(GMList) World["GMList"]<<GMList
		if(MuteList) World["MuteList"]<<MuteList
		if(WSayBanList) World["WSayBanList"]<<WSayBanList
		if(IPMuteList) World["IPMuteList"]<<IPMuteList
		if(BanList) World["BanList"]<<BanList
		if(IPBanList) World["IPBanList"]<<IPBanList
		if(WCensor) World["WCensor"]<<WCensor
		..()

//# world var/proc
var/list/GAME_OWNER = list("Lunaofthemoon"="Head Admin")
var/list/GAME_HOST = list("Lunaofthemoon")
var/LOGFILE="ffl.log"							// Log file
//tick lag stuff
var/const/DEFAULT_PRIORITY = 1
var/const/HIGH_PRIORITY = 1
var/const/NORMAL_PRIORITY = 2
var/const/LOW_PRIORITY = 3
var/const/VERYLOW_PRIORITY = 4

var/savefile/CR_Key = new("saves/cr_key.sav")
var/savefile/CR_IP = new("saves/cr_ip.sav")
var/list/Submit = new("saves/submit.sav")
var/list/Defeated_Bosses[] = new()
var/list/ClientIP[] = new()					// Multiples connections
var/list/WCensor[] = new()					// Word censor list
var/list/GMList[] = GAME_OWNER				// GMs list
var/list/MuteList = new()					// mute list
var/list/WSayBanList = new()
var/list/IPMuteList = new()					// IP Mute list
var/list/BanList = new()					// Ban list
var/list/IPBanList = new()					// IP Ban list
var/list/color_list = list("Black"="#000000","White"="#FFFFFF","Blue"="#0000FF","Dark Blue"="#00008B","Red"="#FF0000","Dark Red"="#8B0000","Green"="#008000","Dark Green"="#006400","Orange"="#FFA500","Dark Orange"="#FF8C00","Teal"="#008080","Tan"="#D2B48C","Turquoise"="#40E0D0","Cyan"="#00FFFF","Dark Cyan"="#008B8B","Steelblue"="#4682B4","Skyblue"="#87CEEB","Magenta"="#FF00FF","Dark Magenta"="#8B008B","Light Grey"="#D3D3D3","Gray"="#808080","Yellow"="#FFFF00")
var/const/max_ip_allowed=2					// maximum number of connection from the same IP address.
var/const/max_text_len=400 					// max message len, in letter.
var/const/max_away_len=50					// max away message len
// allow how many line (flood_lines) for a period of time (flood_interval)
var/const/flood_lines=12					// gives 12 lines max
var/const/flood_interval=450				// for 45 secs.
var/const/repeat_num=4 						// allow how many repeats
var/const/max_swearing=5					// how swear allowed by line (triggering it will give a warning)
var/const/mute_time=2000 					// mute time
var/const/ban_time=4000 					// ban time after user reached max_warning
var/const/max_warning=2 					// max warning before auto-ban
var/const/announce_wait_time=200 			// wait time for the announcement
var/const/game_version = "5.6"				// game version
var/global/chat=1							// global var to turn on/off chat

client/preload_rsc = 2						// preload resources

mob
	verb/FAQ()
		set category="Social"
		if(fexists("faq.htm")) usr<<browse(file("faq.htm"))
	verb/Enable_special_class()
		set category = "Social"
		set desc = "Enable any bonus class"
		var/s_class = input("Which class?") in list("Dark Knight","Black Knight","Lunarian","Young Caller","Sage")
		var/savefile/F = new("saves/[copytext(src.ckey,1,2)]/[src.ckey].sav")
		F.cd = "/bonus/"
		var/list/allowed_characters = new()
		if(F["characters"]) F["characters"] >> allowed_characters
		if(!allowed_characters.Find(s_class))
			allowed_characters += s_class
			F["characters"] << allowed_characters
		else info(,list(src),"You already have this class unlocked.")
	character
		density=0
		Login()
			spawn()
				if(isBan(usr)) return
				if(isHeadAdmin(usr))
					for(var/X in typesof(/mob/Head_Admin/proc)) usr.verbs += X
					for(var/X in typesof(/mob/Admin/proc)) usr.verbs += X
					for(var/X in typesof(/mob/Head_GM/proc)) usr.verbs += X
					for(var/X in typesof(/mob/GM/proc)) usr.verbs += X
					for(var/X in typesof(/mob/Mod/proc)) usr.verbs += X
				//locating to the starting screen
				usr.loc=locate(/area/intro_screen)
				//crystal music..
				usr<<sound(MUSIC_CRYSTAL,1,0,1)
				//setting 'inmenu' so the users can press CENTER to make the loading screen popup
				spawn(10) if(inmenu=="intro_screen") screen_textl(5,13,1,1,16,24,2,0,"� 1991 SQU�RE","intro_screen")
				inmenu="intro_screen"
			..()

proc
	Log(logtext as text)
		file(LOGFILE)<<"[time2text(world.realtime,"MM/DD/YY hh:mm:ss")] - [logtext]"
	duration(ticks,flag)
		if(!ticks) return 0
		if(!flag) flag="WDHMS"
		var/duration
		if(findtext(flag,"W")&&(ticks/6048000)>=1) //6048000 = 1 week
			var/W = round(ticks/6048000)
			ticks-=(W*6048000)
			if(W>1) duration+="[W] weeks "
			else duration+="[W] week "
		if(findtext(flag,"D")&&(ticks/864000)>=1) //864000 = 1 day
			var/D = round(ticks/864000)
			ticks-=(D*864000)
			if(D>1) duration+="[D] days "
			else duration+="[D] day "
		if(findtext(flag,"H")&&(ticks/36000)>=1) //36000 = 1 hour
			var/H = round(ticks/36000)
			ticks-=(H*36000)
			if(H>1) duration+="[H] hours "
			else duration+="[H] hour "
		if(findtext(flag,"M")&&(ticks/600)>=1) //600 = 1 minute
			var/M = round(ticks/600)
			ticks-=(M*600)
			if(M>1) duration+="[M] minutes "
			else duration+="[M] minute "
		if(findtext(flag,"S")&&(ticks/10)>=1) //10 = 1 second
			var/S = round(ticks/10)
			ticks-=(S*10)
			if(S>1) duration+="[S] seconds "
			else duration+="[S] second "
		if(findtext(flag,"T")&&(ticks)>=1) duration+="[ticks] ms" //1 = 1 ticks (ms)
		return duration
	get_token(string,N,C)
		if(!string||!N||!C||!findtext(string,C)) return
		if(isnum(C)) C = ascii2text(C)
		var/token_s = text2num(copytext(N,1,findtext(N,ascii2text(45))))
		var/token_e = text2num(copytext(N,findtext(N,ascii2text(45))+1,0))
		if(token_e<token_s) return
		var/string_pos = 1
		var/token_pos = 1
		var/token
		while(string_pos<length(string))
			//Revert to findText() if this no longer functions.
			var/string_npos = findtextEx(string,C,string_pos,0)
			var/token_str = copytext(string,string_pos,string_npos)
			string_pos = string_npos + 1
			if(token_s <= token_pos && token_e >= token_pos) token = token + token_str + C
			else if(token_e < token_pos) break
			token_pos++
		return token
	info(mob/PC/s,list/TargList,text,silent)
		var
			s_name = "other"
			s_prefix = "*"
		if(silent) s_prefix = null
		if(s&&(isGM(s)||isAdmin(s)||isMod(s)||isHeadAdmin(s)||isHeadGM(s))) s_name = "gm"
		for(var/mob/PC/p in TargList)
			if(!p) continue
			var
				info_color = p.chat_color["info text"]
				name_color
			if(p.party && p.party.Find(s) && p!=s) name_color = p.chat_color["party name"]
			else if(p!=s) name_color = p.chat_color["[s_name] name"]
			else name_color = p.chat_color["own name"]
			var/message
			if(s_prefix) message += "<FONT COLOR=[info_color]>[s_prefix] "
			if(s) message += "<FONT COLOR=[name_color]>[s]</FONT> "
			if(text) message += "[text]</FONT>"
			p<<message
	chat(item,mob/PC/s,list/targlist,text)
		//it is possible to chat?
		if(!global.chat) if(!isGM(s)&&!isAdmin(s)&&!isMod(s)&&!isHeadAdmin(s)&&!isHeadGM(s)){info(,list(s),"World chat has been disabled.");return}
		else if(MuteList.Find("[s.key]")||IPMuteList.Find("[s.client.address]")){info(,list(s),"You're muted.");return}
		else if(IPMuteList.Find("[s.client.address]")){info(,list(src),"You're muted.");return}
		//limiting 'text' length and removing html code
		text = copytext(html_encode(text),1,max_text_len)
		while(findtext(text,"\n")) text = copytext(text,1,findtext(text,"\n")) + copytext(text,findtext(text,"\n")+1,0)
		//stripping everything bad from 'text' here
		var/swears
		if(item == "wsay"||item == "CSay"||item == "CEmote"||item == "wemote"||item == "GMSay"||item == "say"||item == "emote"||item == "whisper"||item == "psay")
			for(var/B in WCensor)
				while(findtext(text,B))
					text = copytext(text,1,findtext(text,B)) + WCensor[B] + copytext(text,findtext(text,B)+length(B),0)
					swears++
		//customizing 'from'
		var
			s_name
			s_text
			s_prefix
			s_suffix
		//setting prefix/suffix
		switch(item)
			if("wsay"){s_name = "other";s_text = "other";s_suffix=":"}
			if("msay"){s_name = "other";s_text = "other";s_prefix="(";s_suffix=" msays):"}
			if("wemote"){s_name = "other";s_text = "emote";s_prefix="* "}
			if("say"){s_name = "other";s_text = "other";s_prefix="(";s_suffix="):"}
			if("emote"){s_name = "other";s_text = "emote";s_prefix="* (";s_suffix=")"}
			if("whisper"){s_name = "other";s_text = "whisper";s_prefix="(";s_suffix=" whispers):"}
			if("psay"){s_name = "party";s_text = "party";s_prefix="(";s_suffix=" psays):"}
			if("GMSay"){s_name = "gm";s_text = "other";s_prefix="(";s_suffix=" GMSays):"}
			if("CSay"){s_name = "other";s_text = "clan";s_prefix="(";s_suffix=" CSays):"}
			if("CEmote"){s_name = "other";s_text = "clan emote";s_prefix="(";s_suffix=" CEmotes):"}
		//maybe it is a gm?
		if(isGM(s)||isAdmin(s)||isMod(s)||isHeadAdmin(s)||isHeadGM(s)) s_name = "gm"
		//now sending to everyone
		if(s.chat_toggle.Find(item))
			if(!s.chat_toggle[item])
				s << "* Your [item] channel is disabled."
				return
		for(var/mob/PC/p in targlist)
			if(!p || p.ignore_list.Find("[s.key]"))
				continue
			else if(p.chat_toggle.Find(item))
				if(!p.chat_toggle[item])
					continue
			var
				name_color
				text_color
			if(p.party && p.party.Find(s) && p!=s){name_color = p.chat_color["party name"];text_color = p.chat_color["party text"]}
			else if(p!=s){name_color = p.chat_color["[s_name] name"];text_color = p.chat_color["[s_text] text"]}
			else {name_color = p.chat_color["own name"];text_color = p.chat_color["[s_text] text"]}
			p<<"[s_prefix]<IMG CLASS=icon SRC=\ref[s.init_icon()] ICONSTATE='normal'> <FONT COLOR=[name_color]>[s]</FONT>[s_suffix] <FONT COLOR=[text_color]>[text]</FONT>"
		//checking for flood now
		if(s_name!="gm")
			if(s.flood) s.flood++
			else{s.flood++;spawn(flood_interval) if(s) s.flood=0}
			if(s.remember_txt==text) s.repeat++
			else{s.remember_txt=text;s.repeat=1}
			var/reason
			if(s.flood>=flood_lines){reason="Your keyboard will thank me for this";s.flood=0}
			else if(s.repeat>=repeat_num){reason="Repeat, repeat, repeat";s.repeat=s.repeat-1}
			else if(swears>=max_swearing) reason="Who did teach you all these evil words?"
			if(reason)
				s.warning++
				var/skey = "[s.key]"
				if(s.warning>=max_warning)
					AddBan(skey)
					spawn(ban_time) RemBan(skey)
					info(s,world,"has been auto-banned ([reason]).")
					del(s)
				else
					MuteList+=skey
					spawn(mute_time) MuteList-=skey
					info(s,world,"has been auto-muted ([reason]).")
	AddBan(BanKey,BanIP)
		//key banning
		if(BanKey)
			if(!GMList.Find(BanKey)) BanList[BanKey] += BanIP
			else return
		//ip banning
		if(BanIP) IPBanList[BanIP] += BanKey
	RemBan(BanKey)
		if(!BanKey) return
		IPBanList -= BanList[BanKey]
		BanList -= BanKey
	AddMute(MuteKey,MuteIP)
		//key muting
		if(MuteKey)
			if(!GMList.Find(MuteKey)) MuteList[MuteKey] += MuteIP
			else return
		//ip muting
		if(MuteIP) IPMuteList[MuteIP] += MuteKey
	RemMute(MuteKey)
		if(!MuteKey) return
		IPMuteList -= MuteList[MuteKey]
		MuteList -= MuteKey
	WordCensor(mob/PC/M)
		//creating html background
		var/html="<html><body bgcolor=#000000 text=#A0A0DD link=blue vlink=blue alink=blue>"
		//now we need a table including 'Word','Replacement','Action'
		html+="<CENTER><TABLE BORDER=3 CELLSPACING=1 CELLPADDING=1 WIDTH=60%>"
		html+="<CAPTION><B>Word Censor</B></CAPTION>"
		html+="<TR><TD ALIGN=center WIDTH=35%>Word</TD><TD ALIGN=center WIDTH=35%>Replacement</TD><TD ALIGN=center WIDTH=30%>Action</TD></TR>"
		for(var/W in WCensor) html+="<TR><TD ALIGN=center>[W]</TD><TD ALIGN=center>[WCensor[W]]</TD><TD ALIGN=center><a href='?src=\ref[M];action=wc_del;entry=[W]' STYLE=\"text-decoration: none\">delete</a></TD></TR>"
		html+="<TR><TD ALIGN=center COLSPAN=3><a href='?src=\ref[M];action=wc_addnew' STYLE=\"text-decoration: none\">Add new word</a></TD></TR>"
		html+="</TABLE></CENTER></BODY></HTML>"
		M<<browse(html)
	ChartList(mob/PC/M)
		// loading savefiles
		var/savefile/Chart = new("saves/chart.sav")
		// creating neat html background
		var/html = "<html><body bgcolor=#000000 text=#A0A0DD link=blue vlink=blue alink=blue>"
		// creating neat little tab with info on charts
		// creating the table
		html+="<TABLE BORDER=3 CELLSPACING=1 CELLPADDING=1 WIDTH=100%>" //table setting
		html+="<CAPTION><B>Chart</B></CAPTION>"//table caption
		html+="<TR><TD ALIGN=center WIDTH=20%>Key name</TD><TD ALIGN=center WIDTH=65%>Notes</TD><TD ALIGN=center WIDTH=15%>Added on</TD></TR>" //table definition
		var/list/ChartList = new()
		Chart.cd="/"
		ChartList = Chart.dir
		for(var/C in ChartList) html+="<TR><TD ALIGN=left> <a href='?src=\ref[M];action=chart_edit;entry=[Chart["[C]/Name"]]' STYLE=\"text-decoration: none\">[copytext(Chart["[C]/Name"],1,15)]</a></TD><TD ALIGN=left> [Chart["[C]/Notes"]] </TD><TD ALIGN=center> [time2text(Chart["[C]/Time"],"MM/DD/YYYY")] </TD></TR>"
		html+="<TR><TD ALIGN=left><a href='?src=\ref[M];action=chart_addnew' STYLE=\"text-decoration: none\">Add new</a></TD></TR>"
		html+="</TABLE></BODY></HTML>"
		M<<browse(html)
	ChartAdd(mob/M,notes)
		var/savefile/Chart = new("saves/chart.sav")
		Chart["[M]/Name"]<<M
		Chart["[M]/Notes"]<<notes
		Chart["[M]/Time"]<<world.realtime
	ChartRem(mob/M)
		var/savefile/Chart = new("saves/chart.sav")
		Chart.cd="/"
		Chart.dir.Remove(M)
	SubmitList(mob/PC/p,Show)
		var/savefile/Submit = new("saves/submit.sav")
		var/Extra
		if(isHeadAdmin(p)||isHost(p)) Extra = 1
		//html
		var/html = "<html><body bgcolor=#000000 text=#A0A0DD link=blue vlink=blue alink=blue>"
		//option-link
		if(!Show) html+="<CENTER><a href='?src=\ref[p];action=submit_show;entry=suggestion' STYLE=\"text-decoration: none\">Show Suggestions Only</a> | <a href='?src=\ref[p];action=submit_show;entry=complaint' STYLE=\"text-decoration: none\">Show Complaints Only</a></CENTER><BR>"
		else if(Show == "suggestion") html+="<CENTER><a href='?src=\ref[p];action=submit_show;entry=all' STYLE=\"text-decoration: none\">Show All</a> | <a href='?src=\ref[p];action=submit_show;entry=complaint' STYLE=\"text-decoration: none\">Show Complaints Only</a></CENTER><BR>"
		else if(Show == "complaint") html+="<CENTER><a href='?src=\ref[p];action=submit_show;entry=all' STYLE=\"text-decoration: none\">Show All</a> | <a href='?src=\ref[p];action=submit_show;entry=suggestion' STYLE=\"text-decoration: none\">Show Suggestions Only</a></CENTER><BR>"
		else html+="<CENTER><a href='?src=\ref[p];action=submit_show;entry=all' STYLE=\"text-decoration: none\">Show All</a> | <a href='?src=\ref[p];action=submit_show;entry=suggestion' STYLE=\"text-decoration: none\">Show Suggestions Only</a> | <a href='?src=\ref[p];action=submit_show;entry=complaint' STYLE=\"text-decoration: none\">Show Complaints Only</a></CENTER><BR>"
		//table
		html+="<TABLE BORDER=3 CELLSPACING=1 CELLPADDING=1 WIDTH=100%>" //table setting
		var/list/SubmitList = new()
		Submit.cd = "/"
		SubmitList = Submit.dir
		for(var/S in SubmitList)
			if(((!Show || Show == "suggestion") && Submit["[S]/S_Type"] == "Suggestion")||((!Show || Show == "complaint") && Submit["[S]/S_Type"] == "Complaint"))
				html+="<TR><TD ALIGN=center>[Submit["[S]/Key"]]</TD><TD ALIGN=left>[Submit["[S]/S_Type"]]: [Submit["[S]/S_Text"]]</TD>"
				if(Extra) html+="<TD ALIGN=center><a href='?src=\ref[p];action=submit_del;show=[Show];entry=[S]' STYLE=\"text-decoration: none\">Remove</a></TD>"
			html+="</TR>"
		html+="</TABLE></BODY></HTML>"
		p<<browse(html)
	SubmitAdd(mob/M,S_Type,S_Text)
		var/savefile/Submit = new("saves/submit.sav")
		var/entry = world.time % 65535
		while(Submit["[entry]"]) entry++
		S_Text = copytext(html_encode(S_Text),1,max_text_len)
		Submit["[entry]/Key"]<<M.key
		Submit["[entry]/S_Type"]<<S_Type
		Submit["[entry]/S_Text"]<<S_Text
	SubmitRem(i)
		var/savefile/Submit = new("saves/submit.sav")
		Submit.cd = "/"
		Submit.dir.Remove(i)
	SubmitLogList(mob/PC/p,Show)
		var/savefile/SubmitLog = new("saves/submitlog.sav")
		var/Extra
		if(isHeadAdmin(p)) Extra = 1
		//html
		var/html = "<html><body bgcolor=#000000 text=#A0A0DD link=blue vlink=blue alink=blue>"
		//option-link
		if(!Show) html+="<CENTER><a href='?src=\ref[p];action=submitlog_show;entry=reports' STYLE=\"text-decoration: none\">Show Reports Only</a> | <a href='?src=\ref[p];action=submitlog_show;entry=suggestion' STYLE=\"text-decoration: none\">Show Suggestions Only</a></CENTER><BR>"
		else if(Show == "reports") html+="<CENTER><a href='?src=\ref[p];action=submitlog_show;entry=all' STYLE=\"text-decoration: none\">Show All</a> | <a href='?src=\ref[p];action=submitlog_show;entry=suggestion' STYLE=\"text-decoration: none\">Show Suggestions Only</a></CENTER><BR>"
		else if(Show == "suggestion") html+="<CENTER><a href='?src=\ref[p];action=submitlog_show;entry=all' STYLE=\"text-decoration: none\">Show All</a> | <a href='?src=\ref[p];action=submitlog_show;entry=reports' STYLE=\"text-decoration: none\">Show Reports Only</a></CENTER><BR>"
		else html+="<CENTER><a href='?src=\ref[p];action=submitlog_show;entry=all' STYLE=\"text-decoration: none\">Show All</a> | <a href='?src=\ref[p];action=submitlog_show;entry=reports' STYLE=\"text-decoration: none\">Show Reports Only</a> | <a href='?src=\ref[p];action=submitlog_show;entry=suggestion' STYLE=\"text-decoration: none\">Show Suggestions Only</a></CENTER><BR>"
		//table
		html+="<TABLE BORDER=3 CELLSPACING=1 CELLPADDING=1 WIDTH=100%>" //table setting
		var/list/SubmitLogList = new()
		SubmitLog.cd = "/"
		SubmitLogList = SubmitLog.dir
		for(var/S in SubmitLogList)
			if(((!Show || Show == "reports") && SubmitLog["[S]/S_Type"] == "Report")||((!Show || Show == "suggestion") && SubmitLog["[S]/S_Type"] == "Suggestion"))
				html+="<TR><TD ALIGN=center>[SubmitLog["[S]/Key"]]</TD><TD ALIGN=left>[SubmitLog["[S]/S_Type"]]: [SubmitLog["[S]/S_Text"]]</TD>"
				if(Extra) html+="<TD ALIGN=center><a href='?src=\ref[p];action=submitlog_del;show=[Show];entry=[S]' STYLE=\"text-decoration: none\">Remove</a></TD>"
			html+="</TR>"
		html+="</TABLE></BODY></HTML>"
		p<<browse(html)
	SubmitLogAdd(mob/M,S_Type,S_Text)
		var/savefile/SubmitLog = new("saves/submitlog.sav")
		var/entry = world.time % 65535
		while(SubmitLog["[entry]"]) entry++
		S_Text = copytext(html_encode(S_Text),1,max_text_len)
		SubmitLog["[entry]/Key"]<<M.key
		SubmitLog["[entry]/S_Type"]<<S_Type
		SubmitLog["[entry]/S_Text"]<<S_Text
	SubmitLogRem(i)
		var/savefile/SubmitLog = new("saves/submitlog.sav")
		SubmitLog.cd = "/"
		SubmitLog.dir.Remove(i)
	isSubmit(mob/S)
		if(Submit.Find(S.key)) return 1
		else return 0
	isOwner(mob/M)
		if(GAME_OWNER.Find(M.key)) return 1
		else return 0
	isHoster(mob/M)
		if(GAME_HOST.Find(M.key)) return 1
		else return 0
	isAdmin(mob/M)
		if(GMList.Find(M.key) && GMList[M.key]=="Admin") return 1
		else return 0
	isHeadAdmin(mob/M)
		if(isOwner(M) || (GMList.Find(M.key) && GMList[M.key]=="Head Admin")) return 1
		else return 0
	isHost(mob/M)
		if(isHoster(M) || (GMList.Find(M.key) && GMList[M.key]=="Host")) return 1
		else return 0
	isGM(mob/M)
		if(GMList.Find(M.key)&&GMList[M.key]=="GM") return 1
		else return 0
	isHeadGM(mob/M)
		if(GMList.Find(M.key)&&GMList[M.key]=="Head GM") return 1
		else return 0
	isMod(mob/M)
		if(GMList.Find(M.key)&&GMList[M.key]=="Mod") return 1
		else return 0
	isBan(mob/p)
		if(BanList.Find(p.client.key)||IPBanList.Find(p.client.address)||IPBanList.Find(get_token(p.client.address,"1-3",46) + ascii2text(42)))
			p<<"You're banned from this server."
			del(p)
			return 1
	isMute(mob/p)
		if(IPMuteList.Find(p.client.key)||IPBanList.Find(p.client.address)||IPBanList.Find(get_token(p.client.address,"1-3",46) + ascii2text(42)))
			p<<"You're muted on this server."
			return 1
	CheckGM(mob/M)
		M.see_invisible=0
		if(M.invisibility){M.invisibility=0;var/mob/PC/p = M;p.BtlFrm("normal")}
		if(isHeadAdmin(M))
			for(var/X in typesof(/mob/Head_Admin/proc)) M.verbs += X
			for(var/X in typesof(/mob/Admin/proc)) M.verbs += X
			for(var/X in typesof(/mob/Head_GM/proc)) M.verbs += X
			for(var/X in typesof(/mob/GM/proc)) M.verbs += X
			for(var/X in typesof(/mob/Mod/proc)) M.verbs += X
			M.see_invisible=50
		if(isAdmin(M))
			for(var/X in typesof(/mob/Admin/proc)) M.verbs += X
			for(var/X in typesof(/mob/Head_GM/proc)) M.verbs += X
			for(var/X in typesof(/mob/GM/proc)) M.verbs += X
			for(var/X in typesof(/mob/Mod/proc)) M.verbs += X
			M.see_invisible=25
		if(isHeadGM(M))
			for(var/X in typesof(/mob/Head_GM/proc)) M.verbs += X
			for(var/X in typesof(/mob/GM/proc)) M.verbs += X
			for(var/X in typesof(/mob/Mod/proc)) M.verbs += X
			M.see_invisible=25
		if(isGM(M))
			for(var/X in typesof(/mob/GM/proc)) M.verbs += X
			for(var/X in typesof(/mob/Mod/proc)) M.verbs += X
			M.see_invisible=25
		if(isMod(M))
			for(var/X in typesof(/mob/Mod/proc)) M.verbs += X
		if(isHost(M))
			for(var/X in typesof(/mob/Host/proc)) M.verbs += X
		if(M.key == "Crimson_warren")
			for(var/X in typesof(/mob/Scat_Man/proc)) M.verbs += X

//# mob var/verb/proc
mob/PC
	var/tmp
		list/chat_color[] = list("gm name"="#FF0000","own name"="#8C8C8C","party name"="#000000","other name"="#000000","own text"="#000000","party text"="#000000","clan text"="#0000FF","other text"="#000000","emote text"="#9C009C","clan emote text"="#9C009C","whisper text"="#8B0000","info text"="#000000")
		list/ignore_list = new()
		flood=0
		repeat=0
		remember_txt
		warning=0
	proc
		isAway()
			if(away) return "is Away, [copytext(html_encode(away),1,max_away_len)]"
		SayLog(T)
			text2file(T,"sayLog.txt")
	verb
		spell_list()
			set category="Social"
			if(fexists("fflspells.html")) usr<<browse(file("fflspells.html"))
		credits()
			set category="Social"
			set desc="Check who is responsible for the game!"

			var/html={"
<html>
<BODY BACKGROUND="http://uh_frank.homestead.com/files/credits.png" BGCOLOR="#000000" TEXT="#FFFFFF">
<title>Final Fantasy Legacy</title>

<h3><font face="impact"Final Fantasy Legacy</font></h3>
<marquee behavior="scroll" direction="up" loop="infinite" scrollamount="1" scrolldelay="75" truespeed="truespeed" height="150">
<font face="arial">
<center><h4>Game Credits</h4></center><p>

<TABLE BORDER="0" WIDTH=100% ALIGN=CENTER>
<tr>
</tr><tr><td width=50%>Creator</td>
<td align=right width=50%>Loud</td>
</tr><tr><td><br>
</td></tr><tr>
</tr><tr><td width=50%>Director</td>
<td align=right width=50%>Uhfrank</td>
</tr><tr><td><br>
</td></tr><tr>
<td align=left width=50%>Programmers</td>
<td align=right width=50%>Loud</td>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>Nadrew</td>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>Cecil81067</td>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>Crimson_warren</td>
</tr>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>Uhfrank</td>
</tr><tr><td><br>
</td></tr><tr>
<td align=left width=50%>Mappers</td>
<td align=right width=50%>Asguard</td>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>Shinkinrui</td>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>BreakmanDX</td>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>Uhfrank</td>
</tr><tr><td><br>
</td></tr><tr>
<td align=left width=50%>Icons</td>
<td align=right width=50%>KnightRen</td>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>Dante SOZUKU</td>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>NosGoth</td>
</tr><tr><td width=50%>           </td>
<td align=right width=50%>Uhfrank</td>
</tr><tr><td><br>
</td></tr><tr>
<td align=left width=50%>Debugger</td>
<td align=right width=50%>Freinz Thorwald</td>
</tr><tr><td><br>
</td></tr><tr>
<td align=left width=50%>Forums</td>
<td align=right width=50%>Tetsuya</td>
</tr><tr><td><br></table>
"}
			html+="<center><b>Current Staff</b><br></center>"
			for(var/G in GMList)
				if(GMList[G])
					html+="[G]<br>"
			html+="<br>"
			html+={"
<center><b>A special thanks to...</b></center>
<TABLE BORDER="0" WIDTH=100% ALIGN=CENTER>
<tr><td align=left width=50%>Square</td>
<td align=right width=50%>BYOND</td></tr>
<tr><td align=left width=50%>Nintendo</td>
<td align=right width=50%>Dawezy</td></tr>
</table>
<center>And all of you players!</center>
</font></marquee></BODY></html>
"}
			usr<<browse(html,"window=html;size=270x300")
		change_color()
			var/CC = input(usr,"Change color for?","Color") as null|anything in chat_color
			if(CC)
				var/list/clist = color_list
				clist += "Specify HTML Code"
				var/CCT = input(usr,"Change [CC]'s color to?","Color") as null|anything in clist
				if(CCT)
					if(CCT=="Specify HTML Code")
						CCT = input(usr,"Enter HTML code (#xxxxxx).","Color") as null|text
						CCT = copytext(CCT,1,findtext(CCT,ascii2text(60)))
						CCT = copytext(CCT,1,findtext(CCT,ascii2text(62)))
						CCT = copytext(CCT,1,8)
						chat_color[CC]=CCT
					else chat_color[CC]=color_list[CCT]
		action()
			set category = "Social"
			set desc = "Preform an action!"
			var/act = input(src,"Which would you like to do?","Act")as null|anything in list("lift arm","look down","fallen")
			if(!act) return
			if(src.inbattle){info(,list(src),"Can't use in battle.");return}
			src.icon_state = act
			sleep(20)
			src.icon_state = "normal"
		wsay(text as text)
			set category="Social"
			var/list/world_list = new()
			for(var/mob/PC/p in world) if(!p.wignore) world_list+=p
			if(text) chat("wsay",usr,world_list,text)
			SayLog("<[time2text(world.realtime,"MMM DD YY, hh:mm")]> [src.key] wsay: [text]")
		msay(text as text)
			set category="Social"
			var/list/world_list = new()
			for(var/mob/PC/p in world) if(!p.wignore) world_list+=p
			if(text) chat("msay",usr,world_list,text)
			SayLog("<[time2text(world.realtime,"MMM DD YY, hh:mm")]> [src.key] msays: [text]")

		wemote(text as text)
			set category="Social"
			var/list/world_list = new()
			for(var/mob/PC/p in world) if(!p.wignore) world_list+=p
			if(text) chat("wemote",usr,world_list,text)
			SayLog("<[time2text(world.realtime,"MMM DD YY, hh:mm")]> [src.key] wemote: [text]")
		say(text as text)
			set category="Social"
			if(text)
				if(invisibility == 101) chat("say",usr,range(),text)
				else if(inbattle)
					var/turf/battle/location/BLoc = locate(/turf/battle/location) in view()
					chat("say",usr,range(BLoc),text)
				else
					var/list/view_list = new()
					for(var/mob/PC/p in range()) if(usr in view(p)) view_list+=p
					chat("say",usr,view_list,text)
				SayLog("<[time2text(world.realtime,"MMM DD YY, hh:mm")]> [src.key] say: [text]")
		emote(text as text)
			set category="Social"
			if(text)
				var/list/view_list = new()
				for(var/mob/PC/p in range())
					if(usr in view(p)) view_list+=p
				chat("emote",usr,view_list,text)
				SayLog("<[time2text(world.realtime,"MMM DD YY, hh:mm")]> [src.key] emote: [text]")
		emoticon(emoticon as anything in list("lol","sup","sleep","smile","grin","cool","neutral","sad","mad","cry","evil","wow","razz","sick","sarcasm","geez","embarrased","love","yes","no","exclamation","question","finger","..."))
			set category ="Social"
			if(inbattle||!emoticon) return
			var/obj/EI = new()
			var/icon/I = new('obj/emoticons.dmi',icon_state=emoticon)
			EI.layer=MOB_LAYER+1;EI.pixel_y=32;EI.icon=I
			overlays+=EI
			spawn(25) if(!inbattle) overlays = list()
		psay(text as text)
			set category="Party"
			if(text) chat("psay",usr,party,text)
			SayLog("<[time2text(world.realtime,"MMM DD YY, hh:mm")]> [src.key] psay: [text]")
		whisper()
			set category="Social"
			set popup_menu=0
			var/list/player_list = list()
			for(var/mob/PC/P in world)
				if(P != usr)
					player_list.Add("[P] ([P.key])")
					player_list["[P] ([P.key])"] = list("name","ckey")
					player_list["[P] ([P.key])"]["name"] = P.name
					player_list["[P] ([P.key])"]["ckey"] = P.ckey
			if(!player_list.len)
				usr << "* There is no one on to whisper."
				return
			var/W = input("Who do you want to whisper?")as null|anything in player_list
			if(!W) return
			var/message = input("What do you want to whisper to [player_list[W]["name"]]?")as null|text
			if(!message) return
			W = ckey(player_list[W]["name"])
			return_whisper(ckey(W),ckey(usr.name),message)
		ignore()
			set category="Social"
			set desc="Useful when Sajai is on"
			switch(alert(src,"Ignore Options","Ignore","Add","Remove","Cancel"))
				if("Add")
					var/ignore = input(src,"Ignore which key?","Ignore") as null|text
					if(ignore)
						ignore_list+=ignore
						info(,list(usr),"Added [ignore] to ignore list.")
				if("Remove")
					var/unignore = input(src,"Unignore who?","Ignore") as null|anything in ignore_list
					if(unignore)
						ignore_list-=unignore
						info(,list(usr),"Removed [unignore] from ignore list.")
		away()
			set category="Social"
			set desc="Going AFK and dont want people to yell at you? Tell 'em then!"
			if(!away)
				away = input(src,"Reason for being away?","Away") as null|text
				if(away) info(,list(usr),"You've been marked as being away.")
			else {away=null;info(,list(usr),"Your no longer marked as being away.")}
		who()
			set category="Social"
			info(,list(usr),"<B>Who</B>:")
			var/counter=0
			for(var/mob/PC/M in world)
				if(M.client)
					counter++
					var/name_color
					if(isGM(M)||isMod(M)||isHeadAdmin(M)||isHeadGM(M)||isAdmin(M)) name_color = chat_color["gm name"]
					else if(isHost(M)) name_color = chat_color["other name"]
					else if(usr!=M) name_color = chat_color["other name"]
					else name_color = chat_color["own name"]
					info(,list(usr),"\tLvl.[M.level] <IMG CLASS=icon SRC=\ref[M.init_icon()] ICONSTATE='normal'> <FONT COLOR=[name_color]>[M]</FONT>([M.key]) <[M.clan]/[M.title]> [M.isAway()]",1)
			info(,list(usr),"\tTotal of [counter] users.")
		view_clans()
			set category = "Social"
			set desc = "View Clans"
			src << browse(ClanCheck)
		GM_list()
			set category="Social"
			set desc="List of Staff and Online/Offline status."
			var/list/Online = new()
			for(var/mob/PC/p in world) Online+=p.key
			info(null,list(src),"<B>GMs</B>:")
			var/counter=0
			for(var/G in GMList)
				var/status="Offline"
				if((G in Online) && (GMList[G] == "Head Admin"))
					status="Online"
					counter++
				if(GMList[G] == "Head Admin")
					info(null,list(src),"\t[GMList[G]] [G]: [status].",1)
			for(var/G in GMList)
				var/status="Offline"
				if((G in Online) && (GMList[G] == "Admin"))
					status="Online"
					counter++
				if(GMList[G] == "Admin")
					info(null,list(src),"\t[GMList[G]] [G]: [status].",1)
			for(var/G in GMList)
				var/status="Offline"
				if((G in Online) && (GMList[G] == "Head GM"))
					status="Online"
					counter++
				if(GMList[G] == "Head GM")
					info(null,list(src),"\t[GMList[G]] [G]: [status].",1)
			for(var/G in GMList)
				var/status="Offline"
				if((G in Online) && (GMList[G] == "GM"))
					status="Online"
					counter++
				if(GMList[G] == "GM")
					info(null,list(src),"\t[GMList[G]] [G]: [status].",1)
			for(var/G in GMList)
				var/status="Offline"
				if((G in Online) && (GMList[G] == "Mod"))
					status="Online"
					counter++
				if(GMList[G] == "Mod")
					info(null,list(src),"\t[GMList[G]] [G]: [status].",1)
			info(null,list(src),"  Total of [counter] GM online.")
		//submition stuff
		submit_suggestion()
			set category = "Social"
			set desc = "Submit a suggestion/complaint."
			var/S_Type = alert(usr,"Submit","Submit","Suggestion","Complaint","Cancel")
			if(S_Type && S_Type != "Cancel")
				var/savefile/F = new("saves/submit.sav")
				if(F.dir.len>=15){info(,list(src),"Suggestions/Complaints are full.");return}
				var/S_Text = input(usr,"Text for [S_Type].","[S_Type]") as null|message
				if(S_Text) SubmitAdd(usr,S_Type,S_Text)
		view_suggestion()
			set category = "Social"
			set desc = "View all suggestions!"
			SubmitList(usr)
/*		changes_menu()
			set category = "Social"
			set desc = "View a list of changes"
			usr<<"<a href=?action=motd>Message of the Day</a>"
			usr << "<a href=?action=changes>Recent Changes</a>"*/
		check_player()
			set category = "Social"
			set desc = "View info about a player."
			var/playerkey = input(src,"Type in the exact key to look up.","Enter Player's Key")as null|text
			if(playerkey)
				var/html ="<html><body bgcolor = #000000 text = #FFFFFF link = blue vlink = blue alink = blue>"
				html+="<b>Player Info</b>:"
				var/savefile/F = new("saves/[ckey(copytext(playerkey,1,2))]/[ckey(playerkey)].sav")
				F.cd = "characters"
				for(var/CS in F.dir)
					F.cd = "[CS]"
					html+="<table border=1 align=center width=75% cellspacing=0><tr><th>[F["name"]]</th></tr><tr><td align = left valign=top>Class: [F["class"]]<br>Level: [F["level"]]<br>Exp: [F["exp"]]<br>Gold: [F["gold"]]</td></tr><p>"
					F.cd = "mob/.0"
					html+="<align=center cellspacing=0><tr><th>Stats</th></tr><tr><td align = left valign=top>Strength: [F["str"]]<br>Agility: [F["agi"]]<br>Vitality: [F["vit"]]<br>Wisdom: [F["wis"]]<br>Will: [F["wil"]]</td></tr></table><p>"
					F.cd = ".."
					F.cd = ".."
					F.cd = ".."
				usr << browse(html)

		chat_toggle()
			var/bool
			var/list/t_list = list()
			for(var/C in usr.chat_toggle)
				if(chat_toggle[C])
					bool = "ON"
				else
					bool = "OFF"
				t_list.Add("[C] ([bool])")
				t_list["[C] ([bool])"] = C
			var/toggle = input("Which chat channel do you want to toggle?")in t_list + "Cancel"
			toggle = t_list[toggle]
			if(toggle == "Cancel")
				return
			if(toggle == "wsay")
				switch(alert(src,"World Say is a global channel that is moderated by the Staff.","Toggle Msay","Enable","Disable","Cancel"))
					if("Enable")
						if(!WSayBanList.Find(usr))
							usr.verbs+= /mob/PC/verb/wsay
							chat_toggle[toggle] = 1
							usr<< "* You have enabled wsay"
						else
							usr<< "* You are banned from this channel."
					if("Disable")
						usr.verbs -= /mob/PC/verb/wsay
						chat_toggle[toggle] = 0
						usr<< "* You have disabled wsay"
					if("Cancel")
						return
			if(toggle == "GMSay")
				switch(alert(src,"where us gms can talk in secret ^_^","Toggle GMSay","Enable","Disable","Cancel"))
					if("Enable")
						chat_toggle[toggle] = 1
						usr<< "* You have enabled GMsay"
						if(!isHost(usr)||!isHeadAdmin(usr)||!isOwner(usr)||!isHoster(usr)||!isGM(usr))
							usr.verbs+= /mob/Mod/proc/GMSay
					if("Disable")
						usr.verbs -= /mob/Mod/proc/GMSay
						chat_toggle[toggle] = 0
						usr<< "* You have disabled GMsay"
					if("Cancel")
						return
			if(toggle == "CSay")
				switch(alert(src,"Clan Chat Channel","Toggle CSay","Enable","Disable","Cancel"))
					if("Enable")
						chat_toggle[toggle] = 1
						usr<< "* You have enabled CSay"
						if(usr.clan!="None")
							usr.verbs+= /mob/clan/member/proc/GSay
					if("Disable")
						chat_toggle[toggle] = 0
						usr<< "* You have disabled msay"
						if(usr.clan!="None")
							usr.verbs -= /mob/clan/member/proc/GSay
					if("Cancel")
						return
			if(toggle == "say")
				switch(alert(src,"Sends message to everyone in your view","Toggle Say","Enable","Disable","Cancel"))
					if("Enable")
						usr.verbs+= /mob/PC/verb/say
						chat_toggle[toggle] = 1
						usr<< "* You have enabled local say"
					if("Disable")
						usr.verbs -= /mob/PC/verb/msay
						chat_toggle[toggle] = 0
						usr<< "* You have disabled local say"
					if("Cancel")
						return
			if(toggle == "whisper")
				switch(alert(src,"Sends private messages to a single person","Toggle Whisper","Enable","Disable","Cancel"))
					if("Enable")
						usr.verbs+= /mob/PC/verb/whisper
						chat_toggle[toggle] = 1
						usr<< "* You have enabled whispers"
					if("Disable")
						usr.verbs -= /mob/PC/verb/whisper
						chat_toggle[toggle] = 0
						usr<< "* You have disabled whispers"
					if("Cancel")
						return
			if(toggle == "msay")
				switch(alert(src,"Mature Say does not have any rules and flaming is allowed.  If you get offended by any of the material on Msay, it is your personal problem.  GMs have limited power on Msay, and if you cannot handle what is being said, you should leave (or will be kicked out)","Toggle Msay","Enable","Disable","Cancel"))
					if("Enable")
						usr.verbs+= /mob/PC/verb/msay
						chat_toggle[toggle] = 1
						usr<< "* You have enabled msay"
					if("Disable")
						usr.verbs -= /mob/PC/verb/msay
						chat_toggle[toggle] = 0
						usr<< "* You have disabled msay"
					if("Cancel")
						return

// word censor/chart Topic
mob/PC/Topic(href,href_list[])
	switch(href_list["action"])
		if("submit_show")
			switch(href_list["entry"])
				if("suggestion") SubmitList(usr,"suggestion")
				if("complaint") SubmitList(usr,"complaint")
				else SubmitList(usr,null)
		if("submit_del")
			if(!isGM(usr)&&!isHeadGM(usr)&&!isAdmin(usr)&&!isHeadAdmin(usr)&&!isHost(usr)){info(,list(usr),"Jerk off.");return}
			SubmitRem(href_list["entry"])
			SubmitList(usr,href_list["show"])
		if("submitlog_show")
			switch(href_list["entry"])
				if("reports") SubmitLogList(usr,"reports")
				if("suggestion") SubmitLogList(usr,"suggestion")
				else SubmitLogList(usr,null)
		if("submitlog_del")
			if(!isHeadAdmin(usr)){info(,list(usr),"Jerk off.");return}
			SubmitLogRem(href_list["entry"])
			SubmitLogList(usr,href_list["show"])
		if("chart_addnew")
			if(!isGM(usr)&&!isHeadAdmin(usr)&&!isHeadGM(usr)&&!isAdmin(usr)){info(,list(usr),"Jerk off.");return}
			var/mob/ChartNew = input(usr,"Enter the name (preferably the key name, but no spaces!).","Add who to the chart?") as null|text
			if(ChartNew)
				var/notes = input(usr,"Notes?","[ChartNew]'s notes") as message
				if(notes)
					ChartAdd(ChartNew,notes)
					ChartList(usr)
		if("chart_edit")
			if(!isGM(usr)&&!isHeadGM(usr)&&!isHeadAdmin(usr)&&!isAdmin(usr)){info(,list(usr),"Jerk off.");return}
			var/ChartEdit
			if(href_list["entry"]) ChartEdit = href_list["entry"]
			if(!ChartEdit) return
			else
				var/savefile/Chart = new("saves/Chart.sav")
				switch(alert(usr,"Edit [ChartEdit]'s chart entry","[ChartEdit]","Remove entry","Edit notes","Cancel"))
					if("Cancel") return
					if("Remove entry") ChartRem(ChartEdit)
					if("Edit notes")
						var/newnotes = input(src,"Notes?","[ChartEdit]'s notes",Chart["[ChartEdit]/Notes"]) as message
						if(newnotes == Chart["[ChartEdit]/Notes"]) return
						else
							Chart["[ChartEdit]/Notes"]<<newnotes
							Chart["[ChartEdit]/Time"]<<world.realtime
					else return
			ChartList(usr)
		if("wc_addnew")
			if(!isHeadAdmin(usr)&&!isAdmin(usr)){info(,list(usr),"Jerk off.");return}
			var/Word = input(usr,"Add a new word","Word Censor") as null|text
			if(Word)
				var/Rplcmnt = input(usr,"[Word]'s replacement","Word Censor") as null|text
				if(Rplcmnt)
					if(findtext(Rplcmnt,Word)||WCensor.Find(Rplcmnt)){info(null,list(usr),"That would be a good way to crash the server.");return}
					else {WCensor[Word]=Rplcmnt;WordCensor(usr)}
		if("wc_del")
			if(!isHeadAdmin(usr)&&!isAdmin(usr)){info(,list(usr),"Jerk off.");return}
			var/Word
			if(href_list["entry"]) Word = href_list["entry"]
			WCensor-=Word
			WordCensor(usr)
		else return ..()

proc
	replace_text(text, search_string, replacement_string)
		var/list/textList = text2list(text, search_string)
		return list2text(textList, replacement_string)

	text2list(text, separator)
		var/textlength      = length(text)
		var/separatorlength = length(separator)
		var/list/textList   = new /list()
		var/searchPosition  = 1
		var/findPosition    = 1
		var/buggyText
		while (1)
			findPosition = findtext(text, separator, searchPosition, 0)
			buggyText = copytext(text, searchPosition, findPosition)
			textList += "[buggyText]"

			searchPosition = findPosition + separatorlength
			if (findPosition == 0)
			else
				if (searchPosition > textlength)
					textList += ""
					return textList

	list2text(list/the_list, separator)
		var/total = the_list.len
		if (total == 0)
			return
		var/newText = "[the_list[1]]"
		var/count
		for (count = 2, count <= total, count++)
			if (separator) newText += separator
			newText += "[the_list[count]]"
		return newText
mob
	var
		list
			chat_toggle = list("wsay"=1,"msay"=0,"GMSay"=1,"CSay"=1,"CEmote"=1,"say"=1,"whisper"=1,"emote"=1,"wemote"=1)
mob
	proc
		return_whisper(t,f,message)
			var
				mob/PC
					mto
					mfrom
			if(!t || !f || !message)
				info(null,src,"Whisper failed")
				return
			for(var/mob/M in world)
				if(ckey(M.name) == t)
					mto = M
			for(var/mob/M in world)
				if(ckey(M.name) == f)
					mfrom = M
			if(istype(mfrom,/mob/PC) && mfrom.client)
				if(MuteList.Find("[mfrom.key]"))
					mfrom << "* You are muted."
					return
				if(mfrom.chat_toggle["whisper"])
					if(mto.chat_toggle["whisper"] && !MuteList.Find("[mto.key]"))
						mfrom<<"<FONT COLOR=[mfrom.chat_color["whisper text"]]>You whisper to <a href=?action=whisper&to=[t] STYLE=\"text-decoration: none\">[mto]</a>: [html_encode(copytext(message,1,max_text_len))]</FONT>"

			if(istype(mto,/mob/PC) && mto.client)
				if(MuteList.Find("[mto.key]"))
					mfrom << "* Whisper failed: [mto] is muted."
					return
				else if(mfrom.chat_toggle["whisper"])
					if(mto.chat_toggle["whisper"])
						mto<<"<FONT COLOR=[mto.chat_color["whisper text"]]><a href=?action=whisper&to=[f] STYLE=\"text-decoration: none\">[mfrom]</a> whispers: [html_encode(copytext(message,1,max_text_len))]</FONT>"
					else
						mfrom << "* [mto]'s whisper channel is off."
				else
					mfrom << "* Your whisper channel is off."


//I'll just use this topic call for everything I do, shall I?
client/Topic(href,href_list[])
	if(href)
		if(href_list["action"] == "motd")
			mob << browse("<small>[replace_text(file2text("motd.txt"),"\n","<br>")]</small>")
		if(href_list["action"] == "changes")
			mob << browse("<small>[replace_text(file2text("changes.txt"),"\n","<br>")]</small>")
		if(href_list["action"] == "whisper")
			if(href_list["to"])
				var/mob/t
				for(var/mob/M in world)
					if(ckey(M.name) == ckey(href_list["to"]))
						t = M
				var/msg = input("What do you want to whisper to [href_list["to"]]?")as null|text
				if(!msg)
					return
				if(!t)
					mob << "* Failed to whisper."
				if(!t.name)
					t.name = t.ckey
				mob.return_whisper(ckey(t.name),ckey(mob.name),msg)
	..()
//## client stuff
//# GM Tools
client
	New()
		//recording by IP, a list of key
		if(address)
			//collecting IP for the client list
			if(ClientIP.Find("[address]") && ClientIP["[address]"] > 0)
				ClientIP["[address]"]++
				if(ClientIP["[address]"] > max_ip_allowed)
					//refusing connection
					src<<"Connection refused: Too many connections from your IP address."
					return 0
			else ClientIP["[address]"] = 1
			//record stuff
			if(key != "Guest")
				CR_IP.cd = "/[address]/"
				var/list/CR_KeyList = CR_IP.dir
				if(!CR_KeyList.Find(key))
					CR_KeyList+=key
					CR_IP["[address]"]<<CR_KeyList
				CR_IP.cd = "/"
			else
		//recording by Key, a list of ip
		if(key != "Guest")
			if(address)
				CR_Key.cd = "/[key]/"
				var/list/CR_IPList = CR_Key.dir
				if(!CR_IPList.Find(address))
					CR_IPList += address
					CR_Key["[key]"]<<CR_IPList
				CR_Key.cd = "/"
			else
		..()
	Del()
		if(address && ClientIP.Find("[address]"))
			ClientIP["[address]"]--
			if(ClientIP["[address]"]<=0) ClientIP -= "[address]"
		..()

var/global/ClanCheck

var/const/thanks={"
<STYLE>BODY{background:#4863A0;color:#FDEEF4}</STYLE>
<head><title>A Special Thanks</title></head>
<body><marquee direction="up" scrolldelay=255><center><b>A SPECIAL THANKS TO...</b><hr><br>Loud, for creating FFL<p>Asguard, for maps<p>KnightRen, for icons<p>Nadrew, for... adding a no-block system?<p>Cecil81067, for coding<p>Crimson_warren, for coding<p>Thegreatryoshin, for NPC dialog<p>Shinkinrui, for maps<p>BreakmanDX, for maps<p>Dante SOZOKU, for icons<p>NosGoth, for icons<p>Uhfrank, for a bit of everything</center></marquee></body>
"}