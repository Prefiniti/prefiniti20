<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="getDEs" datasource="#session.DB_Sites#">
	SELECT * FROM department_entries WHERE user_id=#URL.UserID#
</cfquery>

<cfparam name="getSites" default="">
<cfset getSites = getAssociationsByUser(URL.UserID)>
<cfparam name="si" default="">

<div style="height:100%; width:100%; background-color:#999999; color:white;">
	<div style="padding:30px;">
	<strong><img src="/graphics/user.png" align="absmiddle" /> Choose Friend</strong>
	<hr />
		<br />
		<br />
		<cfif URL.ShowFriends EQ true>
		<span class="PTabButtonActive" style="height:25px; width:auto;" id="tab_friends"><img src="/graphics/group.png" align="absmiddle" /> <a href="##" onclick="LoadFriends();">Friends</a> <select size="1" name="upf" id="upf" style="width:50px;" onclick="LoadFriends();"><option value="all" selected>All</option></select>
		</span>
		</cfif>
		<cfif URL.ShowCoworkers EQ true>
    	<span class="PTabButtonInactive" style="height:25px; color:black; width:auto;" id="tab_coworkers"><img src="/graphics/building.png" align="absmiddle"/> <a href="##" onclick="LoadCoworkers(GetValue('UPCowork'));">Coworkers</a>
		<select size="1" name="UPCowork" id="UPCowork" style="width:100px;" onchange="LoadCoworkers(GetValue('UPCowork'));">
			<cfoutput query="getDEs">
				<option value="#department_id#"><cfif wwDepartmentName(department_id) NEQ "">#wwDepartmentName(department_id)#<cfelse>[No Name]</cfif></option>
			</cfoutput>
		</select>
		</span>
		</cfif>
		<cfif URL.ShowCustomers EQ true>
		<span class="PTabButtonInactive" style="height:25px; color:black; width:auto;" id="tab_customers"><img src="/graphics/money.png" align="absmiddle" /> <a href="##" onclick="LoadCustomers(GetValue('UPCust'));">Customers</a>
		<select size="1" name="UPCust" id="UPCust" style="width:100px;" onchange="LoadCustomers(GetValue('UPCust'));">
			
		
			<cfoutput query="getSites">
				<cfset si = getSiteInformation(site_id)>
				<option value="#si.SiteID#">#si.SiteName#</option>
			</cfoutput>
		</select>
		</span>
		</cfif>
		<cfif URL.ShowSearch EQ true>
		<span class="PTabButtonInactive" style="height:25px; width:auto;" id="tab_search"><img src="/graphics/zoom.png" align="absmiddle" /> <a href="####" onclick="LoadSearch();">Search</a> <select size="1" name="ups" id="ups" onclick="LoadSearch();" style="width:50px;"><option value="all" selected>All</option></select></span>
		</cfif>
		<br />
	
		<div id="UPFS_Target" style="background-color:white; border:1px solid black; width:100%; height:300px; color:black; overflow:auto;">
			
		</div>
		<br />
		<cfif URL.BrowseOnly EQ false>
		<cfoutput>
		<div style="float:right;">
			<input type="button" class="normalButton" value="Cancel" id="UPCancel" name="UPCancel" onclick="CancelUserPicker();" /> <input type="button" class="normalButton" value="Choose" onclick="SetValue('#URL.TargetCtl#', GetValue('SelectedUserName')); SetValue('#URL.TargetCtl#_UID', GetValue('SelectedUserID')); CancelUserPicker();"/> <input type="text" readonly id="SelectedUserName" /> <input type="text" style="width:40px;" readonly id="SelectedUserID" /> 
		</div>
		</cfoutput>
		</cfif>
		
		
	
	</div>
</div>