<cfquery name="g_r" datasource="#session.DB_Sites#">
	SELECT * FROM site_ratings WHERE site_id=#attributes.site_id#
</cfquery>    

<cfquery name="g_average_rating" datasource="#session.DB_Sites#">
	SELECT AVG(rating_value) AS sav FROM site_ratings WHERE site_id=#attributes.site_id#
</cfquery>

<cfif g_r.RecordCount GT 0>
    <cfparam name="a_rating" default="">
    <cfset a_rating=#Int(g_average_rating.sav)#>
    
    <cfloop from="1" to="#a_rating#" index="i">
    <img src="/graphics/star.png">
    </cfloop>
    <cfloop from="#a_rating + 1#" to="10" index="i">
    <img src="/graphics/star_gray.png">
    </cfloop><br>
    <cfoutput>#g_r.RecordCount# users have rated this company.</cfoutput><br>
<cfelse>
	<strong style="color:red;">Nobody has rated this company yet.</strong>
</cfif>        
