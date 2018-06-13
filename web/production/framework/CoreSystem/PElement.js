
function PElement(NodeID) {
	this.Node = document.getElementById(NodeID);
	this.NodeID = NodeID;
	this.TextContents = null;
}

PElement.prototype.LoadText = function(Value) {
	this.Node.innerHTML = Value;
	this.TextContents = Value;
};

PElement.prototype.Style = function(Selector) {
	this.Node.className = Selector;
};

PElement.prototype.Size = function () {
	this.height = this.Node.clientHeight();
	this.width = this.Node.clientWidth();
	
	return this;
};

PElement.prototype.Resize = function(ns) {
	// ns = Rect
	this.Node.style.width = ns.width + "px";
	this.Node.style.height = ns.height + "px";
};

PElement.prototype.Add = function() {
	var parentRef = this.Node;
	var newID = "PElement_" + GetUnique();

	if (parentRef) {
		var ChildFrameDiv = document.createElement('div');
	
		ChildFrameDiv.setAttribute('id', newID);
		this.Node.appendChild(ChildFrameDiv);
	
		var frameRef = new PElement(newID);
	
		
		
		return frameRef;
	}
	else {
		return null;
	}
};

PElement.prototype.Hide = function () {
	try {
	this.Node.style.display = "none";
	} catch (ex) {}
};

PElement.prototype.ShowInline = function () {
	try {
	this.Node.style.display = "inline";
	} catch (ex) {}
};

PElement.prototype.ShowBlock = function () {
	try {
	this.Node.style.display = "block";
	} catch (ex) {}
};

PElement.prototype.Show = function () {
	try {
	this.ShowBlock();
	} catch (ex) {}
};

PElement.prototype.SetVerticalOffset = function (factor) {
	try {
	this.Node.style.marginTop = factor.toString() + "px";
	} catch (ex) {}
};

PElement.prototype.CenterToScreenHorizontal = function () {
	try {
		var lPos = (p_session.ScreenWidth / 2) - (this.Node.clientWidth / 2);
		
		this.Node.style.left = lPos.toString() + "px";
	} catch (ex) { writeConsole("JUMPER: " + ex.message); }
};

PElement.prototype.GetText = function () {
	if(this.Node.value) {
		return this.Node.value;
	}
	else if(this.Node.innerHTML) {
		return this.Node.innerHTML;
	}
	else if(this.Node.innerText) {
		return this.Node.innerText;
	}
	else {
		return null;
	}
};
