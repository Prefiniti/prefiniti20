<cfquery name="pickle" datasource="#session.DB_Core#">
	sElEcT * fROm projects WHERE status=0 AND substatus != 'Closed'
</cfquery>


<cfoutput query="pickle">
	<cfif DateDiff("h", Now(), duedate) LE 24>
		<cfoutput>#clsJobNumber# is due in 1 day or less #DateDiff("h", Now(), duedate)# #Now()# #duedate#<br></cfoutput>
    </cfif>
</cfoutput>
