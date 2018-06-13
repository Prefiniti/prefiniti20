<!---<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="MA_VIEW">--->
<cfinclude template="/mail/mail_udf.cfm">


<style type="text/css">
pre {
 white-space: pre-wrap;       /* css-3 */
 white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
 white-space: -pre-wrap;      /* Opera 4-6 */
 white-space: -o-pre-wrap;    /* Opera 7 */
 word-wrap: break-word;       /* Internet Explorer 5.5+ */
}
</style>
<cfquery name="m" datasource="#session.DB_Core#">
	SELECT messageInbox.id AS msgid, messageInbox.readReceipt, messageInbox.tread, messageInbox.touser, messageInbox.tsubject, messageInbox.tdate, messageInbox.tbody, messageInbox.refJobID, messageInbox.fromuser, Users.longName FROM messageInbox INNER JOIN Users ON Users.id=messageInbox.fromuser WHERE messageInbox.id=#url.id#
</cfquery>

<cfif #m.readReceipt# EQ 1 AND #m.tread# EQ "no">
	<cfquery name="srr" datasource="#session.DB_Core#">
	INSERT INTO messageInbox 
		(fromuser,
		touser,
		tsubject,
		tbody,
		tdate,
		tread,
        req_id
		)
	VALUES
		(#m.touser#,
		#m.fromuser#,
		'Read Receipt - #m.tsubject#',
		'Your message was read on #DateFormat(Now(), "mm/dd/yyyy")# at #TimeFormat(Now(), "h:mm tt")#',
		#CreateODBCDateTime(Now())#,
		'no',
        '#CreateUUID()#'
		)		
	</cfquery>
</cfif>

<cfquery name="udread" datasource="#session.DB_Core#">
	UPDATE messageInbox SET tread='yes' WHERE id=#url.id#
</cfquery>

<cfparam name="attList" default="">
<cfset attList=mailGetAttachments(#m.msgid#)>

<cfoutput>
<!--
<wwafcomponent>View Message from #m.longName#</wwafcomponent>
<wwaficon>email_open.png</wwaficon>
-->
</cfoutput>
<style type="text/css">
	.mrt td {
		background-color:#EFEFEF;
	}		
</style>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> View Message</h3>
        </div>
    </div>
    <br />
    <br />

<div style="padding:30px;">
    <div style="padding-bottom:3px;">
        <span class="MailButton" style="margin-right:5px;">
            <img src="/graphics/email.png" align="absmiddle"> <a style="color:white;" href="javascript:viewMailFolder('inbox', 1)">Return to Inbox</a>
        </span>
        <span class="MailButton">
            <cfoutput>
            	<img src="/graphics/email_reply.png" align="absmiddle"> <a style="color:white;" href="javascript:replyMessage(#m.msgid#)">Reply</a>
			</cfoutput>                
        </span>
    </div>
    
	<div style="padding:0px; border:1px solid #EFEFEF">
	
 	<table width="100%" cellpadding="10" >
    <tr>
    <td valign="top" width="200">
    <div style="background-color:#EFEFEF; padding:5px; -moz-border-radius:5px;"> 
    <table width="100%" cellspacing="0" class="mrt">
        
        <tr>
            <td><strong>From:</strong></td>
            <td><cfoutput>#m.longName#</cfoutput></td>
        </tr>
        <tr>
            <td><strong>Subject:</strong></td>
            <td><cfoutput>#m.tsubject#</cfoutput></td>
        </tr>
        <tr>
            <td><strong>Sent:</strong></td>
            <td><cfoutput>#DateFormat(m.tdate, "mm/dd/yyyy")#</cfoutput></td>
        </tr>

        <tr>
        <td><strong>Ref. Job No.:</strong></td>
            <td>
            
            </td>
            
        </tr>
        <tr>
        	<td colspan="2" align="center" style="padding-top:20px;"><cfoutput><img src="#getPicture(m.fromUser)#" width="170" /></cfoutput></td>
		</tr>            
	</table>
    </div>
    </td>
    <td valign="top">
    			<cfif attList.RecordCount NEQ 0>
                	<strong>Attachments:</strong>
                	<cfoutput query="attList">
                    	<div style="padding:8px; border-bottom:1px solid ##EFEFEF;"><img src="/graphics/email_attach.png" align="absmiddle"/> <a href="javascript:cmsViewFile(#file_id#, 'user');">#cmsUserFileName(file_id)#</a></div>
                    </cfoutput>
				</cfif>                    
                <div class="tMsg" style="height:250px; overflow:auto; width:80%; border:1px solid #EFEFEF;">
                    <cfoutput>#m.tbody#</cfoutput>
                </div>
	</td>
    </tr>          
    </table>
   
    </div>
</div>    
