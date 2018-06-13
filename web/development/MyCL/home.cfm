<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>MyCL Home</title> 
<link href="../style/cls.css" rel="stylesheet" type="text/css" />
</head>

<body> 
	<div class="bodyWrapperM">
	
	  <table width="1000" border="0" height="500" cellpadding="0" cellspacing="0">
        <tr>
          <td width="25%" valign="top" style="background-color:#C0C0C0">
			
			<cfmodule template="components/Collapse.cfm" DivName="Jobs" HeaderText="My Jobs" URL="Jobs.cfm" InitialState="none" SideImage="date_go.png">
			<cfmodule template="components/Collapse.cfm" DivName="Search" HeaderText="Search" URL="Search.cfm" InitialState="none" SideImage="find.png">
			<cfmodule template="components/Collapse.cfm" DivName="Mail" HeaderText="Inbox" URL="Inbox.cfm" InitialState="none" SideImage="email_go.png">
		    <cfmodule template="components/Collapse.cfm" DivName="Accounts" HeaderText="Manage Accounts" URL="Accounts.cfm" InitialState="none" SideImage="group_edit.png">
			<cfmodule template="components/Collapse.cfm" DivName="Reports" HeaderText="Reports" URL="Reports.cfm" InitialState="none" SideImage="report.png">		  </td>
          <td width="75%" rowspan="2" valign="top" style="background-color:gray">
		    <div class="jobTab" id="btnDetail" style="margin-bottom:-1px">Detail</div>
			<div class="jobTab" id="btnFiles" style="border-bottom:solid 1px black;">Files</div>
			<div class="jobTab" id="btnNotes" style="border-bottom:solid 1px black;">Notes</div>
			<div class="jobTab" id="btnMap" style="border-bottom:solid 1px black;">Map</div>
			<div class="jobTab" id="btnCrew" style="border-bottom:solid 1px black;">Crew</div>
		  	<div id="frm" class="jobArea" >&nbsp;</div></td>
        </tr>
        <tr>
          	<td valign="bottom" style="background-color:#C0C0C0">
		  	<div class="OptionsBox">
		  		<div class="OptionBoxHeading">Options</div>
				<label class="SettingsCheckBox"><input type="checkbox" name="KeepTabsOpen" id="KeepTabsOpen" align="absmiddle"/> Keep sidebars open until I close them</label>
			</div>
			</td>
        </tr>
      </table>
	</div>
</body>
</html>
