<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfquery datasource="#session.DB_Core#" name="getItems">
	SELECT * FROM Users WHERE allowSearch=1
</cfquery>
<!--- make sure there are records available --->

<cfif getItems.recordCount>
 <!--- number of records you want to show --->
 <cfset showNum = 9>
 <!--- make sure we aren't trying to show
  more than what's in the DB --->
 <cfif showNum gt getItems.recordCount>
   <cfset showNum = getItems.recordCount>
 </cfif>
 <!--- make a list --->
 <cfset itemList = "">
 <cfloop from="1" to="#getItems.recordCount#" index="i">
   <cfset itemList = ListAppend(itemList, i)>
 </cfloop>
 <!--- randomize the list --->
 <cfset randomItems = "">
 <cfset itemCount = ListLen(itemList)>
 <cfloop from="1" to="#itemCount#" index="i">
   <cfset random = ListGetAt(itemList, RandRange(1, itemCount))>
   <cfset randomItems = ListAppend(randomItems, random)>
   <cfset itemList = ListDeleteAt(itemList, ListFind(itemList, random))>
   <cfset itemCount = ListLen(itemList)>
 </cfloop>
 <cfparam name="my_age" default="">
 <cfset my_age = getAge(url.calledByUser)>
 
 <cfparam name="user_id" default="">
 
 <!--- display stuff here --->
 <cfloop from="1" to="#showNum#" index="i">
   <cfoutput>
   	<cfset user_id=#getItems.id[ListGetAt(randomItems, i)]#>
	<cfif my_age GE 18>  <!--- only show adults to adults --->
		<cfif getAge(user_id) GE 18>	
		<div style="height:auto; float:left; width:55px; margin-right:2px; overflow:hidden;">
	
		<a href="javascript:viewProfile(#getItems.id[ListGetAt(randomItems, i)]#);"><img src="#getPicture(getItems.id[ListGetAt(randomItems, i)])#" width="50" height="50"></a><br>#getItems.firstName[ListGetAt(randomItems, i)]#
		
		</div>
		</cfif>
	<cfelse>			<!--- only show minors to minors --->
		<cfif getAge(user_id) LT 18>	
		<div style="height:auto; float:left; width:55px; margin-right:2px; overflow:hidden;">
	
		<a href="javascript:viewProfile(#getItems.id[ListGetAt(randomItems, i)]#);"><img src="#getPicture(getItems.id[ListGetAt(randomItems, i)])#" width="50" height="50"></a><br>#getItems.firstName[ListGetAt(randomItems, i)]#
		
		</div>
		</cfif>
	</cfif>		
   </cfoutput>
 </cfloop>
</cfif>