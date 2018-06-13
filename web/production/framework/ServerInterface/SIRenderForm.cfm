
<cfquery name="FormInfo" datasource="#session.DB_Core#">
	SELECT * FROM Forms WHERE id=#URL.FormID#
</cfquery>

<cfquery name="FormFields" datasource="#session.DB_Core#">
	SELECT * FROM form_fields WHERE FormID=#URL.FormID#	
</cfquery>



<cfoutput>
<!--
	<wwafcomponent>#FormInfo.FormDescription#</wwafcomponent>
-->
</cfoutput>	

<cfoutput><h1>#FormInfo.FormDescription#</h1></cfoutput>


<form <cfoutput>name="#FormInfo.FormName#" id="#FormInfo.FormName#" </cfoutput>>
	
	<cfoutput>
		<input type="hidden" name="PAF_ObjectTypeID" id="PAF_ObjectTypeID" value="#FormInfo.ObjectTypeID#" />
		<input type="hidden" name="PAF_FormMode" id="PAF_FormMode" value="#FormInfo.ActionType#" />
		<input type="hidden" name="PAF_SubmissionUUID" id="PAF_SubmissionUUID" value="#CreateUUID()#" />
	</cfoutput>

<table width="100%" cellpadding="3">
	<cfoutput query="FormFields">
		<tr>
			<td><strong>#Label#:</strong></td>
			<td><cfmodule template="/Framework/ServerInterface/SIGetField.cfm" id="#ObjectFieldID#" pafdebug="true" FormMode="#FormInfo.ActionType#"></td>
		</tr>
	</cfoutput>
	<tr>
		<td colspan="2" align="right">
			<cfoutput>
				<input type="button" 
				class="normalButton" 
				value="Submit" 
				onclick="AjaxSubmitForm(AjaxGetElementReference('#FormInfo.FormName#'), '/Framework/ServerInterface/SISubmitForm.cfm', 'tcTarget');" />
			</cfoutput>
		</td>
	</tr>					
</table>		

</form>				