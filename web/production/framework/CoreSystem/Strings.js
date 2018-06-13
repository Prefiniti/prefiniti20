/*
 * Strings.js
 * provides extended string handling for the Prefiniti Framework
 *
 * Author: jpw
 * Created: 2/17/2009
 * Copyright (C) 2009, AJL Intel-Properties LLC
 */


String.prototype.trim = function () {
	return this.replace(/^\s+|\s+$/g,"");
};

String.prototype.ltrim = function () {
	return this.replace(/^\s+/,"");
};

String.prototype.rtrim = function () {
	return this.replace(/\s+$/,"");
};

String.prototype.PAF_GetStringAfterLast = function (Delimiter) {
	var lastPos = this.lastIndexOf(Delimiter);
	
	return this.substr(lastPos + 1);
};

String.prototype.PAF_GetStringBeforeLast = function (Delimiter) {
	var lastPos = this.lastIndexOf(Delimiter);
	
	return this.substr(0, lastPos);
};

String.prototype.PAF_SaveToFile = function (Path, Append) {
	
	var http = KGetAjax();
	
	var url = "/Framework/CoreSystem/HTMLResources/WriteFile.cfm";
	var params = "Content=" + escape(this);
	params += "&Path=" + escape(Path);
	params += "&Append=" + escape(Append);
	params += "&UserID=" + escape(AuthenticationRecord.UserID);
	
	http.open("POST", url, true);
	
	//Send the proper header information along with the request
	http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	http.setRequestHeader("Content-length", params.length);
	http.setRequestHeader("Connection", "close");
	
	http.onreadystatechange = function() {//Call a function when the state changes.
		if(http.readyState == 4) {
			//KValidateServerResponse(http.responseText, url, null);
			writeConsole(http.responseText);
		}
	}
	http.send(params);

};
	