<style type="text/css">

	
	.Xtable {

		border:1px solid #CCCCCC;
		margin-bottom:5px;
	}
	.padCell
	{
		background-color:#3399CC;
		width:8px;
	}
	.bodyCell
	{
	padding-right:8px;
	background-color:#FFFFFF;
	
	background-image: url(http://www.prefiniti.com/MyCL/components/headerBlockBG.png);
	background-repeat: no-repeat;
	background-position: left center;
	}
	.bodyCellText
	{
	font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif;
	font-size: x-small;
	margin-top: 5px;
	margin-right: 5px;
	margin-bottom: 5px;
	margin-left: 0px;
	
	text-align: right;
	}
</style>

<cfoutput>
	<table class="Xtable" width="#attributes.width#" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="padCell">&nbsp;</td>
			<td class="bodyCell" align="right"><div class="bodyCellText">#attributes.text#</div></td>
		</tr>
	</table>
</cfoutput>