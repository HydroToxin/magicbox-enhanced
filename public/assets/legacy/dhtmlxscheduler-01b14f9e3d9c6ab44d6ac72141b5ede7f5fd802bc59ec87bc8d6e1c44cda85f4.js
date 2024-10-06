var __getOwnPropNames = Object.getOwnPropertyNames;
var __commonJS = (cb, mod) => function __require() {
  return mod || (0, cb[__getOwnPropNames(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports;
};

// app/javascript/legacy/dhtmlxscheduler.js
var require_dhtmlxscheduler = __commonJS({
  "app/javascript/legacy/dhtmlxscheduler.js"(exports, module) {
    !function() {
      function dtmlXMLLoaderObject(t, e, i, n) {
        return this.xmlDoc = "", this.async = void 0 === i || i, this.onloadAction = t || null, this.mainObject = e || null, this.waitCall = null, this.rSeed = n || false, this;
      }
      function dhtmlDragAndDropObject() {
        return window.dhtmlDragAndDrop ? window.dhtmlDragAndDrop : (this.lastLanding = 0, this.dragNode = 0, this.dragStartNode = 0, this.dragStartObject = 0, this.tempDOMU = null, this.tempDOMM = null, this.waitDrag = 0, window.dhtmlDragAndDrop = this, this);
      }
      function _dhtmlxError(t, e, i) {
        return this.catches || (this.catches = []), this;
      }
      function dhtmlXHeir(t, e) {
        for (var i in e) "function" == typeof e[i] && (t[i] = e[i]);
        return t;
      }
      window.dhtmlx || (window.dhtmlx = function(t) {
        for (var e in t) dhtmlx[e] = t[e];
        return dhtmlx;
      }), dhtmlx.extend_api = function(t, e, i) {
        var n = window[t];
        n && (window[t] = function(t2) {
          var i2;
          if (t2 && "object" == typeof t2 && !t2.tagName) {
            i2 = n.apply(this, e._init ? e._init(t2) : arguments);
            for (var a in dhtmlx) e[a] && this[e[a]](dhtmlx[a]);
            for (var a in t2) e[a] ? this[e[a]](t2[a]) : 0 === a.indexOf("on") && this.attachEvent(a, t2[a]);
          } else i2 = n.apply(this, arguments);
          return e._patch && e._patch(this), i2 || this;
        }, window[t].prototype = n.prototype, i && dhtmlXHeir(window[t].prototype, i));
      }, window.dhtmlxAjax = {
        get: function(t, e) {
          var i = new dtmlXMLLoaderObject(true);
          return i.async = arguments.length < 3, i.waitCall = e, i.loadXML(t), i;
        },
        post: function(t, e, i) {
          var n = new dtmlXMLLoaderObject(true);
          return n.async = arguments.length < 4, n.waitCall = i, n.loadXML(t, true, e), n;
        },
        getSync: function(t) {
          return this.get(t, null, true);
        },
        postSync: function(t, e) {
          return this.post(t, e, null, true);
        }
      }, window.dtmlXMLLoaderObject = dtmlXMLLoaderObject, dtmlXMLLoaderObject.count = 0, dtmlXMLLoaderObject.prototype.waitLoadFunction = function(t) {
        var e = true;
        return this.check = function() {
          if (t && t.onloadAction && (!t.xmlDoc.readyState || 4 == t.xmlDoc.readyState)) {
            if (!e) return;
            e = false, dtmlXMLLoaderObject.count++, "function" == typeof t.onloadAction && t.onloadAction(t.mainObject, null, null, null, t), t.waitCall && (t.waitCall.call(this, t), t.waitCall = null);
          }
        }, this.check;
      }, dtmlXMLLoaderObject.prototype.getXMLTopNode = function(t, e) {
        var i;
        if (this.xmlDoc.responseXML) {
          var n = this.xmlDoc.responseXML.getElementsByTagName(t);
          if (0 === n.length && -1 != t.indexOf(":")) var n = this.xmlDoc.responseXML.getElementsByTagName(t.split(":")[1]);
          i = n[0];
        } else i = this.xmlDoc.documentElement;
        if (i) return this._retry = false, i;
        if (!this._retry && _isIE) {
          this._retry = true;
          var e = this.xmlDoc;
          return this.loadXMLString(this.xmlDoc.responseText.replace(/^[\s]+/, ""), true), this.getXMLTopNode(t, e);
        }
        return dhtmlxError.throwError("LoadXML", "Incorrect XML", [e || this.xmlDoc, this.mainObject]), document.createElement("div");
      }, dtmlXMLLoaderObject.prototype.loadXMLString = function(t, e) {
        if (_isIE) this.xmlDoc = new ActiveXObject("Microsoft.XMLDOM"), this.xmlDoc.async = this.async, this.xmlDoc.onreadystatechange = function() {
        }, this.xmlDoc.loadXML(t);
        else {
          var i = new DOMParser();
          this.xmlDoc = i.parseFromString(t, "text/xml");
        }
        e || (this.onloadAction && this.onloadAction(this.mainObject, null, null, null, this), this.waitCall && (this.waitCall(), this.waitCall = null));
      }, dtmlXMLLoaderObject.prototype.loadXML = function(t, e, i, n) {
        this.rSeed && (t += (-1 != t.indexOf("?") ? "&" : "?") + "a_dhx_rSeed=" + (/* @__PURE__ */ new Date()).valueOf()), this.filePath = t, !_isIE && window.XMLHttpRequest ? this.xmlDoc = new XMLHttpRequest() : this.xmlDoc = new ActiveXObject("Microsoft.XMLHTTP"), this.async && (this.xmlDoc.onreadystatechange = new this.waitLoadFunction(this)), "string" == typeof e ? this.xmlDoc.open(e, t, this.async) : this.xmlDoc.open(e ? "POST" : "GET", t, this.async), n ? (this.xmlDoc.setRequestHeader("User-Agent", "dhtmlxRPC v0.1 (" + navigator.userAgent + ")"), this.xmlDoc.setRequestHeader("Content-type", "text/xml")) : e && this.xmlDoc.setRequestHeader("Content-type", "application/x-www-form-urlencoded"), this.xmlDoc.setRequestHeader("X-Requested-With", "XMLHttpRequest"), this.xmlDoc.send(i), this.async || new this.waitLoadFunction(this)();
      }, dtmlXMLLoaderObject.prototype.destructor = function() {
        return this._filterXPath = null, this._getAllNamedChilds = null, this._retry = null, this.async = null, this.rSeed = null, this.filePath = null, this.onloadAction = null, this.mainObject = null, this.xmlDoc = null, this.doXPath = null, this.doXPathOpera = null, this.doXSLTransToObject = null, this.doXSLTransToString = null, this.loadXML = null, this.loadXMLString = null, this.doSerialization = null, this.xmlNodeToJSON = null, this.getXMLTopNode = null, this.setXSLParamValue = null, null;
      }, dtmlXMLLoaderObject.prototype.xmlNodeToJSON = function(t) {
        for (var e = {}, i = 0; i < t.attributes.length; i++) e[t.attributes[i].name] = t.attributes[i].value;
        e._tagvalue = t.firstChild ? t.firstChild.nodeValue : "";
        for (var i = 0; i < t.childNodes.length; i++) {
          var n = t.childNodes[i].tagName;
          n && (e[n] || (e[n] = []), e[n].push(this.xmlNodeToJSON(t.childNodes[i])));
        }
        return e;
      }, window.dhtmlDragAndDropObject = dhtmlDragAndDropObject, dhtmlDragAndDropObject.prototype.removeDraggableItem = function(t) {
        t.onmousedown = null, t.dragStarter = null, t.dragLanding = null;
      }, dhtmlDragAndDropObject.prototype.addDraggableItem = function(t, e) {
        t.onmousedown = this.preCreateDragCopy, t.dragStarter = e, this.addDragLanding(t, e);
      }, dhtmlDragAndDropObject.prototype.addDragLanding = function(t, e) {
        t.dragLanding = e;
      }, dhtmlDragAndDropObject.prototype.preCreateDragCopy = function(t) {
        if (!t && !window.event || 2 != (t || event).button) return window.dhtmlDragAndDrop.waitDrag ? (window.dhtmlDragAndDrop.waitDrag = 0, document.body.onmouseup = window.dhtmlDragAndDrop.tempDOMU, document.body.onmousemove = window.dhtmlDragAndDrop.tempDOMM, false) : (window.dhtmlDragAndDrop.dragNode && window.dhtmlDragAndDrop.stopDrag(t), window.dhtmlDragAndDrop.waitDrag = 1, window.dhtmlDragAndDrop.tempDOMU = document.body.onmouseup, window.dhtmlDragAndDrop.tempDOMM = document.body.onmousemove, window.dhtmlDragAndDrop.dragStartNode = this, window.dhtmlDragAndDrop.dragStartObject = this.dragStarter, document.body.onmouseup = window.dhtmlDragAndDrop.preCreateDragCopy, document.body.onmousemove = window.dhtmlDragAndDrop.callDrag, window.dhtmlDragAndDrop.downtime = (/* @__PURE__ */ new Date()).valueOf(), !(!t || !t.preventDefault) && (t.preventDefault(), false));
      }, dhtmlDragAndDropObject.prototype.callDrag = function(t) {
        t || (t = window.event);
        var e = window.dhtmlDragAndDrop;
        if (!((/* @__PURE__ */ new Date()).valueOf() - e.downtime < 100)) {
          if (!e.dragNode) {
            if (!e.waitDrag) return e.stopDrag(t, true);
            if (e.dragNode = e.dragStartObject._createDragNode(e.dragStartNode, t), !e.dragNode) return e.stopDrag();
            e.dragNode.onselectstart = function() {
              return false;
            }, e.gldragNode = e.dragNode, document.body.appendChild(e.dragNode), document.body.onmouseup = e.stopDrag, e.waitDrag = 0, e.dragNode.pWindow = window, e.initFrameRoute();
          }
          if (e.dragNode.parentNode != window.document.body && e.gldragNode) {
            var i = e.gldragNode;
            e.gldragNode.old && (i = e.gldragNode.old), i.parentNode.removeChild(i);
            var n = e.dragNode.pWindow;
            if (i.pWindow && i.pWindow.dhtmlDragAndDrop.lastLanding && i.pWindow.dhtmlDragAndDrop.lastLanding.dragLanding._dragOut(i.pWindow.dhtmlDragAndDrop.lastLanding), _isIE) {
              var a = document.createElement("div");
              a.innerHTML = e.dragNode.outerHTML, e.dragNode = a.childNodes[0];
            } else e.dragNode = e.dragNode.cloneNode(true);
            e.dragNode.pWindow = window, e.gldragNode.old = e.dragNode, document.body.appendChild(e.dragNode), n.dhtmlDragAndDrop.dragNode = e.dragNode;
          }
          e.dragNode.style.left = t.clientX + 15 + (e.fx ? -1 * e.fx : 0) + (document.body.scrollLeft || document.documentElement.scrollLeft) + "px", e.dragNode.style.top = t.clientY + 3 + (e.fy ? -1 * e.fy : 0) + (document.body.scrollTop || document.documentElement.scrollTop) + "px";
          var r;
          r = t.srcElement ? t.srcElement : t.target, e.checkLanding(r, t);
        }
      }, dhtmlDragAndDropObject.prototype.calculateFramePosition = function(t) {
        if (window.name) {
          for (var e = parent.frames[window.name].frameElement.offsetParent, i = 0, n = 0; e; ) i += e.offsetLeft, n += e.offsetTop, e = e.offsetParent;
          if (parent.dhtmlDragAndDrop) {
            var a = parent.dhtmlDragAndDrop.calculateFramePosition(1);
            i += 1 * a.split("_")[0], n += 1 * a.split("_")[1];
          }
          if (t) return i + "_" + n;
          this.fx = i, this.fy = n;
        }
        return "0_0";
      }, dhtmlDragAndDropObject.prototype.checkLanding = function(t, e) {
        t && t.dragLanding ? (this.lastLanding && this.lastLanding.dragLanding._dragOut(this.lastLanding), this.lastLanding = t, this.lastLanding = this.lastLanding.dragLanding._dragIn(this.lastLanding, this.dragStartNode, e.clientX, e.clientY, e), this.lastLanding_scr = _isIE ? e.srcElement : e.target) : t && "BODY" != t.tagName ? this.checkLanding(t.parentNode, e) : (this.lastLanding && this.lastLanding.dragLanding._dragOut(this.lastLanding, e.clientX, e.clientY, e), this.lastLanding = 0, this._onNotFound && this._onNotFound());
      }, dhtmlDragAndDropObject.prototype.stopDrag = function(t, e) {
        var i = window.dhtmlDragAndDrop;
        if (!e) {
          i.stopFrameRoute();
          var n = i.lastLanding;
          i.lastLanding = null, n && n.dragLanding._drag(i.dragStartNode, i.dragStartObject, n, _isIE ? event.srcElement : t.target);
        }
        i.lastLanding = null, i.dragNode && i.dragNode.parentNode == document.body && i.dragNode.parentNode.removeChild(i.dragNode), i.dragNode = 0, i.gldragNode = 0, i.fx = 0, i.fy = 0, i.dragStartNode = 0, i.dragStartObject = 0, document.body.onmouseup = i.tempDOMU, document.body.onmousemove = i.tempDOMM, i.tempDOMU = null, i.tempDOMM = null, i.waitDrag = 0;
      }, dhtmlDragAndDropObject.prototype.stopFrameRoute = function(t) {
        t && window.dhtmlDragAndDrop.stopDrag(1, 1);
        for (var e = 0; e < window.frames.length; e++) try {
          window.frames[e] != t && window.frames[e].dhtmlDragAndDrop && window.frames[e].dhtmlDragAndDrop.stopFrameRoute(window);
        } catch (t2) {
        }
        try {
          parent.dhtmlDragAndDrop && parent != window && parent != t && parent.dhtmlDragAndDrop.stopFrameRoute(window);
        } catch (t2) {
        }
      }, dhtmlDragAndDropObject.prototype.initFrameRoute = function(t, e) {
        t && (window.dhtmlDragAndDrop.preCreateDragCopy(), window.dhtmlDragAndDrop.dragStartNode = t.dhtmlDragAndDrop.dragStartNode, window.dhtmlDragAndDrop.dragStartObject = t.dhtmlDragAndDrop.dragStartObject, window.dhtmlDragAndDrop.dragNode = t.dhtmlDragAndDrop.dragNode, window.dhtmlDragAndDrop.gldragNode = t.dhtmlDragAndDrop.dragNode, window.document.body.onmouseup = window.dhtmlDragAndDrop.stopDrag, window.waitDrag = 0, !_isIE && e && (!_isFF || _FFrv < 1.8) && window.dhtmlDragAndDrop.calculateFramePosition());
        try {
          parent.dhtmlDragAndDrop && parent != window && parent != t && parent.dhtmlDragAndDrop.initFrameRoute(window);
        } catch (t2) {
        }
        for (var i = 0; i < window.frames.length; i++) try {
          window.frames[i] != t && window.frames[i].dhtmlDragAndDrop && window.frames[i].dhtmlDragAndDrop.initFrameRoute(window, !t || e ? 1 : 0);
        } catch (t2) {
        }
      };
      var _isFF = false, _isIE = false, _isOpera = false, _isKHTML = false, _isMacOS = false, _isChrome = false, _FFrv = false, _KHTMLrv = false, _OperaRv = false;
      -1 != navigator.userAgent.indexOf("Macintosh") && (_isMacOS = true), navigator.userAgent.toLowerCase().indexOf("chrome") > -1 && (_isChrome = true), -1 != navigator.userAgent.indexOf("Safari") || -1 != navigator.userAgent.indexOf("Konqueror") ? (_KHTMLrv = parseFloat(navigator.userAgent.substr(navigator.userAgent.indexOf("Safari") + 7, 5)), _KHTMLrv > 525 ? (_isFF = true, _FFrv = 1.9) : _isKHTML = true) : -1 != navigator.userAgent.indexOf("Opera") ? (_isOpera = true, _OperaRv = parseFloat(navigator.userAgent.substr(navigator.userAgent.indexOf("Opera") + 6, 3))) : -1 != navigator.appName.indexOf("Microsoft") ? (_isIE = true, -1 == navigator.appVersion.indexOf("MSIE 8.0") && -1 == navigator.appVersion.indexOf("MSIE 9.0") && -1 == navigator.appVersion.indexOf("MSIE 10.0") || "BackCompat" == document.compatMode || (_isIE = 8)) : "Netscape" == navigator.appName && -1 != navigator.userAgent.indexOf("Trident") ? _isIE = 8 : (_isFF = true, _FFrv = parseFloat(navigator.userAgent.split("rv:")[1])), dtmlXMLLoaderObject.prototype.doXPath = function(t, e, i, n) {
        if (_isKHTML || !_isIE && !window.XPathResult) return this.doXPathOpera(t, e);
        if (_isIE) return e || (e = this.xmlDoc.nodeName ? this.xmlDoc : this.xmlDoc.responseXML), e || dhtmlxError.throwError("LoadXML", "Incorrect XML", [e || this.xmlDoc, this.mainObject]), i && e.setProperty("SelectionNamespaces", "xmlns:xsl='" + i + "'"), "single" == n ? e.selectSingleNode(t) : e.selectNodes(t) || new Array(0);
        var a = e;
        e || (e = this.xmlDoc.nodeName ? this.xmlDoc : this.xmlDoc.responseXML), e || dhtmlxError.throwError("LoadXML", "Incorrect XML", [e || this.xmlDoc, this.mainObject]), -1 != e.nodeName.indexOf("document") ? a = e : (a = e, e = e.ownerDocument);
        var r = XPathResult.ANY_TYPE;
        "single" == n && (r = XPathResult.FIRST_ORDERED_NODE_TYPE);
        var s = [], o = e.evaluate(t, a, function(t2) {
          return i;
        }, r, null);
        if (r == XPathResult.FIRST_ORDERED_NODE_TYPE) return o.singleNodeValue;
        for (var d = o.iterateNext(); d; ) s[s.length] = d, d = o.iterateNext();
        return s;
      }, _dhtmlxError.prototype.catchError = function(t, e) {
        this.catches[t] = e;
      }, _dhtmlxError.prototype.throwError = function(t, e, i) {
        return this.catches[t] ? this.catches[t](t, e, i) : this.catches.ALL ? this.catches.ALL(t, e, i) : (window.alert("Error type: " + arguments[0] + "\nDescription: " + arguments[1]), null);
      }, window.dhtmlxError = new _dhtmlxError(), dtmlXMLLoaderObject.prototype.doXPathOpera = function(t, e) {
        var i = t.replace(/[\/]+/gi, "/").split("/"), n = null, a = 1;
        if (!i.length) return [];
        if ("." == i[0]) n = [e];
        else {
          if ("" !== i[0]) return [];
          n = (this.xmlDoc.responseXML || this.xmlDoc).getElementsByTagName(i[a].replace(/\[[^\]]*\]/g, "")), a++;
        }
        for (a; a < i.length; a++) n = this._getAllNamedChilds(n, i[a]);
        return -1 != i[a - 1].indexOf("[") && (n = this._filterXPath(n, i[a - 1])), n;
      }, dtmlXMLLoaderObject.prototype._filterXPath = function(t, e) {
        for (var i = [], e = e.replace(/[^\[]*\[\@/g, "").replace(/[\[\]\@]*/g, ""), n = 0; n < t.length; n++) t[n].getAttribute(e) && (i[i.length] = t[n]);
        return i;
      }, dtmlXMLLoaderObject.prototype._getAllNamedChilds = function(t, e) {
        var i = [];
        _isKHTML && (e = e.toUpperCase());
        for (var n = 0; n < t.length; n++) for (var a = 0; a < t[n].childNodes.length; a++) _isKHTML ? t[n].childNodes[a].tagName && t[n].childNodes[a].tagName.toUpperCase() == e && (i[i.length] = t[n].childNodes[a]) : t[n].childNodes[a].tagName == e && (i[i.length] = t[n].childNodes[a]);
        return i;
      }, void 0 === window.dhtmlxEvent && (window.dhtmlxEvent = function(t, e, i) {
        t.addEventListener ? t.addEventListener(e, i, false) : t.attachEvent && t.attachEvent("on" + e, i);
      }), dtmlXMLLoaderObject.prototype.xslDoc = null, dtmlXMLLoaderObject.prototype.setXSLParamValue = function(t, e, i) {
        i || (i = this.xslDoc), i.responseXML && (i = i.responseXML);
        var n = this.doXPath("/xsl:stylesheet/xsl:variable[@name='" + t + "']", i, "http://www.w3.org/1999/XSL/Transform", "single");
        n && (n.firstChild.nodeValue = e);
      }, dtmlXMLLoaderObject.prototype.doXSLTransToObject = function(t, e) {
        t || (t = this.xslDoc), t.responseXML && (t = t.responseXML), e || (e = this.xmlDoc), e.responseXML && (e = e.responseXML);
        var i;
        if (_isIE) {
          i = new ActiveXObject("Msxml2.DOMDocument.3.0");
          try {
            e.transformNodeToObject(t, i);
          } catch (n) {
            i = e.transformNode(t);
          }
        } else this.XSLProcessor || (this.XSLProcessor = new XSLTProcessor(), this.XSLProcessor.importStylesheet(t)), i = this.XSLProcessor.transformToDocument(e);
        return i;
      }, dtmlXMLLoaderObject.prototype.doXSLTransToString = function(t, e) {
        var i = this.doXSLTransToObject(t, e);
        return "string" == typeof i ? i : this.doSerialization(i);
      }, dtmlXMLLoaderObject.prototype.doSerialization = function(t) {
        return t || (t = this.xmlDoc), t.responseXML && (t = t.responseXML), _isIE ? t.xml : new XMLSerializer().serializeToString(t);
      }, window.dhtmlxEventable = function(obj) {
        obj.attachEvent = function(t, e, i) {
          return t = "ev_" + t.toLowerCase(), this[t] || (this[t] = new this.eventCatcher(i || this)), t + ":" + this[t].addEvent(e);
        }, obj.callEvent = function(t, e) {
          return t = "ev_" + t.toLowerCase(), !this[t] || this[t].apply(this, e);
        }, obj.checkEvent = function(t) {
          return !!this["ev_" + t.toLowerCase()];
        }, obj.eventCatcher = function(obj) {
          var dhx_catch = [], z = function() {
            for (var t = true, e = 0; e < dhx_catch.length; e++) if (dhx_catch[e]) {
              var i = dhx_catch[e].apply(obj, arguments);
              t = t && i;
            }
            return t;
          };
          return z.addEvent = function(ev) {
            return "function" != typeof ev && (ev = eval(ev)), !!ev && dhx_catch.push(ev) - 1;
          }, z.removeEvent = function(t) {
            dhx_catch[t] = null;
          }, z;
        }, obj.detachEvent = function(t) {
          if (t) {
            var e = t.split(":");
            this[e[0]].removeEvent(e[1]);
          }
        }, obj.detachAllEvents = function() {
          for (var t in this) 0 === t.indexOf("ev_") && (this.detachEvent(t), this[t] = null);
        }, obj = null;
      }, window.dhtmlx || (window.dhtmlx = {}), function() {
        function t(t2, e2) {
          setTimeout(function() {
            if (t2.box) {
              var n2 = t2.callback;
              i(false), t2.box.parentNode.removeChild(t2.box), dhtmlx.callEvent("onAfterMessagePopup", [t2.box]), c = t2.box = null, n2 && n2(e2);
            }
          }, 1);
        }
        function e(e2) {
          if (c) {
            e2 = e2 || event;
            var i2 = e2.which || event.keyCode, n2 = false;
            if (dhtmlx.message.keyboard) {
              if (13 == i2 || 32 == i2) {
                var a2 = e2.target || e2.srcElement;
                scheduler._getClassName(a2).indexOf("dhtmlx_popup_button") > -1 && a2.click ? a2.click() : (t(c, true), n2 = true);
              }
              27 == i2 && (t(c, false), n2 = true);
            }
            if (n2) return e2.preventDefault && e2.preventDefault(), !(e2.cancelBubble = true);
          } else ;
        }
        function i(t2) {
          i.cover || (i.cover = document.createElement("div"), i.cover.onkeydown = e, i.cover.className = "dhx_modal_cover", document.body.appendChild(i.cover));
          document.body.scrollHeight;
          i.cover.style.display = t2 ? "inline-block" : "none";
        }
        function n(t2, e2, i2) {
          return "<div " + scheduler._waiAria.messageButtonAttrString(t2) + "class='dhtmlx_popup_button dhtmlx_" + (i2 || t2 || "").toLowerCase().replace(/ /g, "_") + "_button' result='" + e2 + "' ><div>" + t2 + "</div></div>";
        }
        function a(t2) {
          u.area || (u.area = document.createElement("div"), u.area.className = "dhtmlx_message_area", u.area.style[u.position] = "5px", document.body.appendChild(u.area)), u.hide(t2.id);
          var e2 = document.createElement("div");
          return e2.innerHTML = "<div>" + t2.text + "</div>", e2.className = "dhtmlx-info dhtmlx-" + t2.type, e2.onclick = function() {
            u.hide(t2.id), t2 = null;
          }, scheduler._waiAria.messageInfoAttr(e2), "bottom" == u.position && u.area.firstChild ? u.area.insertBefore(e2, u.area.firstChild) : u.area.appendChild(e2), t2.expire > 0 && (u.timers[t2.id] = window.setTimeout(function() {
            u.hide(t2.id);
          }, t2.expire)), u.pull[t2.id] = e2, e2 = null, t2.id;
        }
        function r(e2, i2, a2) {
          var r2 = document.createElement("div");
          r2.className = " dhtmlx_modal_box dhtmlx-" + e2.type, r2.setAttribute("dhxbox", 1);
          var s2 = scheduler.uid();
          scheduler._waiAria.messageModalAttr(r2, s2);
          var o2 = "", d2 = false;
          if (e2.width && (r2.style.width = e2.width), e2.height && (r2.style.height = e2.height), e2.title && (o2 += '<div class="dhtmlx_popup_title" id="' + s2 + '">' + e2.title + "</div>", d2 = true), o2 += '<div class="dhtmlx_popup_text" ' + (d2 ? "" : ' id="' + s2 + '" ') + "><span>" + (e2.content ? "" : e2.text) + '</span></div><div  class="dhtmlx_popup_controls">', i2) {
            var l2 = e2.ok || scheduler.locale.labels.message_ok;
            void 0 === l2 && (l2 = "OK"), o2 += n(l2, true, "ok");
          }
          if (a2) {
            var _2 = e2.cancel || scheduler.locale.labels.message_cancel;
            void 0 === _2 && (_2 = "Cancel"), o2 += n(_2, false, "cancel");
          }
          if (e2.buttons) for (var h2 = 0; h2 < e2.buttons.length; h2++) o2 += n(e2.buttons[h2], h2);
          if (o2 += "</div>", r2.innerHTML = o2, e2.content) {
            var u2 = e2.content;
            "string" == typeof u2 && (u2 = document.getElementById(u2)), "none" == u2.style.display && (u2.style.display = ""), r2.childNodes[e2.title ? 1 : 0].appendChild(u2);
          }
          return r2.onclick = function(i3) {
            i3 = i3 || event;
            var n2 = i3.target || i3.srcElement, a3 = scheduler._getClassName(n2);
            if (a3 || (n2 = n2.parentNode), a3 = scheduler._getClassName(n2), "dhtmlx_popup_button" == a3.split(" ")[0]) {
              var r3 = n2.getAttribute("result");
              r3 = "true" == r3 || "false" != r3 && r3, t(e2, r3);
            }
          }, e2.box = r2, c = e2, r2;
        }
        function s(t2, n2, a2) {
          var s2 = t2.tagName ? t2 : r(t2, n2, a2);
          t2.hidden || i(true), document.body.appendChild(s2);
          var o2 = Math.abs(Math.floor(((window.innerWidth || document.documentElement.offsetWidth) - s2.offsetWidth) / 2)), d2 = Math.abs(Math.floor(((window.innerHeight || document.documentElement.offsetHeight) - s2.offsetHeight) / 2));
          return "top" == t2.position ? s2.style.top = "-3px" : s2.style.top = d2 + "px", s2.style.left = o2 + "px", s2.onkeydown = e, dhtmlx.modalbox.focus(s2), t2.hidden && dhtmlx.modalbox.hide(s2), dhtmlx.callEvent("onMessagePopup", [s2]), s2;
        }
        function o(t2) {
          return s(t2, true, false);
        }
        function d(t2) {
          return s(t2, true, true);
        }
        function l(t2) {
          return s(t2);
        }
        function _(t2, e2, i2) {
          return "object" != typeof t2 && ("function" == typeof e2 && (i2 = e2, e2 = ""), t2 = { text: t2, type: e2, callback: i2 }), t2;
        }
        function h(t2, e2, i2, n2) {
          return "object" != typeof t2 && (t2 = { text: t2, type: e2, expire: i2, id: n2 }), t2.id = t2.id || u.uid(), t2.expire = t2.expire || u.expire, t2;
        }
        var c = null;
        document.attachEvent ? document.attachEvent("onkeydown", e) : document.addEventListener("keydown", e, true), dhtmlx.alert = function() {
          var t2 = _.apply(this, arguments);
          return t2.type = t2.type || "confirm", o(t2);
        }, dhtmlx.confirm = function() {
          var t2 = _.apply(this, arguments);
          return t2.type = t2.type || "alert", d(t2);
        }, dhtmlx.modalbox = function() {
          var t2 = _.apply(this, arguments);
          return t2.type = t2.type || "alert", l(t2);
        }, dhtmlx.modalbox.hide = function(t2) {
          for (; t2 && t2.getAttribute && !t2.getAttribute("dhxbox"); ) t2 = t2.parentNode;
          t2 && (t2.parentNode.removeChild(t2), i(false));
        }, dhtmlx.modalbox.focus = function(t2) {
          setTimeout(function() {
            var e2 = scheduler._getFocusableNodes(t2);
            e2.length && e2[0].focus && e2[0].focus();
          }, 1);
        };
        var u = dhtmlx.message = function(t2, e2, i2, n2) {
          switch (t2 = h.apply(this, arguments), t2.type = t2.type || "info", t2.type.split("-")[0]) {
            case "alert":
              return o(t2);
            case "confirm":
              return d(t2);
            case "modalbox":
              return l(t2);
            default:
              return a(t2);
          }
        };
        u.seed = (/* @__PURE__ */ new Date()).valueOf(), u.uid = function() {
          return u.seed++;
        }, u.expire = 4e3, u.keyboard = true, u.position = "top", u.pull = {}, u.timers = {}, u.hideAll = function() {
          for (var t2 in u.pull) u.hide(t2);
        }, u.hide = function(t2) {
          var e2 = u.pull[t2];
          e2 && e2.parentNode && (window.setTimeout(function() {
            e2.parentNode.removeChild(e2), e2 = null;
          }, 2e3), e2.className += " hidden", u.timers[t2] && window.clearTimeout(u.timers[t2]), delete u.pull[t2]);
        };
      }(), dhtmlx.attachEvent || dhtmlxEventable(dhtmlx);
      var dataProcessor = window.dataProcessor = function(t) {
        return this.serverProcessor = t, this.action_param = "!nativeeditor_status", this.object = null, this.updatedRows = [], this.autoUpdate = true, this.updateMode = "cell", this._tMode = "GET", this._headers = null, this._payload = null, this.post_delim = "_", this._waitMode = 0, this._in_progress = {}, this._invalid = {}, this.mandatoryFields = [], this.messages = [], this.styles = {
          updated: "font-weight:bold;",
          inserted: "font-weight:bold;",
          deleted: "text-decoration : line-through;",
          invalid: "background-color:FFE0E0;",
          invalid_cell: "border-bottom:2px solid red;",
          error: "color:red;",
          clear: "font-weight:normal;text-decoration:none;"
        }, this.enableUTFencoding(true), dhtmlxEventable(this), this;
      };
      dataProcessor.prototype = {
        setTransactionMode: function(t, e) {
          "object" == typeof t ? (this._tMode = t.mode || this._tMode, void 0 !== t.headers && (this._headers = t.headers), void 0 !== t.payload && (this._payload = t.payload)) : (this._tMode = t, this._tSend = e), "REST" == this._tMode && (this._tSend = false, this._endnm = true), "JSON" == this._tMode && (this._tSend = false, this._endnm = true, this._headers = this._headers || {}, this._headers["Content-type"] = "application/json"), this._headers && !this._headers["Content-Type"] && (this._headers["Content-Type"] = "application/x-www-form-urlencoded");
        },
        escape: function(t) {
          return this._utf ? encodeURIComponent(t) : escape(t);
        },
        enableUTFencoding: function(t) {
          this._utf = !!t;
        },
        setDataColumns: function(t) {
          this._columns = "string" == typeof t ? t.split(",") : t;
        },
        getSyncState: function() {
          return !this.updatedRows.length;
        },
        enableDataNames: function(t) {
          this._endnm = !!t;
        },
        enablePartialDataSend: function(t) {
          this._changed = !!t;
        },
        setUpdateMode: function(t, e) {
          this.autoUpdate = "cell" == t, this.updateMode = t, this.dnd = e;
        },
        ignore: function(t, e) {
          this._silent_mode = true, t.call(e || window), this._silent_mode = false;
        },
        setUpdated: function(t, e, i) {
          if (!this._silent_mode) {
            var n = this.findRow(t);
            i = i || "updated";
            var a = this.obj.getUserData(t, this.action_param);
            a && "updated" == i && (i = a), e ? (this.set_invalid(t, false), this.updatedRows[n] = t, this.obj.setUserData(t, this.action_param, i), this._in_progress[t] && (this._in_progress[t] = "wait")) : this.is_invalid(t) || (this.updatedRows.splice(n, 1), this.obj.setUserData(t, this.action_param, "")), e || this._clearUpdateFlag(t), this.markRow(t, e, i), e && this.autoUpdate && this.sendData(t);
          }
        },
        _clearUpdateFlag: function(t) {
        },
        markRow: function(t, e, i) {
          var n = "", a = this.is_invalid(t);
          if (a && (n = this.styles[a], e = true), this.callEvent("onRowMark", [t, e, i, a]) && (n = this.styles[e ? i : "clear"] + n, this.obj[this._methods[0]](t, n), a && a.details)) {
            n += this.styles[a + "_cell"];
            for (var r = 0; r < a.details.length; r++) a.details[r] && this.obj[this._methods[1]](t, r, n);
          }
        },
        getState: function(t) {
          return this.obj.getUserData(t, this.action_param);
        },
        is_invalid: function(t) {
          return this._invalid[t];
        },
        set_invalid: function(t, e, i) {
          i && (e = { value: e, details: i, toString: function() {
            return this.value.toString();
          } }), this._invalid[t] = e;
        },
        checkBeforeUpdate: function(t) {
          return true;
        },
        sendData: function(t) {
          if (!this._waitMode || "tree" != this.obj.mytype && !this.obj._h2) {
            if (this.obj.editStop && this.obj.editStop(), void 0 === t || this._tSend) return this.sendAllData();
            if (this._in_progress[t]) return false;
            if (this.messages = [], !this.checkBeforeUpdate(t) && this.callEvent("onValidationError", [t, this.messages])) return false;
            this._beforeSendData(this._getRowData(t), t);
          }
        },
        _beforeSendData: function(t, e) {
          if (!this.callEvent("onBeforeUpdate", [e, this.getState(e), t])) return false;
          this._sendData(t, e);
        },
        serialize: function(t, e) {
          if ("string" == typeof t) return t;
          if (void 0 !== e) return this.serialize_one(t, "");
          var i = [], n = [];
          for (var a in t) t.hasOwnProperty(a) && (i.push(this.serialize_one(t[a], a + this.post_delim)), n.push(a));
          return i.push("ids=" + this.escape(n.join(","))), (scheduler.security_key || dhtmlx.security_key) && i.push("dhx_security=" + (scheduler.security_key || dhtmlx.security_key)), i.join("&");
        },
        serialize_one: function(t, e) {
          if ("string" == typeof t) return t;
          var i = [];
          for (var n in t) if (t.hasOwnProperty(n)) {
            if (("id" == n || n == this.action_param) && "REST" == this._tMode) continue;
            i.push(this.escape((e || "") + n) + "=" + this.escape(t[n]));
          }
          return i.join("&");
        },
        _applyPayload: function(t) {
          var e = this.obj.$ajax;
          if (this._payload) for (var i in this._payload) t = t + e.urlSeparator(t) + this.escape(i) + "=" + this.escape(this._payload[i]);
          return t;
        },
        _sendData: function(t, e) {
          if (t) {
            if (!this.callEvent("onBeforeDataSending", e ? [e, this.getState(e), t] : [null, null, t])) return false;
            e && (this._in_progress[e] = (/* @__PURE__ */ new Date()).valueOf());
            var i = this, n = function(n2) {
              var a2 = [];
              if (e) a2.push(e);
              else if (t) for (var r2 in t) a2.push(r2);
              return i.afterUpdate(i, n2, a2);
            }, a = this.obj.$ajax, r = this.serverProcessor + (this._user ? a.urlSeparator(this.serverProcessor) + ["dhx_user=" + this._user, "dhx_version=" + this.obj.getUserData(0, "version")].join("&") : ""), s = this._applyPayload(r);
            if ("GET" == this._tMode) a.query({
              url: s + a.urlSeparator(s) + this.serialize(t, e),
              method: "GET",
              callback: n,
              headers: this._headers
            });
            else if ("POST" == this._tMode) a.query({ url: s, method: "POST", headers: this._headers, data: this.serialize(t, e), callback: n });
            else if ("JSON" == this._tMode) {
              var o = t[this.action_param], d = {};
              for (var l in t) d[l] = t[l];
              delete d[this.action_param], delete d.id, delete d.gr_id, a.query({ url: s, method: "POST", headers: this._headers, callback: n, data: JSON.stringify({ id: e, action: o, data: d }) });
            } else if ("REST" == this._tMode) {
              var _ = this.getState(e), h = r.replace(/(\&|\?)editing\=true/, ""), d = "", c = "post";
              "inserted" == _ ? d = this.serialize(t, e) : "deleted" == _ ? (c = "DELETE", h = h + ("/" == h.slice(-1) ? "" : "/") + e) : (c = "PUT", d = this.serialize(t, e), h = h + ("/" == h.slice(-1) ? "" : "/") + e), h = this._applyPayload(h), a.query({ url: h, method: c, headers: this._headers, data: d, callback: n });
            }
            this._waitMode++;
          }
        },
        sendAllData: function() {
          if (this.updatedRows.length) {
            this.messages = [];
            for (var t = true, e = 0; e < this.updatedRows.length; e++) t &= this.checkBeforeUpdate(this.updatedRows[e]);
            if (!t && !this.callEvent("onValidationError", ["", this.messages])) return false;
            if (this._tSend) this._sendData(this._getAllData());
            else for (var e = 0; e < this.updatedRows.length; e++) if (!this._in_progress[this.updatedRows[e]]) {
              if (this.is_invalid(this.updatedRows[e])) continue;
              if (this._beforeSendData(this._getRowData(this.updatedRows[e]), this.updatedRows[e]), this._waitMode && ("tree" == this.obj.mytype || this.obj._h2)) return;
            }
          }
        },
        _getAllData: function(t) {
          for (var e = {}, i = false, n = 0; n < this.updatedRows.length; n++) {
            var a = this.updatedRows[n];
            if (!this._in_progress[a] && !this.is_invalid(a)) {
              var r = this._getRowData(a);
              this.callEvent("onBeforeUpdate", [a, this.getState(a), r]) && (e[a] = r, i = true, this._in_progress[a] = (/* @__PURE__ */ new Date()).valueOf());
            }
          }
          return i ? e : null;
        },
        setVerificator: function(t, e) {
          this.mandatoryFields[t] = e || function(t2) {
            return "" !== t2;
          };
        },
        clearVerificator: function(t) {
          this.mandatoryFields[t] = false;
        },
        findRow: function(t) {
          var e = 0;
          for (e = 0; e < this.updatedRows.length && t != this.updatedRows[e]; e++) ;
          return e;
        },
        defineAction: function(t, e) {
          this._uActions || (this._uActions = []), this._uActions[t] = e;
        },
        afterUpdateCallback: function(t, e, i, n) {
          var a = t, r = "error" != i && "invalid" != i;
          if (r || this.set_invalid(t, i), this._uActions && this._uActions[i] && !this._uActions[i](n)) return delete this._in_progress[a];
          "wait" != this._in_progress[a] && this.setUpdated(t, false);
          var s = t;
          switch (i) {
            case "inserted":
            case "insert":
              e != t && (this.setUpdated(t, false), this.obj[this._methods[2]](t, e), t = e);
              break;
            case "delete":
            case "deleted":
              return this.obj.setUserData(t, this.action_param, "true_deleted"), this.obj[this._methods[3]](t, e), delete this._in_progress[a], this.callEvent("onAfterUpdate", [t, i, e, n]);
          }
          "wait" != this._in_progress[a] ? (r && this.obj.setUserData(t, this.action_param, ""), delete this._in_progress[a]) : (delete this._in_progress[a], this.setUpdated(e, true, this.obj.getUserData(t, this.action_param))), this.callEvent("onAfterUpdate", [s, i, e, n]);
        },
        _errorResponse: function(t, e) {
          return this.obj && this.obj.callEvent && this.obj.callEvent("onSaveError", [e, t.xmlDoc]), this.cleanUpdate(e);
        },
        afterUpdate: function(t, e, i) {
          var n = this.obj.$ajax;
          if (200 !== e.xmlDoc.status) return void this._errorResponse(e, i);
          if (window.JSON) {
            var a;
            try {
              a = JSON.parse(e.xmlDoc.responseText);
            } catch (t2) {
              e.xmlDoc.responseText.length || (a = {});
            }
            if (a) {
              var r = a.action || this.getState(i) || "updated", s = a.sid || i[0], o = a.tid || i[0];
              return t.afterUpdateCallback(s, o, r, a), void t.finalizeUpdate();
            }
          }
          var d = n.xmltop("data", e.xmlDoc);
          if (!d) return this._errorResponse(e, i);
          var l = n.xpath("//data/action", d);
          l.length || this._errorResponse(e, i);
          for (var _ = 0; _ < l.length; _++) {
            var h = l[_], r = h.getAttribute("type"), s = h.getAttribute("sid"), o = h.getAttribute("tid");
            t.afterUpdateCallback(s, o, r, h);
          }
          t.finalizeUpdate();
        },
        cleanUpdate: function(t) {
          if (t) for (var e = 0; e < t.length; e++) delete this._in_progress[t[e]];
        },
        finalizeUpdate: function() {
          this._waitMode && this._waitMode--, ("tree" == this.obj.mytype || this.obj._h2) && this.updatedRows.length && this.sendData(), this.callEvent("onAfterUpdateFinish", []), this.updatedRows.length || this.callEvent("onFullSync", []);
        },
        init: function(t) {
          this.obj = t, this.obj._dp_init && this.obj._dp_init(this);
        },
        setOnAfterUpdate: function(t) {
          this.attachEvent("onAfterUpdate", t);
        },
        enableDebug: function(t) {
        },
        setOnBeforeUpdateHandler: function(t) {
          this.attachEvent("onBeforeDataSending", t);
        },
        setAutoUpdate: function(t, e) {
          t = t || 2e3, this._user = e || (/* @__PURE__ */ new Date()).valueOf(), this._need_update = false, this._update_busy = false, this.attachEvent("onAfterUpdate", function(t2, e2, i2, n) {
            this.afterAutoUpdate(t2, e2, i2, n);
          }), this.attachEvent("onFullSync", function() {
            this.fullSync();
          });
          var i = this;
          window.setInterval(function() {
            i.loadUpdate();
          }, t);
        },
        afterAutoUpdate: function(t, e, i, n) {
          return "collision" != e || (this._need_update = true, false);
        },
        fullSync: function() {
          return this._need_update && (this._need_update = false, this.loadUpdate()), true;
        },
        getUpdates: function(t, e) {
          var i = this.obj.$ajax;
          if (this._update_busy) return false;
          this._update_busy = true, i.get(t, e);
        },
        _v: function(t) {
          return t.firstChild ? t.firstChild.nodeValue : "";
        },
        _a: function(t) {
          for (var e = [], i = 0; i < t.length; i++) e[i] = this._v(t[i]);
          return e;
        },
        loadUpdate: function() {
          var t = this.obj.$ajax, e = this, i = this.obj.getUserData(0, "version"), n = this.serverProcessor + t.urlSeparator(this.serverProcessor) + ["dhx_user=" + this._user, "dhx_version=" + i].join("&");
          n = n.replace("editing=true&", ""), this.getUpdates(n, function(i2) {
            var n2 = t.xpath("//userdata", i2);
            e.obj.setUserData(0, "version", e._v(n2[0]));
            var a = t.xpath("//update", i2);
            if (a.length) {
              e._silent_mode = true;
              for (var r = 0; r < a.length; r++) {
                var s = a[r].getAttribute("status"), o = a[r].getAttribute("id"), d = a[r].getAttribute("parent");
                switch (s) {
                  case "inserted":
                    e.callEvent("insertCallback", [a[r], o, d]);
                    break;
                  case "updated":
                    e.callEvent("updateCallback", [a[r], o, d]);
                    break;
                  case "deleted":
                    e.callEvent("deleteCallback", [a[r], o, d]);
                }
              }
              e._silent_mode = false;
            }
            e._update_busy = false, e = null;
          });
        }
      }, window.dataProcessor && !dataProcessor.prototype.init_original && (dataProcessor.prototype.init_original = dataProcessor.prototype.init, dataProcessor.prototype.init = function(t) {
        this.init_original(t), t._dataprocessor = this, this.setTransactionMode("POST", true), this.serverProcessor += (-1 != this.serverProcessor.indexOf("?") ? "&" : "?") + "editing=true";
      }), dhtmlxError.catchError("LoadXML", function(t, e, i) {
        var n = i[0].responseText;
        switch (scheduler.config.ajax_error) {
          case "alert":
            window.alert(n);
            break;
          case "console":
            window.console.log(n);
        }
      });
      var Scheduler = { _seed: 0 };
      Scheduler.plugin = function(t) {
        this._schedulerPlugins.push(t), t(window.scheduler);
      }, Scheduler._schedulerPlugins = [], Scheduler.getSchedulerInstance = function() {
        function t(t2) {
          var e2 = document.createElement("div");
          return (t2 || "").split(" ").forEach(function(t3) {
            e2.classList.add(t3);
          }), e2;
        }
        function e(t2) {
          var e2;
          if (t2.view) switch (t2.view) {
            case "today":
            case "next":
            case "prev":
              e2 = p.builtInButton;
              break;
            case "date":
              e2 = p.date;
              break;
            case "spacer":
              e2 = p.spacer;
              break;
            case "button":
              e2 = p.button;
              break;
            case "minicalendar":
              e2 = p.minicalendarButton;
              break;
            default:
              e2 = p.view;
          }
          else t2.rows ? e2 = p.rows_container : t2.cols && (e2 = p.row);
          return e2;
        }
        function i(t2) {
          var i2 = e(t2);
          if (i2) {
            var n2 = i2(t2);
            if (t2.css && n2.classList.add(t2.css), t2.width) {
              var a2 = t2.width;
              a2 === 1 * a2 && (a2 += "px"), n2.style.width = a2;
            }
            if (t2.height) {
              var a2 = t2.height;
              a2 === 1 * a2 && (a2 += "px"), n2.style.height = a2;
            }
            if (t2.click && n2.addEventListener("click", t2.click), t2.html && (n2.innerHTML = t2.html), t2.align) {
              var a2 = "";
              "right" == t2.align ? a2 = "flex-end" : "left" == t2.align && (a2 = "flex-start"), n2.style.justifyContent = a2;
            }
            return n2;
          }
        }
        function n(t2) {
          return "string" == typeof t2 && (t2 = { view: t2 }), t2.view || t2.rows || t2.cols || (t2.view = "button"), t2;
        }
        function a(t2) {
          var e2, r2 = document.createDocumentFragment();
          e2 = Array.isArray(t2) ? t2 : [t2];
          for (var s2 = 0; s2 < e2.length; s2++) {
            var o2 = n(e2[s2]);
            if ("day" === o2.view && e2[s2 + 1]) {
              var d2 = n(e2[s2 + 1]);
              "week" !== d2.view && "month" !== d2.view || (o2.$firstTab = true);
            }
            if ("month" === o2.view && e2[s2 - 1]) {
              var d2 = n(e2[s2 - 1]);
              "week" !== d2.view && "day" !== d2.view || (o2.$lastTab = true);
            }
            var l2 = i(o2);
            r2.appendChild(l2), (o2.cols || o2.rows) && l2.appendChild(a(o2.cols || o2.rows));
          }
          return r2;
        }
        function r(t2) {
          return !!(t2.querySelector(".dhx_cal_header") && t2.querySelector(".dhx_cal_data") && t2.querySelector(".dhx_cal_navline"));
        }
        function s(t2) {
          var e2 = ["day", "week", "month"], i2 = ["date"], n2 = ["prev", "today", "next"];
          if (t2.matrix) for (var a2 in t2.matrix) e2.push(a2);
          if (t2._props) for (var a2 in t2._props) e2.push(a2);
          if (t2._grid && t2._grid.names) for (var a2 in t2._grid.names) e2.push(a2);
          return ["map", "agenda", "week_agenda", "year"].forEach(function(i3) {
            t2[i3 + "_view"] && e2.push(i3);
          }), e2.concat(i2).concat(n2);
        }
        function o(t2) {
          return Array.isArray ? Array.isArray(t2) : t2 && void 0 !== t2.length && t2.pop && t2.push;
        }
        function d(t2) {
          return t2 && "object" == typeof t2 && "function String() { [native code] }" === Function.prototype.toString.call(t2.constructor);
        }
        function l(t2) {
          return t2 && "object" == typeof t2 && "function Number() { [native code] }" === Function.prototype.toString.call(t2.constructor);
        }
        function _(t2) {
          return t2 && "object" == typeof t2 && "function Boolean() { [native code] }" === Function.prototype.toString.call(t2.constructor);
        }
        function h(t2) {
          return !(!t2 || "object" != typeof t2) && !!(t2.getFullYear && t2.getMonth && t2.getDate);
        }
        function c() {
          if (void 0 === A) {
            var t2 = document.createElement("div");
            t2.style.position = "absolute", t2.style.left = "-9999px", t2.style.top = "-9999px", t2.innerHTML = "<div class='dhx_cal_container'><div class='dhx_cal_scale_placeholder'></div><div>", document.body.appendChild(t2);
            var e2 = window.getComputedStyle(t2.querySelector(".dhx_cal_scale_placeholder")), i2 = e2.getPropertyValue("position");
            A = "absolute" === i2, setTimeout(function() {
              A = null;
            }, 500);
          }
          return A;
        }
        function u() {
          if (g._is_material_skin()) return true;
          if (void 0 !== k) return k;
          var t2 = document.createElement("div");
          t2.style.position = "absolute", t2.style.left = "-9999px", t2.style.top = "-9999px", t2.innerHTML = "<div class='dhx_cal_container'><div class='dhx_cal_data'><div class='dhx_cal_event'><div class='dhx_body'></div></div><div>", document.body.appendChild(t2);
          var e2 = window.getComputedStyle(t2.querySelector(".dhx_body")), i2 = e2.getPropertyValue("box-sizing");
          document.body.removeChild(t2), (k = !("border-box" !== i2)) || setTimeout(function() {
            k = void 0;
          }, 1e3);
        }
        function f() {
          if (!g._is_material_skin() && !g._border_box_events()) {
            var t2 = k;
            k = void 0, A = void 0;
            t2 !== u() && g.$container && g.setCurrentView();
          }
        }
        var g = { version: "5.3.10" }, v = {
          agenda: "https://docs.dhtmlx.com/scheduler/agenda_view.html",
          grid: "https://docs.dhtmlx.com/scheduler/grid_view.html",
          map: "https://docs.dhtmlx.com/scheduler/map_view.html",
          unit: "https://docs.dhtmlx.com/scheduler/units_view.html",
          timeline: "https://docs.dhtmlx.com/scheduler/timeline_view.html",
          week_agenda: "https://docs.dhtmlx.com/scheduler/weekagenda_view.html",
          year: "https://docs.dhtmlx.com/scheduler/year_view.html",
          anythingElse: "https://docs.dhtmlx.com/scheduler/views.html"
        }, m = {
          agenda: "ext/dhtmlxscheduler_agenda_view.js",
          grid: "ext/dhtmlxscheduler_grid_view.js",
          map: "ext/dhtmlxscheduler_map_view.js",
          unit: "ext/dhtmlxscheduler_units.js",
          timeline: "ext/dhtmlxscheduler_timeline.js, ext/dhtmlxscheduler_treetimeline.js, ext/dhtmlxscheduler_daytimeline.js",
          week_agenda: "ext/dhtmlxscheduler_week_agenda.js",
          year: "ext/dhtmlxscheduler_year_view.js",
          limit: "ext/dhtmlxscheduler_limit.js"
        };
        g._commonErrorMessages = { unknownView: function(t2) {
          var e2 = "Related docs: " + (v[t2] || v.anythingElse), i2 = m[t2] ? "You're probably missing " + m[t2] + "." : "";
          return "`" + t2 + "` view is not defined. \nPlease check parameters you pass to `scheduler.init` or `scheduler.setCurrentView` in your code and ensure you've imported appropriate extensions. \n" + e2 + "\n" + (i2 ? i2 + "\n" : "");
        }, collapsedContainer: function(t2) {
          return "Scheduler container height is set to *100%* but the rendered height is zero and the scheduler is not visible. \nMake sure that the container has some initial height or use different units. For example:\n<div id='scheduler_here' class='dhx_cal_container' style='width:100%; height:600px;'> \n";
        } }, g.createTimelineView = function() {
          throw new Error("scheduler.createTimelineView is not implemented. Be sure to add the required extension: " + m.timeline + "\nRelated docs: " + v.timeline);
        }, g.createUnitsView = function() {
          throw new Error("scheduler.createUnitsView is not implemented. Be sure to add the required extension: " + m.unit + "\nRelated docs: " + v.unit);
        }, g.createGridView = function() {
          throw new Error("scheduler.createGridView is not implemented. Be sure to add the required extension: " + m.grid + "\nRelated docs: " + v.grid);
        }, g.addMarkedTimespan = function() {
          throw new Error("scheduler.addMarkedTimespan is not implemented. Be sure to add the required extension: ext/dhtmlxscheduler_limit.js\nRelated docs: https://docs.dhtmlx.com/scheduler/limits.html");
        }, g.renderCalendar = function() {
          throw new Error("scheduler.renderCalendar is not implemented. Be sure to add the required extension: ext/dhtmlxscheduler_minical.js\nhttps://docs.dhtmlx.com/scheduler/minicalendar.html");
        }, g.exportToPNG = function() {
          throw new Error(["scheduler.exportToPNG is not implemented.", "This feature requires an additional module, be sure to check the related doc here https://docs.dhtmlx.com/scheduler/png.html", "Licensing info: https://dhtmlx.com/docs/products/dhtmlxScheduler/export.shtml"].join("\n"));
        }, g.exportToPDF = function() {
          throw new Error(["scheduler.exportToPDF is not implemented.", "This feature requires an additional module, be sure to check the related doc here https://docs.dhtmlx.com/scheduler/pdf.html", "Licensing info: https://dhtmlx.com/docs/products/dhtmlxScheduler/export.shtml"].join("\n"));
        }, dhtmlxEventable(g);
        var p = {
          rows_container: function() {
            return t("dhx_cal_navbar_rows_container");
          },
          row: function() {
            return t("dhx_cal_navbar_row");
          },
          view: function(e2) {
            var i2 = t("dhx_cal_tab");
            return i2.setAttribute("name", e2.view + "_tab"), i2.setAttribute("data-viewname", e2.view), g.config.fix_tab_position && (e2.$firstTab ? i2.classList.add("dhx_cal_tab_first") : e2.$lastTab ? i2.classList.add("dhx_cal_tab_last") : "week" !== e2.view && i2.classList.add("dhx_cal_tab_standalone")), i2;
          },
          date: function() {
            return t("dhx_cal_date");
          },
          button: function(e2) {
            return t("dhx_cal_nav_button dhx_cal_nav_button_custom dhx_cal_tab");
          },
          builtInButton: function(e2) {
            return t("dhx_cal_" + e2.view + "_button dhx_cal_nav_button");
          },
          spacer: function() {
            return t("dhx_cal_line_spacer");
          },
          minicalendarButton: function(e2) {
            var i2 = t("dhx_minical_icon");
            return e2.click || (i2.onclick = function() {
              g.isCalendarVisible() ? g.destroyCalendar() : g.renderCalendar({ position: this, date: g.getState().date, navigation: true, handler: function(t2, e3) {
                g.setCurrentView(t2), g.destroyCalendar();
              } });
            }), i2;
          },
          html_element: function(e2) {
            return t("dhx_cal_nav_content");
          }
        };
        g._init_nav_bar = function(t2) {
          var e2 = this.$container.querySelector(".dhx_cal_navline");
          return e2 || (e2 = document.createElement("div"), e2.className = "dhx_cal_navline dhx_cal_navline_flex", g._update_nav_bar(t2, e2), e2);
        };
        var x = null, b = null;
        g._update_nav_bar = function(t2, e2) {
          if (t2) {
            var i2 = false, n2 = false, r2 = t2.height || g.xy.nav_height;
            null !== b && b === r2 || (i2 = true), x && JSON.stringify(t2) === x || (n2 = true), i2 && (g.xy.nav_height = r2), n2 && (e2.innerHTML = "", e2.appendChild(a(t2))), (i2 || n2) && (g._els = [], g.get_elements(), g.set_actions()), e2.style.display = 0 === r2 ? "none" : "", b = r2;
          }
        }, g._detachDomEvent = function(t2, e2, i2) {
          t2.removeEventListener ? t2.removeEventListener(e2, i2, false) : t2.detachEvent && t2.detachEvent("on" + e2, i2);
        }, g._init_once = function() {
          function t2(t3) {
            for (var e3 = document.body; t3 && t3 != e3; ) t3 = t3.parentNode;
            return !(e3 != t3);
          }
          function e2(t3) {
            return { w: t3.innerWidth || document.documentElement.clientWidth, h: t3.innerHeight || document.documentElement.clientHeight };
          }
          function i2(t3, e3) {
            return t3.w == e3.w && t3.h == e3.h;
          }
          function n2(n3, a3) {
            var r2, s2 = e2(a3);
            a3.addEventListener("resize", function() {
              clearTimeout(r2), r2 = setTimeout(function() {
                if (t2(n3.$container)) {
                  var r3 = e2(a3);
                  i2(s2, r3) || (s2 = r3, n3.callEvent("onSchedulerResize", []) && (n3.updateView(), n3.callEvent("onAfterSchedulerResize", [])));
                }
              }, 150);
            });
          }
          function a2(t3) {
            var e3 = t3.$container;
            "static" == window.getComputedStyle(e3).getPropertyValue("position") && (e3.style.position = "relative");
            var i3 = document.createElement("iframe");
            i3.className = "scheduler_container_resize_watcher", i3.tabIndex = -1, t3.config.wai_aria_attributes && (i3.setAttribute("role", "none"), i3.setAttribute("aria-hidden", true)), e3.appendChild(i3), i3.contentWindow ? n2(t3, i3.contentWindow) : (e3.removeChild(i3), n2(t3, window));
          }
          a2(g), g._init_once = function() {
          };
        };
        var y = { navbar: { render: function(t2) {
          return g._init_nav_bar(t2);
        } }, header: { render: function(t2) {
          var e2 = document.createElement("div");
          return e2.className = "dhx_cal_header", e2;
        } }, dataArea: { render: function(t2) {
          var e2 = document.createElement("div");
          return e2.className = "dhx_cal_data", e2;
        } }, html_element: { render: function(t2) {
          return t2.html;
        } } };
        g.init = function(t2, e2, i2) {
          if (e2 = e2 || g._currentDate(), i2 = i2 || "week", this._obj && this.unset_actions(), this._obj = "string" == typeof t2 ? document.getElementById(t2) : t2, this.$container = this._obj, !this.$container.offsetHeight && this.$container.offsetWidth && "100%" === this.$container.style.height && window.console.error(g._commonErrorMessages.collapsedContainer(), this.$container), this.config.wai_aria_attributes && this.config.wai_aria_application_role && this.$container.setAttribute("role", "application"), this.config.header || r(this.$container) || (this.config.header = s(this), console.log(["Required DOM elements are missing from the scheduler container and **scheduler.config.header** is not specified.", "Using a default header configuration: ", "scheduler.config.header = " + JSON.stringify(this.config.header, null, 2), "Check this article for the details: https://docs.dhtmlx.com/scheduler/initialization.html"].join("\n"))), this.config.header) this.$container.innerHTML = "", this.$container.classList.add("dhx_cal_container"), this.config.header.height && (this.xy.nav_height = this.config.header.height), this.$container.appendChild(y.navbar.render(this.config.header)), this.$container.appendChild(y.header.render()), this.$container.appendChild(y.dataArea.render());
          else if (!r(this.$container)) throw new Error(["Required DOM elements are missing from the scheduler container.", "Be sure to either specify them manually in the markup: https://docs.dhtmlx.com/scheduler/initialization.html#initializingschedulerviamarkup", "Or to use **scheduler.config.header** setting so they could be created automatically: https://docs.dhtmlx.com/scheduler/initialization.html#initializingschedulerviaheaderconfig"].join("\n"));
          this.config.rtl && (this.$container.className += " dhx_cal_container_rtl"), this._skin_init && g._skin_init(), g.date.init(), this._scroll = true, this._quirks = this.$env.isIE && "BackCompat" == document.compatMode, this._quirks7 = this.$env.isIE && -1 == navigator.appVersion.indexOf("MSIE 8"), this._els = [], this.get_elements(), this.init_templates(), this.set_actions(), this._init_once(), this._init_touch_events(), this.set_sizes(), g.callEvent("onSchedulerReady", []), this.setCurrentView(e2, i2);
        }, g.xy = {
          min_event_height: 40,
          scale_width: 50,
          scroll_width: 18,
          scale_height: 20,
          month_scale_height: 20,
          menu_width: 25,
          margin_top: 0,
          margin_left: 0,
          editor_width: 140,
          month_head_height: 22,
          event_header_height: 14
        }, g.keys = { edit_save: 13, edit_cancel: 27 }, g.bind = function(t2, e2) {
          return t2.bind ? t2.bind(e2) : function() {
            return t2.apply(e2, arguments);
          };
        }, g.set_sizes = function() {
          var t2 = this._x = this._obj.clientWidth - this.xy.margin_left, e2 = this._y = this._obj.clientHeight - this.xy.margin_top, i2 = this._table_view ? 0 : this.xy.scale_width + this.xy.scroll_width, n2 = this._table_view ? -1 : this.xy.scale_width, a2 = this.$container.querySelector(".dhx_cal_scale_placeholder");
          g._is_material_skin() ? (a2 || (a2 = document.createElement("div"), a2.className = "dhx_cal_scale_placeholder", this.$container.insertBefore(a2, this._els.dhx_cal_header[0])), a2.style.display = "block", this.set_xy(a2, t2, this.xy.scale_height + 1, 0, this.xy.nav_height + (this._quirks ? -1 : 1))) : a2 && a2.parentNode.removeChild(a2), this._lightbox && (g.$container.offsetWidth < 1200 || this._setLbPosition(document.querySelector(".dhx_cal_light"))), this.set_xy(this._els.dhx_cal_navline[0], t2, this.xy.nav_height, 0, 0), this.set_xy(this._els.dhx_cal_header[0], t2 - i2, this.xy.scale_height, n2, this.xy.nav_height + (this._quirks ? -1 : 1));
          var r2 = this._els.dhx_cal_navline[0].offsetHeight;
          r2 > 0 && (this.xy.nav_height = r2);
          var s2 = this.xy.scale_height + this.xy.nav_height + (this._quirks ? -2 : 0);
          this.set_xy(this._els.dhx_cal_data[0], t2, e2 - (s2 + 2), 0, s2 + 2);
        }, g.set_xy = function(t2, e2, i2, n2, a2) {
          var r2 = "left";
          t2.style.width = Math.max(0, e2) + "px", t2.style.height = Math.max(0, i2) + "px", arguments.length > 3 && (this.config.rtl && (r2 = "right"), t2.style[r2] = n2 + "px", t2.style.top = a2 + "px");
        }, g.get_elements = function() {
          for (var t2 = this._obj.getElementsByTagName("DIV"), e2 = 0; e2 < t2.length; e2++) {
            var i2 = g._getClassName(t2[e2]), n2 = t2[e2].getAttribute("name") || "";
            i2 && (i2 = i2.split(" ")[0]), this._els[i2] || (this._els[i2] = []), this._els[i2].push(t2[e2]);
            var a2 = g.locale.labels[n2 || i2];
            "string" != typeof a2 && n2 && !t2[e2].innerHTML && (a2 = n2.split("_")[0]), a2 && (this._waiAria.labelAttr(t2[e2], a2), t2[e2].innerHTML = a2);
          }
        }, g.unset_actions = function() {
          for (var t2 in this._els) if (this._click[t2]) for (var e2 = 0; e2 < this._els[t2].length; e2++) this._els[t2][e2].onclick = null;
          this._obj.onselectstart = null, this._obj.onmousemove = null, this._obj.onmousedown = null, this._obj.onmouseup = null, this._obj.ondblclick = null, this._obj.oncontextmenu = null;
        }, g.set_actions = function() {
          for (var t2 in this._els) if (this._click[t2]) for (var e2 = 0; e2 < this._els[t2].length; e2++) this._els[t2][e2].onclick = g._click[t2];
          this._obj.onselectstart = function(t3) {
            return false;
          }, this._obj.onmousemove = function(t3) {
            g._temp_touch_block || g._on_mouse_move(t3 || event);
          }, this._obj.onmousedown = function(t3) {
            g._ignore_next_click || g._on_mouse_down(t3 || event);
          }, this._obj.onmouseup = function(t3) {
            g._ignore_next_click || g._on_mouse_up(t3 || event);
          }, this._obj.ondblclick = function(t3) {
            g._on_dbl_click(t3 || event);
          }, this._obj.oncontextmenu = function(t3) {
            var e3 = t3 || event, i2 = e3.target || e3.srcElement;
            return g.callEvent("onContextMenu", [g._locate_event(i2), e3]);
          };
        }, g.select = function(t2) {
          this._select_id != t2 && (g._close_not_saved(), this.editStop(false), this.unselect(), this._select_id = t2, this.updateEvent(t2), this.callEvent("onEventSelected", [t2]));
        }, g.unselect = function(t2) {
          if (!t2 || t2 == this._select_id) {
            var e2 = this._select_id;
            this._select_id = null, e2 && this.getEvent(e2) && this.updateEvent(e2), this.callEvent("onEventUnselected", [e2]);
          }
        }, g.getState = function() {
          return { mode: this._mode, date: new Date(this._date), min_date: new Date(this._min_date), max_date: new Date(this._max_date), editor_id: this._edit_id, lightbox_id: this._lightbox_id, new_event: this._new_event, select_id: this._select_id, expanded: this.expanded, drag_id: this._drag_id, drag_mode: this._drag_mode };
        }, g._click = {
          dhx_cal_data: function(t2) {
            if (g._ignore_next_click) return t2.preventDefault && t2.preventDefault(), t2.cancelBubble = true, g._ignore_next_click = false, false;
            var e2 = t2 ? t2.target : event.srcElement, i2 = g._locate_event(e2);
            if (t2 = t2 || event, i2) {
              if (!g.callEvent("onClick", [i2, t2]) || g.config.readonly) return;
            } else g.callEvent("onEmptyClick", [g.getActionData(t2).date, t2]);
            if (i2 && g.config.select) {
              g.select(i2);
              var n2 = g._getClassName(e2);
              -1 != n2.indexOf("_icon") && g._click.buttons[n2.split(" ")[1].replace("icon_", "")](i2);
            } else g._close_not_saved(), (/* @__PURE__ */ new Date()).valueOf() - (g._new_event || 0) > 500 && g.unselect();
          },
          dhx_cal_prev_button: function() {
            g._click.dhx_cal_next_button(0, -1);
          },
          dhx_cal_next_button: function(t2, e2) {
            var i2 = 1;
            g.config.rtl && (e2 = -e2, i2 = -i2), g.setCurrentView(g.date.add(g.date[g._mode + "_start"](new Date(g._date)), e2 || i2, g._mode));
          },
          dhx_cal_today_button: function() {
            g.callEvent("onBeforeTodayDisplayed", []) && g.setCurrentView(g._currentDate());
          },
          dhx_cal_tab: function() {
            var t2 = this.getAttribute("name"), e2 = t2.substring(0, t2.search("_tab"));
            g.setCurrentView(g._date, e2);
          },
          buttons: { delete: function(t2) {
            var e2 = g.locale.labels.confirm_deleting;
            g._dhtmlx_confirm(e2, g.locale.labels.title_confirm_deleting, function() {
              g.deleteEvent(t2);
            });
          }, edit: function(t2) {
            g.edit(t2);
          }, save: function(t2) {
            g.editStop(true);
          }, details: function(t2) {
            g.showLightbox(t2);
          }, cancel: function(t2) {
            g.editStop(false);
          } }
        }, g._dhtmlx_confirm = function(t2, e2, i2) {
          if (!t2) return i2();
          var n2 = { text: t2 };
          e2 && (n2.title = e2), i2 && (n2.callback = function(t3) {
            t3 && i2();
          }), dhtmlx.confirm(n2);
        }, g.addEventNow = function(t2, e2, i2) {
          var n2 = {};
          g._isObject(t2) && !g._isDate(t2) && (n2 = t2, t2 = null);
          var a2 = 6e4 * (this.config.event_duration || this.config.time_step);
          t2 || (t2 = n2.start_date || Math.round(g._currentDate().valueOf() / a2) * a2);
          var r2 = new Date(t2);
          if (!e2) {
            var s2 = this.config.first_hour;
            s2 > r2.getHours() && (r2.setHours(s2), t2 = r2.valueOf()), e2 = t2.valueOf() + a2;
          }
          var o2 = new Date(e2);
          r2.valueOf() == o2.valueOf() && o2.setTime(o2.valueOf() + a2), n2.start_date = n2.start_date || r2, n2.end_date = n2.end_date || o2, n2.text = n2.text || this.locale.labels.new_event, n2.id = this._drag_id = n2.id || this.uid(), this._drag_mode = "new-size", this._loading = true;
          var d2 = this.addEvent(n2);
          return this.callEvent("onEventCreated", [this._drag_id, i2]), this._loading = false, this._drag_event = {}, this._on_mouse_up(i2), d2;
        }, g._on_dbl_click = function(t2, e2) {
          if (e2 = e2 || t2.target || t2.srcElement, !this.config.readonly) {
            var i2 = g._getClassName(e2).split(" ")[0];
            switch (i2) {
              case "dhx_scale_holder":
              case "dhx_scale_holder_now":
              case "dhx_month_body":
              case "dhx_wa_day_data":
                if (!g.config.dblclick_create) break;
                this.addEventNow(this.getActionData(t2).date, null, t2);
                break;
              case "dhx_cal_event":
              case "dhx_wa_ev_body":
              case "dhx_agenda_line":
              case "dhx_grid_event":
              case "dhx_cal_event_line":
              case "dhx_cal_event_clear":
                var n2 = this._locate_event(e2);
                if (!this.callEvent("onDblClick", [n2, t2])) return;
                this.config.details_on_dblclick || this._table_view || !this.getEvent(n2)._timed || !this.config.select ? this.showLightbox(n2) : this.edit(n2);
                break;
              case "dhx_time_block":
              case "dhx_cal_container":
                return;
              default:
                var a2 = this["dblclick_" + i2];
                if (a2) a2.call(this, t2);
                else if (e2.parentNode && e2 != this) return g._on_dbl_click(t2, e2.parentNode);
            }
          }
        }, g._get_column_index = function(t2) {
          var e2 = 0;
          if (this._cols) {
            for (var i2 = 0, n2 = 0; i2 + this._cols[n2] < t2 && n2 < this._cols.length; ) i2 += this._cols[n2], n2++;
            if (e2 = n2 + (this._cols[n2] ? (t2 - i2) / this._cols[n2] : 0), this._ignores && e2 >= this._cols.length) for (; e2 >= 1 && this._ignores[Math.floor(e2)]; ) e2--;
          }
          return e2;
        }, g._week_indexes_from_pos = function(t2) {
          if (this._cols) {
            var e2 = this._get_column_index(t2.x);
            return t2.x = Math.min(this._cols.length - 1, Math.max(0, Math.ceil(e2) - 1)), t2.y = Math.max(0, Math.ceil(60 * t2.y / (this.config.time_step * this.config.hour_size_px)) - 1) + this.config.first_hour * (60 / this.config.time_step), t2;
          }
          return t2;
        }, g._mouse_coords = function(t2) {
          var e2, i2 = document.body, n2 = document.documentElement;
          e2 = this.$env.isIE || !t2.pageX && !t2.pageY ? { x: t2.clientX + (i2.scrollLeft || n2.scrollLeft || 0) - i2.clientLeft, y: t2.clientY + (i2.scrollTop || n2.scrollTop || 0) - i2.clientTop } : { x: t2.pageX, y: t2.pageY }, this.config.rtl && this._colsS ? (e2.x = this.$container.querySelector(".dhx_cal_data").offsetWidth - e2.x, "month" !== this._mode && (e2.x -= this.xy.scale_width)) : e2.x -= this.$domHelpers.getAbsoluteLeft(this._obj) + (this._table_view ? 0 : this.xy.scale_width);
          var a2 = this.$container.querySelector(".dhx_cal_data");
          e2.y -= this.$domHelpers.getAbsoluteTop(a2) - this._els.dhx_cal_data[0].scrollTop, e2.ev = t2;
          var r2 = this["mouse_" + this._mode];
          if (r2) e2 = r2.call(this, e2);
          else if (this._table_view) {
            var s2 = this._get_column_index(e2.x);
            if (!this._cols || !this._colsS) return e2;
            var o2 = 0;
            for (o2 = 1; o2 < this._colsS.heights.length && !(this._colsS.heights[o2] > e2.y); o2++) ;
            e2.y = Math.ceil(24 * (Math.max(0, s2) + 7 * Math.max(0, o2 - 1)) * 60 / this.config.time_step), (g._drag_mode || "month" == this._mode) && (e2.y = 24 * (Math.max(0, Math.ceil(s2) - 1) + 7 * Math.max(0, o2 - 1)) * 60 / this.config.time_step), "move" == this._drag_mode && g._ignores_detected && g.config.preserve_length && (e2._ignores = true, this._drag_event._event_length || (this._drag_event._event_length = this._get_real_event_length(this._drag_event.start_date, this._drag_event.end_date, { x_step: 1, x_unit: "day" }))), e2.x = 0;
          } else e2 = this._week_indexes_from_pos(e2);
          return e2.timestamp = +/* @__PURE__ */ new Date(), e2;
        }, g._close_not_saved = function() {
          if ((/* @__PURE__ */ new Date()).valueOf() - (g._new_event || 0) > 500 && g._edit_id) {
            var t2 = g.locale.labels.confirm_closing;
            g._dhtmlx_confirm(t2, g.locale.labels.title_confirm_closing, function() {
              g.editStop(g.config.positive_closing);
            }), t2 && (this._drag_id = this._drag_pos = this._drag_mode = null);
          }
        }, g._correct_shift = function(t2, e2) {
          return t2 -= 6e4 * (new Date(g._min_date).getTimezoneOffset() - new Date(t2).getTimezoneOffset()) * (e2 ? -1 : 1);
        }, g._is_pos_changed = function(t2, e2) {
          function i2(t3, e3, i3) {
            return !!(Math.abs(t3 - e3) > i3);
          }
          if (!t2 || !this._drag_pos) return true;
          var n2 = 5;
          return !!(this._drag_pos.has_moved || !this._drag_pos.timestamp || e2.timestamp - this._drag_pos.timestamp > 100 || i2(t2.ev.clientX, e2.ev.clientX, n2) || i2(t2.ev.clientY, e2.ev.clientY, n2));
        }, g._correct_drag_start_date = function(t2) {
          var e2;
          g.matrix && (e2 = g.matrix[g._mode]), e2 = e2 || { x_step: 1, x_unit: "day" }, t2 = new Date(t2);
          var i2 = 1;
          return (e2._start_correction || e2._end_correction) && (i2 = 60 * (e2.last_hour || 0) - (60 * t2.getHours() + t2.getMinutes()) || 1), 1 * t2 + (g._get_fictional_event_length(t2, i2, e2) - i2);
        }, g._correct_drag_end_date = function(t2, e2) {
          var i2;
          g.matrix && (i2 = g.matrix[g._mode]), i2 = i2 || { x_step: 1, x_unit: "day" };
          var n2 = 1 * t2 + g._get_fictional_event_length(t2, e2, i2);
          return new Date(1 * n2 - (g._get_fictional_event_length(n2, -1, i2, -1) + 1));
        }, g._on_mouse_move = function(t2) {
          if (this._drag_mode) {
            var e2 = this._mouse_coords(t2);
            if (this._is_pos_changed(this._drag_pos, e2)) {
              var i2, n2;
              if (this._edit_id != this._drag_id && this._close_not_saved(), !this._drag_mode) return;
              var a2 = null;
              if (this._drag_pos && !this._drag_pos.has_moved && (a2 = this._drag_pos, a2.has_moved = true), this._drag_pos = e2, this._drag_pos.has_moved = true, "create" == this._drag_mode) {
                if (a2 && (e2 = a2), this._close_not_saved(), this.unselect(this._select_id), this._loading = true, i2 = this._get_date_from_pos(e2).valueOf(), !this._drag_start) {
                  return this.callEvent("onBeforeEventCreated", [t2, this._drag_id]) ? (this._loading = false, void (this._drag_start = i2)) : void (this._loading = false);
                }
                n2 = i2, this._drag_start;
                var r2 = new Date(this._drag_start), s2 = new Date(n2);
                "day" != this._mode && "week" != this._mode || r2.getHours() != s2.getHours() || r2.getMinutes() != s2.getMinutes() || (s2 = new Date(this._drag_start + 1e3)), this._drag_id = this.uid(), this.addEvent(r2, s2, this.locale.labels.new_event, this._drag_id, e2.fields), this.callEvent("onEventCreated", [this._drag_id, t2]), this._loading = false, this._drag_mode = "new-size";
              }
              var o2, d2 = this.config.time_step, l2 = this.getEvent(this._drag_id);
              if (g.matrix && (o2 = g.matrix[g._mode]), o2 = o2 || { x_step: 1, x_unit: "day" }, "move" == this._drag_mode) i2 = this._min_date.valueOf() + 6e4 * (e2.y * this.config.time_step + 24 * e2.x * 60), !e2.custom && this._table_view && (i2 += 1e3 * this.date.time_part(l2.start_date)), !this._table_view && this._dragEventBody && void 0 === this._drag_event._move_event_shift && (this._drag_event._move_event_shift = i2 - l2.start_date), this._drag_event._move_event_shift && (i2 -= this._drag_event._move_event_shift), i2 = this._correct_shift(i2), e2._ignores && this.config.preserve_length && this._table_view ? (i2 = g._correct_drag_start_date(i2), n2 = g._correct_drag_end_date(i2, this._drag_event._event_length)) : n2 = l2.end_date.valueOf() - (l2.start_date.valueOf() - i2);
              else {
                if (i2 = l2.start_date.valueOf(), n2 = l2.end_date.valueOf(), this._table_view) {
                  var _2 = this._min_date.valueOf() + e2.y * this.config.time_step * 6e4 + (e2.custom ? 0 : 864e5);
                  if ("month" == this._mode) if (_2 = this._correct_shift(_2, false), this._drag_from_start) {
                    var h2 = 864e5;
                    _2 <= g.date.date_part(new Date(n2 + h2 - 1)).valueOf() && (i2 = _2 - h2);
                  } else n2 = _2;
                  else this.config.preserve_length ? e2.resize_from_start ? i2 = g._correct_drag_start_date(_2) : n2 = g._correct_drag_end_date(_2, 0) : e2.resize_from_start ? i2 = _2 : n2 = _2;
                } else {
                  var c2 = this.date.date_part(new Date(l2.end_date.valueOf() - 1)).valueOf(), u2 = new Date(c2), f2 = this.config.first_hour, v2 = this.config.last_hour, m2 = 60 / d2 * (v2 - f2);
                  this.config.time_step = 1;
                  var p2 = this._mouse_coords(t2);
                  this.config.time_step = d2;
                  var x2 = e2.y * d2 * 6e4, b2 = Math.min(e2.y + 1, m2) * d2 * 6e4, y2 = 6e4 * p2.y;
                  n2 = Math.abs(x2 - y2) > Math.abs(b2 - y2) ? c2 + b2 : c2 + x2, n2 += 6e4 * (new Date(n2).getTimezoneOffset() - u2.getTimezoneOffset()), this._els.dhx_cal_data[0].style.cursor = "s-resize", "week" != this._mode && "day" != this._mode || (n2 = this._correct_shift(n2));
                }
                if ("new-size" == this._drag_mode) if (n2 <= this._drag_start) {
                  var w2 = e2.shift || (this._table_view && !e2.custom ? 864e5 : 0);
                  i2 = n2 - (e2.shift ? 0 : w2), n2 = this._drag_start + (w2 || 6e4 * d2);
                } else i2 = this._drag_start;
                else n2 <= i2 && (n2 = i2 + 6e4 * d2);
              }
              var D2 = new Date(n2 - 1), E2 = new Date(i2);
              if ("move" == this._drag_mode && g.config.limit_drag_out && (+E2 < +g._min_date || +n2 > +g._max_date)) {
                if (+l2.start_date < +g._min_date || +l2.end_date > +g._max_date) E2 = new Date(l2.start_date), n2 = new Date(l2.end_date);
                else {
                  var A2 = n2 - E2;
                  +E2 < +g._min_date ? (E2 = new Date(g._min_date), e2._ignores && this.config.preserve_length && this._table_view ? (E2 = new Date(g._correct_drag_start_date(E2)), o2._start_correction && (E2 = new Date(E2.valueOf() + o2._start_correction)), n2 = new Date(1 * E2 + this._get_fictional_event_length(E2, this._drag_event._event_length, o2))) : n2 = new Date(+E2 + A2)) : (n2 = new Date(g._max_date), e2._ignores && this.config.preserve_length && this._table_view ? (o2._end_correction && (n2 = new Date(n2.valueOf() - o2._end_correction)), n2 = new Date(1 * n2 - this._get_fictional_event_length(n2, 0, o2, true)), E2 = new Date(1 * n2 - this._get_fictional_event_length(n2, this._drag_event._event_length, o2, true)), this._ignores_detected && (E2 = g.date.add(E2, o2.x_step, o2.x_unit), n2 = new Date(1 * n2 - this._get_fictional_event_length(n2, 0, o2, true)), n2 = g.date.add(n2, o2.x_step, o2.x_unit))) : E2 = new Date(+n2 - A2));
                }
                var D2 = new Date(n2 - 1);
              }
              if (!this._table_view && this._dragEventBody && !g.config.all_timed && (!g._get_section_view() && e2.x != this._get_event_sday({ start_date: new Date(i2), end_date: new Date(i2) }) || new Date(i2).getHours() < this.config.first_hour)) {
                var A2 = n2 - E2;
                if ("move" == this._drag_mode) {
                  var h2 = this._min_date.valueOf() + 24 * e2.x * 60 * 6e4;
                  E2 = new Date(h2), E2.setHours(this.config.first_hour), n2 = new Date(E2.valueOf() + A2), D2 = new Date(n2 - 1);
                }
              }
              if (!this._table_view && !g.config.all_timed && (!g.getView() && e2.x != this._get_event_sday({ start_date: new Date(n2), end_date: new Date(n2) }) || new Date(n2).getHours() >= this.config.last_hour)) {
                var A2 = n2 - E2, h2 = this._min_date.valueOf() + 24 * e2.x * 60 * 6e4;
                n2 = g.date.date_part(new Date(h2)), n2.setHours(this.config.last_hour), D2 = new Date(n2 - 1), "move" == this._drag_mode && (E2 = new Date(+n2 - A2));
              }
              if (this._table_view || D2.getDate() == E2.getDate() && D2.getHours() < this.config.last_hour || g._allow_dnd) if (l2.start_date = E2, l2.end_date = new Date(n2), this.config.update_render) {
                var k2 = g._els.dhx_cal_data[0].scrollTop;
                this.update_view(), g._els.dhx_cal_data[0].scrollTop = k2;
              } else this.updateEvent(this._drag_id);
              this._table_view && this.for_rendered(this._drag_id, function(t3) {
                t3.className += " dhx_in_move dhx_cal_event_drag";
              }), this.callEvent("onEventDrag", [this._drag_id, this._drag_mode, t2]);
            }
          } else if (g.checkEvent("onMouseMove")) {
            var S2 = this._locate_event(t2.target || t2.srcElement);
            this.callEvent("onMouseMove", [S2, t2]);
          }
        }, g._on_mouse_down = function(t2, e2) {
          if (2 != t2.button && !this.config.readonly && !this._drag_mode) {
            e2 = e2 || t2.target || t2.srcElement;
            var i2 = g._getClassName(e2).split(" ")[0];
            switch (this.config.drag_event_body && "dhx_body" == i2 && e2.parentNode && -1 === e2.parentNode.className.indexOf("dhx_cal_select_menu") && (i2 = "dhx_event_move", this._dragEventBody = true), i2) {
              case "dhx_cal_event_line":
              case "dhx_cal_event_clear":
                this._table_view && (this._drag_mode = "move");
                break;
              case "dhx_event_move":
              case "dhx_wa_ev_body":
                this._drag_mode = "move";
                break;
              case "dhx_event_resize":
                this._drag_mode = "resize";
                g._getClassName(e2).indexOf("dhx_event_resize_end") < 0 ? g._drag_from_start = true : g._drag_from_start = false;
                break;
              case "dhx_scale_holder":
              case "dhx_scale_holder_now":
              case "dhx_month_body":
              case "dhx_matrix_cell":
              case "dhx_marked_timespan":
                this._drag_mode = "create";
                break;
              case "":
                if (e2.parentNode) return g._on_mouse_down(t2, e2.parentNode);
                break;
              default:
                if ((!g.checkEvent("onMouseDown") || g.callEvent("onMouseDown", [i2, t2])) && e2.parentNode && e2 != this && "dhx_body" != i2) return g._on_mouse_down(t2, e2.parentNode);
                this._drag_mode = null, this._drag_id = null;
            }
            if (this._drag_mode) {
              var n2 = this._locate_event(e2);
              if (this.config["drag_" + this._drag_mode] && this.callEvent("onBeforeDrag", [n2, this._drag_mode, t2])) {
                if (this._drag_id = n2, (this._edit_id != this._drag_id || this._edit_id && "create" == this._drag_mode) && this._close_not_saved(), !this._drag_mode) return;
                this._drag_event = g._lame_clone(this.getEvent(this._drag_id) || {}), this._drag_pos = this._mouse_coords(t2);
              } else this._drag_mode = this._drag_id = 0;
            }
            this._drag_start = null;
          }
        }, g._get_private_properties = function(t2) {
          var e2 = {};
          for (var i2 in t2) 0 === i2.indexOf("_") && (e2[i2] = true);
          return e2;
        }, g._clear_temporary_properties = function(t2, e2) {
          var i2 = this._get_private_properties(t2), n2 = this._get_private_properties(e2);
          for (var a2 in n2) i2[a2] || delete e2[a2];
        }, g._on_mouse_up = function(t2) {
          if (!t2 || 2 != t2.button || !this._mobile) {
            if (this._drag_mode && this._drag_id) {
              this._els.dhx_cal_data[0].style.cursor = "default";
              var e2 = this._drag_id, i2 = this._drag_mode, n2 = !this._drag_pos || this._drag_pos.has_moved;
              delete this._drag_event._move_event_shift;
              var a2 = this.getEvent(this._drag_id);
              if (n2 && (this._drag_event._dhx_changed || !this._drag_event.start_date || a2.start_date.valueOf() != this._drag_event.start_date.valueOf() || a2.end_date.valueOf() != this._drag_event.end_date.valueOf())) {
                var r2 = "new-size" == this._drag_mode;
                if (this.callEvent("onBeforeEventChanged", [a2, t2, r2, this._drag_event])) if (this._drag_id = this._drag_mode = null, r2 && this.config.edit_on_create) {
                  if (this.unselect(), this._new_event = /* @__PURE__ */ new Date(), this._table_view || this.config.details_on_create || !this.config.select || !this.isOneDayEvent(this.getEvent(e2))) return g.callEvent("onDragEnd", [e2, i2, t2]), this.showLightbox(e2);
                  this._drag_pos = true, this._select_id = this._edit_id = e2;
                } else this._new_event || this.callEvent(r2 ? "onEventAdded" : "onEventChanged", [e2, this.getEvent(e2)]);
                else r2 ? this.deleteEvent(a2.id, true) : (this._drag_event._dhx_changed = false, this._clear_temporary_properties(a2, this._drag_event), g._lame_copy(a2, this._drag_event), this.updateEvent(a2.id));
              }
              this._drag_pos && (this._drag_pos.has_moved || true === this._drag_pos) && (this._drag_id = this._drag_mode = null, this.render_view_data()), g.callEvent("onDragEnd", [e2, i2, t2]);
            }
            this._drag_id = null, this._drag_mode = null, this._drag_pos = null;
          }
        }, g._trigger_dyn_loading = function() {
          return !(!this._load_mode || !this._load()) && (this._render_wait = true, true);
        }, g.update_view = function() {
          this._reset_ignores(), this._update_nav_bar(this.config.header, this.$container.querySelector(".dhx_cal_navline"));
          var t2 = this[this._mode + "_view"];
          if (t2 ? t2(true) : this._reset_scale(), this._trigger_dyn_loading()) return true;
          this.render_view_data();
        }, g.isViewExists = function(t2) {
          return !!(g[t2 + "_view"] || g.date[t2 + "_start"] && g.templates[t2 + "_date"] && g.templates[t2 + "_scale_date"]);
        }, g._set_aria_buttons_attrs = function() {
          for (var t2 = ["dhx_cal_next_button", "dhx_cal_prev_button", "dhx_cal_tab", "dhx_cal_today_button"], e2 = 0; e2 < t2.length; e2++) for (var i2 = this._els[t2[e2]], n2 = 0; i2 && n2 < i2.length; n2++) {
            var a2 = i2[n2].getAttribute("name"), r2 = this.locale.labels[t2[e2]];
            a2 && (r2 = this.locale.labels[a2] || r2), "dhx_cal_next_button" == t2[e2] ? r2 = this.locale.labels.next : "dhx_cal_prev_button" == t2[e2] && (r2 = this.locale.labels.prev), this._waiAria.headerButtonsAttributes(i2[n2], r2 || "");
          }
        }, g.updateView = function(t2, e2) {
          if (!this.$container) throw new Error("The scheduler is not initialized. \n **scheduler.updateView** or **scheduler.setCurrentView** can be called only after **scheduler.init**");
          t2 = t2 || this._date, e2 = e2 || this._mode;
          var i2 = "dhx_cal_data", n2 = this._obj, a2 = "dhx_scheduler_" + this._mode, r2 = "dhx_scheduler_" + e2;
          this._mode && -1 != n2.className.indexOf(a2) ? n2.className = n2.className.replace(a2, r2) : n2.className += " " + r2;
          var s2, o2 = "dhx_multi_day", d2 = !(this._mode != e2 || !this.config.preserve_scroll) && this._els[i2][0].scrollTop;
          this._els[o2] && this._els[o2][0] && (s2 = this._els[o2][0].scrollTop), this[this._mode + "_view"] && e2 && this._mode != e2 && this[this._mode + "_view"](false), this._close_not_saved(), this._els[o2] && (this._els[o2][0].parentNode.removeChild(this._els[o2][0]), this._els[o2] = null), this._mode = e2, this._date = t2, this._table_view = "month" == this._mode, this._dy_shift = 0, this.update_view(), this._set_aria_buttons_attrs();
          var l2 = this._els.dhx_cal_tab;
          if (l2) for (var _2 = 0; _2 < l2.length; _2++) {
            var h2 = l2[_2];
            h2.getAttribute("name") == this._mode + "_tab" ? (h2.classList.add("active"), this._waiAria.headerToggleState(h2, true)) : (h2.classList.remove("active"), this._waiAria.headerToggleState(h2, false));
          }
          "number" == typeof d2 && (this._els[i2][0].scrollTop = d2), "number" == typeof s2 && this._els[o2] && this._els[o2][0] && (this._els[o2][0].scrollTop = s2);
        }, g.setCurrentView = function(t2, e2) {
          this.callEvent("onBeforeViewChange", [this._mode, this._date, e2 || this._mode, t2 || this._date]) && (this.updateView(t2, e2), this.callEvent("onViewChange", [this._mode, this._date]));
        }, g.render = function(t2, e2) {
          g.setCurrentView(t2, e2);
        }, g._render_x_header = function(t2, e2, i2, n2, a2) {
          a2 = a2 || 0;
          var r2 = document.createElement("div");
          r2.className = "dhx_scale_bar", this.templates[this._mode + "_scalex_class"] && (r2.className += " " + this.templates[this._mode + "_scalex_class"](i2));
          var s2 = this._cols[t2] - 1;
          "month" == this._mode && 0 === t2 && this.config.left_border && (r2.className += " dhx_scale_bar_border", e2 += 1), this.set_xy(r2, s2, this.xy.scale_height - 2, e2, a2);
          var o2 = this.templates[this._mode + "_scale_date"](i2, this._mode);
          r2.innerHTML = o2, this._waiAria.dayHeaderAttr(r2, o2), n2.appendChild(r2);
        }, g._get_columns_num = function(t2, e2) {
          var i2 = 7;
          if (!g._table_view) {
            var n2 = g.date["get_" + g._mode + "_end"];
            n2 && (e2 = n2(t2)), i2 = Math.round((e2.valueOf() - t2.valueOf()) / 864e5);
          }
          return i2;
        }, g._get_timeunit_start = function() {
          return this.date[this._mode + "_start"](new Date(this._date.valueOf()));
        }, g._get_view_end = function() {
          var t2 = this._get_timeunit_start(), e2 = g.date.add(t2, 1, this._mode);
          if (!g._table_view) {
            var i2 = g.date["get_" + g._mode + "_end"];
            i2 && (e2 = i2(t2));
          }
          return e2;
        }, g._calc_scale_sizes = function(t2, e2, i2) {
          var n2 = this.config.rtl, a2 = t2, r2 = this._get_columns_num(e2, i2);
          this._process_ignores(e2, r2, "day", 1);
          for (var s2 = r2 - this._ignores_detected, o2 = 0; o2 < r2; o2++) this._ignores[o2] ? (this._cols[o2] = 0, s2++) : this._cols[o2] = Math.floor(a2 / (s2 - o2)), a2 -= this._cols[o2], this._colsS[o2] = (this._cols[o2 - 1] || 0) + (this._colsS[o2 - 1] || (this._table_view ? 0 : (n2 ? this.xy.scroll_width : this.xy.scale_width) + 2));
          this._colsS.col_length = r2, this._colsS[r2] = this._cols[r2 - 1] + this._colsS[r2 - 1] || 0;
        }, g._set_scale_col_size = function(t2, e2, i2) {
          var n2 = this.config;
          this.set_xy(t2, e2 - 1, n2.hour_size_px * (n2.last_hour - n2.first_hour), i2 + this.xy.scale_width + 1, 0);
        }, g._render_scales = function(t2, e2) {
          var i2 = new Date(g._min_date), n2 = new Date(g._max_date), a2 = this.date.date_part(g._currentDate()), r2 = parseInt(t2.style.width, 10), s2 = new Date(this._min_date), o2 = this._get_columns_num(i2, n2);
          this._calc_scale_sizes(r2, i2, n2);
          var d2 = 0;
          t2.innerHTML = "";
          for (var l2 = 0; l2 < o2; l2++) {
            if (this._ignores[l2] || this._render_x_header(l2, d2, s2, t2), !this._table_view) {
              var _2 = document.createElement("div"), h2 = "dhx_scale_holder";
              s2.valueOf() == a2.valueOf() && (h2 = "dhx_scale_holder_now"), _2.setAttribute("data-column-index", l2), this._ignores_detected && this._ignores[l2] && (h2 += " dhx_scale_ignore"), _2.className = h2 + " " + this.templates.week_date_class(s2, a2), this._waiAria.dayColumnAttr(_2, s2), this._set_scale_col_size(_2, this._cols[l2], d2), e2.appendChild(_2), this.callEvent("onScaleAdd", [_2, s2]);
            }
            d2 += this._cols[l2], s2 = this.date.add(s2, 1, "day"), s2 = this.date.day_start(s2);
          }
        }, g._getNavDateElement = function() {
          return this.$container.querySelector(".dhx_cal_date");
        }, g._reset_scale = function() {
          if (this.templates[this._mode + "_date"]) {
            var t2 = this._els.dhx_cal_header[0], e2 = this._els.dhx_cal_data[0], i2 = this.config;
            t2.innerHTML = "", e2.innerHTML = "";
            var n2 = (i2.readonly || !i2.drag_resize ? " dhx_resize_denied" : "") + (i2.readonly || !i2.drag_move ? " dhx_move_denied" : "");
            e2.className = "dhx_cal_data" + n2, this._scales = {}, this._cols = [], this._colsS = { height: 0 }, this._dy_shift = 0, this.set_sizes();
            var a2, r2, s2 = this._get_timeunit_start(), o2 = g._get_view_end();
            a2 = r2 = this._table_view ? g.date.week_start(s2) : s2, this._min_date = a2;
            var d2 = this.templates[this._mode + "_date"](s2, o2, this._mode), l2 = this._getNavDateElement();
            if (l2 && (l2.innerHTML = d2, this._waiAria.navBarDateAttr(l2, d2)), this._max_date = o2, g._render_scales(t2, e2), this._table_view) this._reset_month_scale(e2, s2, r2);
            else if (this._reset_hours_scale(e2, s2, r2), i2.multi_day) {
              var _2 = "dhx_multi_day";
              this._els[_2] && (this._els[_2][0].parentNode.removeChild(this._els[_2][0]), this._els[_2] = null);
              var h2 = this._els.dhx_cal_navline[0], c2 = h2.offsetHeight + this._els.dhx_cal_header[0].offsetHeight + 1, u2 = document.createElement("div");
              u2.className = _2, u2.style.visibility = "hidden";
              var f2 = this._colsS[this._colsS.col_length], v2 = i2.rtl ? this.xy.scale_width : this.xy.scroll_width, m2 = Math.max(f2 + v2 - 2, 0);
              this.set_xy(u2, m2, 0, 0, c2), e2.parentNode.insertBefore(u2, e2);
              var p2 = u2.cloneNode(true);
              p2.className = _2 + "_icon", p2.style.visibility = "hidden", this.set_xy(p2, this.xy.scale_width, 0, 0, c2), u2.appendChild(p2), this._els[_2] = [u2, p2], this._els[_2][0].onclick = this._click.dhx_cal_data;
            }
          }
        }, g._reset_hours_scale = function(t2, e2, i2) {
          var n2 = document.createElement("div");
          n2.className = "dhx_scale_holder";
          for (var a2 = new Date(1980, 1, 1, this.config.first_hour, 0, 0), r2 = 1 * this.config.first_hour; r2 < this.config.last_hour; r2++) {
            var s2 = document.createElement("div");
            s2.className = "dhx_scale_hour", s2.style.height = this.config.hour_size_px + "px";
            var o2 = this.xy.scale_width;
            this.config.left_border && (s2.className += " dhx_scale_hour_border"), s2.style.width = o2 + "px";
            var d2 = g.templates.hour_scale(a2);
            s2.innerHTML = d2, this._waiAria.hourScaleAttr(s2, d2), n2.appendChild(s2), a2 = this.date.add(a2, 1, "hour");
          }
          t2.appendChild(n2), this.config.scroll_hour && (t2.scrollTop = this.config.hour_size_px * (this.config.scroll_hour - this.config.first_hour));
        }, g._currentDate = function() {
          return g.config.now_date ? new Date(g.config.now_date) : /* @__PURE__ */ new Date();
        }, g._reset_ignores = function() {
          this._ignores = {}, this._ignores_detected = 0;
        }, g._process_ignores = function(t2, e2, i2, n2, a2) {
          this._reset_ignores();
          var r2 = g["ignore_" + this._mode];
          if (r2) for (var s2 = new Date(t2), o2 = 0; o2 < e2; o2++) r2(s2) && (this._ignores_detected += 1, this._ignores[o2] = true, a2 && e2++), s2 = g.date.add(s2, n2, i2), g.date[i2 + "_start"] && (s2 = g.date[i2 + "_start"](s2));
        }, g._render_month_scale = function(t2, e2, i2, n2) {
          function a2(t3) {
            var e3 = g._colsS.height;
            return void 0 !== g._colsS.heights[t3 + 1] && (e3 = g._colsS.heights[t3 + 1] - (g._colsS.heights[t3] || 0)), e3;
          }
          var r2 = g.date.add(e2, 1, "month"), s2 = new Date(i2), o2 = g._currentDate();
          this.date.date_part(o2), this.date.date_part(i2), n2 = n2 || Math.ceil(Math.round((r2.valueOf() - i2.valueOf()) / 864e5) / 7);
          for (var d2 = [], l2 = 0; l2 <= 7; l2++) {
            var _2 = (this._cols[l2] || 0) - 1;
            0 === l2 && this.config.left_border && (_2 -= 1), d2[l2] = _2 + "px";
          }
          var h2 = 0, c2 = document.createElement("table");
          c2.setAttribute("cellpadding", "0"), c2.setAttribute("cellspacing", "0");
          var u2 = document.createElement("tbody");
          c2.appendChild(u2);
          for (var f2 = [], l2 = 0; l2 < n2; l2++) {
            var v2 = document.createElement("tr");
            u2.appendChild(v2);
            for (var m2 = Math.max(a2(l2) - g.xy.month_head_height, 0), p2 = 0; p2 < 7; p2++) {
              var x2 = document.createElement("td");
              v2.appendChild(x2);
              var b2 = "";
              i2 < e2 ? b2 = "dhx_before" : i2 >= r2 ? b2 = "dhx_after" : i2.valueOf() == o2.valueOf() && (b2 = "dhx_now"), this._ignores_detected && this._ignores[p2] && (b2 += " dhx_scale_ignore"), x2.className = b2 + " " + this.templates.month_date_class(i2, o2), x2.setAttribute("data-cell-date", g.templates.format_date(i2));
              var y2 = "dhx_month_body", w2 = "dhx_month_head";
              if (0 === p2 && this.config.left_border && (y2 += " dhx_month_body_border", w2 += " dhx_month_head_border"), this._ignores_detected && this._ignores[p2]) x2.appendChild(document.createElement("div")), x2.appendChild(document.createElement("div"));
              else {
                this._waiAria.monthCellAttr(x2, i2);
                var D2 = document.createElement("div");
                D2.className = w2, D2.innerHTML = this.templates.month_day(i2), x2.appendChild(D2);
                var E2 = document.createElement("div");
                E2.className = y2, E2.style.height = m2 + "px", E2.style.width = d2[p2], x2.appendChild(E2);
              }
              f2.push(i2);
              var A2 = i2.getDate();
              i2 = this.date.add(i2, 1, "day"), i2.getDate() - A2 > 1 && (i2 = new Date(i2.getFullYear(), i2.getMonth(), A2 + 1, 12, 0));
            }
            g._colsS.heights[l2] = h2, h2 += a2(l2);
          }
          this._min_date = s2, this._max_date = i2, t2.innerHTML = "", t2.appendChild(c2), this._scales = {};
          for (var k2 = t2.getElementsByTagName("div"), l2 = 0; l2 < f2.length; l2++) {
            var t2 = k2[2 * l2 + 1], S2 = f2[l2];
            this._scales[+S2] = t2;
          }
          for (var l2 = 0; l2 < f2.length; l2++) {
            var S2 = f2[l2];
            this.callEvent("onScaleAdd", [this._scales[+S2], S2]);
          }
          return this._max_date;
        }, g._reset_month_scale = function(t2, e2, i2, n2) {
          var a2 = g.date.add(e2, 1, "month"), r2 = g._currentDate();
          this.date.date_part(r2), this.date.date_part(i2), n2 = n2 || Math.ceil(Math.round((a2.valueOf() - i2.valueOf()) / 864e5) / 7);
          var s2 = Math.floor(t2.clientHeight / n2) - this.xy.month_head_height;
          return this._colsS.height = s2 + this.xy.month_head_height, this._colsS.heights = [], g._render_month_scale(t2, e2, i2, n2);
        }, g.getView = function(t2) {
          return t2 || (t2 = g.getState().mode), g.matrix && g.matrix[t2] ? g.matrix[t2] : g._props && g._props[t2] ? g._props[t2] : null;
        }, g.getLabel = function(t2, e2) {
          for (var i2 = this.config.lightbox.sections, n2 = 0; n2 < i2.length; n2++) if (i2[n2].map_to == t2) {
            for (var a2 = i2[n2].options, r2 = 0; r2 < a2.length; r2++) if (a2[r2].key == e2) return a2[r2].label;
          }
          return "";
        }, g.updateCollection = function(t2, e2) {
          var i2 = g.serverList(t2);
          return !!i2 && (i2.splice(0, i2.length), i2.push.apply(i2, e2 || []), g.callEvent("onOptionsLoad", []), g.resetLightbox(), true);
        }, g._lame_clone = function(t2, e2) {
          var i2, n2, a2;
          for (e2 = e2 || [], i2 = 0; i2 < e2.length; i2 += 2) if (t2 === e2[i2]) return e2[i2 + 1];
          if (t2 && "object" == typeof t2) {
            for (a2 = Object.create(t2), n2 = [Array, Date, Number, String, Boolean], i2 = 0; i2 < n2.length; i2++) t2 instanceof n2[i2] && (a2 = i2 ? new n2[i2](t2) : new n2[i2]());
            e2.push(t2, a2);
            for (i2 in t2) Object.prototype.hasOwnProperty.apply(t2, [i2]) && (a2[i2] = g._lame_clone(t2[i2], e2));
          }
          return a2 || t2;
        }, g._lame_copy = function(t2, e2) {
          for (var i2 in e2) e2.hasOwnProperty(i2) && (t2[i2] = e2[i2]);
          return t2;
        }, g._get_date_from_pos = function(t2) {
          var e2 = this._min_date.valueOf() + 6e4 * (t2.y * this.config.time_step + 24 * (this._table_view ? 0 : t2.x) * 60);
          return new Date(this._correct_shift(e2));
        }, g.getActionData = function(t2) {
          var e2 = this._mouse_coords(t2);
          return { date: this._get_date_from_pos(e2), section: e2.section };
        }, g._focus = function(t2, e2) {
          if (t2 && t2.focus) if (this._mobile) window.setTimeout(function() {
            t2.focus();
          }, 10);
          else try {
            e2 && t2.select && t2.offsetWidth && t2.select(), t2.focus();
          } catch (t3) {
          }
        }, g._get_real_event_length = function(t2, e2, i2) {
          var n2, a2 = e2 - t2, r2 = i2._start_correction + i2._end_correction || 0, s2 = this["ignore_" + this._mode], o2 = 0;
          i2.render ? (o2 = this._get_date_index(i2, t2), n2 = this._get_date_index(i2, e2)) : n2 = Math.round(a2 / 60 / 60 / 1e3 / 24);
          for (var d2 = true; o2 < n2; ) {
            var l2 = g.date.add(e2, -i2.x_step, i2.x_unit);
            s2 && s2(e2) && (!d2 || d2 && s2(l2)) ? a2 -= e2 - l2 : (d2 = false, a2 -= r2), e2 = l2, n2--;
          }
          return a2;
        }, g._get_fictional_event_length = function(t2, e2, i2, n2) {
          var a2 = new Date(t2), r2 = n2 ? -1 : 1;
          if (i2._start_correction || i2._end_correction) {
            var s2;
            s2 = n2 ? 60 * a2.getHours() + a2.getMinutes() - 60 * (i2.first_hour || 0) : 60 * (i2.last_hour || 0) - (60 * a2.getHours() + a2.getMinutes());
            var o2 = 60 * (i2.last_hour - i2.first_hour), d2 = Math.ceil((e2 / 6e4 - s2) / o2);
            d2 < 0 && (d2 = 0), e2 += d2 * (1440 - o2) * 60 * 1e3;
          }
          var l2, _2 = new Date(1 * t2 + e2 * r2), h2 = this["ignore_" + this._mode], c2 = 0;
          for (i2.render ? (c2 = this._get_date_index(i2, a2), l2 = this._get_date_index(i2, _2)) : l2 = Math.round(e2 / 60 / 60 / 1e3 / 24); c2 * r2 <= l2 * r2; ) {
            var u2 = g.date.add(a2, i2.x_step * r2, i2.x_unit);
            h2 && h2(a2) && (e2 += (u2 - a2) * r2, l2 += r2), a2 = u2, c2 += r2;
          }
          return e2;
        }, g._get_section_view = function() {
          return this.getView();
        }, g._get_section_property = function() {
          return this.matrix && this.matrix[this._mode] ? this.matrix[this._mode].y_property : this._props && this._props[this._mode] ? this._props[this._mode].map_to : null;
        }, g._is_initialized = function() {
          var t2 = this.getState();
          return this._obj && t2.date && t2.mode;
        }, g._is_lightbox_open = function() {
          var t2 = this.getState();
          return null !== t2.lightbox_id && void 0 !== t2.lightbox_id;
        }, g._getClassName = function(t2) {
          if (!t2) return "";
          var e2 = t2.className || "";
          return e2.baseVal && (e2 = e2.baseVal), e2.indexOf || (e2 = ""), e2 || "";
        }, g.event = function(t2, e2, i2) {
          t2.addEventListener ? t2.addEventListener(e2, i2, false) : t2.attachEvent && t2.attachEvent("on" + e2, i2);
        }, g.eventRemove = function(t2, e2, i2) {
          t2.removeEventListener ? t2.removeEventListener(e2, i2, false) : t2.detachEvent && t2.detachEvent("on" + e2, i2);
        }, function() {
          function t2(t3) {
            var e3 = false, i3 = false;
            if (window.getComputedStyle) {
              var n3 = window.getComputedStyle(t3, null);
              e3 = n3.display, i3 = n3.visibility;
            } else t3.currentStyle && (e3 = t3.currentStyle.display, i3 = t3.currentStyle.visibility);
            var a2 = false, r2 = g._locate_css({ target: t3 }, "dhx_form_repeat", false);
            return r2 && (a2 = !("0px" != r2.style.height)), a2 = a2 || !t3.offsetHeight, "none" != e3 && "hidden" != i3 && !a2;
          }
          function e2(t3) {
            return !isNaN(t3.getAttribute("tabindex")) && 1 * t3.getAttribute("tabindex") >= 0;
          }
          function i2(t3) {
            return !{
              a: true,
              area: true
            }[t3.nodeName.loLowerCase()] || !!t3.getAttribute("href");
          }
          function n2(t3) {
            return !{ input: true, select: true, textarea: true, button: true, object: true }[t3.nodeName.toLowerCase()] || !t3.hasAttribute("disabled");
          }
          g._getFocusableNodes = function(a2) {
            for (var r2 = a2.querySelectorAll(["a[href]", "area[href]", "input", "select", "textarea", "button", "iframe", "object", "embed", "[tabindex]", "[contenteditable]"].join(", ")), s2 = Array.prototype.slice.call(r2, 0), o2 = 0; o2 < s2.length; o2++) {
              var d2 = s2[o2];
              (e2(d2) || n2(d2) || i2(d2)) && t2(d2) || (s2.splice(o2, 1), o2--);
            }
            return s2;
          };
        }(), g._trim = function(t2) {
          return (String.prototype.trim || function() {
            return this.replace(/^\s+|\s+$/g, "");
          }).apply(t2);
        }, g._isDate = function(t2) {
          return !(!t2 || "object" != typeof t2) && !!(t2.getFullYear && t2.getMonth && t2.getDate);
        }, g._isObject = function(t2) {
          return t2 && "object" == typeof t2;
        }, function() {
          function t2(t3) {
            return (t3 + "").replace(n2, " ").replace(a2, " ");
          }
          function e2(t3) {
            return (t3 + "").replace(r2, "&#39;");
          }
          function i2() {
            return !g.config.wai_aria_attributes;
          }
          var n2 = new RegExp("<(?:.|\n)*?>", "gm"), a2 = new RegExp(" +", "gm"), r2 = new RegExp("'", "gm");
          g._waiAria = {
            getAttributeString: function(i3) {
              var n3 = [" "];
              for (var a3 in i3) if ("function" != typeof i3[a3] && "object" != typeof i3[a3]) {
                var r3 = e2(t2(i3[a3]));
                n3.push(a3 + "='" + r3 + "'");
              }
              return n3.push(" "), n3.join(" ");
            },
            setAttributes: function(e3, i3) {
              for (var n3 in i3) e3.setAttribute(n3, t2(i3[n3]));
              return e3;
            },
            labelAttr: function(t3, e3) {
              return this.setAttributes(t3, { "aria-label": e3 });
            },
            label: function(t3) {
              return g._waiAria.getAttributeString({ "aria-label": t3 });
            },
            hourScaleAttr: function(t3, e3) {
              this.labelAttr(t3, e3);
            },
            monthCellAttr: function(t3, e3) {
              this.labelAttr(t3, g.templates.day_date(e3));
            },
            navBarDateAttr: function(t3, e3) {
              this.labelAttr(t3, e3);
            },
            dayHeaderAttr: function(t3, e3) {
              this.labelAttr(t3, e3);
            },
            dayColumnAttr: function(t3, e3) {
              this.dayHeaderAttr(t3, g.templates.day_date(e3));
            },
            headerButtonsAttributes: function(t3, e3) {
              return this.setAttributes(t3, { role: "button", "aria-label": e3 });
            },
            headerToggleState: function(t3, e3) {
              return this.setAttributes(t3, { "aria-pressed": e3 ? "true" : "false" });
            },
            getHeaderCellAttr: function(t3) {
              return g._waiAria.getAttributeString({ "aria-label": t3 });
            },
            eventAttr: function(t3, e3) {
              this._eventCommonAttr(t3, e3);
            },
            _eventCommonAttr: function(e3, i3) {
              i3.setAttribute("aria-label", t2(g.templates.event_text(e3.start_date, e3.end_date, e3))), g.config.readonly && i3.setAttribute("aria-readonly", true), e3.$dataprocessor_class && i3.setAttribute("aria-busy", true), i3.setAttribute("aria-selected", g.getState().select_id == e3.id ? "true" : "false");
            },
            setEventBarAttr: function(t3, e3) {
              this._eventCommonAttr(t3, e3);
            },
            _getAttributes: function(t3, e3) {
              var i3 = { setAttribute: function(t4, e4) {
                this[t4] = e4;
              } };
              return t3.apply(this, [e3, i3]), i3;
            },
            eventBarAttrString: function(t3) {
              return this.getAttributeString(this._getAttributes(this.setEventBarAttr, t3));
            },
            agendaHeadAttrString: function() {
              return this.getAttributeString({ role: "row" });
            },
            agendaHeadDateString: function(t3) {
              return this.getAttributeString({ role: "columnheader", "aria-label": t3 });
            },
            agendaHeadDescriptionString: function(t3) {
              return this.agendaHeadDateString(t3);
            },
            agendaDataAttrString: function() {
              return this.getAttributeString({ role: "grid" });
            },
            agendaEventAttrString: function(t3) {
              var e3 = this._getAttributes(this._eventCommonAttr, t3);
              return e3.role = "row", this.getAttributeString(e3);
            },
            agendaDetailsBtnString: function() {
              return this.getAttributeString({ role: "button", "aria-label": g.locale.labels.icon_details });
            },
            gridAttrString: function() {
              return this.getAttributeString({ role: "grid" });
            },
            gridRowAttrString: function(t3) {
              return this.agendaEventAttrString(t3);
            },
            gridCellAttrString: function(t3, e3, i3) {
              return this.getAttributeString({ role: "gridcell", "aria-label": [void 0 === e3.label ? e3.id : e3.label, ": ", i3] });
            },
            mapAttrString: function() {
              return this.gridAttrString();
            },
            mapRowAttrString: function(t3) {
              return this.gridRowAttrString(t3);
            },
            mapDetailsBtnString: function() {
              return this.agendaDetailsBtnString();
            },
            minicalHeader: function(t3, e3) {
              this.setAttributes(t3, { id: e3 + "", "aria-live": "assertice", "aria-atomic": "true" });
            },
            minicalGrid: function(t3, e3) {
              this.setAttributes(t3, {
                "aria-labelledby": e3 + "",
                role: "grid"
              });
            },
            minicalRow: function(t3) {
              this.setAttributes(t3, { role: "row" });
            },
            minicalDayCell: function(t3, e3) {
              var i3 = e3.valueOf() < g._max_date.valueOf() && e3.valueOf() >= g._min_date.valueOf();
              this.setAttributes(t3, { role: "gridcell", "aria-label": g.templates.day_date(e3), "aria-selected": i3 ? "true" : "false" });
            },
            minicalHeadCell: function(t3) {
              this.setAttributes(t3, { role: "columnheader" });
            },
            weekAgendaDayCell: function(t3, e3) {
              var i3 = t3.querySelector(".dhx_wa_scale_bar"), n3 = t3.querySelector(".dhx_wa_day_data"), a3 = g.uid() + "";
              this.setAttributes(i3, { id: a3 }), this.setAttributes(n3, { "aria-labelledby": a3 });
            },
            weekAgendaEvent: function(t3, e3) {
              this.eventAttr(e3, t3);
            },
            lightboxHiddenAttr: function(t3) {
              t3.setAttribute("aria-hidden", "true");
            },
            lightboxVisibleAttr: function(t3) {
              t3.setAttribute("aria-hidden", "false");
            },
            lightboxSectionButtonAttrString: function(t3) {
              return this.getAttributeString({ role: "button", "aria-label": t3, tabindex: "0" });
            },
            yearHeader: function(t3, e3) {
              this.setAttributes(t3, { id: e3 + "" });
            },
            yearGrid: function(t3, e3) {
              this.minicalGrid(t3, e3);
            },
            yearHeadCell: function(t3) {
              return this.minicalHeadCell(t3);
            },
            yearRow: function(t3) {
              return this.minicalRow(t3);
            },
            yearDayCell: function(t3) {
              this.setAttributes(t3, { role: "gridcell" });
            },
            lightboxAttr: function(t3) {
              t3.setAttribute("role", "dialog"), t3.setAttribute("aria-hidden", "true"), t3.firstChild.setAttribute("role", "heading");
            },
            lightboxButtonAttrString: function(t3) {
              return this.getAttributeString({
                role: "button",
                "aria-label": g.locale.labels[t3],
                tabindex: "0"
              });
            },
            eventMenuAttrString: function(t3) {
              return this.getAttributeString({ role: "button", "aria-label": g.locale.labels[t3] });
            },
            lightboxHeader: function(t3, e3) {
              t3.setAttribute("aria-label", e3);
            },
            lightboxSelectAttrString: function(t3) {
              var e3 = "";
              switch (t3) {
                case "%Y":
                  e3 = g.locale.labels.year;
                  break;
                case "%m":
                  e3 = g.locale.labels.month;
                  break;
                case "%d":
                  e3 = g.locale.labels.day;
                  break;
                case "%H:%i":
                  e3 = g.locale.labels.hour + " " + g.locale.labels.minute;
              }
              return g._waiAria.getAttributeString({
                "aria-label": e3
              });
            },
            messageButtonAttrString: function(t3) {
              return "tabindex='0' role='button' aria-label='" + t3 + "'";
            },
            messageInfoAttr: function(t3) {
              t3.setAttribute("role", "alert");
            },
            messageModalAttr: function(t3, e3) {
              t3.setAttribute("role", "dialog"), e3 && t3.setAttribute("aria-labelledby", e3);
            },
            quickInfoAttr: function(t3) {
              t3.setAttribute("role", "dialog");
            },
            quickInfoHeaderAttrString: function() {
              return " role='heading' ";
            },
            quickInfoHeader: function(t3, e3) {
              t3.setAttribute("aria-label", e3);
            },
            quickInfoButtonAttrString: function(t3) {
              return g._waiAria.getAttributeString({ role: "button", "aria-label": t3, tabindex: "0" });
            },
            tooltipAttr: function(t3) {
              t3.setAttribute("role", "tooltip");
            },
            tooltipVisibleAttr: function(t3) {
              t3.setAttribute("aria-hidden", "false");
            },
            tooltipHiddenAttr: function(t3) {
              t3.setAttribute("aria-hidden", "true");
            }
          };
          for (var s2 in g._waiAria) g._waiAria[s2] = /* @__PURE__ */ function(t3) {
            return function() {
              return i2() ? " " : t3.apply(this, arguments);
            };
          }(g._waiAria[s2]);
        }(), g.utils = {
          mixin: function(t2, e2, i2) {
            for (var n2 in e2) (void 0 === t2[n2] || i2) && (t2[n2] = e2[n2]);
            return t2;
          },
          copy: function t2(e2) {
            var i2, n2;
            if (e2 && "object" == typeof e2) switch (true) {
              case h(e2):
                n2 = new Date(e2);
                break;
              case o(e2):
                for (n2 = new Array(e2.length), i2 = 0; i2 < e2.length; i2++) n2[i2] = t2(e2[i2]);
                break;
              case d(e2):
                n2 = new String(e2);
                break;
              case l(e2):
                n2 = new Number(e2);
                break;
              case _(e2):
                n2 = new Boolean(e2);
                break;
              default:
                n2 = {};
                for (i2 in e2) Object.prototype.hasOwnProperty.apply(e2, [i2]) && (n2[i2] = t2(e2[i2]));
            }
            return n2 || e2;
          }
        }, g.$domHelpers = {
          getAbsoluteLeft: function(t2) {
            return this.getOffset(t2).left;
          },
          getAbsoluteTop: function(t2) {
            return this.getOffset(t2).top;
          },
          getOffsetSum: function(t2) {
            for (var e2 = 0, i2 = 0; t2; ) e2 += parseInt(t2.offsetTop), i2 += parseInt(t2.offsetLeft), t2 = t2.offsetParent;
            return { top: e2, left: i2 };
          },
          getOffsetRect: function(t2) {
            var e2 = t2.getBoundingClientRect(), i2 = 0, n2 = 0;
            if (/Mobi/.test(navigator.userAgent)) {
              var a2 = document.createElement("div");
              a2.style.position = "absolute", a2.style.left = "0px", a2.style.top = "0px", a2.style.width = "1px", a2.style.height = "1px", document.body.appendChild(a2);
              var r2 = a2.getBoundingClientRect();
              i2 = e2.top - r2.top, n2 = e2.left - r2.left, a2.parentNode.removeChild(a2);
            } else {
              var s2 = document.body, o2 = document.documentElement, d2 = window.pageYOffset || o2.scrollTop || s2.scrollTop, l2 = window.pageXOffset || o2.scrollLeft || s2.scrollLeft, _2 = o2.clientTop || s2.clientTop || 0, h2 = o2.clientLeft || s2.clientLeft || 0;
              i2 = e2.top + d2 - _2, n2 = e2.left + l2 - h2;
            }
            return { top: Math.round(i2), left: Math.round(n2) };
          },
          getOffset: function(t2) {
            return t2.getBoundingClientRect ? this.getOffsetRect(t2) : this.getOffsetSum(t2);
          },
          closest: function(t2, e2) {
            return t2 && e2 ? w(t2, e2) : null;
          },
          insertAfter: function(t2, e2) {
            e2.nextSibling ? e2.parentNode.insertBefore(t2, e2.nextSibling) : e2.parentNode.appendChild(t2);
          }
        };
        var w;
        if (Element.prototype.closest) w = function(t2, e2) {
          return t2.closest(e2);
        };
        else {
          var D = Element.prototype.matches || Element.prototype.msMatchesSelector || Element.prototype.webkitMatchesSelector;
          w = function(t2, e2) {
            var i2 = t2;
            do {
              if (D.call(i2, e2)) return i2;
              i2 = i2.parentElement || i2.parentNode;
            } while (null !== i2 && 1 === i2.nodeType);
            return null;
          };
        }
        g.$env = {
          isIE: navigator.userAgent.indexOf("MSIE") >= 0 || navigator.userAgent.indexOf("Trident") >= 0,
          isIE6: !window.XMLHttpRequest && navigator.userAgent.indexOf("MSIE") >= 0,
          isIE7: navigator.userAgent.indexOf("MSIE 7.0") >= 0 && navigator.userAgent.indexOf("Trident") < 0,
          isIE8: navigator.userAgent.indexOf("MSIE 8.0") >= 0 && navigator.userAgent.indexOf("Trident") >= 0,
          isOpera: navigator.userAgent.indexOf("Opera") >= 0,
          isChrome: navigator.userAgent.indexOf("Chrome") >= 0,
          isKHTML: navigator.userAgent.indexOf("Safari") >= 0 || navigator.userAgent.indexOf("Konqueror") >= 0,
          isFF: navigator.userAgent.indexOf("Firefox") >= 0,
          isIPad: navigator.userAgent.search(/iPad/gi) >= 0,
          isEdge: -1 != navigator.userAgent.indexOf("Edge")
        }, g.$ajax = {
          _obj: g,
          cache: true,
          method: "get",
          parse: function(t2) {
            if ("string" != typeof t2) return t2;
            var e2;
            return t2 = t2.replace(/^[\s]+/, ""), window.DOMParser && !g.$env.isIE ? e2 = new window.DOMParser().parseFromString(t2, "text/xml") : window.ActiveXObject !== window.undefined && (e2 = new window.ActiveXObject("Microsoft.XMLDOM"), e2.async = "false", e2.loadXML(t2)), e2;
          },
          xmltop: function(t2, e2, i2) {
            if (void 0 === e2.status || e2.status < 400) {
              var n2 = e2.responseXML ? e2.responseXML || e2 : this.parse(e2.responseText || e2);
              if (n2 && null !== n2.documentElement && !n2.getElementsByTagName("parsererror").length) return n2.getElementsByTagName(t2)[0];
            }
            return -1 !== i2 && this._obj.callEvent("onLoadXMLError", ["Incorrect XML", arguments[1], i2]), document.createElement("DIV");
          },
          xpath: function(t2, e2) {
            if (e2.nodeName || (e2 = e2.responseXML || e2), g.$env.isIE) return e2.selectNodes(t2) || [];
            for (var i2, n2 = [], a2 = (e2.ownerDocument || e2).evaluate(t2, e2, null, XPathResult.ANY_TYPE, null); ; ) {
              if (!(i2 = a2.iterateNext())) break;
              n2.push(i2);
            }
            return n2;
          },
          query: function(t2) {
            this._call(t2.method || "GET", t2.url, t2.data || "", t2.async || true, t2.callback, null, t2.headers);
          },
          get: function(t2, e2) {
            this._call("GET", t2, null, true, e2);
          },
          getSync: function(t2) {
            return this._call("GET", t2, null, false);
          },
          put: function(t2, e2, i2) {
            this._call("PUT", t2, e2, true, i2);
          },
          del: function(t2, e2, i2) {
            this._call("DELETE", t2, e2, true, i2);
          },
          post: function(t2, e2, i2) {
            1 == arguments.length ? e2 = "" : 2 != arguments.length || "function" != typeof e2 && "function" != typeof window[e2] ? e2 = String(e2) : (i2 = e2, e2 = ""), this._call("POST", t2, e2, true, i2);
          },
          postSync: function(t2, e2) {
            return e2 = null === e2 ? "" : String(e2), this._call("POST", t2, e2, false);
          },
          getLong: function(t2, e2) {
            this._call("GET", t2, null, true, e2, { url: t2 });
          },
          postLong: function(t2, e2, i2) {
            2 != arguments.length || "function" != typeof e2 && (window[e2], 0) || (i2 = e2, e2 = ""), this._call("POST", t2, e2, true, i2, { url: t2, postData: e2 });
          },
          _call: function(t2, e2, i2, n2, a2, r2, s2) {
            var o2 = this._obj, d2 = window.XMLHttpRequest && !o2.$env.isIE ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"), l2 = null !== navigator.userAgent.match(/AppleWebKit/) && null !== navigator.userAgent.match(/Qt/) && null !== navigator.userAgent.match(/Safari/);
            if (n2 && (d2.onreadystatechange = function() {
              if (4 == d2.readyState || l2 && 3 == d2.readyState) {
                if ((200 != d2.status || "" === d2.responseText) && !o2.callEvent("onAjaxError", [d2])) return;
                window.setTimeout(function() {
                  "function" == typeof a2 && a2.apply(window, [{ xmlDoc: d2, filePath: e2 }]), r2 && (void 0 !== r2.postData ? this.postLong(r2.url, r2.postData, a2) : this.getLong(r2.url, a2)), a2 = null, d2 = null;
                }, 1);
              }
            }), "GET" != t2 || this.cache || (e2 += (e2.indexOf("?") >= 0 ? "&" : "?") + "dhxr" + (/* @__PURE__ */ new Date()).getTime() + "=1"), d2.open(t2, e2, n2), s2) for (var _2 in s2) d2.setRequestHeader(_2, s2[_2]);
            else "POST" == t2.toUpperCase() || "PUT" == t2 || "DELETE" == t2 ? d2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded") : "GET" == t2 && (i2 = null);
            if (d2.setRequestHeader("X-Requested-With", "XMLHttpRequest"), d2.send(i2), !n2) return { xmlDoc: d2, filePath: e2 };
          },
          urlSeparator: function(t2) {
            return -1 != t2.indexOf("?") ? "&" : "?";
          }
        };
        var E = function(t2, e2) {
          for (var i2 = "var temp=date.match(/[a-zA-Z]+|[0-9]+/g);", n2 = t2.match(/%[a-zA-Z]/g), a2 = 0; a2 < n2.length; a2++) switch (n2[a2]) {
            case "%j":
            case "%d":
              i2 += "set[2]=temp[" + a2 + "]||1;";
              break;
            case "%n":
            case "%m":
              i2 += "set[1]=(temp[" + a2 + "]||1)-1;";
              break;
            case "%y":
              i2 += "set[0]=temp[" + a2 + "]*1+(temp[" + a2 + "]>50?1900:2000);";
              break;
            case "%g":
            case "%G":
            case "%h":
            case "%H":
              i2 += "set[3]=temp[" + a2 + "]||0;";
              break;
            case "%i":
              i2 += "set[4]=temp[" + a2 + "]||0;";
              break;
            case "%Y":
              i2 += "set[0]=temp[" + a2 + "]||0;";
              break;
            case "%a":
            case "%A":
              i2 += "set[3]=set[3]%12+((temp[" + a2 + "]||'').toLowerCase()=='am'?0:12);";
              break;
            case "%s":
              i2 += "set[5]=temp[" + a2 + "]||0;";
              break;
            case "%M":
              i2 += "set[1]=this.locale.date.month_short_hash[temp[" + a2 + "]]||0;";
              break;
            case "%F":
              i2 += "set[1]=this.locale.date.month_full_hash[temp[" + a2 + "]]||0;";
          }
          var r2 = "set[0],set[1],set[2],set[3],set[4],set[5]";
          return e2 && (r2 = " Date.UTC(" + r2 + ")"), new Function("date", "var set=[0,0,1,0,0,0]; " + i2 + " return new Date(" + r2 + ");");
        };
        g.date = {
          init: function() {
            for (var t2 = g.locale.date.month_short, e2 = g.locale.date.month_short_hash = {}, i2 = 0; i2 < t2.length; i2++) e2[t2[i2]] = i2;
            for (var t2 = g.locale.date.month_full, e2 = g.locale.date.month_full_hash = {}, i2 = 0; i2 < t2.length; i2++) e2[t2[i2]] = i2;
          },
          _bind_host_object: function(t2) {
            return t2.bind ? t2.bind(g) : function() {
              return t2.apply(g, arguments);
            };
          },
          date_part: function(t2) {
            var e2 = new Date(t2);
            return t2.setHours(0), t2.setMinutes(0), t2.setSeconds(0), t2.setMilliseconds(0), t2.getHours() && (t2.getDate() < e2.getDate() || t2.getMonth() < e2.getMonth() || t2.getFullYear() < e2.getFullYear()) && t2.setTime(t2.getTime() + 36e5 * (24 - t2.getHours())), t2;
          },
          time_part: function(t2) {
            return (t2.valueOf() / 1e3 - 60 * t2.getTimezoneOffset()) % 86400;
          },
          week_start: function(t2) {
            var e2 = t2.getDay();
            return g.config.start_on_monday && (0 === e2 ? e2 = 6 : e2--), this.date_part(this.add(t2, -1 * e2, "day"));
          },
          month_start: function(t2) {
            return t2.setDate(1), this.date_part(t2);
          },
          year_start: function(t2) {
            return t2.setMonth(0), this.month_start(t2);
          },
          day_start: function(t2) {
            return this.date_part(t2);
          },
          _add_days: function(t2, e2) {
            var i2 = new Date(t2.valueOf());
            if (i2.setDate(i2.getDate() + e2), e2 == Math.round(e2) && e2 > 0) {
              var n2 = +i2 - +t2, a2 = n2 % 864e5;
              if (a2 && t2.getTimezoneOffset() == i2.getTimezoneOffset()) {
                var r2 = a2 / 36e5;
                i2.setTime(i2.getTime() + 60 * (24 - r2) * 60 * 1e3);
              }
            }
            return e2 >= 0 && !t2.getHours() && i2.getHours() && (i2.getDate() < t2.getDate() || i2.getMonth() < t2.getMonth() || i2.getFullYear() < t2.getFullYear()) && i2.setTime(i2.getTime() + 36e5 * (24 - i2.getHours())), i2;
          },
          add: function(t2, e2, i2) {
            var n2 = new Date(t2.valueOf());
            switch (i2) {
              case "day":
                n2 = g.date._add_days(n2, e2);
                break;
              case "week":
                n2 = g.date._add_days(n2, 7 * e2);
                break;
              case "month":
                n2.setMonth(n2.getMonth() + e2);
                break;
              case "year":
                n2.setYear(n2.getFullYear() + e2);
                break;
              case "hour":
                n2.setTime(n2.getTime() + 60 * e2 * 60 * 1e3);
                break;
              case "minute":
                n2.setTime(n2.getTime() + 60 * e2 * 1e3);
                break;
              default:
                return g.date["add_" + i2](t2, e2, i2);
            }
            return n2;
          },
          to_fixed: function(t2) {
            return t2 < 10 ? "0" + t2 : t2;
          },
          copy: function(t2) {
            return new Date(t2.valueOf());
          },
          date_to_str: function(t2, e2) {
            t2 = t2.replace(/%[a-zA-Z]/g, function(t3) {
              switch (t3) {
                case "%d":
                  return '"+this.date.to_fixed(date.getDate())+"';
                case "%m":
                  return '"+this.date.to_fixed((date.getMonth()+1))+"';
                case "%j":
                  return '"+date.getDate()+"';
                case "%n":
                  return '"+(date.getMonth()+1)+"';
                case "%y":
                  return '"+this.date.to_fixed(date.getFullYear()%100)+"';
                case "%Y":
                  return '"+date.getFullYear()+"';
                case "%D":
                  return '"+this.locale.date.day_short[date.getDay()]+"';
                case "%l":
                  return '"+this.locale.date.day_full[date.getDay()]+"';
                case "%M":
                  return '"+this.locale.date.month_short[date.getMonth()]+"';
                case "%F":
                  return '"+this.locale.date.month_full[date.getMonth()]+"';
                case "%h":
                  return '"+this.date.to_fixed((date.getHours()+11)%12+1)+"';
                case "%g":
                  return '"+((date.getHours()+11)%12+1)+"';
                case "%G":
                  return '"+date.getHours()+"';
                case "%H":
                  return '"+this.date.to_fixed(date.getHours())+"';
                case "%i":
                  return '"+this.date.to_fixed(date.getMinutes())+"';
                case "%a":
                  return '"+(date.getHours()>11?"pm":"am")+"';
                case "%A":
                  return '"+(date.getHours()>11?"PM":"AM")+"';
                case "%s":
                  return '"+this.date.to_fixed(date.getSeconds())+"';
                case "%W":
                  return '"+this.date.to_fixed(this.date.getISOWeek(date))+"';
                default:
                  return t3;
              }
            }), e2 && (t2 = t2.replace(/date\.get/g, "date.getUTC"));
            var i2 = new Function("date", 'return "' + t2 + '";');
            return g.date._bind_host_object(i2);
          },
          str_to_date: function(t2, e2, i2) {
            var n2 = E(t2, e2), a2 = /^[0-9]{4}(\-|\/)[0-9]{2}(\-|\/)[0-9]{2} ?(([0-9]{1,2}:[0-9]{1,2})(:[0-9]{1,2})?)?$/, r2 = /^[0-9]{2}\/[0-9]{2}\/[0-9]{4} ?(([0-9]{1,2}:[0-9]{2})(:[0-9]{1,2})?)?$/, s2 = /^[0-9]{2}\-[0-9]{2}\-[0-9]{4} ?(([0-9]{1,2}:[0-9]{1,2})(:[0-9]{1,2})?)?$/, o2 = /^([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\3([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T\s]((([01]\d|2[0-3])((:?)[0-5]\d)?|24\:?00)([\.,]\d+(?!:))?)?(\17[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?$/, d2 = function(t3) {
              return a2.test(String(t3));
            }, l2 = function(t3) {
              return r2.test(String(t3));
            }, _2 = function(t3) {
              return s2.test(String(t3));
            }, h2 = function(t3) {
              return o2.test(t3);
            }, c2 = E("%Y-%m-%d %H:%i:%s", e2), u2 = E("%m/%d/%Y %H:%i:%s", e2), f2 = E("%d-%m-%Y %H:%i:%s", e2);
            return function(t3) {
              if (!i2 && !g.config.parse_exact_format) {
                if (t3 && t3.getISOWeek) return new Date(t3);
                if ("number" == typeof t3) return new Date(t3);
                if (d2(t3)) return c2(t3);
                if (l2(t3)) return u2(t3);
                if (_2(t3)) return f2(t3);
                if (h2(t3)) return new Date(t3);
              }
              return n2.call(g, t3);
            };
          },
          getISOWeek: function(t2) {
            if (!t2) return false;
            t2 = this.date_part(new Date(t2));
            var e2 = t2.getDay();
            0 === e2 && (e2 = 7);
            var i2 = new Date(t2.valueOf());
            i2.setDate(t2.getDate() + (4 - e2));
            var n2 = i2.getFullYear(), a2 = Math.round((i2.getTime() - new Date(n2, 0, 1).getTime()) / 864e5);
            return 1 + Math.floor(a2 / 7);
          },
          getUTCISOWeek: function(t2) {
            return this.getISOWeek(this.convert_to_utc(t2));
          },
          convert_to_utc: function(t2) {
            return new Date(t2.getUTCFullYear(), t2.getUTCMonth(), t2.getUTCDate(), t2.getUTCHours(), t2.getUTCMinutes(), t2.getUTCSeconds());
          }
        }, g.locale = { date: {
          month_full: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
          month_short: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
          day_full: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
          day_short: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        }, labels: {
          dhx_cal_today_button: "Today",
          day_tab: "Day",
          week_tab: "Week",
          month_tab: "Month",
          new_event: "New event",
          icon_save: "Save",
          icon_cancel: "Cancel",
          icon_details: "Details",
          icon_edit: "Edit",
          icon_delete: "Delete",
          confirm_closing: "",
          confirm_deleting: "Event will be deleted permanently, are you sure?",
          section_description: "Description",
          section_time: "Time period",
          full_day: "Full day",
          confirm_recurring: "Do you want to edit the whole set of repeated events?",
          section_recurring: "Repeat event",
          button_recurring: "Disabled",
          button_recurring_open: "Enabled",
          button_edit_series: "Edit series",
          button_edit_occurrence: "Edit occurrence",
          agenda_tab: "Agenda",
          date: "Date",
          description: "Description",
          year_tab: "Year",
          week_agenda_tab: "Agenda",
          grid_tab: "Grid",
          drag_to_create: "Drag to create",
          drag_to_move: "Drag to move",
          message_ok: "OK",
          message_cancel: "Cancel",
          next: "Next",
          prev: "Previous",
          year: "Year",
          month: "Month",
          day: "Day",
          hour: "Hour",
          minute: "Minute",
          repeat_radio_day: "Daily",
          repeat_radio_week: "Weekly",
          repeat_radio_month: "Monthly",
          repeat_radio_year: "Yearly",
          repeat_radio_day_type: "Every",
          repeat_text_day_count: "day",
          repeat_radio_day_type2: "Every workday",
          repeat_week: " Repeat every",
          repeat_text_week_count: "week next days:",
          repeat_radio_month_type: "Repeat",
          repeat_radio_month_start: "On",
          repeat_text_month_day: "day every",
          repeat_text_month_count: "month",
          repeat_text_month_count2_before: "every",
          repeat_text_month_count2_after: "month",
          repeat_year_label: "On",
          select_year_day2: "of",
          repeat_text_year_day: "day",
          select_year_month: "month",
          repeat_radio_end: "No end date",
          repeat_text_occurences_count: "occurrences",
          repeat_radio_end2: "After",
          repeat_radio_end3: "End by",
          month_for_recurring: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
          day_for_recurring: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        } }, g.config = {
          default_date: "%j %M %Y",
          month_date: "%F %Y",
          load_date: "%Y-%m-%d",
          week_date: "%l",
          day_date: "%D, %F %j",
          hour_date: "%H:%i",
          month_day: "%d",
          date_format: "%Y-%m-%d %H:%i",
          api_date: "%d-%m-%Y %H:%i",
          parse_exact_format: false,
          preserve_length: true,
          time_step: 5,
          start_on_monday: true,
          first_hour: 0,
          last_hour: 24,
          readonly: false,
          drag_resize: true,
          drag_move: true,
          drag_create: true,
          drag_event_body: true,
          dblclick_create: true,
          edit_on_create: true,
          details_on_create: false,
          header: null,
          resize_month_events: false,
          resize_month_timed: false,
          responsive_lightbox: false,
          rtl: false,
          cascade_event_display: false,
          cascade_event_count: 4,
          cascade_event_margin: 30,
          multi_day: true,
          multi_day_height_limit: 0,
          drag_lightbox: true,
          preserve_scroll: true,
          select: true,
          server_utc: false,
          touch: true,
          touch_tip: true,
          touch_drag: 500,
          touch_swipe_dates: false,
          quick_info_detached: true,
          positive_closing: false,
          drag_highlight: true,
          limit_drag_out: false,
          icons_edit: ["icon_save", "icon_cancel"],
          icons_select: ["icon_details", "icon_edit", "icon_delete"],
          buttons_left: ["dhx_save_btn", "dhx_cancel_btn"],
          buttons_right: ["dhx_delete_btn"],
          lightbox: { sections: [{ name: "description", map_to: "text", type: "textarea", focus: true }, { name: "time", height: 72, type: "time", map_to: "auto" }] },
          highlight_displayed_event: true,
          left_border: false,
          ajax_error: "alert",
          delay_render: 0,
          timeline_swap_resize: true,
          wai_aria_attributes: true,
          wai_aria_application_role: true
        }, g.config.buttons_left.$inital = g.config.buttons_left.join(), g.config.buttons_right.$inital = g.config.buttons_right.join(), g._helpers = { parseDate: function(t2) {
          return (g.templates.xml_date || g.templates.parse_date)(t2);
        }, formatDate: function(t2) {
          return (g.templates.xml_format || g.templates.format_date)(t2);
        } }, g.templates = {}, g.init_templates = function() {
          var t2 = g.locale.labels;
          t2.dhx_save_btn = t2.icon_save, t2.dhx_cancel_btn = t2.icon_cancel, t2.dhx_delete_btn = t2.icon_delete;
          var e2 = g.date.date_to_str, i2 = g.config;
          (function(t3, e3) {
            for (var i3 in e3) t3[i3] || (t3[i3] = e3[i3]);
          })(g.templates, {
            day_date: e2(i2.default_date),
            month_date: e2(i2.month_date),
            week_date: function(t3, e3) {
              return i2.rtl ? g.templates.day_date(g.date.add(e3, -1, "day")) + " &ndash; " + g.templates.day_date(t3) : g.templates.day_date(t3) + " &ndash; " + g.templates.day_date(g.date.add(e3, -1, "day"));
            },
            day_scale_date: e2(i2.default_date),
            month_scale_date: e2(i2.week_date),
            week_scale_date: e2(i2.day_date),
            hour_scale: e2(i2.hour_date),
            time_picker: e2(i2.hour_date),
            event_date: e2(i2.hour_date),
            month_day: e2(i2.month_day),
            load_format: e2(i2.load_date),
            format_date: e2(i2.date_format, i2.server_utc),
            parse_date: g.date.str_to_date(i2.date_format, i2.server_utc),
            api_date: g.date.str_to_date(i2.api_date, false, false),
            event_header: function(t3, e3, i3) {
              return g.templates.event_date(t3) + " - " + g.templates.event_date(e3);
            },
            event_text: function(t3, e3, i3) {
              return i3.text;
            },
            event_class: function(t3, e3, i3) {
              return "";
            },
            month_date_class: function(t3) {
              return "";
            },
            week_date_class: function(t3) {
              return "";
            },
            event_bar_date: function(t3, e3, i3) {
              return g.templates.event_date(t3) + " ";
            },
            event_bar_text: function(t3, e3, i3) {
              return i3.text;
            },
            month_events_link: function(t3, e3) {
              return "<a>View more(" + e3 + " events)</a>";
            },
            drag_marker_class: function(t3, e3, i3) {
              return "";
            },
            drag_marker_content: function(t3, e3, i3) {
              return "";
            },
            tooltip_date_format: g.date.date_to_str("%Y-%m-%d %H:%i"),
            tooltip_text: function(t3, e3, i3) {
              return "<b>Event:</b> " + i3.text + "<br/><b>Start date:</b> " + g.templates.tooltip_date_format(t3) + "<br/><b>End date:</b> " + g.templates.tooltip_date_format(e3);
            }
          }), this.callEvent("onTemplatesReady", []);
        }, g.uid = function() {
          return this._seed || (this._seed = (/* @__PURE__ */ new Date()).valueOf()), this._seed++;
        }, g._events = {}, g.clearAll = function() {
          this._events = {}, this._loaded = {}, this._edit_id = null, this._select_id = null, this._drag_id = null, this._drag_mode = null, this._drag_pos = null, this._new_event = null, this.clear_view(), this.callEvent("onClearAll", []);
        }, g.addEvent = function(t2, e2, i2, n2, a2) {
          if (!arguments.length) return this.addEventNow();
          var r2 = t2;
          1 != arguments.length && (r2 = a2 || {}, r2.start_date = t2, r2.end_date = e2, r2.text = i2, r2.id = n2), r2.id = r2.id || g.uid(), r2.text = r2.text || "", "string" == typeof r2.start_date && (r2.start_date = this.templates.api_date(r2.start_date)), "string" == typeof r2.end_date && (r2.end_date = this.templates.api_date(r2.end_date));
          var s2 = 6e4 * (this.config.event_duration || this.config.time_step);
          r2.start_date.valueOf() == r2.end_date.valueOf() && r2.end_date.setTime(r2.end_date.valueOf() + s2), r2._timed = this.isOneDayEvent(r2);
          var o2 = !this._events[r2.id];
          return this._events[r2.id] = r2, this.event_updated(r2), this._loading || this.callEvent(o2 ? "onEventAdded" : "onEventChanged", [r2.id, r2]), r2.id;
        }, g.deleteEvent = function(t2, e2) {
          var i2 = this._events[t2];
          (e2 || this.callEvent("onBeforeEventDelete", [t2, i2]) && this.callEvent("onConfirmedBeforeEventDelete", [t2, i2])) && (i2 && (this._select_id = null, delete this._events[t2], this.event_updated(i2), this._drag_id == i2.id && (this._drag_id = null, this._drag_mode = null, this._drag_pos = null)), this.callEvent("onEventDeleted", [t2, i2]));
        }, g.getEvent = function(t2) {
          return this._events[t2];
        }, g.setEvent = function(t2, e2) {
          e2.id || (e2.id = t2), this._events[t2] = e2;
        }, g.for_rendered = function(t2, e2) {
          for (var i2 = this._rendered.length - 1; i2 >= 0; i2--) this._rendered[i2].getAttribute("event_id") == t2 && e2(this._rendered[i2], i2);
        }, g.changeEventId = function(t2, e2) {
          if (t2 != e2) {
            var i2 = this._events[t2];
            i2 && (i2.id = e2, this._events[e2] = i2, delete this._events[t2]), this.for_rendered(t2, function(t3) {
              t3.setAttribute("event_id", e2);
            }), this._select_id == t2 && (this._select_id = e2), this._edit_id == t2 && (this._edit_id = e2), this.callEvent("onEventIdChange", [t2, e2]);
          }
        }, function() {
          for (var t2 = ["text", "Text", "start_date", "StartDate", "end_date", "EndDate"], e2 = function(t3) {
            return function(e3) {
              return g.getEvent(e3)[t3];
            };
          }, i2 = function(t3) {
            return function(e3, i3) {
              var n3 = g.getEvent(e3);
              n3[t3] = i3, n3._changed = true, n3._timed = this.isOneDayEvent(n3), g.event_updated(n3, true);
            };
          }, n2 = 0; n2 < t2.length; n2 += 2) g["getEvent" + t2[n2 + 1]] = e2(t2[n2]), g["setEvent" + t2[n2 + 1]] = i2(t2[n2]);
        }(), g.event_updated = function(t2, e2) {
          this.is_visible_events(t2) ? this.render_view_data() : this.clear_event(t2.id);
        }, g.is_visible_events = function(t2) {
          if (t2.start_date.valueOf() < this._max_date.valueOf() && this._min_date.valueOf() < t2.end_date.valueOf()) {
            var e2 = t2.start_date.getHours(), i2 = t2.end_date.getHours() + t2.end_date.getMinutes() / 60, n2 = this.config.last_hour, a2 = this.config.first_hour;
            return !(!this._table_view && (i2 > n2 || i2 < a2) && (e2 >= n2 || e2 < a2)) || !!((t2.end_date.valueOf() - t2.start_date.valueOf()) / 36e5 > 24 - (this.config.last_hour - this.config.first_hour) || e2 < n2 && i2 >= a2);
          }
          return false;
        }, g.isOneDayEvent = function(t2) {
          var e2 = new Date(t2.end_date.valueOf() - 1);
          return t2.start_date.getFullYear() === e2.getFullYear() && t2.start_date.getMonth() === e2.getMonth() && t2.start_date.getDate() === e2.getDate() && t2.end_date.valueOf() - t2.start_date.valueOf() < 864e5;
        }, g.get_visible_events = function(t2) {
          var e2 = [];
          for (var i2 in this._events) this.is_visible_events(this._events[i2]) && (t2 && !this._events[i2]._timed || this.filter_event(i2, this._events[i2]) && e2.push(this._events[i2]));
          return e2;
        }, g.filter_event = function(t2, e2) {
          var i2 = this["filter_" + this._mode];
          return !i2 || i2(t2, e2);
        }, g._is_main_area_event = function(t2) {
          return !!t2._timed;
        }, g.render_view_data = function(t2, e2) {
          var i2 = false;
          if (!t2) {
            if (i2 = true, this._not_render) return void (this._render_wait = true);
            this._render_wait = false, this.clear_view(), t2 = this.get_visible_events(!(this._table_view || this.config.multi_day));
          }
          for (var n2 = 0, a2 = t2.length; n2 < a2; n2++) this._recalculate_timed(t2[n2]);
          if (this.config.multi_day && !this._table_view) {
            for (var r2 = [], s2 = [], n2 = 0; n2 < t2.length; n2++) this._is_main_area_event(t2[n2]) ? r2.push(t2[n2]) : s2.push(t2[n2]);
            if (!this._els.dhx_multi_day) {
              var o2 = g._commonErrorMessages.unknownView(this._mode);
              throw new Error(o2);
            }
            this._rendered_location = this._els.dhx_multi_day[0], this._table_view = true, this.render_data(s2, e2), this._table_view = false, this._rendered_location = this._els.dhx_cal_data[0], this._table_view = false, this.render_data(r2, e2);
          } else {
            var d2 = document.createDocumentFragment(), l2 = this._els.dhx_cal_data[0];
            this._rendered_location = d2, this.render_data(t2, e2), l2.appendChild(d2), this._rendered_location = l2;
          }
          i2 && this.callEvent("onDataRender", []);
        }, g._view_month_day = function(t2) {
          var e2 = g.getActionData(t2).date;
          g.callEvent("onViewMoreClick", [e2]) && g.setCurrentView(e2, "day");
        }, g._render_month_link = function(t2) {
          for (var e2 = this._rendered_location, i2 = this._lame_clone(t2), n2 = t2._sday; n2 < t2._eday; n2++) {
            i2._sday = n2, i2._eday = n2 + 1;
            var a2 = g.date, r2 = g._min_date;
            r2 = a2.add(r2, i2._sweek, "week"), r2 = a2.add(r2, i2._sday, "day");
            var s2 = g.getEvents(r2, a2.add(r2, 1, "day")).length, o2 = this._get_event_bar_pos(i2), d2 = o2.x2 - o2.x, l2 = document.createElement("div");
            l2.onclick = function(t3) {
              g._view_month_day(t3 || event);
            }, l2.className = "dhx_month_link", l2.style.top = o2.y + "px", l2.style.left = o2.x + "px", l2.style.width = d2 + "px", l2.innerHTML = g.templates.month_events_link(r2, s2), this._rendered.push(l2), e2.appendChild(l2);
          }
        }, g._recalculate_timed = function(t2) {
          if (t2) {
            var e2;
            e2 = "object" != typeof t2 ? this._events[t2] : t2, e2 && (e2._timed = g.isOneDayEvent(e2));
          }
        }, g.attachEvent("onEventChanged", g._recalculate_timed), g.attachEvent("onEventAdded", g._recalculate_timed), g.render_data = function(t2, e2) {
          t2 = this._pre_render_events(t2, e2);
          for (var i2 = {}, n2 = 0; n2 < t2.length; n2++) if (this._table_view) if ("month" != g._mode) this.render_event_bar(t2[n2]);
          else {
            var a2 = g.config.max_month_events;
            a2 !== 1 * a2 || t2[n2]._sorder < a2 ? this.render_event_bar(t2[n2]) : void 0 !== a2 && t2[n2]._sorder == a2 && g._render_month_link(t2[n2]);
          }
          else {
            var r2 = t2[n2], s2 = g.locate_holder(r2._sday);
            if (!s2) continue;
            i2[r2._sday] || (i2[r2._sday] = { real: s2, buffer: document.createDocumentFragment(), width: s2.clientWidth });
            var o2 = i2[r2._sday];
            this.render_event(r2, o2.buffer, o2.width);
          }
          for (var n2 in i2) {
            var o2 = i2[n2];
            o2.real && o2.buffer && o2.real.appendChild(o2.buffer);
          }
        }, g._get_first_visible_cell = function(t2) {
          for (var e2 = 0; e2 < t2.length; e2++) if (-1 == (t2[e2].className || "").indexOf("dhx_scale_ignore")) return t2[e2];
          return t2[0];
        }, g._pre_render_events = function(t2, e2) {
          var i2 = this.xy.bar_height, n2 = this._colsS.heights, a2 = this._colsS.heights = [0, 0, 0, 0, 0, 0, 0], r2 = this._els.dhx_cal_data[0];
          if (t2 = this._table_view ? this._pre_render_events_table(t2, e2) : this._pre_render_events_line(t2, e2), this._table_view) if (e2) this._colsS.heights = n2;
          else {
            var s2 = r2.firstChild;
            if (s2.rows) {
              for (var o2 = 0; o2 < s2.rows.length; o2++) {
                a2[o2]++;
                var d2 = s2.rows[o2].cells, l2 = this._colsS.height - this.xy.month_head_height;
                if (a2[o2] * i2 > l2) {
                  var _2 = l2;
                  1 * this.config.max_month_events !== this.config.max_month_events || a2[o2] <= this.config.max_month_events ? _2 = a2[o2] * i2 : (this.config.max_month_events + 1) * i2 > l2 && (_2 = (this.config.max_month_events + 1) * i2);
                  for (var h2 = 0; h2 < d2.length; h2++) d2[h2].childNodes[1].style.height = _2 + "px";
                }
                a2[o2] = (a2[o2 - 1] || 0) + g._get_first_visible_cell(d2).offsetHeight;
              }
              if (a2.unshift(0), s2.parentNode.offsetHeight < s2.parentNode.scrollHeight && !g._colsS.scroll_fix && g.xy.scroll_width) {
                var c2 = g._colsS, u2 = c2[c2.col_length], f2 = c2.heights.slice();
                u2 -= g.xy.scroll_width || 0, this._calc_scale_sizes(u2, this._min_date, this._max_date), g._colsS.heights = f2, this.set_xy(this._els.dhx_cal_header[0], u2, this.xy.scale_height), g._render_scales(this._els.dhx_cal_header[0]), g._render_month_scale(this._els.dhx_cal_data[0], this._get_timeunit_start(), this._min_date), c2.scroll_fix = true;
              }
            } else if (t2.length || "visible" != this._els.dhx_multi_day[0].style.visibility || (a2[0] = -1), t2.length || -1 == a2[0]) {
              var v2 = (s2.parentNode.childNodes, (a2[0] + 1) * i2 + 1), m2 = v2, p2 = v2 + "px";
              this.config.multi_day_height_limit && (m2 = Math.min(v2, this.config.multi_day_height_limit), p2 = m2 + "px"), r2.style.top = this._els.dhx_cal_navline[0].offsetHeight + this._els.dhx_cal_header[0].offsetHeight + m2 + "px", r2.style.height = this._obj.offsetHeight - parseInt(r2.style.top, 10) - (this.xy.margin_top || 0) + "px";
              var x2 = this._els.dhx_multi_day[0];
              x2.style.height = p2, x2.style.visibility = -1 == a2[0] ? "hidden" : "visible";
              var b2 = this._els.dhx_multi_day[1];
              b2.style.height = p2, b2.style.visibility = -1 == a2[0] ? "hidden" : "visible", b2.className = a2[0] ? "dhx_multi_day_icon" : "dhx_multi_day_icon_small", this._dy_shift = (a2[0] + 1) * i2, this.config.multi_day_height_limit && (this._dy_shift = Math.min(this.config.multi_day_height_limit, this._dy_shift)), a2[0] = 0, m2 != v2 && (r2.style.top = parseInt(r2.style.top) + 2 + "px", x2.style.overflowY = "auto", b2.style.position = "fixed", b2.style.top = "", b2.style.left = "");
            }
          }
          return t2;
        }, g._get_event_sday = function(t2) {
          var e2 = this.date.day_start(new Date(t2.start_date));
          return Math.round((e2.valueOf() - this._min_date.valueOf()) / 864e5);
        }, g._get_event_mapped_end_date = function(t2) {
          var e2 = t2.end_date;
          if (this.config.separate_short_events) {
            var i2 = (t2.end_date - t2.start_date) / 6e4;
            i2 < this._min_mapped_duration && (e2 = this.date.add(e2, this._min_mapped_duration - i2, "minute"));
          }
          return e2;
        }, g._pre_render_events_line = function(t2, e2) {
          t2.sort(function(t3, e3) {
            return t3.start_date.valueOf() == e3.start_date.valueOf() ? t3.id > e3.id ? 1 : -1 : t3.start_date > e3.start_date ? 1 : -1;
          });
          var i2 = [], n2 = [];
          this._min_mapped_duration = Math.ceil(60 * this.xy.min_event_height / this.config.hour_size_px);
          for (var a2 = 0; a2 < t2.length; a2++) {
            var r2 = t2[a2], s2 = r2.start_date, o2 = r2.end_date, d2 = s2.getHours(), l2 = o2.getHours();
            if (r2._sday = this._get_event_sday(r2), this._ignores[r2._sday]) t2.splice(a2, 1), a2--;
            else {
              if (i2[r2._sday] || (i2[r2._sday] = []), !e2) {
                r2._inner = false;
                for (var _2 = i2[r2._sday]; _2.length; ) {
                  var h2 = _2[_2.length - 1], c2 = this._get_event_mapped_end_date(h2);
                  if (!(c2.valueOf() <= r2.start_date.valueOf())) break;
                  _2.splice(_2.length - 1, 1);
                }
                for (var u2 = _2.length, f2 = false, g2 = 0; g2 < _2.length; g2++) {
                  var h2 = _2[g2], c2 = this._get_event_mapped_end_date(h2);
                  if (c2.valueOf() <= r2.start_date.valueOf()) {
                    f2 = true, r2._sorder = h2._sorder, u2 = g2, r2._inner = true;
                    break;
                  }
                }
                if (_2.length && (_2[_2.length - 1]._inner = true), !f2) if (_2.length) if (_2.length <= _2[_2.length - 1]._sorder) {
                  if (_2[_2.length - 1]._sorder) for (g2 = 0; g2 < _2.length; g2++) {
                    for (var v2 = false, m2 = 0; m2 < _2.length; m2++) if (_2[m2]._sorder == g2) {
                      v2 = true;
                      break;
                    }
                    if (!v2) {
                      r2._sorder = g2;
                      break;
                    }
                  }
                  else r2._sorder = 0;
                  r2._inner = true;
                } else {
                  var p2 = _2[0]._sorder;
                  for (g2 = 1; g2 < _2.length; g2++) _2[g2]._sorder > p2 && (p2 = _2[g2]._sorder);
                  r2._sorder = p2 + 1, r2._inner = false;
                }
                else r2._sorder = 0;
                _2.splice(u2, u2 == _2.length ? 0 : 1, r2), _2.length > (_2.max_count || 0) ? (_2.max_count = _2.length, r2._count = _2.length) : r2._count = r2._count ? r2._count : 1;
              }
              (d2 < this.config.first_hour || l2 >= this.config.last_hour) && (n2.push(r2), t2[a2] = r2 = this._copy_event(r2), d2 < this.config.first_hour && (r2.start_date.setHours(this.config.first_hour), r2.start_date.setMinutes(0)), l2 >= this.config.last_hour && (r2.end_date.setMinutes(0), r2.end_date.setHours(this.config.last_hour)), r2.start_date > r2.end_date || d2 == this.config.last_hour) && (t2.splice(a2, 1), a2--);
            }
          }
          if (!e2) {
            for (var a2 = 0; a2 < t2.length; a2++) t2[a2]._count = i2[t2[a2]._sday].max_count;
            for (var a2 = 0; a2 < n2.length; a2++) n2[a2]._count = i2[n2[a2]._sday].max_count;
          }
          return t2;
        }, g._time_order = function(t2) {
          t2.sort(function(t3, e2) {
            return t3.start_date.valueOf() == e2.start_date.valueOf() ? t3._timed && !e2._timed ? 1 : !t3._timed && e2._timed ? -1 : t3.id > e2.id ? 1 : -1 : t3.start_date > e2.start_date ? 1 : -1;
          });
        }, g._is_any_multiday_cell_visible = function(t2, e2, i2) {
          var n2 = this._cols.length, a2 = false, r2 = t2, s2 = true, o2 = new Date(e2);
          for (g.date.day_start(new Date(e2)).valueOf() != e2.valueOf() && (o2 = g.date.day_start(o2), o2 = g.date.add(o2, 1, "day")); r2 < o2; ) {
            s2 = false;
            var d2 = this.locate_holder_day(r2, false, i2), l2 = d2 % n2;
            if (!this._ignores[l2]) {
              a2 = true;
              break;
            }
            r2 = g.date.add(r2, 1, "day");
          }
          return s2 || a2;
        }, g._pre_render_events_table = function(t2, e2) {
          this._time_order(t2);
          for (var i2, n2 = [], a2 = [[], [], [], [], [], [], []], r2 = this._colsS.heights, s2 = this._cols.length, o2 = {}, d2 = 0; d2 < t2.length; d2++) {
            var l2 = t2[d2], _2 = l2.id;
            o2[_2] || (o2[_2] = { first_chunk: true, last_chunk: true });
            var h2 = o2[_2], c2 = i2 || l2.start_date, u2 = l2.end_date;
            c2 < this._min_date && (h2.first_chunk = false, c2 = this._min_date), u2 > this._max_date && (h2.last_chunk = false, u2 = this._max_date);
            var f2 = this.locate_holder_day(c2, false, l2);
            if (l2._sday = f2 % s2, !this._ignores[l2._sday] || !l2._timed) {
              var v2 = this.locate_holder_day(u2, true, l2) || s2;
              l2._eday = v2 % s2 || s2, l2._length = v2 - f2, l2._sweek = Math.floor((this._correct_shift(c2.valueOf(), 1) - this._min_date.valueOf()) / (864e5 * s2));
              if (g._is_any_multiday_cell_visible(c2, u2, l2)) {
                var m2, p2 = a2[l2._sweek];
                for (m2 = 0; m2 < p2.length && !(p2[m2]._eday <= l2._sday); m2++) ;
                if (l2._sorder && e2 || (l2._sorder = m2), l2._sday + l2._length <= s2) i2 = null, n2.push(l2), p2[m2] = l2, r2[l2._sweek] = p2.length - 1, l2._first_chunk = h2.first_chunk, l2._last_chunk = h2.last_chunk;
                else {
                  var x2 = this._copy_event(l2);
                  x2.id = l2.id, x2._length = s2 - l2._sday, x2._eday = s2, x2._sday = l2._sday, x2._sweek = l2._sweek, x2._sorder = l2._sorder, x2.end_date = this.date.add(c2, x2._length, "day"), x2._first_chunk = h2.first_chunk, h2.first_chunk && (h2.first_chunk = false), n2.push(x2), p2[m2] = x2, i2 = x2.end_date, r2[l2._sweek] = p2.length - 1, d2--;
                }
              }
            }
          }
          return n2;
        }, g._copy_dummy = function() {
          var t2 = new Date(this.start_date), e2 = new Date(this.end_date);
          this.start_date = t2, this.end_date = e2;
        }, g._copy_event = function(t2) {
          return this._copy_dummy.prototype = t2, new this._copy_dummy();
        }, g._rendered = [], g.clear_view = function() {
          for (var t2 = 0; t2 < this._rendered.length; t2++) {
            var e2 = this._rendered[t2];
            e2.parentNode && e2.parentNode.removeChild(e2);
          }
          this._rendered = [];
        }, g.updateEvent = function(t2) {
          var e2 = this.getEvent(t2);
          this.clear_event(t2), e2 && this.is_visible_events(e2) && this.filter_event(t2, e2) && (this._table_view || this.config.multi_day || e2._timed) && (this.config.update_render ? this.render_view_data() : "month" != this.getState().mode || this.getState().drag_id || this.isOneDayEvent(e2) ? this.render_view_data([e2], true) : this.render_view_data());
        }, g.clear_event = function(t2) {
          this.for_rendered(t2, function(t3, e2) {
            t3.parentNode && t3.parentNode.removeChild(t3), g._rendered.splice(e2, 1);
          });
        }, g._y_from_date = function(t2) {
          var e2 = 60 * t2.getHours() + t2.getMinutes();
          return Math.round((60 * e2 * 1e3 - 60 * this.config.first_hour * 60 * 1e3) * this.config.hour_size_px / 36e5) % (24 * this.config.hour_size_px);
        }, g._calc_event_y = function(t2, e2) {
          e2 = e2 || 0;
          var i2 = 60 * t2.start_date.getHours() + t2.start_date.getMinutes(), n2 = 60 * t2.end_date.getHours() + t2.end_date.getMinutes() || 60 * g.config.last_hour;
          return {
            top: this._y_from_date(t2.start_date),
            height: Math.max(e2, (n2 - i2) * this.config.hour_size_px / 60)
          };
        }, g.render_event = function(t2, e2, i2) {
          var n2 = g.xy.menu_width, a2 = this.config.use_select_menu_space ? 0 : n2;
          if (!(t2._sday < 0)) {
            var r2 = g.locate_holder(t2._sday);
            if (r2) {
              e2 = e2 || r2;
              var s2 = this._calc_event_y(t2, g.xy.min_event_height), o2 = s2.top, d2 = s2.height, l2 = t2._count || 1, _2 = t2._sorder || 0;
              i2 = i2 || r2.clientWidth;
              var h2 = Math.floor((i2 - a2) / l2), c2 = _2 * h2 + 1;
              if (t2._inner || (h2 *= l2 - _2), this.config.cascade_event_display) {
                var u2 = this.config.cascade_event_count, f2 = this.config.cascade_event_margin;
                c2 = _2 % u2 * f2;
                var v2 = t2._inner ? (l2 - _2 - 1) % u2 * f2 / 2 : 0;
                h2 = Math.floor(i2 - a2 - c2 - v2);
              }
              var m2 = this._render_v_bar(t2, a2 + c2, o2, h2, d2, t2._text_style, g.templates.event_header(t2.start_date, t2.end_date, t2), g.templates.event_text(t2.start_date, t2.end_date, t2));
              this._waiAria.eventAttr(t2, m2), this._rendered.push(m2), e2.appendChild(m2);
              if (c2 = c2 + parseInt(this.config.rtl ? r2.style.right : r2.style.left, 10) + a2, this._edit_id == t2.id) {
                m2.style.zIndex = 1, h2 = Math.max(h2 - 4, g.xy.editor_width), m2 = document.createElement("div"), m2.setAttribute("event_id", t2.id), this._waiAria.eventAttr(t2, m2), m2.className = "dhx_cal_event dhx_cal_editor", this.config.rtl && c2++, this.set_xy(m2, h2, d2 - 20, c2, o2 + (g.xy.event_header_height || 14)), t2.color && (m2.style.backgroundColor = t2.color);
                var p2 = g.templates.event_class(t2.start_date, t2.end_date, t2);
                p2 && (m2.className += " " + p2);
                var x2 = document.createElement("div");
                this.set_xy(x2, h2 - 6, d2 - 26), x2.style.cssText += ";margin:2px 2px 2px 2px;overflow:hidden;", m2.appendChild(x2), this._els.dhx_cal_data[0].appendChild(m2), this._rendered.push(m2), x2.innerHTML = "<textarea class='dhx_cal_editor'>" + t2.text + "</textarea>", this._editor = x2.querySelector("textarea"), this._quirks7 && (this._editor.style.height = d2 - 12 + "px"), this._editor.onkeydown = function(t3) {
                  if ((t3 || event).shiftKey) return true;
                  var e3 = (t3 || event).keyCode;
                  e3 == g.keys.edit_save && g.editStop(true), e3 == g.keys.edit_cancel && g.editStop(false), e3 != g.keys.edit_save && e3 != g.keys.edit_cancel || t3.preventDefault && t3.preventDefault();
                }, this._editor.onselectstart = function(t3) {
                  return (t3 || event).cancelBubble = true, true;
                }, g._focus(this._editor, true), this._els.dhx_cal_data[0].scrollLeft = 0;
              }
              if (0 !== this.xy.menu_width && this._select_id == t2.id) {
                this.config.cascade_event_display && this._drag_mode && (m2.style.zIndex = 1);
                for (var b2, y2 = this.config["icons_" + (this._edit_id == t2.id ? "edit" : "select")], w2 = "", D2 = t2.color ? "background-color: " + t2.color + ";" : "", E2 = t2.textColor ? "color: " + t2.textColor + ";" : "", A2 = 0; A2 < y2.length; A2++) b2 = this._waiAria.eventMenuAttrString(y2[A2]), w2 += "<div class='dhx_menu_icon " + y2[A2] + "' style='" + D2 + E2 + "' title='" + this.locale.labels[y2[A2]] + "'" + b2 + "></div>";
                var k2 = this._render_v_bar(t2, c2 - n2 + 1, o2, n2, 20 * y2.length + 26 - 2, "", "<div style='" + D2 + E2 + "' class='dhx_menu_head'></div>", w2, true);
                k2.style.left = c2 - n2 + 1, this._els.dhx_cal_data[0].appendChild(k2), this._rendered.push(k2);
              }
              this.config.drag_highlight && this._drag_id == t2.id && this.highlightEventPosition(t2);
            }
          }
        }, g._render_v_bar = function(t2, e2, i2, n2, a2, r2, s2, o2, d2) {
          var l2 = document.createElement("div"), _2 = t2.id, h2 = d2 ? "dhx_cal_event dhx_cal_select_menu" : "dhx_cal_event", c2 = g.getState();
          c2.drag_id == t2.id && (h2 += " dhx_cal_event_drag"), c2.select_id == t2.id && (h2 += " dhx_cal_event_selected");
          var u2 = g.templates.event_class(t2.start_date, t2.end_date, t2);
          u2 && (h2 = h2 + " " + u2), this.config.cascade_event_display && (h2 += " dhx_cal_event_cascade");
          var f2 = t2.color ? "background-color:" + t2.color + ";" : "", v2 = t2.textColor ? "color:" + t2.textColor + ";" : "", m2 = g._border_box_events(), p2 = n2 - 2, x2 = m2 ? p2 : n2 - 4, b2 = m2 ? p2 : n2 - 6, y2 = m2 ? p2 : n2 - (this._quirks ? 4 : 14), w2 = m2 ? p2 - 2 : n2 - 8, D2 = m2 ? a2 - this.xy.event_header_height - 1 : a2 - (this._quirks ? 20 : 30) + 1, E2 = '<div event_id="' + _2 + '" class="' + h2 + '" style="position:absolute; top:' + i2 + "px; " + (this.config.rtl ? "right:" : "left:") + e2 + "px; width:" + x2 + "px; height:" + a2 + "px;" + (r2 || "") + '"></div>';
          l2.innerHTML = E2;
          var A2 = l2.cloneNode(true).firstChild;
          if (!d2 && g.renderEvent(A2, t2, n2, a2, s2, o2)) return A2;
          A2 = l2.firstChild;
          var k2 = '<div class="dhx_event_move dhx_header" style=" width:' + b2 + "px;" + f2 + '" >&nbsp;</div>';
          k2 += '<div class="dhx_event_move dhx_title" style="' + f2 + v2 + '">' + s2 + "</div>", k2 += '<div class="dhx_body" style=" width:' + y2 + "px; height:" + D2 + "px;" + f2 + v2 + '">' + o2 + "</div>";
          var S2 = "dhx_event_resize dhx_footer";
          return (d2 || false === t2._drag_resize) && (S2 = "dhx_resize_denied " + S2), k2 += '<div class="' + S2 + '" style=" width:' + w2 + "px;" + (d2 ? " margin-top:-1px;" : "") + f2 + v2 + '" ></div>', A2.innerHTML = k2, A2;
        }, g.renderEvent = function() {
          return false;
        }, g.locate_holder = function(t2) {
          return "day" == this._mode ? this._els.dhx_cal_data[0].firstChild : this._els.dhx_cal_data[0].childNodes[t2];
        }, g.locate_holder_day = function(t2, e2) {
          var i2 = Math.floor((this._correct_shift(t2, 1) - this._min_date) / 864e5);
          return e2 && this.date.time_part(t2) && i2++, i2;
        }, g._get_dnd_order = function(t2, e2, i2) {
          if (!this._drag_event) return t2;
          this._drag_event._orig_sorder ? t2 = this._drag_event._orig_sorder : this._drag_event._orig_sorder = t2;
          for (var n2 = e2 * t2; n2 + e2 > i2; ) t2--, n2 -= e2;
          return t2 = Math.max(t2, 0);
        }, g._get_event_bar_pos = function(t2) {
          var e2 = this.config.rtl, i2 = this._colsS, n2 = i2[t2._sday], a2 = i2[t2._eday];
          e2 && (n2 = i2[i2.col_length] - i2[t2._eday] + i2[0], a2 = i2[i2.col_length] - i2[t2._sday] + i2[0]), a2 == n2 && (a2 = i2[t2._eday + 1]);
          var r2 = this.xy.bar_height, s2 = t2._sorder;
          if (t2.id == this._drag_id) {
            var o2 = i2.heights[t2._sweek + 1] - i2.heights[t2._sweek] - this.xy.month_head_height;
            s2 = g._get_dnd_order(s2, r2, o2);
          }
          var d2 = s2 * r2;
          return { x: n2, x2: a2, y: i2.heights[t2._sweek] + (i2.height ? this.xy.month_scale_height + 2 : 2) + d2 };
        }, g.render_event_bar = function(t2) {
          var e2 = this._rendered_location, i2 = this._get_event_bar_pos(t2), n2 = i2.y, a2 = i2.x, r2 = i2.x2, s2 = "";
          if (r2) {
            var o2 = g.config.resize_month_events && "month" == this._mode && (!t2._timed || g.config.resize_month_timed), d2 = document.createElement("div"), l2 = t2.hasOwnProperty("_first_chunk") && t2._first_chunk, _2 = t2.hasOwnProperty("_last_chunk") && t2._last_chunk, h2 = o2 && (t2._timed || l2), c2 = o2 && (t2._timed || _2), u2 = true, f2 = "dhx_cal_event_clear";
            t2._timed && !o2 || (u2 = false, f2 = "dhx_cal_event_line"), l2 && (f2 += " dhx_cal_event_line_start"), _2 && (f2 += " dhx_cal_event_line_end"), h2 && (s2 += "<div class='dhx_event_resize dhx_event_resize_start'></div>"), c2 && (s2 += "<div class='dhx_event_resize dhx_event_resize_end'></div>");
            var v2 = g.templates.event_class(t2.start_date, t2.end_date, t2);
            v2 && (f2 += " " + v2);
            var m2 = t2.color ? "background:" + t2.color + ";" : "", p2 = t2.textColor ? "color:" + t2.textColor + ";" : "", x2 = ["position:absolute", "top:" + n2 + "px", "left:" + a2 + "px", "width:" + (r2 - a2 - 3 - (u2 ? 1 : 0)) + "px", p2, m2, t2._text_style || ""].join(";"), b2 = "<div event_id='" + t2.id + "' class='" + f2 + "' style='" + x2 + "'" + this._waiAria.eventBarAttrString(t2) + ">";
            o2 && (b2 += s2), "month" == g.getState().mode && (t2 = g.getEvent(t2.id)), t2._timed && (b2 += g.templates.event_bar_date(t2.start_date, t2.end_date, t2)), b2 += g.templates.event_bar_text(t2.start_date, t2.end_date, t2) + "</div>", b2 += "</div>", d2.innerHTML = b2, this._rendered.push(d2.firstChild), e2.appendChild(d2.firstChild);
          }
        }, g._locate_event = function(t2) {
          for (var e2 = null; t2 && !e2 && t2.getAttribute; ) e2 = t2.getAttribute("event_id"), t2 = t2.parentNode;
          return e2;
        }, g._locate_css = function(t2, e2, i2) {
          void 0 === i2 && (i2 = true);
          for (var n2 = t2.target || t2.srcElement, a2 = ""; n2; ) {
            if (a2 = g._getClassName(n2)) {
              var r2 = a2.indexOf(e2);
              if (r2 >= 0) {
                if (!i2) return n2;
                var s2 = 0 === r2 || !g._trim(a2.charAt(r2 - 1)), o2 = r2 + e2.length >= a2.length || !g._trim(a2.charAt(r2 + e2.length));
                if (s2 && o2) return n2;
              }
            }
            n2 = n2.parentNode;
          }
          return null;
        }, g.edit = function(t2) {
          this._edit_id != t2 && (this.editStop(false, t2), this._edit_id = t2, this.updateEvent(t2));
        }, g.editStop = function(t2, e2) {
          if (!e2 || this._edit_id != e2) {
            var i2 = this.getEvent(this._edit_id);
            i2 && (t2 && (i2.text = this._editor.value), this._edit_id = null, this._editor = null, this.updateEvent(i2.id), this._edit_stop_event(i2, t2));
          }
        }, g._edit_stop_event = function(t2, e2) {
          this._new_event ? (e2 ? this.callEvent("onEventAdded", [t2.id, t2]) : t2 && this.deleteEvent(t2.id, true), this._new_event = null) : e2 && this.callEvent("onEventChanged", [t2.id, t2]);
        }, g.getEvents = function(t2, e2) {
          var i2 = [];
          for (var n2 in this._events) {
            var a2 = this._events[n2];
            a2 && (!t2 && !e2 || a2.start_date < e2 && a2.end_date > t2) && i2.push(a2);
          }
          return i2;
        }, g.getRenderedEvent = function(t2) {
          if (t2) {
            for (var e2 = g._rendered, i2 = 0; i2 < e2.length; i2++) {
              var n2 = e2[i2];
              if (n2.getAttribute("event_id") == t2) return n2;
            }
            return null;
          }
        }, g.showEvent = function(t2, e2) {
          var i2;
          t2 && "object" == typeof t2 && (e2 = t2.mode, i2 = t2.section, t2 = t2.section);
          var n2 = "number" == typeof t2 || "string" == typeof t2 ? g.getEvent(t2) : t2;
          if (e2 = e2 || g._mode, n2 && (!this.checkEvent("onBeforeEventDisplay") || this.callEvent("onBeforeEventDisplay", [n2, e2]))) {
            var a2 = g.config.scroll_hour;
            g.config.scroll_hour = n2.start_date.getHours();
            var r2 = g.config.preserve_scroll;
            g.config.preserve_scroll = false;
            var s2 = n2.color, o2 = n2.textColor;
            if (g.config.highlight_displayed_event && (n2.color = g.config.displayed_event_color, n2.textColor = g.config.displayed_event_text_color), g.setCurrentView(new Date(n2.start_date), e2), n2.color = s2, n2.textColor = o2, g.config.scroll_hour = a2, g.config.preserve_scroll = r2, g.matrix && g.matrix[e2]) {
              var d2 = g.getView(), l2 = d2.y_property, _2 = g.getEvent(n2.id);
              if (_2) {
                if (!i2) {
                  var i2 = _2[l2];
                  Array.isArray(i2) ? i2 = i2[0] : "string" == typeof i2 && g.config.section_delimiter && i2.indexOf(g.config.section_delimiter) > -1 && (i2 = i2.split(g.config.section_delimiter)[0]);
                }
                var h2 = d2.posFromSection(i2), c2 = d2.posFromDate(_2.start_date), u2 = g.$container.querySelector(".dhx_timeline_data_wrapper");
                c2 -= (u2.offsetWidth - d2.dx) / 2, h2 = h2 - u2.offsetHeight / 2 + d2.dy / 2, d2.scrollTo({ left: c2, top: h2 });
              }
            }
            g.callEvent("onAfterEventDisplay", [n2, e2]);
          }
        }, g._append_drag_marker = function(t2) {
          if (!t2.parentNode) {
            var e2 = g._els.dhx_cal_data[0], i2 = e2.lastChild, n2 = g._getClassName(i2);
            n2.indexOf("dhx_scale_holder") < 0 && i2.previousSibling && (i2 = i2.previousSibling), n2 = g._getClassName(i2), i2 && 0 === n2.indexOf("dhx_scale_holder") && i2.appendChild(t2);
          }
        }, g._update_marker_position = function(t2, e2) {
          var i2 = g._calc_event_y(e2, 0);
          t2.style.top = i2.top + "px", t2.style.height = i2.height + "px";
        }, g.highlightEventPosition = function(t2) {
          var e2 = document.createElement("div");
          e2.setAttribute("event_id", t2.id), this._rendered.push(e2), this._update_marker_position(e2, t2);
          var i2 = this.templates.drag_marker_class(t2.start_date, t2.end_date, t2), n2 = this.templates.drag_marker_content(t2.start_date, t2.end_date, t2);
          e2.className = "dhx_drag_marker", i2 && (e2.className += " " + i2), n2 && (e2.innerHTML = n2), this._append_drag_marker(e2);
        }, g._loaded = {}, g._load = function(t2, e2) {
          function i2(t3) {
            g.on_load(t3), g.callEvent("onLoadEnd", []);
          }
          if (t2 = t2 || this._load_url) {
            t2 += (-1 == t2.indexOf("?") ? "?" : "&") + "timeshift=" + (/* @__PURE__ */ new Date()).getTimezoneOffset(), this.config.prevent_cache && (t2 += "&uid=" + this.uid());
            var n2;
            if (e2 = e2 || this._date, this._load_mode) {
              var a2 = this.templates.load_format;
              for (e2 = this.date[this._load_mode + "_start"](new Date(e2.valueOf())); e2 > this._min_date; ) e2 = this.date.add(e2, -1, this._load_mode);
              n2 = e2;
              for (var r2 = true; n2 < this._max_date; ) n2 = this.date.add(n2, 1, this._load_mode), this._loaded[a2(e2)] && r2 ? e2 = this.date.add(e2, 1, this._load_mode) : r2 = false;
              var s2 = n2;
              do {
                n2 = s2, s2 = this.date.add(n2, -1, this._load_mode);
              } while (s2 > e2 && this._loaded[a2(s2)]);
              if (n2 <= e2) return false;
              for (g.$ajax.get(t2 + "&from=" + a2(e2) + "&to=" + a2(n2), i2); e2 < n2; ) this._loaded[a2(e2)] = true, e2 = this.date.add(e2, 1, this._load_mode);
            } else g.$ajax.get(t2, i2);
            return this.callEvent("onXLS", []), this.callEvent("onLoadStart", []), true;
          }
        }, g._parsers = {}, g._parsers.xml = { canParse: function(t2, e2) {
          if (e2.responseXML && e2.responseXML.firstChild) return true;
          try {
            var i2 = g.$ajax.parse(e2.responseText), n2 = g.$ajax.xmltop("data", i2);
            if (n2 && "data" === n2.tagName) return true;
          } catch (t3) {
          }
          return false;
        }, parse: function(t2) {
          var e2;
          if (t2.xmlDoc.responseXML || (t2.xmlDoc.responseXML = g.$ajax.parse(t2.xmlDoc.responseText)), e2 = g.$ajax.xmltop("data", t2.xmlDoc), "data" != e2.tagName) return null;
          var i2 = e2.getAttribute("dhx_security");
          i2 && (window.dhtmlx && (dhtmlx.security_key = i2), g.security_key = i2);
          for (var n2 = g.$ajax.xpath("//coll_options", t2.xmlDoc), a2 = 0; a2 < n2.length; a2++) {
            var r2 = n2[a2].getAttribute("for"), s2 = g.serverList[r2];
            s2 || (g.serverList[r2] = s2 = []), s2.splice(0, s2.length);
            for (var o2 = g.$ajax.xpath(".//item", n2[a2]), d2 = 0; d2 < o2.length; d2++) {
              for (var l2 = o2[d2], _2 = l2.attributes, h2 = { key: o2[d2].getAttribute("value"), label: o2[d2].getAttribute("label") }, c2 = 0; c2 < _2.length; c2++) {
                var u2 = _2[c2];
                "value" != u2.nodeName && "label" != u2.nodeName && (h2[u2.nodeName] = u2.nodeValue);
              }
              s2.push(h2);
            }
          }
          n2.length && g.callEvent("onOptionsLoad", []);
          for (var f2 = g.$ajax.xpath("//userdata", t2.xmlDoc), a2 = 0; a2 < f2.length; a2++) {
            var v2 = g._xmlNodeToJSON(f2[a2]);
            g._userdata[v2.name] = v2.text;
          }
          var m2 = [];
          e2 = g.$ajax.xpath("//event", t2.xmlDoc);
          for (var a2 = 0; a2 < e2.length; a2++) {
            var p2 = m2[a2] = g._xmlNodeToJSON(e2[a2]);
            g._init_event(p2);
          }
          return m2;
        } }, g.json = g._parsers.json = { canParse: function(t2) {
          if (t2 && "object" == typeof t2) return true;
          if ("string" == typeof t2) try {
            var e2 = JSON.parse(t2);
            return "[object Object]" === Object.prototype.toString.call(e2) || "[object Array]" === Object.prototype.toString.call(e2);
          } catch (t3) {
            return false;
          }
          return false;
        }, parse: function(t2) {
          var e2 = [];
          "string" == typeof t2 && (t2 = JSON.parse(t2)), e2 = "[object Array]" === Object.prototype.toString.call(t2) ? t2 : t2 ? t2.data : [], e2 = e2 || [], t2.dhx_security && (window.dhtmlx && (dhtmlx.security_key = t2.dhx_security), g.security_key = t2.dhx_security);
          var i2 = t2 && t2.collections ? t2.collections : {}, n2 = false;
          for (var a2 in i2) if (i2.hasOwnProperty(a2)) {
            n2 = true;
            var r2 = i2[a2], s2 = g.serverList[a2];
            s2 || (g.serverList[a2] = s2 = []), s2.splice(0, s2.length);
            for (var o2 = 0; o2 < r2.length; o2++) {
              var d2 = r2[o2], l2 = { key: d2.value, label: d2.label };
              for (var _2 in d2) if (d2.hasOwnProperty(_2)) {
                if ("value" == _2 || "label" == _2) continue;
                l2[_2] = d2[_2];
              }
              s2.push(l2);
            }
          }
          n2 && g.callEvent("onOptionsLoad", []);
          for (var h2 = [], c2 = 0; c2 < e2.length; c2++) {
            var u2 = e2[c2];
            g._init_event(u2), h2.push(u2);
          }
          return h2;
        } }, g.ical = g._parsers.ical = { canParse: function(t2) {
          return "string" == typeof t2 && new RegExp("^BEGIN:VCALENDAR").test(t2);
        }, parse: function(t2) {
          var e2 = t2.match(RegExp(this.c_start + "[^\f]*" + this.c_end, ""));
          if (e2.length) {
            e2[0] = e2[0].replace(/[\r\n]+ /g, ""), e2[0] = e2[0].replace(/[\r\n]+(?=[a-z \t])/g, " "), e2[0] = e2[0].replace(/\;[^:\r\n]*:/g, ":");
            for (var i2, n2 = [], a2 = RegExp("(?:" + this.e_start + ")([^\f]*?)(?:" + this.e_end + ")", "g"); null !== (i2 = a2.exec(e2)); ) {
              for (var r2, s2 = {}, o2 = /[^\r\n]+[\r\n]+/g; null !== (r2 = o2.exec(i2[1])); ) this.parse_param(r2.toString(), s2);
              s2.uid && !s2.id && (s2.id = s2.uid), n2.push(s2);
            }
            return n2;
          }
        }, parse_param: function(t2, e2) {
          var i2 = t2.indexOf(":");
          if (-1 != i2) {
            var n2 = t2.substr(0, i2).toLowerCase(), a2 = t2.substr(i2 + 1).replace(/\\\,/g, ",").replace(/[\r\n]+$/, "");
            "summary" == n2 ? n2 = "text" : "dtstart" == n2 ? (n2 = "start_date", a2 = this.parse_date(a2, 0, 0)) : "dtend" == n2 && (n2 = "end_date", a2 = this.parse_date(a2, 0, 0)), e2[n2] = a2;
          }
        }, parse_date: function(t2, e2, i2) {
          var n2 = t2.split("T"), a2 = false;
          n2[1] && (e2 = n2[1].substr(0, 2), i2 = n2[1].substr(2, 2), a2 = !("Z" != n2[1][6]));
          var r2 = n2[0].substr(0, 4), s2 = parseInt(n2[0].substr(4, 2), 10) - 1, o2 = n2[0].substr(6, 2);
          return g.config.server_utc || a2 ? new Date(Date.UTC(r2, s2, o2, e2, i2)) : new Date(r2, s2, o2, e2, i2);
        }, c_start: "BEGIN:VCALENDAR", e_start: "BEGIN:VEVENT", e_end: "END:VEVENT", c_end: "END:VCALENDAR" }, g.on_load = function(t2) {
          this.callEvent("onBeforeParse", []);
          var e2, i2 = false, n2 = false;
          for (var a2 in this._parsers) {
            var r2 = this._parsers[a2];
            if (r2.canParse(t2.xmlDoc.responseText, t2.xmlDoc)) {
              try {
                var s2 = t2.xmlDoc.responseText;
                "xml" === a2 && (s2 = t2), e2 = r2.parse(s2), e2 || (i2 = true);
              } catch (t3) {
                i2 = true;
              }
              n2 = true;
              break;
            }
          }
          if (!n2) if (this._process && this[this._process]) try {
            e2 = this[this._process].parse(t2.xmlDoc.responseText);
          } catch (t3) {
            i2 = true;
          }
          else i2 = true;
          (i2 || t2.xmlDoc.status && t2.xmlDoc.status >= 400) && (this.callEvent("onLoadError", [t2.xmlDoc]), e2 = []), this._process_loading(e2), this.callEvent("onXLE", []), this.callEvent("onParse", []);
        }, g._process_loading = function(t2) {
          this._loading = true, this._not_render = true;
          for (var e2 = 0; e2 < t2.length; e2++) this.callEvent("onEventLoading", [t2[e2]]) && this.addEvent(t2[e2]);
          this._not_render = false, this._render_wait && this.render_view_data(), this._loading = false, this._after_call && this._after_call(), this._after_call = null;
        }, g._init_event = function(t2) {
          t2.text = t2.text || t2._tagvalue || "", t2.start_date = g._init_date(t2.start_date), t2.end_date = g._init_date(t2.end_date);
        }, g._init_date = function(t2) {
          return t2 ? "string" == typeof t2 ? g._helpers.parseDate(t2) : new Date(t2) : null;
        }, g.json = {}, g.json.parse = function(t2) {
          var e2 = [];
          "string" == typeof t2 && (t2 = JSON.parse(t2)), e2 = "[object Array]" === Object.prototype.toString.call(t2) ? t2 : t2 ? t2.data : [], e2 = e2 || [], t2.dhx_security && (window.dhtmlx && (dhtmlx.security_key = t2.dhx_security), g.security_key = t2.dhx_security);
          var i2 = t2 && t2.collections ? t2.collections : {}, n2 = false;
          for (var a2 in i2) if (i2.hasOwnProperty(a2)) {
            n2 = true;
            var r2 = i2[a2], s2 = g.serverList[a2];
            s2 || (g.serverList[a2] = s2 = []), s2.splice(0, s2.length);
            for (var o2 = 0; o2 < r2.length; o2++) {
              var d2 = r2[o2], l2 = { key: d2.value, label: d2.label };
              for (var _2 in d2) if (d2.hasOwnProperty(_2)) {
                if ("value" == _2 || "label" == _2) continue;
                l2[_2] = d2[_2];
              }
              s2.push(l2);
            }
          }
          n2 && g.callEvent("onOptionsLoad", []);
          for (var h2 = [], c2 = 0; c2 < e2.length; c2++) {
            var u2 = e2[c2];
            g._init_event(u2), h2.push(u2);
          }
          return h2;
        }, g.parse = function(t2, e2) {
          this._process = e2, this.on_load({ xmlDoc: { responseText: t2 } });
        }, g.load = function(t2, e2) {
          "string" == typeof e2 && (this._process = e2, e2 = arguments[2]), this._load_url = t2, this._after_call = e2, this._load(t2, this._date);
        }, g.setLoadMode = function(t2) {
          "all" == t2 && (t2 = ""), this._load_mode = t2;
        }, g.serverList = function(t2, e2) {
          return e2 ? (this.serverList[t2] = e2.slice(0), this.serverList[t2]) : (this.serverList[t2] = this.serverList[t2] || [], this.serverList[t2]);
        }, g._userdata = {}, g._xmlNodeToJSON = function(t2) {
          for (var e2 = {}, i2 = 0; i2 < t2.attributes.length; i2++) e2[t2.attributes[i2].name] = t2.attributes[i2].value;
          for (var i2 = 0; i2 < t2.childNodes.length; i2++) {
            var n2 = t2.childNodes[i2];
            1 == n2.nodeType && (e2[n2.tagName] = n2.firstChild ? n2.firstChild.nodeValue : "");
          }
          return e2.text || (e2.text = t2.firstChild ? t2.firstChild.nodeValue : ""), e2;
        }, g.attachEvent("onXLS", function() {
          if (true === this.config.show_loading) {
            var t2;
            t2 = this.config.show_loading = document.createElement("div"), t2.className = "dhx_loading", t2.style.left = Math.round((this._x - 128) / 2) + "px", t2.style.top = Math.round((this._y - 15) / 2) + "px", this._obj.appendChild(t2);
          }
        }), g.attachEvent("onXLE", function() {
          var t2 = this.config.show_loading;
          t2 && "object" == typeof t2 && (t2.parentNode && t2.parentNode.removeChild(t2), this.config.show_loading = true);
        }), g._lightbox_controls = {}, g.formSection = function(t2) {
          var e2 = this.config.lightbox.sections, i2 = 0;
          for (i2; i2 < e2.length && e2[i2].name != t2; i2++) ;
          var n2 = e2[i2];
          g._lightbox || g.getLightbox();
          var a2 = document.getElementById(n2.id), r2 = a2.nextSibling, s2 = { section: n2, header: a2, node: r2, getValue: function(t3) {
            return g.form_blocks[n2.type].get_value(r2, t3 || {}, n2);
          }, setValue: function(t3, e3) {
            return g.form_blocks[n2.type].set_value(r2, t3, e3 || {}, n2);
          } }, o2 = g._lightbox_controls["get_" + n2.type + "_control"];
          return o2 ? o2(s2) : s2;
        }, g._lightbox_controls.get_template_control = function(t2) {
          return t2.control = t2.node, t2;
        }, g._lightbox_controls.get_select_control = function(t2) {
          return t2.control = t2.node.getElementsByTagName("select")[0], t2;
        }, g._lightbox_controls.get_textarea_control = function(t2) {
          return t2.control = t2.node.getElementsByTagName("textarea")[0], t2;
        }, g._lightbox_controls.get_time_control = function(t2) {
          return t2.control = t2.node.getElementsByTagName("select"), t2;
        }, g._lightbox_controls.defaults = { template: { height: 30 }, textarea: { height: 200 }, select: { height: 23 }, time: { height: 20 } }, g.form_blocks = { template: { render: function(t2) {
          var e2 = g._lightbox_controls.defaults.template, i2 = e2 ? e2.height : 30;
          return "<div class='dhx_cal_ltext dhx_cal_template' style='height:" + (t2.height || i2 || 30) + "px;'></div>";
        }, set_value: function(t2, e2, i2, n2) {
          t2.innerHTML = e2 || "";
        }, get_value: function(t2, e2, i2) {
          return t2.innerHTML || "";
        }, focus: function(t2) {
        } }, textarea: {
          render: function(t2) {
            var e2 = g._lightbox_controls.defaults.textarea, i2 = e2 ? e2.height : 200;
            return "<div class='dhx_cal_ltext' style='height:" + (t2.height || i2 || "130") + "px;'><textarea></textarea></div>";
          },
          set_value: function(t2, e2, i2) {
            g.form_blocks.textarea._get_input(t2).value = e2 || "";
          },
          get_value: function(t2, e2) {
            return g.form_blocks.textarea._get_input(t2).value;
          },
          focus: function(t2) {
            var e2 = g.form_blocks.textarea._get_input(t2);
            g._focus(e2, true);
          },
          _get_input: function(t2) {
            return t2.getElementsByTagName("textarea")[0];
          }
        }, select: {
          render: function(t2) {
            for (var e2 = g._lightbox_controls.defaults.select, i2 = e2 ? e2.height : 23, n2 = (t2.height || i2 || "23") + "px", a2 = "<div class='dhx_cal_ltext' style='height:" + n2 + ";'><select style='width:100%;'>", r2 = 0; r2 < t2.options.length; r2++) a2 += "<option value='" + t2.options[r2].key + "'>" + t2.options[r2].label + "</option>";
            return a2 += "</select></div>";
          },
          set_value: function(t2, e2, i2, n2) {
            var a2 = t2.firstChild;
            !a2._dhx_onchange && n2.onchange && (a2.onchange = n2.onchange, a2._dhx_onchange = true), void 0 === e2 && (e2 = (a2.options[0] || {}).value), a2.value = e2 || "";
          },
          get_value: function(t2, e2) {
            return t2.firstChild.value;
          },
          focus: function(t2) {
            var e2 = t2.firstChild;
            g._focus(e2, true);
          }
        }, time: { render: function(t2) {
          t2.time_format || (t2.time_format = ["%H:%i", "%d", "%m", "%Y"]), t2._time_format_order = {};
          var e2 = t2.time_format, i2 = g.config, n2 = g.date.date_part(g._currentDate()), a2 = 1440, r2 = 0;
          g.config.limit_time_select && (a2 = 60 * i2.last_hour + 1, r2 = 60 * i2.first_hour, n2.setHours(i2.first_hour));
          for (var s2 = "", o2 = 0; o2 < e2.length; o2++) {
            var d2 = e2[o2];
            o2 > 0 && (s2 += " ");
            var l2 = "", _2 = "";
            switch (d2) {
              case "%Y":
                l2 = "dhx_lightbox_year_select", t2._time_format_order[3] = o2;
                var h2, c2, u2;
                t2.year_range && (isNaN(t2.year_range) ? t2.year_range.push && (c2 = t2.year_range[0], u2 = t2.year_range[1]) : h2 = t2.year_range), h2 = h2 || 10;
                var f2 = f2 || Math.floor(h2 / 2);
                c2 = c2 || n2.getFullYear() - f2, u2 = u2 || c2 + h2;
                for (var v2 = c2; v2 < u2; v2++) _2 += "<option value='" + v2 + "'>" + v2 + "</option>";
                break;
              case "%m":
                l2 = "dhx_lightbox_month_select", t2._time_format_order[2] = o2;
                for (var v2 = 0; v2 < 12; v2++) _2 += "<option value='" + v2 + "'>" + this.locale.date.month_full[v2] + "</option>";
                break;
              case "%d":
                l2 = "dhx_lightbox_day_select", t2._time_format_order[1] = o2;
                for (var v2 = 1; v2 < 32; v2++) _2 += "<option value='" + v2 + "'>" + v2 + "</option>";
                break;
              case "%H:%i":
                l2 = "dhx_lightbox_time_select", t2._time_format_order[0] = o2;
                var v2 = r2, m2 = n2.getDate();
                for (t2._time_values = []; v2 < a2; ) {
                  _2 += "<option value='" + v2 + "'>" + this.templates.time_picker(n2) + "</option>", t2._time_values.push(v2), n2.setTime(n2.valueOf() + 60 * this.config.time_step * 1e3);
                  v2 = 24 * (n2.getDate() != m2 ? 1 : 0) * 60 + 60 * n2.getHours() + n2.getMinutes();
                }
            }
            if (_2) {
              var p2 = g._waiAria.lightboxSelectAttrString(d2);
              s2 += "<select class='" + l2 + "' " + (t2.readonly ? "disabled='disabled'" : "") + p2 + ">" + _2 + "</select> ";
            }
          }
          var x2 = g._lightbox_controls.defaults.select;
          return "<div style='height:" + ((x2 ? x2.height : 23) || 30) + "px;padding-top:0px;font-size:inherit;' class='dhx_section_time'>" + s2 + "<span style='font-weight:normal; font-size:10pt;'> &nbsp;&ndash;&nbsp; </span>" + s2 + "</div>";
        }, set_value: function(t2, e2, i2, n2) {
          function a2(t3, e3, i3) {
            for (var a3 = n2._time_values, r3 = 60 * i3.getHours() + i3.getMinutes(), s3 = r3, o3 = false, d3 = 0; d3 < a3.length; d3++) {
              var _3 = a3[d3];
              if (_3 === r3) {
                o3 = true;
                break;
              }
              _3 < r3 && (s3 = _3);
            }
            t3[e3 + l2[0]].value = o3 ? r3 : s3, o3 || s3 || (t3[e3 + l2[0]].selectedIndex = -1), t3[e3 + l2[1]].value = i3.getDate(), t3[e3 + l2[2]].value = i3.getMonth(), t3[e3 + l2[3]].value = i3.getFullYear();
          }
          var r2, s2, o2 = g.config, d2 = t2.getElementsByTagName("select"), l2 = n2._time_format_order;
          if (o2.full_day) {
            if (!t2._full_day) {
              var _2 = "<label class='dhx_fullday'><input type='checkbox' name='full_day' value='true'> " + g.locale.labels.full_day + "&nbsp;</label></input>";
              g.config.wide_form || (_2 = t2.previousSibling.innerHTML + _2), t2.previousSibling.innerHTML = _2, t2._full_day = true;
            }
            var h2 = t2.previousSibling.getElementsByTagName("input")[0];
            h2.checked = 0 === g.date.time_part(i2.start_date) && 0 === g.date.time_part(i2.end_date), d2[l2[0]].disabled = h2.checked, d2[l2[0] + d2.length / 2].disabled = h2.checked, h2.onclick = function() {
              if (h2.checked) {
                var e3 = {};
                g.form_blocks.time.get_value(t2, e3, n2), r2 = g.date.date_part(e3.start_date), s2 = g.date.date_part(e3.end_date), (+s2 == +r2 || +s2 >= +r2 && (0 !== i2.end_date.getHours() || 0 !== i2.end_date.getMinutes())) && (s2 = g.date.add(s2, 1, "day"));
              } else r2 = null, s2 = null;
              d2[l2[0]].disabled = h2.checked, d2[l2[0] + d2.length / 2].disabled = h2.checked, a2(d2, 0, r2 || i2.start_date), a2(d2, 4, s2 || i2.end_date);
            };
          }
          if (o2.auto_end_date && o2.event_duration) for (var c2 = function() {
            r2 = new Date(d2[l2[3]].value, d2[l2[2]].value, d2[l2[1]].value, 0, d2[l2[0]].value), s2 = new Date(r2.getTime() + 60 * g.config.event_duration * 1e3), a2(d2, 4, s2);
          }, u2 = 0; u2 < 4; u2++) d2[u2].onchange = c2;
          a2(d2, 0, i2.start_date), a2(d2, 4, i2.end_date);
        }, get_value: function(t2, e2, i2) {
          var n2 = t2.getElementsByTagName("select"), a2 = i2._time_format_order;
          if (e2.start_date = new Date(n2[a2[3]].value, n2[a2[2]].value, n2[a2[1]].value, 0, n2[a2[0]].value), e2.end_date = new Date(n2[a2[3] + 4].value, n2[a2[2] + 4].value, n2[a2[1] + 4].value, 0, n2[a2[0] + 4].value), !n2[a2[3]].value || !n2[a2[3] + 4].value) {
            var r2 = g.getEvent(g._lightbox_id);
            r2 && (e2.start_date = r2.start_date, e2.end_date = r2.end_date);
          }
          return e2.end_date <= e2.start_date && (e2.end_date = g.date.add(e2.start_date, g.config.time_step, "minute")), { start_date: new Date(e2.start_date), end_date: new Date(e2.end_date) };
        }, focus: function(t2) {
          g._focus(t2.getElementsByTagName("select")[0]);
        } } }, g._setLbPosition = function(t2) {
          if (t2) {
            var e2 = window.pageYOffset || document.body.scrollTop || document.documentElement.scrollTop, i2 = window.pageXOffset || document.body.scrollLeft || document.documentElement.scrollLeft, n2 = window.innerHeight || document.documentElement.clientHeight;
            t2.style.top = e2 ? Math.round(e2 + Math.max((n2 - t2.offsetHeight) / 2, 0)) + "px" : Math.round(Math.max((n2 - t2.offsetHeight) / 2, 0) + 9) + "px", document.documentElement.scrollWidth > document.body.offsetWidth ? t2.style.left = Math.round(i2 + (document.body.offsetWidth - t2.offsetWidth) / 2) + "px" : t2.style.left = Math.round((document.body.offsetWidth - t2.offsetWidth) / 2) + "px";
          }
        }, g.showCover = function(t2) {
          t2 && (t2.style.display = "block", this._setLbPosition(t2)), g.config.responsive_lightbox && (document.documentElement.classList.add("dhx_cal_overflow_container"), document.body.classList.add("dhx_cal_overflow_container")), this.show_cover();
        }, g.showLightbox = function(t2) {
          if (t2) {
            if (!this.callEvent("onBeforeLightbox", [t2])) return void (this._new_event && (this._new_event = null));
            var e2 = this.getLightbox();
            this.showCover(e2), this._fill_lightbox(t2, e2), this._waiAria.lightboxVisibleAttr(e2), this.callEvent("onLightbox", [t2]);
          }
        }, g._fill_lightbox = function(t2, e2) {
          var i2 = this.getEvent(t2), n2 = e2.getElementsByTagName("span"), a2 = [];
          if (g.templates.lightbox_header) {
            a2.push("");
            var r2 = g.templates.lightbox_header(i2.start_date, i2.end_date, i2);
            a2.push(r2), n2[1].innerHTML = "", n2[2].innerHTML = r2;
          } else {
            var s2 = this.templates.event_header(i2.start_date, i2.end_date, i2), o2 = (this.templates.event_bar_text(i2.start_date, i2.end_date, i2) || "").substr(0, 70);
            a2.push(s2), a2.push(o2), n2[1].innerHTML = s2, n2[2].innerHTML = o2;
          }
          this._waiAria.lightboxHeader(e2, a2.join(" "));
          for (var d2 = this.config.lightbox.sections, l2 = 0; l2 < d2.length; l2++) {
            var _2 = d2[l2], h2 = g._get_lightbox_section_node(_2), c2 = this.form_blocks[_2.type], u2 = void 0 !== i2[_2.map_to] ? i2[_2.map_to] : _2.default_value;
            c2.set_value.call(this, h2, u2, i2, _2), d2[l2].focus && c2.focus.call(this, h2);
          }
          g._lightbox_id = t2;
        }, g._get_lightbox_section_node = function(t2) {
          return document.getElementById(t2.id).nextSibling;
        }, g._lightbox_out = function(t2) {
          for (var e2 = this.config.lightbox.sections, i2 = 0; i2 < e2.length; i2++) {
            var n2 = document.getElementById(e2[i2].id);
            n2 = n2 ? n2.nextSibling : n2;
            var a2 = this.form_blocks[e2[i2].type], r2 = a2.get_value.call(this, n2, t2, e2[i2]);
            "auto" != e2[i2].map_to && (t2[e2[i2].map_to] = r2);
          }
          return t2;
        }, g._empty_lightbox = function(t2) {
          var e2 = g._lightbox_id, i2 = this.getEvent(e2);
          this.getLightbox();
          this._lame_copy(i2, t2), this.setEvent(i2.id, i2), this._edit_stop_event(i2, true), this.render_view_data();
        }, g.hide_lightbox = function(t2) {
          g.endLightbox(false, this.getLightbox());
        }, g.hideLightbox = g.hide_lightbox, g.hideCover = function(t2) {
          t2 && (t2.style.display = "none"), this.hide_cover(), g.config.responsive_lightbox && (document.documentElement.classList.remove("dhx_cal_overflow_container"), document.body.classList.remove("dhx_cal_overflow_container"));
        }, g.hide_cover = function() {
          this._cover && this._cover.parentNode.removeChild(this._cover), this._cover = null;
        }, g.show_cover = function() {
          this._cover || (this._cover = document.createElement("div"), this._cover.className = "dhx_cal_cover", document.body.appendChild(this._cover));
        }, g.save_lightbox = function() {
          var t2 = this._lightbox_out({}, this._lame_copy(this.getEvent(this._lightbox_id)));
          this.checkEvent("onEventSave") && !this.callEvent("onEventSave", [this._lightbox_id, t2, this._new_event]) || (this._empty_lightbox(t2), this.hide_lightbox());
        }, g.startLightbox = function(t2, e2) {
          this._lightbox_id = t2, this._custom_lightbox = true, this._temp_lightbox = this._lightbox, this._lightbox = e2, this.showCover(e2);
        }, g.endLightbox = function(t2, e2) {
          var e2 = e2 || g.getLightbox(), i2 = g.getEvent(this._lightbox_id);
          i2 && this._edit_stop_event(i2, t2), t2 && g.render_view_data(), this.hideCover(e2), this._custom_lightbox && (this._lightbox = this._temp_lightbox, this._custom_lightbox = false), this._temp_lightbox = this._lightbox_id = null, this._waiAria.lightboxHiddenAttr(e2), this.callEvent("onAfterLightbox", []);
        }, g.resetLightbox = function() {
          g._lightbox && !g._custom_lightbox && g._lightbox.parentNode.removeChild(g._lightbox), g._lightbox = null;
        }, g.cancel_lightbox = function() {
          this.callEvent("onEventCancel", [this._lightbox_id, this._new_event]), this.hide_lightbox();
        }, g._init_lightbox_events = function() {
          this.getLightbox().onclick = function(t2) {
            var e2 = t2 ? t2.target : event.srcElement;
            if (e2.className || (e2 = e2.previousSibling), !(e2 && e2.className && g._getClassName(e2).indexOf("dhx_btn_set") > -1) || (e2 = e2.querySelector("[dhx_button]"))) {
              var i2 = g._getClassName(e2);
              if (e2 && i2) switch (i2) {
                case "dhx_save_btn":
                  g.save_lightbox();
                  break;
                case "dhx_delete_btn":
                  var n2 = g.locale.labels.confirm_deleting;
                  g._dhtmlx_confirm(n2, g.locale.labels.title_confirm_deleting, function() {
                    g.deleteEvent(g._lightbox_id), g._new_event = null, g.hide_lightbox();
                  });
                  break;
                case "dhx_cancel_btn":
                  g.cancel_lightbox();
                  break;
                default:
                  if (e2.getAttribute("dhx_button")) g.callEvent("onLightboxButton", [i2, e2, t2]);
                  else {
                    var a2, r2, s2;
                    -1 != i2.indexOf("dhx_custom_button") && (-1 != i2.indexOf("dhx_custom_button_") ? (a2 = e2.parentNode.getAttribute("index"), s2 = e2.parentNode.parentNode) : (a2 = e2.getAttribute("index"), s2 = e2.parentNode, e2 = e2.firstChild)), a2 && (r2 = g.form_blocks[g.config.lightbox.sections[a2].type], r2.button_click(a2, e2, s2, s2.nextSibling));
                  }
              }
            }
          }, this.getLightbox().onkeydown = function(t2) {
            var e2 = t2 || window.event, i2 = t2.target || t2.srcElement, n2 = i2.querySelector("[dhx_button]");
            switch (n2 || (n2 = i2.parentNode.querySelector(".dhx_custom_button, .dhx_readonly")), (t2 || e2).keyCode) {
              case 32:
                if ((t2 || e2).shiftKey) return;
                n2 && n2.click && n2.click();
                break;
              case g.keys.edit_save:
                if ((t2 || e2).shiftKey) return;
                n2 && n2.click ? n2.click() : g.save_lightbox();
                break;
              case g.keys.edit_cancel:
                g.cancel_lightbox();
            }
          };
        }, g.setLightboxSize = function() {
          var t2 = this._lightbox;
          if (t2) {
            var e2 = t2.childNodes[1];
            e2.style.height = "0px", e2.style.height = e2.scrollHeight + "px", t2.style.height = e2.scrollHeight + g.xy.lightbox_additional_height + "px", e2.style.height = e2.scrollHeight + "px";
          }
        }, g._init_dnd_events = function() {
          g.event(document.body, "mousemove", g._move_while_dnd), g.event(document.body, "mouseup", g._finish_dnd), g._init_dnd_events = function() {
          };
        }, g._move_while_dnd = function(t2) {
          if (g._dnd_start_lb) {
            document.dhx_unselectable || (document.body.className += " dhx_unselectable", document.dhx_unselectable = true);
            var e2 = g.getLightbox(), i2 = t2 && t2.target ? [t2.pageX, t2.pageY] : [event.clientX, event.clientY];
            e2.style.top = g._lb_start[1] + i2[1] - g._dnd_start_lb[1] + "px", e2.style.left = g._lb_start[0] + i2[0] - g._dnd_start_lb[0] + "px";
          }
        }, g._ready_to_dnd = function(t2) {
          var e2 = g.getLightbox();
          g._lb_start = [parseInt(e2.style.left, 10), parseInt(e2.style.top, 10)], g._dnd_start_lb = t2 && t2.target ? [t2.pageX, t2.pageY] : [event.clientX, event.clientY];
        }, g._finish_dnd = function() {
          g._lb_start && (g._lb_start = g._dnd_start_lb = false, document.body.className = document.body.className.replace(" dhx_unselectable", ""), document.dhx_unselectable = false);
        }, g.getLightbox = function() {
          if (!this._lightbox) {
            var t2 = document.createElement("div");
            t2.className = "dhx_cal_light", g.config.wide_form && (t2.className += " dhx_cal_light_wide"), g.form_blocks.recurring && (t2.className += " dhx_cal_light_rec"), g.config.rtl && (t2.className += " dhx_cal_light_rtl"), g.config.responsive_lightbox && (t2.className += " dhx_cal_light_responsive"), /msie|MSIE 6/.test(navigator.userAgent) && (t2.className += " dhx_ie6"), t2.style.visibility = "hidden";
            for (var e2 = this._lightbox_template, i2 = this.config.buttons_left, n2 = "", a2 = 0; a2 < i2.length; a2++) n2 = this._waiAria.lightboxButtonAttrString(i2[a2]), e2 += "<div " + n2 + " class='dhx_btn_set dhx_" + (g.config.rtl ? "right" : "left") + "_btn_set " + i2[a2] + "_set'><div dhx_button='1' class='" + i2[a2] + "'></div><div>" + g.locale.labels[i2[a2]] + "</div></div>";
            i2 = this.config.buttons_right;
            for (var r2 = g.config.rtl, a2 = 0; a2 < i2.length; a2++) n2 = this._waiAria.lightboxButtonAttrString(i2[a2]), e2 += "<div " + n2 + " class='dhx_btn_set dhx_" + (r2 ? "left" : "right") + "_btn_set " + i2[a2] + "_set' style='float:" + (r2 ? "left" : "right") + ";'><div dhx_button='1' class='" + i2[a2] + "'></div><div>" + g.locale.labels[i2[a2]] + "</div></div>";
            e2 += "</div>", t2.innerHTML = e2, g.config.drag_lightbox && (t2.firstChild.onmousedown = g._ready_to_dnd, t2.firstChild.onselectstart = function() {
              return false;
            }, t2.firstChild.style.cursor = "move", g._init_dnd_events()), this._waiAria.lightboxAttr(t2), document.body.insertBefore(t2, document.body.firstChild), this._lightbox = t2;
            var s2 = this.config.lightbox.sections;
            e2 = "";
            for (var a2 = 0; a2 < s2.length; a2++) {
              var o2 = this.form_blocks[s2[a2].type];
              if (o2) {
                s2[a2].id = "area_" + this.uid();
                var d2 = "";
                if (s2[a2].button) {
                  var n2 = g._waiAria.lightboxSectionButtonAttrString(this.locale.labels["button_" + s2[a2].button]);
                  d2 = "<div " + n2 + " class='dhx_custom_button' index='" + a2 + "'><div class='dhx_custom_button_" + s2[a2].button + "'></div><div>" + this.locale.labels["button_" + s2[a2].button] + "</div></div>";
                }
                this.config.wide_form && (e2 += "<div class='dhx_wrap_section'>");
                var l2 = this.locale.labels["section_" + s2[a2].name];
                "string" != typeof l2 && (l2 = s2[a2].name), e2 += "<div id='" + s2[a2].id + "' class='dhx_cal_lsection'>" + d2 + "<label>" + l2 + "</label></div>" + o2.render.call(this, s2[a2]), e2 += "</div>";
              }
            }
            for (var _2 = t2.getElementsByTagName("div"), a2 = 0; a2 < _2.length; a2++) {
              var h2 = _2[a2];
              if ("dhx_cal_larea" == g._getClassName(h2)) {
                h2.innerHTML = e2;
                break;
              }
            }
            g._bindLightboxLabels(s2), this.setLightboxSize(), this._init_lightbox_events(this), t2.style.display = "none", t2.style.visibility = "visible";
          }
          return this._lightbox;
        }, g._bindLightboxLabels = function(t2) {
          for (var e2 = 0; e2 < t2.length; e2++) {
            var i2 = t2[e2];
            if (i2.id && document.getElementById(i2.id)) {
              for (var n2 = document.getElementById(i2.id), a2 = n2.querySelector("label"), r2 = g._get_lightbox_section_node(i2); r2 && !r2.querySelector; ) r2 = r2.nextSibling;
              var s2 = true;
              if (r2) {
                var o2 = r2.querySelector("input, select, textarea");
                o2 && (i2.inputId = o2.id || "input_" + g.uid(), o2.id || (o2.id = i2.inputId), a2.setAttribute("for", i2.inputId), s2 = false);
              }
              if (s2) {
                g.form_blocks[i2.type].focus && (a2.onclick = /* @__PURE__ */ function(t3) {
                  return function() {
                    var e3 = g.form_blocks[t3.type], i3 = g._get_lightbox_section_node(t3);
                    e3 && e3.focus && e3.focus.call(g, i3);
                  };
                }(i2));
              }
            }
          }
        }, g.attachEvent("onEventIdChange", function(t2, e2) {
          this._lightbox_id == t2 && (this._lightbox_id = e2);
        }), g._lightbox_template = "<div class='dhx_cal_ltitle'><span class='dhx_mark'>&nbsp;</span><span class='dhx_time'></span><span class='dhx_title'></span></div><div class='dhx_cal_larea'></div>", g._init_touch_events = function() {
          if ((this.config.touch && (-1 != navigator.userAgent.indexOf("Mobile") || -1 != navigator.userAgent.indexOf("iPad") || -1 != navigator.userAgent.indexOf("Android") || -1 != navigator.userAgent.indexOf("Touch")) && !window.MSStream || "MacIntel" === navigator.platform && navigator.maxTouchPoints > 1) && (this.xy.scroll_width = 0, this._mobile = true), this.config.touch) {
            var t2 = true;
            try {
              document.createEvent("TouchEvent");
            } catch (e2) {
              t2 = false;
            }
            t2 ? this._touch_events(["touchmove", "touchstart", "touchend"], function(t3) {
              return t3.touches && t3.touches.length > 1 ? null : t3.touches[0] ? { target: t3.target, pageX: t3.touches[0].pageX, pageY: t3.touches[0].pageY, clientX: t3.touches[0].clientX, clientY: t3.touches[0].clientY } : t3;
            }, function() {
              return false;
            }) : window.PointerEvent || window.navigator.pointerEnabled ? this._touch_events(["pointermove", "pointerdown", "pointerup"], function(t3) {
              return "mouse" == t3.pointerType ? null : t3;
            }, function(t3) {
              return !t3 || "mouse" == t3.pointerType;
            }) : window.navigator.msPointerEnabled && this._touch_events(["MSPointerMove", "MSPointerDown", "MSPointerUp"], function(t3) {
              return t3.pointerType == t3.MSPOINTER_TYPE_MOUSE ? null : t3;
            }, function(t3) {
              return !t3 || t3.pointerType == t3.MSPOINTER_TYPE_MOUSE;
            });
          }
        }, g._touch_events = function(t2, e2, i2) {
          function n2(t3, e3, n3) {
            t3.addEventListener(e3, function(t4) {
              if (g._is_lightbox_open()) return true;
              if (!i2(t4)) return n3(t4);
            }, { passive: false });
          }
          function a2(t3, e3, i3, n3) {
            if (!t3 || !e3) return false;
            for (var a3 = t3.target; a3 && a3 != g._obj; ) a3 = a3.parentNode;
            if (a3 != g._obj) return false;
            if (g.matrix && g.matrix[g.getState().mode]) {
              if (g.matrix[g.getState().mode].scrollable) return false;
            }
            var r3 = Math.abs(t3.pageY - e3.pageY), s3 = Math.abs(t3.pageX - e3.pageX);
            return r3 < n3 && s3 > i3 && (!r3 || s3 / r3 > 3) && (t3.pageX > e3.pageX ? g._click.dhx_cal_next_button() : g._click.dhx_cal_prev_button(), true);
          }
          function r2(t3) {
            if (!i2(t3)) {
              var e3 = g.getState().drag_mode, n3 = !!g.matrix && g.matrix[g._mode], a3 = g.render_view_data;
              return "create" == e3 && n3 && (g.render_view_data = function() {
                for (var t4 = g.getState().drag_id, e4 = g.getEvent(t4), i3 = n3.y_property, a4 = g.getEvents(e4.start_date, e4.end_date), r3 = 0; r3 < a4.length; r3++) a4[r3][i3] != e4[i3] && (a4.splice(r3, 1), r3--);
                e4._sorder = a4.length - 1, e4._count = a4.length, this.render_data([e4], g.getState().mode);
              }), g._on_mouse_move(t3), "create" == e3 && n3 && (g.render_view_data = a3), t3.preventDefault && t3.preventDefault(), t3.cancelBubble = true, false;
            }
          }
          function s2(t3) {
            i2(t3) || (g._hide_global_tip(), _2 && (g._on_mouse_up(e2(t3 || event)), g._temp_touch_block = false), g._drag_id = null, g._drag_mode = null, g._drag_pos = null, g._pointerDragId = null, clearTimeout(l2), _2 = c2 = false, h2 = true);
          }
          var o2, d2, l2, _2, h2, c2, u2 = (-1 != navigator.userAgent.indexOf("Android") && navigator.userAgent.indexOf("WebKit"), 0);
          n2(document.body, t2[0], function(t3) {
            if (!i2(t3)) {
              var n3 = e2(t3);
              if (n3) {
                if (_2) return r2(n3), t3.preventDefault && t3.preventDefault(), t3.cancelBubble = true, g._update_global_tip(), false;
                if (d2 = e2(t3), c2) return d2 ? void ((o2.target != d2.target || Math.abs(o2.pageX - d2.pageX) > 5 || Math.abs(o2.pageY - d2.pageY) > 5) && (h2 = true, clearTimeout(l2))) : void (h2 = true);
              }
            }
          }), n2(this._els.dhx_cal_data[0], "touchcancel", s2), n2(this._els.dhx_cal_data[0], "contextmenu", function(t3) {
            if (!i2(t3)) return c2 ? (t3 && t3.preventDefault && t3.preventDefault(), (t3 || event).cancelBubble = true, false) : void 0;
          }), n2(this._obj, t2[1], function(t3) {
            if (document && document.body && document.body.classList.add("dhx_cal_touch_active"), !i2(t3)) {
              g._pointerDragId = t3.pointerId;
              var n3;
              if (_2 = h2 = false, c2 = true, !(n3 = d2 = e2(t3))) return void (h2 = true);
              var a3 = /* @__PURE__ */ new Date();
              if (!h2 && !_2 && a3 - u2 < 250) return g._click.dhx_cal_data(n3), window.setTimeout(function() {
                n3.type = "dblclick", g._on_dbl_click(n3);
              }, 50), t3.preventDefault && t3.preventDefault(), t3.cancelBubble = true, g._block_next_stop = true, false;
              if (u2 = a3, !h2 && !_2 && g.config.touch_drag) {
                var r3 = g._locate_event(document.activeElement), s3 = g._locate_event(n3.target), f2 = o2 ? g._locate_event(o2.target) : null;
                if (r3 && s3 && r3 == s3 && r3 != f2) return t3.preventDefault && t3.preventDefault(), t3.cancelBubble = true, g._ignore_next_click = false, g._click.dhx_cal_data(n3), o2 = n3, false;
                l2 = setTimeout(function() {
                  _2 = true;
                  var t4 = o2.target, e3 = g._getClassName(t4);
                  t4 && -1 != e3.indexOf("dhx_body") && (t4 = t4.previousSibling), g._on_mouse_down(o2, t4), g._drag_mode && "create" != g._drag_mode && g.for_rendered(g._drag_id, function(t5, e4) {
                    t5.style.display = "none", g._rendered.splice(e4, 1);
                  }), g.config.touch_tip && g._show_global_tip(), g.updateEvent(g._drag_id);
                }, g.config.touch_drag), o2 = n3;
              }
            }
          }), n2(this._els.dhx_cal_data[0], t2[2], function(t3) {
            if (document && document.body && document.body.classList.remove("dhx_cal_touch_active"), !i2(t3)) return g.config.touch_swipe_dates && !_2 && a2(o2, d2, 200, 100) && (g._block_next_stop = true), _2 && (g._ignore_next_click = true, setTimeout(function() {
              g._ignore_next_click = false;
            }, 100)), s2(t3), g._block_next_stop ? (g._block_next_stop = false, t3.preventDefault && t3.preventDefault(), t3.cancelBubble = true, false) : void 0;
          }), g.event(document.body, t2[2], s2);
        }, g._show_global_tip = function() {
          g._hide_global_tip();
          var t2 = g._global_tip = document.createElement("div");
          t2.className = "dhx_global_tip", g._update_global_tip(1), document.body.appendChild(t2);
        }, g._update_global_tip = function(t2) {
          var e2 = g._global_tip;
          if (e2) {
            var i2 = "";
            if (g._drag_id && !t2) {
              var n2 = g.getEvent(g._drag_id);
              n2 && (i2 = "<div>" + (n2._timed ? g.templates.event_header(n2.start_date, n2.end_date, n2) : g.templates.day_date(n2.start_date, n2.end_date, n2)) + "</div>");
            }
            "create" == g._drag_mode || "new-size" == g._drag_mode ? e2.innerHTML = (g.locale.labels.drag_to_create || "Drag to create") + i2 : e2.innerHTML = (g.locale.labels.drag_to_move || "Drag to move") + i2;
          }
        }, g._hide_global_tip = function() {
          var t2 = g._global_tip;
          t2 && t2.parentNode && (t2.parentNode.removeChild(t2), g._global_tip = 0);
        }, g._dp_init = function(t2) {
          t2._methods = ["_set_event_text_style", "", "_dp_change_event_id", "_dp_hook_delete"], this._dp_change_event_id = function(t3, e3) {
            g.getEvent(t3) && g.changeEventId(t3, e3);
          }, this._dp_hook_delete = function(e3, i3) {
            if (g.getEvent(e3)) return i3 && e3 != i3 && ("true_deleted" == this.getUserData(e3, t2.action_param) && this.setUserData(e3, t2.action_param, "updated"), this.changeEventId(e3, i3)), this.deleteEvent(i3, true);
          }, this.attachEvent("onEventAdded", function(e3) {
            !this._loading && this._validId(e3) && t2.setUpdated(e3, true, "inserted");
          }), this.attachEvent("onConfirmedBeforeEventDelete", function(e3) {
            if (this._validId(e3)) {
              var i3 = t2.getState(e3);
              return "inserted" == i3 || this._new_event ? (t2.setUpdated(e3, false), true) : "deleted" != i3 && ("true_deleted" == i3 || (t2.setUpdated(e3, true, "deleted"), false));
            }
          }), this.attachEvent("onEventChanged", function(e3) {
            !this._loading && this._validId(e3) && t2.setUpdated(e3, true, "updated");
          }), g.attachEvent("onClearAll", function() {
            t2._in_progress = {}, t2._invalid = {}, t2.updatedRows = [], t2._waitMode = 0;
          });
          var e2 = function(t3, i3, n2) {
            n2 = n2 || "", i3 = i3 || {};
            for (var a2 in t3) 0 !== a2.indexOf("_") && (t3[a2] && t3[a2].getUTCFullYear ? i3[n2 + a2] = this.obj._helpers.formatDate(t3[a2]) : t3[a2] && "object" == typeof t3[a2] ? e2.call(this, t3[a2], i3, n2 + a2 + ".") : i3[n2 + a2] = t3[a2]);
            return i3;
          }, i2 = function(t3) {
            var e3 = g.utils.copy(t3);
            for (var n2 in e3) 0 === n2.indexOf("_") ? delete e3[n2] : e3[n2] && (e3[n2].getUTCFullYear ? e3[n2] = this.obj._helpers.formatDate(e3[n2]) : "object" == typeof e3[n2] && (e3[n2] = i2(e3[n2])));
            return e3;
          };
          t2._getRowData = function(t3, n2) {
            var a2 = this.obj.getEvent(t3);
            return "JSON" == this._tMode ? i2.call(this, a2) : e2.call(this, a2);
          }, t2._clearUpdateFlag = function() {
          }, t2.attachEvent("insertCallback", g._update_callback), t2.attachEvent("updateCallback", g._update_callback), t2.attachEvent("deleteCallback", function(t3, e3) {
            this.obj.getEvent(e3) ? (this.obj.setUserData(e3, this.action_param, "true_deleted"), this.obj.deleteEvent(e3)) : this.obj._add_rec_marker && this.obj._update_callback(t3, e3);
          });
        }, g._validId = function(t2) {
          return true;
        }, g.setUserData = function(t2, e2, i2) {
          if (t2) {
            var n2 = this.getEvent(t2);
            n2 && (n2[e2] = i2);
          } else this._userdata[e2] = i2;
        }, g.getUserData = function(t2, e2) {
          if (t2) {
            var i2 = this.getEvent(t2);
            return i2 ? i2[e2] : null;
          }
          return this._userdata[e2];
        }, g._set_event_text_style = function(t2, e2) {
          if (g.getEvent(t2)) {
            this.for_rendered(t2, function(t3) {
              t3.style.cssText += ";" + e2;
            });
            var i2 = this.getEvent(t2);
            i2._text_style = e2, this.event_updated(i2);
          }
        }, g._update_callback = function(t2, e2) {
          var i2 = g._xmlNodeToJSON(t2.firstChild);
          "none" == i2.rec_type && (i2.rec_pattern = "none"), i2.text = i2.text || i2._tagvalue, i2.start_date = g._helpers.parseDate(i2.start_date), i2.end_date = g._helpers.parseDate(i2.end_date), g.addEvent(i2), g._add_rec_marker && g.setCurrentView();
        }, g.getRootView = function() {
          return { view: { render: function() {
            return { tag: "div", type: 1, attrs: { style: "width:100%;height:100%;" }, hooks: { didInsert: function() {
              g.setCurrentView();
            } }, body: [{ el: this.el, type: 1 }] };
          }, init: function() {
            var t2 = document.createElement("DIV");
            t2.id = "scheduler_" + g.uid(), t2.style.width = "100%", t2.style.height = "100%", t2.classList.add("dhx_cal_container"), t2.cmp = "grid", t2.innerHTML = '<div class="dhx_cal_navline"><div class="dhx_cal_prev_button">&nbsp;</div><div class="dhx_cal_next_button">&nbsp;</div><div class="dhx_cal_today_button"></div><div class="dhx_cal_date"></div><div class="dhx_cal_tab" name="day_tab"></div><div class="dhx_cal_tab" name="week_tab"></div><div class="dhx_cal_tab" name="month_tab"></div></div><div class="dhx_cal_header"></div><div class="dhx_cal_data"></div>', g.init(t2), this.el = t2;
          } }, type: 4 };
        }, g._skin_settings = { fix_tab_position: [1, 0], use_select_menu_space: [1, 0], wide_form: [1, 0], hour_size_px: [44, 42], displayed_event_color: ["#ff4a4a", "ffc5ab"], displayed_event_text_color: ["#ffef80", "7e2727"] }, g._skin_xy = { lightbox_additional_height: [90, 50], nav_height: [59, 22], bar_height: [24, 20] }, g._is_material_skin = function() {
          return g.skin ? (g.skin + "").indexOf("material") > -1 : c();
        };
        var A, k;
        window.addEventListener("DOMContentLoaded", f), window.addEventListener("load", f), g._border_box_events = function() {
          return u();
        }, g._configure = function(t2, e2, i2) {
          for (var n2 in e2) void 0 === t2[n2] && (t2[n2] = e2[n2][i2]);
        }, g._skin_init = function() {
          if (!g.skin) for (var t2 = document.getElementsByTagName("link"), e2 = 0; e2 < t2.length; e2++) {
            var i2 = t2[e2].href.match("dhtmlxscheduler_([a-z]+).css");
            if (i2) {
              g.skin = i2[1];
              break;
            }
          }
          var n2 = 0;
          if (!g.skin || "classic" !== g.skin && "glossy" !== g.skin || (n2 = 1), g._is_material_skin()) {
            var a2 = g.config.buttons_left.$inital, r2 = g.config.buttons_right.$inital;
            if (a2 && g.config.buttons_left.slice().join() == a2 && r2 && g.config.buttons_right.slice().join() == r2) {
              var s2 = g.config.buttons_left.slice();
              g.config.buttons_left = g.config.buttons_right.slice(), g.config.buttons_right = s2;
            }
            g.xy.event_header_height = 18, g.xy.week_agenda_scale_height = 35, g.xy.map_icon_width = 38, g._lightbox_controls.defaults.textarea.height = 64, g._lightbox_controls.defaults.time.height = "auto";
          }
          if (this._configure(g.config, g._skin_settings, n2), this._configure(g.xy, g._skin_xy, n2), "flat" === g.skin && (g.xy.scale_height = 35, g.templates.hour_scale = function(t3) {
            var e3 = t3.getMinutes();
            return e3 = e3 < 10 ? "0" + e3 : e3, "<span class='dhx_scale_h'>" + t3.getHours() + "</span><span class='dhx_scale_m'>&nbsp;" + e3 + "</span>";
          }), !n2) {
            var o2 = g.config.minicalendar;
            o2 && (o2.padding = 14), g.templates.event_bar_date = function(t3, e3, i3) {
              return "\u2022 <b>" + g.templates.event_date(t3) + "</b> ";
            }, g.attachEvent("onTemplatesReady", function() {
              var t3 = g.date.date_to_str("%d");
              g.templates._old_month_day || (g.templates._old_month_day = g.templates.month_day);
              var e3 = g.templates._old_month_day;
              if (g.templates.month_day = function(i4) {
                if ("month" == this._mode) {
                  var n4 = t3(i4);
                  return 1 == i4.getDate() && (n4 = g.locale.date.month_full[i4.getMonth()] + " " + n4), +i4 == +g.date.date_part(this._currentDate()) && (n4 = g.locale.labels.dhx_cal_today_button + " " + n4), n4;
                }
                return e3.call(this, i4);
              }, g.config.fix_tab_position) {
                var i3 = g._els.dhx_cal_navline[0].getElementsByTagName("div"), n3 = null, a3 = 211, r3 = [14, 75, 136], s3 = 14;
                g._is_material_skin() && (r3 = [16, 103, 192], a3 = 294, s3 = -1);
                for (var o3 = 0; o3 < i3.length; o3++) {
                  var d2 = i3[o3], l2 = d2.getAttribute("name");
                  if (l2) {
                    switch (d2.style.right = "auto", l2) {
                      case "day_tab":
                        d2.style.left = r3[0] + "px", d2.className += " dhx_cal_tab_first";
                        break;
                      case "week_tab":
                        d2.style.left = r3[1] + "px";
                        break;
                      case "month_tab":
                        d2.style.left = r3[2] + "px", d2.className += " dhx_cal_tab_last";
                        break;
                      default:
                        d2.style.left = a3 + "px", d2.className += " dhx_cal_tab_standalone", a3 = a3 + s3 + d2.offsetWidth;
                    }
                    d2.className += " " + l2;
                  } else 0 === (d2.className || "").indexOf("dhx_minical_icon") && d2.parentNode == g._els.dhx_cal_navline[0] && (n3 = d2);
                }
                n3 && (n3.style.left = a3 + "px");
              }
            }), g._skin_init = function() {
            };
          }
        }, window.jQuery && function(t2) {
          var e2 = 0, i2 = [];
          t2.fn.dhx_scheduler = function(n2) {
            if ("string" != typeof n2) {
              var a2 = [];
              return this.each(function() {
                if (this && this.getAttribute) if (this.getAttribute("dhxscheduler")) a2.push(window[this.getAttribute("dhxscheduler")]);
                else {
                  var t3 = "scheduler";
                  e2 && (t3 = "scheduler" + (e2 + 1), window[t3] = Scheduler.getSchedulerInstance());
                  var i3 = window[t3];
                  this.setAttribute("dhxscheduler", t3);
                  for (var r2 in n2) "data" != r2 && (i3.config[r2] = n2[r2]);
                  this.getElementsByTagName("div").length || (this.innerHTML = '<div class="dhx_cal_navline"><div class="dhx_cal_prev_button">&nbsp;</div><div class="dhx_cal_next_button">&nbsp;</div><div class="dhx_cal_today_button"></div><div class="dhx_cal_date"></div><div class="dhx_cal_tab" name="day_tab" style="right:204px;"></div><div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div><div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div></div><div class="dhx_cal_header"></div><div class="dhx_cal_data"></div>', this.className += " dhx_cal_container"), i3.init(this, i3.config.date, i3.config.mode), n2.data && i3.parse(n2.data), a2.push(i3), e2++;
                }
              }), 1 === a2.length ? a2[0] : a2;
            }
            if (i2[n2]) return i2[n2].apply(this, []);
            t2.error("Method " + n2 + " does not exist on jQuery.dhx_scheduler");
          };
        }(jQuery), function() {
          function t2(t3, e3, i3) {
            e3 && (t3._date = e3), i3 && (t3._mode = i3);
          }
          var e2 = g.setCurrentView, i2 = g.updateView, n2 = null, a2 = null, r2 = function(e3, r3) {
            var s3 = this;
            window.clearTimeout(a2), window.clearTimeout(n2);
            var o2 = s3._date, d2 = s3._mode;
            t2(this, e3, r3), a2 = setTimeout(function() {
              if (!s3.callEvent("onBeforeViewChange", [d2, o2, r3 || s3._mode, e3 || s3._date])) return void t2(s3, o2, d2);
              i2.call(s3, e3, r3), s3.callEvent("onViewChange", [s3._mode, s3._date]), window.clearTimeout(n2), a2 = 0;
            }, g.config.delay_render);
          }, s2 = function(e3, r3) {
            var s3 = this, o2 = arguments;
            t2(this, e3, r3), window.clearTimeout(n2), n2 = setTimeout(function() {
              a2 || i2.apply(s3, o2);
            }, g.config.delay_render);
          };
          g.attachEvent("onSchedulerReady", function() {
            g.config.delay_render ? (g.setCurrentView = r2, g.updateView = s2) : (g.setCurrentView = e2, g.updateView = i2);
          });
        }();
        for (var S = 0; S < Scheduler._schedulerPlugins.length; S++) Scheduler._schedulerPlugins[S](g);
        return g._internal_id = Scheduler._seed++, Scheduler.$syncFactory && Scheduler.$syncFactory(g), g;
      }, window.scheduler = Scheduler.getSchedulerInstance(), window.Scheduler = { plugin: scheduler.bind(Scheduler.plugin, Scheduler) }, dhtmlx && dhtmlx.attaches && (dhtmlx.attaches.attachScheduler = function(t, e, i, n) {
        var i = i || '<div class="dhx_cal_tab" name="day_tab" style="right:204px;"></div><div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div><div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div>', a = document.createElement("DIV");
        return a.id = "dhxSchedObj_" + this._genStr(12), a.innerHTML = '<div id="' + a.id + '" class="dhx_cal_container" style="width:100%; height:100%;"><div class="dhx_cal_navline"><div class="dhx_cal_prev_button">&nbsp;</div><div class="dhx_cal_next_button">&nbsp;</div><div class="dhx_cal_today_button"></div><div class="dhx_cal_date"></div>' + i + '</div><div class="dhx_cal_header"></div><div class="dhx_cal_data"></div></div>', document.body.appendChild(a.firstChild), this.attachObject(a.id, false, true), this.vs[this.av].sched = n, this.vs[this.av].schedId = a.id, n.setSizes = n.updateView, n.destructor = function() {
        }, n.init(a.id, t, e), this.vs[this._viewRestore()].sched;
      });
    }();
  }
});
export default require_dhtmlxscheduler();
/*

@license
dhtmlxScheduler v.5.3.10 Standard

To use dhtmlxScheduler in non-GPL projects (and get Pro version of the product), please obtain Commercial/Enterprise or Ultimate license on our site https://dhtmlx.com/docs/products/dhtmlxScheduler/#licensing or contact us at sales@dhtmlx.com

(c) XB Software Ltd.

*/;
