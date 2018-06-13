<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfparam name="blogs" default="">
<cfset blogs = snGetBlogs(attributes.user_id)>

<div class="homeHeader"><img src="/graphics/note.png" align="absmiddle"/> Blogs</div>

<div style="padding-left:30px;">
	<cfif blogs.RecordCount GT 0>
		<cfoutput query="blogs" startrow="1" maxrows="5">
    		<cfif public EQ 1 OR attributes.calling_user EQ attributes.user_id>
            	<a href="javascript:snViewBlog(#id#);">#subject#</a> - #DateFormat(post_date, "m/dd/yyyy")# #TimeFormat(post_date, "h:mm tt")#<br />
            </cfif>
    	</cfoutput>
    	<cfif blogs.RecordCount GT 5>
        	<div id="hidden_blogs" style="display:none;">
        
        	</div>
        </cfif>
	<cfelse>
    	<strong>No blogs for this user.</strong>
	</cfif>
                    
        
</div>