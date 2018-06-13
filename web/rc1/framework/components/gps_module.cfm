<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="lastGPSPoll" default="">
<cfparam name="fixAge" default="">
<cfset lastGPSPoll = wwReadConfig(url.calledByUser, 'GPS:LAST_GGA_STREAM')>
<cfif lastGPSPoll NEQ "WW_NOT_CONFIGURED">
<cfset fixAge = DateDiff("s", CreateODBCDateTime(lastGPSPoll), Now())>
<cfelse>
<cfset fixAge = 3000000>
</cfif>
<span style="display:none;" id="m_stat">
    <cfoutput>
       #fixAge#
    </cfoutput>
</span>                

<style>
	.gpsTD td {
		background-color:black;
		opacity:0.70;
		color:white;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:x-small;
	}
	
	.gpsTD td {
		 background-image:url(/graphics/navicons/locations.png); 
		 background-attachment:fixed; 
		 background-position:top left; 
		 background-repeat:no-repeat;
	}		 
		 
</style>	

<div style="width:100%; text-align:left; background-color:black; background-image:url(/graphics/navicons/locations.png); background-attachment:fixed; background-position:center; background-repeat:no-repeat;">
<cfif (wwReadConfig(url.calledByUser, "GPS:FIX_TIME_UTC") NEQ "WW_NOT_CONFIGURED") AND (fixAge LE 30)>
	<strong style="font-weight:bold; color:green; font-size:small;">
    	<cfif wwReadConfig(url.calledByUser, "GPS:VENDOR") NEQ "WW_NOT_CONFIGURED">
        	<cfoutput>#wwReadConfig(url.calledByUser, "GPS:VENDOR")# GPS</cfoutput>
        <cfelse>
        	Generic GPS                
		</cfif>
    </strong>
    
    <cfoutput>
    <table style="margin-left:5px;" width="200" class="gpsTD" cellspacing="0">
    	<tr>
        	<td>Latitude:</td>
            <td><span id="current_latitude">#NumberFormat(wwReadConfig(url.calledByUser, "GPS:LATITUDE"), "00.000000")#</span></td>
        </tr>
        <tr>
        	<td>Longitude:</td>
            <td><span id="current_longitude">#NumberFormat(wwReadConfig(url.calledByUser, "GPS:LONGITUDE"), "000.000000")#</span></td>
        </tr>
        <tr>
        	<td>Elevation:</td>
            <td>#Int(Val(wwReadConfig(url.calledByUser, "GPS:ELEVATION")) / 0.3048)# feet</td>
        </tr>
        <tr>
        	<td>Speed:</td>
            <td>
            	<span id="current_speed">
            	<cfparam name="speed" default="">
                <cfset speed=Val(wwReadConfig(url.calledByUser, "GPS:GROUND_SPEED")) * 1.15077945>#Int(speed)#
                </span>
            </td>
        </tr>
        <tr>
        	<td>Satellites:</td>
            <td>#Val(wwReadConfig(url.calledByUser, "GPS:SATELLITES_TRACKED"))#</td>
        </tr>
        <tr>
        	<td>Horiz. Dilution:</td>
            <td>#wwReadConfig(url.calledByUser, "GPS:HORIZONTAL_DILUTION")#</td>
        </tr>
        <tr>
        	<td>Fix Quality:</td>
            <td>
            	<cfswitch expression="#wwReadConfig(url.calledByUser, 'GPS:FIX_QUALITY')#">
                	<cfcase value="0">Invalid Fix</cfcase>
                    <cfcase value="1">GPS fix (SPS)</cfcase>
                    <cfcase value="2">DGPS fix</cfcase>
                    <cfcase value="3">PPS fix</cfcase>
                    <cfcase value="4">Real-time kinematic</cfcase>
                    <cfcase value="5">Float RTK</cfcase>
                    <cfcase value="6">Estimated (dead reckoning)</cfcase>
                    <cfcase value="7">Manual input</cfcase>
                    <cfcase value="8">Simulation</cfcase>
                </cfswitch>
            </td>
        </tr>
        <tr>
        	<td>Last Fix Time:</td>
            <td>
            	<cfparam name="utc_time" default="">
                <cfparam name="udate" default="">
                
                <cfset utc_time = Int(Val(wwReadConfig(url.calledByUser, 'GPS:FIX_TIME_UTC'))).ToString()>
            	
                <cfif fixAge GT 0>
					<cfoutput>#fixAge# seconds ago</cfoutput>
    			<cfelse>
                	<strong style="color:green;">Current</strong>
                </cfif>            
				<cftry>
				<cfset udate = CreateDateTime(2008, 10, 7, left(utc_time, 2), mid(utc_time, 3, 2), right(utc_time, 2))>
                
                <cfset udate = DateConvert("utc2Local", udate)>
                
                
                <!---#TimeFormat(udate, "h:mm tt")#--->
            	<cfcatch type="any">
                </cfcatch>
                </cftry>

            </td>
        </tr>
  
    </table>
    </cfoutput>
        
<cfelse>
	<strong style="font-weight:bold; color:red;">No GPS devices connected.</strong>
</cfif>
</div>
