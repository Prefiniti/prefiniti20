<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/Framework/CoreSystem/Widgets/Thumbnails/Thumbnails_udf.cfm">

<cfoutput>
<tr>
	<td width="32">
	<img src="#Thumb(getPicture(Attributes.UserID), 32, 32)#" height="32" width="32" align="absmiddle" />
	</td>
	<td>
		<a href="####" onclick="SelectUser(#Attributes.UserID#, '#getLongname(Attributes.UserID)#');"><span style="font-size:medium;">#getLongname(Attributes.UserID)#</span></a><br />
		#GetOnline(Attributes.UserID)# | <cftry>#getAge(Attributes.UserID)# years old | <cfcatch type="any"></cfcatch></cftry>
		
		<cfif isFriend(Attributes.UserID, Attributes.CallingUser)> 
			<img src="/graphics/emoticon_smile.png" align="absmiddle" 
			onmouseover="Tip('I am friends with #getFirstName(Attributes.UserID)#.');" onmouseout="UnTip();"/> 	
		<cfelse>
			<img src="/graphics/emoticon_unhappy.png" align="absmiddle" 
			onmouseover="Tip('I am not friends with #getFirstName(Attributes.UserID)#.');" onmouseout="UnTip();"/>
			<img src="/graphics/user_add.png" align="absmiddle" onclick="requestFriend(#Attributes.UserID#);" onmouseover="Tip('Send a friend request to #getFirstName(Attributes.UserID)#');" onmouseout="UnTip();" />
		</cfif>
		
		<cfif isSO(Attributes.UserID, Attributes.CallingUser)>
			<img src="/graphics/heart.png" align="absmiddle" onmouseover="Tip('I am in a relationship with #getFirstName(Attributes.UserID)#.');" onmouseout="UnTip();" />
		</cfif>
		
		
		<cfif isFriend(Attributes.UserID, Attributes.CallingUser)>
			<img src="/graphics/layout.png" align="absmiddle" onmouseover="Tip('Click to view #getFirstName(Attributes.UserID)#\'s profile.');" onmouseout="UnTip();" onclick="viewProfile(#Attributes.UserID#);">
		</cfif>
		
		<img src="/graphics/email.png" align="absmiddle" onclick="mailTo(#Attributes.UserID#, '#getLongname(Attributes.UserID)#');" onmouseover="Tip('Send a message to #getFirstName(Attributes.UserID)#');" onmouseout="UnTip();" />
		
	</td>
</tr>
</cfoutput>