<cfquery name="upd" datasource="#session.DB_Core#">
	UPDATE Users SET newpdf=0 WHERE id=#url.calledByUser#
</cfquery>
    
<cfquery name="getPDFS" datasource="#session.DB_Core#">
	SELECT * FROM pdfs WHERE user_id=#url.calledByUser# ORDER BY filename
</cfquery>    


<h3 class="stdHeader">My PDF Files</h3>

<div style="padding-left:30px;">
<cfif getPDFS.RecordCount EQ 0>
	<strong>You do not have any PDF files.</strong>
<cfelse>
	<strong>You have <cfoutput>#getPDFS.RecordCount# PDF files.</cfoutput></strong>
	<div style="padding:10px;">
	<cfoutput query="getPDFS">
        <div style="border-bottom:1px solid ##EFEFEF; padding:3px;">
            <a href="http://www.prefiniti.com/UserContent/#url.userName#/project_files/#filename#" target="_blank">#filename#</a>
        </div>
    </cfoutput>
    </div>
</cfif>
</div>    
