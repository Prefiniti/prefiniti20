var PAppMgrs = 0;
function PApplicationManager()
{
	PAppMgrs++;
	var PAMhandle 	= "PApplicationManager_" + PAppMgrs.toString();
	var PAMtitle 	= "Applications Manager";
	var PAMicon 	= new PIcon("/graphics/package.png", P_SMALLICON);
	var PAMstyle 	= WS_DIALOG;
	var PAMrect 	= new PAutoRect(600, 600);
	
	var PAMwindow = new PWindow(PAMhandle, 
								PAMtitle, 
								PAMrect, 
								PAMicon, 
								PAMstyle, 
								null, 
								new PColor(0, 0, 0));

	var wRef = p_session.Framework.CreateWindow(PAMwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PApplicationManager.cfm?Base=' + escape(PAppMgrs.toString());
	
	var LoadCallback = function () { return; };
	wRef.LoadClientArea(url, LoadCallback);
}

function PInstallApplication(AppID)
{
	var PIAhandle 	= "PInstalled";
	var PIAtitle 	= "Application Installed";
	var PIAicon 	= new PIcon("/graphics/package_add.png", P_SMALLICON);
	var PIAstyle 	= WS_DIALOG;
	var PIArect 	= new PAutoRect(498, 250);
	var PIAwindow 	= new PWindow(PIAhandle, 
								  PIAtitle, 
								  PIArect, 
								  PIAicon, 
								  PIAstyle, 
								  null, 
								  new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(PIAwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PInstallApp.cfm?AppID=' + escape(AppID);
	
	var LoadCallback = function () { p_session.Framework.SetFocus(PIAhandle); };
	wRef.LoadClientArea(url, LoadCallback);
}

function PRemoveApplication(AppID)
{
	var PIAhandle 	= "PRemoved";
	var PIAtitle 	= "Application Removed";
	var PIAicon 	= new PIcon("/graphics/package_delete.png", P_SMALLICON);
	var PIAstyle 	= WS_DIALOG;
	var PIArect 	= new PAutoRect(498, 250);
	var PIAwindow = new PWindow(PIAhandle, 
								PIAtitle, 
								PIArect, 
								PIAicon, 
								PIAstyle, 
								null, 
								new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(PIAwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PRemoveApp.cfm?AppID=' + escape(AppID);
	
	var LoadCallback = function () { p_session.Framework.SetFocus(PIAhandle); };
	wRef.LoadClientArea(url, LoadCallback);
}
