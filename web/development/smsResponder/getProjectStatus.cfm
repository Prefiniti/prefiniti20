<cfquery name="getFromAddress" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE smsnumber='#attributes.from#'
</cfquery>

<cfparam name="cid" default="">

<cfif #UCase(Left(attributes.project, 4))# EQ "CONF">
	<cfset cid="#Mid(attributes.project, 6, 6)#">
	
	<cfquery name="getConf" datasource="#session.DB_Core#">
		SELECT * FROM Users WHERE sms_conf='#UCase(cid)#'
	</cfquery>
	
	<cfquery name="udSMS" datasource="#session.DB_Core#">
		UPDATE Users SET smsnumber='#attributes.from#' WHERE id=#getConf.id#
	</cfquery>
	
	<cfoutput><cfmail from="sms@prefiniti.com" to="#attributes.from#" subject="Prefiniti Text Messaging Setup">Congratulations, #getConf.longName#! Your Prefiniti account is now set up to receive SMS notifications.</cfmail></cfoutput>
	
<cfelseif #ucase(attributes.project)# EQ "LIST">
	<cfmodule template="/smsResponder/getProjectListy.cfm" id="#getFromAddress.id#" from="#attributes.from#" longName="#getFromAddress.longName#" type="#getFromAddress.type#">
<cfelse>
	
	<cfquery name="gP" datasource="#session.DB_Core#">
		SELECT * FROM projects WHERE clsJobNumber='#attributes.project#' AND clientID='#getFromAddress.id#'
	</cfquery>
	
	
	
	<cfif #gP.RecordCount# EQ 0>
		<cfoutput>
		<cfmail to="#attributes.from#" from="sms@prefiniti.com" subject="Prefiniti SMS - #getFromAddress.longName#">No such project</cfmail>
		</cfoutput>
	<cfelse>
		<cfoutput>
		<cfmail to="#attributes.from#" from="sms@prefiniti.com" subject="Prefiniti SMS - #getFromAddress.longName#">#Chr(13)##Chr(10)##Chr(13)##Chr(10)#Project #attributes.project#:#Chr(13)##Chr(10)#
			<cfif #gP.status# EQ 0>Incomplete<cfelse>Complete</cfif> [#gP.SubStatus#]#Chr(13)##Chr(10)#Due Date: #DateFormat(gP.duedate, "mm/dd/yyyy")##Chr(13)##Chr(10)##gP.address##Chr(13)##Chr(10)##gP.city#, #gP.state# #gP.zip#
		</cfmail>
		</cfoutput>
	</cfif>
</cfif>