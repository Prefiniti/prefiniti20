
<div style="width:100%; height:30px;" class="__PREFINITI_DESKTOP_TOOLBAR">
<table cellspacing="0" cellpadding="0" width="100%">
<tr>
	<td align="left" width="50%" style="padding:8px;">
		<span id="CurrentWindowIcon">
        	<img src="/graphics/show_desktop.png" align="absmiddle"/>
        </span> 
        <span id="CurrentWindowTitle" style="margin-right:20px;">Prefiniti Desktop</span>
	
		<span id="gzPMenu" style="margin-left:20px; width:auto;">
        	<!--- menustrip container --->
        </span>
        
        <div 	id="__PREFINITI_MENU" 
        		class="__PREFINITI_MENUTABLE"
                style="display:none; position:absolute; z-index:2000; left:0px; top:0px; height:auto; min-height:100px; width:auto;  min-width:200px; -moz-opacity:0.85; opacity:0.85;">
			<!--- menu container --->                
		</div>
        
        <span id="PNotificationBar">
        	<!--- notification area --->
        </span>

	<div style="border:1px solid white; float:left; width:auto; height:10px; display:none;" id="CLoader">
            <cfloop index="i" from="1" to="18">
            	<cfoutput>
                	<div id="CLoad_#i#" style="float:left; width:10px; height:10px; margin-right:2px;">&nbsp;</div>
                </cfoutput> 
            </cfloop>
    </div>
	</td>
	<td align="right"><span id="Chat_NotifyBox"></span>
		<span id="SRR" style="display:none;"><img src="/Framework/CoreSystem/SRR.gif" align="absmiddle" onmouseover="Tip(BytesTransferred + ' bytes transferred.');" onmouseout="UnTip();" onclick="ConnectionInfo();"/></span>
		<span id="SRR-down" style="display:none;"><img src="/Framework/CoreSystem/SRR-down.gif" align="absmiddle" onmouseover="Tip(BytesTransferred + ' bytes transferred.');" onmouseout="UnTip();" onclick="ConnectionInfo();"/></span>
	
		<span id="PSystemClock"></span>
	</td>
</tr>
</table>
</div>

