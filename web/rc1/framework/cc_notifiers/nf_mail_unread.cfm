<cfquery name="get_mail" datasource="#session.DB_Core#">
			SELECT 		messageInbox.id AS msgid, 
            			messageInbox.tbody, 
                    	messageInbox.tsubject, 
                    	messageInbox.tdate, 
                    	messageInbox.tread, 
                    	Users.id AS sender_id, 
                    	Users.username, 
                    	Users.firstName 
			FROM 		messageInbox 
            INNER JOIN 	Users 
            ON 			Users.id=messageInbox.fromuser 
            WHERE 		messageInbox.touser=#url.calledByUser# 
            AND 		messageInbox.deleted_inbox=0 
            AND			messageInbox.tread='no'
            ORDER BY 	messageInbox.tdate 
            DESC
</cfquery>		

<cfif get_mail.RecordCount NEQ 0>
	<h3>Recent Mail</h3>
    <table cellspacing="0">
    <tr>
    	<td style="background-color:#999999; font-weight:bold;">From</td>
        <td style="background-color:#999999; font-weight:bold;">Subject</td>
    </tr>
	<cfoutput query="get_mail" startrow="1" maxrows="5">
    	<tr>
        <td style="background-color:##999999; border-bottom:1px solid gray;">
        <a href="javascript:viewMessage(#msgid#)">#firstName#</a>
        </td>
        <td style="background-color:##999999; border-bottom:1px solid gray;">
        <a href="javascript:viewMessage(#msgid#)">#tsubject#</a>
        </td>
        </tr>
    </cfoutput>
    </table>
</cfif>

