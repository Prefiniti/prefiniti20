<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="c" default="">
<cfset c = getComments(attributes.user_id)>

<cfif attributes.user_id EQ attributes.calledByUser>
	<cfoutput>#setCommentsRead(attributes.user_id)#</cfoutput>
</cfif>    

<div style="padding-left:30px;">
<cfif c.RecordCount EQ 0>
	<strong>No comments.</strong>
<cfelse>    
	<cfoutput><strong>#getLongName(attributes.user_id)# has #c.RecordCount# comments.</strong><br /></cfoutput>
    <cfmodule template="/controls/record_scroller.cfm" attributecollection="#attributes#" record_count="#c.RecordCount#" records_per_page="#attributes.records_per_page#" scroller_id="cms" loadpage="/socialnet/components/read_comments.cfm"> 
	<cfoutput query="c" startrow="#attributes.start_row#" maxrows="#attributes.records_per_page#">
    <div style="width:75%; margin-bottom:10px;">
    <table cellspacing="0" width="100%" cellpadding="0">
	
    	<tr>
        	<td rowspan="2" width="50" style="background-color:##EFEFEF; padding:8px; -moz-border-radius:5px;"><a href="javascript:viewProfile(#c.from_id#);"><img src="#getPicture(c.from_id)#" width="50" border="0" /></a><br />#getOnline(c.from_id)#</td>
            <td valign="top" style="margin-left:20px; border-top:1px solid ##EFEFEF;">
            	<div style="float:right; width:auto; background-color:##EFEFEF; padding:5px; -moz-border-radius-bottomleft:5px;">
				<img src="/graphics/AppIconResources/crystal_project/16x16/actions/mail_reply.png" onclick="snReplyComment(#c.id#);" onmouseover="Tip('Reply to this comment');" onmouseout="UnTip();" align="absmiddle">&nbsp;
				<img src="/graphics/AppIconResources/crystal_project/16x16/actions/mail_delete.png" onclick="alert('Under construction.');" onmouseover="Tip('Delete this comment');" onmouseout="UnTip();" align="absmiddle">
				<a href="javascript:viewProfile(#c.from_id#);"><strong>#getLongname(c.from_id)#</strong></a> - #DateFormat(c.sent_date, "mmmm dd, yyyy")# #TimeFormat(c.sent_date, "h:mm tt")# 
				
						
				</div>
            </td>
		</tr>
    	<tr>
    	  <td valign="bottom" style="padding-left:20px;">            	
          		<div style="width:100%; overflow:auto; ">	
                    <p style="width:300px;"><strong>#c.body#</strong></p>
                    
                </div>	
          </td>
  	  	</tr>			                            
    
    </table>
    </div>
    </cfoutput>
</cfif>    
</div>

