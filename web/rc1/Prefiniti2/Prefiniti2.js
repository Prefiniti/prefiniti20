// JavaScript Document

function ShowScreenshots()
{
	hideDiv('Blog');
	showDivBlock('Screenshots');
}

function ShowBlog()
{
	hideDiv('Screenshots');
	showDivBlock('Blog');
}


function showDiv(which) 
{
	try {
	document.getElementById(which).style.display="inline";
	
	}
	catch (error) {  }
}



function showDivBlock(which) 
{
	document.getElementById(which).style.display="block";
	
}

function hideDiv(which) 
{
	
	//alert(which);
	try {
		document.getElementById(which).style.display="none";
	}
	catch(error) {
		//alert('hideDiv error for div with id of ' + which);
	}
}