<head><title>The Prefiniti Network</title></head>

<cfif session.browserType EQ "Microsoft Internet Explorer">
	<h1>Unsupported Browser</h1>
    
    <p>Prefiniti no longer supports any version of Microsoft Internet Explorer. You will be redirected to the home page in a few moments, where you will be presented with links to download a supported browser.</p>
    
    <script>
		window.setTimeout("location.replace('/default.cfm');", 10000);
	</script>		
</cfif>  

<cfif session.loggedin EQ "no">
	<cflocation url="/default.cfm" addtoken="no">
</cfif>
<cfquery name="fwb" datasource="#session.DB_Core#">
	UPDATE Users SET framework_base='Prefiniti.cfm?steel' WHERE id=#session.userid#
</cfquery>
<cfinclude template="/framework/components/navigator.cfm">
<cfinclude template="/framework/components/PrefinitiLauncher.cfm">
<cfinclude template="/StatsDiv.cfm">
	

<script>
InitializePrefiniti();

</script>