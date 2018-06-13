<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="GChatContents" datasource="#session.DB_Core#">
	SELECT * FROM chat_entries WHERE (FromUser=#URL.FromUser# AND ToUser=#URL.ToUser#) OR (ToUser=#URL.FromUser# AND FromUser=#URL.ToUser#)  ORDER BY CTimeStamp
</cfquery>

<cfquery name="SetRead" datasource="#session.DB_Core#">
	UPDATE chat_entries SET PRead=1 WHERE (FromUser=#URL.FromUser# AND ToUser=#URL.ToUser#) OR (ToUser=#URL.FromUser# AND FromUser=#URL.ToUser#)
</cfquery>
<cfparam name="tb" default="">



<cfoutput query="GChatContents">
<cfset tb = Body>

<cfset tb = replace(tb, ':)', '<img src="/graphics/emoticon_smile.png" align="absmiddle" />', 'all')>
<cfset tb = replace(tb, ':D', '<img src="/graphics/emoticon_grin.png" align="absmiddle" />', 'all')>
<cfset tb = replace(tb, ':(', '<img src="/graphics/emoticon_unhappy.png" align="absmiddle" />', 'all')>
<cfset tb = replace(tb, ':P', '<img src="/graphics/emoticon_tongue.png" align="absmiddle" />', 'all')>
<cfset tb = replace(tb, ';)', '<img src="/graphics/emoticon_wink.png" align="absmiddle" />', 'all')>
<cfset tb = replace(tb, '>)', '<img src="/graphics/emoticon_evilgrin.png" align="absmiddle" />', 'all')>
<cfset tb = replace(tb, ':O', '<img src="/graphics/emoticon_surprised.png" align="absmiddle" />', 'all')>
<cfset tb = replace(tb, ':|', '<img src="/graphics/emoticon_waii.png" align="absmiddle" />', 'all')>
<cfset tb = replace(tb, '<3', '<img src="/graphics/heart.png" align="absmiddle" />', 'all')>
<cfset tb = replace(tb, '(pf)', '<img src="/graphics/pi-16x16.png" align="absmiddle" />', 'all')>
	<p><strong>#getLongname(FromUser)#:</strong> #tb#<br /></p>    
</cfoutput>    


    