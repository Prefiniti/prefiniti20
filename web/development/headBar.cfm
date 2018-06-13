
<cfif #session.loggedin# EQ "yes">
<cfif NOT IsDefined("URL.FW15")>
<cfif NOT IsDefined("URL.steel")>
<div id="headBar"><table width="100%" cellspacing="0"><tr><th align="left" id="qs" style="background-image:url(/graphics/steel.png); background-attachment:fixed; background-repeat:repeat-x; text-shadow:white;">
<!---
<cfinclude template="/framework/components/quick_status/qs_connection.cfm">
<cfinclude template="/framework/components/quick_status/qs_gps.cfm">
--->
</th><th align="center" style="background-image:url(/graphics/steel.png); background-attachment:fixed; background-repeat:repeat-x; text-shadow:white;"><a href="##"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, appMenu, '150px')" onmouseout="delayhidemenu()">The Prefiniti Network</a></th></tr></table></div>
</cfif>
</cfif>
<cfelse><!---
<div style="padding-left:30px;">
<table width="800" cellpadding="0" cellspacing="0" style="border-bottom:1px solid #EFEFEF;">
	<tr>
    	<td align="left" width="40%" style="padding-top:30px;" valign="bottom">
			<a href="/default.cfm"><img id="plogo" src="graphics/prefiniti.png" style="vertical-align:middle; height:56px;" height="56" align="absmiddle" border="0"></a><br />
            Beta
        </td>
        <td align="right" width="60%" valign="bottom" style="vertical-align:bottom;">
        	<a href="http://www.prefiniti.com/prefiniti_framework_nocheck.cfm">About Us</a> | <a href="/business_register.cfm">Business Account Inquiry</a>
        </td> 
	</tr>
</table>
</div>--->
</cfif>
