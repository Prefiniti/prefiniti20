<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="sn_friends" default="">
<cfset sn_friends=StructNew()>

<cfset sn_friends=getFriends(#attributes.user_id#)>


<div style="padding-left:30px;">
<cfif sn_friends.RecordCount EQ 0>
	<cfif attributes.calledByUser EQ attributes.user_id>
		<strong>You do not seem to have any friends yet.<br>
    	Search for friends <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/search_users.cfm');">here</a>.
	</strong>
    <cfelse>
    	<cfoutput>
	    	<strong>#getLongName(attributes.user_id)# does not seem to have any friends yet.</strong>
		</cfoutput>           
    </cfif>       
<cfelse>
	<cfoutput><strong>#getLongName(attributes.user_id)# has #sn_friends.RecordCount# friends.</strong></cfoutput>
    
    <cfmodule template="/controls/record_scroller.cfm" attributecollection="#attributes#" record_count="#sn_friends.RecordCount#" records_per_page="#attributes.records_per_page#" scroller_id="fl" loadpage="/socialnet/components/friends_list.cfm"> 
    
	<cfoutput query="sn_friends" startrow="#attributes.start_row#" maxrows="#attributes.records_per_page#">
    	<div style="padding:5px; margin:10px; background-color:##EFEFEF; -moz-border-radius:5px; width:200px; float:left;">
    	<table width="100%" cellspacing="0">
        	<tr>
            	<td width="50" rowspan="2" style="background-color:##EFEFEF">
        			<img src="#getPicture(sn_friends.target_id)#" width="50" height="50" />  
                    #getOnline(sn_friends.target_id)#
				
                      		</td>
				<td align="right" valign="top">              
                    <strong><a href="javascript:viewProfile(#sn_friends.target_id#);">#getLongname(sn_friends.target_id)#</a></strong><br>
                    #DateDiff("yyyy", getBirthday(sn_friends.target_id), Now())# years old<br>
                    Became friends on #DateFormat(sn_friends.request_date, "mm/dd/yyyy")#
                    
                    				</td>
			</tr>
        	<tr>
        	  <td align="right" valign="bottom">
              <a href="javascript:mailTo(#target_id#, '#longName#');">Send Message</a><cfif attributes.calledByUser EQ attributes.user_id> | <a href="javascript:confirmDeleteFriend(#attributes.calledByUser#, #target_id#);">Delete Friend</a></cfif></td>
      	  </tr>
		</table>                                            
        </div>
    </cfoutput>
    
</cfif>    
</div>