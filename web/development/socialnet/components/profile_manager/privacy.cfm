<cfinclude template="/authentication/authentication_udf.cfm">

<div class="homeHeader"><img src="/graphics/lock.png" align="absmiddle" /> Privacy Settings</div>

<cfparam name="u" default="">
<cfset u=getUserInformation(#attributes.user_id#)>

<cfoutput>
<div style="padding-left:20px;">
	<form name="updatePrivacy" id="updatePrivacy">
	<input type="hidden" name="user_id" id="user_id" value="#attributes.user_id#" />
    <table width="100%">
    	<tr>
        	<td>Profile Search:</td>
    		<td><label><input type="checkbox" id="allowSearch" name="allowSearch"value="1" <cfif #u.allowSearch# EQ 1>checked</cfif>>Allow users to search for me</label></td>
        </tr>
        <tr>
        	<td>&nbsp;</td>
            <td><a href="javascript:AjaxLoadPageToDiv('tcTarget', '/authentication/components/changePassword.cfm?id=#url.calledByUser#');">Change my password</a>
            </td>
        </tr>
        <tr>
        	<td>Password Question:</td>
            <td>
            	<select name="password_question" id="password_question">
                	<option value="What city were you born in?" <cfif u.password_question EQ "What city were you born in?">selected</cfif>>What city were you born in?</option>
                    <option value="What is your mother's maiden name?" <cfif u.password_question EQ "What is your mother's maiden name?">selected</cfif>>What is your mother's maiden name?</option>
                    <option value="What is your favorite pet's name?" <cfif u.password_question EQ "What is your favorite pet's name?">selected</cfif>>What is your favorite pet's name?</option>
				</select>
			</td>
		</tr>
        <tr>
        	<td>Password Answer:</td>
            <td><textarea name="password_answer" id="password_answer">#u.password_answer#</textarea></td>
		</tr>                                                            
                    
        <tr>
        	<td colspan="2" align="left"><input type="button" class="normalButton" name="submit" value="Save Changes" onclick="AjaxSubmitForm(AjaxGetElementReference('updatePrivacy'), '/socialnet/components/profile_manager/privacy_sub.cfm', 'userActionTarget');" /></td>
    </table>
    </form>
</div>
</cfoutput>