<!--
	<wwafcomponent>View Priority Projects</wwafcomponent>
	<wwafpackage>Workflow Manager</wwafpackage>
<wwaficon>report.png</wwaficon>
-->
<cfif url.permissionlevel EQ 1>
    <cfquery name="pp" datasource="#session.DB_Core#">
        SELECT * FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) < dueDate AND status=0 AND rfp=0 AND site_id=#url.current_site_id# ORDER BY dueDate ASC
    </cfquery>
<cfelse>
    <cfquery name="pp" datasource="#session.DB_Core#">
        SELECT * FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) < dueDate AND status=0 AND rfp=0 AND site_id=#url.current_site_id# AND clientID=#url.calledByUser# ORDER BY dueDate ASC
    </cfquery>
</cfif>

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
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Priority Projects</h3>
        </div>
    </div>
    <br />
    <br />

<div style="padding:30px;">
<div id="weekCal">
<cfmodule template="/controls/weekCalendar.cfm" viewer="/jobViews/priorityByDay.cfm" showWeekend="false" startDate="firstDayOfWeek">
</div>
<div id="projInfo" style="display:block;">
<p>No project selected</p>
</div>
<cfif #pp.RecordCount# EQ 0>
	<strong>No priority projects.</strong>
<cfelse>
    <table width="100%" cellspacing="0" class="pList">
        <tr>
            <th style="text-align:left; -moz-border-radius-topleft:5px;">Client</th>
            <th>Description</th>
            <th>Project Number</th>
            <th>Status</th>
            <th>Due Date</th>
            <th style="text-align:left; -moz-border-radius-topright:5px;">Tools</th>
        </tr>
        
        <cfoutput query="pp">
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
                <td style="background-color:#ColColor#"><a href="javascript:viewProfile(#clientID#);"><cfmodule template="/jobViews/components/custNameByID.cfm" id="#clientID#"></a><br>#billing_company#</td>
                <td style="background-color:#ColColor#">#description#</td>
                <td style="background-color:#ColColor#">#clsJobNumber#</td>
                <td style="background-color:#ColColor#"><cfif #status# EQ 0>Incomplete<cfelse>Complete</cfif> <cfif #SubStatus# NEQ ""><br>[#SubStatus#]</cfif></td>
                <td style="background-color:#ColColor#"><cfif #dueDate# LT #Now()#><p style="color:red"><cfelseif #DateDiff("d", DateAdd("d",2,Now()), dueDate)# LE 2><p style="color:yellow"><cfelse><p style="color:green"></cfif>#DateFormat(dueDate, "mm/dd/yyyy")#</p></td>
                <td style="background-color:#ColColor#"><img src="graphics/zoom.png" border="0" align="absmiddle"> <a href="javascript:loadProjectViewer(#id#);">View</a>
            </tr>
        </cfoutput>
    </table>
</cfif>
</div>