<cfinclude template="/authentication/authentication_udf.cfm">

							
								
							
							<cfif getPermissionByKey("WF_SEARCH", #url.current_association#) EQ true>
								<cfmodule template="/MyCL/components/Collapse.cfm" DivName="searchBar" HeaderText="Project Locator" InitialState="none" URL="/search/components/search.cfm" SideImage="AppIconResources/crystal_project/16x16/actions/search.png">
							</cfif>
							
							
							<cfif getPermissionByKey("TS_VIEW", #url.current_association#) EQ true>
							<cfmodule template="/MyCL/components/Collapse.cfm" DivName="timeEntryBar" HeaderText="Time Entry" InitialState="none" URL="/framework/sb_TimeEntry.cfm" SideImage="AppIconResources/crystal_project/16x16/actions/timespan.png">	
							</cfif>

	