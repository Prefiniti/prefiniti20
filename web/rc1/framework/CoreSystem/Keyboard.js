/*
 * Keyboard.js
 * Prefiniti Keyboard Support (per-window mappings)
 * 
 * Author: jpw
 * Copyright (C) 2009, AJL Intel-Properties LLC
 *
 */




// acceltypes
var		AC_LOCAL = 1;
var		AC_GLOBAL = 2;

var	ACTable = null;

function InitKeyboard()
{
	writeConsole("<br><br>Prefiniti Application Framework - Keyboard Driver");
	writeConsole(" Version: 0.98<br>");
	
	writeConsole(" Copyright &copy; 2009, AJL Intel-Properties LLC<br><br>");
	
	writeConsole("Initializing the accelerators table...");
	ACTable = new Array(1);
	writeConsole("Accelerators table initialized. Keyboard Ready.<br><br>");
	
}


function InstallAC (AC)
{
	if (AC.AccelType == AC_LOCAL) {
		var wRef = p_session.Framework.FindWindow(AC.WindowHandle);
		
		if(!wRef) { //the window did not exist
			var noWin = new AlertBox("Cannot set a binding for a window that does not exist.", "Keyboard Error", "/graphics/AppIconResources/crystal_project/32x32/apps/keyboard.png");
			noWin.Show();
			return null;
		}
	}

	
	// If this accelerator is local, make sure it does not conflict with any global accelerators
	if (AC.AccelType == AC_LOCAL) {
		for(i in ACTable) {
			if((ACTable[i].ScanCode == AC.ScanCode) && (ACTable[i].AccelType == AC_GLOBAL)) {
				var msg = "An application has attempted to set a local key binding for a key already bound globally.";
				msg += "<br><br>Proposed Binding: Key '" + String.fromCharCode(AC.ScanCode) + "' to '" + AC.Description + "'";
				msg += "<br>Conflicting Binding: Key '" + String.fromCharCode(ACTable[i].ScanCode) + "' to '" + ACTable[i].Description + "'";
				var ab = new AlertBox(msg, "Keyboard Error", "/graphics/AppIconResources/crystal_project/32x32/apps/keyboard.png");
				ab.Show();
				return null;
			}
		}
		// if we get here, there are no conflicts.
														   
		ACTable.push(AC);
		writeConsole('KEYBOARD_DRIVER: Successfully installed local accelerator (Code ' + AC.ScanCode + ', Bound To ' + AC.Description + ")");
		
		return true;
	}
	else {
		for(i in ACTable) {
			if((ACTable[i].ScanCode == AC.ScanCode) && (ACTable[i].AccelType == AC.AccelType)) {
				var abd = new AlertBox("Cannot install duplicate global keyboard binding.", "Keyboard Error", "/graphics/AppIconResources/crystal_project/32x32/apps/keyboard.png");
				abd.Show();
				return null;
			}
		}
		// no conflicts
		ACTable.push(AC);
		writeConsole('KEYBOARD_DRIVER: Successfully installed global accelerator (Code ' + AC.ScanCode + ', Bound To ' + AC.Description + ")");
		return true;
				
	}
}

function AC(AccelType,
			WindowHandle,
			ScanCode,
			Description,
			Fnc) 
{
	this.AccelType = AccelType;
	
	if (this.AccelType == AC_LOCAL) {
		this.WindowHandle = WindowHandle;
	}
	else {
		this.WindowHandle = null;
	}
	this.ScanCode = ScanCode;
	this.Description = Description;
	this.Fnc = Fnc;
}

AC.prototype.Exec = function () {
	this.Fnc();
};

function KBEvent(ScanCode, 
				 Character,
				 ShiftState,
				 AltState,
				 CtlState,
				 RawEvent)
{
	this.ScanCode = ScanCode;
	this.Character = Character;
	this.ShiftState = ShiftState;
	this.AltState = AltState;
	this.CtlState = CtlState;
}

function KBKeyPressed(e) 
{
	var ScanCode = null;
	var Character = null;
	
	if(HP_Browser == HPB_MSIE) {
  		ScanCode = e.keyCode;
  	}
	else {
		ScanCode = e.which;
  	}
	Character = String.fromCharCode(Character);
	
	var KEvt = new KBEvent(ScanCode,
						   Character,
						   e.shiftKey,
						   e.altKey,
						   e.ctrlKey,
						   e);
	
	return KBDispatchEvent(KEvt);
}

function KBDispatchEvent(KEvt)
{
	KBProcessGlobalAccelerators(KEvt)
	return p_session.Framework.PostLocalMessage(p_session.ActiveWindowHandle, IWC_KEYPRESSED, C_KEYBOARD, KEvt);
}

function KBProcessLocalAccelerators(handle, KEvt)
{
	for(i in ACTable) {
		if((ACTable[i].WindowHandle == handle) && (ACTable[i].ScanCode == KEvt.ScanCode)) {
			ACTable[i].Exec();
			return;
		}
	}
}

function KBProcessGlobalAccelerators(KEvt)
{
	for(i in ACTable) {
		if((ACTable[i].ScanCode == KEvt.ScanCode) && (ACTable[i].AccelType == AC_GLOBAL)) {
			ACTable[i].Exec();
			return;
		}
	}
}