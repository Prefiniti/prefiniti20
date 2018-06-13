<div id="PNavigator" class="PNavigator">
					
					<div id="profilePicture">
					
						<cfoutput query="profile">
                        <table width="100%" cellspacing="0" style="background-color:##999999;">
                        <tr>
                        <td width="50" style="background-color:##CCCCCC;">
                        <span id="mainPic">
						<cfif #picture# EQ "">
                            <cfif #gender# EQ "M">
                                <img src="/graphics/genpicmale.png" width="50"  />
                                <cfelseif #gender# EQ "F">
                                <img src="/graphics/genpicfemale.png" width="50" >
                            <cfelse>
                                <img src="/graphics/genpicmale.png" width="50">
                            </cfif>
                        <cfelse>
                            <img src="#picture#" width="50" style="-moz-border-radius:5px;" >
                        </cfif>
                        </span>
                        </td>
                        <td valign="top" align="right" style="background-color:##CCCCCC;">
                        	<h3 style="font-size:medium; text-shadow:##EFEFEF; color:black; font-family:Tahoma; padding:0px; margin:0px;">#longName#</h3><a href="javascript:editUser(#session.userid#, 'basic_information.cfm');">Edit Profile</a> | <a href="javascript:viewProfile(#session.userid#);">View Profile</a><br />
                            <a href="javascript:viewPictures(#session.userid#, true);">My Pictures</a> | <a href="javascript:p_session.LogOut();" >Sign Out</a>
                           
                        </td>
                        
                        </tr>
                        </table>
                        <div id="soundmanager-debug" style="display:none;">
                        
                        </div>

                        <cfinclude template="/framework/components/command_center.cfm">
                       
                        </cfoutput>                   
                        
                        
                        </div>
                       
                    <div id="historyList" style="display:none; width:220px; overflow:hidden;" align="left">
                    
                    </div>
                    <div id="currentStats" align="left" style="clear:left; display:none;">
                    
                    </div>
                    
                    
                    
                    <div id="framework_status" style="font-size:6pt; padding-top:16px; display:none;" align="left"></div>
                    
                    <div id="statTarget" align="left" style="color:red; font-weight:bold; display:none;">
                    	
                    </div>
                    <div id="clock" style="background-color:#efefef; -moz-border-radius:5px; padding:0px; position:absolute; right:3px; top:9px; font-size:medium; font-weight:bold; color:#999999;"></div>
                    
</div>            