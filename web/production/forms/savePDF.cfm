<cfdocument format="pdf" filename="D:\Inetpub\WebWareCL\UserContent\#url.username#\project_files\#url.filename#">
	<link rel="stylesheet" href="/css/gecko.css">
	<cfoutput>#url.content#</cfoutput>
</cfdocument>

<cfquery name="postPDF" datasource="#session.DB_Core#">
	UPDATE Users SET newpdf=1 WHERE id=#url.user_id#
</cfquery>    

<cfquery name="pp2" datasource="#session.DB_Core#">
	INSERT INTO pdfs
    	(user_id,
        filename)
	VALUES
    	(#url.user_id#,
        '#url.filename#')
</cfquery>               