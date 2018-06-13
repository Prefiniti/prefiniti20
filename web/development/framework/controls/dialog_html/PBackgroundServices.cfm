<div style="width:100%; height:100%;" class="__PREFINITI_APPLICATION">
	<div style="padding:30px;">
	<strong><img src="/graphics/cog.png" align="absmiddle" /> Background Services</strong>
	<hr />
	<br />
	
    <input type="button" class="normalButton" value="Pause All" onclick="PauseAllTasks();">
    <input type="button" class="normalButton" value="Resume All" onclick="ResumeAllTasks();"> <br><br>
    
    <div id="BGServices" class="PBackgroundServices" style="background-color:white; color:black; width:100%; height:260px; overflow:auto;">
    
    </div>
    
    <label>MaxWait: <span id="CMaxWait"></span></label> <label><span id="CCycle"></span></label><br><br>
    <span style="font-size:xx-small;"><img src="/graphics/information.png" align="absmiddle"> <strong>Tip:</strong> Pausing background services can improve performance on slower connections.</span>
</div>
</div>
