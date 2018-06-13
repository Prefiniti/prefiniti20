<cfinclude template="/scriptIncludes.cfm">
<!---<script type="text/javascript" src="/framework/framework.js"></script>

<script type="text/javascript" src="/mapping/mapping.js"></script>--->

<link href="/css/gecko.css" rel="stylesheet" />
<style>
	.projTabl td
	{
		background-color:#EFEFEF;
	}		
	.cellLabel
	{
		display:block;
		width:150px;
		float:left;
		clear:left;
	}
	.cellC
	{
		float:left;
		display:inline;
		clear:right;
	}	
</style>
<cfinclude template="/contentmanager/cm_udf.cfm">
<cfparam name="file_type" default="">
<cfparam name="file_url" default="">
<cfparam name="file_name" default="">
<cfparam name="file_path" default="">

<cfif url.mode EQ "user">
	<cfhttp url="#cmsUserFileURL(URLEncodedFormat(url.file_id))#">
<cfelse>
	<cfhttp url="#cmsSiteFileURL(URLEncodedFormat(url.file_id))#">
</cfif>       
<cfset file_type=cfhttp.MIMEType>
<cfif url.mode EQ "user">
	<cfset file_url=cmsUserFileURL(url.file_id)>
    <cfset file_name=cmsUserFileName(url.file_id)>
    <cfset file_path=cmsUserFilePath(url.file_id)>
<cfelse>
	<cfset file_url=cmsSiteFileURL(url.file_id)>
    <cfset file_name=cmsSiteFileName(url.file_id)>
    <cfset file_path=cmsSiteFilePath(url.file_id)>    
</cfif>    

<cfparam name="ft" default="">
<cfset ft=StructNew()>
<cfif url.mode EQ "user">
	<cfset ft="#cmsFileType(url.file_id, "user")#">
<cfelse>
	<cfset ft="#cmsFileType(url.file_id, "site")#">
</cfif>    
<cfoutput>
<div style="width:100%; background-image:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:200px;">
	<div style="float:left">
		<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> View File</h3>
	</div>
    
    <div style="clear:both;margin-left:50px; width:720px;">
        <div class="cellLabel"><strong>File Type:</strong></div>
        <div class="cellC"><img src="#ft.icon#" align="absmiddle" /> #ft.description#</div>
        <div class="cellLabel"><strong>File Name:</strong></div><div class="cellC">#file_name#</div>
        <div class="cellLabel"><strong>URL:</strong></div><div class="cellC"><a href="#file_url#">#file_url#</a></div>
        <div class="cellLabel">&nbsp;</div><div class="cellC" style="padding-top:10px;"><input type="button" class="normalButton" style="margin-left:0px;" onclick="window.open('#file_url#');" value="Download This File"></div>
    </div>
</div> 
</cfoutput>   
<hr style="border:1px solid #EFEFEF;" />
<div style="width:100%; background-color:#EFEFEF; padding:5px;">
	<img src="/graphics/zoom.png" align="absmiddle"> <strong style="color:black;">File Preview</strong>
</div>
<cfparam name="fileBaseName" default="">
<cfparam name="fileExtension" default="">

		
<cftry>	
<cfoutput>
<cfpdf source="#file_path#" pages="1" action="thumbnail" destination="D:\Inetpub\WebWareCL\PDFThumbs" format="jpg" overwrite="true" resolution="high" scale="100"> 
</cfoutput>
<cfset fileBaseName=Left(#file_name#, Len(#file_name#) - 4)>

<cfoutput><img src="/PDFThumbs/#fileBaseName#_page_1.jpg" /></cfoutput>
<cfcatch type="any">
<cfset fileExtension=right(#file_path#,3)>
    
<cfswitch expression="#UCase(fileExtension)#">
    <cfcase value="JPG">
        <cfoutput>
        <img src="#file_url#"/>
        </cfoutput>
    </cfcase>
    <cfcase value="GIF">
        <cfoutput>
        <img src="#file_url#"/>
        </cfoutput>
    </cfcase>
    <cfcase value="PNG">
        <cfoutput>
        <img src="#file_url#"/>
        </cfoutput>
    </cfcase>
    <cfcase value="ZIP">
    	<h3 class="subHead">ZIP Viewer</h3>
        
        <cfzip action="list" file="#file_path#" name="qFile"/>
        
        <table width="500px" cellspacing="0">
        <tr>
        	<th>Directory</th>
            <th>File Name</th>
        </tr>
		<cfoutput query="qFile">
            <tr>
                <td>#directory#</td>
                <td>#name#</td>
            </tr>
        </cfoutput>
        </table>
    </cfcase>
    <cfcase value="TXT">
        <h3 class="subHead">Text File Viewer</h3>
        <cfoutput>
            <cfparam name="ftext" default="">
            <cffile action="read" file="#cmsUserFilePath(url.file_id)#" variable="ftext">
            <p>#ftext#</p>
        </cfoutput>
    </cfcase>
    <cfcase value="PFN">
    
    	<h3 class="subHead">Field Notes</h3>
        
        <div id="fn_map_target" style="height:400px; width:100%;">
        
        </div>
        
        <script language="javascript">
			getMapNoMsg('fn_map_target');
		
		</script>
        
        <cfparam name="column_index" default="0">
        <cfparam name="point_name" default="">
        <cfparam name="latitude" default="">
        <cfparam name="longitude" default="">
        <cfparam name="elevation" default="">
        <cfparam name="tmp_str" default="">
        <cfparam name="current_character" default="">
        <cfparam name="column_array" default="">
        <cfset column_array=ArrayNew(1)>
        <cfset space_count=0>
        <cfloop file="#cmsUserFilePath(url.file_id)#" index="line">
            <cfset line="#line# ">
            <cfloop index="cChar" from="1" to="#Len(line)#">
            	<cfset current_character=Mid(line, cChar, 1)>
            	<cfif current_character EQ " ">
                	<cfset column_index = column_index + 1>	
                    <cfset column_array[column_index]=tmp_str>
                    <cfset tmp_str="">
				<cfelse>
                	<cfset tmp_str="#tmp_str##current_character#">
				</cfif>                    
            </cfloop>
            
			<cfoutput>
            	<cfset point_name=column_array[1]>
                <cfset latitude=column_array[2]>
                <cfset longitude=column_array[3]>
                <cfset elevation=column_array[4]>
                
                <script language="javascript">
					<!---function showLatLong(point_name, latitude, longitude, elevation) --->
					
					showLatLong('#point_name#', #latitude#, #longitude#, #elevation#);
				</script>
                
            	<!---<cfdump var="#column_array#">--->
            </cfoutput>
			<cfset column_array=ArrayNew(1)>
			<!---<cfoutput>#line#  (this line is #Len(line)# characters long with #space_count# spaces)</cfoutput><br /> --->
            <cfset column_index=0>
        </cfloop>
    </cfcase>
    <cfdefaultcase>
    	<cfif file_type EQ "text/html">
        	<cfoutput>#cfhttp.FileContent#</cfoutput>
        <cfelse>
	    	<strong>No preview available.</strong>
    	</cfif>
    </cfdefaultcase>
            
</cfswitch>		

</cfcatch>
</cftry>

<div id="soundmanager-debug" style="display:none;">
</div>
		

<link href="/css/gecko.css" rel="stylesheet" type="text/css" media="screen" />
<script>
	hideSplash();
</script>