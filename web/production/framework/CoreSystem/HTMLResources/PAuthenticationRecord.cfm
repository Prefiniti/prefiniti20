<!--
	URL Parameters:
    	Username
        Password
-->

<cfquery name="qryGetLogin" datasource="#session.DB_Core#">
    SELECT * FROM Users WHERE username='#URL.Username#' AND password='#Hash(URL.Password)#'
</cfquery>

<cfparam name="LoginOK" default="">
<cfset LoginOK = false>

<cfparam name="FailureReason" default="">


<cfif #qryGetLogin.RecordCount# GT 0>

    <cfif #qryGetLogin.account_enabled# EQ 1>
        
        <!---login success--->
        
        <cfquery name="setOnline" datasource="#session.DB_Core#">
            UPDATE Users SET online=1, last_login=#CreateODBCDateTime(Now())# WHERE id=#qryGetLogin.id#
        </cfquery>

        <cfquery name="getLastSite" datasource="#session.DB_Core#">
            SELECT last_site_id FROM users WHERE id=#qryGetLogin.id# 
        </cfquery> 
        
        <cfquery name="getSites" datasource="#session.DB_Sites#">
            SELECT * FROM site_associations WHERE id=#getLastSite.last_site_id#
        </cfquery> 
		
                                
        <!---<cfset session.usertype=#getSites.assoc_type#>
        <cfset session.current_association=#getSites.id#>
        <cfset session.current_site_id=#getSites.site_id#>--->
        
        <cfset LoginOK = true> 
    <cfelse>
        <!--- Account Disabled --->
        <cfset LoginOK = false>
        <cfset FailureReason = "E_ACCOUNTDISABLED">
        
    </cfif>

<cfelse>
    <!---login failure--->
    <cfset LoginOK = false>
    <cfset FailureReason = "E_BADCREDENTIALS">
</cfif> 


<!-- build the XML authentication record -->
<cfoutput>
<?xml version="1.0" encoding="UTF-8"?>
<authentication>
    <result>
        <success>#LoginOK#</success>
        <failurereason>#FailureReason#</failurereason>
    </result>
</cfoutput>
	<cfif LoginOK EQ true>    
    <cfoutput query="qryGetLogin">
    <record>
  		<userid>#id#</userid>
        <username>#username#</username>
        <siteid>#getSites.site_id#</siteid>
        <associationid>#getSites.id#</associationid>
        <desktoptheme>crystal_project</desktoptheme>
    </record>    
    </cfoutput>
    </cfif>
</authentication>
<!--UserID, Username, SiteID, AssociationID, DesktopTheme-->