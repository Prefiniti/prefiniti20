<cfparam name="cJob" default="1">

	<cfquery name="gProjectsList" datasource="#session.DB_Core#">
		SELECT * FROM projects WHERE <cfif #attributes.type# EQ 0>clientID='#attributes.id#' AND<cfelse>DATE_SUB(CURDATE(), INTERVAL 7 DAY) < dueDate AND</cfif> status=0 AND clsJobNumber!='' ORDER BY duedate
	</cfquery>
	
	<cfmail to="#attributes.from#" from="sms@prefiniti.com" subject="Prefiniti SMS">
		#Chr(13)##Chr(10)#<cfif #attributes.type# EQ 0>Projects for #attributes.longName#<cfelse>Priority Projects</cfif>#Chr(13)##Chr(10)##Chr(13)##Chr(10)#
		<cfloop query="gProjectsList">
			<cfif #clsJobNumber# NEQ "">#clsJobNumber# <cfif #attributes.type# EQ 1><cfmodule template="/jobViews/components/custNameByID.cfm" id="#clientID#"></cfif>#Chr(13)##Chr(10)#</cfif>
			<cfset cJob=#cJob#+1>
		</cfloop>	
		<cfif #attributes.type# EQ 0>#Chr(13)##Chr(10)##Chr(13)##Chr(10)#Reply with project no. for detailed status</cfif>
	</cfmail>