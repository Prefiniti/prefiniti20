<cfinclude template="/Framework/ServerInterface/ServerInterface_udf.cfm">

<cfparam name="ObjectTypeID" default="">
<cfparam name="SubmissionUUID" default="">
<cfparam name="FormMode" default="">

<cfset ObjectTypeID = URL.PAF_ObjectTypeID>
<cfset SubmissionUUID = URL.PAF_SubmissionUUID>
<cfset FormMode = URL.PAF_FormMode>

<cfparam name="CurID" default="">
<cfparam name="CurVal" default="">

<cfparam name="FieldData" default="">
<cfparam name="Fields" default="">
<cfparam name="FieldID" default="">
<cfparam name="FormSQL" default="">

<cfset Fields = ArrayNew(1)>
<cfset FieldData = StructNew()>
<cfparam name="NullVal" default="">

<cfloop index="CurField" list="#StructKeyList(url)#">
	<cfif Left(CurField, 12) EQ "PAFDynField_">
		<cfset CurID = "URL.#CurField#">
		<cfset CurVal = Evaluate("#CurID#")>
		<cfset FieldID = Mid(CurID, 17, Len(CurID))>
		
		<cfset FieldData = StructNew()>
		<cfset FieldData.FieldName = siFieldInfo(FieldID).FieldName>
		<cfset FieldData.FieldType = siFieldInfo(FieldID).FieldType>
		<cfset FieldData.FieldID = FieldID>
		<cfset FieldData.FieldValue = CurVal>
		<cfset FieldData.QuoteSQL = siFieldInfo(FieldID).QuoteSQL>
		<cfset NullVal = ArrayAppend(Fields, FieldData)>
	</cfif>
</cfloop>		

<cfparam name="ActionDesc" default="">

<cfswitch expression="#FormMode#">
<cfcase value="CREATE">
	<cfset ActionDesc = "New">
	<cfset FormSQL = pfBuildInsert(Fields, ObjectTypeID, SubmissionUUID)>
</cfcase>
</cfswitch>

<cfparam name="ObjectName" default="">
<cfset ObjectName = pfObjectInformation(ObjectTypeID).Description>


<cfoutput>
	<div style="width:465px; background-color:##EFEFEF; padding:8px; margin:5px; -moz-border-radius:5px;">
	<h3><img src="/graphics/pi-16x16.png" align="absmiddle"> #ActionDesc# #ObjectName#</h3>
	
	<div style="border:none; padding:5px; background-color:white; height:150px; width:450px; overflow:auto; margin-bottom:10px;">
	<table width="100%" cellpadding="0" cellspacing="0">
	<cfloop from="1" to="#ArrayLen(Fields)#" index="f">
		<tr>
			<td style="border-bottom:1px solid ##EFEFEF; padding:3px;"><strong>#Fields[f].FieldName#:</strong></td>
			<td style="border-bottom:1px solid ##EFEFEF; padding:3px;">#Fields[f].FieldValue#</td>
		</tr>			
	</cfloop>
	</table>
	</div>
	
	<table width="100%" cellspacing="0">
		<tr>
		<td valign="top" style="background-color:##EFEFEF;">
			<label><strong>Choose a folder:</strong>
			<cfmodule template="/framework/coresystem/htmlresources/choosefolder.cfm" UserID="#url.calledbyuser#" ControlID="ChooseFolder"></label>
		</td>
		<td valign="top" align="right" style="background-color:##EFEFEF;">		
			<label><input type="checkbox"> Save this item as a template</label>
			
		</td>
		</tr>
	</table>					
	</div>
	
</cfoutput>	

<a href="##" <cfoutput>onclick="showDivBlock('ODebug_#SubmissionUUID#');"</cfoutput>>Show debugging information</a>

<div <cfoutput>id="ODebug_#SubmissionUUID#"</cfoutput> style="border:1px solid black; padding:5px; display:none;">
	<strong><img src="/graphics/pi-16x16.png" align="absmiddle"> Prefiniti Application Framework Debugging Information</strong>
	<br><br>
	<cfoutput>
	<strong>Form Mode:</strong> #FormMode#<br />
	<strong>Submission UUID:</strong> #SubmissionUUID#<br />
	<strong>Object Type ID:</strong> #ObjectTypeID#<br />
	
	
	<div style="border:1px solid black; padding:5px; margin:5px;">
		<strong>Generated SQL:</strong><br><br>
		<p style="font-family:'Courier New', Courier, monospace; font-size:small;">#FormSQL#</p>
	</div>
	</cfoutput>
		
</div>

	