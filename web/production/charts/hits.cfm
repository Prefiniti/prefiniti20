<!--
<wwafcomponent>Page Hits</wwafcomponent>
-->

<cfquery name="hitsD" datasource="#session.DB_Core#">
	SELECT 
    	count(hit_ip) as daily_hits,
		count(distinct hit_ip) as distinct_daily_hits,
		
		hit_date
	FROM 
		hits
    WHERE
    	hit_ip != '216.243.116.130'
	GROUP BY DATE(hit_date)
</cfquery>
<cfquery name="hit_details" datasource="#session.DB_Core#">
	SELECT * FROM hits ORDER BY hit_date DESC
</cfquery>    

<cfquery name="ip" datasource="#session.DB_Core#">
	select count(distinct hit_ip) as c, count(hit_ip) as ttl from hits
</cfquery>    

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Page Hits</h3>
    </div>
</div>
<br />
<br />

<ul>
	<li><cfoutput>#ip.c# distinct IP addresses</cfoutput></li>
    <li><cfoutput>#ip.ttl# total hits</cfoutput></li>    
</ul>    

<div align="center" style="margin-top:30px;">
<cfchart xAxisTitle="Date" yAxisTitle="Page Hits" chartwidth="650" chartheight="380" show3d="no" showlegend="yes" >

   <cfchartseries 
      type="line"
      query="hitsD" 
      valueColumn="daily_hits" 
      itemColumn="hit_date"
	  seriescolor="##3399CC"
      serieslabel="Total Hits"
      />
      
      <cfchartseries 
      type="line"
      query="hitsD" 
      valueColumn="distinct_daily_hits" 
      itemColumn="hit_date"
	  seriescolor="##FF0000"
      serieslabel="Hits from Distinct Hosts"
      />

</cfchart>
</div>

<table width="100%">
	<cfoutput query="hit_details" startrow="1" maxrows="150">
		<tr>
        	<td>#DateFormat(hit_date, "dd mmm yyyy")#</td>
        	<td>#hit_ip#</td>
            <td>#hit_page#</td>
		</tr>            
    </cfoutput>
</table>	