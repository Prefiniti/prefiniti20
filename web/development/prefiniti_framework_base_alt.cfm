<head>
	<title>The Prefiniti Network</title>
</head>    
<cfif session.browserType EQ "Microsoft Internet Explorer">
	<h1>Unsupported Browser</h1>
    
    <p>Prefiniti no longer supports any version of Microsoft Internet Explorer. You will be redirected to the home page in a few moments, where you will be presented with links to download a supported browser.</p>
    
    <script>
		window.setTimeout("location.replace('/default.cfm');", 10000);
	</script>		
</cfif>    
<cfif session.loggedin EQ "no">
	<cflocation url="/default.cfm" addtoken="no">
</cfif>
<cfquery name="fwb" datasource="#session.DB_Core#">
	UPDATE Users SET framework_base='Prefiniti_1_5.cfm?FW15' WHERE id=#session.userid#
</cfquery>
<!---<cflocation url="/Prefiniti_1_5.cfm?FW15">--->
<cfinclude template="/framework/components/navigator.cfm">
<table width="100%" cellspacing="0" >
  <tr>
    <td rowspan="2" style="background-color:#efefef; border-top:1px solid #cccccc;" valign="top" align="left">
    <span style="background-color:#EFEFEF; display:block; padding:5px;">
                <span id="packageIcon" style="padding-left:10px; display:none;"></span><span id="packageName" style="padding-left:3px; padding-right:3px; font-size:large; font-weight:bold; color:#3399cc;">
                </span><br />
                <span id="uo" style="padding-left:3px;"></span>
            </span><br>
            <!---<div style="padding-left:5px;">
            <!---<strong style="color:#3399cc;">View Options</strong>
	<div style="padding-left:5px;">
    	
    	<a href="/prefiniti_framework_base.cfm">Keep everything on one screen</a><br>
    	<a href="/prefiniti_framework_base_alt.cfm"><strong>Use entire browser window</strong></a> 
    </div> --->        
    </div>--->
    </td>
    <td style="background-color:#efefef; border-top:1px solid #cccccc;" valign="top">
    	 <div id="stWrapper">
            <div id="stT" style="width:100%;">
                <cfif #session.loggedin# EQ "yes">
                    
                    <div style="width:100%; background-color:#EFEFEF;">
                    
                    <a href="javascript:navigateBack();"><img src="/graphics/resultset_previous.png" border="0" align="absmiddle" /> <a href="javascript:navigateForward();"><img src="/graphics/resultset_next.png" border="0" align="absmiddle"/></a>
                     <a href="javascript:loadHomeView();"><img src="graphics/house.png" border="0" align="absmiddle" /></a>
                    &nbsp; <a href="javascript:AjaxRefreshTarget();"><img src="graphics/arrow_refresh.png" border="0" align="absmiddle" /></a>&nbsp;<!---<a href="javascript:copyToClipboard()"><img src="/graphics/page_copy.png" border="0" align="absmiddle"/></a>&nbsp;---><span id="documentName" style="color:black; padding-left:5px; padding-right:5px;"></span> 
                    <!---History: <select style="margin-top:3px;" id="history" name="history" size="1" onchange="AjaxLoadPageToDiv('tcTarget', GetValue('history'));"><option value=""> </option></select>---><!---<a href="javascript:AjaxLoadPageToDiv('tcTarget', GetValue('history'));"><img src="graphics/page_go.png" border="0" align="absmiddle"/></a> | ---><img src="graphics/help.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/chat/liveHelpIntro.cfm');">Live Help</a> |
                    
                    <span id="file_action" style="width:100%; background-color:#EFEFEF; display:none; padding:5px;">
	<input type="hidden" name="selected_file_id" id="selected_file_id" value="">
    <input type="hidden" name="current_mode" id="current_mode" value="" />
    <!--function mailWithAttachments(attachment_file_id, attachment_file_name)-->
	<span id="cms_send_file"><img src="/graphics/email_attach.png" border="0" align="absmiddle"> <a href="javascript:mailWithAttachments(GetValue('selected_file_id'))">Send File</a> |&nbsp;</span>
    <span id="cms_delete_file"><img src="/graphics/bin.png" border="0" align="absmiddle"> <a href="javascript:cmsDeleteFile(GetValue('selected_file_id'), GetValue('current_mode'));">Delete File</a> |&nbsp;</span>
    <img src="/graphics/zoom.png" border="0" align="absmiddle"> <a href="javascript:cmsViewFile(GetValue('selected_file_id'), GetValue('current_mode'));">View File</a>
</span>
                    
                    </div>
                </cfif>
            </div>
            
    </td>
  </tr>
  <tr>
    <td>
    <div id="sbTarget" style=" min-height:20px; height:auto;width:100%; border-bottom:1px solid #EFEFEF; vertical-align:bottom; padding-top:10px; padding-left:3px; overflow:auto; background-image:url(/graphics/wizardbg.png); background-attachment:fixed; background-position:top left; background-repeat:no-repeat;">
            
            </div>
    </td>
  </tr>
  <tr>
    <td style="width:220px; background-color:#efefef;" valign="top">
    <div class="picWrap" align="center">
					
					<div id="profilePicture">
					
						<cfoutput query="profile">
                        <span id="mainPic">
						<cfif #picture# EQ "">
                            <cfif #gender# EQ "M">
                                <img src="/graphics/genpicmale.png" width="220"  />
                                <cfelseif #gender# EQ "F">
                                <img src="/graphics/genpicfemale.png" width="220" >
                            <cfelse>
                                <img src="/graphics/genpicmale.png" width="220">
                            </cfif>
                        <cfelse>
                            <img src="#picture#" width="220" style="-moz-border-radius:5px;" >
                        </cfif>
                        </span>
                        <strong><a href="javascript:editUser(#session.userid#, 'basic_information.cfm');">Edit Profile</a> | <a href="javascript:viewProfile(#session.userid#);">View Profile</a><br />
                        <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/search_users.cfm');">Find People</a> | <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/find_companies.cfm');">Find Companies</a> | <a href="javascript:viewPictures(#session.userid#, true);">My Pictures</a><br /><a href="javascript:cmsBrowseFolder(#session.userid#, 'project_files', '', 'user', '');">My Files</a> | <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/businessnet/components/my_departments.cfm');">My Departments</a> | <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(Now(), "yyyy/mm/dd")#');">My Schedule</a><br /><a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/post_blog.cfm');">Compose Blog</a> | <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/view_comments.cfm');">My Comments</a><br />
                        <a href="javascript:Chat_EntryPoint();">Open Prefiniti Chat</a> <img src="/graphics/new.png" align="absmiddle"><br /><a href="javascript:PBackgroundServices();">Manage Background Services</a><br /><br />
                        

                        </strong>
                       
                        </cfoutput>                   
                        
                        
                        </div>
                        <style type="text/css">
							.hTabl td { 
								background-color:#efefef;
								}
						</style>

						<cfoutput><img src="/graphics/AppIconResources/#session.PDMDefaultTheme#/16x16/apps/khelpcenter.png" border="0" align="absmiddle"  id="DockIcon_8"/> <a href="javascript:PHelpBrowser(0);">Search Help</a></cfoutput>
        <br />
                    <div id="historyList" style="display:none; width:220px; overflow:hidden;" align="left">
                    
                    </div>
                    <div id="currentStats" align="left" style="clear:left; display:none;">
                    
                    </div>
                    
                    
                    
                    <div id="framework_status" style="font-size:6pt; padding-top:16px;" align="left"></div>
                    
                    <div id="statTargetLegacy" align="left" style="color:red; font-weight:bold;">
                    	
                    </div>
                    <div id="clock"></div>
                    
			</div>
    
    </td>
    <td valign="top" style="border-bottom:1px solid #cccccc; border-right:1px solid #cccccc;"><div id="tcTarget"></div></td>
  </tr>
</table>
          
<cfset session.framework_loaded="1">
        <cfoutput>
        	<script>
				hideSplash();
				PrefinitiLegacyInit();
				fwRegisterAutoUpdate("/framework/components/sitestats.cfm", "statTargetLegacy");
				
				//InitializePrefiniti();
			</script>
            <cfif #session.pwdiff# GE 30>
                <script language="javascript">
                    hideSplash();
					AjaxLoadPageToDiv('tcTarget', '/authentication/components/changePassword.cfm?id=#session.userid#&expired=true');
                </script>
                
            <cfelse>
                <cfif #session.last_loaded_page# EQ "">
                    <script language="javascript">
                        loadHomeView();
                    </script>
                <cfelse>
                    <cfif #session.remember_page# EQ 1>
                        <script language="javascript">
                            AjaxLoadPageToDiv('tcTarget', '#session.last_loaded_page#');
                        </script>
                    <cfelse>
                        <script language="javascript">
							loadHomeView();
														
                        </script>                
                    </cfif>
                </cfif>
                
                <script language="javascript">
					//glob_framework_loaded = #session.framework_loaded#;
                    //handleAppResize();
					loadSiteStats();
					hideSplash();
                </script>

            </cfif>
            <cfif IsDefined("url.event_redir")>
            	
				<script language="javascript">
				
					#url.event_redir#
				</script>
			</cfif>                					
        </cfoutput>          