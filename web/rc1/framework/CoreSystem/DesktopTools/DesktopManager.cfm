<cfinclude template="/framework/framework_udf.cfm">
<cfoutput>

<cfparam name="DockWidth" default=" width:auto;">
<cfparam name="GCIStyle" default="PWindowGCIcon">
<cfparam name="PDMStyle" default="PDesktopManager">
<cfparam name="PWLClass" default="PWindowList">

<cfif URL.HP_Browser EQ "Microsoft Internet Explorer">
	<cfset DockWidth = " width:auto;">
	<cfset GCIStyle = "PWindowGCIconMSIE">
	<cfset PDMStyle = "PDesktopManagerMSIE">
	<cfset PWLClass = "PWindowListMSIE">
</cfif>

<!---LoadControlPanel('#Attributes.PanelID#', '#Attributes.Title#');--->

<div id="PDesktopManager" class="#PDMStyle#" style="z-index:2000; #DockWidth#">
	
	<div id="PWindowGenControls" style="#DockWidth# float:left;">
		<cfif BitAnd(URL.PAFFLAGS, 8)>
		<a class="#GCIStyle#" href="javascript:P15Browser(null);"><img src="/graphics/pi.png" border="0" align="top" width="32" height="32" id="DockIcon_1" onmouseover="ZoomIcon('DockIcon_1'); Tip('Prefiniti Network Browser');" onmouseout="UnZoomIcon('DockIcon_1'); UnTip();"/></a>
		</cfif>
		<a class="#GCIStyle#" href="####" onclick="POpenCart(#URL.CalledByUser#);"><img src="/graphics/AppIconResources/crystal_project/32x32/actions/shopping_cart.png" border="0" align="top" width="32" height="32" id="DockIcon_12" onmouseover="ZoomIcon('DockIcon_12'); Tip('Shopping Cart');" onmouseout="UnZoomIcon('DockIcon_12'); UnTip();"/></a>
		<a class="#GCIStyle#" href="####" onclick="POpenFriendChooser(#URL.CalledByUser#, null, false, true, true, true, true, true);"><img src="/graphics/AppIconResources/crystal_project/32x32/actions/groupevent.png" border="0" align="top" width="32" height="32" id="DockIcon_11" onmouseover="ZoomIcon('DockIcon_11'); Tip('Browse People');" onmouseout="UnZoomIcon('DockIcon_11'); UnTip();"/></a>
		
		<a class="#GCIStyle#" href="####" onclick="myCalc = new Calculator(); myCalc.Show(0);"><img src="/graphics/AppIconResources/crystal_project/32x32/apps/calc.png" border="0" align="top" width="32" height="32" id="DockIcon_13" onmouseover="ZoomIcon('DockIcon_13'); Tip('Calculator');" onmouseout="UnZoomIcon('DockIcon_13'); UnTip();"/></a>
		
		<cfif BitAnd(URL.PAFFLAGS, 128)>
		<a class="#GCIStyle#" href="javascript:PSessionBar();"><img src="/graphics/AppIconResources/crystal_project/32x32/actions/agt_member.png" border="0" align="top" width="32" height="32" id="DockIcon_10" onmouseover="ZoomIcon('DockIcon_10'); Tip('Member Services');" onmouseout="UnZoomIcon('DockIcon_10'); UnTip();"/></a>
		</cfif>
		
		<cfif BitAnd(URL.PAFFLAGS, 1024)>
		<a class="#GCIStyle#" href="javascript:PSysCtls();"><img src="/graphics/AppIconResources/crystal_project/32x32/apps/kservices.png" border="0" align="absmiddle" id="DockIcon_9" onmouseover="ZoomIcon('DockIcon_9'); Tip('Prefiniti Settings');" onmouseout="UnZoomIcon('DockIcon_9'); UnTip();"/></a>
		</cfif>
		
		<a class="#GCIStyle#" href="javascript:p_session.Framework.ShowDesktop();"><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/filesystems/desktop.png" border="0" align="absmiddle" id="DockIcon_2" onmouseover="ZoomIcon('DockIcon_2'); Tip('Show Desktop');" onmouseout="UnZoomIcon('DockIcon_2'); UnTip();"/></a>
		<a class="#GCIStyle#" href="javascript:p_session.Framework.CascadeWindows();"><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/apps/windowlist.png" border="0" align="absmiddle" id="DockIcon_3" onmouseover="ZoomIcon('DockIcon_3'); Tip('Cascade Windows');" onmouseout="UnZoomIcon('DockIcon_3'); UnTip();"></a>
		<a class="#GCIStyle#" href="javascript:pf_show_map();"><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/apps/web.png" border="0" align="absmiddle" id="DockIcon_4" onmouseover="ZoomIcon('DockIcon_4'); Tip('Maps');" onmouseout="UnZoomIcon('DockIcon_4'); UnTip();"/></a>
		<!---<a class="#GCIStyle#" href="javascript:AjaxLoadPageToWindow('/search/components/prefiniti_search.cfm', 'Search');"><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/apps/search.png" border="0" align="absmiddle"  id="DockIcon_5" onmouseover="ZoomIcon('DockIcon_5'); Tip('Search');" onmouseout="UnZoomIcon('DockIcon_5'); UnTip();"/></a>--->
        
        <a class="#GCIStyle#" href="javascript:LoadControlPanel('Games', 'Games');"><img src="/graphics/AppIconResources/crystal_project/32x32/apps/package_games.png" border="0" align="absmiddle"  id="DockIcon_14" onmouseover="ZoomIcon('DockIcon_14'); Tip('Games');" onmouseout="UnZoomIcon('DockIcon_14'); UnTip();"/></a>
		
		<cfif BitAnd(URL.PAFFLAGS, 16)>
		<a class="#GCIStyle#" href="javascript:Chat_EntryPoint();"><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/apps/chat.png" border="0" align="absmiddle"  id="DockIcon_6" onmouseover="ZoomIcon('DockIcon_6'); Tip('Prefiniti Chat');" onmouseout="UnZoomIcon('DockIcon_6'); UnTip();"/></a>
		</cfif>
		
		<cfif BitAnd(URL.PAFFLAGS, 32)>
		<a class="#GCIStyle#" href="javascript:showConsole();"><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/apps/terminal.png" border="0" align="absmiddle" id="DockIcon_7" onmouseover="ZoomIcon('DockIcon_7'); Tip('Prefiniti Console');" onmouseout="UnZoomIcon('DockIcon_7'); UnTip();"></a>
		</cfif>
		
		<a class="#GCIStyle#" href="javascript:PHelpBrowser(0);"><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/apps/khelpcenter.png" border="0" align="absmiddle"  id="DockIcon_8" onmouseover="ZoomIcon('DockIcon_8'); Tip('Help and Support');" onmouseout="UnZoomIcon('DockIcon_8'); UnTip();"/></a>
		<!---<cfif BitAnd(URL.PAFFLAGS, 2)>
			
			#fwGetSidebarHeadingsEx(URL.current_association, GCIStyle)#
			
			
		</cfif>--->
    </div>
    
    <div id="PWindowList" class="#PWLClass#">
    
    </div>
    
    
</div>
</cfoutput>

