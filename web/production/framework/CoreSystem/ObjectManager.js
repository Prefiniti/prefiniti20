var PSelected = null;

function PObjectClick(EventParams, IconHandle, ObjectTypeID, 
					  ObjectID, ReferenceType, FolderID, DOMElement, FolderItemID)
{
	var mouseButton = 'LEFT';
	var IconRef = AjaxGetElementReference(DOMElement);
	if(IconRef) {
		
	}
	
	
	if (navigator.appName == 'Netscape' && EventParams.which == 3) {
		mouseButton = 'RIGHT';
	}
	else {
		if (navigator.appName == 'Microsoft Internet Explorer' && event.button==2) {
			mouseButton = 'RIGHT';
		}
	}
	
	switch(ReferenceType) {
		case RT_OBJECT:
			switch(mouseButton) {
				case 'LEFT':
					if(PSelected == IconRef) {
						POpenObject(ObjectTypeID, ObjectID);
						SystemSound('SND_OBJECTCLICK');
					}
					else {
						if(PSelected) {
							PSelected.style.backgroundColor = "";
							PSelected.style.opacity = "1";
						}
						PSelected = IconRef;
						PSelected.style.backgroundColor = "#EFEFEF";
						PSelected.style.opacity = ".40";
						//PSelected.style.positioning = "absolute";
						//alert(PSelected.id);
						p_session.Framework.PDragIcon(PSelected, EventParams, null);
					}
					break;
				case 'RIGHT':
					PGetObjectMenu(IconHandle, EventParams, ObjectTypeID, ObjectID, FolderItemID);
					break;
			}
			break;
		case RT_FOLDER:
			switch(mouseButton) {
				case 'LEFT':
					if(PSelected == IconRef) {
						SystemSound('SND_OBJECTCLICK');
						POpenFolder(FolderID);
					}
					else {
						if(PSelected) {
							PSelected.style.backgroundColor = "";
							PSelected.style.opacity = "1";
						}
						PSelected = IconRef;
						PSelected.style.backgroundColor = "#EFEFEF";
						PSelected.style.opacity = ".40";
						p_session.Framework.PDragIcon(PSelected, EventParams, null);
					}
					
					break;
				case 'RIGHT':
					PGetFolderMenu(FolderID, IconHandle, EventParams, FolderItemID);
					break;
			}
			break;
	}
	
	return true;
	//alert("Object ID " + ObjectID.toString() + " of type " + ObjectTypeID.toString() + " was " + mouseButton + " clicked.");
}

function PGetObjectMenu(OnObject, EventHandle, ObjectTypeID, ObjectID, FolderItemID)
{
	var ObjectMenu = new Array(1);
	
	ObjectMenu[0]='<img src="/graphics/page_white_go.png"><a href="javascript:POpenObject(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Open</strong></a>'; 
	ObjectMenu[1]='<img src="/graphics/bin.png"><a href="javascript:PDeleteObject(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Delete</strong></a>'; 
	ObjectMenu[2]='<img src="/graphics/page_white_edit.png"><a href="javascript:PRenameObject(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Rename</strong></a>'; 
	ObjectMenu[3]='<img src="/graphics/show_desktop.png"><a href="javascript:PCreateReference(0, ' + ObjectTypeID + ', ' + ObjectID + ', \'SYSOBJ\');"><strong>Create link on desktop</strong></a>'; 
	ObjectMenu[4]='<img src="/graphics/folder_add.png"><a href="javascript:PBrowseReference(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Create link in folder</strong></a>'; 
	ObjectMenu[5]='<img src="/graphics/basket_add.png"><a href="javascript:PGrabObject(' + FolderItemID + ');">Grab this item</a>';
	ObjectMenu[6]='<img src="/graphics/group_add.png"><a href="javascript:PShareObject(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Share this item...</strong></a>'; 
	ObjectMenu[7]='<img src="/graphics/wrench.png"><a href="javascript:PObjectInfo(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Properties...</strong></a>';
	
	
	dropdownmenu(OnObject, EventHandle, ObjectMenu, '170px');
}

function PGetFolderMenu(FolderID, OnObject, EventHandle, FolderItemID) 
{
	var FolderMenu = new Array(1);
	FolderMenu[0]='<img src="/graphics/folder_explore.png"><a href="javascript:POpenFolder(' + FolderID + ');">Browse This Folder</a>';
	FolderMenu[1]='<img src="/graphics/folder_edit.png"><a href="javascript:PRenameFolder(' + FolderID + ');">Rename This Folder...</a>';
	FolderMenu[2]='<img src="/graphics/folder_delete.png"><a href="javascript:PDeleteFolder(' + FolderID + ');">Move to Bin</a>';
	FolderMenu[3]='<img src="/graphics/folder_user.png"><a href="javascript:PShareFolder(' + FolderID + ');">Share This Folder...</a>';
	if (PBICount() > 0) {
		FolderMenu[4]='<img src="/graphics/basket_remove.png"><a onmousedown="javascript:PLetGoMenu(this, event, ' +  FolderID + ');" href="##">Let Go of ' + PBICount() + ' Items Here &gt;&gt;</a>';
	}
	
	dropdownmenu(OnObject, EventHandle, FolderMenu, '180px');
	
}

function PLetGoMenu(OnObject, EventHandle, TargetFolderID)
{
	var LetGoMenu = new Array(1);
	LetGoMenu[0]='<img src="/graphics/page_white_copy.png"><a href="javascript:PCopySelected(' + TargetFolderID + ');">Copy</a>';
	LetGoMenu[1]='<img src="/graphics/page_white_put.png"><a href="javascript:PMoveSelected(' + TargetFolderID + ');">Move</a>';
	
	dropdownmenu(OnObject, EventHandle, LetGoMenu, '170px');
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
	var proposedHandle = "BrowserWindow_" + FolderID.toString();
	
	var owRef;
	owRef = p_session.Framework.FindWindow(proposedHandle);
	
	if(owRef) {
		
		p_session.Framework.SetFocus(proposedHandle);
		p_session.Framework.PostLocalMessage(proposedHandle, IWC_POPULATEFOLDER, C_WINDOWMANAGER, FolderID);
		return;
	}
	else {
		var POFrect = new PAutoRect(840, 560);	
	}

	BrowserWindows++;
	var POFhandle = proposedHandle;
	var POFtitle = "Browse Folder";
	
	var POFicon = new PIcon("/graphics/AppIconResources/" + glob_PDMDefaultTheme + "/32x32/filesystems/folder.png",
							P_SMALLICON);
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
	
	
	
	var TBOnRequestCallback = function () {
		p_session.Framework.PostLocalMessage(POFhandle, IWC_POPULATEFOLDER, C_WINDOWMANAGER, FolderID);
		PPopulateFolder('PFolderList_' + FolderID, FolderID, GetValue('PObjectView_' + FolderID));
		
		return true;
	};
	
	var LoadCallback = function () {
		
		
		var TBurl;
		TBurl = '/framework/controls/dialog_html/PBrowseFolder_Toolbar.cfm?FolderID=' + escape(FolderID);
		
		wRef.LoadToolbarStrip(TBurl, TBOnRequestCallback);
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
			var SIRrect = new PAutoRect(640, 480);
			var SIRicon = new PIcon("/graphics/page_white.png", P_SMALLICON);
			var SIRcolor = new PColor(255, 255, 255);
			
			var SIRwindow = new PWindow(SIRhandle, SIRtitle, SIRrect, SIRicon, WS_DEFAULT, null, SIRcolor); 
			var wRef = p_session.Framework.CreateWindow(SIRwindow);
			
			var url;
			url = '/framework/CoreSystem/HTMLResources/ObjectView.cfm?DivBase=' + escape(SIRhandle);
			
			var LoadCallback = function() {
				wRef.BindToObject(ObjectTypeID, ObjectID, SIRhandle + '_ObjectArea');
			};

			wRef.LoadClientArea(url, LoadCallback);
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

/*
 * item_basket.js
 * Supports grab/let go
 *
 * John Willis
 * john@prefiniti.com
 *
 * Created 6 June 2008
 *
 * Copyright (C) 2008, AJL Intel-Properties LLC
 */

var ItemBasket = new Array(1);
var BasketCount = 0;
function PBasketedItem(FolderItemID)
{
	this.FolderItemID = FolderItemID;
	this.Deleted = false;
	this.Selected = true;
	this.DOMElement = null;
}

function PGetBasketedItem(FolderItemID)
{
	for(i in ItemBasket) {
		if ((ItemBasket[i].FolderItemID == FolderItemID) && (!ItemBasket[i].Deleted)) {
			return ItemBasket[i];
		}
	}
	
	return null;
}

function PGrabObject(FolderItemID)
{
	var DivID = "BI_" + FolderItemID.toString()
	var Item;
	Item = PGetBasketedItem(FolderItemID);
	if (!Item) {
		ItemBasket[BasketCount] = new PBasketedItem(FolderItemID);
		ItemBasket[BasketCount].DOMElement = document.createElement('div');
		ItemBasket[BasketCount].DOMElement.setAttribute('id', DivID);
		
		var Container = AjaxGetElementReference('ItemBasketItems');
		if (Container) {
			Container.appendChild(ItemBasket[BasketCount].DOMElement);
			
			var url;
			url = '/framework/controls/dialog_html/PBasketItem.cfm?FolderItemID=' + escape(FolderItemID);
			url += '&DOMElement=' + escape(DivID);
			
			AjaxLoadPageToDiv(DivID, url);
			
			AjaxGetElementReference('ItemBasket').style.display = "block";
		}
		
		BasketCount++;	
		
		if	(PBICount() == 1) {
			SetInnerHTML('ItemBasketCount', 'You are carrying ' + PBICount() + ' item.');
		}
		else {
			SetInnerHTML('ItemBasketCount', 'You are carrying ' + PBICount() + ' items.');
		}
	}
	else {
		alert("You already have this item in your item basket.");
	}
}

function PBIDelete(FolderItemID)
{
	var Container = AjaxGetElementReference('ItemBasketItems');
	var BasketItem = PGetBasketedItem(FolderItemID);
	
	if (BasketItem) {
		BasketItem.Deleted = true;
		BasketItem.Selected = false;
		if (Container) {
			Container.removeChild(BasketItem.DOMElement);
		}
	}
	
	if	(PBICount() == 1) {
		SetInnerHTML('ItemBasketCount', 'You are carrying ' + PBICount() + ' item.');
	}
	else {
		SetInnerHTML('ItemBasketCount', 'You are carrying ' + PBICount() + ' items.');
	}
}

function PBISelect(FolderItemID, Value) 
{	
	var BasketItem = PGetBasketedItem(FolderItemID);
	
	if (BasketItem) {
		BasketItem.Selected = Value;
		if (!Value) {
			var ChkRef;
			ChkRef = AjaxGetElementReference('ISel_' + FolderItemID);
			
			if (ChkRef) {
				ChkRef.checked = false;
			}
		}
	}	
}

function PBICount() 
{	
	var ct = 0;
	for (i in ItemBasket) {
		if (!ItemBasket[i].Deleted) {
			ct++;
		}
	}
	
	if (ct == 0) {
		AjaxGetElementReference('ItemBasket').style.display = "none";
	}
	
	return ct;
}

function PCopySelected(TargetFolderID)
{
	var CItem;
	
	for (i in ItemBasket) {
		CItem = ItemBasket[i];
		if (CItem.Selected) {
			PCopyItem(CItem.FolderItemID, TargetFolderID);
		}
	}
}

function PMoveSelected(TargetFolderID)
{
	var CItem;
	
	for (i in ItemBasket) {
		CItem = ItemBasket[i];
		if (CItem.Selected) {
			PMoveItem(CItem.FolderItemID, TargetFolderID);
		}
	}
}

function PCopyItem(FolderItemID, TargetFolderID)
{
	var url;
	url = '/framework/controls/dialog_html/PCopyItem.cfm?FolderItemID=' + escape(FolderItemID);
	url += '&TargetFolderID=' + escape(TargetFolderID);
	
	var OnRequestCallback = function () {
		PBISelect(FolderItemID, false);
		
		if (IsChecked('DeleteOnLetGo')) {
			PBIDelete(FolderItemID);
		}
		p_session.Framework.PostGlobalMessage(IWC_POPULATEFOLDER, C_WINDOWMANAGER, null);
	};
	
	AjaxLoadPageToDiv('dev-null', url, OnRequestCallback);	
}

function PMoveItem(FolderItemID, TargetFolderID)
{
	var url;
	url = '/framework/controls/dialog_html/PMoveItem.cfm?FolderItemID=' + escape(FolderItemID);
	url += '&TargetFolderID=' + escape(TargetFolderID);
	
	var OnRequestCallback = function () {
		PBISelect(FolderItemID, false);
		
		if (IsChecked('DeleteOnLetGo')) {
			PBIDelete(FolderItemID);
		}
		p_session.Framework.PostGlobalMessage(IWC_POPULATEFOLDER, C_WINDOWMANAGER, null);
	};
	
	AjaxLoadPageToDiv('dev-null', url, OnRequestCallback);
}

function PRenderObject(objectXML, objectXSLT, DOMElement)
{
	var xsltProcessor = new XSLTProcessor();
	//alert("xsl = " + objectXSLT);
	//alert("xml = " + objectXML);
	xsltProcessor.importStylesheet(objectXSLT);
	
	var fragment = xsltProcessor.transformToFragment(objectXML, document);
	
	var deRef = AjaxGetElementReference(DOMElement);
	
	deRef.innerHTML = "";
	deRef.appendChild(fragment);
}

function FullCreate(ObjectTypeID)
{
	var url;
	url = '/framework/serverinterface/SIFullCreateForm.cfm?ObjectTypeID=' + escape(ObjectTypeID);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function RenderForm(FormID, DivID) 
{
	var url;
	
	if(DivID) {
		
	}
	else {
		url = '/Framework/ServerInterface/SIRenderForm.cfm?FormID=' + escape(FormID);
		AjaxLoadPageToDiv('tcTarget', url);
	}
}