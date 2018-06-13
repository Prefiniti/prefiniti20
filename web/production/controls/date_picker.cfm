<cfparam name="sd_month" default="">
<cfparam name="sd_day" default="">
<cfparam name="sd_year" default="">

<cfset sd_month=DateFormat(attributes.startdate, "m")>
<cfset sd_day=DateFormat(attributes.startdate, "d")>
<cfset sd_year=DateFormat(attributes.startdate, "yyyy")>



<cfoutput>
	<input type="hidden" name="#attributes.ctlname#" id="#attributes.ctlname#" value="#attributes.startdate#">
    
    <select name="#attributes.ctlname#_month" id="#attributes.ctlname#_month" size="1" onchange="dp_copy('#attributes.ctlname#');">
  		<option value="1" <cfif sd_month EQ 1>selected</cfif>>January</option>
        <option value="2" <cfif sd_month EQ 2>selected</cfif>>February</option>
        <option value="3" <cfif sd_month EQ 3>selected</cfif>>March</option>
        <option value="4" <cfif sd_month EQ 4>selected</cfif>>April</option>
        <option value="5" <cfif sd_month EQ 5>selected</cfif>>May</option>
        <option value="6" <cfif sd_month EQ 6>selected</cfif>>June</option>
        <option value="7" <cfif sd_month EQ 7>selected</cfif>>July</option>
        <option value="8" <cfif sd_month EQ 8>selected</cfif>>August</option>
        <option value="9" <cfif sd_month EQ 9>selected</cfif>>September</option>
        <option value="10" <cfif sd_month EQ 10>selected</cfif>>October</option>
        <option value="11" <cfif sd_month EQ 11>selected</cfif>>November</option>
        <option value="12" <cfif sd_month EQ 12>selected</cfif>>December</option>  
    </select>
	<select name="#attributes.ctlname#_day" id="#attributes.ctlname#_day" size="1" onchange="dp_copy('#attributes.ctlname#');">
    	<cfloop from="1" to="31" index="i">
        	<option value="#i#" <cfif i EQ sd_day>selected</cfif>>#i#</option>
        </cfloop>
	</select>
    <select name="#attributes.ctlname#_year" id="#attributes.ctlname#_year" size="1" onchange="dp_copy('#attributes.ctlname#');">
    	<cfloop from="1900" to="2010" index="i">
        	<option value="#i#" <cfif i EQ sd_year>selected</cfif>>#i#</option>
        </cfloop>
	</select>
</cfoutput>            