<cfquery name="getUsers" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE type=1 ORDER BY longName
</cfquery>

<cfquery name="getCrewMembers" datasource="#session.DB_Core#">
	SELECT 	
			c.crewid, 
			c.chief, 
			u.picture,
			u.id AS userID, 
			u.longName 
	FROM	crew_entries c
	INNER JOIN 
			Users u
	ON
			u.id = c.userid 
	WHERE
			c.crewid = #url.id#
			
</cfquery>

<cfquery name="getCrewName" datasource="#session.DB_Core#">
	SELECT * FROM crews WHERE id=#url.id#
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<h2 style="color:#3399CC; font-family:'Times New Roman', Times, serif"><cfoutput>#getCrewName.name#</cfoutput></h2>

<div style="float:left; height:250px; overflow:scroll; width:48%; border:1px solid silver;">
	<h2>All Users</h2>
	<table cellpadding="5" cellspacing="0" width="100%">
		<cfoutput query="getUsers">
			<cfset RowNum=RowNum + 1>
			<cfset ColOdd=RowNum mod 2>
			
			<cfswitch expression="#ColOdd#">
				<cfcase value=1>
					<cfset ColColor="silver">
				</cfcase>
				<cfcase value=0>
					<cfset ColColor="white">
				</cfcase>
			</cfswitch>
			<tr>
				<td style="background-color:#ColColor#">
					<cfif #picture# EQ "">
						<img src="/graphics/no_pic.gif" width="65" height="65">
					<cfelse>
						<img src="/authentication/profile_images/#picture#" width="65" height="65">
					</cfif>
				</td>
				<td style="background-color:#ColColor#"><h3><a href="javascript:editUser(#id#)">#longName#</a></h3><br>
				<img src="/graphics/user_add.png"> <a href="javascript:addUserToCrew(#url.id#, #id#);">Add to crew</a> 
				</td>
			</tr>
		</cfoutput>
	</table>
</div>
<cfset RowNum="0">
<cfset ColOdd="">

<div style="float:right; height:250px; overflow:scroll; width:48%; border:1px solid silver;">
<h2>This Crew</h2>
<table cellspacing="0" cellpadding="5" width="100%">
	<cfoutput query="getCrewMembers">
		<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="silver">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
		<tr>
			<td style="background-color:#ColColor#">
				<cfif #picture# EQ "">
					<img src="/graphics/no_pic.gif" width="65" height="65">
				<cfelse>
					<img src="/authentication/profile_images/#picture#" width="65" height="65">
				</cfif>
			</td>
			<td style="background-color:#ColColor#"><h3><a href="javascript:editUser(#userid#)">#longName#</a></h3> <br><label><input type="checkbox" name="#userid#_isChief" id="#userid#_isChief" <cfif #chief# EQ 1>checked</cfif> onclick="setCrewChief(#url.id#, #userid#, IsChecked('#userid#_isChief'));">Crew chief</label><br>
			<img src="/graphics/user_delete.png"> <a href="javascript:deleteUserFromCrew(#url.id#, #userid#);">Delete from crew</a> 
			</td>
		</tr>
	</cfoutput>
</table>
</div>
