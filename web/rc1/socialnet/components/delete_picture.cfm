<cfoutput>#URLDecode(url.full_path)#</cfoutput>
<cffile action="delete" file="#URLDecode(url.full_path)#">
