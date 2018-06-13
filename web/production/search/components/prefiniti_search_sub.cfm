<style>
	.ComponentName
	{
		font-family:Verdana, Arial, Helvetica, sans-serif;
		color:#3399CC;
		font-size:medium;
		font-weight:bold;
		text-transform:capitalize;
				padding:0px;
		margin:0px;
	}
	.ResultsText
	{
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-weight:normal;
		color:#999999;
		padding:0px;
		margin:0px;
	}
	/*.SearchItems li
	{
		display:block; 
		float:left;
		min-width:200px;
		max-width:200px;
		list-style:none;
		
		
	}*/
</style>
<cfinclude template="/search/search_udf.cfm">

<cfparam name="component_name" default="">
<cfparam name="component_results" default="">
<cfset component_results = ArrayNew(1)>

<cfoutput>   
	<div style="width:95%; padding:5px; background-color:white; height:300px; overflow:auto;">
  <cfloop collection="#url#" item="i">
    <cfif Left(i, 3) EQ "com">
		<cfset component_name = Mid(i, 5, Len(i) - 4)>
        <cfset component_results = pfSiteSearch(component_name, url.search_terms, url.calledByUser)>
        
        <cfif ArrayLen(component_results) GT 0>
        	<p class="ComponentName">#LCase(component_name)#</p>
            <p class="ResultsText">#ArrayLen(component_results)# results</p>
        	<ul class="SearchItems">
            <cfloop from="1" to="#ArrayLen(component_results)#" index="j">
            	<li>#component_results[j]#</li>
            </cfloop>
            </ul>
        </cfif>
    <cfelse>
    
    </cfif>
  </cfloop>
  </div>
</cfoutput>