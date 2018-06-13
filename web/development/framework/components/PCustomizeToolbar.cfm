<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="ButtonType" default="">
<cfset ButtonType = wwReadConfig(url.calledByUser, "PF_TOOLBAR_STYLE")>

<cfquery name="getToolbars" datasource="#session.DB_Core#">
	SELECT * FROM toolbars
</cfquery>

<div style="width:330px; margin:20px; padding-left:30px; padding-top:10px; border:1px solid #EFEFEF; height:100px; overflow:auto;">
	<h3>Show toolbar buttons as:</h3>
	
	<label><input name="ButtonType" type="radio" value="IconsAndText" onclick="SetDisplayType(AjaxGetCheckedValue('ButtonType'));"  <cfif ButtonType EQ "IconsAndText" OR ButtonType EQ "WW_NOT_CONFIGURED">checked</cfif>> Icons &amp; Text</label>
	<label><input name="ButtonType" type="radio" value="IconsOnly" onclick="SetDisplayType(AjaxGetCheckedValue('ButtonType'));" <cfif ButtonType EQ "IconsOnly">checked</cfif>> Icons Only</label>
	 
</div>
<div style="width:360px; margin:20px; padding:0px; border:1px solid #EFEFEF; height:300px; overflow:auto;">
<table width="100%" class="PList" cellpadding="5">
<cfoutput query="getToolbars">
	<tr>
		<td width="50%" valign="bottom" align="left">
			<div class="LargeButton" style="background-color:white;"><img src="#icon#" align="absmiddle"> #toolbar_name#</div><br>
		</td>
		<td width="50%" valign="bottom" align="left"><cfmodule template="/framework/components/toolbar_shown_check.cfm" toolbar_id="#id#" user_id="#url.calledByUser#"></td>
	</tr>
</cfoutput>
</table>
</div>