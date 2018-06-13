// JavaScript Document
function loadTimesheetView(target, emp_id, startDate, endDate, filter, admin, jobNum)
{
	
	
	var url;
	
	url = '/tc/listByUser.cfm?emp_id=' + emp_id + "&startDate=" + startDate + "&endDate=" + endDate + "&filter=" + filter + "&admin=" + admin + '&jobNum=' + jobNum;
	
	AjaxLoadPageToDiv(target, url);
}

function loadTimesheetPrint(target, emp_id, startDate, endDate, filter, admin, jobNum)
{
	var url;
	
	url = '/forms/docViewer.cfm?pageTarget=';
	
	url += escape("/tc/components/printView.cfm?emp_id=" + emp_id + "&startDate=" + startDate + "&endDate=" + endDate + "&filter=" + filter + "&admin=" + admin  + '&jobNum=' + jobNum + '&current_association=' + glob_current_association + '&current_site_id=' + glob_current_site_id);
	
	
	window.open(url,"printView","width=800,height=800,toolbar=0,menubar=1");
}

function openTS(tsID, sCtl)
{
	url = '/tc/edit_ts.cfm?id=' + tsID;
	AjaxLoadPageToDiv(sCtl, url);
}

function editTimesheetHeader(id, date, clsJobNumber, JobDescription, startTime)
{
	var url;
	url = '/tc/editHeaderSub.cfm?id=' + id + '&date=' + date + '&clsJobNumber=' + clsJobNumber;
	url += '&JobDescription=' + JobDescription + '&startTime=' + startTime;
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function loadWeekToCtls(startCtl, endCtl)
{
	AjaxLoadPageToValueCtl(startCtl, "/tc/components/firstDayOfWeek.cfm");	
	AjaxLoadPageToValueCtl(endCtl, "/tc/components/lastDayOfWeek.cfm");
}

function approveTimesheet(tsID, sCtl)
{
	url = '/tc/components/approveTC.cfm?id=' + tsID;
	
	AjaxLoadPageToDiv(sCtl, url);
}

function reverseTimesheet(tsID, sCtl)
{
	url = '/tc/components/reverseTC.cfm?id=' + tsID;
	
	AjaxLoadPageToDiv(sCtl, url);
}


function addTwoFields(firstCtl, secondCtl, targetCtl) 
{
		document.getElementById(targetCtl).value = AjaxGetElementReference(firstCtl).value + AjaxGetElementReference(secondCtl).value;
}
	
function subtractTwoFields(firstCtl, secondCtl, targetCtl) 
{
		var res = parseInt(AjaxGetElementReference(secondCtl).value) - parseInt(AjaxGetElementReference(firstCtl).value)
		document.getElementById(targetCtl).value = res;
}

function deleteTimesheetConfirm(tsID, sCtl)
{
	url = '/tc/components/deleteTC.cfm?id=' + tsID;
	url += '&PWindowClientArea=' + escape(sCtl);
	
	AjaxLoadPageToDiv(sCtl, url);
}

function deleteTimesheetSub(tsID, sCtl)
{
	url = '/tc/components/deleteTCSub.cfm?id=' + tsID;
	
	AjaxLoadPageToDiv(sCtl, url);
}

function addLineItem(timecard_id, taskCodeID, description, hours, odStart, odEnd, mileage)
{
	var url;
	url = "/tc/addEntry_sub.cfm?timecard_id=" + escape(timecard_id);
	url += "&taskCodeID=" + escape(taskCodeID);
	url += "&description=" + escape(description);
	
	url += "&hours=" + escape(hours);
	url += "&odStart=" + escape(odStart);
	url += "&odEnd=" + escape(odEnd);
	url += "&mileage=" + escape(mileage);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function editLineItem(timecard_id, lineitem_id, taskCodeID, description, hours, odStart, odEnd, mileage)
{
	var url;
	url = "/tc/editLineItemSub.cfm?id=" + escape(lineitem_id);
	url += "&taskCodeID=" + escape(taskCodeID);
	url += "&description=" + escape(description);
	
	url += "&hours=" + escape(hours);
	url += "&odStart=" + escape(odStart);
	url += "&odEnd=" + escape(odEnd);
	url += "&mileage=" + escape(mileage);
	url += "&timecard_id=" + escape(timecard_id);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function createTimesheet(clientArea, emp_id, date, JobNumSel, JobDescription, startTime, submitID)
{
	var url;
	url = "/tc/newts_sub.cfm?emp_id=" + escape(emp_id);
	url += "&date=" + escape(date);
	url += "&JobNumSel=" + escape(JobNumSel);
	
	url += "&JobDescription=" + escape(JobDescription);
	url += "&startTime=" + escape(startTime);
	url += "&submitID=" + escape(submitID);
	
	
	AjaxLoadPageToDiv(clientArea, url);
}

function getTotalHours(highest)
{
	var curDiv = "";
	var cDivName = "";
	var totHours = 0;
	
	for(curDiv = 1; curDiv <= highest; curDiv++) {
		cDivName = 'hrs_' + curDiv.toString();
		totHours += parseFloat(GetInnerHTML(cDivName));
	}
	SetInnerHTML('totalHours', '<strong>' + totHours.toString() + '</strong>');
	return totHours.toString();
}

function AddMileage()
{
	document.getElementById(mileage).value = document.getElementById(odStart).value + document.getElementById(odEnd).value;
}

function tcSetBilled(id, value)
{
	var url;
	url = '/tc/components/set_billed.cfm?id=' + escape(id);
	url += '&value=' + escape(value);
	
	AjaxNullRequest(url);
}

function tcSetPaid(id, value)
{
	var url;
	url = '/tc/components/set_paid.cfm?id=' + escape(id);
	url += '&value=' + escape(value);
	
	AjaxNullRequest(url);
}