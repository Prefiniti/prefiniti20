<!--
	<wwafcomponent>My Departments</wwafcomponent>
-->
<style type="text/css">
	.dList 
	{
		border-left:1px solid #EFEFEF;
		border-right:1px solid #EFEFEF;
		-moz-border-radius-topleft:5px;
		-moz-border-radius-topright:5px;
	}
	
	.dList th
	{
		text-align:left;
		background-color:#EFEFEF;
		color:#3399CC;
		font-weight:bold;
		background-image:none;
	}
	
	.dList td
	{
		border-bottom:1px solid #EFEFEF;
	}
	
</style>

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
    <div style="float:left">
        <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> My Departments</h3>
    </div>
</div>
<br />
<br />

<div style="padding-left:20px;">
<table width="600">
	<tr>
    <td valign="top">
	<div style="background-color:#EFEFEF; padding:5px; width:200px; margin-left:0px; margin-right:20px; -moz-border-radius:5px;">
        <strong style="color:#3399CC;">Roles Legend</strong><br /><br />
        
        <img src="/graphics/user_suit.png" align="absmiddle" /> Department/Team Manager<br />
        <img src="/graphics/user_red.png" align="absmiddle"  /> Department/Team Member
    </div>
    </td>
	<td valign="top">
		<cfmodule template="/businessnet/components/view_departments.cfm" site_id="#url.current_site_id#" user_id="#url.calledByUser#" assoc_id="#url.current_association#">
	</td>
	</tr>            
</table>    
</div>
