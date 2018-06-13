
function getSection(targetCtl, Latitude, Longitude)
{
	var url;
	url = "/legalSection/components/section.cfm?latitude=" + escape(Latitude);
	url += "&longitude=" + Longitude;
	
	AjaxLoadPageToValueCtl(targetCtl, url);
	
}

function getTownship(targetCtl, Latitude, Longitude)
{
	var url;
	url = "/legalSection/components/township.cfm?latitude=" + escape(Latitude);
	url += "&longitude=" + Longitude;
	
	AjaxLoadPageToValueCtl(targetCtl, url);
}

function getRange(targetCtl, Latitude, Longitude)
{
	var url;
	url = "/legalSection/components/range.cfm?latitude=" + escape(Latitude);
	url += "&longitude=" + Longitude;
	
	AjaxLoadPageToValueCtl(targetCtl, url);
}

function loadTRS()
{
	getTownship('township', GetValue('latitude'), GetValue('longitude'));
	getRange('range', GetValue('latitude'), GetValue('longitude'));	
	getSection('section', GetValue('latitude'), GetValue('longitude'));
}