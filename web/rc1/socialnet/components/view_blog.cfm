<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="blog" default="">
<cfset blog=snGetBlog(url.blog_id)>

<cfoutput>
<!--
	<wwafcomponent>View Blog</wwafcomponent>
-->


<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
    <div style="float:left">
        <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> #blog.subject#</h3>
    </div>
</div>
<br>
<br>
<table>
	<tr>
    	<td>
        	<div style="width:150px; background-color:##EFEFEF; -moz-border-radius:5px; padding:5px; margin:5px;">
				<img src="#getPicture(blog.user_id)#" width="150"  />
			</div>                            
        </td>
        <td>          
            <table width="100%">
                <tr>
                    <td><strong>Subject:</strong></td>
                    <td>#blog.subject#</td>
                </tr>
                <tr>
                    <td><strong>Date and Time:</strong></td>
                    <td>#DateFormat(blog.post_date, "m/dd/yyyy")# #TimeFormat(blog.post_date, "h:mm tt")#</td>
                </tr>                 
            </table> 
            
            <div style="padding:20px;">
                #blog.body_copy#
            </div>       
		</td>
	</tr>
</table>                        
    
</cfoutput>    

