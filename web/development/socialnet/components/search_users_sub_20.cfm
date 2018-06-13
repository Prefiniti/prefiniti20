
<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfif Trim(URL.search_value) EQ "">
	<div style="margin:20px; padding:20px; background-color:#FFFFCC; text-align:center; border:1px solid black;">
	<p><strong style="color:red;"><img src="/graphics/error.png" align="absmiddle" /><br /><Br />Search Field Blank</strong></p>
	<p>Please <a href="##" onclick="LoadSearch();" style="color:blue; text-decoration:underline;">try your search again</a>. The &quot;Search For&quot; field cannot be empty.</p>
	</div>
	<cfabort>
</cfif>

<cfparam name="searchRes" default="">
<cfset searchRes=StructNew()>
<cfset searchRes=searchUsers('#url.search_field#', '#url.search_value#')>
<cfparam name="userDistance" default="">

<cfif searchRes.RecordCount EQ 0>
	<div style="margin:20px; padding:20px; background-color:#FFFFCC; text-align:center; border:1px solid black;">
	<p><strong style="color:red;"><img src="/graphics/information.png" align="absmiddle" /><br /><Br />No results found</strong></p>
	<p>Please <a href="##" onclick="LoadSearch();" style="color:blue; text-decoration:underline;">try your search again</a>. </p>
	</div>
<cfelse>	
<table class="ModTable" cellpadding="3" cellspacing="0" width="100%">
<tr>
	<th><img src="/graphics/photo.png" onmouseover="Tip('User Photo');" onmouseout="UnTip();" /></th>
	<th>Info</th>
<cfoutput query="searchRes">

<cfmodule template="/Framework/Controls/Dialog_HTML/UPComp/ViewOneFriend.cfm" UserID="#id#" CallingUser="#URL.CalledByUser#">
	<!---<cftry>
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
	</div>--->

</cfoutput>
</table>
</cfif>