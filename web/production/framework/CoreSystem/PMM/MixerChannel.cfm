<!---<cfdump var="#url#">--->
<cfoutput>
<div class="__PREFINITI_DOCUMENT"  style="background-color:##333; color:white;">
    
    <table width="100%" cellpadding="10" cellspacing="0" style="background-color:##333; color:white;">
    	
        <tr>
       		<td align="center" style="background-color:##333; color:white;">
				<cfif URL.Muted EQ true>
                    <img src="/graphics/sound_none.png" align="absmiddle" id="muteButton_#URL.Handle#" onmouseover="Tip('Click to un-mute this channel');" onmouseout="UnTip();" onclick="PMMUnmuteChannel('#URL.Handle#');">		
                <cfelse>
                    <img src="/graphics/sound.png" align="absmiddle" id="muteButton_#URL.Handle#" onmouseover="Tip('Click to mute this channel');" onmouseout="UnTip();" onclick="PMMMuteChannel('#URL.Handle#');">	
                </cfif>
            </td>
        	<td width="20%" style="background-color:##333; color:white;"><p style="text-transform:capitalize; font-size:8px; text-transform:uppercase; font-weight:bold;">#LCase(URL.Handle)#</p></td>
			
            <td width="35%" align="center"  style="background-color:##333; color:white;">
            	<cfmodule template="/Framework/CoreSystem/PMM/PanFader.cfm" handle="#URL.Handle#" pan="#URL.Pan#">
                <p style="font-size:6px; color:white; text-transform:uppercase;">l&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;balance&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R</p>
            </td>
            
            <td width="35%" align="center"  style="background-color:##333; color:white;">
            	<cfmodule template="/Framework/CoreSystem/PMM/VolumeFader.cfm" handle="#URL.Handle#" volume="#URL.Volume#" muted="#URL.Muted#">
                <p style="font-size:6px; color:white; text-transform:uppercase;">volume</p>
            </td>
        </tr>            
    
    </table>
	<hr>
</div>
</cfoutput>
