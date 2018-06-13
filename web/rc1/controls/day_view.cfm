<cftry>
<cfinclude template="/scheduling/scheduling_udf.cfm">
<cfcatch type="any">
</cfcatch>
</cftry>

<cftry>
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfcatch type="any">
</cfcatch>
</cftry>

<style type="text/css">
	.timeTable th
	{
		text-align:left;
		background-image:none;
		background-color:#EFEFEF;
		font-weight:bold;
		color:#3399CC;
	}
	
	.itemBlock {
		background-color:#C0C0C0;
		color:#3399CC;
		font-weight:bold;
		width:150px;
		float:left;
		
		opacity:.90;
	}		 
	
</style>
<cfquery name="tl" datasource="#session.DB_Core#">
	SELECT * FROM time_lookup
</cfquery>     	

<cfparam name="times" default="">
<cfset times=ArrayNew(1)>

<cfoutput query="tl" >
	<cfset times[block_id] = time_12hour>
</cfoutput>    

<cfparam name="shading" default="white">
<cfoutput><strong style="font-weight:bold; color:##3399CC">#DateFormat(attributes.date, "dddd mmmm d, yyyy")#</strong></cfoutput>
<table width="100%" cellspacing="0" cellpadding="0" style="clear:left;" class="timeTable">
<tr>
	<th>Time</th>
    <cfloop from="1" to="#ArrayLen(attributes.users)#" index="i">
    	<cfoutput><th>#getLongname(attributes.users[i])#</th></cfoutput>    
    </cfloop>
</tr>    
<cfloop index="i" from="1" to="96" step="4">
	<cfif i GE 33 AND i LE 67>
    	<cfset shading="white">
    <cfelse>
    	<cfset shading="##EFEFEF;">
	</cfif>		
    <cfoutput>
	<tr>
    	<td rowspan="5" width="80" style="border-bottom:1px solid ##C0C0C0; background-color:#shading#; color:##3399CC; font-size:small; font-weight:bold;" nowrap><cfoutput>#times[i]#</cfoutput></td>
    </tr>
    
    <cfloop from="1" to="4" index="current_block">
    	<tr>
        	<cfloop from="1" to="#ArrayLen(attributes.users)#" index="current_user">
    		<td style="background-color:#shading#; border-bottom:1px solid ##C0C0C0;" <cfif attributes.users[current_user] EQ url.calledByUser>ondblclick="javascript:scAddIndividualEvent(#attributes.users[current_user]#, #i + current_block - 1#, '#attributes.date#');"</cfif>><!---i: #i#  i+current_block-1: #i + current_block - 1#  current_block: #current_block#  current_user: #current_user#--->
        		                  
                	#scItemsByBlock(i + current_block - 1, attributes.users[current_user], attributes.date)#
				                    
       		</td>  
            </cfloop>
    	</tr>
    </cfloop>
    
    </cfoutput>
</cfloop>	
</table>