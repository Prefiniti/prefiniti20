<head>
<style type="text/css">
	.picHolder 
	{	
		display: inline;
		z-index: 200;
		position:relative;
		
		margin-left:5px;
		margin-top:6px;
		left:-80px;
		top:-10px;
		
	}
	
	.picFrame
	{
	position:relative;
	display: inline;
	clear:left;
	z-index: 300;
	}
	.insidePicture 
	{
		
	}
</style>
</head>

<div class="picFrame">
	
	<img src="/graphics/picframe-small.png">
</div>

<div class="picHolder">
	<cfoutput>
		<cfif #attributes.image# NEQ "">
			<img src="/authentication/profile_images/#attributes.image#" width="65" height="65" class="insidePicture">
		<cfelse>
			<img src="/graphics/no_pic.gif" width="65" height="65" class="insidePicture">
		</cfif>
	</cfoutput>
</div>