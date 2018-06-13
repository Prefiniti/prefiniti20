<cfinclude template="/authentication/authentication_udf.cfm">
<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WF_PROCESSORDER">

<!--
	<wwafcomponent>Process New Orders</wwafcomponent>
	<wwafpackage>Workflow Manager</wwafpackage>
<wwaficon>report.png</wwaficon>
-->
<style type="text/css">
	.pList 
	{
		border-left:1px solid #EFEFEF;
		border-right:1px solid #EFEFEF;
		-moz-border-radius-topleft:5px;
		-moz-border-radius-topright:5px;
	}
	
	.pList th
	{
		text-align:left;
		background-color:#EFEFEF;
		color:#3399CC;
		font-weight:bold;
		background-image:none;
	}
	
	.pList td
	{
		border-bottom:1px solid #EFEFEF;
	}
	
</style>
<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfquery name="newJobs" datasource="#session.DB_Core#">
	SELECT * FROM projects WHERE viewed=0 AND stage=0 AND site_id=#url.current_site_id# ORDER BY clientID
</cfquery>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> New Orders</h3>
        </div>
    </div>
    <br />
    <br />
    <div style="padding:20px;">
<table width="100%" cellpadding="3" cellspacing="0" class="pList">
	<cfif #newJobs.recordcount# GT 0>

	<tr>
		<th align="left" style="-moz-border-radius-topleft:5px;">Customer</th>
		<th align="left">Description</th>
		<th align="left">Project Type</th>
		<th align="left">Due Date</th>
		<th align="left"  style="-moz-border-radius-topright:5px;"><strong></strong>Tools</th>
	</tr>
	</cfif>
	<cfif #newJobs.recordcount# EQ 0>
	<tr>
		<td align="center"><br /><br /><br /><p style="color:red">No new orders have been placed.</p><br />
		<!---<p class="VPLink"><img src="graphics/report_go.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/allIncomplete.cfm');"> View incomplete projects</a><br />
		<img src="/graphics/report_go.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/allByCustomer.cfm');">View all projects</a></p><br /><br /><br />---></td>
	</tr>
	</cfif>
	<cfoutput query="newJobs">
    <cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="white">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
		<tr>
			<td style="background-color:#ColColor#"><cfmodule template="/jobViews/components/custNameByID.cfm" id="#clientID#"></td>
			<td style="background-color:#ColColor#">#description#</td>
			<td style="background-color:#ColColor#"><cfif ServiceType NEQ "">#ServiceType#<br /></cfif>#jobtype#</td>
			<td style="background-color:#ColColor#">#DateFormat(duedate, "mm/dd/yyyy")#</td>
			<td style="background-color:#ColColor#">
            	<img src="/graphics/zoom.png" align="absmiddle"> 
				<cfif rfp EQ 0>
                	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workFlow/components/processOrder.cfm?id=#id#');">Process Order</a>
                    <cfif rfp_accepted EQ 1>
                    	&nbsp;- [RFP Accepted]<br />
                        <img src="/graphics/zoom.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workFlow/components/viewRFP.cfm?id=#id#&viewOnly=1');">View RFP</a>
                    </cfif>
                <cfelse>
                	<cfif rfp_processed EQ 0>
                		<cfif getPermissionByKey("WF_PROCESSRFP", url.current_association)>
	                        <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workFlow/components/processRFP.cfm?id=#id#');">Process RFP</a>
                        <cfelse>
                        	RFP Awaiting Processing
						</cfif>                            
                    <cfelse>
                    	RFP Awaiting Customer Acceptance<br />
                        <img src="/graphics/zoom.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workFlow/components/viewRFP.cfm?id=#id#&viewOnly=1');">View RFP</a>
                    </cfif>
                </cfif>
            </td>
		</tr>
	</cfoutput>
			
	
</table>
</div>

