<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfquery name="pv" datasource="#session.DB_Core#">
	SELECT DISTINCT source_id, source_age, target_age FROM profile_visits WHERE target_id=#attributes.user_id# AND visit_date=#CreateODBCDate(Now())#
</cfquery>

<div style="clear:both; width:500px; min-height:150px; overflow:auto;">
<cfoutput query="pv">
	<div style="padding:5px; margin:10px; background-color:##EFEFEF; -moz-border-radius:5px; width:200px; float:left;">
    	<table width="100%" cellspacing="0">
        	<tr>
            	<td width="50" rowspan="2" style="background-color:##EFEFEF">
        			<img src="#getPicture(source_id)#" width="50" height="50" />  
                    #getOnline(source_id)#
				
                      		</td>
				<td align="right" valign="top">              
                    <strong><a href="javascript:viewProfile(#source_id#);">#getLongname(source_id)#</a></strong><br>
                    #DateDiff("yyyy", getBirthday(source_id), Now())# years old<br>
                   <cfif source_age GE 18 AND target_age LT 18>
                   		<cfmodule template="/socialnet/components/minor_visits.cfm" source_id="#source_id#">
					</cfif>                        
                    
                    				</td>
			</tr>
        	<tr>
        	  <td align="right" valign="bottom">
              <a href="javascript:mailTo(#source_id#, '#longName#');">Send Message</a>
              </td>
      	  </tr>
		</table>
	</div>        
   
</cfoutput>   
</div>