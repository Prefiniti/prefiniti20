<cfparam name="FileURL" default="">

<cfset FileURL = "http://" & Session.InstanceName & ".prefiniti.com" & URL.File>
<cfoutput>
<div class="__PREFINITI_DOCUMENT" style="padding:5px;">
	<div style="background-color:##EFEFEF; width:100%; border:1px solid ##C0C0C0;">
    	<div style="padding:10px;">
        <strong><img src="/graphics/folder_user.png" align="absmiddle"> Share a File</strong><br>
        <hr>
        <table width="100%" cellpadding="3">
    	<tr>
        	<td valign="top" style="background-color:transparent;"><strong>File</strong></td>
            <td valign="top" style="background-color:transparent;"><a href="#FileURL#" target="_blank">#URL.File#</a></td>
        </tr>
    	<tr>
        	<td valign="top" style="background-color:transparent;"><strong>Web Address</strong></td>
            <td valign="top" style="background-color:transparent;"><textarea cols="40" rows="4">#FileURL#</textarea></td>
		</tr>
	</table>  
    </div>      
    </div>
    
    
   
    <h3><img src="/graphics/pi-16x16.png" align="absmiddle"> Share with Friends &amp; Colleagues on Prefiniti</h3>
    
    Prefiniti User: <cfmodule template="/Framework/Controls/UserPicker.cfm" 
								CtlID="ShareTargetUser" 
								UserID="#URL.CalledByUser#" 
								MultiSelect="false" 
								BrowseOnly="false" 
								ButtonCaption="Choose User..." 
								ShowFriends="true"
								ShowCoworkers="true"
								ShowCustomers="true"
								ShowSearch="true"><br />

	<br>
    <table width="100%"><tr><td align="right">                                
	<input type="button" name="fumbacz" class="normalButton" value="Share With Selected User..." onclick="ShareWithPrefinitiUser('#URL.File#', GetValue('ShareTargetUser'));">
    </td></tr></table>    
    <hr>
    <h3><img src="/graphics/email.png" align="absmiddle"> Share by E-Mail</h3>
   	
    <span id="dest_status">
    <p>E-Mail Address: <input type="text" id="destination_email" name="destination_email"><br></p>
    <table width="100%"><tr><td align="right">
    <input type="button" class="normalButton" name="destm" value="Send E-Mail" onclick="ShareByEmail('#FileURL#', GetValue('destination_email'));"> 
    </td></tr></table>
    </span>    
    <hr>
    <h3><img src="/graphics/phone.png" align="absmiddle"> Share by Text Message</h3>
   	
    <span id="dest_status">
    <p>Mobile Number: <input type="text" id="mobile_number" name="mobile_number"></p>
    <p>Mobile Provider: <select name="CarrierSuffix" id="CarrierSuffix">
             
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
            </select></p>
    <table width="100%"><tr><td align="right">
    <input type="button" class="normalButton" name="destm" value="Send Text Message" onclick="ShareBySMS('#FileURL#', GetValue('mobile_number'));"> 
    </td></tr></table>
    </span>    
   
</div>
</cfoutput>