<!--
<wwafcomponent>Friend Search Results</wwafcomponent>
-->
<cfinclude template="/socialnet/socialnet_udf.cfm">
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Friend Search Results</h3>
    </div>
</div>
<br />
<br />

<cfparam name="searchRes" default="">
<cfset searchRes=StructNew()>
<cfset searchRes=searchUsers('#url.search_field#', '#url.search_value#')>
<cfparam name="userDistance" default="">

<cfoutput><strong>#searchRes.RecordCount# users found where #url.search_field# contains '#url.search_value#'.</strong></cfoutput>



<cfoutput query="searchRes">
	<cftry>
		<cfinvoke returnvariable="userDistance" webservice="ZipDistance" method="getDistance" fromZip="#snUserZip(url.calledByUser)#" toZip="#snUserZip(id)#">
        <cfcatch type="any">
            <cfparam name="userDistance" default="0">
            <cfset userDistance="-1">
        </cfcatch>
    </cftry>
    <div style="padding:5px; margin:10px; background-color:##EFEFEF; -moz-border-radius:5px; width:200px; float:left;">
    	<table width="100%" cellspacing="0">
        	<tr>
            	<td width="50" rowspan="2" style="background-color:##EFEFEF">
        			<img src="#getPicture(searchRes.id)#" width="50" height="50" />  
                    <cfswitch expression="#online#">
					<cfcase value="0"><font color="red">User offline</font></cfcase>
					<cfcase value="1"><font color="green">User online</font></cfcase>
				</cfswitch>
                      		</td>
				<td align="right" valign="top">              
                    <strong><a href="javascript:viewProfile('#id#');">#longName#</a></strong><br>
                    #DateDiff("yyyy", birthday, Now())# years old<cfif userDistance NEQ -1> | #NumberFormat(userDistance, "_,___.__")# miles away</cfif>
                </td>
			</tr>
        	<tr>
        	  <td align="right" valign="bottom"><span id="frBlock_#id#"><a href="javascript:requestFriend(#id#);">Add Friend</a></span> | <a href="javascript:mailTo(#id#, '#longName#');">Send Message</a></td>
      	  </tr>
		</table>                                            
	</div>

</cfoutput>