<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
	
    <!---<cfquery name="gUsers" datasource="#session.DB_Core#">
		SELECT longName, id FROM Users WHERE type=1 ORDER BY lastName, firstName 
	</cfquery>--->
    
    <cfquery name="gUsers" datasource="#session.DB_Sites#">
		SELECT user_id FROM site_associations WHERE site_id=#url.current_site_id# AND assoc_type=1
	</cfquery>

	<cfquery name="qjnv" datasource="#session.DB_Core#">
		SELECT clsJobNumber, description FROM projects WHERE site_id=#url.current_site_id#
	</cfquery>
				<table width="100%">
					
					
					<tr>
						<td><cfoutput>
							
							
							<cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) NEQ true>
								<form name="dateSelEmp">
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<th colspan="2"><cfoutput>View by Date</cfoutput></th>
									</tr>
									
									<tr>
										<td align="right">From</td>
										<td align="left" nowrap><input name="startDateEmp" id="startDateEmp" type="text" size="15" readonly> 
										<a href="javascript:popupDate(AjaxGetElementReference('startDateEmp'));"><img src="/graphics/date.png" border="0"></a></td>
									</tr>
									<tr>
										<td align="right">Until</td>
										<td align="left" nowrap><input name="endDateEmp" id="endDateEmp" type="text" size="15" readonly> 
										<a href="javascript:popupDate(AjaxGetElementReference('endDateEmp'));;"><img src="/graphics/date.png" border="0"></a></td>
									</tr>
									<tr>
									<td align="right"></td>
									<td align="left">
										<input type="button" class="normalButton" onclick="javascript:loadWeekToCtls('startDateEmp', 'endDateEmp');" value="Use Current Week" /><br />&nbsp;
									</td>
								</tr>
									<tr>
										<td colspan="2" align="right">
											<input type="button" class="normalButton" name="printByUserEmp" value="View All Printable" 
											onclick="javascript:loadTimesheetPrint('tcTarget', #url.calledByUser#, GetValue('startDateEmp'), GetValue('endDateEmp'), 'None', 'no', '')"/>
											<input type="button" class="normalButton" name="getByUser" value="View Editable" 
											onclick="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, GetValue('startDateEmp'), GetValue('endDateEmp'), 'Open', 'no', '')"/>
										</td>
									</tr>
									
								</table>
								</form>
								<script language="javascript">
									var startDateEmpCal = new calendar2(document.forms['dateSelEmp'].elements['startDateEmp']);
									var endDateEmpCal = new calendar2(document.forms['dateSelEmp'].elements['endDateEmp']);
								</script>
							</cfif>
							
							
							</cfoutput>
							<cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) EQ true>
							<form name="dateSel">
							<table width="100%" cellpadding="0" cellspacing="0">
								<tr>
									<th colspan="2"><cfoutput>View by Employee</cfoutput></th>
								</tr>
								<tr>
									<td align="right">Employee</td>
									<td>
										<select name="byUser" id="byUser">
												<option value="noUserFilter">All Users</option>
											<cfoutput query="gUsers">
												<option value="#user_id#">#getLongname(user_id)#</option>
											</cfoutput>	
										</select>
									</td>
								</tr>
								<tr>
									<td align="right">From</td>
									<td align="left" nowrap><input name="startDate" id="startDate" type="text" size="15" readonly> 
									<a href="javascript:popupDate(AjaxGetElementReference('startDate'));"><img src="/graphics/date.png" border="0"></a></td>
								</tr>
								<tr>
									<td align="right">Until</td>
									<td align="left" nowrap><input name="endDate" id="endDate" type="text" size="15" readonly> 
									<a href="javascript:popupDate(AjaxGetElementReference('endDate'));"><img src="/graphics/date.png" border="0"></a></td>
								</tr>
								<tr>
									<td align="right"></td>
									<td align="left">
										<input type="button" class="normalButton" onclick="javascript:loadWeekToCtls('startDate', 'endDate');" value="Use Current Week" />
									</td>
								</tr>
								<tr>
									<td align="right">Filter By</td>
									<td align="left" nowrap><p>
									  <label>
									    <input name="filterBy" type="radio" value="None" checked="checked" />
									    View All</label>
									  <br />
									  <label>
									    <input type="radio" name="filterBy" value="Signed" />
									    Signed Only</label>
									  <br />
									  <label>
									    <input type="radio" name="filterBy" value="Open" />
									    Open Only</label>
									  <br />
									  <label>
									    <input type="radio" name="filterBy" value="Approved" />
									    Approved Only</label>
									  <br />
									  </p>									</td>
								</tr>
								<tr>
									<td>Project Number:</td>
									<td>
										<select name="projectNumber" id="projectNumber">
												<option value="" selected="selected">No filter</option>
											<cfoutput query="qjnv">
												<option value="#clsJobNumber#">#clsJobNumber#</option>
											</cfoutput>
											
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="right">
										<cfoutput>
										  <input type="button" class="normalButton" name="printByUser" value="View Printable" 
											onclick="javascript:loadTimesheetPrint('tcTarget', GetValue('byUser'), GetValue('startDate'), GetValue('endDate'), AjaxGetCheckedValue('filterBy'), 'no', GetValue('projectNumber'))"/>
									    <input type="button" class="normalButton" name="getByUser" value="View Editable" 
										onclick="javascript:loadTimesheetView('tcTarget', GetValue('byUser'), GetValue('startDate'), GetValue('endDate'), AjaxGetCheckedValue('filterBy'), 'no', GetValue('projectNumber')); hideDiv('gen_window_frame');"/></cfoutput>									</td>
								</tr>
								
							</table>
							</form>
							
							</cfif>
							
							
						</td>
				</table>
			
			