<cffunction name="Thumb" returntype="string" output="no">
	<cfargument name="ResourcePath" required="yes" type="string">
	<cfargument name="Width" required="yes" type="numeric">
	<cfargument name="Height" required="yes" type="numeric">
	<cfargument name="Overlay" type="string" required="no">
    
    <cfparam name="ovl" default="">
    <cfset ovl = "">
    
    <cfif IsDefined("Overlay")>
    	<cfset ovl = Overlay>
        <cfimage source="#ExpandPath(Overlay)#" name="ImgOverlay">

    </cfif>
	
	<cfquery name="GetThumbs" datasource="#session.DB_Core#">
		SELECT id FROM thumbnails 
		WHERE 	ResourcePath='#ResourcePath#' 
		AND 	Width=#Width#
		AND		Height=#Height#
        <cfif IsDefined("Overlay")>
        	AND Overlay='#Overlay#'
        </cfif>
	</cfquery>
	
	<cfparam name="ret" default="">
	
	<cfif GetThumbs.RecordCount GT 0>			<!--- cache hit :) yay for low server load lolz --->
		<cfset ret =  "http://" & session.InstanceName & ".prefiniti.com/ThumbnailCache/" & GetThumbs.id & "." & Right(ResourcePath, 3)>
		<cfquery name="UpdateThumb" datasource="#session.DB_Core#">
			UPDATE thumbnails
			SET LastAccess=#CreateODBCDateTime(Now())#
			WHERE 	ResourcePath='#ResourcePath#' 
			AND 	Width=#Width#
			AND		Height=#Height#
            <cfif IsDefined("Overlay")>
        		AND Overlay='#Overlay#'
        	</cfif>
		</cfquery>
	<cfelse>  									<!--- cache miss :(  we'll have to resize and write the image!  not yay!!! --->
		<cfparam name="ImgPth" default="">
		<cfparam name="NewPth" default="">
		<cfparam name="NewThumbID" default="">
		
		<cfset NewThumbID = CreateUUID()>
		<cfset ImgPth = session.InstanceRoot & ResourcePath>
		<cfset NewPth = session.InstanceRoot & "/ThumbnailCache/" & NewThumbID & "." & Right(ResourcePath, 3)>
		<cfset NewURL = "http://" & session.InstanceName & ".prefiniti.com/ThumbnailCache/" & NewThumbID & "." & Right(ResourcePath, 3)>
	
    	<cftry>
		<cfimage source="#ImgPth#" name="NewThumb">
		
		<cfset ImageSetAntialiasing(NewThumb, "on")>
		<cfset ImageScaleToFit(NewThumb, Width, Height, "NEAREST")>
  	
    	<cfcatch type="any">
        </cfcatch>
        </cftry>
        
        <cfif IsDefined("Overlay")>
        	<cftry>
            <cfparam name="y" default="">
            <cfset y = ImageGetHeight(NewThumb) - ImageGetHeight(ImgOverlay)>
            <cfset ImagePaste(NewThumb, ImgOverlay, 0, y)>
            <cfcatch type="any">
            </cfcatch>
            </cftry>
        </cfif>
        
		<cfimage source="#NewThumb#" action="write" destination="#NewPth#" overwrite="true">
		
		<cfquery name="WriteThumb" datasource="#session.DB_Core#">
			INSERT INTO thumbnails
				(id,
				ResourcePath,
				Width,
				Height,
				LastAccess
                <cfif IsDefined("Overlay")>
        		 , Overlay
        		</cfif>
                )
			VALUES
				('#NewThumbID#',
				'#ResourcePath#',
				#Width#,
				#Height#,              
				#CreateODBCDateTime(Now())#
                <cfif IsDefined("Overlay")>
        			, '#Overlay#'
        		</cfif>
                )
		</cfquery>
		
		<cfset ret = NewURL>
	</cfif>
	
	<cfreturn #ret#>
</cffunction>