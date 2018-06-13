<!---/graphics/AppIconResources/#session.PDMDefaultTheme#/32x32/apps/krfb.png--->
<cfoutput>
<div id="PDesktopManager" class="PDesktopManager">
	<div id="PWindowGenControls" style="width:auto; float:left;">
   	
    <a class="PWindowGCIcon" href="javascript:PShowNavigator();"><img src="/graphics/pi.png" border="0" align="top" width="32" height="32" id="DockIcon_1" onmouseover="ZoomIcon('DockIcon_1');" onmouseout="UnZoomIcon('DockIcon_1');"/></a>
   
    <a class="PWindowGCIcon" href="javascript:p_session.Framework.ShowDesktop();"><img src="/graphics/AppIconResources/#session.PDMDefaultTheme#/32x32/filesystems/desktop.png" border="0" align="absmiddle" id="DockIcon_2" onmouseover="ZoomIcon('DockIcon_2');" onmouseout="UnZoomIcon('DockIcon_2');"/></a>
    <a class="PWindowGCIcon" href="javascript:p_session.Framework.CascadeWindows();"><img src="/graphics/AppIconResources/#session.PDMDefaultTheme#/32x32/apps/windowlist.png" border="0" align="absmiddle" id="DockIcon_3" onmouseover="ZoomIcon('DockIcon_3');" onmouseout="UnZoomIcon('DockIcon_3');"></a>
    <a class="PWindowGCIcon" href="javascript:pf_show_map();"><img src="/graphics/AppIconResources/#session.PDMDefaultTheme#/32x32/apps/web.png" border="0" align="absmiddle" id="DockIcon_4" onmouseover="ZoomIcon('DockIcon_4');" onmouseout="UnZoomIcon('DockIcon_4');"/></a>
    <a class="PWindowGCIcon" href="javascript:AjaxLoadPageToWindow('/search/components/prefiniti_search.cfm', 'Search');"><img src="/graphics/AppIconResources/#session.PDMDefaultTheme#/32x32/apps/search.png" border="0" align="absmiddle"  id="DockIcon_5" onmouseover="ZoomIcon('DockIcon_5');" onmouseout="UnZoomIcon('DockIcon_5');"/></a>
    <a class="PWindowGCIcon" href="javascript:Chat_EntryPoint();"><img src="/graphics/AppIconResources/#session.PDMDefaultTheme#/32x32/apps/chat.png" border="0" align="absmiddle"  id="DockIcon_6" onmouseover="ZoomIcon('DockIcon_6');" onmouseout="UnZoomIcon('DockIcon_6');"/></a>
    <cfif session.webware_admin EQ 1>
		<a class="PWindowGCIcon" href="javascript:showConsole();"><img src="/graphics/AppIconResources/#session.PDMDefaultTheme#/32x32/apps/terminal.png" border="0" align="absmiddle" id="DockIcon_7" onmouseover="ZoomIcon('DockIcon_7');" onmouseout="UnZoomIcon('DockIcon_7');"></a>
    </cfif>
    
    <a class="PWindowGCIcon" href="javascript:PHelpBrowser(0);"><img src="/graphics/AppIconResources/#session.PDMDefaultTheme#/32x32/apps/khelpcenter.png" border="0" align="absmiddle"  id="DockIcon_8" onmouseover="ZoomIcon('DockIcon_8');" onmouseout="UnZoomIcon('DockIcon_8');"/></a>
    </div>
    
    <div id="PWindowList" class="PWindowList">
    
    </div>
    
    
</div>
</cfoutput>