<style type="text/css">
#dropmenudiv{
position:absolute;
border:1px solid silver;
-moz-opacity:.80;
border-bottom-width: 1;
	font-family: "Lucida Grande", Tahoma, Verdana, Arial, Helvetica, sans-serif;
	font-size: small;
	font-weight:lighter;
	color:#EFEFEF;
line-height:18px;
z-index:100;
padding:0px;
background-color:#EFEFEF;

}

#dropmenudiv a{
background-color:#EFEFEF;
width: 100%;
display:block;
vertical-align:middle;
text-indent: 3px;
clear:right;
padding-left:10px;
padding-right:3px;
padding-bottom:0px;
padding-top:4px;
text-decoration: none;
font-weight: lighter;
}

#dropmenudiv img {
	<cfif #session.browserType# NEQ "Microsoft Internet Explorer">
		display:block;
	<cfelse>
		display:none;
	</cfif>
	float:left;
	
	padding:3px 0;
	padding-top:3px;
	border-right:1px solid black;
	background-color:#C0C0C0;
	vertical-align:middle;
}

#dropmenudiv 
{ /*hover background color*/
background-color:#CCCCCC;
}

</style>
<cfinclude template="/menus/menu_udf.cfm">

<cfquery name="getMenus" datasource="#session.DB_Core#">
	SELECT * FROM menus
</cfquery>

<script type="text/javascript">
	//
	// Create the menu variables
	//
	<cfoutput query="getMenus">
		var #handle#=new Array();
		#handle#[0]='<img src="/graphics/exclamation.png"><a href="##">[No Items]</a>';
	</cfoutput>
</script>
<div id="ClassicMenus">
<table width="100%" class="menuTable">
	<tr>
		<td align="left" class="menuTable" valign="middle" >
			<cfoutput query="getMenus">
                <div class="navBtn">
                    <a href="default.htm"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, #handle#, '150px')" onmouseout="delayhidemenu()">#caption#</a>			
                </div>
                
				<!---
                #getMenuItems(id, handle)#
                --->				               
                
            </cfoutput>
		</td>
	</tr>
</table>               
</div>                     
                
<script type="text/javascript">

var menuwidth='185px' //default menu width
var menubgcolor='white'  //menu bgcolor
var disappeardelay=250  //menu disappear speed onMouseout (in miliseconds)
var hidemenu_onclick="yes" //hide menu when user clicks within menu?

/////No further editting needed

var ie4 = document.all;
var ns6 = document.getElementById && !document.all;

if (ie4 || ns6)
	document.write('<div id="dropmenudiv" style="visibility:hidden;width:'+menuwidth+';background-color:'+menubgcolor+'" onMouseover="clearhidemenu()" onMouseout="dynamichide(event)"></div>');

function getposOffset(what, offsettype)
{
	var totaloffset = (offsettype == "left") ? what.offsetLeft : what.offsetTop;
	var parentEl = what.offsetParent;
	
	while (parentEl != null) {
		totaloffset = (offsettype == "left")? totaloffset + parentEl.offsetLeft : totaloffset + parentEl.offsetTop;
		parentEl = parentEl.offsetParent;
	}
	
	return totaloffset;
}


function showhide(obj, e, visible, hidden, menuwidth)
{
	if (ie4 || ns6)
		dropmenuobj.style.left=dropmenuobj.style.top = "-500px";
	
	if (menuwidth != "") {
		dropmenuobj.widthobj = dropmenuobj.style;
		dropmenuobj.widthobj.width = menuwidth;
	}

	if (e.type == "click" && obj.visibility == hidden || e.type == "mouseover")
		obj.visibility = visible;
	else if (e.type == "click")
		obj.visibility = hidden;
}

function iecompattest()
{
	return (document.compatMode && document.compatMode != "BackCompat") ? document.documentElement : document.body;
}

function clearbrowseredge(obj, whichedge)
{
	var edgeoffset = 0;
	
	if (whichedge == "rightedge") {
		var windowedge = ie4 && !window.opera ? iecompattest().scrollLeft + iecompattest().clientWidth - 15 : window.pageXOffset + window.innerWidth - 15;
		
		dropmenuobj.contentmeasure=dropmenuobj.offsetWidth;
		if (windowedge - dropmenuobj.x < dropmenuobj.contentmeasure)
			edgeoffset = dropmenuobj.contentmeasure - obj.offsetWidth;
	}
	else {
		var topedge = ie4 && !window.opera? iecompattest().scrollTop : window.pageYOffset;
		var windowedge = ie4 && !window.opera? iecompattest().scrollTop+iecompattest().clientHeight-15 : window.pageYOffset + window.innerHeight - 18;
		
		dropmenuobj.contentmeasure = dropmenuobj.offsetHeight;
		if (windowedge - dropmenuobj.y < dropmenuobj.contentmeasure) { //move up?
			edgeoffset = dropmenuobj.contentmeasure + obj.offsetHeight;
		
			if ((dropmenuobj.y - topedge) < dropmenuobj.contentmeasure) //up no good either?
				edgeoffset = dropmenuobj.y + obj.offsetHeight - topedge;
		}
	}
	return edgeoffset;
}

function populatemenu(what)
{
	if (ie4 || ns6)
		dropmenuobj.innerHTML = what.join("");
}


function dropdownmenu(obj, e, menucontents, menuwidth)
{
	if (window.event) 
		event.cancelBubble = true;
	else if (e.stopPropagation) 
		e.stopPropagation();
		
	clearhidemenu();
	dropmenuobj = document.getElementById ? document.getElementById("dropmenudiv") : dropmenudiv;
	populatemenu (menucontents);

	if (ie4 || ns6) {
		showhide(dropmenuobj.style, e, "visible", "hidden", menuwidth);

		dropmenuobj.x = getposOffset(obj, "left");
		dropmenuobj.y = getposOffset(obj, "top");
		dropmenuobj.style.left = dropmenuobj.x - clearbrowseredge(obj, "rightedge") + "px";
		dropmenuobj.style.top = dropmenuobj.y - clearbrowseredge(obj, "bottomedge") + obj.offsetHeight + "px";
	}

	return clickreturnvalue();
}

function clickreturnvalue()
{
	if (ie4 || ns6) 
		return false;
	else 
		return true;
}

function contains_ns6(a, b) 
{
	while (b.parentNode)
		if ((b = b.parentNode) == a)
			return true;
		else
			return false;
}

function dynamichide(e)
{
	if (ie4 && !dropmenuobj.contains(e.toElement))
		delayhidemenu();
	else if (ns6 && e.currentTarget != e.relatedTarget && !contains_ns6(e.currentTarget, e.relatedTarget))
		delayhidemenu();
}

function hidemenu(e)
{
	if (typeof dropmenuobj != "undefined") {
		if (ie4 || ns6)
			dropmenuobj.style.visibility = "hidden";
	}
}

function delayhidemenu()
{
	if (ie4 || ns6)
		delayhide = setTimeout("hidemenu()", disappeardelay);
}

function clearhidemenu()
{
	if (typeof delayhide != "undefined")
		clearTimeout(delayhide);
}

if (hidemenu_onclick == "yes")
	document.onclick = hidemenu;
	
function userDropDown(obj, e, userid, longName)
{
	mnuUser[0] = '<img src="/graphics/user_go.png"><a href="javascript:viewProfile(' + userid + ');">View Profile</a>';
	mnuUser[1] = '<img src="/graphics/email_go.png"><a href="javascript:mailTo(' + userid + ', \'' + longName + '\');">Send Message</a>';
	
	if (glob_isAdmin) {
		mnuUser[2] = '<img src="/graphics/user_edit.png"><a href="javascript:editUser(' + userid + ');">Edit Profile</a>';
	}
	dropdownmenu(obj, e, mnuUser, '150px');
}

function companyDropDown(obj, e, companyid, longName)
{
	if (glob_isAdmin) {
		mnuCompany[0] = '<img src="/graphics/user_go.png"><a href="javascript:editCompany(' + companyid + ');">Edit Company</a>';
		dropdownmenu(obj, e, mnuCompany, '150px');
	}
	
	
}         
</script>                