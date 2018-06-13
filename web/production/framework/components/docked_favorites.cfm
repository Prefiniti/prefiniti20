<cfquery name="dFavs" datasource="#session.DB_Core#">
	SELECT id, url AS linkurl, title, docked FROM favorites WHERE user_id=#url.calledByUser# AND docked=1
</cfquery>

<cfif dFavs.RecordCount GT 0>
	<div style="width:100%; height:20px; ">
	
	<cfoutput query="dFavs">
		
		<div style="float:left; margin:2px; -moz-border-radius:5px; padding:3px; background-color:##EFEFEF; width:auto;"><cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="#title#" url="#linkurl#" help="#title#"></div>
	</cfoutput>
	</div>
</cfif>	