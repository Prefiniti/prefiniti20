<cfquery name="g_my_ratings" datasource="#session.DB_Sites#">
	SELECT * FROM site_ratings WHERE site_id=#attributes.site_id# AND user_id=#attributes.user_id#
</cfquery>

<cfquery name="g_r" datasource="#session.DB_Sites#">
	SELECT * FROM site_ratings WHERE site_id=#attributes.site_id#
</cfquery>    

<cfquery name="g_average_rating" datasource="#session.DB_Sites#">
	SELECT AVG(rating_value) AS sav FROM site_ratings WHERE site_id=#attributes.site_id#
</cfquery>

<cfif g_r.RecordCount GT 0>
    <cfparam name="a_rating" default="">
    <cfset a_rating=#Int(g_average_rating.sav)#>
    
    <strong>Average Rating:</strong><br>
    <cfloop from="1" to="#a_rating#" index="i">
    <img src="/graphics/star.png">
    </cfloop>
    <cfloop from="#a_rating + 1#" to="10" index="i">
    <img src="/graphics/star_gray.png">
    </cfloop><br>
    <cfoutput>#g_r.RecordCount# users have reviewed this company.</cfoutput><br>
<cfelse>
	<strong style="color:red;">Nobody has rated this company yet.</strong>
</cfif>        
<br>
<cfif g_my_ratings.RecordCount EQ 0>    
	<cfoutput>
    
    <div id="rate_company">
    <strong style="">Rate This Company</strong>
    <div style="text-align:center; width:300px;">
    <p style="text-align:left;">
        <strong style="color:red">Worst</strong>
        <input type="radio" name="rating_value" value="1" />
        <input type="radio" name="rating_value" value="2" />
        <input type="radio" name="rating_value" value="3" />
        <input type="radio" name="rating_value" value="4" />
        <input type="radio" name="rating_value" value="5" />
        <input type="radio" name="rating_value" value="6" />
        <input type="radio" name="rating_value" value="7" />
        <input type="radio" name="rating_value" value="8" />
        <input type="radio" name="rating_value" value="9" />
        <input type="radio" name="rating_value" value="10" />
        <strong style="color:green">Best</strong><br /><br />
       
    </p>    
     <img src="/graphics/medal_bronze_add.png" align="absmiddle" /> <a style="font-weight:bold;" href="javascript:rateCompany(#attributes.site_id#, #attributes.user_id#, AjaxGetCheckedValue('rating_value'));">Save Rating</a>
    </div>
    </div>
    </cfoutput>
<cfelse>
	<strong style="color:red;">You have already rated this company.</strong>
</cfif>    	