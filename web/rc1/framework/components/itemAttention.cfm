<cfquery name="gInbox" datasource="#session.DB_Core#">
SELECT messageInbox.id AS msgid, messageInbox.tbody, messageInbox.tsubject, messageInbox.tdate, messageInbox.tread, Users.username FROM messageInbox INNER JOIN Users ON Users.id=messageInbox.fromuser WHERE messageInbox.touser=#url.calledByUser# AND messageInbox.tread='no' ORDER BY messageInbox.tdate
</cfquery>
<table width="100%">
  <cfif #url.unreadMail# GT 0>
	<tr>
	  <td style="text-indent:30px;"><img align="absmiddle" src="graphics/email.png"/> You have <a href="javascript:viewMailFolder('inbox');" style="color:red"><strong><cfoutput>#url.unreadMail#</cfoutput> unread messages</strong></a> in your inbox. <br />
		  <div style="padding-left:40px;">
		  <table width="100%" cellspacing="0">
			<cfoutput query="gInbox">
			  <tr>
				<td style="background-color:##CCCCCC"><a href="javascript:showDiv('body_#msgid#')"><img src="graphics/email_open.png" border="0" /></a></td>
				<td style="background-color:##CCCCCC"><cfif #tread# EQ "no">
				</cfif>
					<strong>#username#</strong></td>
				<td style="background-color:##CCCCCC">#DateFormat(tdate, "mm/dd/yyyy")#</td>
				<td style="background-color:##CCCCCC">#tsubject#</td>
			  </tr>
			  <tr>
				<td colspan="4" style="background-color:##CCCCCC">
					<div id="body_#msgid#" style="display:none;"> #tbody# </div>
				</td>
			  </tr>
			  </div>
			  
			</cfoutput>
		  </table>
		</div>
	  </td>
	</tr>
  </cfif>
  <cfif #url.overdue# GT 0>
	<tr>
	  <td style="text-indent:30px;"><img align="absmiddle" src="graphics/clock_error.png"/> There are <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/checkDelinquent.cfm');" style="color:red"><strong><cfoutput>#url.overdue#</cfoutput> delinquent orders </strong></a> in the system.</td>
	</tr>
  </cfif>
  <cfif #url.istcadmin# EQ "yes">
	<cfif #url.tcsigned# GT 0>
	  <tr>
		<td style="text-indent:30px;"><img align="absmiddle" src="graphics/time.png"/> There are <cfoutput><a href="javascript:loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '1/1/2999', 'Signed', '#url.istcadmin#', '')" style="color:red"><strong>#url.tcsigned# timesheets</strong></a></cfoutput> awaiting your approval.</td>
	  </tr>
	</cfif>
  </cfif>
  <cfif #url.tcopen# GT 0>
	<tr>
	  <td style="text-indent:30px;"><img align="absmiddle" src="graphics/time.png"/> You have <cfoutput><a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', '#url.istcadmin#', '')" style="color:red"><strong>#url.tcopen# open timesheets</strong></a></cfoutput> which need to be signed.</td>
	</tr>
  </cfif>
  <cfif #url.order_processor# EQ 1>
  <cfif #url.newJobs# GT 0>
	<tr>
	  <td style="text-indent:30px;"><img align="absmiddle" src="graphics/basket.png"/> There are <cfoutput><a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/newJobs.cfm');" style="color:red"><strong>#url.newJobs# new Job Requests</strong></a></cfoutput> in the system. </td>
	</tr>
  </cfif>
  </cfif>
</table>
