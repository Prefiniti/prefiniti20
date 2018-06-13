<cfinclude template="/socialnet/socialnet_udf.cfm">
<style>
	.PBStable td {
		color:black;
		background-color:white;
		font-weight:normal;
		border-bottom:1px solid #EFEFEF;
		font-size:xx-small;
	}
</style>	
<cfoutput>
<table width="100%" class="PBStable">
	<cfif NOT IsDefined("URL.GetHeaders")>
    <tr>
    	<td width="20px">#URL.tid#</td>
        <td width="30px">#URL.owner#</td>
        <td width="40px">
        	<div id="TaskStat_#URL.tid#">
			<cfif URL.enabled EQ "true">
            	<font color="orange">Wait</font>
			<cfelse>
            	<font color="red">Pause</font>
			</cfif>                       
            </div>         
        </td>
        <td width="50px">#URL.priority#</td>
        <td width="30px"><div id="TaskRC_#URL.tid#">#URL.rc#</div></td>
        <td width="40px"><div id="TaskPercent_#URL.tid#">?</div></td>
        <td width="40px">
			<cfif URL.owner EQ URL.calledByUser>
            	<img src="/graphics/control_pause.png" onclick="PTasks[#URL.tid#].Pause();" />
        		<img src="/graphics/control_play.png" onclick="PTasks[#URL.tid#].Resume();" />
            <cfelse>
				&nbsp
			</cfif>
        <td>#URL.taskname#</td>
	</tr>
    <cfelse>
    <tr>
    	<td width="20px"><strong>TID</strong></td>
        <td width="30px"><strong>Usr</strong></td>
        <td width="40px"><strong>Stat</strong></td>         
        <td width="50px"><strong>Wait</strong></td>
        <td width="30px"><strong>RunCt</strong></td>
        <td width="40px"><strong>RTE %</strong></td>
        <td width="40px"><strong>Ctl</strong></td>
        <td><strong>Name</strong></td>
	</tr>
    </cfif>
</table>
</cfoutput>                    