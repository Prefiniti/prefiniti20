<!---
var url;
	url = '/Framework/Applications/NewsFeed/SetSubscription.cfm?feed_id=' + escape(feed_id);
	url += "&user_id=" + escape(user_id);
	url += "&method=" + escape(method);
	url += "&value=" + escape(value);
	
	
	<cffunction name="nfSubscribe" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="category_id" type="numeric" required="yes">
    <cfargument name="sub_type" type="numeric" required="yes">
	--->
	

<cfinclude template="/Framework/Applications/NewsFeed/NewsFeed_udf.cfm">



<cfoutput>
	<cfif URL.value EQ "true">
		#nfSubscribe(URL.user_id, URL.feed_id, URL.method)#
	<cfelse>
    	#nfUnsubscribe(URL.user_id, URL.feed_id, URL.method)#
	</cfif>        
</cfoutput>    


<cfdump var="#url#">
