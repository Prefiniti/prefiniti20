var nextToClose;
nextToClose=null;
	
function showDivC(which) 
{
	
	if (nextToClose != null) {
		document.getElementById(nextToClose).style.display="none";
	}

	document.getElementById(which).style.display="inline";
	nextToClose=which;

	soundManager.play('click');
}
function hideDivC(which) 
{
	soundManager.play('click');
	document.getElementById(which).style.display="none";
	
	
}
function SwapShown(which)
{
	if (document.getElementById(which).style.display == "none") {
		showDivC(which);
	}
	else {
		hideDivC(which);
	}
}