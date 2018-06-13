
	<table width="100%" cellpadding="0" cellspacing="0">
    	<tr>
       		<td style="background-color:black; color:white;">Username:</td>
            <td style="background-color:black; color:white;">
            	<input type="text" name="UserName" id="UserName">
			</td>
        </tr>
        <tr>
        	<td style="background-color:black; color:white;">Password:</td>
            <td style="background-color:black; color:white;">
            	<input type="password" name="Password" id="Password">
			</td>
		</tr>
        <tr>
			<td style="background-color:black; color:white;">
				<div id="LoginError" style="padding:10px; color:red; font-weight:bold; background-color:black;">
	</div>
			</td>
        	<td align="right" style="background-color:black; color:white;">                            
    			<input type="button" class="normalButton" value="Log In" onclick="PAuthenticate(GetValue('UserName'), GetValue('Password'));"> <input type="button" class="normalButton" value="Sign Up" onclick="OB('/Framework/CoreSystem/HTMLResources/RegisterAccount.cfm');"/> <input type="button" class="normalButton" value="Reload Prefiniti" onclick="location.reload(true);" />
				
			</td>
		</tr>
	</table>
