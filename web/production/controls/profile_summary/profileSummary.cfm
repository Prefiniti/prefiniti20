<cfquery name="gP" datasource="#session.DB_Core#">
	SELECT longName, picture FROM Users WHERE id=#attributes.userid#
</cfquery>
<style type="text/css">
<!--
.profileSummaryBox {
	width: 300px;
	height: auto;
	border: solid 1px #3399CC;
	padding: 8px;
	background-color:#FDFDFD;
}
.eps {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: medium;
	font-weight: lighter;
	margin:-60px;
	padding:0px;
	vertical-align:top;
}	
.ptext {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: xx-small;
	font-weight: lighter;
	margin:0px;
	padding:0px;
	vertical-align:top;
}	

-->
</style>
			
<cfmodule template="/controls/picture_frame/pictureFrame.cfm" image="#gP.picture#">
