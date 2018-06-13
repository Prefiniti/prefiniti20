
<cfinclude template="/authentication/authentication_udf.cfm">
<!---<cffunction name="getPermissionByKey" returntype="boolean">
	<cfargument name="sz_key" type="string" required="yes">
    <cfargument name="n_assoc_id" type="numeric" required="yes">--->
    
    
<cfparam name="pl" default="">
<cfset pl = StructNew()>
<cfset pl = GetPLink(URL.Path, URL.FileName)>

<cfparam name="olink" default="">

<cftry>
<cfif getPermissionByKey(pl.RequiredPermission, URL.ASSOCIATION_ID)>
   
    
    <cfoutput>
    <cfswitch expression="#pl.LinkType#">
        <cfcase value="DIRECT">
            <cfset olink="BrowseFrom('#pl.LinkAddress#');">
        </cfcase>
        <cfcase value="SCRIPT">
            <cfset olink = "#pl.LinkAddress#">
        </cfcase>
        <cfcase value="WEB">
            <cfset olink = "BrowseWebLink('#pl.LinkAddress#');">
        </cfcase>
    </cfswitch>
    </cfoutput>
<cfelse>
	<cfset olink="bEb = new AlertBox('You must have the permission #pl.RequiredPermission# to open this item.', 'Permission Denied', '/graphics/error.png'); bEb.Show();">
</cfif>
<cfcatch type="database">
	<cfset olink="alert('" & URL.ASSOCIATION_ID & "\n\n" & URLEncodedFormat(cfcatch.SQLState) & "');">
</cfcatch>
</cftry>
    
<cfoutput>#olink#</cfoutput>