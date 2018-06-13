<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/Framework/CoreSystem/Widgets/Thumbnails/Thumbnails_udf.cfm">

<cfquery name="MProf" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE id=#attributes.user_id#
</cfquery>

<cfoutput>
<br />
<br />
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td width="180">
		<div style="padding:10px;">
        <cfif MProf.webware_admin EQ 1>
        	<img src="#Thumb(getPicture(attributes.user_id), 180, 200, '/graphics/eye.png')#">
		<cfelse>
        	<img src="#Thumb(getPicture(attributes.user_id), 180, 200)#">
		</cfif>
        
        
        </div>
	</td>
    <td>
    	<h1 class="stdHeader">#getLongname(attributes.user_id)#</h1>
        
		<div style="width:90%; padding:5px; background-color:##EFEFEF; -moz-border-radius:5px; font-size:xx-small;" class="GrayTable">
			<table width="100%" cellpadding="0" cellspacing="0" class="GrayTable">
			<tr>
				<td style="font-size:xx-small;">My Status:</td>
				<td style="font-size:xx-small;" align="right"><input type="text" value="#MProf.status#" width="80" size="50" id="NewStatus" maxlength="255" /></td>
			</tr>
			<tr>
				<td style="font-size:xx-small;">My Location:</td>
				<td style="font-size:xx-small;" align="right"><input type="text" value="#MProf.location#" width="80" size="50" id="NewLocation" maxlength="255" /></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><input type="button" class="normalButton" value="Update Status &amp; Location" onclick="UpdateStatusAndLocation();" /></td>
			</tr>				
			</table>				
		</div>
		
        <div id="MiniProfileNews" style="font-size:xx-small;">
			<cfmodule template="/socialnet/components/view_user_events.cfm" user_id="#attributes.user_id#" start_row="1" records_per_page="4" load_to="MiniProfileNews" supress_scroller="true" font_size="xx-small">
        </div>
    </td>
</tr>
</table>
</cfoutput>