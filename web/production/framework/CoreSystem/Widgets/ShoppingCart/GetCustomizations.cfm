<!--- attributes:
ProductName
ProductID
--->

<cfparam name="productFolder" default="">
<cfset productFolder = "D:/inetpub/PrefinitiInstances/us-production-r1g1s1/USA/NewMexico/LasCruces/Businesses/5 Brothers/Products/" & Attributes.ProductName>

<cfdirectory action="list" filter="*.sl" directory="#productFolder#" name="Lists">

<cfoutput>

<input type="hidden" id="PCUST_CT_#Attributes.ProductID#" name="PCUST_CT_#Attributes.ProductID#" value="#Lists.RecordCount#">
</cfoutput>

<cfparam name="pindex" default="0">
<cfset pindex = 1>

<cfoutput query="Lists">
	
    
  <cfmodule template="/Framework/CoreSystem/Widgets/ShoppingCart/SimpleList.cfm" Directory="#Directory#" File="#Name#" ProductID="#Attributes.ProductID#" ProductIndex="#pindex#">
  
  <cfset pindex = pindex + 1>
</cfoutput>