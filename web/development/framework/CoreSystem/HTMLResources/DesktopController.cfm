<cfinclude template="/socialnet/socialnet_udf.cfm">


<div style="width:280px; height:48px; margin:4px; border:none;">
<cfoutput>	
    <table width="100%">
    	<tr>
        	<td style="background-color:transparent; width:32px;" valign="middle">
            	<img src="#Thumb(getPicture(URL.UserID), 32, 32)#" />
            </td>
            <td style="background-color:transparent;" valign="top">
            	<span style="color:white; font-size:14px;">#getLongName(URL.UserID)#</span>
            
            </td>
		</tr>
	</table>
</cfoutput>    
</div>                    