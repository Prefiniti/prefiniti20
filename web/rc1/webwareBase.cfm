<cfif session.loggedin EQ "no">
	<cflocation url="/default.cfm">
</cfif>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Prefiniti</title>
        <link href="css/gecko.css" rel="stylesheet" type="text/css" />
    </head>
    
    <body>
        <div class="sidebarBlock"  style="height:auto; width:240px;" id="sbWrapper">
            <span style="background-color:#EFEFEF; display:block; padding:5px; -moz-border-radius-topleft:10px;">
                <span id="packageIcon" style="padding-left:10px;"></span><span id="packageName" style="padding-left:3px; padding-right:3px;">
                </span>
            </span>
            
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
                        <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/search_users.cfm');">Friend Search</a> | <a href="javascript:viewPictures(#session.userid#, true);">Pictures</a><br /><a href="javascript:cmsBrowseFolder(#session.userid#, 'project_files', '', 'user', '');">My Files</a>
                        
                        <!--<a href="javascript:showDiv('historyList');">Show History</a><br />-->
                        </strong>
                        </cfoutput>                   
                        
                        
                        </div>
        <br />
                    <div id="historyList" style="display:none; width:220px; overflow:hidden;" align="left">
                    
                    </div>
                    <div id="currentStats" align="left">
                    
                    </div>
                    
                    
                    
                    <div id="framework_status" style="font-size:6pt; padding-top:16px;" align="left"></div>
                    
                    <div id="statTarget" align="left" style="color:red; font-weight:bold;">
                    	
                    </div>
			</div>
                    
                    
				            
            <!--<div id="sbTarget">
            
            </div>-->
        </div>
        
        <div id="tabBars" class="tabBar" style="display:none;">
            <span class="tabButtonActive" id="listViewBtn"><a href="javascript:setListView();"><span id="sdfdsdf">Document Viewer</span></a></span>
            <span class="tabButtonInactive" id="mapViewBtn" style="display:none"><a href="javascript:setMapView();"><span id="mapViewText">Map View</span></a></span>
        </div>
                        
        <div id="stWrapper" class="orderListBlock" style="padding:0px;width:700px;height:auto; margin-top:32px;">
            <div id="stT" style="width:100%;">
                <cfif #session.loggedin# EQ "yes">
                    
                    <div style="width:100%; background-color:#EFEFEF;">
                    
                    <a href="javascript:navigateBack();"><img src="/graphics/resultset_previous.png" border="0" align="absmiddle" /> <a href="javascript:navigateForward();"><img src="/graphics/resultset_next.png" border="0" align="absmiddle"/></a>
                     <a href="javascript:loadHomeView();"><img src="graphics/house.png" border="0" align="absmiddle" /></a>
                    &nbsp; <a href="javascript:AjaxRefreshTarget();"><img src="graphics/arrow_refresh.png" border="0" align="absmiddle" /></a>&nbsp;<!---<a href="javascript:copyToClipboard()"><img src="/graphics/page_copy.png" border="0" align="absmiddle"/></a>&nbsp;---><span id="documentName" style="color:black; padding-left:5px; padding-right:5px;"></span> 
                    History: <select style="margin-top:3px;" id="history" name="history" size="1" onchange="AjaxLoadPageToDiv('tcTarget', GetValue('history'));"><option value=""> </option></select><!---<a href="javascript:AjaxLoadPageToDiv('tcTarget', GetValue('history'));"><img src="graphics/page_go.png" border="0" align="absmiddle"/></a> | ---><img src="graphics/help.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/chat/liveHelpIntro.cfm');">Live Help</a> |
                    
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
            <div id="sbTarget" style=" min-height:20px; height:auto;width:100%; border-bottom:1px solid #EFEFEF; vertical-align:bottom; padding-top:10px; padding-left:3px; overflow:auto;">
            
            </div>
            <div id="tcTarget" style="padding:0px;  height:440px; overflow:auto;">
            
            </div>
            
        </div>
    	<cfset session.framework_loaded="1">
        <cfoutput>
            <cfif #session.pwdiff# GE 30>
                <script language="javascript">
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
                    handleAppResize();
					loadSiteStats();
                </script>

            </cfif>
            <cfif IsDefined("url.event_redir")>
            	
				<script language="javascript">
				
					#url.event_redir#
				</script>
			</cfif>                					
        </cfoutput>
    </body>
</html>
