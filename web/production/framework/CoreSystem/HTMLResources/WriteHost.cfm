<cfquery name="WriteHost" datasource="#session.DB_Core#">
	UPDATE hosts
	SET		HostName='#URL.HostName#',
			HostDescription='#URL.HostDescription#',
			DefaultRunLevel=3,
			BootTimeout=10
	WHERE	HostKey='#URL.HostKey#'
</cfquery>
Update complete.