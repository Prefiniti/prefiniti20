<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<!---
	Attributes:
	
	File
	Directory
	ProductID
	ProductIndex

--->


<cfparam name="fp" default="">
<cfset fp = Attributes.Directory & "/" & Attributes.File>
<br>

<cfparam name="parsedFile" default="">
<cfset parsedFile = ParseFileName(Attributes.File)>

<cfoutput>#parsedFile.PrimaryName#:</cfoutput><br>
<select <cfoutput>name="PCUST_#Attributes.ProductID#_#Attributes.ProductIndex#" id="PCUST_#Attributes.ProductID#_#Attributes.ProductIndex#"</cfoutput>>
<cfloop file="#fp#" index="line">
	<cfoutput><option value="#line#">#line#</option></cfoutput>    
</cfloop>
</select>


