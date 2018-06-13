<cfquery name="addRating" datasource="#session.DB_Sites#">
	INSERT INTO site_ratings
    	(user_id,
        site_id,
        rating_date,
        rating_value)
	VALUES
    	(#url.user_id#,
        #url.site_id#,
        #CreateODBCDateTime(Now())#,
        #url.rating_value#)
</cfquery>

<cfoutput><strong style="color:red;">Your rating of #url.rating_value# has been saved.</strong></cfoutput>