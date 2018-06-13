
<cfquery name="qryGetJobNumber" datasource="#session.datasource#">
SELECT * FROM projects WHERE id='#URL.jobid#'
</cfquery>
<cfquery name="qryGetJobFiles" datasource="#session.datasource#">
SELECT * FROM files WHERE projectID='#url.jobid#'
</cfquery>
<cfquery name="qryGetCustInf" datasource="#session.datasource#">
SELECT * FROM Users WHERE id='#url.custid#'
</cfquery>
<cfquery name="jc" datasource="#session.datasource#">
SELECT id FROM jobNotes WHERE jobid='#url.jobid#'
</cfquery>
<cfquery name="setViewed" datasource="#session.datasource#">
	UPDATE projects SET viewed=1 WHERE id='#URL.jobid#'
</cfquery>

<cfoutput>	



<table width="100%" align="center"> <!---project home table--->
        <tr>
          <th colspan="2" align="center" ><center><h1>DO NOT USE THIS FORM</h1><img src="../graphics/printer.png" align="absmiddle"/><a href="viewJob.cfm?jobid=#url.jobid#" target="_blank" style="color:white">Printable Order</a> | <img src="../graphics/note.png" align="absmiddle"/><a href="../jobNotes.cfm?jobid=#url.jobid#&amp;custid=#url.custid#" style="color:white">Job Notes (#jc.RecordCount# notes posted)</a> | <img src="../graphics/delete.png" align="absmiddle" /><a href="../deleteJobConfirm.cfm?jobid=#url.jobid#&amp;custid=#url.custid#" style="color:white">Delete Job</a><br /></center></th>
          </tr>
        

		
			<form name="editJob" action="../editJob_sub.cfm?jobid=#url.jobid#&amp;custid=#url.custid#" method="post">
			<tr>
          <td width="655" class="int">Customer's Job Number:</td>
            <td width="355" class="int"><input name="clientJobNumber" type="text" value="#qryGetJobNumber.clientJobNumber#" size="50" /></td>
            </tr>
          <tr>
            <td class="int">Job Type:</td>
            <td class="int"><input name="jobType" type="text" value="#qryGetJobNumber.jobType#" size="50" /></td>
          </tr>
          <tr>
            <td class="int">Address:</td>
            <td class="int"><input name="address" type="text" value="#qryGetJobNumber.address#" size="50" /></td>
          </tr>
          <tr>
            <td class="int">Due Date:</td>
            <td class="int"><input name="duedate" id="duedate" type="text" value="#DateFormat(qryGetJobNumber.duedate, 'mm/dd/yyyy')#" size="50" readonly /> <a href="javascript:dueDateCal.popup();"><img src="../graphics/date.png" border="0" /></a></td>
          </tr>
          <tr>
            <td class="int">Subdivision:</td>
            <td class="int"><input name="subdivision" type="text" value="#qryGetJobNumber.subdivision#" size="50" /></td>
          </tr>
          <tr>
            <td class="int">Lot:</td>
            <td class="int"><input name="lot" type="text" value="#qryGetJobNumber.lot#" size="50"/></td>
          </tr>
          <tr>
            <td class="int">Block:</td>
            <td class="int"><input name="block" type="text" value="#qryGetJobNumber.block#" size="50" /></td>
          </tr>
          <tr>
            <td class="int">Section:</td>
            <td class="int"><input name="section" type="text" value="#qryGetJobNumber.section#" size="50" /></td>
          </tr>
          <tr>
            <td class="int">Township:</td>
            <td class="int"><input name="township" type="text" value="#qryGetJobNumber.township#" size="50" />           </td>
          </tr>
          <tr>
            <td class="int">Range:</td>
            <td class="int"><input name="range" type="text" size="50" value="#qryGetJobNumber.range#" /></td>
          </tr>
		  <tr>
            <td class="int">Filing Information:
					<blockquote>
					<p>
						    <label>
						      <input type="radio" name="SubdivisionOrDeed" value="Subdivision" <cfif #qryGetJobNumber.SubdivisionOrDeed# EQ "Subdivision">checked</cfif> />
						      Subdivision</label>
						    <br />
						    <label>
						      <input type="radio" name="SubdivisionOrDeed" value="Deed" <cfif #qryGetJobNumber.SubdivisionOrDeed# EQ "Deed">checked</cfif> />
						      Deed</label>
						    <br />
				      </p>
					 <p>
				      <label>
				        <input type="radio" name="FilingType" value="Plat" <cfif #qryGetJobNumber.FilingType# EQ "Plat">checked</cfif>/>
				        Plat</label>
				      <br />
				      <label>
				        <input type="radio" name="FilingType" value="Cabinet"  <cfif #qryGetJobNumber.FilingType# EQ "Cabinet">checked</cfif>/>
				        Cabinet</label>
				      <br />
				      <label>
				        <input type="radio" name="FilingType" value="Book"  <cfif #qryGetJobNumber.FilingType# EQ "Book">checked</cfif>/>
				        Book</label>
				      <br />
			      </p>
				  </blockquote>			  </td>
            <td class="int"><input type="text" name="PlatCabinetBook" value="#qryGetJobNumber.PlatCabinetBook#"/>			</td>
          </tr>
		  <tr>
            <td class="int"> <blockquote><p><label>
						      <input type="radio" name="PageOrSlide" value="Page" <cfif #qryGetJobNumber.PageOrSlide# EQ "Page">checked</cfif>/>
						      Page</label>
						    <br />
						    <label>
						      <input type="radio" name="PageOrSlide" value="Slide" <cfif #qryGetJobNumber.PageOrSlide# EQ "Slide">checked</cfif>/>
						      Slide</label>
						    <br />
						    </p></blockquote></td>
            <td class="int"><input type="text" name="PageSlide" value="#qryGetJobNumber.PageSlide#" /></td>
          </tr>
		  <tr>
            <td class="int">Reception Number:</td>
            <td class="int"><input type="text" name="ReceptionNumber" size="50" value="#qryGetJobNumber.ReceptionNumber#" /></td>
          </tr>
		 
		  <tr>
            <td class="int">Filing Date:</td>
            <td class="int"><input type="text" name="FilingDate" id="filingdate" size="50" value="#DateFormat(qryGetJobNumber.FilingDate, 'mm/dd/yyyy')#"  /> <a href="javascript:filingDateCal.popup();"><img src="../graphics/date.png" border="0" /></a></td>
          </tr>
		   <tr>
            <td class="int">Certified To:</td>
            <td class="int"><input type="text" name="CertifiedTo" size="50" value="#qryGetJobNumber.CertifiedTo#" /></td>
          </tr>
		  <tr>
            <td class="int">Other Job Information:</td>
            <td class="int"><input name="specialinstructions" value="#qryGetJobNumber.specialinstructions#" size="50" /></td>
          </tr>
		  <tr>
		  	<td class="int">&nbsp;</td>
			<td class="int" align="right"><input name="submit" value="Save Changes to Job" type="submit" class="normalButton" /></td>
			</tr>
			</form>
		  <form name="setJobStatus" action="../setjobstatus.cfm" method="post">
		  <input type="hidden" name="jobid" value="#qryGetJobNumber.id#" />
		  <input type="hidden" name="custid" value="#url.custid#" />
		  <tr>
		  	<td>Status:</td>
			<td>
			<table width="100%">
			<tr>
			<td valign="top">
			<p>
			  <label>
			    <input type="radio" name="JobStatus" value="0" <cfif #qryGetJobNumber.Status# EQ 0>checked</cfif> />
			    Incomplete</label>
			  <br />
			  <label>
			    <input type="radio" name="JobStatus" value="1" <cfif #qryGetJobNumber.Status# EQ 1>checked</cfif>/>
			    Complete</label>
			  <br />
			  </p>			  </td>
			  <td>
			    <p>
			      <label>
			        <input type="radio" name="SubStatus" value="Pending" <cfif #qryGetJobNumber.SubStatus# EQ "Pending">checked</cfif>/>
			        Pending</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Awarded" <cfif #qryGetJobNumber.SubStatus# EQ "Awarded">checked</cfif>/>
			        Awarded</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Not Awarded" <cfif #qryGetJobNumber.SubStatus# EQ "Not Awarded">checked</cfif>/>
			        Not Awarded</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="In Progress" <cfif #qryGetJobNumber.SubStatus# EQ "In Progress">checked</cfif>/>
			        In Progress</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Paid" <cfif #qryGetJobNumber.SubStatus# EQ "Paid">checked</cfif>/>
			        Paid</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Closed" <cfif #qryGetJobNumber.SubStatus# EQ "Closed">checked</cfif> />
			        Closed</label>
			      <br />
			      </p>
			  <div align="right"><input type="submit" class="normalButton" name="submit" value="Update Job Status" /></div>			  </td>
			  </tr>
			  </table>			  </td>
			</tr>
       	  </form>
		  <script language="javascript">
		  	var dueDateCal = new calendar2(document.forms['editJob'].elements['duedate']);
			var filingDateCal = new calendar2(document.forms['editJob'].elements['filingdate']);
		  </script>
</table> 

<!---End of project home table--->
</cfoutput>
  
  <table width="100%" border="0"  align="center">
    <tr>
      <th colspan="4"><cfoutput>Manage Project Files for #qryGetJobNumber.description# (CLS Job Number:
          <cfif #qryGetJobNumber.clsJobNumber# NEQ "">
            #qryGetJobNumber.clsJobNumber#
            <cfelse>
            No job number assigned
          </cfif>
          )</cfoutput></th>
    </tr>
    <tr>
      <th class="subHead">File Description</th>
      <th class="subHead">File Type</th>
      <th class="subHead">Uploaded On</th>
      <th class="subHead">Actions</th>
    </tr>
    <cfoutput query="qryGetJobFiles">
      <tr>
        <td class="int"><a href="datastore/projectfiles/#filePath#">#longName#</a></td>
        <td class="int">#fileType#</td>
        <td class="int">#uploadDateTime#</td>
        <td class="int"><a href="../contentmanager.cfm?action=delete&amp;name=#filePath#&amp;jobid=#url.jobid#&amp;custid=#url.custid#">Delete</a></td>
      </tr>
    </cfoutput>
  </table>
  <cfif #qryGetJobFiles.RecordCount# EQ 0>
    <table width="100%" border="0" class="bodyTable" align="center">
      <tr>
        <td>No files have been added for this project.</td>
      </tr>
    </table>
  </cfif>
  <form action="../uploadfileaction.cfm" 
		enctype="multipart/form-data" 
		method="post">
    <cfoutput>
      <input type="hidden" name="uploadDateTime" value="#Now()#" />
      <input type="hidden" name="projectID" value="#url.jobid#" />
      <input type="hidden" name="clientID" value="#url.custid#" />
    </cfoutput>
    <table width="100%"  border="0" class="st" align="center">
      <tr>
        <th colspan="2" height="10">Upload Project Files</th>
      </tr>
      
      
      <tr>
        <td>File Type:</td>
        <td><p>
            <label>
            <input type="radio" name="fileType" value="INVOICE" />
            Invoice</label>
            <br />
            <label>
            <input type="radio" name="fileType" value="OTHER" />
            Other</label>
            <br />
            <label>
            <input type="radio" name="fileType" value="PLAT" checked/>
            Plat</label>
            <br />
          </p></td>
      <tr>
        <td class="int">File Description:</td>
        <td class="int"><input type="text" name="longName" width="400"/></td>
      </tr>
      <tr>
        <td class="int" width="399" height="10"  align="left" valign="bottom">File:</td>
        <td class="int" width="385" align="left" valign="bottom"><input type="file" name="FiletoUpload">
		<label><input type="checkbox" name="NotifyAccounting" />Notify accounting</label>
        </td>
      </tr>
      <tr>
        <td class="int" colspan="2" align="right" valign="bottom" height="10"><input type="submit" class="normalButton" value="Upload"><br />
		
        </td>
      </tr>
	  
    </table>
  </form>

