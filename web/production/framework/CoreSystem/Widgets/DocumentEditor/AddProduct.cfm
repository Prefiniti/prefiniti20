<cfquery name="gP" datasource="#Session.DB_Core#">
	SELECT ProductName, id FROM product_catalog WHERE site_id=#URL.SiteID#
</cfquery>
    
<div class="__PREFINITI_APPLICATION" style="width:100%; height:100%;">
	<div style="padding:30px;">
    	<h1>Insert Product</h1>
        
        <p>Please select a product from the list below to insert a link into your document.</p>
        
        <select size="10" name="IProducts" id="IProducts" style="width:100%;"> 
        	<cfoutput query="gP">
            	<option value="#id#">#ProductName#</option>
			</cfoutput>                
        </select>	
        <center>
        	<cfoutput>
            <input type="button" class="normalButton" value="Insert Product" onclick="FromHandle('#URL.TAN#').InsertProductLink(GetValue('IProducts'));">
            </cfoutput>
        </center>
    </div>
</div>