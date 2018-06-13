// JavaScript Document

var orderTmr = null;

function InitializePPView()
{
	
	var Payment;
	var Fulfillment;
	var Delivery;
	
	Payment = IsChecked('Payment').toString();
	Fulfillment = IsChecked('Fulfillment').toString();
	Delivery = IsChecked('Delivery').toString();
	
	var pageURL;
	pageURL = '/Framework/OrderProcess/Orders.cfm?Payment=' + escape(Payment);
	pageURL += '&Fulfillment=' + escape(Fulfillment);
	pageURL += '&Delivery=' + escape(Delivery);
	pageURL += '&VendorID=' + escape(GetValue('VendorID'));
	pageURL += '&UserID=' + escape(GetValue('UserID'));
	
	var tpageURL;
	tpageURL = '/Framework/OrderProcess/SummaryBars.cfm?Payment=' + escape(Payment);
	tpageURL += '&Fulfillment=' + escape(Fulfillment);
	tpageURL += '&Delivery=' + escape(Delivery);
	tpageURL += '&VendorID=' + escape(GetValue('VendorID'));
	tpageURL += '&UserID=' + escape(GetValue('UserID'));
	
	AjaxLoadPageToDiv('OPTarget', pageURL);
	AjaxLoadPageToDiv('SummaryBars', tpageURL);
	
	if (!orderTmr) {
		orderTmr = window.setTimeout("InitializePPView()", 60000);
	}
}

function SetOrderStage(OrderID, NewStage, LoadTo) 
{
	var url;
	url = '/Framework/OrderProcess/SS_SetOrderStage.cfm?OrderID=' + escape(OrderID);
	url += '&NewStage=' + escape(NewStage);
	url += '&UserID=' + escape(GetValue('UserID'));

	
	AjaxLoadPageToDiv(LoadTo, url, InitializePPView);
}


function AcknowledgeOrder(OrderID)
{
	var divn;
	divn = 'ACK_' + OrderID.toString();
	SetInnerHTML(divn, '');
	
	SetOrderStage(OrderID, 1, 'StatBlock');
}

function SetItemDone(ItemID, LoadTo, OrderID)
{
	var url;
	url = '/framework/OrderProcess/SS_SetItemDone.cfm?ItemID=' + escape(ItemID);
	url += '&UserID=' + escape(GetValue('UserID'));
	url += '&OrderID=' + escape(OrderID);
	
	AjaxLoadPageToDiv(LoadTo, url, CheckFulfillmentDone);
	
}

function CheckFulfillmentDone()
{
	
}