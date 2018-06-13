<cfinclude template="/contentManager/cm_udf.cfm">

<cfparam name="userFiles" default="">
<cfset userFiles=cmsGetUserFiles(url.user_id)>

<cfquery name="pls" datasource="#session.DB_CMS#">
	SELECT * FROM playlists WHERE user_id=#url.user_id# ORDER BY playlist_name
</cfquery>

<table width="100%" cellspacing="0">
<cfoutput query="userFiles">
	<tr>
	<cfif LCase(Right(filename, 3)) EQ "mp3">
    	<td style="background-color:black; font-size:xx-small; border-bottom:1px ridge silver;" nowrap>#Left(description,80)#</td>
        <td style="background-color:black; font-size:xx-small; border-bottom:1px ridge silver;" align="right" nowrap>
        	<img src="/graphics/control_play_blue.png" onclick="soundManager.destroySound('mySound'); soundManager.play('mySound','#cmsUserFileURL(id)#');" />
            <select size="1" name="choose_playlist#id#" id="choose_playlist#id#" style="font-size:xx-small;">
			<cfif pls.RecordCount GT 0>
				<cfoutput query="pls">
                    <option value="#id#">#playlist_name#</option>
                </cfoutput>
            <cfelse>
            	<option value="__no_create" selected>You have not created any playlists</option>
            </cfif>
            </select>
            
            <input type="button" onclick="alert('add to choose_playlist#id#');" value="Add"/>
        </td>
	</cfif>        
	</tr>
</cfoutput>
</table>
