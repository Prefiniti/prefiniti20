<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfoutput>
<cfmail from="filesharing@#session.InstanceName#.prefiniti.com" to="#URL.emailaddress#" type="html" subject="#getFirstname(URL.calledbyuser)# wants to show you a file on Prefiniti.">
<h1>Prefiniti File Sharing</h1>

<p>#getLongname(URL.CalledByUser)# wanted you to see <a href="#URL.FullURL#" target="_blank">this file</a>.</p>

<p>If the link does not work, copy the entire following URL to your browser's address bar:</p>

<code>#URL.FullURL#</code>

<p style="font-size:6px;">Copyright &copy; 2009, AJL Intel-Properties LLC</p>
</cfmail>
File has been shared with #URL.emailaddress#.<br><br>
<em>If the recipient does not receive the message, ask them to add <a href="mailto:filesharing@#session.InstanceName#.prefiniti.com">filesharing@#session.InstanceName#.prefiniti.com</a> to their junk mail filtering software as a safe sender.</em>
</cfoutput>
