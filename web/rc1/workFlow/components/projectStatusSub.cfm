<cfquery name="setProjectStatus" datasource="#session.DB_Core#">
	UPDATE projects
	SET		status=#url.status#,
			SubStatus='#url.SubStatus#'
	WHERE	id=#url.id#
</cfquery>

<cfquery name="p" datasource="#session.DB_Core#">
	SELECT clientID, clientJobNumber, status, subStatus, clsJobNumber, description FROM projects WHERE id=#url.id#
</cfquery>

<cfmodule template="/workFlow/components/projectStatusNotify.cfm" id="#url.id#" clientID="#p.clientID#" clientJobNumber="#p.clientJobNumber#" status="#p.status#" subStatus="#p.subStatus#" clsJobNumber="#p.clsJobNumber#" description="#p.description#">

