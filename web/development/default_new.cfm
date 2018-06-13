<head>
	<cfquery name="GetBase" datasource="#session.DB_Core#">
		SELECT * FROM basescripts WHERE RunAt <= 2 AND Enabled=1 ORDER BY RunAt, id 
	</cfquery>
    
    
	<title>The Prefiniti Network</title>
	
	<link rel="stylesheet" href="/Framework/CoreSystem/Styles/Base.css" type="text/css">
	<script src="/Framework/CoreSystem/CodeTransport.js" type="text/javascript"></script>
	<script src="/Framework/CoreSystem/LegacySupport.js" type="text/javascript"></script>
	<script src="/framework/components/paf_debug.js" type="text/javascript"></script>
    
	
	<cfoutput>
	<script>
		
	
	
		
		function OB(url)
		{
			var screenWidth;
			var screenHeight;
			
			if (window.innerWidth) {
				screenWidth = window.innerWidth;
				screenHeight = window.innerHeight;
			}
			else if (document.all) {
				screenWidth = document.body.clientWidth;
				screenHeight = document.body.clientHeight;
			}
			
			var leftPos = (screenWidth / 2) - 320;
			var topPos = (screenHeight / 2) - 200;
			
			showDivBlock('OfflineBrowser');
			
			var obRef = AjaxGetElementReference('OfflineBrowser');
			
			obRef.style.left = leftPos + "px";
			obRef.style.top = topPos + "px";
			
			var rh = new KRequestHeaders();
			rh.Add(new KRequestParam("Dummy", 0));
			
			var res = KSynchronousRequest(url, rh);
			
			SetInnerHTML('ibt', res);
		}
		
		var HP_CGI_Browser = '#CGI.HTTP_USER_AGENT#';
		var HP_CGI_NetworkNode = '#CGI.REMOTE_ADDR#';
			
		var HP_Browser = null;
		var HP_OS = null;
			
		var HPB_FIREFOX = 'Mozilla Firefox';
		var HPB_MSIE = 'Microsoft Internet Explorer';
		var HPB_SAFARI = 'Apple Safari';
		var HPB_OPERA = 'Opera';
			
		var HPOS_WINDOWS = 'Microsoft Windows';
		var HPOS_MACOS = 'MacOS';
		var HPOS_LINUX = 'Linux';
		var HPOS_OS2 = 'IBM OS/2';
		
		var HP_PrefinitiHostKey = '#session.PrefinitiHostKey#';
		var I_Mode = '#session.InstanceMode#';
		var I_Name = '#session.InstanceName#';
		
		var scripts = new Array(1);
		
		var glob_userid;
		var glob_companyid;
		var glob_usertype;
		var glob_isAdmin;
		var glob_isTCAdmin;
		var glob_unreadMail;
		var glob_order_processor;
		var glob_site_maintainer;
		var glob_browser;
		var glob_firstLoad;
		var glob_userName;
		var glob_longName;
		var glob_tcopen;
		var glob_tcsigned;
		var glob_overdue;
		var glob_newJobs;
		var glob_current_association;
		var glob_current_site_id;
		var glob_framework_loaded;
		var glob_uploader;
		var glob_current_latitude;
		var glob_current_longitude;
		var glob_steel=true;
		var glob_prefiniti_admin;
		var glob_PDMDefaultTheme;
		
		function LoadScripts() {
			for (i in scripts) {
				loadjscssfile(scripts[i], "js");
				
			}
			
			try {
			
			}
			catch (ex) {}
			
			
			
			document.getElementById('PrefinitiLoading').style.display = "none";
			document.getElementById('BeginButton').style.display = "inline";
			document.getElementById('LoaderPleaseWait').style.display = "none";
			
		}
		
		function LoadHandler()
		{
			var imgWidth = 425;
			var imgHeight = 450;
			var screenWidth = 0;
			var screenHeight = 0;
			
			if (window.innerWidth) {
				screenWidth = window.innerWidth;
				screenHeight = window.innerHeight;
			}
			else if (document.all) {
				screenWidth = document.body.clientWidth;
				screenHeight = document.body.clientHeight;
			}
			
			var leftPos = (screenWidth / 2) - (imgWidth / 2);
			var leftPosX = (screenWidth / 2) - (317 / 2);
			//var topPos = (screenHeight / 2) - (imgHeight / 2);
			
			
			var lbRef = document.getElementById('HostInfo');
			var ldRef = document.getElementById('PrefinitiLogo');
			ldRef.style.left = leftPosX + "px";
			
			var lbWidth = lbRef.clientWidth;
			var lbHeight = lbRef.clientHeight;
			
			var lbLeftPos = (screenWidth / 2) - (lbWidth / 2);
			//alert(lbLeftPos.toString());
			lbRef.style.left = lbLeftPos + "px";
			//lbRef.style.top = topPos + 180 + "px";
			
			
			window.setTimeout("LoadScripts();", 6000);
			
			
			
			
			
			
			
			if(HP_CGI_Browser.indexOf('Firefox') != -1) {
				HP_Browser = HPB_FIREFOX;
			}
			
			if(HP_CGI_Browser.indexOf('Internet Explorer') != -1) {
				HP_Browser = HPB_MSIE;
			}
			
			if(HP_CGI_Browser.indexOf('Safari') != -1) {
				HP_Browser = HPB_SAFARI;
			}
			
			if(HP_CGI_Browser.indexOf('Opera') != -1) {
				HP_Browser = HPB_OPERA;
			}
			
			if(HP_CGI_Browser.indexOf('Windows') != -1) {
				HP_OS = HPOS_WINDOWS;
			}
			
			if(HP_CGI_Browser.indexOf('Mac') != -1) {
				HP_OS = HPOS_MACOS;
			}
			
			if(HP_CGI_Browser.indexOf('Linux') != -1) {
				HP_OS = HPOS_LINUX;
			}
			
			if(HP_CGI_Browser.indexOf('OS/2') != -1) {
				HP_OS = HPOS_OS2;
			}
			
			if(!HP_Browser) {
				HP_Browser = HPB_MSIE;
			}
			

					
			if (I_Mode != 'Development') {
				hideDiv('prefiniti_console_wrapper');
			}
			
			
			<cfif IsDefined("URL.Confirm")>
				var confStr = '/Framework/CoreSystem/Security/Resources/ConfirmAccount.cfm?cid=#URL.Confirm#';
				OB(confStr);
			</cfif>
			
			
			
			//writeConsole("LoadHandler() completed");
			
			return;
			
			
		} /* LoadHandler() */
	</script>
	</cfoutput>
	

</head>

<!--- CHECK FOR INSTANCE CONFIGURATION --->
<cfif session.InstanceName EQ "" OR session.DB_Core EQ "" OR session.DB_Sites EQ "" OR session.DB_CMS EQ "">
	<cflocation url="/Instance/ConfigureInstance.cfm" addtoken="no">
</cfif>


<!--- SET UP DEBUGGING & RSS --->
<cfinclude template="/console.cfm">
<cfinclude template="/Framework/CoreSystem/HTMLResources/ConfigureRSS.cfm">

<!--- CONFIGURE HOSTS --->
<cfif IsDefined("cookie.PrefinitiHostKey")>
	<cfset session.PrefinitiHostKey = cookie.PrefinitiHostKey>
	
	<cfquery name="CheckServerHosts" datasource="#session.DB_Core#">
		SELECT * FROM hosts WHERE HostKey='#session.PrefinitiHostKey#'
	</cfquery>
	
	<cfif CheckServerHosts.RecordCount EQ 0>
		<cfquery name="WriteNewHost2" datasource="#session.DB_Core#">
			INSERT INTO hosts
				(HostKey,
				HostName,
				HostDescription,
				DefaultRunLevel,
				BootTimeout)
			VALUES
				('#session.PrefinitiHostKey#',
				'[New Host]',
				'You will be asked to configure this host when you log in.',
				3,
				10)
		</cfquery>
	</cfif>
<cfelse>
	<cfset session.PrefinitiHostKey = CreateUUID()>
	<cfcookie name="PrefinitiHostKey" expires="never" value="#session.PrefinitiHostKey#">
	<cfquery name="WriteNewHost" datasource="#session.DB_Core#">
		INSERT INTO hosts
			(HostKey,
			HostName,
			HostDescription,
			DefaultRunLevel,
			BootTimeout)
		VALUES
			('#session.PrefinitiHostKey#',
			'[New Host]',
			'You will be asked to configure this host when you log in.',
			3,
			10)
	</cfquery>
</cfif>

<cfquery name="GetHost" datasource="#session.DB_Core#">
	SELECT * FROM hosts WHERE HostKey='#session.PrefinitiHostKey#'
</cfquery>

<cfquery name="GetSessions" datasource="#session.DB_Core#">
	SELECT * FROM auth_tokens WHERE HP_PrefinitiHostKey='#session.PrefinitiHostKey#' ORDER BY login_date DESC
</cfquery>
<!--- END OF CONFIGURE HOSTS --->

<!--- DIVS --->
<style type="text/css">
		.olb td {
			background-color:black;
			color:white;
			font-family:Verdana, Arial, Helvetica, sans-serif;
		}
		.orb td {
			background-color:black;
			color:white;
			font-family:Verdana, Arial, Helvetica, sans-serif;
			border-bottom:1px solid gray;
		}
		.LoadTable td {
			border-bottom:1px solid #999999;
			background-color:#C0C0C0;
		}
		
	</style>
    
    
<div id="HostInfo" style="width:450px; height:auto; background-color:black; color:white; top:0px; left:0px; position:absolute; border:1px solid white; padding:5px; -moz-border-radius-bottomleft:5px; -moz-border-radius-bottomright:5px; z-index:50000;">
	
    <div id="Login_Box" style="display:none;">
		<cfoutput query="GetHost">
        <table width="100%" cellpadding="5" cellspacing="0" style="border:1px solid blue;">
        <tr>
            <td width="84"><img src="/graphics/AppIconResources/crystal_project/64x64/devices/Globe.png" align="absmiddle" style="padding:10px;"> </td>
            <td align="center">
                <h1>#HostName#</h1>
                <p>#HostDescription#</p>
            </td>
        </tr>
        </table>
        
        
        </cfoutput>
        <div style="width:100%; height:100px; overflow:auto; background-color:white;">
            <table width="100%" class="ModTable">
                <tr>
                    <th>User</th>
                    <th>Login Date</th>
                    <th>Logout Date</th>
                </tr>
            <cfoutput query="GetSessions">
                <tr>
                    <td><a href="####" onClick="SetValue('UserName', '#username#'); SetValue('Password', ''); AjaxGetElementReference('Password').focus();">#username#</a></td>
                    <td>#DateFormat(login_date, "mm/dd/yyyy")# #TimeFormat(login_date, "h:mm tt")#</td>
                    <td>#DateFormat(logout_date, "mm/dd/yyyy")# #TimeFormat(logout_date, "h:mm tt")#</td>
                </tr>
                    
            
            </cfoutput>
            </table>
        </div><br>
        
        
        <cfinclude template="/Framework/CoreSystem/HTMLResources/LoginDialog.cfm">
	</div>
  
    <div id="LoginCommands" style="width:100%; text-align:center;" align="center">
    	<span id="LoaderPleaseWait" style="font-size:18px; font-weight:lighter; font-family:Tahoma, Geneva, sans-serif; color:#EFEFEF;">Please Wait...</span>
    	<input type="button" class="normalButton" id="BeginButton" value="Begin Prefiniti Session" style="display:none;" onclick="WMInitialize(); showDivBlock('Login_Box');">
    </div>
</div>

<div id="OfflineBrowser" style="display:none; position:fixed; left:0px; top:0px; z-index:25000; background-color:black; width:640px; height:400px; color:white; font-family:Verdana, Arial, Helvetica, sans-serif; padding:5px; -moz-border-radius:5px; border:1px solid white;">
	<table width="100%" class="olb">
		<tr>
			<td align="center"><img src="/homeres/Prefiniti-Logo-white.png"></td>
		</tr>
	</table>
	<table width="100%" class="olb">
		<tr>
			<td valign="bottom" width="4">		
				<img src="/graphics/pi.png">
			</td>
			<td valign="top">
				<div id="ibtw" style="height:350px; overflow:auto; width:100%;">
					<div style="padding:30px;" id="ibt">
					No content.
					</div>
				</div>
			</td>
		</tr>
	</table>
	<center>Copyright &copy; 2009, AJL Intel-Properties LLC</center>			
</div>




<div id="soundmanager-debug" style="display:none; position:absolute; left:0px; top:0px; z-index:50000; width:300px; height:auto;"></div>
<div id="dev-null" style="display:none"></div>

		
	
		

		
		
		<!---<!-- google maps crap -->
		<cfif cgi.HTTP_HOST EQ "www.webwarecl.com">
			<!--Google Maps API key for webwarecl.com-->
			<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BS9InrnI581krHDS1IjuwzeaQviEhQBz53weq4VDYr1p0Sz1v1fM1skIA"
			  type="text/javascript"></script>
		<cfelseif cgi.HTTP_HOST EQ "www.webwarecl.net">
			<!--Google Maps API key for webwarecl.net-->	
			<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BTjBSsxbgXyRVXCz3Y1iKPokBykHhQlDq4lMFFgzKoxkPrLb2CAxQNfDw"
			  type="text/javascript"></script>
		<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.com">
			<!--Google Maps API key for prefiniti.com-->
			<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BQSPiOpE8kHJZIw4xDccjP9KUdOfRTsJgLdrnSOHIxyCRSU6QBKZCQ1qQ"
			  type="text/javascript"></script>      
		<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.net">
			<!--Google Maps API key for prefiniti.net-->
			<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BRvWbUCKD0fBD63QbLGzCRB1qPvoxS-oPj5SWW_XVANygFvcFE0OmdFKg"
			  type="text/javascript"></script>
		<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.mobi">
			<!--Google Maps API key for prefiniti.mobi-->
			<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BQG9--bzDoENeb2oUAu-TVJT4rODxRlV0_TON-qVKMhrTAgqvlcDngVYA"
			  type="text/javascript"></script>            
		</cfif>--->
	


	<body style="background-color:#2957A2;" id="Sfff" onResize="handleAppResize();" onLoad="LoadHandler();">	
    	<div id="PGlobalScreen"></div>
		<script src="/framework/UI/wz_tooltip.js" type="text/javascript"></script>
		<script>
            <cfoutput query="GetBase">	
                <cfif IsStyle EQ 0>
                    
                        scripts.push('#ScriptPath#');
                    
                </cfif>
            </cfoutput>
        </script>
        <center>
        <div id="PrefinitiLogo" style="top:250px; position:absolute;" align="center">
            <img src="/graphics/prefinitispl.jpg"><br>
            <strong>Version 2.0<br>Release Candidate 1</strong><br>
            Copyright &copy; 2009, AJL Intel-Properties LLC<br>
            Patent Pending.
            <div id="PrefinitiLoading" align="center">
                <img src="/graphics/CoreLoading.gif" style="padding:40px;">
            </div>
            <div id="MyDesks">
            
            </div>
        </div>
        </center>

	</body>



