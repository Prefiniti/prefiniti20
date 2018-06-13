<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="apps" default="">
<cfset apps = pfGetApplications()>


<div class="PDMCommonDialog" style="width:540px; height:auto;">
	<h1><cfoutput><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/64x64/apps/ark.png" align="absmiddle"></cfoutput>Applications Manager</h1>

	<div style="height:400px; overflow:auto; width:530px; margin-left:10px;">
	<cfoutput query="apps">
    	<div style="border-bottom:1px solid gray; width:455px; padding-top:8px;">
    	<table width="450">
        	<tr>
            	<td><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/apps/#AppIcon#" /></td>
                <td>
                	<h2>#AppName#</h2>
                    
                    <p>#AppDescription#</p>
                    
                    <p><strong>Developer:</strong> #Developer#</p>
                </td>
            </tr>
            <tr>
            	<td>&nbsp;</td>
                <td align="right">
                	<cfif pfIsApplicationInstalled(id, URL.current_association) EQ true>
                    	<cfif GlobalLoad EQ 0>
                        	<input class="normalButton" type="button" value="Remove" onclick="PRemoveApplication(#id#);"/>
						<cfelse>
                        	<strong style="color:red; font-weight:lighter; font-size:xx-small;">This application cannot be removed.</strong>
                        </cfif>                            
                    <cfelse>
                        <input class="normalButton" type="button" value="Install" onclick="PInstallApplication(#id#);"/>
                    </cfif>
                </td>
			</tr>                
		</table>            
        </div>
    </cfoutput>
    </div>
</div>