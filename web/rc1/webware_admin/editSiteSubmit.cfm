<cfquery name="updateSite" datasource="#session.DB_Sites#">
	UPDATE sites
    SET		SiteName='#form.SiteName#',
    		admin_id=#form.admin_id#,
            enabled=#form.enabled#
	WHERE	SiteID=#form.SiteID#
</cfquery>




<cflocation url="/webware_admin/manageSites.cfm" addtoken="no">
