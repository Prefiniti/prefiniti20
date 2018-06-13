<div class="PWelcomeScreen">
	<h1 style="color:white; font-size:36px; letter-spacing:normal;">Welcome.</h1>
    
    <span class="PTabButtonActive" id="tab_work"><a href="##" onclick="javascript:wsOpen('Work');">Work</a></span>
    <span class="PTabButtonInactive" id="tab_shop"><a href="##" onclick="javascript:wsOpen('Shop');">Shop</a></span>
    <span class="PTabButtonInactive" id="tab_socialize"><a href="##" onclick="javascript:wsOpen('Socialize');">Socialize</a></span>
    <cfoutput>
    <div class="PWSContentArea" id="CWork" style="display:block;">
    	<table width="550">
        	<tr>
            	<td valign="middle">
                	<h1>Manage</h1>
                	
                </td>
                
                <td align="right" valign="middle">
                	
                    	<a href="javascript:AjaxLoadPageToDiv('tcTarget',%20'/jobViews/priority.cfm'); p_session.Framework.PostLocalMessage('WelcomeScreen', IWC_REQUESTCLOSE, C_WINDOWMANAGER);">View priority projects</a><br />
                    	
                </td>
			</tr>
            <tr>
            	<td valign="middle">
                	<h1>Organize</h1>
                	
                </td>

                <td align="right" valign="middle">
                	
                    	<a href="javascript:loadTimesheetView('tcTarget',#url.calledByUser#,%20'1/1/1980',%20'1/1/2999',%20'Open',%20glob_isTCAdmin,%20''); p_session.Framework.PostLocalMessage('WelcomeScreen', IWC_REQUESTCLOSE, C_WINDOWMANAGER);">View my open timesheets</a><br />
                    	<a href="javascript:AjaxLoadPageToDiv('tcTarget',%20'tc/timesheet.cfm?action=add&userid=' + glob_userid); p_session.Framework.PostLocalMessage('WelcomeScreen', IWC_REQUESTCLOSE, C_WINDOWMANAGER);">Start a new timesheet</a><br />
                        <a href="javascript:AjaxLoadPageToDiv('tcTarget',%20'/scheduling/my_schedule.cfm?date=#DateFormat(Now(), 'mm/dd/yyyy')#'); p_session.Framework.PostLocalMessage('WelcomeScreen', IWC_REQUESTCLOSE, C_WINDOWMANAGER);">View my schedule</a>
                        
                        
                        
                        
                </td>
			</tr>
            <tr>
            	<td valign="middle">
                	<h1>Customize</h1>
            	</td>

             	<td align="right" valign="middle">
                <a href="javascript:AjaxLoadPageToDiv('tcTarget',%20'/authentication/components/maintenancePanel.cfm?section=site_information.cfm'); p_session.Framework.PostLocalMessage('WelcomeScreen', IWC_REQUESTCLOSE, C_WINDOWMANAGER);">Manage this site</a>
                </td>
             </tr>
		</table> 
        
                                   
    </div>
    
    <div class="PWSContentArea" id="CShop" style="display:none;">
    	<table width="550">
        	<tr>
            	<td><h1>Shop</h1></td>
                <td>&nbsp;</td>
			</tr>
		</table> 
    </div>
    </cfoutput>
    <div class="PWSContentArea" id="CSocialize" style="display:none;">
    	<table width="550">
        	<tr>
            	<td><h1>Connect</h1></td>
                <td><h1>&nbsp;</h1>
                <p><strong>These friends are online now:</strong></p>
               <cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="friends" default="">
<cfset friends=getFriends(#url.CalledByUser#)>

<cfoutput query="friends">
	<cfif getOnlineBool(target_id)>
    	<a href="javascript:viewProfile(#target_id#)"><img src="#getPicture(target_id)#" width="50" height="50" /></a>
	</cfif>
</cfoutput></td>
			</tr>
		</table> 
    </div>
    
</div>