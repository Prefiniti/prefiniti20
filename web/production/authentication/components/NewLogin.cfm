<style type="text/css">
	.loginTable {
	font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif;
	font-size: x-small;
	
	margin:0px;
	padding:0px;
	}
	
	.loginTable td {
	padding-left: 5px;	
	padding-right: 5px;
	padding-bottom: 5px;
	padding-top:5px;
	}
	
</style>

<cfquery name="ll" datasource="#session.DB_Core#">
	SELECT id FROM Users WHERE online=1
</cfquery>

<cfquery name="uc" datasource="#session.DB_Core#">
	SELECT count(id) AS ct FROM Users WHERE confirmed=1
</cfquery>

<cfquery name="SiteInfo" datasource="#session.DB_Sites#">
	SELECT * FROM Sites WHERE SiteID='#attributes.siteid#'
</cfquery>

<cfquery name="getStatus" datasource="#session.DB_Core#">
	SELECT * FROM config
</cfquery>

<cfif not IsDefined("cookie.wwcl_rememberMe")>
	<cfcookie name="wwcl_rememberMe" value="false">
</cfif>

<cfoutput>
	<cfform name="login" action="/login-submit.cfm">
		<cfif IsDefined("url.redir")>
			<input type="hidden" name="doRedirect" value="true" />
			<input type="hidden" name="redir" value="#url.redir#" />
		<cfelse>
		  	<input type="hidden" name="doRedirect" value="false" />
		</cfif>
		<input type="hidden" name="siteid" value="#attributes.siteid#">
	    <table class="loginTable" width="400" cellpadding="0" cellspacing="0" border="0" style="margin-top:120px;">
            <tr>
            	<td colspan="3">
                	<strong>#ll.RecordCount# of #uc.ct# users online now</strong><br />
					
				</td>
			</tr>                                    
          <!---<tr>
            <td>Site:</td>
			<td colspan="2" style="color:blue;">#SiteInfo.SiteName#</td>
		  </tr>
		  <tr>
		  	<td>Site Status:</td>
			<td colspan="2">
				<cfswitch expression="#getStatus.maintenance#">
					<cfcase value="0">
						<font color="green">Normal<br /></font>
					</cfcase>
					<cfcase value="1">
						<font color="red">Undergoing maintenance<br /></font>
					</cfcase>
				</cfswitch>
				
				<cfswitch expression="#getStatus.logins_disabled#">
					<cfcase value="0">
						<font color="green">Sign-in enabled</font>
					</cfcase>
					<cfcase value="1">
						<font color="red">Sign-in disabled</font>
					</cfcase>
				</cfswitch>
				
			</td>
		   </tr>
		   --->

		  <tr>
		  	<td align="left">&nbsp;</td>
			<td align="right">
				<cfif Attributes.browserType NEQ "Microsoft Internet Explorer">
						<img src="/graphics/new.png" align="absmiddle" /> 
						<a href="http://www.prefiniti.com/Framework/CoreSystem/Run.cfm" target="_blank">
							Try Prefiniti 2.0 Beta
						</a>
				</cfif>
			</td>
		  </tr>
          <tr>
            <td>Username:</td>
            <td colspan="2" align="right"><input type="text" name="UserName" <cfif #cookie.wwcl_rememberMe# EQ "true">value="#cookie.wwcl_username#"</cfif>></td>
          </tr>
          <tr>
            <td>Password:</td>
            <td colspan="2" align="right"><input type="password" name="Password" <cfif #cookie.wwcl_rememberMe# EQ "true">value="#cookie.wwcl_password#"</cfif>><br /><input type="checkbox" name="rememberMe" <cfif #cookie.wwcl_rememberMe# EQ "true">checked</cfif>/>Remember me</td>
          </tr>
          <tr>
		  	<!---<td style="font-size:xx-small">No account? <a href="/appBase.cfm?contentBar=/authentication/components/register.cfm">Register.</a></td>--->
            
            <td align="right" colspan="3" style="padding:0px;">
            	<input type="button" onclick="javascript:location.replace('/appBase.cfm?contentBar=/authentication/components/register.cfm');" value="Sign Up for Prefiniti" class="normalButton" />
                <input type="submit" class="normalButton" name="Submit" value="Log In" style="font-weight:bold;" /></td>
          </tr>
        </table>
	</cfform>
</cfoutput>