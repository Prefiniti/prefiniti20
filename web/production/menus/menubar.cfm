
<table width="100%" class="menuTable">
<tr>
<td align="left" class="menuTable" valign="middle" ><cfswitch expression="#session.usertype#">
            <cfcase value="0">
            <!---Customer Nav Links --->
            <div class="navBtn">
            	<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, custOrdersMenu, '150px')" onmouseout="delayhidemenu()">Orders</a>			</div>
                <div class="navBtn">
            	<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, custAcctMenu, '150px')" onmouseout="delayhidemenu()">Account</a>			</div>
                <div class="navBtn">
            	<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, mailMenu, '150px')" onmouseout="delayhidemenu()">Mail</a>			</div>
           
            </cfcase>
            <cfcase value="1">
            <!---Employee Nav Links --->
			<div class="navBtn">
            	<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, ordersMenu, '150px')" onmouseout="delayhidemenu()">Orders</a>			</div>
			<div class="navBtn">
				<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, projectsMenu, '150px')" onmouseout="delayhidemenu()">Projects</a>			</div>
            <div class="navBtn">
				<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, gisMenu, '150px')" onmouseout="delayhidemenu()">GIS</a>			</div>    
			<div class="navBtn">
				<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, schedulingMenu, '150px')" onmouseout="delayhidemenu()">Scheduling</a>			</div>
			<div class="navBtn">
				<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, timeMenu, '150px')" onmouseout="delayhidemenu()">Time Entry</a>			</div>
			<div class="navBtn">
				<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, accountsMenu, '150px')" onmouseout="delayhidemenu()">Accounts</a>			</div>
			<div class="navBtn">
				<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, reportsMenu, '150px')" onmouseout="delayhidemenu()">Reports</a>			</div>
			<div class="navBtn">
				<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, mailMenu, '150px')" onmouseout="delayhidemenu()">Mail</a>			</div>
			<div class="navBtn">
				<a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, toolsMenu, '150px')" onmouseout="delayhidemenu()">Tools</a>			</div>

			
            </cfcase>
          </cfswitch>        </td>
	</tr>
</table>