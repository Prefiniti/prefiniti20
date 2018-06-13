<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="mr" default="">
<cfparam name="rw" default="">

<cfif attributes.maxrows EQ 1>
	<style>
		.wwt td {
		background-color:#EFEFEF;
		}
	</style>
<cfelse>
	<style>
		.wwt td {
		background-color:white;
		}
	</style>	
</cfif>    

<cfquery name="gwg" datasource="#session.DB_Core#">
	SELECT * FROM webgrams WHERE dev_blog=0 ORDER BY post_date DESC
</cfquery>

<cfif attributes.maxrows EQ "">
	<cfset mr=gwg.RecordCount>
<cfelse>
	<cfset mr=attributes.maxrows>
</cfif>        

<cfif mr EQ 1>
	<cfset rw="370">
<cfelse>
	<cfset rw="100%">
</cfif>     

<cfif gwg.RecordCount EQ 0>
	<div style="padding-left:30px;"><strong>No WebGrams</strong></div>
<cfelse>
	<h3>Latest News</h3>
	<cfoutput query="gwg" maxrows="#mr#">
		<p style="font-size:12px; width:650px;">#w_body#</p>
    </cfoutput>
</cfif>    




