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