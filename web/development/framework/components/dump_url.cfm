<!--
	<wwafcomponent>Dump URL</wwafcomponent>
    <wwaficon>lorry.png</wwaficon>
    <wwafpackage>Development Tools</wwafpackage>
-->
<h3 class="stdHeader">Dump URL</h3>


<div style="padding-left:30px;">
	<table width="400">
    <tr>
    	<th>Variable</th>
        <th>Value</th>
	</tr>   
    <cfoutput>    
    <cfloop collection="#url#" item="ca">
	<tr>	
    	<td>#ca#</td>
        <td>#Evaluate("url.#ca#")#</td>
	</tr>
    </cfloop>
    </cfoutput>
    </table>        
</div>