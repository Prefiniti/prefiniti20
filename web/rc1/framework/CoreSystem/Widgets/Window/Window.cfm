<!---

var WS_ALLOWCLOSE 		= 1;
var WS_ALLOWMINIMIZE 	= 2;
var WS_ALLOWMAXIMIZE 	= 4;
var WS_ALLOWRESIZE 		= 8;
var WS_SHOWAPPMENU 		= 16;
var WS_ENABLEPDM 		= 32;
var WS_ROOT 			= 64;
var WS_MODAL 			= 128;
var WS_ALLOWREFRESH 	= 256;
var WS_DESKTOOL 		= 512;

--->

<cfparam name="ThemeBase" default="">
<cfset ThemeBase="/Framework/StockResources/Themes/#URL.Theme#">

<cfoutput>
<cfif BitAnd(URL.Style, 64)> 		<!--- WS_ROOT --->

		
	<div id="#URL.Handle#_ToolbarStrip" style="width:#URL.Width#px; height:20px;"></div>
	<div id="DesktopFolder" style="width:#URL.Width#px; height:#URL.Height#px;"></div>
	
<cfelse>							<!--- CHILD WINDOW --->
	<table width="100%" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td align="left" class="__PREFINITI_TLC" style="background-position:right;"><!--- TLC ---><div style="width:8px;"></div></td>
			<td class="__PREFINITI_ICON"  style="background-color:transparent;"><!--- ICON --->
				<cfif BitAnd(URL.Style, 16)> <!--- WS_SHOWAPPMENU --->
					<img src="#URL.Icon#" 
						 onclick="PGetWindowMenu('#URL.Handle#', this, event);" align="absmiddle" width="16" height="16" ondblclick="p_session.Framework.PShadeWindow(AjaxGetElementReference('#URL.Handle#'));" style="background-color:transparent;">
				<cfelse>
					<img src="#URL.Icon#" align="absmiddle" width="16" height="16" style="background-color:transparent;">
				</cfif>
			</td>
			<td align="left" 
				class="__PREFINITI_TITLEBAR"
				onclick="p_session.Framework.SetFocus('#URL.Handle#');" 
				onmousedown="p_session.Framework.PMoveWindow(AjaxGetElementReference('#URL.Handle#'), event, '#URL.Handle#');"
				ondblclick="p_session.Framework.PShadeWindow(event, '#URL.Handle#');"><!---TITLE--->
			
			<div id="#URL.Handle#_titlex" 
				onclick="p_session.Framework.SetFocus('#URL.Handle#');" 
				onmousedown="p_session.Framework.PMoveWindow(AjaxGetElementReference('#URL.Handle#'), event, '#URL.Handle#');"
				
				align="left"
				class="__PREFINITI_TITLETEXTWRAPPER">
				<div id="#URL.Handle#_TitleText" style="padding-top:8px; padding-left:8px;">
					<strong class="__PREFINITI_TITLETEXT">#URL.Title#</strong>
				</div>
			</div>
			</td>
			<td 
			class="__PREFINITI_CONTROLS" 
			align="right" 
			onmousedown="p_session.Framework.PMoveWindow(AjaxGetElementReference('#URL.Handle#'), event, '#URL.Handle#');" 
			style="background-color:transparent; border:none;"
			onclick="p_session.Framework.SetFocus('#URL.Handle#');" >
				<!--- CONTROLS --->
				
				
				<cfif BitAnd(URL.Style, 256)>   	<!--- WS_ALLOWREFRESH --->
						<img src="#ThemeBase#/refresh.png" align="absmiddle" border="0" 
						onclick="p_session.Framework.PostLocalMessage('#URL.Handle#', IWC_REQUESTREFRESH, C_WINDOWMANAGER, null); KillEv(event);">
				</cfif>
				
				<cfif BitAnd(URL.Style, 2)>			<!--- WS_ALLOWMINIMIZE --->
						<img src="#ThemeBase#/minimize.png" align="absmiddle" border="0"
						onclick="p_session.Framework.PostLocalMessage('#URL.Handle#', IWC_REQUESTMINIMIZE, C_WINDOWMANAGER, null); KillEv(event);">
				</cfif>
						
				<cfif BitAnd(URL.Style, 4)>			<!--- WS_ALLOWMAXIMIZE --->
						<img src="#ThemeBase#/maximize.png" align="absmiddle" border="0" 
						onclick="p_session.Framework.PostLocalMessage('#URL.Handle#', IWC_REQUESTMAXIMIZE, C_WINDOWMANAGER, null); KillEv(event);"
						id="#URL.Handle#_MaxButton">
						<img src="#ThemeBase#/restore.png" align="absmiddle" border="0" 
						onclick="p_session.Framework.PostLocalMessage('#URL.Handle#', IWC_REQUESTMAXIMIZE, C_WINDOWMANAGER, null); KillEv(event);"
						id="#URL.Handle#_RestoreButton"
						style="display:none;">
				</cfif>
				
				<cfif BitAnd(URL.Style, 1)> 		<!--- WS_ALLOWCLOSE --->
						<img src="#ThemeBase#/close.png" align="absmiddle" border="0"
						onclick="p_session.Framework.PostLocalMessage('#URL.Handle#', IWC_REQUESTCLOSE, C_WINDOWMANAGER, null); KillEv(event);">
				</cfif>
					
			</td>
			<td class="__PREFINITI_TRC" align="right"><!--- TRC --->&nbsp;<div style="width:8px;"></div></td>
		</tr>
		<tr>
        	<cfparam name="LeftEdgeClass" default="">
           	<cfif BitAnd(URL.Style, 8)>
            	<cfset LeftEdgeClass = "__PREFINITI_LEFTEDGE_RESIZE">
            <cfelse>
            	<cfset LeftEdgeClass = "__PREFINITI_LEFTEDGE">
            </cfif>
                
			<td onclick="p_session.Framework.SetFocus('#URL.Handle#');"  class="#LeftEdgeClass#" style="background-color:transparent; background-position:right;">
			<!--- LEFTEDGE--->&nbsp;<div style="width:8px;"></div></td>
			<td colspan="3" style="background-color:white; border:none;" >
				
				
				<!--- INNERFRAME --->
				<div id="#URL.Handle#_InnerFrame" class="__PREFINITI_INNERFRAME" id="#URL.Handle#_InnerFrame" style="width:auto; height:auto;">
				
				
					<!--- TOOLBARSTRIP --->
					<div id="#URL.Handle#_ToolbarStrip" class="__PREFINITI_TOOLBAR" style="width:100%; height:auto;" >
					</div>
					
					<!--- CLIENTAREA --->
					<div id="#URL.Handle#_ClientArea" class="__PREFINITI_CLIENTAREA"  style="width:#URL.Width#px; height:#URL.Height#px; overflow:auto;">
					
					</div>
				</div>
				
			</td>
			<td 
			<cfif BitAnd(URL.Style, 8)>
				class="__PREFINITI_RIGHTEDGE_RESIZE"
				onmousedown="p_session.Framework.PResizeWindowLeftRight('#URL.Handle#', event);"
			<cfelse>
				class="__PREFINITI_RIGHTEDGE"
			</cfif> 
			style="background-color:transparent; border:none; background-position:left;"
			onclick="p_session.Framework.SetFocus('#URL.Handle#');" ><!---RIGHTEDGE--->&nbsp;<div style="width:8px;"></div></td>
		</tr>
		
		<tr>
			<td align="left" class="__PREFINITI_BLC" valign="bottom" style="background-position:top right;"><!---BLC --->
				&nbsp;<div style="width:8px;"></div>
			</td>
			<td 
			<cfif BitAnd(URL.Style, 8)>
				class="__PREFINITI_BOTTOMEDGE_RESIZE"
				onmousedown="p_session.Framework.PResizeWindowUpDown('#URL.Handle#', event);"
			<cfelse>
				class="__PREFINITI_BOTTOMEDGE"
			</cfif>
			colspan="3" 
			align="right" 
			style="background-color:transparent;"
			onclick="p_session.Framework.SetFocus('#URL.Handle#');" >&nbsp;
			</td>
			
			<cfparam name="BRCSTYLE" default="">
			<cfif BitAnd(URL.Style, 8)>
				<cfset BRCSTYLE = "__PREFINITI_BRC_RESIZE">
			<cfelse>
				<cfset BRCSTYLE = "__PREFINITI_BRC">
			</cfif>
							
			<td align="right" class="#BRCSTYLE#" onmousedown="p_session.Framework.PResizeWindow('#URL.Handle#', event);" valign="bottom" style="background-color:transparent; background-position:top left;"><!--- BRC --->	
			
				&nbsp;
			
			</td>
		</tr>
	</table>
</cfif>
</cfoutput>