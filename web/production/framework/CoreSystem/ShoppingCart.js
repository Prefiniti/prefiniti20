/* new stuff for 1.6 */
function CartItem(item_id, quantity, item_opts)
{
	this.item_id = item_id;
	this.quantity = quantity;
	this.item_opts = item_opts;
}

function ProcessCartMessages(handle, msg_id, sender_component, message_object)
{
	var UpdateToolbar = function () {
		var twRef = p_session.Framework.FindWindow('UserShoppingCart');
		var SCT_ToolbarStripURL = '/framework/components/PShoppingCartToolbar.cfm?user_id=' + escape(glob_userid);
		twRef.LoadToolbarStrip(SCT_ToolbarStripURL);
		
		p_session.Framework.PostLocalMessage('UserShoppingCart', IWC_REQUESTREFRESH, C_WINDOWMANAGER, null);
	};
	
	var CartID = GetValue('CurrentCartID');
	
	switch(msg_id) {
		case IWC_SUBMITORDER:
		
			var url;
			url = '/framework/components/submitorder.cfm?CartID=' + escape(CartID);
			/*if(GetValue('cart_loc') != '') {
				url += '&Location=' + escape(GetValue('cart_loc'));
			}
			else {
				url += '&Location=0';
			}
			url += '&PayProfile=' + escape(GetValue('cart_pay'));
			url += '&fulfillment_method=' + escape(GetRadioCheckedValue(document.forms['orderCheckout'].elements['fulfillment_method']));
			*/
			var vl = GetVendorList();
			var ecode = vl.substring(0, 6);
			
			if(ecode == "ERRORS") {
				writeConsole("Could not submit order due to form validation failure.");
				writeConsole("VALIDATION ERRORS: " + vl);
			}
			else {
				url += vl;
			
			}
			
			break;
			
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
			
			SystemSound('CHECKOUT');
			
			break;
		case IWC_ADDTOCART:
			
			var baseURL = '/framework/components/add_to_cart.cfm';
			var cartRH = new KRequestHeaders();
			
			cartRH.Add(new KRequestParam("item_id", message_object.item_id));
			cartRH.Add(new KRequestParam("quantity", message_object.quantity));
			cartRH.Add(new KRequestParam("item_opts", message_object.item_opts));
			
			var url;
			url = baseURL + cartRH.QueryString(baseURL);
			
			var wRef = p_session.Framework.FindWindow(handle);
			
			var NewItemDiv = 'CartItem_' + message_object.item_id;
			
			
			if(!KElementExists(NewItemDiv)) {
				wRef.CreateChildFrame(NewItemDiv);	
				AjaxLoadPageToDiv(NewItemDiv, url, UpdateToolbar);
				hideDiv('CartError');
			}
			else {
				NewItemDiv += "_" + GetUnique().toString();
				wRef.CreateChildFrame(NewItemDiv);	
				AjaxLoadPageToDiv(NewItemDiv, url, UpdateToolbar);
				hideDiv('CartError');
			}
			
			var qa = new QuickAlert("/graphics/cart.png", "Item added to cart.", 3000);
			qa.Show();
			
			SystemSound('ADDTOCART');
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

function PGetCustomizations(ProductID) {
	var elCstFldCt = new PElement("PCUST_CT_" + ProductID.toString());
	var CustomFieldCount = parseInt(elCstFldCt.GetText()) + 1;
	
	var curField = null;
	var custVar = "";
	
	for(i = 1; i < CustomFieldCount; i++) {
		curField = new PElement("PCUST_" + ProductID + "_" + i.toString());
		
		if(curField.Node) {
			custVar += curField.GetText() + ", ";
		}
	}
	
	return custVar.substr(0, custVar.length - 2);
}

function GetVendorList() {
	var elVendorList = new PElement("VendorList");
	
	var tmpArr;
	tmpArr = elVendorList.GetText().split(",");
	
	var pStr = "&Vendors=" + escape(elVendorList.GetText());
	var tFul = null;
	var tPay = null;
	var tLoc = null;
	var tel = null;
	
	var ts = null;
	
	var errVal = '';
	
	for(i in tmpArr) {
		if(tmpArr[i] == "VLIST") {
			writeConsole("SHOPPINGCART: Skipping dummy record.");
		}
		else {
			tel = 'fulfillment_method_' + tmpArr[i].toString();
			ts = escape(GetRadioCheckedValue(document.forms['orderCheckout'].elements[tel]))
			if(ts == '') {
				errVal = ",FAIL VALIDATION ON FULFILLMENT FROM METHOD EMPTY FOR VENDOR " + tmpArr[i].toString();
			}
			pStr += '&fulfillment_method_' + tmpArr[i].toString() + '=' + ts;
			
			tel = new PElement('cart_loc_' + tmpArr[i].toString());
			
			if(tel.Node) {
				ts = escape(tel.GetText());
				if(ts == '') {
					errVal += ",FAIL VALIDATION ON LOCATION FROM ADDRESS EMPTY FOR VENDOR " + tmpArr[i].toString();
				}
				pStr += '&cart_loc_' + tmpArr[i].toString() + '=' + ts;
			}
			else {
				errVal += ",FAIL VALIDATION ON LOCATION FROM ADDRESS EMPTY FOR VENDOR " + tmpArr[i].toString();
			}
			
			tel = new PElement('cart_pay_' + tmpArr[i].toString());
			if(tel.Node) {
				ts = escape(tel.GetText());
				if(ts == '') {
					errVal += ",FAIL VALIDATION ON PAYMENT FROM METHOD EMPTY FOR VENDOR " + tmpArr[i].toString();
				}
				pStr += '&payment_method_' + tmpArr[i].toString() + '=' + ts;
			}
			else {
				errVal += ",FAIL VALIDATION ON PAYMENT FROM METHOD EMPTY FOR VENDOR " + tmpArr[i].toString();
			}
		}
	}
	
	if(!errVal) {
		return pStr;
	}
	else {
		return "ERRORS" + errVal;
	}
}

function PGatherDeliveries () {
	
}

function PGatherPayments () {
	
}

function POpenCart(user_id)
{
	/* Window code generated by Prefiniti Development System 0.1 */
	var SC_handle = 'UserShoppingCart';
	var wRef = p_session.Framework.FindWindow(SC_handle);
	if (!wRef) {
		var SC_title  = 'My Shopping Cart';
		var SC_icon   = new PIcon('/graphics/AppIconResources/crystal_project/32x32/actions/shopping_cart.png', P_SMALLICON);
		var SC_rect   = new PAutoRect(700, 500);
		var SC_style  = WS_ALLOWMINIMIZE | WS_ENABLEPDM | WS_ALLOWREFRESH;
		var SC_MessageHandler  = ProcessCartMessages;
		var SC_BackgroundColor = new PColor(255, 255, 255);
	
		var SC_window = new PWindow(SC_handle, SC_title, SC_rect, SC_icon, SC_style, SC_MessageHandler, SC_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(SC_window);
	}
	
	var orc = function () {
		p_session.Framework.SetFocus(SC_handle);
	};
	
	var SC_ClientAreaURL = '/framework/components/PShoppingCart.cfm?user_id=' + escape(user_id);
	wRef.LoadClientArea(SC_ClientAreaURL, orc);
	
	var SC_ToolbarStripURL = '/framework/components/PShoppingCartToolbar.cfm?user_id=' + escape(user_id);
	wRef.LoadToolbarStrip(SC_ToolbarStripURL);
}
	
function AddToCart(item_id, quantity, item_opts)
{
	var tmpItem = new CartItem(item_id, quantity, item_opts);
	
	p_session.Framework.PostLocalMessage('UserShoppingCart', IWC_ADDTOCART, C_WINDOWMANAGER, tmpItem);
}


function ViewCatalog(site_id)
{
	/* Window code generated by Prefiniti Development System 0.1 */
	var PC_handle = 'ProductCatalog_' + site_id;

	var wRef = p_session.Framework.FindWindow(PC_handle);
	if (!wRef) {
		var PC_title  = 'Product Catalog';
		var PC_icon   = new PIcon('/graphics/pi-16x16.png', P_SMALLICON);
		var PC_rect   = new PAutoRect(640, 480);
		var PC_style  = WS_ALLOWCLOSE | WS_ALLOWMAXIMIZE | WS_ALLOWMINIMIZE | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM | WS_ALLOWREFRESH;
		var PC_MessageHandler  = null;
		var PC_BackgroundColor = new PColor(255, 255, 255);
	
		var PC_window = new PWindow(PC_handle, PC_title, PC_rect, PC_icon, PC_style, PC_MessageHandler, PC_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(PC_window);
	}
	
	var orc = function () {
		p_session.Framework.SetFocus(PC_handle);
	};
	
	var url;
	url = '/product_ordering/ViewCatalog.cfm?site_id=' + escape(site_id);
	
	wRef.LoadClientArea(url, orc);
	
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

function MyOrders(SiteID)
{
	
	
	/* Window code generated by Prefiniti Development System 1.0.2 */

	var wRef = p_session.Framework.FindWindow('MyOrders');
	if (!wRef) {
		var MO_handle = 'MyOrders';
		var MO_title  = 'My Orders';
		var MO_icon   = new PIcon('/graphics/cart.png', P_SMALLICON);
		var MO_rect   = new PAutoRect(550, 350);
		var MO_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWMAXIMIZE | WS_ALLOWREFRESH | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var MO_MessageHandler  = null;
		var MO_BackgroundColor = new PColor(255, 255, 255);
	
		var MO_window = new PWindow(MO_handle, MO_title, MO_rect, MO_icon, MO_style, MO_MessageHandler, MO_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(MO_window);
		MO_ClientAreaURL = '/framework/CoreSystem/HTMLResources/MyOrders.cfm';
		MO_ClientAreaURL += '?SiteID=' + escape(SiteID);
		
		var olf = function () {
			p_session.Framework.SetFocus(MO_handle);
		};
		
		wRef.LoadClientArea(MO_ClientAreaURL, olf);
	
		MO_ToolbarURL = '/framework/CoreSystem/HTMLResources/MyOrders_Toolbar.cfm';
		wRef.LoadToolbarStrip(MO_ToolbarURL);
	}
	
	
}

function ViewOrder(OrderID)
{
	/* Window code generated by Prefiniti Development System 1.0.2 */
	
	var wRef = p_session.Framework.FindWindow('OrderView');
	if (!wRef) {
		var OV_handle = 'OrderView';
		var OV_title  = 'View Order';
		var OV_icon   = new PIcon('/graphics/cart.png', P_SMALLICON);
		var OV_rect   = new PAutoRect(640, 600);
		var OV_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWREFRESH | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var OV_MessageHandler  = null;
		var OV_BackgroundColor = new PColor(255, 255, 255);
	
		var OV_window = new PWindow(OV_handle, OV_title, OV_rect, OV_icon, OV_style, OV_MessageHandler, OV_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(OV_window);
		
		
	
	}

	var olf = function () {
		p_session.Framework.SetFocus(OV_handle);
	};
	
	OV_ClientAreaURL = '/framework/CoreSystem/HTMLResources/ViewOrder.cfm';
	OV_ClientAreaURL += '?OrderID=' + escape(OrderID);
		
	wRef.LoadClientArea(OV_ClientAreaURL, olf);
}

function checkEditor()
{
	for ( i = 0; i < parent.frames.length; ++i ) {
		if ( parent.frames[i].FCK ) {
			try {
				parent.frames[i].FCK.UpdateLinkedField();
			}
			catch(error) {
				alert(error);
			} // try-catch
		} // if
	} // for	
} // function

function PViewProduct(Item_ID, ImageFolder)
{
	var VP_handle = 'ViewProduct_' + Item_ID.toString();
	
	/* Window code generated by Prefiniti Development System 1.0.2 */

	var wRef = p_session.Framework.FindWindow(VP_handle);
	if (!wRef) {
		
		var VP_title  = 'View Product';
		var VP_icon   = new PIcon('/graphics/tag_blue.png', P_SMALLICON);
		var VP_rect   = new PAutoRect(800, 600);
		var VP_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWMAXIMIZE | WS_ALLOWREFRESH | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var VP_MessageHandler  = null;
		var VP_BackgroundColor = new PColor(255, 255, 255);
	
		var VP_window = new PWindow(VP_handle, VP_title, VP_rect, VP_icon, VP_style, VP_MessageHandler, VP_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(VP_window);
	}
	
	var orc = function() {
		p_session.Framework.SetFocus(VP_handle);
	};
	
	VP_ClientAreaURL = '/framework/CoreSystem/HTMLResources/ViewProduct.cfm';
	VP_ClientAreaURL += '?ItemID=' + escape(Item_ID);
	VP_ClientAreaURL += '&ImageFolder=' + escape(ImageFolder);
	
	wRef.LoadClientArea(VP_ClientAreaURL, orc);
}

function PEditProduct(id)
{
	var divName = 'EditProduct_' + id.toString();
	var url = '/framework/CoreSystem/HTMLResources/EditProduct.cfm?ProductID=' + escape(id);
	
	var orc = function () {
		var glob_editor = new FCKeditor( 'EIDescription' ) ;
        glob_editor.BasePath = "/FCKeditor/" ;
        glob_editor.ToolbarSet = "Prefiniti" ;
		glob_editor.ReplaceTextarea() ;
	};
	
	showDivBlock(divName);
	AjaxLoadPageToDiv(divName, url, orc);
}


function PItemCustomizations(ItemID)
{
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var MC_handle = 'ManageCustomizations';
	
	var wRef = p_session.Framework.FindWindow(MC_handle);
	if (!wRef) {
		var MC_title  = 'Item Customization Settings';
		var MC_icon   = new PIcon('/graphics/wand.png', P_SMALLICON);
		var MC_rect   = new PAutoRect(498, 496);
		var MC_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var MC_MessageHandler  = null;
		var MC_BackgroundColor = new PColor(255, 255, 255);
	
		var MC_window = new PWindow(MC_handle, MC_title, MC_rect, MC_icon, MC_style, MC_MessageHandler, MC_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(MC_window);
		
	
	}
	
	var orc = function () {
		p_session.Framework.SetFocus(MC_handle);
	};
	
	MC_ClientAreaURL = '/Framework/CoreSystem/HTMLResources/ManageCustomizations.cfm';
	MC_ClientAreaURL += '?ItemID=' + escape(ItemID);
	
	wRef.LoadClientArea(MC_ClientAreaURL, orc);
}

function AddProduct(SiteID)
{
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var TP_handle = 'AddProduct';
	 
	var wRef = p_session.Framework.FindWindow(TP_handle);
	if (!wRef) {
		var TP_title  = 'Add Product';
		var TP_icon   = new PIcon('/graphics/cart_add.png', P_SMALLICON);
		var TP_rect   = new PAutoRect(550, 400);
		var TP_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWMAXIMIZE | WS_ALLOWREFRESH | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var TP_MessageHandler  = null;
		var TP_BackgroundColor = new PColor(255, 255, 255);

		var TP_window = new PWindow(TP_handle, TP_title, TP_rect, TP_icon, TP_style, TP_MessageHandler, TP_BackgroundColor);
	 
		wRef = p_session.Framework.CreateWindow(TP_window);	
	}
	TP_ClientAreaURL = '/product_ordering/AddProduct.cfm';
	TP_ClientAreaURL += '?SiteID=' + escape(SiteID);
	TP_ClientAreaURL += '&UserID=' + escape(AuthenticationRecord.UserID);

	
	wRef.LoadClientArea(TP_ClientAreaURL);
}

function AddPaymentProfile()
{
	var res = "/product_ordering/AddPaymentProfile.cfm";
	var qry = "&UserID=" + escape(AuthenticationRecord.UserID);
	
	OpenSecureWindow(res, qry, "AddPaymentMethod");
	
	var epmEl = new PElement("ExistingMethods");
	epmEl.LoadText("");
}

function ExistingPaymentMethods(VendorID)
{
	var theDiv = "ExistingMethods_" + VendorID;
	
	var url = "/framework/components/PaymentMethodExisting.cfm";
	url += "?UserID=" + AuthenticationRecord.UserID;
	url += "&CtlID=cart_pay_" + VendorID;
	AjaxLoadPageToDiv(theDiv, url);
	
}

function DeletePaymentProfile(id) 
{
	
	var resp = confirm("Are you sure you wish to delete this payment profile?");
	
	if (resp) {
		var epmEl = new PElement("ExistingMethods");
		epmEl.LoadText("");
		var res = "/product_ordering/DeletePaymentProfile.cfm";
		var qry = "&id=" + escape(id);

		OpenSecureWindow(res, qry, "DeletePaymentMethod");
	}
}

function EditPaymentProfile(id)
{
	var res = "/product_ordering/Edit.cfm";
	var qry = "&id=" + escape(id);
	
	OpenSecureWindow(res, qry, "EditPaymentMethod");
	
	
}

function snMyLocations()
{
	/* Window code generated by Prefiniti Development System 0.1 */

	var wRef = p_session.Framework.FindWindow('MyLocations');
	if (!wRef) {
		var ML_handle = 'MyLocations';
		var ML_title  = 'My Locations';
		var ML_icon   = new PIcon('/graphics/map.png', P_SMALLICON);
		var ML_rect   = new PAutoRect(800, 600);
		var ML_style  = WS_ALLOWCLOSE | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var ML_MessageHandler  = null;
		var ML_BackgroundColor = new PColor(255, 255, 255);
	
		var ML_window = new PWindow(ML_handle, ML_title, ML_rect, ML_icon, ML_style, ML_MessageHandler, ML_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(ML_window);
		ML_ClientAreaURL = '/socialnet/components/profile_manager/locations_16.cfm';
		wRef.LoadClientArea(ML_ClientAreaURL);
	
	}
}