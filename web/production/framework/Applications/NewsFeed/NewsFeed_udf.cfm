<cfinclude template="/Framework/sms_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cffunction name="nfCreate" returntype="string">
	<cfargument name="feed_name" type="string" required="yes">
    <cfargument name="site_id" type="numeric" required="yes">
	
    <cfparam name="oi" default="">
    <cfset oi = CreateUUID()>
    
	<cfquery name="nfc" datasource="#session.DB_Sites#">
    	INSERT INTO news_categories
        	(category_name,
            site_id,
            om_uuid)
		VALUES
        	('#feed_name#',
            #site_id#,
            '#oi#')          
    </cfquery>
    
    <cfreturn #oi#>
</cffunction>

<cffunction name="nf" returntype="struct">
	<cfargument name="feed_id" type="numeric" required="yes">
    
    <cfparam name="nfinfo" default="">
    <cfset nfinfo = StructNew()>
    
    <cfquery name="gnf" datasource="#session.DB_Sites#">
    	SELECT * FROM news_categories WHERE id=#feed_id#
    </cfquery>
    
    <cfquery name="cs" datasource="#session.DB_Sites#">
    	SELECT COUNT(id) AS ct FROM news_subscriptions WHERE category_id=#feed_id#
    </cfquery>
    
    <cfset nfinfo.Name = gnf.category_name>
    <cfset nfinfo.Site = gnf.site_id>
    <cfset nfinfo.SiteName = getSiteNameByID(gnf.site_id)>
    <cfset nfinfo.Over21 = false>
    <cfset nfinfo.Subscribers = cs.ct>
    
    <cfreturn #nfinfo#>
</cffunction>    
    

<cffunction name="nfFeedsBySite" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="feedsBySite" datasource="#session.DB_Sites#">
    	SELECT * FROM news_categories WHERE site_id=#site_id# ORDER BY category_name
	</cfquery>
    
    <cfreturn #feedsBySite#>        
</cffunction>    

<cffunction name="nfFeedsBySubscriber" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="nffbs" datasource="#session.DB_Sites#">
    	SELECT category_id FROM news_subscriptions WHERE user_id=#user_id#
    </cfquery>
    
    <cfreturn #nffbs#>
</cffunction>

<cffunction name="nfPostsByFeed" returntype="query">
	<cfargument name="feed_id" type="numeric" required="yes">
    
    <cfquery name="getPostsByFeed" datasource="#session.DB_Sites#">
    	SELECT * FROM site_news WHERE news_category=#feed_id#
    </cfquery>
    
    <cfreturn #getPostsByFeed#>
</cffunction>

<cffunction name="nfPost" returntype="string">
	<cfargument name="news_category" type="numeric" required="yes">
    <cfargument name="event_headline" type="string" required="yes">
    <cfargument name="event_body" type="string" required="yes">
    <cfargument name="scheduled_event" type="numeric" required="no" default="0">

	<cfparam name="oi" default="">
    <cfset oi = CreateUUID()>
    
    <cfquery name="nfp" datasource="#session.DB_Sites#">
    	INSERT INTO site_news
        	(news_category,
            event_headline,
            event_body,
            post_date,
            scheduled_event,
            om_uuid)
		VALUES
        	(#news_category#,
            '#event_headline#',
            '#event_body#',
            #CreateODBCDateTime(Now())#,
            #scheduled_event#,
            '#oi#')                   
    </cfquery>
    
    <cfoutput>
    	#nfSendSubscriptions(oi)#
    </cfoutput>
    
    <cfreturn #oi#>
</cffunction>

<cffunction name="nfSendSubscriptions" returntype="void">
	<cfargument name="post_om_uuid" type="uuid" required="yes">
    
    <cfparam name="postData" default="">
    <cfset postData = StructNew()>
    <cfset postData = nfGetPost(post_om_uuid)>
    
    <cfparam name="feedData" default="">
    <cfset feedData = nf(postData.FeedID)>
    
    <cfquery name="getSubs" datasource="#session.DB_Sites#">
    	SELECT * FROM news_subscriptions WHERE category_id = #postData.FeedID#
	</cfquery>
    
    <cfoutput query="getSubs">
    	<cfswitch expression="#sub_type#">
        	<cfcase value="0"> <!--- PREFINITI MAIL --->
            
            </cfcase>
            <cfcase value="1"> <!--- SMS --->
            	
            	<cfparam name="postBody" default="">
                <cfparam name="smsRes" default="">
				<cfset postBody = feedData.SiteName & "-" & feedData.Name & ": " & postData.Headline & " " & postData.Body>
                <cfset smsRes = smsSend(getSubs.user_id, postBody)>
               
            </cfcase>
            <cfcase value="2"> <!--- Internet E-Mail --->
            
            </cfcase>
        </cfswitch>
    </cfoutput>        
</cffunction>    
    


<cffunction name="nfGetPost" returntype="struct">
	<cfargument name="om_uuid" type="uuid" required="yes">
    
    <cfquery name="nfgp_post" datasource="#session.DB_Sites#">
    	SELECT * FROM site_news WHERE om_uuid='#om_uuid#'
    </cfquery>
    
    <cfquery name="nfgp_feed" datasource="#session.DB_Sites#">
    	SELECT id, category_name, site_id FROM news_categories WHERE id=#nfgp_post.news_category#
	</cfquery>
    
	<cfparam name="os" default="">
    <cfset os = StructNew()>
    
    <cfset os.FeedID = nfgp_feed.id>
    <cfset os.FeedName = nfgp_feed.category_name>
	<cfset os.Headline = nfgp_post.event_headline>
	<cfset os.Body = nfgp_post.event_body>
	<cfset os.PostDate = nfgp_post.post_date>
	<cfset os.Poster = nfgp_feed.site_id>
    <cfset os.ScheduledEvent = nfgp_post.scheduled_event>
    
    <cfreturn #os#>
</cffunction>


<cffunction name="nfIsSubscribed" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="category_id" type="numeric" required="yes">
    <cfargument name="sub_type" type="numeric" required="yes">
    
    
    <cfquery name="nfis" datasource="#session.DB_Sites#">
    	SELECT id FROM 
        	news_subscriptions 
        WHERE 
        	user_id=#user_id# 
        AND
        	category_id=#category_id# 
		AND
        	sub_type=#sub_type#            
    </cfquery>
    
    <cfif nfis.RecordCount GT 0>
    	<cfreturn true>
    <cfelse>
    	<cfreturn false>
    </cfif>
</cffunction>

<cffunction name="nfSubscribe" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="category_id" type="numeric" required="yes">
    <cfargument name="sub_type" type="numeric" required="yes">
    
    <cfif NOT nfIsSubscribed(user_id, category_id, sub_type)>
    	<cfquery name="nfs" datasource="#session.DB_Sites#">
        	INSERT INTO news_subscriptions
            	(user_id,
                category_id,
                sub_type)
			VALUES
            	(#user_id#,
                #category_id#,
                #sub_type#)
		</cfquery>
        
        <cfparam name="fi" default="">
        <cfset fi = nf(category_id)>
        
        <cfparam name="notifyText" default="">
        <cfset notifyText = "You have subscribed to " & fi.SiteName & "-" & fi.Name & ". Please visit prefiniti.com if you wish to unsubscribe.">
        
        <cfparam name="sres" default="">
        <cfset sres = smsSend(user_id, notifyText)>
        
		<cfreturn true>
	<cfelse>
    	<cfreturn false>
	</cfif>                                                        
</cffunction>    
	
<cffunction name="nfUnsubscribe" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="category_id" type="numeric" required="yes">
    <cfargument name="sub_type" type="numeric" required="yes">
    
    <cfif nfIsSubscribed(user_id, category_id, sub_type)> 
    	<cfquery name="nfu" datasource="#session.DB_Sites#">
        	DELETE FROM news_subscriptions WHERE user_id=#user_id# AND category_id=#category_id# AND sub_type=#sub_type#
		</cfquery>
		 <cfparam name="fi" default="">
        <cfset fi = nf(category_id)>
        
        <cfparam name="notifyText" default="">
        <cfset notifyText = "You are unsubscribed from " & fi.SiteName & "-" & fi.Name & ".">
        
        <cfparam name="sres" default="">
        <cfset sres = smsSend(user_id, notifyText)>
        
        <cfreturn true>
	<cfelse>
    	<cfreturn false>
	</cfif>
   
</cffunction>