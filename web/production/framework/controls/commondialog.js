/* 
 * commondialog.js
 * 
 * Common dialog boxes for the Prefiniti Desktop Manager
 *
 * John Willis
 * john@prefiniti.com
 *
 * Copyright (C) 2008 AJL Intel-Properties LLC
 *
 * Created: 18 May 2008
 *
 */
 
function PIconChooser(onChosenCallback)
{
	// set up for window creation
	var PIhandle 	= 'IconChooser';
	var PItitle 	= 'Choose Icon';
	var PIicon 		= new PIcon('/graphics/image.png', P_SMALLICON);
	var PIstyle 	= WS_DIALOG;
	var PIrect 		= new PAutoRect(498, 496);
	
	//alert("HTMLColor: " + PIcolor.HTMLColor);
	
	var PIwindow = new PWindow(PIhandle, 
							   PItitle, 
							   PIrect, 
							   PIicon, 
							   PIstyle, 
							   null, 
							   new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(PIwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PIconChooser.cfm?onChosenCallback=' + escape(onChosenCallback);
	
	var LoadCallback = function () {
		PIconGetList(glob_PDMDefaultTheme, GetValue('PIconSize'), GetValue('PIconCategory'), GetValue('PIconView'));
	};
	
	wRef.LoadClientArea(url, LoadCallback);
}

function PIconSizeChanged(new_size) 
{
	PIconGetList(glob_PDMDefaultTheme, new_size, GetValue('PIconCategory'), GetValue('PIconView'));
}

function PIconCategoryChanged(new_category)
{
	PIconGetList(glob_PDMDefaultTheme, GetValue('PIconSize'), new_category, GetValue('PIconView'));
}

function PIconGetList(theme, size, category, view)
{
	var url;
	url = '/framework/controls/dialog_html/PIconList.cfm?IconSize=' + escape(size);
	url += '&Context=' + escape(category);
	url += '&View=' + escape(view);
	
	AjaxLoadPageToDiv('PIconList', url);
}
var POLObjectListCount = 0;

function PObjectList(ObjectID, ObjectName, UserID, Icon)
{
	POLObjectListCount++;
	var POLhandle = 'ObjectList' + escape(ObjectID) + "_" + escape(UserID) + "_" + POLObjectListCount.toString();
	var POLtitle = 'My ' + ObjectName + 's';
	var POLicon = new PIcon(Icon, P_SMALLICON);
	var POLstyle = WS_DEFAULT;
	var POLrect = new PAutoRect(840, 560);
	var POLwindow =  new PWindow(POLhandle, 
								 POLtitle, 
								 POLrect, 
								 POLicon, 
								 POLstyle, 
								 null, 
								 new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(POLwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PObjectList.cfm?ObjectID=' + escape(ObjectID);
	url += '&UserID=' + escape(UserID);
	
	var LoadCallback = function () {
		PObjectGetList(ObjectID, UserID, 'PObjectList' + ObjectID.toString() + '_' + glob_userid.toString(), 'VT_LIST');
	};
	
	wRef.LoadClientArea(url, LoadCallback);
}

function PObjectGetList(ObjectID, UserID, ItemBoxID, View)
{
	var url;
	url = '/framework/controls/dialog_html/PObjectListItems.cfm?ObjectID=' + escape(ObjectID);
	url += '&UserID=' + escape(UserID);
	url += '&View=' + escape(View);
	
	AjaxLoadPageToDiv(ItemBoxID, url);
}

var PLegacyCreators = 0;
function PLegacyCreator(ObjectID, ObjectName)
{
	PLegacyCreators++;
	var PLChandle 	= "LegacyCreator_" + PLegacyCreators.toString();
	var PLCtitle 	= ObjectName;
	var PLCicon 	= new PIcon("/graphics/page_white_add.png", P_SMALLICON);
	var PLCstyle 	= WS_DEFAULT;
	var PLCrect 	= new PAutoRect(800, 600);
	var PLCwindow = new PWindow(PLChandle, 
								PLCtitle, 
								PLCrect, 
								PLCicon, 
								PLCstyle, 
								null, 
								new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(PLCwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PLegacyCreator.cfm?ObjectID=' + escape(ObjectID);
	
	var LoadCallback = function () {
		return;
	};
	
	wRef.LoadClientArea(url, LoadCallback);
}
	
var PObjectInfos = 0;
function PObjectInfo (ObjectTypeID, ObjectID) 
{
	PObjectInfos++;
	var POIhandle 	= "PObjectInfo_" + PObjectInfos.toString();
	var POItitle 	= "Object Information";
	var POIicon 	= new PIcon("/graphics/information.png", P_SMALLICON);
	var POIstyle 	= WS_DIALOG;
	var POIrect 	= new PAutoRect(498, 496);
	
	var POIwindow = new PWindow(POIhandle, 
								POItitle, 
								POIrect, 
								POIicon, 
								POIstyle, 
								null, 
								new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(POIwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PObjectInfo.cfm?ObjectID=' + escape(ObjectID);
	url += '&ObjectTypeID=' + escape(ObjectTypeID);
	
	var LoadCallback = function () {
		return;
	};
	
	wRef.LoadClientArea(url, LoadCallback);
}

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

function PCreateReference(ContainingFolder, ObjectTypeID, ObjectID, RefType)
{
	var url;
	url = '/framework/controls/dialog_html/PCreateReference.cfm?ContainingFolder=' + escape(ContainingFolder);
	url += '&ObjectTypeID=' + escape(ObjectTypeID);
	url += '&ObjectID=' + escape(ObjectID);
	url += '&RefType=' + escape(RefType);
	
	var onCreatedCallback = function () {
		p_session.Framework.PostLocalMessage('PDesktopWindow', 
										 IWC_POPULATEFOLDER, 
										 C_WINDOWMANAGER,
										 null);
	};
	
	AjaxLoadPageToDiv('dev-null', url, onCreatedCallback);
}

function PPopulateFolder(DOMObject, FolderID, View)
{
	var url;
	url = '/framework/controls/dialog_html/PFolderItems.cfm?FolderID=' + escape(FolderID);
	url += '&View=' + escape(View);
	url += '&UserID=' + escape(glob_userid);
	url += '&Theme=' + escape(glob_PDMDefaultTheme);
	
	var loadCallback = function () {
		// get node list for parent node
		var objParent = DOMObject;
		var arrChildren = objParent.childNodes;
		var xPos = 5;
	
		
		
		// loop thru all child nodes
		for(i = 0; i < arrChildren.length; i++)
		{
			objChild = arrChildren[i];
			objChild.style.left = xPos.toString() + "px";
			
			xPos += 50;
			
		}
	};

	
	AjaxLoadPageToDiv(DOMObject, url, loadCallback);
}

var PCFs = 0;
function PCreateFolder(ContainingFolder) 
{
	PCFs++;
	var PCFhandle 	= "CreateFolder_" + PCFs.toString();
	var PCFtitle 	= "Create Folder";
	var PCFicon 	= new PIcon("/graphics/folder_add.png", P_SMALLICON);
	var PCFstyle 	= WS_DIALOG;
	var PCFrect 	= new PAutoRect(498, 250);
	var PCFwindow 	= new PWindow(PCFhandle, 
								  PCFtitle, 
								  PCFrect, 
								  PCFicon, 
								  PCFstyle, 
								  null, 
								  new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(PCFwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PCreateFolder.cfm?ContainingFolder=' + escape(ContainingFolder);
	url += '&Handle=' + escape(PCFhandle);
	
	var LoadCallback = function () {
		p_session.Framework.SetFocus(PCFhandle);
	};
	
	wRef.LoadClientArea(url, LoadCallback);
}

function PCreateFolderObject(ContainingFolder, FolderName, DialogHandle)
{
	var url;
	
	url = '/framework/controls/dialog_html/PCreateFolderAction.cfm?ContainingFolder=' + escape(ContainingFolder);
	url += '&FolderName=' + escape(FolderName);
	url += '&UserID=' + escape(glob_userid);
	
	var LoadCallback = function () {
		p_session.Framework.PostGlobalMessage(IWC_POPULATEFOLDER, C_WINDOWMANAGER, null);
		p_session.Framework.DeleteWindow(DialogHandle);
		
	};
	
	AjaxLoadPageToDiv('dev-null', url, LoadCallback);
}

var BrowserWindows=0;
function POpenFolder(FolderID)
{	
	var owRef;
	owRef = p_session.Framework.FindWindow("BrowserWindow");
	
	if(owRef) {
		var POFrect = new PRect(owRef.Rect.top, owRef.Rect.left, 840, 560);
		p_session.Framework.DeleteWindow("BrowserWindow");
	}
	else {
		var POFrect = new PAutoRect(840, 560);	
	}

	BrowserWindows++;
	var POFhandle = "BrowserWindow";
	var POFtitle = "Browse Folder";
	
	var POFicon = new PIcon("/graphics/AppIconResources/" + glob_PDMDefaultTheme + "/32x32/filesystems/folder.png", P_SMALLICON);
	var POFstyle = WS_DEFAULT;
	
	
	var MessageHandler = function (handle, msg_id, sender_component, message_object) {
		switch(msg_id) {
			case IWC_POPULATEFOLDER:
				PPopulateFolder('PFolderList_' + FolderID, FolderID, GetValue('PObjectView_' + FolderID));
				break;
			default:
				p_session.Framework.DefaultMessageHandler(handle, msg_id, sender_component, message_object);
		}
	};
				
	
	var PCFwindow = new PWindow(POFhandle, 
								POFtitle, 
								POFrect, 
								POFicon, 
								POFstyle, 
								MessageHandler, 
								new PColor(255, 255, 255));
	
	var wRef = p_session.Framework.CreateWindow(PCFwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PBrowseFolder.cfm?FolderID=' + escape(FolderID);
	
	
	var LoadCallback = function () {
		p_session.Framework.PostLocalMessage(POFhandle, IWC_POPULATEFOLDER, C_WINDOWMANAGER, FolderID);
		PPopulateFolder('PFolderList_' + FolderID, FolderID, GetValue('PObjectView_' + FolderID));
	};
	
	wRef.LoadClientArea(url, LoadCallback);	
}

var CObject = 0;
function POpenObject(ObjectTypeID, ObjectID)
{
	CObject++;
	switch(ObjectTypeID) {
		case 4:
			cmsViewFile(ObjectID, "user");
			break;
		case 5:
			cmsViewFile(ObjectID, "site");
			break;
		default:
			var SIRhandle = 'SIRenderObject_' + CObject.toString();
			var SIRtitle = 'Object View';
			var SIRrect = new PAutoRect(900, 700);
			var SIRicon = new PIcon("/graphics/page_white.png", P_SMALLICON);
			var SIRcolor = new PColor(255, 255, 255);
			
			var SIRwindow = new PWindow(SIRhandle, SIRtitle, SIRrect, SIRicon, WS_DEFAULT, null, SIRcolor); 
			var wRef = p_session.Framework.CreateWindow(SIRwindow);
			
			var url;
			url = '/framework/ServerInterface/SIObjectXML.cfm?ObjectTypeID=' + escape(ObjectTypeID);
			url += '&InstanceID=' + escape(ObjectID);
			url += '&ObjectAction=VIEW';
			
			wRef.LoadClientArea(url);
			//alert("Unknown object:\n\n Type ID: " + ObjectTypeID + "\n Instance ID: " + ObjectID);
			break;
	}
}
		
function PShowHideTreeBlock(id) 
{
	var ctlRef;
	ctlRef = AjaxGetElementReference(id);
	
	if(ctlRef.style.display == "none") {
		ctlRef.style.display = "block";
	}
	else {
		ctlRef.style.display = "none";
	}
}

var ACLboxes = 0;
function PObjectACL(ObjectTypeID, ObjectID)
{
	
}


function PHelpBrowser(HelpContextID)
{
	var owRef;
	owRef = p_session.Framework.FindWindow("HelpBrowser");
	
	if(owRef) {
		var HBrect = new PRect(owRef.Rect.top, owRef.Rect.left, 840, 560);
		p_session.Framework.DeleteWindow("HelpBrowser");
	}
	else {
		var HBrect = new PAutoRect(950, 560);	
	}	
	
	var HBhandle = "HelpBrowser";
	var HBtitle = "Prefiniti Help Browser";
	var HBicon = new PIcon("/graphics/AppIconResources/" + glob_PDMDefaultTheme + "/32x32/apps/khelpcenter.png", P_SMALLICON);
	var HBstyle = WS_DEFAULT;
	
	var HBwindow = new PWindow(HBhandle, 
								HBtitle, 
								HBrect, 
								HBicon, 
								HBstyle, 
								null, 
								new PColor(255, 255, 255));
	
	var wRef = p_session.Framework.CreateWindow(HBwindow);
	
	var url;
	if (HelpContextID) {
		url = '/framework/controls/dialog_html/PHelpBrowser.cfm?HelpContextID=' + escape(HelpContextID);
	}
	else {
		url = '/framework/controls/dialog_html/PHelpBrowser.cfm?HelpContextID=0';
	}
	
	var loadCallback = function () {
		return true;
	};
	
	wRef.LoadClientArea(url, loadCallback);
}

function PViewDocument(DocID)
{
	var url;
	url = '/framework/controls/dialog_html/PViewDocument.cfm?doc_id=' + escape(DocID);
	
	AjaxLoadPageToDiv('helpContentArea', url);
}

function PGetCatalog(catalog_id) 
{
	var url;
	url = '/framework/controls/dialog_html/PCatalogDocs.cfm?catalog_id=' + escape(catalog_id);
	
	AjaxLoadPageToDiv('catalogDocs', url);
}

function PBackgroundServices()
{
	var owRef;
	owRef = p_session.Framework.FindWindow("BackgroundServices");
	
	if(owRef) {
		p_session.Framework.DeleteWindow("BackgroundServices");
	}
	
	var PBShandle = 'BackgroundServices';
	var PBStitle = 'Background Services';
	var PBSicon = new PIcon("/graphics/cog.png", P_SMALLICON);
	var PBSstyle = WS_TOOLWINDOW;
	var PBSrect = new PAutoRect(498, 496);
	
	var PBSwindow = new PWindow(PBShandle, 
								PBStitle, 
								PBSrect, 
								PBSicon, 
								PBSstyle,
								null,
								new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(PBSwindow);
	var url = '/framework/controls/dialog_html/PBackgroundServices.cfm';

	var OnRequestCallback = function() {
		var cDiv = document.createElement('div');
		var cID = 'TaskHeader'
		cDiv.setAttribute('id', cID);
		
		var Container = AjaxGetElementReference('BGServices');
		Container.appendChild(cDiv);
		
		AjaxLoadPageToDiv(cID, '/framework/controls/dialog_html/PBackgroundServiceInfo.cfm?GetHeaders');
		
		
		for (i in PTasks) {
			cDiv = document.createElement('div');
			cID = 'Task_' + i.toString();
			cDiv.setAttribute('id', cID);
			
			Container = AjaxGetElementReference('BGServices');
			Container.appendChild(cDiv);
			
			var url = '/framework/controls/dialog_html/PBackgroundServiceInfo.cfm?tid=' + escape(i.toString());
			url += '&enabled=' + escape(PTasks[i].Enabled);
			url += '&priority=' + escape(PTasks[i].Priority);
			url += '&owner=' + escape(PTasks[i].Owner);
			url += '&taskname=' + escape(PTasks[i].TaskName);
			url += '&rc=' + escape(PTasks[i].RunCount);
			
			AjaxLoadPageToDiv(cID, url);
		}
	};
	
	wRef.LoadClientArea(url, OnRequestCallback);
}
				
function OpenLanding(page)
{
	showDiv('LandingPage');
	showDiv('LandingPageShadow');
	AjaxLoadPageToDiv('LandingPage', '/LandingPages/' + page);
}

function OpenLink(url)
{
	dispatch();
	AjaxLoadPageToDiv('tcTarget', url);
}

function dispatch()
{
	hideDiv('LandingPage');
	hideDiv('LandingPageShadow');
}

function PUserPicker(OwnerField)
{
	var UPhandle = 'UserPicker_' + OwnerField;
	var UPtitle = 'User Picker';
	var UPicon = new PIcon("/graphics/user.png", P_SMALLICON);
	var UPrect = new PAutoRect(640, 480);
	var UPstyle = WS_DIALOG;
	var UPcolor = new PColor(0, 0, 0);
	
	var UPwindow = new PWindow(UPhandle, 
							UPtitle, 
							UPrect, 
							UPicon, 
							UPstyle,
							null,
							UPcolor);
	
	var wRef = p_session.Framework.CreateWindow(UPwindow);
	
	var url = '/framework/controls/dialog_html/PUserPicker.cfm?OwnerField=' + escape(OwnerField);
	var OnRequestCallback = function () {
		return true;
	};
	
	wRef.LoadClientArea(url, OnRequestCallback);
}



/* new stuff for 1.6 */
function CartItem(item_id, quantity)
{
	this.item_id = item_id;
	this.quantity = quantity;
}

function ProcessCartMessages(handle, msg_id, sender_component, message_object)
{
	var UpdateToolbar = function () {
		var twRef = p_session.Framework.FindWindow('UserShoppingCart');
		var SCT_ToolbarStripURL = '/framework/components/PShoppingCartToolbar.cfm?user_id=' + escape(glob_userid);
		twRef.LoadToolbarStrip(SCT_ToolbarStripURL);
	};
	
	var CartID = GetValue('CurrentCartID');
	
	switch(msg_id) {
		case IWC_SUBMITORDER:
			var url;
			url = '/framework/components/submitorder.cfm?CartID=' + escape(CartID);
			
			url += '&Location=' + escape(GetValue('cart_loc'));
			url += '&PayProfile=' + escape(GetValue('cart_pay'));
			url += '&fulfillment_method=' + escape(GetRadioCheckedValue(document.forms['orderCheckout'].elements['fulfillment_method']));
			
			var wRef = p_session.Framework.FindWindow(handle);
			wRef.LoadClientArea(url);
			
			break;
		case IWC_CHECKOUTCART:
		
			var url;
			url = '/framework/components/checkout.cfm?CartID=' + escape(CartID);
			
			var wRef = p_session.Framework.FindWindow(handle);
			wRef.LoadClientArea(url);
			
			var tburl;
			tburl = '/framework/components/PCheckoutToolbar.cfm';
			wRef.LoadToolbarStrip(tburl);
			
			break;
		case IWC_ADDTOCART:
			
			var url;
			url = '/framework/components/add_to_cart.cfm?item_id=' + escape(message_object.item_id);
			url += '&quantity=' + escape(message_object.quantity);
			
			var wRef = p_session.Framework.FindWindow(handle);
			
			var NewItemDiv = 'CartItem_' + message_object.item_id;
			
			
			if(!AjaxGetElementReference(NewItemDiv)) {
				wRef.CreateChildFrame(NewItemDiv);	
				AjaxLoadPageToDiv(NewItemDiv, url, UpdateToolbar);
				hideDiv('CartError');
			}
			else {
				SetInnerHTML('CartError', '<img src="/graphics/information.png" align="absmiddle"> That item is already in your cart.');
				showDivBlock('CartError');
			}
			
			break;
		case IWC_LOCATIONCHANGED:
			// div id = CartLocationPicker
			
			var url;
			url = '/framework/components/LocationPickerLoader.cfm';
			
			AjaxLoadPageToDiv('CartLocationPicker', url);
			
			break;
		case IWC_PAYMENTCHANGED:
			// div id = CartPaymentPicker
			
			var url;
			url = '/framework/components/PaymentPickerLoader.cfm';
			
			AjaxLoadPageToDiv('CartLocationPicker', url);
			
			break;
		default:
			p_session.Framework.DefaultMessageHandler(handle, msg_id, sender_component, message_object);
	}
}

function POpenCart(user_id)
{
	/* Window code generated by Prefiniti Development System 0.1 */

	var wRef = p_session.Framework.FindWindow('UserShoppingCart');
	if (!wRef) {
		var SC_handle = 'UserShoppingCart';
		var SC_title  = 'My Shopping Cart';
		var SC_icon   = new PIcon('/graphics/cart.png', P_SMALLICON);
		var SC_rect   = new PAutoRect(498, 496);
		var SC_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_SHOWAPPMENU | WS_ENABLEPDM | WS_ALLOWREFRESH;
		var SC_MessageHandler  = ProcessCartMessages;
		var SC_BackgroundColor = new PColor(255, 255, 255);
	
		var SC_window = new PWindow(SC_handle, SC_title, SC_rect, SC_icon, SC_style, SC_MessageHandler, SC_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(SC_window);
	}
	
	var SC_ClientAreaURL = '/framework/components/PShoppingCart.cfm?user_id=' + escape(user_id);
	wRef.LoadClientArea(SC_ClientAreaURL);
	
	var SC_ToolbarStripURL = '/framework/components/PShoppingCartToolbar.cfm?user_id=' + escape(user_id);
	wRef.LoadToolbarStrip(SC_ToolbarStripURL);
}
	
function AddToCart(item_id, quantity)
{
	var tmpItem = new CartItem(item_id, quantity);
	
	p_session.Framework.PostLocalMessage('UserShoppingCart', IWC_ADDTOCART, C_WINDOWMANAGER, tmpItem);
}


function ViewCatalog(site_id)
{
	/* Window code generated by Prefiniti Development System 0.1 */

	var wRef = p_session.Framework.FindWindow('ProductCatalog_' + site_id);
	if (!wRef) {
		var PC_handle = 'ProductCatalog_' + site_id;
		var PC_title  = 'Product Catalog';
		var PC_icon   = new PIcon('/graphics/pi-16x16.png', P_SMALLICON);
		var PC_rect   = new PAutoRect(640, 480);
		var PC_style  = WS_ALLOWCLOSE | WS_ALLOWMAXIMIZE | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM | WS_ALLOWREFRESH;
		var PC_MessageHandler  = null;
		var PC_BackgroundColor = new PColor(255, 255, 255);
	
		var PC_window = new PWindow(PC_handle, PC_title, PC_rect, PC_icon, PC_style, PC_MessageHandler, PC_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(PC_window);
	}

	var url;
	url = '/product_ordering/ViewCatalog.cfm?site_id=' + escape(site_id);
	
	wRef.LoadClientArea(url);
	
}

function UpdateQuantity(item_id, quantity)
{
	var url;
	url = '/framework/components/UpdateQuantity.cfm?item_id=' + escape(item_id);
	url += '&quantity=' + escape(quantity);
	
	var orc = function () {
		POpenCart(glob_userid);
	};
	
	AjaxLoadPageToDiv('ItemStatus_' + item_id.toString(), url, orc);
}