/*
 *  DocumentEditor.js
 *  Prefiniti Document Editor
 *
 * Author: jpw
 * Created: 2/11/2009
 *
 * Copyright (C) 2009, AJL Intel-Properties LLC
 *
 */



var DOCMODE_HTML = 0x00;
var DOCMODE_TEXT = 0x01;
 
var Documents = new Array(1);

function DocumentViewer(Path) {
	throw("Document viewer under construction");
	
	
}

function DocumentEditor(Path) {
	var fname = Path.PAF_GetStringAfterLast("/");
	
	Path = Path.PAF_GetStringBeforeLast("/");
	
	var pd = new PDocument(Path, fname, DOCMODE_HTML, null);
	pd.Edit();
}

function DocumentEditor_PlainText(Path) {
	var fname = Path.PAF_GetStringAfterLast("/");
	Path = Path.PAF_GetStringBeforeLast("/");
	var pd = new PDocument(Path, fname, DOCMODE_TEXT, null);
	pd.Edit();
}


function PDocument(Path, FileName, Mode, Close_Callback)
{
	/* externals */
	this.Path = Path;
	this.FileName= FileName;
	this.Mode = Mode;
	this.Close_Callback = Close_Callback;

	/* internals */
	this.Editor = null;
	this.Window = null;
	this.Toolbar = null;
	this.ClientArea = null;
	this.InnerFrame = null;
	this.textareaHandle = null;

	Documents.push(this);
}

function FindDocument(Path, FileName) 
{
	for(doc in Documents) {
		if (Documents[doc].Path == Path) {
			if (Documents[doc].FileName == FileName) {
				return Documents[doc];
			}
		}
	}
	
	return null;
}

function FromHandle (Handle) {
	for (doc in Documents) {
		if (Documents[doc].textareaHandle == Handle) {
			return Documents[doc];
		}
	}
	
	return null;
};

PDocument.prototype.View = function () {
	
};

PDocument.prototype.Edit = function () {
	
	writeConsole("Prefiniti Document Editor 0.98");
	writeConsole("Copyright &copy; 2009, AJL Intel-Properties LLC");
	writeConsole("<br>DOCUMENTEDITOR: Creating window object...");
	var TP_handle = 'PDocument_' + GetUnique();
	 
	this.Window = p_session.Framework.FindWindow(TP_handle);
	if (!this.Window) {
		var TP_title  = this.FileName + " - Document Editor";
		var TP_icon   = new PIcon('/graphics/AppIconResources/crystal_project/32x32/apps/kate.png', P_SMALLICON);
		var TP_rect   = new PAutoRect(800, 500);
		var TP_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWMAXIMIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var TP_MessageHandler  = PDocument_MessageHandler;
		var TP_BackgroundColor = new PColor(255, 255, 255);

		var TP_window = new PWindow(TP_handle, TP_title, TP_rect, TP_icon, TP_style, TP_MessageHandler, TP_BackgroundColor);
	 
		this.Window = p_session.Framework.CreateWindow(TP_window);	
	}
	
	
	this.Toolbar 	= new PElement(TP_handle + "_ToolbarStrip");
	this.ClientArea	= new PElement(TP_handle + "_ClientArea");
	this.InnerFrame	= new PElement(TP_handle + "_InnerFrame");
	writeConsole("DOCUMENTEDITOR: Requesting client window from server...");
	/* load the textarea */
	var contentURL = "/Framework/CoreSystem/Widgets/DocumentEditor/DocumentWindow.cfm";
	var contentRH = new KRequestHeaders();
	this.textareaHandle = "TAN_" + TP_handle;
	
	contentRH.Add(new KRequestParam("TAN", this.textareaHandle));
	contentRH.Add(new KRequestParam("PATH", this.Path));
	contentRH.Add(new KRequestParam("FILENAME", this.FileName));
	
	this.ClientArea.LoadText(KSynchronousRequest(contentURL, contentRH));
	
	writeConsole("DOCUMENTEDITOR: Requesting toolbar resource from server...");
	
	/* load the toolbar */
	var toolbarURL = "/Framework/CoreSystem/Widgets/DocumentEditor/Toolbar.cfm";
	this.Toolbar.LoadText(KSynchronousRequest(toolbarURL, contentRH));
	
	
	switch (this.Mode) {
		case DOCMODE_HTML:
			writeConsole("DOCUMENTEDITOR: We are in HTML mode");
			writeConsole("DOCUMENTEDITOR: Initializing FCKeditor 2.6...");
			this.Editor = new FCKeditor(this.textareaHandle);
			this.Editor.BasePath = "/FCKeditor/";
			this.Editor.ToolbarSet = "Prefiniti";
			this.Editor.Width = "100%";
			this.Editor.Height = "100%";
			this.Editor.ReplaceTextarea();
			writeConsole("DOCUMENTEDITOR: FCKeditor 2.6 initialized.");
			break;	
		case DOCMODE_TEXT:
			writeConsole("DOCUMENTEDITOR: We are in plain text mode");
			break;
	}

	
};

PDocument.prototype.Save = function () {
	writeConsole("DOCUMENTEDITOR: Saving document...");
	
	var fullPath = this.Path + "/" + this.FileName;
	
	if (this.Mode == DOCMODE_HTML) {
		var oAPI = FCKeditorAPI.GetInstance(this.textareaHandle);
		var Content = oAPI.GetHTML();
	}
	else {
		var edEl = new PElement(this.textareaHandle);
		var Content = edEl.GetText();
	}
	
	Content.PAF_SaveToFile(fullPath, "");
	
	var myAB = new AlertBox("Your work has been saved.", "Documents", "/graphics/AppIconResources/crystal_project/32x32/actions/filesave.png");
	myAB.Show();
};

PDocument.prototype.SaveAs = function(Path, FileName) {
	this.Path = Path;
	this.FileName = FileName;
	
	this.Save();
};


function Editor_NormalClose() {
	
	return true;
}

function PDocument_MessageHandler(handle, msg_id, sender_component, message_object) 
{
	var WindowObject = p_session.Framework.FindWindow(handle);
	
	
	switch (msg_id) {
		case IWC_REQUESTCLOSE:
		
		break;
	}
	
	p_session.Framework.DefaultMessageHandler(handle, msg_id, sender_component, message_object);	
}
