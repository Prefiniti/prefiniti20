<!--- 
	Attributes.HP_SessionKey
	
	
--->





<cfquery name="pcs" datasource="#session.DB_Core#">
	SELECT * FROM auth_tokens WHERE session_key='#Attributes.HP_SessionKey#'
</cfquery>


<cfif pcs.RecordCount EQ 0>
	<div style="width:100%; height:auto; padding:3px; background-color:black; color:white; border-bottom:1px solid black; font-size:8px;">
    	<img src="/graphics/cancel.png" align="absmiddle" /> <strong>This Prefiniti session is invalid or no longer exists. Please sign in again.</strong>
    </div>	
	<cfabort>
</cfif>

<cfif pcs.SessionState NEQ "%%ACTIV::">
	<div style="width:100%; height:auto; padding:3px; background-color:black; color:white; border-bottom:1px solid black; font-size:8px;">
    	<img src="/graphics/cancel.png" align="absmiddle" /> <strong>This Prefiniti session has been closed. Please sign in again.</strong>
    </div>
    <cfabort>
</cfif>

<div style="width:100%; height:auto; padding:3px; background-color:black; color:white; border-bottom:1px solid black; font-size:8px;">
   	<img src="/graphics/accept.png" align="absmiddle" /> <strong>Your Prefiniti session has been validated.</strong>
</div>

