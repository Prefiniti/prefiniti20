<cfinclude template="/contentmanager/cm_udf.cfm">



<cfparam name="pQuot" default="">
<cfparam name="quota_size" default="">
<cfset pQuot=getQuotaUsed(#attributes.user_id#)>
<cfset quota_size=getQuota(#attributes.user_id#)/1024>
<cfset total_used=cmsTotalSpaceUsed(#attributes.user_id#)/1024>

            	
                <div style="border:1px solid gray; width:200px; height:10px; float:right;">
                	<cfloop from="1" to="#pQuot#" index="i">
                		<div style="width:2px; height:10px; background-color:gold; border:none; float:left;">&nbsp;</div>
                	</cfloop>
                </div>
           
           	<div style="float:right; padding-right:3px; color:white; font-weight:bold; font-size:xx-small; font-family:Verdana, Arial, Helvetica, sans-serif;">
            <cfif pQuot EQ 100><font color="red"><cfelse><font></cfif>
            <cfoutput>#pQuot#% full</cfoutput></font>
            </div>