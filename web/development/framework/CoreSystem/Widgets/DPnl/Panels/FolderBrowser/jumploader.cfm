
<cfparam name="ulp" default="">
<cfset ulp = session.InstanceRoot & URL.DestinationPath>
<cfset ulp = URLEncodedFormat(ulp)>

<cfoutput>
<applet name="jumpLoaderApplet"
		code="jmaster.jumploader.app.JumpLoaderApplet.class"
		archive="/Framework/CoreSystem/jumploader_z.jar"
		width="640"
		height="480" 
		mayscript>
	<param name="uc_uploadUrl" value="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/ProcessUpload.cfm?DestinationPath=#ulp#&CreatorID=#URL.CreatorID#"/>
    <param name="ac_fireUploaderStatusChanged" value="true">
</applet>
</cfoutput>