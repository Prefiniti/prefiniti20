<script type="text/javascript" src="/sm2/script/soundmanager2-jsmin.js"></script>
<script type="text/javascript" src="/sm2/demo/jsAMP-preview/script/jsamp-preview.js"></script>

<link rel="stylesheet" type="text/css" href="/sm2/demo/jsAMP-preview/css/player.css" title="dark" media="screen" />
<link rel="alternate stylesheet" type="text/css" href="/sm2/demo/jsAMP-preview/css/player-light.css" title="light" media="screen" />

<cfinclude template="/contentManager/cm_udf.cfm">
<cfparam name="userFiles" default="">

<cfset userFiles=cmsGetUserFiles(attributes.user_id)>


<style type="text/css">

#demo-info {
 position:relative;
 padding:1em;
 background:#000;
 opacity:0.75;
 filter:alpha(opacity=75);
 color:#fff;
 max-width:51em;
}

#demo-info h1 {
 margin:0px 0px 2em 0px;
 font-size:1.5em;
 color:#99ccff;
}

#demo-info p {
 line-height:1.5em;
}

#demo-info a {
 color:#99ccff;
}

#demo-info a:hover {
 color:#fff;
}

#close {
 position:absolute;
 right:0px;
 top:0px;
 display:block;
 width:1em;
 line-height:1em;
 padding:0.1em;
 margin:0.5em;
 height:1em;
 text-decoration:none;
 color:#fff;
 border:1px solid #666;
 text-align:center;
 overflow:hidden;
}

#close:hover {
 background:#333;
}

#demo-info.closed * {
 display:none;
}

#demo-info.closed .minimal {
 display:block;
 margin:0px;
 padding:0px;
}

#demo-info.closed .minimal * {
 display:inline;
}

</style>
<script type="text/javascript">
function setActiveStyleSheet(title) {
  var i, a, main;
  for (i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if (a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {
      a.disabled = true;
      if(a.getAttribute("title") == title) a.disabled = false;
    }
  }
}
</script>



</head>

<body>

<div>

 <!-- skin / control stuff -->

 
<!---
<img src="pfm.jpg" />
<hr />
<div style="width:100%; min-height:400px; background-color:black; color:#CCCCCC;">
<table width="100%">
<tr>
	<td style="margin-left:10px;" width="100%">
    	<div id="
        <h1 style="font-size:medium; font-weight:bolder; padding:0px; margin:0px;">My Library</h1>    
		<div style="height:300px; overflow:auto;">
        <cfmodule template="components/view_library.cfm" user_id="#url.user_id#">
        </div>
	</td>
    <!--<td width="55%">
    </td>-->
</tr>
</table>
</div> 
--->   


 <div id="player-template" class="sm2player">

  <!-- player UI (bar) -->

  <div class="ui">

   <div class="left">
    <a href="#" title="Pause/Play" onclick="soundPlayer.togglePause();return false" class="trigger pauseplay"><span></span></a>
   </div>

   <div class="mid">

    <div class="progress"></div>
    <div class="info"><span class="caption text">%{artist} - %{title} [%{album}], (%{year}) (%{time})</span></div>
    <div class="default">Prefiniti Media Player</div>
    <div class="seek">Seek to %{time1} of %{time2} (%{percent}%)</div>
    <div class="divider">&nbsp;&nbsp;---&nbsp;&nbsp;</div>
    <a href="#" title="" class="slider"></a>
   </div>

   <div class="right">
    <div class="divider"></div>
    <div class="time" title="Time">0:00</div>
    <a href="#" title="Previous" class="trigger prev" onclick="soundPlayer.oPlaylist.playPreviousItem();return false"><span></span></a>
    <a href="#" title="Next" class="trigger next" onclick="soundPlayer.oPlaylist.playNextItem();return false"><span></span></a>
    <a href="#" title="Shuffle" class="trigger s1 shuffle" onclick="soundPlayer.toggleShuffle();return false"><span></span></a>
    <a href="#" title="Repeat" class="trigger s2 loop" onclick="soundPlayer.toggleRepeat();return false"><span></span></a>
    <a href="#" title="Mute" class="trigger s3 mute" onclick="soundPlayer.toggleMute();return false"><span></span></a>
    <a href="#" title="Volume" onmousedown="soundPlayer.volumeDown(event);return false" onclick="return false" class="trigger s4 volume"><span></span></a>
    <a href="#" title="Playlist" class="trigger dropdown" onclick="soundPlayer.togglePlaylist();return false"><span></span></a>
   </div>

  </div>

  <div class="sm2playlist-box">

  <!-- playlist / controls -->
  <div id="playlist-template" class="sm2playlist">

   <div class="hd"><div class="c"></div></div>
   <div class="bd">
    <ul>
     <!-- playlist items created, inserted here
      <li><a href="/path/to/some.mp3"><span>Artist - Song Name, etc.</span></a></li>
     -->
    </ul>
   </div>
   <div class="ft"><div class="c"></div></div>
  </div>

  <!-- close container -->
  </div>

 </div>
<cfif attributes.playlist EQ "__library">
<div style="display:none;">
<ul>
<cfoutput query="userFiles">
	<cfif LCase(Right(filename, 3)) EQ "mp3">
    	<li><a href="#cmsUserFileURLNoEnc(id)#">#description#</a></li>
	</cfif>        
</cfoutput>
</ul>
</div>
</cfif>

 <!---<div style="position:absolute;left:0px;top:-9999px;width:30em">

 <p>This is a normal list of HTML links to MP3 files, which jsAMP picks up and turns into a playlist.</p>

 <ul>

  <li><a href="audio/going_outside.mp3">Going Outside</a></li>
  <li><a href="audio/office_lobby.mp3">Office Lobby Entrance</a></li>
  <li><a href="audio/rain.mp3">Rain</a></li>
  <li><a href="audio/walking.mp3">Walking</a></li>

  <!-- files from the web (note that ID3 information will *not* load from remote domains without permission, Flash restriction) -->

  <li><a href="http://www.freshly-ground.com/data/audio/binaural/Rain 3.mp3">Rain 3</a></li>
  <li><a href="http://www.freshly-ground.com/data/audio/binaural/Frogs @ Yahoo!.mp3">Frogs @ Yahoo!</a></li>
  <li><a href="http://www.freshly-ground.com/data/audio/binaural/Walking past sprinklers, mailbox.mp3">Walking past sprinklers, mailbox</a></li>
  <li><a href="http://www.freshly-ground.com/data/audio/binaural/Cup of Coffee.mp3">Cup of Coffee</a></li>
  <li><a href="http://www.freshly-ground.com/misc/music/carl-3-barlp.mp3">Barrlping with Carl (featureblend.com)</a></li>
  <li><a href="http://www.freshly-ground.com/data/audio/binaural/Mak.mp3">Angry cow sound?</a></li>
  <li><a href="http://www.freshly-ground.com/data/audio/binaural/Things that open, close and roll.mp3">Things that open, close and roll</a></li>
  <li><a href="http://www.freshly-ground.com/misc/music/20060826%20-%20Armstrong.mp3">20060826 - Armstrong</a></li>

 </ul>

 </div>--->

</div>

<script type="text/javascript">
var bg = {
  images: ['vernon-night1','vernon-night2','bg1','bg2','bg3'],
  i: 0,
  getRandom: function(n) {
    this.i = (typeof n != 'undefined'?n:(++this.i>=this.images.length?0:this.i));
    //document.body.style.background = "#000 url(backgrounds/"+this.images[this.i]+".jpg) no-repeat 0px 0px";
  }
}

bg.getRandom(parseInt(Math.random()*bg.images.length));
</script>

<script type="text/javascript">soundManager.createMovie('/sm2/soundmanager2.swf');</script>

</body>
</html>