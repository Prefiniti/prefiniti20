<cfquery name="PostFavorite" datasource="#session.DB_Core#">
	INSERT INTO favorites(user_id,
    					url,
                        title,
						docked)
	VALUES		(#url.user_id#,
    			'#url.urlval#',
                '#url.title#',
				#url.docked#)                        
</cfquery>