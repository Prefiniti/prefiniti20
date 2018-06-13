function PWorkflowManager()
{
	var WFMhandle = 'WorkflowManager';
	var WFMtitle = 'Workflow Manager';
	var WFMrect = new PAutoRect(1280, 500);
	var WFMicon = new PIcon("/graphics/database_lightning.png", P_SMALLICON);
	var WFMstyle = WS_DEFAULT;
	var WFMcolor = new PColor(255, 255, 255);
	
	var WFMwindow = new PWindow(WFMhandle, WFMtitle, WFMrect, WFMicon, WFMstyle, null, WFMcolor);
	
	var wRef = p_session.Framework.CreateWindow(WFMwindow);
	var url = '/framework/controls/dialog_html/PWorkflowManager.cfm';
	var orc = function () {
		return true;
	};
	
	wRef.LoadClientArea(url, orc);
}

function WFMlsb(url, orc)
{
	AjaxLoadPageToDiv('WFMSidebar', '/framework/controls/dialog_html/WFM/WFM' + url + '.cfm', orc);
}

function WFMlc(url, orc)
{
	AjaxLoadPageToDiv('WFMContent', '/framework/controls/dialog_html/WFM/WFM' + url + '.cfm', orc);
}

function WFMwrite(url, params, orc)
{
	AjaxLoadPageToDiv('WFMStatus', '/framework/controls/dialog_html/WFM/Writers/' + url + '.cfm' + params, orc);
}

function WFMedit(url, params, orc)
{
	AjaxLoadPageToDiv('WFMContent', '/framework/controls/dialog_html/WFM/Editors/' + url + '.cfm' + params, orc);
}

function WFMlist(url, orc)
{
	AjaxLoadPageToDiv('WFMSidebar', '/framework/controls/dialog_html/WFM/Listers/' + url + '.cfm', orc);
}




function WFMNewRole()
{
	WFMlsb('NewRole', null);
}

function WFMNewWorkflow()
{
	WFMlsb('NewWorkflow', null);
}

function WFMEditRole(uuid)
{
	var p;
	p = '?role_uuid=' + escape(uuid);
	
	WFMedit('Role', p, null);
}

function WFMEditWorkflow(uuid)
{
	var p;
	p = '?wf_uuid=' + escape(uuid);
	
	WFMedit('Workflow', p, null);
}

function WFMCreateStep(wf_uuid, wf_id, wf_step, blocking, wf_role, wf_action, object_type_id)
{
	var p;
	p = '?wf_id=' + escape(wf_id);
	p += '&wf_uuid=' + escape(wf_uuid);
	p += '&wf_step=' + escape(wf_step);
	p += '&blocking=' + escape(blocking);
	p += '&wf_role=' + escape(wf_role);
	p += '&wf_action=' + escape(wf_action);
	p += '&object_type_id=' + escape(object_type_id);
	
	var orc = function() {
		WFMEditWorkflow(wf_uuid);
	};
	
	WFMwrite('Step', p, orc);
}

function WFMInsertRole(uuid, name, auto_add)
{
	var p;
	
	p = '?role_uuid=' + escape(uuid);
	p += '&role_name=' + escape(name);
	
	if (auto_add) {
		p += '&add_new_members=1';
	}
	else {
		p += '&add_new_members=0';
	}
	
	var orc=function() {
		WFMlist('Role');
		WFMEditRole(uuid);
	};
	
	WFMwrite('Role', p, orc);
}

function WFMInsertWorkflow(uuid, name)
{
	var p;
	p = '?wf_uuid=' + escape(uuid);
	p += '&wf_name=' + escape(name);
	
	var orc=function() {
		WFMlist('Workflow');
		WFMEditWorkflow(uuid);
	};
	
	WFMwrite('Workflow', p, orc);
}

function WFMStepSaveNeeded(container)
{
	AjaxGetElementReference(container).style.backgroundColor = "#FFFFCC";
}
	
