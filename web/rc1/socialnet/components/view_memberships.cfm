<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="gMem" datasource="#session.DB_Sites#">
	SELECT * FROM site_associations WHERE user_id=#attributes.user_id#
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<table cellspacing="0">
	<cfoutput query="gMem">
		<cfset RowNum=RowNum + 1>
            <cfset ColOdd=RowNum mod 2>
            
            
            
            <tr>
            	<td style="background-color:#ColColor#"><a href="javascript:viewSiteProfile(#site_id#);">#getSiteNameByID(site_id)# - <cfif assoc_type EQ 0>
                    	Customer
                    <cfelse>
                    	Employee
                    </cfif>
                    </a>
                    </td>
                
            </tr>
    </cfoutput>
</table>    
