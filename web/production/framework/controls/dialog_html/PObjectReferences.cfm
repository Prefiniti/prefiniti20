<cfinclude template="/framework/framework_udf.cfm">
<cftry>
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfcatch type="any">

</cfcatch>
</cftry>
<cfparam name="obr" default="">
<cfset obr = pfGetObjectReferences(Attributes.ObjectTypeID, Attributes.ObjectID)>
<table class="ModTable" cellspacing="0" cellpadding="3" width="100%">
	<tr>
		<th>User</th>
    	<th>Reference Path</th>
	</tr>
    <cfoutput query="obr">
    <tr>
    	<td>#getLongname(UserID)#</td>
        <td>#pfFolderPathPlain(ContainingFolder)#</td>
	</tr>
    </cfoutput>
</table>                 
    