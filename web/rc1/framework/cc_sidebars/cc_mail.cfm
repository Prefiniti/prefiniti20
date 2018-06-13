<table width="100%">
	<tr>
    	<td><img src="/graphics/navicons/email.png" /></td>
        <td>
        	<h1>Prefiniti Mail</h1>
        
        	<p class="PLDescription">Allows you to read messages from and write messages to your friends and co-workers on the Prefiniti Network.</p>
        </td>
	</tr>
</table>
<script>
	fwRegisterAutoUpdate('/framework/cc_notifiers/nf_mail.cfm', 'ntf_mail');
	fwRegisterAutoUpdate('/framework/cc_notifiers/nf_mail_unread.cfm', 'recent_unread');
</script>

<blockquote>
<a href="javascript:writeMessage();">Write a new mail message</a><br />
<a href="javascript:viewMailFolder('inbox', 1);">View messages that have been sent to me</a><br />
<a href="javascript:viewMailFolder('sent messages', 1);">View messages I have sent</a>
</blockquote>
<div id="recent_unread">
	
</div>
