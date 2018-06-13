<!---

function POpenFriendChooser(UserID, 
							TargetCtl, 
							MultiSelect,
							ShowFriends,
							ShowCoworkers,
							ShowCustomers,
							BrowseOnly)

--->
<cfoutput>
<input type="text" id="#Attributes.CtlID#" name="#Attributes.CtlID#" value="[No user chosen]" readonly/> <input type="hidden" id="#Attributes.CtlID#_UID" name="#Attributes.CtlID#_UID" /> <input type="button" class="normalButton" value="#Attributes.ButtonCaption#" onclick="POpenFriendChooser(#Attributes.UserID#, '#Attributes.CtlID#', #Attributes.MultiSelect#, #Attributes.ShowFriends#, #Attributes.ShowCoworkers#, #Attributes.ShowCustomers#, #Attributes.ShowSearch#,  #Attributes.BrowseOnly#);" />
</cfoutput>