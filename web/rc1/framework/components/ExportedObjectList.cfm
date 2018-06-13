<cfinclude template="/framework/framework_udf.cfm">
<cfparam name="st" default="">
<cfset st = ArrayNew(1)>
<cfset st = pfObjectList(attributes.ObjectTypeID, 724)>

<cfloop from="1" to="#ArrayLen(st)#" index="i"> 
	<cfoutput>
		#st[i].ID#: #st[i].Name#<br />
	</cfoutput>
</cfloop>            