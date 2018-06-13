<form name="uploadFile" action="/contentManager/components/fileUploadSub.cfm" target="uploadStatusWindow" method="post" enctype="multipart/form-data">
<cfoutput>
	<input type="hidden" name="uploadDateTime" value="#Now()#" />
    <input type="hidden" name="projectID" value="#url.id#" />
</cfoutput>
<table width="100%"  border="0" class="st" align="center">
      <tr>
        <td width="399">File Type:</td>
        <td width="385"><p>
            <label>
            <input type="radio" name="fileType" value="INVOICE" <cfif #url.permissionLevel# EQ 0>disabled</cfif> />
            Invoice</label>
            <br />
            <label>
            <input type="radio" name="fileType" value="OTHER" <cfif #url.permissionLevel# EQ 0>checked</cfif>  />
            Other</label>
            <br />
            <label>
            <input type="radio" name="fileType" value="PLAT" <cfif #url.permissionLevel# EQ 0>disabled<cfelse>checked</cfif>/>
            Plat</label>
            <br />
          </p></td>
      <tr>
        <td >File Description:</td>
        <td ><input type="text" name="longName" width="400"/></td>
      </tr>
      <tr>
        <td height="10" colspan="2"  align="left" valign="bottom" >Choose File:<br>
          <input type="file" name="FiletoUpload"><br>
		  <label><input type="checkbox" name="NotifyAccounting" <cfif #url.permissionLevel# EQ 0>disabled</cfif> />Notify accounting</label> <br />
		  <label><input type="checkbox" name="ReviewOnly" <cfif url.permissionLevel EQ 0>disabled</cfif>/>Requires surveyor approval</label>
		</td>
      </tr>
      <tr>
        <td  colspan="2" align="right" valign="bottom" height="10"><input type="button" class="normalButton" onclick="doUpload();" value="Upload"><br />        </td>
      </tr>
	  
    </table>
</form>