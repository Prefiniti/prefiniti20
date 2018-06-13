<div id="pageScriptContent" style="display:none">
// 
		/*alert("called");*/
        var glob_editor = new FCKeditor( 'background' ) ;
        glob_editor.BasePath = "/FCKeditor/" ;
        glob_editor.ToolbarSet = "Basic" ;
		glob_editor.ReplaceTextarea() ;
// 
</div>

<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfparam name="friends" default="">
<cfset friends=getFriends(url.calledByUser)>

<cfquery name="gbi" datasource="#session.DB_Core#">
	SELECT background, interests, music, relationship_status, so_id FROM Users WHERE id=#url.calledByUser#
</cfquery>    

<div class="homeHeader"><img src="/graphics/user.png" align="absmiddle" /> Background &amp; Interests</div>
<form name="updateBI" id="updateBI">
<cfoutput>
<input type="hidden" name="userid" id="userid" value="#url.calledByUser#" />
</cfoutput>
<div style="padding-left:20px;">
	<strong>Background</strong><br />
    <textarea name="background" id="background"><cfoutput>#gbi.background#</cfoutput></textarea>
    <br />
    <br />
    <strong>Interests</strong><br />
    <textarea name="interests" id="interests" cols="60" rows="8"><cfoutput>#gbi.interests#</cfoutput></textarea>
    <br />
    <br />
    <strong>Bands</strong><br />
    <textarea name="music" id="music"  cols="60" rows="8"><cfoutput>#gbi.music#</cfoutput></textarea>
    <br />
    <br />
    <strong>Relationship Status</strong><br />
    <select name="relationship_status" id="relationship_status">
    	<option value="No Answer" <cfif #gbi.relationship_status# EQ "No Answer">selected</cfif>>No Answer</option>
        <option value="Single" <cfif #gbi.relationship_status# EQ "Single">selected</cfif>>Single</option>
        <option value="In a Relationship" <cfif #gbi.relationship_status# EQ "In a Relationship">selected</cfif>>In a Relationship</option>
        <option value="In an Open Relationship" <cfif #gbi.relationship_status# EQ "In an Open Relationship">selected</cfif>>In an Open Relationship</option>
        <option value="Married" <cfif #gbi.relationship_status# EQ "Married">selected</cfif>>Married</option>
        <option value="Swinger" <cfif #gbi.relationship_status# EQ "Swinger">selected</cfif>>Swinger</option>
    </select><br /><br />
    <strong>Significant Other</strong><br />
    <cfoutput>
   
    <input type="hidden" name="so_id" id="so_id" value="#gbi.so_id#" /></cfoutput>
    <select name="so_ids" id="so_ids" onchange="SetValue('so_id', GetValue('so_ids'));">
    	<!---<cfif gbi.so_id EQ null>
        	<option value="">None</option> 
		</cfif>--->
    	<cfoutput query="friends">
        	<option value="#target_id#" <cfif #gbi.so_id# EQ #target_id#>selected</cfif>>#getLongname(target_id)#</option>
        </cfoutput>
    </select><br /><br />
    <input type="button" name="sub_bi" id="sub_bi" class="normalButton" value="Save Background and Interests" onclick="checkEditor(); AjaxSubmitForm(AjaxGetElementReference('updateBI'), '/socialnet/components/profile_manager/background_sub.cfm', 'userActionTarget');" />    
</div>
</form>