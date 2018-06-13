function CreateNewsArticle(date, headline, bodyCopy)
{
	var url;
	url = "/news/components/articleSubmit.cfm?date=" + escape(date);
	url += "&headline=" + escape(headline);
	url += "&body=" + escape(bodyCopy);
	
	AjaxLoadPageToDiv('tcTarget', url);
}