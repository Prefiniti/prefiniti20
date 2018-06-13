<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<cfinclude template="/Framework/CoreSystem/Widgets/Thumbnails/Thumbnails_udf.cfm">

<cfdirectory directory="#session.InstanceRoot##Attributes.ImageFolder#" action="list" type="file" name="Images" sort="name ASC">
<cfparam name="FileExtension" default="">
<cfparam name="FileIcon" default="">
<cfparam name="FullFile" default="">
<cfparam name="BaseURL" default="">

<cfparam name="FldrImages" default="">
<cfset FldrImages = ArrayNew(1)>
<div style="display:none;">
<cfoutput query="Images">
	<cfset FullFile = Replace(Directory, "\", "/", "all") & "/" & Name>
    <cfset FileExtension = LCase(Right(Name, 3))>
    <cfif FileExtension NEQ "ini">
    
	<cfset FileIcon = "/Framework/StockResources/Icons/FileType/" & FileExtension & ".png">
    <cfset BaseURL = Mid(FullFile, 31 + Len(session.InstanceName), Len(FullFile) - (30 + Len(session.InstanceName)))>
              
    <cfif 	(FileExtension EQ "jpg") OR
            (FileExtension EQ "gif") OR
            (FileExtension EQ "png") OR
			(FileExtension EQ "bmp") OR
            (FileExtension EQ "tif")>
	
		#arrayAppend(FldrImages,  BaseURL)#                     
     
  	</cfif>
    </cfif>
</cfoutput>
</div>

<cfparam name="divid" default="">
<cfset divid = CreateUUID()>

<cfoutput>
<div id="ProductImage_#divid#">
	<img src="#Thumb(FldrImages[1], 220, 220)#">
</div>
</cfoutput>    


<cfparam name="ct" default="">
<cfset ct = 0>

<cfloop index="x" array="#FldrImages#">
	<cfset ct = ct + 1>
	<cfoutput><a href="####" onclick="LoadImageTo('ProductImage_#divid#', '#x#', 220, 220)">Image #ct#</a> |&nbsp;</cfoutput>
</cfloop>   