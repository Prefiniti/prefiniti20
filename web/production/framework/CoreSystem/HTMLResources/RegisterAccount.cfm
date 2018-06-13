<img src="/graphics/user_add.png" align="absmiddle"/> <strong>Sign Up for Prefiniti</strong><br />
<hr />
<p>Prefiniti accounts are always free! Sign up today and begin ordering products and services from local businesses and socializing with your friends online.</p>

<p>All fields below are required.</p>

<!---
	<cfargument name="Username" type="string" required="yes">
	<cfargument name="FirstName" type="string" required="yes">
	<cfargument name="MiddleInitial" type="string" required="yes">
	<cfargument name="LastName" type="string" required="yes">
	<cfargument name="EMail" type="string" required="yes">
	<cfargument name="ZIP" type="string" required="yes">
	<cfargument name="ReferralCode" type="string" required="yes">
	<cfargument name="Gender" type="string" required="yes">
	<cfargument name="Birthday" type="string" required="yes">
	<cfargument name="PAFFLAGS" type="numeric" required="yes">
	<cfargument name="AllowSearch" type="numeric" required="yes">
	<cfargument name="PrefinitiAdministrator" type="numeric" required="yes">
	<cfargument name="PrimarySite" type="numeric" required="yes">
	<cfargument name="PrimarySiteAdministrator" type="numeric" required="yes">
	<cfargument name="PrimarySiteAssociationType" type="numeric" required="yes">
--->

<form name="RegisterAccount" id="RegisterAccount">
<table width="100%" class="orb" cellspacing="0">
	<tr>
		<td valign="top"><strong>Username</strong><br /><br />
			<p>This is the username you will use to connect to Prefiniti. It cannot be changed once your account is created.</p><br />
		</td>
		<td valign="top">
			<input type="text" name="Username" id="Username"/>
		</td>
	</tr>
	<tr>
		<td valign="top"><strong>First Name</strong><br />
		</td>
		<td valign="top">
			<input type="text" name="FirstName" id="FirstName"/>
		</td>
	</tr>
	<tr>
		<td>
		</td>
		<td>
			<input type="hidden" name="MiddleInitial" id="MiddleInitial" value=""/>
		</td>
	</tr>
	<tr>
		<td valign="top"><strong>Last Name</strong><br />
		</td>
		<td valign="top">
			<input type="text" name="LastName" id="LastName"/>
		</td>
	</tr>
	<tr>
		<td valign="top"><strong>Sex</strong><br></td>
		<td valign="top">
			<select name="Gender" id="Gender">
				<option value="M">Male</option>
				<option value="F">Female</option>
			</select>
		</td>
	</tr>
	<tr>
		<td valign="top"><strong>Birthday</strong><br></td>
		<td valign="top"><cfmodule template="/controls/date_picker.cfm" ctlname="Birthday" startdate="#Now()#"></td>
	</tr>
	<tr>
		<td valign="top"><strong>E-Mail Address</strong><br /><br />
		<p>A valid e-mail account is required to access the Prefiniti network.</p><br />
		</td>
		<td valign="top">
			<input type="text" name="EMail" id="EMail"/>
		</td>
	</tr>
    <tr>
    	<td valign="top"><strong>Mobile Phone Number</strong><br /></td>
        <td valign="top">
        	<input type="text" name="Phone" id="Phone" />
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
            <p style="color:red; font-size:xx-small;"><strong>ATTENTION:</strong> Prefiniti and its clients will <strong style="text-transform:uppercase;">not</strong> charge you for text messaging services. However, standard carrier charges may apply.</p>
            
           
        	
        </td>
	</tr>
	<tr>
		<td valign="top"><strong>ZIP Code</strong><br /><br />
		<p>Your ZIP code is used to place you in a Prefiniti Region. It will not be visible to anyone else unless you choose to display it.</p><br />
		</td>
		<td valign="top">
			<input type="text" name="ZIP" id="ZIP"/>
		</td>
	</tr>
            
	
	<tr>
		<td colspan="2" style="border:none;"><strong>Privacy</strong><br><br>
		<blockquote>
		<label><input type="checkbox" name="AllowSearch"> Allow other Prefiniti users to search for me</label>
		</blockquote>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right" style="border:none;">
			<input type="button" onclick="AjaxSubmitForm(AjaxGetElementReference('RegisterAccount'), '/Framework/CoreSystem/HTMLResources/RegisterAccountSubmit.cfm', 'ibt');" class="normalButton" value="Create Account">
		</td>
	</tr>

		
	
			
</table>
</form>