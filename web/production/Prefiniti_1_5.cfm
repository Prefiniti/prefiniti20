<head><title>The Prefiniti Network</title>
<script type="text/javascript">
	function LoadHandler15 () {
		hideDiv('ClassicSiteSelect');
		hideDiv('ClassicMenus');
		loadHomeView();
		hideSplash();
		PrefinitiLegacyInit();
		fwRegisterAutoUpdate("/framework/components/sitestats_15.cfm", "SiteStatsDiv");
		if(glob_AutoCatalog.toString() != '') {
			try {
				ViewCatalog(glob_AutoCatalog);
			}
			catch (ex) {}
		}
		LoadDockedFavorites();
	}
</script>
</head>
<body onLoad="LoadHandler15();">
<a name="top"></a>

<script src="/framework/UI/wz_tooltip.js" type="text/javascript"></script>

<cfquery name="toolbars" datasource="#session.DB_Core#">
	SELECT * FROM installed_toolbars WHERE user_id=#session.userid#
</cfquery>

<cfif toolbars.RecordCount LT 1>
	<cfquery name="SetUpToolbars" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#session.userid#, 1)
	</cfquery>
	<cfquery name="SetUpToolbars2" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#session.userid#, 2)
	</cfquery>
	<cfquery name="SetUpToolbars3" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#session.userid#, 3)
	</cfquery>
	<cfquery name="SetUpToolbars4" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#session.userid#, 4)
	</cfquery>
	<cfquery name="SetUpToolbars5" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#session.userid#, 5)
	</cfquery>
	<cfquery name="SetUpToolbars6" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#session.userid#, 6)
	</cfquery>
	<cfquery name="SetUpToolbars7" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#session.userid#, 7)
	</cfquery>
	<cfquery name="SetUpToolbars8" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#session.userid#, 8)
	</cfquery>
</cfif>	

<!--- NEW STYLES --->
<style type="text/css">
	#PrefinitiToolbar {
		width:100%;
		clear:left;
	}
	
	.LargeButton {
		font-size:16px;
		font-family:Tahoma, Verdana, Arial, Helvetica, sans-serif;
		float:left;
		margin-left:15px;
		margin-top:5px;
		padding:8px;
		background-color:#EFEFEF;
		-moz-border-radius:5px;
	}
	
	.TabBar {
		margin-top:8px;
		margin-left:10px;
		width:100%;
	}
	
	.ContentBar {
		border-top:1px solid #EFEFEF;
		width:100%;
		height:auto;
		clear:left;
	}

	#LandingPage {
		-moz-border-radius:5px;
		display:none;
		z-index:2000;
		background-color:white;
		border:1px solid #C0C0C0;
		position:absolute;
		left:80px;
		top:90px;
		width:550px;;
		height:450px;
		padding:10px;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:12px;
	}
	
	#LandingPage td {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:12px;
	}
	
	#LandingPageShadow {
		-moz-border-radius:5px;
		display:none;
		z-index:1800;
		background-color:gray;
		border:1px solid gray;
		position:absolute;
		left:85px;
		top:95px;
		width:550px;
		height:450px;
		padding:10px;
	}
	
	#SiteStatsDiv {
		width:100%;
		padding:0px;
		margin:0px;
		height:20px;
		
	}
	
	#tcTarget {
		border-top:1px solid #EFEFEF;
		border-bottom:none;
		border-left:none;
		border-right:none;
	}
	
	.PNotifyText {
		font-family:Verdana;
		font-size:10px;
		font-weight:normal;
		color:#3300CC;
		text-transform:uppercase;
	}
	
	.bigBox {
		width:792px;
		height:289px;
		ba
		ckground-image:url(/homeres/back_01.jpg);
		background-repeat:no-repeat;
		margin-top:20px;
	}
</style>
<!--- END NEW STYLES --->


<cfif session.loggedin EQ "no">
	<cflocation url="/default.cfm" addtoken="no">
</cfif>
<cfquery name="fwb" datasource="#session.DB_Core#">
	UPDATE Users SET framework_base='Prefiniti_1_5.cfm?FW15' WHERE id=#session.userid#
</cfquery>

<div id="TabBar" class="TabBar">
	<div style="float:left;">
	<cfif #session.loggedin# EQ "yes">
        
            <a href="javascript:navigateBack();"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/back.png" border="0" align="absmiddle"  onmouseover="Tip('Back');" onMouseOut="UnTip();"/></a>
            <a href="javascript:navigateForward();"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/forward.png" border="0" align="absmiddle"  onmouseover="Tip('Forward');" onMouseOut="UnTip();"/></a>
            
            <a href="javascript:AjaxRefreshTarget();"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/reload.png" border="0" align="absmiddle"  onmouseover="Tip('Refresh');" onMouseOut="UnTip();"/></a>&nbsp;
            <a href="javascript:AddTargetToFavorites();"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/bookmark_add.png" border="0" align="absmiddle" onMouseOver="Tip('Add to favorites');" onMouseOut="UnTip();" /></a> 
			<cfoutput><a href="javascript:POpenCart(#session.userid#);"><img src="/graphics/cart.png" align="absmiddle" onMouseOver="Tip('View my shopping cart');" onMouseOut="UnTip();" border="0"></a></cfoutput>
			<a href="/logoff.cfm"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/shutdown.png" border="0" align="absmiddle" onMouseOver="Tip('Sign Out');" onMouseOut="UnTip();" /></a>
            
            <span id="file_action" style="width:100%; background-color:white; display:none; padding:5px;">
                <input type="hidden" name="selected_file_id" id="selected_file_id" value="">
                <input type="hidden" name="current_mode" id="current_mode" value="" />
                <!--function mailWithAttachments(attachment_file_id, attachment_file_name)-->
                <span id="cms_send_file"><img src="/graphics/email_attach.png" border="0" align="absmiddle"> <a href="javascript:mailWithAttachments(GetValue('selected_file_id'))">Send File</a> |&nbsp;</span>
                <span id="cms_delete_file"><img src="/graphics/bin.png" border="0" align="absmiddle"> <a href="javascript:cmsDeleteFile(GetValue('selected_file_id'), GetValue('current_mode'));">Delete File</a> |&nbsp;</span>
                <img src="/graphics/zoom.png" border="0" align="absmiddle"> <a href="javascript:cmsViewFile(GetValue('selected_file_id'), GetValue('current_mode'));">View File</a>
			</span>                
        
        
	</cfif>
   	</div>
    <div id="Sidebars" style="float:left; width:auto; margin-left:5px;"></div>  
	<div id="sbTarget" style="float:left;"></div>   <!--- THIS IS THE TAB BAR --->
	<div style="position:absolute; top:3px; right:3px;">
	<a href="##" onClick="PCustomizeToolbar();">Toolbar Settings</a>
	</div>
	
	<div style="position:fixed; bottom:3px; right:3px; border:1px solid #EFEFEF; padding:5px; -moz-border-radius:5px;">
		[<a href="#top">Return to top</a>]
	</div>
</div>
<!--- TOOLBAR --->
<div id="PrefinitiToolbar">
<table width="100%">
<tr><td style="border-top:1px solid #EFEFEF; background-color:#EFEFEF;">
	<img src="/graphics/prefiniti-square.png" style="float:left;" align="absmiddle">
    <div class="LargeButton" onClick="OpenLanding('Account.cfm');">
    	<cfoutput>
        <img src="#profile.picture#" width="32" height="32" align="absmiddle"> #profile.firstName#
    	</cfoutput>
    </div>
	
	<div id="barz">
	<cfquery name="pt" datasource="#session.DB_Core#">
		SELECT * FROM installed_toolbars WHERE user_id=#session.userid# AND display=1 
	</cfquery>
	
	<cfoutput query="pt">
		<cfmodule template="/framework/components/toolbar_button.cfm" toolbar_id="#toolbar_id#" user_id="#session.userid#">
	</cfoutput>
	</div>
   
</td></tr></table>    
</div>
<div id="DockedFavorites">

</div>
<div id="SiteStatsDiv" style="padding-top:3px;">

</div>

<!--- END TOOLBAR --->
<div id="tcTarget" class="ContentBar">

</div>

<div id="LandingPage">

</div>

<div id="LandingPageShadow">

</div>



</body>