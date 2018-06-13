<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="ass_count" datasource="#session.DB_Sites#">
	SELECT * 
	FROM 	site_associations
    WHERE	user_id=#url.calledByUser#
    AND		site_id=#url.site_id#
</cfquery>    


<cfparam name="si" default="">
<cfset si=getSiteInformation(url.site_id)>
<cfoutput>
<!--
	<wwafcomponent>#si.SiteName# Company Profile</wwafcomponent>
-->    
</cfoutput>

<cfoutput query="si">
	<table width="100%">
    	<tr>
        	<td width="200" valign="top">
            	<div style="padding:5px; margin:3px; background-color:##EFEFEF; -moz-border-radius:5px;">
				<cfif logo NEQ "">
                	<img src="/SiteContent/#url.site_id#/#logo#" width="200">
				</cfif>
                <br />
                <br />
                <strong>Industry: </strong>#getIndustryByID(industry)#<br><br />
                <div id="join_site">
                <cfif ass_count.RecordCount EQ 0>
	                <img src="/graphics/building_key.png" align="absmiddle" /> <a href="javascript:joinSite(#url.site_id#, #url.calledByUser#);">Become a member</a>
				<cfelse>
                	You are a member of this site.
					<br /><br /><br />
					<div align="center" style="background-color:##0099FF; padding:5px; font-size:x-large; -moz-border-radius:5px; margin:2px;"><center>
						<a style="color:white;" href="javascript:ViewCatalog(#url.site_id#);">Order Online</a>
						</center>
					</div>						
				</cfif>                                        
                </div>
                <br />
                <br />
                
                </div>
			</td>
        	<td valign="top">
    			<div id="CatArea">
				<h3 class="stdHeader" style="padding-bottom:0px; margin-bottom:0px;">#SiteName#</h3>            
    <em><cfif slogan NEQ "">&quot;#slogan#&quot;</cfif></em>
    			<div style="padding-left:30px;">
                 <p>#about#</p>
                 <p>#summary#</p>
                </div>
    			<div class="homeHeader"><img src="/graphics/star.png" align="absmiddle"/> Company Rating</div>
                <div style="padding-left:30px;">
                <cfmodule template="/socialnet/components/rating_add.cfm" site_id="#url.site_id#" user_id="#url.calledByUser#">
                </div>
                    <div class="homeHeader"><a href="/news/rss.cfm?current_site_id=#url.current_site_id#" target="_blank"><img src="graphics/feed.png" align="absmiddle" border="0"/></a> Site News</div>
                <div style="padding-left:30px;">
                <cfmodule template="/news/components/newsView.cfm"  site_id="#SiteID#">
                </div>
                <div style="padding-left:30px;">
                <h3>Summary</h3>
                <p>#summary#</p>
                <h3>Mission Statement</h3>
                <p>#mission_statement#</p>
                <h3>Vision Statement</h3>
                <p>#vision_statement#</p>
                </div>
				</div>
    		</td>
		</tr>
	</table>                    
</cfoutput>
