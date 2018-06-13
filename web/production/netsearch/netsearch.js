function netSearch(criteria)
{
	var url;
	url = "/netsearch/components/netsearch.cfm?criteria=" + escape(criteria);
	
	AjaxLoadPageToDiv('tcTarget', url);
}