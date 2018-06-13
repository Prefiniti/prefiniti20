<cfparam name="ev_id" default="">
<cfparam name="ed_ct" default="0">

<cfoutput>   
  <cfloop collection="#url#" item="i">
    <cfif Left(i, 3) EQ "dse">
    	<cfset ev_id=Mid(i, 5, Len(i) - 4)>
        
        <cfif url[i] EQ true>
            <cfquery name="dev" datasource="#session.DB_Core#">
                DELETE FROM schedule_entries WHERE id=#ev_id#
            </cfquery>
            <cfset ed_ct=ed_ct+1>
       	</cfif>     
		                         
    </cfif>
    <!---<br />url name/value : #i# = #url[i]#--->
  </cfloop>
  
  <center>
  	<h1>Deleted #ed_ct# event(s).</h1>
    <br><br>
    
  </center>    
</cfoutput> 

<div id="pageScriptContent" style="display:none;">
	AjaxRefreshTarget();
</div>