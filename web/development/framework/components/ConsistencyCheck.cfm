<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="items" datasource="#session.DB_Core#">
	SELECT * FROM folder_items WHERE UserID=#URL.UserID#
</cfquery>

<cfparam name="fe" default="">
<cfparam name="errCount" default="">
<cfset errCount = 0>

<code>
Prefiniti Application Framework v2.0<br />
Consistency Checker<br /><br />
Running consistency check on objects for user ID <cfoutput>#URL.UserID#</cfoutput>...<br />

<cfoutput query="items">
	 
    
	<cfswitch expression="#ItemType#">
    	<cfcase value="SYSOBJ">
        	<cfset fe = pfObjectExists(ObjectTypeID, ObjectID)>
            
            <cfif fe>
            	
            <cfelse>
            	<cfset errCount = errCount + 1>
            	#ItemType# #id#:  ObjectName=#ItemName#, ContainingFolder=#ContainingFolder# REF -&gt; OBJECT ObjectTypeID=#ObjectTypeID#, InstanceID=#ObjectID# [ORPHANED]
                <cfif IsDefined("URL.Fix")>
                #pfDeleteObjectByID(id)# [FIXED]
                </cfif>
                <br />
			</cfif>                
            	
        </cfcase>
        <cfcase value="FOLDER">
        	<cfset fe = pfFolderExists(TargetFolderID)>
            
            <cfif fe>
            	
			<cfelse>
            	<cfset errCount = errCount + 1>
            	#ItemType# #id#:  ObjectName=#ItemName#, ContainingFolder=#ContainingFolder# REF -&gt; FOLDER #TargetFolderID# [ORPHANED]
                <cfif IsDefined("URL.Fix")>
                #pfDeleteObjectByID(id)# [FIXED]
                </cfif>
                <br />
            </cfif>
                            
        </cfcase>
    </cfswitch>
    
</cfoutput>

<cfoutput>
	<br />
	#items.RecordCount# objects checked<br />
    #errCount# errors found<br />
</cfoutput>

</code>