function SuggestionProvider() {
    //any initializations needed go here
}

SuggestionProvider.prototype.requestSuggestions = function (oAutoSuggestControl) {  
    var query = oAutoSuggestControl.textbox.value;
    
    //ajax stuff
    var xhr = new XMLHttpRequest();
    
    xhr.onreadystatechange = function () {
	if( xhr.readyState !== 4 || xhr.status !== 200 ) { return };
	
    	var xml = xhr.responseXML;
    	var suggestions = xml.getElementsByTagName("suggestion");
    	
    	var aSuggestions = new Array();
    	for( var i = 0; i < suggestions.length; i++ ) {
    		aSuggestions[i] = suggestions[i].getAttribute("data");
    	}
    	oAutoSuggestControl.autosuggest(aSuggestions);
   	}
   	
    xhr.open("GET", "suggest?q=" + query, true);
    xhr.send();
    


};

function AutoSuggestControl(oTextbox, oProvider) {
	this.cur = -1;
	this.layer = null;
    this.provider = oProvider;
    this.textbox = oTextbox;
    this.init();
}

AutoSuggestControl.prototype.init = function () {
	//save a reference to this object
    var oThis = this;
    
    //assign the onkeyup event handler
    this.textbox.onkeyup = function (oEvent) {
    
        //check for the proper location of the event object
        if (!oEvent) {
            oEvent = window.event;
        }    
        
        //call the handleKeyUp() method with the event object
        oThis.handleKeyUp(oEvent);
    };
    
    //assign onkeydown event handler
    this.textbox.onkeydown = function (oEvent) {
    
        //check for the proper location of the event object
        if (!oEvent) {
            oEvent = window.event;
        }    
        
        //call the handleKeyDown() method with the event object
        oThis.handleKeyDown(oEvent);
    };
    
    //assign onblur event handler (hides suggestions)    
    this.textbox.onblur = function () {
        oThis.hideSuggestions();
    };
    
    //create the suggestions dropdown
    this.createDropDown();
};

AutoSuggestControl.prototype.handleKeyUp = function (oEvent) {
    var iKeyCode = oEvent.keyCode;

    //for backspace (8) and delete (46), shows suggestions without typeahead
    if (iKeyCode == 8 || iKeyCode == 46) {
        this.provider.requestSuggestions(this);
        
    //make sure not to interfere with non-character keys
    } else if (iKeyCode < 32 || (iKeyCode >= 33 && iKeyCode < 46) || (iKeyCode >= 112 && iKeyCode <= 123)) {
        //ignore
    } else {
        //request suggestions from the suggestion provider with typeahead
        this.provider.requestSuggestions(this);
    }
};

AutoSuggestControl.prototype.handleKeyDown = function (oEvent) {
    switch(oEvent.keyCode) {
        case 38: //up arrow
            this.previousSuggestion();
            break;
        case 40: //down arrow 
            this.nextSuggestion();
            break;
        case 13: //enter
            this.hideSuggestions();
            break;
    }
};

AutoSuggestControl.prototype.autosuggest = function (aSuggestions) {
    if (aSuggestions.length > 0) {
        this.showSuggestions(aSuggestions);
    } else {
        this.hideSuggestions();
    }
};

AutoSuggestControl.prototype.nextSuggestion = function () {
    var cSuggestionNodes = this.layer.childNodes;

    if (cSuggestionNodes.length > 0 && this.cur < cSuggestionNodes.length-1) {
        var oNode = cSuggestionNodes[++this.cur];
        this.highlightSuggestion(oNode);
        this.textbox.value = oNode.firstChild.nodeValue; 
    }
};

AutoSuggestControl.prototype.previousSuggestion = function () {
    var cSuggestionNodes = this.layer.childNodes;

    if (cSuggestionNodes.length > 0 && this.cur > 0) {
        var oNode = cSuggestionNodes[--this.cur];
        this.highlightSuggestion(oNode);
        this.textbox.value = oNode.firstChild.nodeValue;   
    }
};

AutoSuggestControl.prototype.createDropDown = function () {
    var oThis = this;

    //create the layer and assign styles
    this.layer = document.createElement("div");
    this.layer.className = "suggestions";
    this.layer.style.visibility = "hidden";
    this.layer.style.width = this.textbox.offsetWidth;
    
    //when the user clicks on the a suggestion, get the text (innerHTML)
    //and place it into a textbox
    this.layer.onmousedown = 
    this.layer.onmouseup = 
    this.layer.onmouseover = function (oEvent) {
        oEvent = oEvent || window.event;
        oTarget = oEvent.target || oEvent.srcElement;

        if (oEvent.type == "mousedown") {
            oThis.textbox.value = oTarget.firstChild.nodeValue;
            oThis.hideSuggestions();
        } else if (oEvent.type == "mouseover") {
            oThis.highlightSuggestion(oTarget);
        } else {
            oThis.textbox.focus();
        }
    };    
    document.body.appendChild(this.layer);
};

AutoSuggestControl.prototype.getLeft = function () /*:int*/ {
    var oNode = this.textbox;
    var iLeft = 0;
    
    while(oNode.tagName != "BODY") {
        iLeft += oNode.offsetLeft;
        oNode = oNode.offsetParent;        
    }
    
    return iLeft;
};

AutoSuggestControl.prototype.getTop = function () /*:int*/ {
    var oNode = this.textbox;
    var iTop = 0;
    
    while(oNode.tagName != "BODY") {
        iTop += oNode.offsetTop;
        oNode = oNode.offsetParent;
    }
    
    return iTop;
};

AutoSuggestControl.prototype.showSuggestions = function (aSuggestions /*:Array*/) {  
    var oDiv = null;
    this.layer.innerHTML = "";  //clear contents of the layer
    
    for (var i=0; i < aSuggestions.length; i++) {
        oDiv = document.createElement("div");
        oDiv.appendChild(document.createTextNode(aSuggestions[i]));
        this.layer.appendChild(oDiv);
    }
    
    this.layer.style.left = this.getLeft() + "px";
    this.layer.style.top = (this.getTop()+this.textbox.offsetHeight) + "px";
    this.layer.style.visibility = "visible";
};

AutoSuggestControl.prototype.hideSuggestions = function () {
    this.layer.style.visibility = "hidden";
};

AutoSuggestControl.prototype.highlightSuggestion = function (oSuggestionNode) {

    for (var i=0; i < this.layer.childNodes.length; i++) {
        var oNode = this.layer.childNodes[i];
        if (oNode == oSuggestionNode) {
            oNode.className = "current"
        } else if (oNode.className == "current") {
            oNode.className = "";
        }
    }
};


