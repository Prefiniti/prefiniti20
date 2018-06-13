<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="ObjectInfo" default="">
<cfset ObjectInfo = StructNew()>
<cfset ObjectInfo = pfObjectInformation(URL.ObjectID)>



<div class="PDMCommonDialog" style="width:760px; height:auto;">
	<table width="100%" cellspacing="0" cellpadding="0">
    	<tr>
        	<td><h1><cfoutput><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/48x48/#ObjectInfo.IconContext#/#ObjectInfo.Icon#" align="absmiddle"> My #ObjectInfo.Description#s</cfoutput></h1></td>
		</tr>
        <tr>
        	<td align="right" style="width:750px;">
            	<div style="background-color:#999999; width:100%; padding-right:5px; padding-top:3px; -moz-border-radius-topleft:5px; -moz-border-radius-topright:5px;">
				<cfoutput>
                <input type="hidden" id="PObjectView" value="VT_LIST" name="PObjectView" />
            	<img src="http://www.prefiniti.com/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/actions/window_new.png" onclick="PLegacyCreator(#URL.ObjectID#, '#LCase(ObjectInfo.Description)#');" onmouseover="Tip('Create a new #ObjectInfo.Description#');" onmouseout="UnTip();">
                <img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/view_icon.png" onclick="SetValue('PObjectView', 'VT_ICON'); PObjectGetList(#URL.ObjectID#, #URL.UserID#, 'PObjectList#URL.ObjectID#_#URL.CalledByUser#', GetValue('PObjectView'));" onmouseover="Tip('View as icons');" onmouseout="UnTip();"/>
            	<img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/view_detailed.png" onclick="SetValue('PObjectView', 'VT_LIST'); PObjectGetList(#URL.ObjectID#, #URL.UserID#, 'PObjectList#URL.ObjectID#_#URL.CalledByUser#', GetValue('PObjectView'));" onmouseover="Tip('View as list');" onmouseout="UnTip();"/>
                <img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/reload.png" onclick="PObjectGetList(#URL.ObjectID#, #URL.UserID#, 'PObjectList#URL.ObjectID#_#URL.CalledByUser#', GetValue('PObjectView'));" onmouseover="Tip('Refresh');" onmouseout="UnTip();"/>
        		
                </cfoutput>
                </div>
			</td>
		</tr>
        <tr>            
            <td align="right" style="background-color:#999999; width:750px;">
            	<cfoutput>
                	<div class="PItemBox" id="PObjectList#URL.ObjectID#_#URL.CalledByUser#" style="width:100%; height:350px; padding-right:5px;">
            
            		</div>
				</cfoutput>
			</td>                                    
		</tr>                            
                    
    </table>
</div>