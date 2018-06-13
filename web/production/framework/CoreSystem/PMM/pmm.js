/*
* pmm.js
* Prefiniti Multimedia Manager
*
* Copyright (C) 2009 AJL Intel-Properties LLC
*
* Author: jpw
*/


var pmmChannels = new Array(1);

var scSystem = null;
var scMain = null;

function PMMInitialize()
{
	writeConsole("<br><br>PMM: Prefiniti MultiMedia Manager 2.0RC1");
	writeConsole("Copyright (C) 2009, AJL Intel-Properties LLC");
	writeConsole("<br><br>Initializing sound channels...");
	
	scSystem = new PMMSoundChannel('SYSTEM');
	scMain = new PMMSoundChannel('MAIN');
  
    PMMLoadSoundChannel(scSystem);
    PMMLoadSoundChannel(scMain);
	
	showDiv('PMM-TB');
	//SystemSound('SESSION_STARTUP');
}



function PMMSoundChannel(Handle)
{
   	this.Handle = Handle;
   	this.Loaded = false;
  
	var volKey = "PMM:SOUNDCHANNEL:VOLUME:" + this.Handle;
	var panKey = "PMM:SOUNDCHANNEL:PAN:" + this.Handle;
  
    var volSet = KGetSetting(AuthenticationRecord.UserID, volKey)
   	var panSet = KGetSetting(AuthenticationRecord.UserID, panKey);
   
	if(volSet) {
		this.ChVolume = volSet;
	}
	else {
		this.ChVolume = 50;
	}
	
	if(panSet) {
		this.ChPan = panSet;
	}
	else {
		this.ChPan = 0;
	}

   	this.Queue = new Array(1);
   	this.QueueIndex = 0;
	this.QueueShuffle = false;
	this.Muted = false;
	
	this.IIndex = 0;
}

function PMMLoadSoundChannel(chn)
{
	chn.Loaded = true;
	writeConsole("PMM: Loading sound channel:");
	writeConsole("&nbsp;handle&nbsp;: " + chn.Handle);
	writeConsole("&nbsp;volume&nbsp;: " + chn.Volume);
	writeConsole("&nbsp;pan&nbsp;&nbsp;&nbsp;&nbsp;: " + chn.Pan);
    pmmChannels.push(chn);
	writeConsole("PMM: Sound channel " + chn.Handle + " loaded.");
}

function PMMFindSoundChannel(handle)
{
   for(ch in pmmChannels) {
	   if(pmmChannels[ch].Handle = handle) {
		   return pmmChannels[ch];
	   }
   }
   
   return null;
}


function PMMQueueEntry(Path, smID) 
{ 
  this.Path = Path; 
  this.smID = smID; 
  this.Arist = null;
  this.Title = null;
  this.Album = null;
  
}

PMMSoundChannel.prototype.EnqueueSound = function (Path) {
   
   if (this.Loaded) {
		
   }
};

PMMSoundChannel.prototype.ShuffleQueue = function (value) {
	this.QueueShuffle = value;
};

PMMSoundChannel.prototype.SeekQueueAbsolute = function (value) {
	this.QueueIndex = value;
};

PMMSoundChannel.prototype.SeekQueueOffset = function (offset) {
	this.QueueIndex += offset;
};

PMMSoundChannel.prototype.PlayQueue = function () {
	
	var obj = this;
	soundManager.createSound({
		id:'PMMQSOUND_' + this.Handle + '_' + this.QueueIndex,
		url:this.Queue[QueueIndex].Path,
		volume:this.ChVolume,
		pan:this.ChPan,
		onfinish:function() {
			
			alert(obj.Handle);
			
			
		}
	});
};

PMMSoundChannel.prototype.PlaySound = function (Path) {
	writeConsole("PMM: Playing sound " + Path + " on channel " + this.Handle);
	var sm2Handle = 'PMMISOUND_' + this.Handle + '_' + this.IIndex;
	
	var chVol = null;
	if(this.Muted == true) {
		chVol = 0;
	}
	else {
		chVol = this.ChVolume;
	}
	
	var chPan = this.ChPan;
	
	try {
		var sSnd = " ";
		soundManager.createSound({
								 id:sm2Handle,
								 url:Path,
								
								 
								 });
		if(!sSnd) {
			throw("soundManager.createSound() returned null");
		}
		else {
			soundManager.play(sm2Handle,
							  {
								 volume:chVol,
								 pan:chPan
							  });
		}
	} 
	catch (ex) {
		writeConsole("PMM Exception: " + ex + "<br>&nbsp;channel : " + this.Handle + "<br>&nbsp;media file: " + Path );
	}
	

	this.IIndex++;
	
};

function SystemSound(sound)
{
	var themeBase = "/Framework/StockResources/Themes/" + AuthenticationRecord.Theme + "/Sounds/";
	var sndPath = null;
	
	
	switch(sound) {
		case 'SESSION_STARTUP':
			sndPath = themeBase + "SESSION_STARTUP.MP3";
			break;
		
		case 'SESSION_SWITCH_USERS':
			sndPath = themeBase + "SESSION_SWITCH_USERS.MP3";	
			break;
		
		case 'SESSION_LOGOUT':
			sndPath = themeBase + "SESSION_LOGOUT.MP3";
			break;
		
		case 'SYSTEM_WARNING':
			sndPath = themeBase + "SYSTEM_WARNING.MP3";
			break;
		
		case 'SYSTEM_CRITICAL_ERROR':
			sndPath = themeBase + "SYSTEM_CRITICAL_ERROR.MP3";
			break;
		
		case 'SYSTEM_ALARM':
			sndPath = themeBase + "SYSTEM_ALARM.MP3";
			break;
		
		case 'SYSTEM_UPLOAD_COMPLETE':
			sndPath = themeBase + "SYSTEM_UPLOAD_COMPLETE.MP3";
			break;
		
		case 'WINDOW_MAXIMIZE':
			sndPath = themeBase + "WINDOW_MAXIMIZE.MP3";
			break;
		
		case 'WINDOW_MINIMIZE':
			sndPath = themeBase + "WINDOW_MINIMIZE.MP3";
			break;
		
		case 'WINDOW_RESTORE':
			sndPath = themeBase + "WINDOW_RESTORE.MP3";	
			break;
		
		case 'WINDOW_OPEN':
			sndPath = themeBase + "WINDOW_OPEN.MP3";	
			break;
		
		case 'WINDOW_CLOSE':
			sndPath = themeBase + "WINDOW_CLOSE.MP3";	
			break;
		
		case 'DRAG_BEGIN':
			sndPath = themeBase + "DRAG_BEGIN.MP3";	
			break;
		
		case 'DRAG_END':
			sndPath = themeBase + "DRAG_END.MP3";
			break;
		
		default:
		
			var pmmAb = new AlertBox("PMM Error:<br><br>Invalid system sound ID " + sound, "PMM", "/graphics/AppIconResources/crystal_project/32x32/apps/aktion.png");
			pmmAb.Show();
			return;
	}
	
	var chan = PMMFindSoundChannel("SYSTEM");
	if(chan) {
		chan.PlaySound(sndPath);
	}
}

function PMMShowMixer()
{
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var TP_handle = 'PMMVolumeMixer';
	 
	var wRef = p_session.Framework.FindWindow(TP_handle);
	if (!wRef) {
		var TP_title  = 'PMM Volume Mixer';
		var TP_icon   = new PIcon('/graphics/sound.png', P_SMALLICON);
		var TP_rect   = new PAutoRect(640, 168);
		var TP_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWMAXIMIZE | WS_ALLOWREFRESH | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var TP_MessageHandler  = null;
		var TP_BackgroundColor = new PColor(255, 255, 255);

		var TP_window = new PWindow(TP_handle, TP_title, TP_rect, TP_icon, TP_style, TP_MessageHandler, TP_BackgroundColor);
	 
		wRef = p_session.Framework.CreateWindow(TP_window);	
	}	
	
	var winNode = new PElement("PMMVolumeMixer_ClientArea");
	
	var newNode = null;
	var curChan = null;
	var rhChan = null;
	var mixerURL = "/Framework/CoreSystem/PMM/MixerChannel.cfm";
	
	for(ch in pmmChannels) {
		curChan = pmmChannels[ch];
		
		rhChan = new KRequestHeaders();
		rhChan.Add(new KRequestParam("HANDLE", curChan.Handle));
		rhChan.Add(new KRequestParam("VOLUME", curChan.Volume));
		rhChan.Add(new KRequestParam("PAN", curChan.Pan));
		rhChan.Add(new KRequestParam("MUTED", curChan.Muted));
		
		newNode = winNode.Add();
		newNode.LoadText(KSynchronousRequest(mixerURL, rhChan));
	}
}

function PMMSetChannelVolume(Handle, Level)
{
	//alert("set volume on " + Handle + " to " + Level);
	var ch = PMMFindSoundChannel(Handle);
	ch.ChVolume = Level;
	
	var volKey = "PMM:SOUNDCHANNEL:VOLUME:" + Handle;
	
	KSaveSetting(AuthenticationRecord.UserID, volKey, Level);
	
	var vd = null; // vd = volume detent
	
	try {
		for(i = 0; i <= 100; i++) {
			vd = new PElement("volDetent_" + Handle + "_" + i);
			if(i <= Level) {
				vd.Node.style.backgroundColor = "blue";
			}
			else {
				vd.Node.style.backgroundColor = "gray";
			}
		}
	}
	catch (ex) {
		//alert(ex);	
	}
	
	var themeBase = "/Framework/StockResources/Themes/" + AuthenticationRecord.Theme + "/Sounds/";
	ch.PlaySound(themeBase + "WINDOW_CLOSE.mp3");
	
}

