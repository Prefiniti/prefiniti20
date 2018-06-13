<cfinclude template="/authentication/authentication_udf.cfm">

<div class="homeHeader"><img src="/graphics/phone.png" align="absmiddle" /> Contact Information</div>
<cfparam name="u" default="">
<cfset u=getUserInformation(#URL.calledbyuser#)>



<div style="padding-left:20px;">
	<cfoutput query="u">
		<form name="updateContact" id="updateContact">
		<input type="hidden" name="user_id" id="user_id" value="#url.calledbyuser#" />
        <table width="100%">
        	<tr>
            	<td>Primary Phone Number:</td>
                <td><input type="text" maxlength="45" name="phone" id="phone" value="#phone#" /></td>
			</tr>
            <tr>
            	<td>Mobile Phone Number:</td>
                <td><cfoutput><input type="text" name="smsNumber" id="smsNumber" value="#smsNumber#"><!---<input type="button" class="normalButton" value="Configure my account for Text Messaging" onclick="confirmSMS(#url.calledbyuser#, GetValue('smsNumber'));" />---></cfoutput>
                
                
                	<select name="CarrierSuffix" id="CarrierSuffix">
						<option value="@message.alltel.com">Alltel</option>
						<option value="@clearpath.acswireless.com">Ameritech</option>
						<option value="@txt.att.net">AT&amp;T Wireless</option>
						<option value="@bellsouth.cl">BellSouth</option>
						<option value="@myboostmobile.com">Boost Mobile</option>
						<option value="@mobile.celloneusa.com">CellularOne</option>
						<option value="@sms.edgewireless.com">Edge Wireless</option>
						<option value="@messaging.sprintpcs.com">Sprint PCS</option>
						<option value="@tmomail.net">T-Mobile</option>
						<option value="@mymetropcs.com">Metro PCS</option>
						<option value="@messaging.nextel.com">Nextel</option>
						<option value="@mobile.celloneusa.com">O2</option>
						<option value="@mobile.celloneusa.com">Orange</option>
						<option value="@qwestmp.com">Qwest</option>
						<option value="@email.uscc.net">US Cellular</option>
						<option value="@vtext.com">Verizon Wireless</option>
						<option value="@vmobl.com">Virgin Mobile</option>
						<option value="@mms.mycricket.com">Cricket</option>
                    </select>
                
                
                </td>
                
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