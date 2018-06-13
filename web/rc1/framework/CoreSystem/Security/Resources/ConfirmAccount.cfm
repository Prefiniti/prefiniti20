<img src="/graphics/shield.png" align="absmiddle"/> <strong>Confirm Account</strong><br />
<hr />


<cfquery name="getAccountID" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE confirm_id='#url.cid#'
</cfquery>

<cfquery name="setAccountConfirmed" datasource="#session.DB_Core#">
	UPDATE Users
	SET		account_enabled=1,
			confirmed=1
	WHERE	id=#getAccountID.id#
</cfquery>

<cfoutput>
	<table width="100%" class="olb">
		<tr>
			<td align="left">
   
					<h3>Create Password</h3>
				
					<p>You must now set your password.</p>
          
			</td>
		</tr>
	</table>
	<table width="100%" class="olb">
		<tr>
			<td>Password:</td>
			<td><input type="password" name="password" id="password" /></td>
		</tr>
		<tr>
			<td>Re-Enter Password:</td>
			<td><input type="password" name="passwordConfirm" id="passwordConfirm" /></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="button" class="normalButton" name="submit" onClick="SetPassword(#getAccountID.id#, GetValue('password'), GetValue('passwordConfirm'));" value="Set Password" />
			</td>
		</tr>
	</table>
</cfoutput>