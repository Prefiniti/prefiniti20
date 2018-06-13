<!--
	URL Parameters:
	
    TotalCatalogs		Numeric		number of catalogs to search
    SearchTerms			Text		what to look for
    SearchFullDocument	Boolean		search the full document if true
    SearchKeywords		Boolean		search keywords if true
    SearchTitle			Boolean		search document title if true	
    Cat_X				Boolean		where "X" is the catalog ID of the catalog to be searched;
    								there will be URL.TotalCatalogs of these.                                    

-->

<cfparam name="CatalogID" default="">
<cfparam name="CatQS" default="">
<cfparam name="FiltQS" default="">
<cfparam name="QS" default="">
<cfparam name="idx" default="">
<cfset idx = 1>
<cfset QS = "SELECT * FROM documents WHERE">

<cfparam name="CatsToSearch" default="">
<cfset CatsToSearch = 0>

   
<!-- build catalog query string -->
<cfloop collection="#url#" item="i">
    <cfif LCase(Left(i, 4)) EQ "cat_">
    	<cfif Evaluate(i) EQ true>
        	<cfset CatsToSearch = CatsToSearch + 1>
		</cfif>
	</cfif>
</cfloop>      

<cfif CatsToSearch LT 1>
	<strong>You must specify at least one catalog to search.</strong>
    <cfabort>
</cfif>      

<cfif URL.SearchTitle EQ false AND URL.SearchKeywords EQ false AND URL.SearchFullDocument EQ false>
	<strong>You must choose at least one of the following: Keywords, Title, Full Document.</strong>
    <cfabort>
</cfif>             

<cfset CatQS = "">
<cfloop collection="#url#" item="i">
    <cfif LCase(Left(i, 4)) EQ "cat_">
		<cfset CatalogID = Mid(i, 5, Len(i))>
        <cfif Evaluate(i) EQ true>
			<cfif idx NEQ CatsToSearch AND CatsToSearch GT 1>
                <cfset CatQS = "catalog_id=#CatalogID# OR #CatQS#">
            <cfelse>
            	<cfset CatQS = "#CatQS# catalog_id=#CatalogID# ">
            </cfif>
            <cfset idx = idx + 1>
        </cfif>      
	</cfif>
</cfloop>    		

<!-- build filter query string -->
<cfif url.SearchTitle EQ true>
	<cfset FiltQS = "doc_title LIKE '%#url.SearchTerms#%'">
</cfif>     
<cfif url.SearchTitle EQ true AND (url.SearchKeywords EQ true OR url.SearchFullDocument EQ true)>
	<cfset FiltQS = " #FiltQS# OR">
</cfif>        
<cfif url.SearchKeywords EQ true>
	<cfset FiltQS = " #FiltQS# keywords LIKE '%#url.SearchTerms#%'">
</cfif>
<cfif url.SearchKeywords EQ true AND url.SearchFullDocument EQ true>
	<cfset FiltQS = " #FiltQS# OR">
</cfif>
<cfif url.SearchFullDocument EQ true>
	<cfset FiltQS = " #FiltQS# doc_body LIKE '%#url.SearchTerms#%'">
</cfif>

<cfset FiltQS = Replace(FiltQS, "''", "'")>

<cfset QS="#QS# (#CatQS#) AND (#FiltQS#)">

<cfquery name="GetResults" datasource="#session.DB_Core#">
	#REReplace(QS,"''","'","ALL")#
</cfquery>

<cfif GetResults.RecordCount GT 0>
	<cfoutput><h2>#GetResults.RecordCount# documents found</h2></cfoutput>
	
    <cfoutput query="GetResults">
		<a style="font-size:small; color:##3399CC;" href="####" onclick="PViewDocument('#doc_id#'); hideDiv('helpSearch');">#doc_title#</a><br>
        <blockquote>
        	<strong>Keywords:</strong> #Replace(keywords, url.SearchTerms, "<strong>" & url.SearchTerms & "</strong>")#
        </blockquote>
    </cfoutput>
<cfelse>
	<h2>No matching documents found.</h2>
</cfif>	