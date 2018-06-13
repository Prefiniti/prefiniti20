<cfinclude template="/billing/billing_udf.cfm">
<cfparam name="plan_id" default="">
<cfparam name="plan_info" default="">

<cfset plan_id = bGetSiteBillingPlanID(attributes.site_id)>
<cfset plan_info = bGetBillingPlan(plan_id)>

<div style="border:1px solid #EFEFEF; padding:5px; -moz-border-radius:5px; margin-left:20px; width:330px;">
	<cfoutput query="plan_info">
    <h4>#plan_name#</h4>
        <table width="100%">
            <tr>
                <td><strong>Base Price:</strong></td>
                <td>$#NumberFormat(base_rate, "0.00")#</td>
            </tr>
            <tr>
                <td><strong>Employees Included:</strong></td>
                <td>#max_employees#</td>
            </tr>
            <tr>
                <td><strong>Price Per Additional Employee:</strong></td>
                <td>$#NumberFormat(price_per_employee, "0.00")#</td>
            </tr>            
            <tr>        	
                <td><strong>Price Per Order:</strong></td>
                <td>$#NumberFormat(price_per_order, "0.00")#</td>
            </tr>
            <tr>
                <td><strong>GIS Access:</strong></td>
                <td>
                    <cfif gis_included EQ 1>
                        Included in plan
                    <cfelse>
                        $#NumberFormat(gis_price, "0.00")#
                    </cfif>
                </td>
            </tr>
        </table>                                                                                                           
    </cfoutput>
</div>