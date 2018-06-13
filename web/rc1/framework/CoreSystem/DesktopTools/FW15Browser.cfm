<script src="/framework/UI/wz_tooltip.js" type="text/javascript"></script>



<cfquery name="toolbars" datasource="#session.DB_Core#">
	SELECT * FROM installed_toolbars WHERE user_id=#url.calledbyuser#
</cfquery>

<cfif toolbars.RecordCount LT 1>
	<cfquery name="SetUpToolbars" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#url.calledbyuser#, 1)
	</cfquery>
	<cfquery name="SetUpToolbars2" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#url.calledbyuser#, 2)
	</cfquery>
	<cfquery name="SetUpToolbars3" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#url.calledbyuser#, 3)
	</cfquery>
	<cfquery name="SetUpToolbars4" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#url.calledbyuser#, 4)
	</cfquery>
	<cfquery name="SetUpToolbars5" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#url.calledbyuser#, 5)
	</cfquery>
	<cfquery name="SetUpToolbars6" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#url.calledbyuser#, 6)
	</cfquery>
	<cfquery name="SetUpToolbars7" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#url.calledbyuser#, 7)
	</cfquery>
	<cfquery name="SetUpToolbars8" datasource="#session.DB_Core#">
		INSERT INTO installed_toolbars (user_id, toolbar_id)
		VALUES	(#url.calledbyuser#, 8)
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


<!---<cfif session.loggedin EQ "no">
	<cflocation url="/default.cfm" addtoken="no">
</cfif>--->
<cfquery name="fwb" datasource="#session.DB_Core#">
	UPDATE Users SET framework_base='Prefiniti_1_5.cfm?FW15' WHERE id=#url.calledbyuser#
</cfquery>


<div id="tcTarget" class="ContentBar">

</div>

<div id="LandingPage">

</div>

<div id="LandingPageShadow">

</div>