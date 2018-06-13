<cfquery name="cn" datasource="#session.DB_Core#">
	SELECT company FROM Users WHERE id=#attributes.id#
</cfquery>

<cfmodule template="/jobViews/components/companyByCompanyIDMenu.cfm" id="#cn.company#">