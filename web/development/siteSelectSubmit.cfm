<cfquery name="getSites" datasource="#session.DB_Sites#">
	SELECT * FROM site_associations WHERE id=#form.siteAssociation#
</cfquery>

<cfquery name="updateLastSite" datasource="#session.DB_Core#">
	UPDATE users SET last_site_id=#form.siteAssociation# WHERE id=#session.userid# 
</cfquery>    

<cfset session.usertype=#getSites.assoc_type#>
<cfset session.current_association=#getSites.id#>
<cfset session.current_site_id=#getSites.site_id#>

<cfif getPermissionByKey("AS_LOGIN", #session.current_association#) EQ false>
	<center>
    <div style="margin:30px; padding:30px; width:300px; border:1px solid #EFEFEF;" align="center">
        <img src="/graphics/webware.png" style="padding-bottom:20px;">
        <h3 class="stdHeader">Permission Denied</h3>
        
        <p>You do not have the <strong>AS_LOGIN</strong> permission on this site.</p>
    </div>
    </center>
    <cfabort>
</cfif>
    
<cfquery name="getASite" datasource="#session.DB_Sites#">
	SELECT * FROM sites WHERE SiteID=#session.current_site_id# 
</cfquery>    

<cfquery name="getFWB" datasource="#session.DB_Core#">
	SELECT framework_base FROM Users WHERE id=#session.userid# 
</cfquery>


<cfif #getASite.enabled# EQ 1>
	<cflocation url="#getFWB.framework_base#" addtoken="no">
<cfelse>
	<center>
    <div align="center" style="margin:30px; padding:30px; width:300px; border:1px solid #EFEFEF;">
		<img src="/graphics/webware.png" style="padding-bottom:20px;"/>
		<h3 class="stdHeader">Site Disabled</h3>
        
        <p>Logins to this site have been disabled by the Prefiniti administration team.</p><p>Please try again later.</p>
	</div>
	</center>
</cfif>