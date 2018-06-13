// JavaScript Document

function rs_load_page(modtemplate, url_string, load_to, start_row, records_per_page)
{
	var urlx;
	
	

	urlx = "/controls/moduleLoader.cfm";
	urlx += "?loadpage=" + escape(modtemplate);
	urlx += url_string;
	urlx += "&start_row=" + start_row;
	urlx += "&records_per_page=" + records_per_page;
	urlx += "&load_to=" + load_to;
	//alert("loading " + urlx + " to div " + load_to + " starting at row " + start_row + ", " + records_per_page + " records per page");


	AjaxLoadPageToDiv(load_to, urlx);

}