// JavaScript Document

function scAddIndividualEvent(user_id, start_block_id, sdate) 
{
	var url;
	url = '/scheduling/add_event.cfm?user_id=' + escape(user_id);
	url += '&start_block_id=' + escape(start_block_id);
	url += '&date=' + escape(sdate);
	
	AjaxLoadPageToWindow(url, 'Add Event');
	
}

function scAddDepartmentEvent(department_id)
{
	var url;
	url = '/scheduling/add_department_event.cfm?department_id=' + escape(department_id);

	
	AjaxLoadPageToWindow(url, 'Add Department Event');	
}

function scCreateEvent(user_id, date, start_block, end_block, event_description,
					   event_title, address, city, state, zip)
{
	if (parseInt(end_block) <= parseInt(start_block)) {
		alert("The end time must be after the start time.");
		return;
	}
	
	if (event_title == "") {
		alert("You must enter a title for the event.");
		return;
	}
	
	
	var url;
	url = '/scheduling/create_event.cfm?user_id=' + escape(user_id);
	url += '&date=' + escape(date);
	url += '&start_block=' + escape(start_block);
	url += '&end_block=' + escape(end_block);
	url += '&event_description=' + escape(event_description);
	url += '&event_title=' + escape(event_title);
	url += '&address=' + escape(address);
	url += '&city=' + escape(city);
	url += '&state=' + escape(state);
	url += '&zip=' + escape(zip);
	
	AjaxLoadPageToDiv('schedTarget', url);
	
	//hideDiv('gen_window_frame');
	AjaxRefreshTarget();
}

function scCreateDepartmentEvent(department_id, date, start_block, end_block, event_description,
					   event_title, address, city, state, zip)
{
	if (parseInt(end_block) <= parseInt(start_block)) {
		alert("The end time must be after the start time.");
		return;
	}
	
	if (event_title == "") {
		alert("You must enter a title for the event.");
		return;
	}
	
	
	var url;
	url = '/scheduling/create_department_event.cfm?department_id=' + escape(department_id);
	url += '&date=' + escape(date);
	url += '&start_block=' + escape(start_block);
	url += '&end_block=' + escape(end_block);
	url += '&event_description=' + escape(event_description);
	url += '&event_title=' + escape(event_title);
	url += '&address=' + escape(address);
	url += '&city=' + escape(city);
	url += '&state=' + escape(state);
	url += '&zip=' + escape(zip);
	
	AjaxLoadPageToDiv('schedTarget', url);
	
	//hideDiv('gen_window_frame');
	AjaxRefreshTarget();
}

<!--scDispatchCrew(#url.project_id#, GetValue('department'), GetValue('date'), GetValue('start_block'), GetValue('end_block'), GetValue('event_description'), GetValue('event_title'), GetValue('address'), GetValue('city'), GetValue('state'), GetValue('zip'));-->
function scDispatchCrew(project_id, department_id, date, start_block, end_block, event_description,
					   event_title, address, city, state, zip)
{
	if (department_id == null) {
		alert("You must select a department.");
		return;
	}
	
	if (parseInt(end_block) <= parseInt(start_block)) {
		alert("The end time must be after the start time.");
		return;
	}
	
	if (event_title == "") {
		alert("You must enter a title for the event.");
		return;
	}
	
	
	var url;
	url = '/scheduling/create_department_event.cfm?department_id=' + escape(department_id);
	url += '&date=' + escape(date);
	url += '&start_block=' + escape(start_block);
	url += '&end_block=' + escape(end_block);
	url += '&event_description=' + escape(event_description);
	url += escape('<br><a href="javascript:loadProjectViewer(' + project_id + ');">View Project</a>');
	url += '&event_title=' + escape(event_title);
	url += '&address=' + escape(address);
	url += '&city=' + escape(city);
	url += '&state=' + escape(state);
	url += '&zip=' + escape(zip);
	
	AjaxLoadPageToDiv('schedTarget', url);
	
	//hideDiv('gen_window_frame');
	AjaxRefreshTarget();
}

function scUpdateEvent(event_id, date, start_block, end_block, event_description,
					   event_title, address, city, state, zip, event_guid)
{
	if (parseInt(end_block) <= parseInt(start_block)) {
		alert("The end time must be after the start time.");
		return;
	}
	
	if (event_title == "") {
		alert("You must enter a title for the event.");
		return;
	}
	
	
	var url;
	url = '/scheduling/update_event.cfm?event_id=' + escape(event_id);
	url += '&date=' + escape(date);
	url += '&start_block=' + escape(start_block);
	url += '&end_block=' + escape(end_block);
	url += '&event_description=' + escape(event_description);
	url += '&event_title=' + escape(event_title);
	url += '&address=' + escape(address);
	url += '&city=' + escape(city);
	url += '&state=' + escape(state);
	url += '&zip=' + escape(zip);
	url += '&event_guid=' + escape(event_guid);
	
	AjaxLoadPageToDiv('schedTarget', url);
	
	//hideDiv('gen_window_frame');
	AjaxRefreshTarget();
}

function scViewEvent(event_id)
{
	var url;
	url = '/scheduling/view_item.cfm?item_id=' + escape(event_id);
	
	AjaxLoadPageToWindow(url, 'View Event');
}

function scEditEvent(event_id)
{
	var url;
	url = '/scheduling/edit_item.cfm?event_id=' + escape(event_id);
	
	AjaxLoadPageToWindow(url, 'Edit Event');
}

function scDeleteEvent(item_id)
{
	var url;
	url = '/scheduling/delete_item.cfm?item_id=' + escape(item_id);

	var onRequestCallback = function () {
		AjaxRefreshTarget();
	};

	AjaxLoadPageToWindow(url, 'Delete Event', onRequestCallback);
}
