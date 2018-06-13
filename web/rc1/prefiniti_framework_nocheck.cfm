<link href="css/gecko.css" rel="stylesheet" type="text/css">

<div style="padding-left:30px;"  id="framework_status"></div>
<div style="padding-left:30px;" id="statTarget"></div>	

<div style="padding-left:20px;">
<table width="800">
	<tr>
    	<td style="padding:10px;" valign="top" width="240">
        	<div style="background-color:#EFEFEF; width:220px; height:400px; -moz-border-radius:5px; padding:5px;">
            	<h5>Business Benefits</h5>
                <blockquote>
        	    <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_advert_internet.cfm');">Internet word-of-mouth advertising</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_advert_local.cfm');">Local business advertising</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_customer_notifications.cfm');">Customer notifications</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_employee_notifications.cfm');">Employee notifications</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_filestorage.cfm');">Flexible file storage</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_map_2way.cfm');">Instant two-way mapping communication</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_mapping.cfm');">Mapping and driving directions</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_projects.cfm');">Automated project management</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_realtime_locations.cfm');">Real-time personnel locations</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_sched.cfm');">Project and departmental scheduling</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_sitemail.cfm');">Efficient built-in mail</a><br />
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/bus_timesheet.cfm');">Flexible timesheet processing</a>
            	</blockquote>
                <h5>Personal Benefits</h5>
                <blockquote>
                	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/help/help_text/per_convenient_access.cfm');">Convenient access to local businesses</a><br />
                </blockquote>
            </div>
		</td>
        
        <td valign="top" style="padding-top:10px;">
        	<div id="tcTarget">
            <embed wmode="transparent" src="Prefiniti.swf" width="578" height="378" allowscriptaccess="always"  />
            </div>
        </td>
	</tr>  
</table>                      
</div>
	
<cfoutput>
	<script language="javascript">
		
		<cfif IsDefined("url.contentBar")>
		loadContentBar('#URL.contentBar#');
		</cfif>
		if (glob_browser != "Microsoft Internet Explorer") {
			shiftOpacity('plogo', 6000);
		}	
	</script>
</cfoutput>    