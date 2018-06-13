<h3 class="stdHeader">Upload Survey Map</h3>

<form name="uploadFile" action="/contentManager/components/surveyMapUploadSub.cfm" target="uploadStatusWindow" method="post" enctype="multipart/form-data">
<cfoutput>
	<input type="hidden" name="uploadDateTime" value="#Now()#" />
    <input type="hidden" name="projectID" value="0" />
    <input type="hidden" name="subdivisionID" value="#url.subdivisionID#">
</cfoutput>

<table cellspacing="0" width="100%">
	<tr>
    	<td>Subdivision:</td>
        <td><cfmodule template="/workflow/components/subdivisionNameByID.cfm" id="#url.subdivisionID#"></td>
    </tr>
	<tr>
    	<td>Choose File:</td>
        <td><input type="file" name="FiletoUpload"></td>
    </tr>
	<tr>
	  <td>Description:</td>
	  <td><input name="longName" type="text" id="longName" size="60"></td>
    </tr>
    <tr>
    	<td>Keywords:</td>
        <td><textarea name="keywords" cols="60" rows="6"></textarea></td>
    </tr>
    <tr>
    	<td colspan="2" align="right">
        	<input class="normalButton" type="button" onclick="doUpload();" value="Post Map">        </td>
    </tr>
</table>


</form>