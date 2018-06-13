<cfinclude template="/authentication/authentication_udf.cfm">

<div class="homeHeader"><img src="/graphics/phone.png" align="absmiddle" /> Contact Information</div>
<cfparam name="u" default="">
<cfset u=getUserInformation(#attributes.user_id#)>



<div style="padding-left:20px;">
	<cfoutput query="u">
		<form name="updateContact" id="updateContact">
		<input type="hidden" name="user_id" id="user_id" value="#attributes.user_id#" />
        <table width="100%">
        	<tr>
            	<td>Primary Phone Number:</td>
                <td><input type="text" maxlength="45" name="phone" id="phone" value="#phone#" /></td>
			</tr>
            <tr>
            	<td>Mobile Phone Number:</td>
                <td><cfoutput><input type="text" name="smsNumber" id="smsNumber" value="#smsNumber#"><input type="button" class="normalButton" value="Configure my account for Text Messaging" onclick="confirmSMS(#attributes.user_id#, GetValue('smsNumber'));" /></cfoutput></td>
			</tr>               
            <tr>
            	<td>Fax Number:</td>
                <td><input type="text" name="fax" value="#fax#" id="fax" /></td>
            </tr>
            <tr>
            	<td>E-Mail Address:</td>
                <td><input type="text" name="email" id="email" value="#email#" /></td>
            </tr>
            <tr>
                <td colspan="2" align="left">
                    <input type="button" class="normalButton" name="submit" value="Save Changes" onclick="AjaxSubmitForm(AjaxGetElementReference('updateContact'), '/socialnet/components/profile_manager/contact_info_sub.cfm', 'userActionTarget');" />
                </td>
			</tr>
        </table>
	</cfoutput>
</div>

<div id="smsConfTarget">

</div>