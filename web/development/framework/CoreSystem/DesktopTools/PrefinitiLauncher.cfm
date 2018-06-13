<cfinclude template="/framework/framework_udf.cfm"><head>
<link href="/css/gecko.css" rel="stylesheet" type="text/css" />
</head>

<div class="PrefinitiLauncherDiv" id="PrefinitiLauncher">
	
	
	
	
	
	  <table width="100%" border="0" cellspacing="0">
        <tr>
          <td valign="top"><h1>Prefiniti Launcher</h1>
          <cfinclude template="/framework/components/site_select.cfm">
          </td>
          <td>
              <div style="background-color:#333333; -moz-opacity:.90; -moz-border-radius:10px; padding:10px;">
				  <cfoutput>
                    #fwGetSidebarHeadingsEx(session.current_association)#<br>
                    <span class="PLauncherAppName" id="ApplicationName">Click an application above to launch.</span> 
                  </cfoutput>
              </div>
          </td>
        </tr>
        <tr>
          <td valign="bottom">
          <br>
          <br>
          <br>
          <br>
          <br>
          <cfoutput>
          	<a class="PLLargeLink" href="javascript:editUser(#session.userid#, 'basic_information.cfm');">Edit Profile</a><br> 
            <a class="PLLargeLink" href="javascript:viewProfile(#session.userid#);">View Profile</a><br />
            <a class="PLLargeLink" href="javascript:viewPictures(#session.userid#, true);">My Pictures</a><br>
		  </cfoutput>	
		  </td>
          <td>
          	<div class="PLInfoArea" id="PLInfoArea">
            	<h3>Welcome to Prefiniti Launcher</h3>
                
                
                	<p>The Prefiniti Launcher is a central location from which you can access the many features of Prefiniti. The Launcher bar (above) contains icons representing each major application.</p>
                    
                    <h4>To launch an application in Prefiniti:</h4>
                    
                    <ol>
                    	<li>Find the application's icon in the Launcher Bar (above)</li>
                        <li>Click the application icon. This will bring up a panel of common tasks for the application in question.</li>
                        <li>Click the task you wish to perform. Prefiniti will load that task and hide the launcher.</li>
                    </ol>
                    <p>Enjoy your stay on The Prefiniti Network!</p>
				
                                   
                    
                    
            </div>
            <div id="PLSearchLink">
            
            </div>
          </td>
        </tr>
      </table>
      <table width="100%">
      	<tr>
        	<td align="left">
            	<img src="/graphics/pi-16x16.png">
            </td>
            <td align="right">
      			<a href="javascript:p_session.LogOut();" ><img src="/graphics/AppIconResources/crystal_project/32x32/actions/shutdown.png" height="32" align="absmiddle" border="0"></a> <a href="javascript:p_session.LogOut();" style="color:white; font-size:medium; font-family:Verdana, Arial, Helvetica, sans-serif;">Sign out of Prefiniti</a>
			</td>                
      	</tr>
		</table>        
</div>
