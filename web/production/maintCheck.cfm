<cfif #session.logins_disabled# EQ 1>
	<cfif #session.site_maintainer# NEQ 1>
		<cfif #session.loggedin# EQ "yes">
		<cfset session.loggedin="no">
		<cfset session.message='Our site is currently undergoing maintenance. Please try again later.'>
		</cfif>
	</cfif>
</cfif>

<cfif #session.maintenance# EQ 1>
		<p style="clear:both; border:1px solid red; padding:3px;"><strong>Maintenance Warning:</strong> Our site is currently undergoing maintenance and/or development. Although we have not disabled your ability to sign in, some features may be unavailable, or may exhibit unusual and/or erratic behavior at this time.<br /><br /> We apologize for any inconvenience this may cause.</p>
</cfif>