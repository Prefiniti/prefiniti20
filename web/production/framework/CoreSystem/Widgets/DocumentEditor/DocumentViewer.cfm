<cfparam name="fp" default="">
<cfset fp = Session.InstanceRoot & URL.Path & "/" & URL.FileName>

<cffile action="read" file="#fp#" variable="theFile">

<div class="__PREFINITI_DOCUMENT">
<cfoutput>
#theFile#
</cfoutput>
</div>