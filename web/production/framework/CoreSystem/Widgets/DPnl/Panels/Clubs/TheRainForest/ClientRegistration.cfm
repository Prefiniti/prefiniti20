<div class="__PREFINITI_DOCUMENT">
<h1 class="stdHeader"><img src="/graphics/pi.png" align="absmiddle" /> Invite Users</h1>
<em>The Rain Forest</em><br /><br />
<form>
<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
    	<td>
        	<strong>Phone Number:</strong>
        </td>
		<td>
        	<input type="text" id="PhoneNumber" />
        </td>
	</tr>
     <tr>
    	<td valign="top"><strong>Mobile Provider</strong></td>
        <td valign="top">
        <select name="CarrierSuffix" id="CarrierSuffix">
              <option value="@NO_PROVIDER.BAD">Not Yet Known</option>
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
    	<td>
        	<strong>E-Mail Address:</strong>
        </td>
        <td>
        	<input type="text" id="EMailAddress" />
		</td>          
	</tr>  
       
                     
    <tr>
    	<td colspan="2" align="right">
        	<input type="button" class="normalButton" value="Add User" onclick="RFAddUserSubmit(GetValue('PhoneNumber'), GetValue('CarrierSuffix'), GetValue('EMailAddress'));" />
        </td>
    </tr>
</table>
</form>            