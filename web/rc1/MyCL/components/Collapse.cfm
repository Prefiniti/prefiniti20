<!---
	Collapse.cfm
	Expanding/Collapsing div widget
	
	John Willis
	Authored 3/9/2007

	Attributes:
		Name			The name of this box
		URL				URL of content to load inside of the box
		HeaderText		Header Text to display at the top of the box
		InitialState	Initial state of the box-"inline" or "none"
--->




<cfoutput>
	
	<img src="http://www.prefiniti.com/graphics/#attributes.SideImage#" align="absmiddle" onclick="dispatch(); SwapShown('#attributes.DivName#');" onmouseover="Tip('#attributes.HeaderText#');" onmouseout="UnTip();"/>
			
				<div id="#attributes.DivName#" style="display:none; z-index:2000;position:absolute; border:2px solid ##C0C0C0; background-color: ##EFEFEF; width:240px; left:80px; top:70px; ">
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                    <td align="left">
                    <h2>#Attributes.HeaderText#</h2>
                    </td>
                    <td align="right">
                    [<a href="##" onclick="hideDiv('#attributes.DivName#');">CLOSE</a>]
					
                    </td>
                    </tr>
                    </table>
                    <cfinclude template="#attributes.URL#">
				</div>
			
	


</cfoutput>