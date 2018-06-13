
<style type="text/css">
	.pList 
	{
		border-left:1px solid #EFEFEF;
		border-right:1px solid #EFEFEF;
		-moz-border-radius-topleft:5px;
		-moz-border-radius-topright:5px;
	}
	
	.pList th
	{
		text-align:left;
		background-color:#EFEFEF;
		color:#3399CC;
		font-weight:bold;
		background-image:none;
	}
	
	.pList td
	{
		border-bottom:1px solid #EFEFEF;
	}
</style>


<cfinclude template="/billing/billing_udf.cfm">

<cfparam name="stmt" default="">
<cfset stmt=bGetStatement(attributes.site_id)>

<div class="homeHeader"><img src="/graphics/table.png" align="absmiddle"> Billing Detail</div>

<div style="padding-left:20px;">
<table width="450" cellspacing="0" class="pList">
	<tr>
    	<th style="-moz-border-radius-topleft:5px;">Date</th>
        <th>Activity</th>
    	<th style="-moz-border-radius-topright:5px;">Price</th>
    </tr>    
	<cfoutput query="stmt">
		<tr>
        	<td>#DateFormat(event_date, "m/dd")#</td>
            <td>#event_type#</td>
            <td>
            	#NumberFormat(bGetEventPrice(attributes.site_id, event_type), "$0.00")#
            </td>
		</tr>            
	</cfoutput>
    <tr>
    	<td colspan="3">
        	
        </td>
    </tr>
</table>
</div>
