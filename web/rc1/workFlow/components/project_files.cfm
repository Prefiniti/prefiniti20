<cfinclude template="/contentmanager/cm_udf.cfm">

<style type="text/css">
	.dList 
	{
		padding-left:20px;
	}
	
	.dList th
	{
		text-align:left;
		background-color:#EFEFEF;
		color:#3399CC;
		font-weight:bold;
		background-image:none;
	}
	
	.dList td
	{
		border-bottom:1px solid #EFEFEF;
		padding:5px;
	}
	
</style>

<cfparam name="project_files" default="">
<cfset project_files=cmsGetProjectFiles(attributes.project_id)>
<cfparam name="view_data" default="">

<table width="100%" class="dList" cellspacing="0" cellpadding="0">
	<tr>
    	<th width="20">Scope</th>
        <th width="20">Type</th>
        <th>Description</th>
        <th>Posted By</th>
        <th>Post Date</th>
        
    </tr>    	
    
	<cfoutput query="project_files">
    <cfset view_data=cmsGetViewData(id, url.current_association)>
   	<cfif view_data.viewable> 
	<tr>
    	<td>	<!-- scope -->
			<cfif assoc_type EQ 0>
        		<img src="/graphics/user.png" />
            <cfelse>
            	<img src="/graphics/world.png" />
			</cfif>
		</td>
   
        <td>
        	<cfparam name="ft" default="">
            <cfif assoc_type EQ 0>
				<cfset ft=cmsFileType(project_files.file_id, "user")>
    		<cfelse>
            	<cfset ft=cmsFileType(project_files.file_id, "site")>
			</cfif>
                                    
            <img src="#ft.icon#" align="absmiddle" />
       	</td>
        <td>
        	#view_data.view_link#
            
		</td>
        <td>
        	#getLongname(view_data.poster_id)#
		</td>
        <td>
        	#DateFormat(view_data.post_date, "mm/dd/yyyy")#
        </td>
                                
	</tr>        	
    </cfif>
                                        
	</cfoutput>
    
    <!---<cfif releasable EQ 1>
		<cfif assoc_type EQ 0>		<!--- personal file --->
        <tr>
    		<td>
            	<cfif Right(UCase(cmsUserFileName(file_id)), 3) EQ "PFN">
					<!--- handle field notes --->
                    <img src="/graphics/page_white.png" align="absmiddle"> <a href="javascript:load_field_map(#file_id#, 0, GetValue('latitude'), GetValue('longitude'));">#description#</a>
				<cfelse>
                	#description#
				</cfif>                    
            
            </td>
            <td></td>
        </tr>
        <cfelse>					<!--- project staging area --->
        <tr>
        	<td>#description#</td>
        </tr>
        </cfif>
        </cfif>--->
</table>	