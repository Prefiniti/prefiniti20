


<cfinclude template="/mail/mail_udf.cfm">
<cfquery name="mail" datasource="#session.DB_Core#">
	<cfswitch expression="#url.mailbox#">
		<cfcase value="inbox">
			SELECT 		messageInbox.id AS msgid, 
            			messageInbox.tbody, 
                    	messageInbox.tsubject, 
                    	messageInbox.tdate, 
                    	messageInbox.tread, 
                    	Users.id AS sender_id, 
                    	Users.username, 
                    	Users.longName 
			FROM 		messageInbox 
            INNER JOIN 	Users 
            ON 			Users.id=messageInbox.fromuser 
            WHERE 		messageInbox.touser=#url.userid# 
            AND 		messageInbox.deleted_inbox=0 
            ORDER BY 	messageInbox.tdate 
            DESC
		</cfcase>
		<cfcase value="sent messages">
			SELECT  	messageInbox.id AS msgid, 
            			messageInbox.tbody, 
                    	messageInbox.tsubject, 
                    	messageInbox.tdate, 
                    	messageInbox.tread, 
                        messageInbox.touser,
                    	Users.username, 
                    	Users.longName, 
                    	Users.id AS sender_id 
			FROM 		messageInbox 
            INNER JOIN 	Users 
            ON 			Users.id=messageInbox.fromuser 
            WHERE 		messageInbox.fromuser=#url.userid# 
            AND			messageInbox.deleted_outbox=0
            ORDER BY 	messageInbox.tread, 
            			messageInbox.tdate 
            DESC
		</cfcase>
	</cfswitch>	
	
</cfquery>

<style type="text/css">
	.mView th {
		background-image:none;
		background-color:#EFEFEF;
		color:#3399CC;
		text-align:left;
		font-weight:bold;
	}
	.mView td {
		padding-top:3px;
		padding-bottom:3px;
		border-bottom:1px solid #EFEFEF;
	}
</style>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfoutput>
<!--
<wwafcomponent>#url.mailbox#</wwafcomponent>
<wwaficon>email.png</wwaficon>
-->
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px; text-transform:capitalize;"><img src="/graphics/globe-compass-48x48.png" align="top"> My #url.mailbox#</h3>
        </div>
    </div>
    <div style="height:20px; clear:both; padding:5px; margin-top:-10px;">
    
	<img src="/graphics/email_add.png" align="absmiddle"> <a style="color:black;" href="javascript:writeMessage();">Write Message</a> <strong>|</strong> <img src="/graphics/folder_magnify.png" align="absmiddle" /> <a href="javascript:viewMailFolder('inbox', 1);">Inbox</a> <strong>|</strong> <img src="/graphics/folder_magnify.png" align="absmiddle" /> <a href="javascript:viewMailFolder('sent messages', 1);">Sent Messages</a>
    </div>
 
</cfoutput>

<cfoutput>

<div style="padding:30px;">
<div style="padding-bottom:3px;">

	<span style="color:black; font-weight:bold; padding-left:5px;">Messages #url.start_at#-<cfif url.start_at+9 GT mail.RecordCount>#mail.RecordCount#<cfelse>#url.start_at + 9#</cfif> of #mail.RecordCount# </span>
	<cfif url.start_at NEQ 1>
    	<a href="javascript:viewMailFolder('#url.mailbox#', #url.start_at - 10#);"><img src="/graphics/resultset_previous.png" border="0" align="absmiddle"/></a>
	</cfif> 
    <cfif NOT url.start_at GE mail.RecordCount-10>
    	<a href="javascript:viewMailFolder('#url.mailbox#', #url.start_at + 10#);"><img src="/graphics/resultset_next.png" border="0" align="absmiddle"/></a> 
    </cfif>
</div>
    
</cfoutput>



<div style="padding:0px; ">
<table width="100%" cellspacing="0" class="mView">
	<tr>
		<th style="text-align:left; -moz-border-radius-topleft:5px;">&nbsp;</th>
		<th style="text-align:left;">
        	<cfif url.mailbox EQ "inbox">
            	From
        	<cfelse>
            	To
			</cfif>                
        </th>
		<th style="text-align:left;">Date</th>
		<th style="text-align:left;">Subject</th>
        <th style="text-align:left; -moz-border-radius-topright:5px;">&nbsp;</th>
		
	</tr>
		<cfparam name="att" default="">
		<cfoutput query="mail" maxrows="10" startrow="#url.start_at#">
    		<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
        <cfset att=mailGetAttachments(msgid)>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="white">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
		<tr>
			<td style="background-color:#ColColor#; border-left:1px solid ##EFEFEF; padding-left:2px;">
                <a href="javascript:viewMessage(#msgid#)">
	                <cfif #tread# EQ "no">
                    	<cfif att.RecordCount EQ 0>
                        	<cfif #sender_id# EQ 743>
                            	<img src="/graphics/webware-16x16.png" border="0" />
                            <cfelse>    
								<img src="/graphics/email.png" border="0" />                
                            </cfif>
                        <cfelse>
                        	<img src="/graphics/email_attach.png" border="0" />
						</cfif>
                                                    
        			<cfelse>
                    	<cfif att.RecordCount EQ 0>
							<cfif #sender_id# EQ 743>
                            	<img src="/graphics/webware-16x16.png" border="0" />
                            <cfelse>    
								<img src="/graphics/email_open.png" border="0" />                
                            </cfif>                
                        <cfelse>
                        	<img src="/graphics/email_attach.png" border="0" />
						</cfif>
                    </cfif>
                </a>
            </td>
			<td style="background-color:#ColColor#">
            	<a href="javascript:viewMessage(#msgid#)">
            		<cfif url.mailbox EQ "sent messages">
                    	#getLongname(touser)#
                    <cfelse>
						<cfif #tread# EQ "no">
                            <strong>#longName#</strong>
                            
                        <cfelse>
                            #longName#
                        </cfif>
					</cfif>                                                
                                
                </a>
                
            </td>
			<td style="background-color:#ColColor#">#DateFormat(tdate, "mm/dd/yyyy")#</td>
			<td style="background-color:#ColColor#">#tsubject#<cfif #tread# EQ "no"></strong></cfif></td>
			<td style="background-color:#ColColor#; border-right:1px solid ##EFEFEF;" align="right">
            	<a href="javascript:mDeleteMessage('#URL.PWindowClientArea#', #msgid#, '#url.mailbox#');"><img src="/graphics/bin.png" border="0" align="absmiddle" /></a>
            </td>
		</tr>
        <cfif #tread# EQ "no">
        <tr>
        	<td colspan="5" style=" border-left:1px solid ##EFEFEF; border-right:1px solid ##EFEFEF;">
        	<div style="margin-left:20px; margin-bottom:0px; -moz-border-radius-bottomleft:5px; width:80%; color:blue; border:none;">
            	<strong style="color:##3399CC;"><a style="color:##3399CC;" href="##" onclick="showDiv('#msgid#_div'); showDiv('#msgid#_hidebtn');">Message Preview:</a></strong> 
                <div style="margin-left:20px;" id="#msgid#_div">
                #tbody#
                 
                </div>
                <span id="#msgid#_hidebtn"><a href="##" onclick="hideDiv('#msgid#_div'); hideDiv('#msgid#_hidebtn');">[Hide]</a></span>
			</div>
            </td>
		</tr>
        </cfif>            
	</cfoutput>
    <tr>
    <td style="color:red; border-left:1px solid #EFEFEF; border-right:1px solid #EFEFEF;" colspan="5"><strong>Note:</strong> Only messages with the <img src="/graphics/webware-16x16.png" border="0" /> icon are official Prefiniti communications. Prefiniti will never ask you for your password or other personal information.</td>
    </tr>
    
</table>
</div>
</div>

