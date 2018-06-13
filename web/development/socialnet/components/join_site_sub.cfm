<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/notifications/notification_udf.cfm">

<cfquery name="check_existing" datasource="#session.DB_Sites#">
	SELECT * FROM site_associations
    WHERE	user_id=#url.user_id#
    AND		site_id=#url.site_id#
</cfquery>

<cfparam name="guid" default="">
<cfparam name="created_id" default="">

<cfset guid=CreateUUID()>

<cfif check_existing.RecordCount EQ 0>
	<cfquery name="join_site" datasource="#session.DB_Sites#">
		INSERT INTO site_associations
        	(user_id,
            site_id,
            assoc_type,
            conf_id)
		VALUES
        	(#url.user_id#,
            #url.site_id#,
            0,
            '#guid#')
	</cfquery>
    
    <cfquery name="get_new_association" datasource="#session.DB_Sites#">
    	SELECT * FROM site_associations
        WHERE	conf_id='#guid#'
    </cfquery>
    
    <cfset created_id=#get_new_association.id#>
    
    <cfoutput>
        <!-- set default permissions -->
        #grantPermission("AS_LOGIN", created_id)#
        #grantPermission("WF_CREATE", created_id)#
        #grantPermission("WF_VIEWRFP", created_id)#
        #grantPermission("WF_SEARCH", created_id)#
        #grantPermission("WF_VIEW", created_id)#
    </cfoutput>
    
    <!---
		TODO:  Create subroutine to establish a default set of notifications
	--->
</cfif>    
<cfoutput><strong>You are now a member of this site.</strong></cfoutput>