/*
 Highcharts JS v5.0.7 (2017-01-17)
 Exporting module

 (c) 2010-2016 Torstein Honsi

 License: www.highcharts.com/license
*/
(function (k) { "object" === typeof module && module.exports ? module.exports = k : k(Highcharts) })(function (k) {
    (function (f) {
        var k = f.defaultOptions, u = f.doc, A = f.Chart, x = f.addEvent, G = f.removeEvent, E = f.fireEvent, w = f.createElement, B = f.discardElement, F = f.css, v = f.merge, C = f.pick, t = f.each, y = f.extend, z = f.win, D = f.SVGRenderer, H = f.Renderer.prototype.symbols; y(k.lang, {
            printChart: "Print chart", downloadPNG: "Download PNG image", downloadJPEG: "Download JPEG image", downloadPDF: "Download PDF document", downloadSVG: "Download SVG vector image",
            contextButtonTitle: "Chart context menu"
        }); k.navigation = { buttonOptions: { theme: {}, symbolSize: 14, symbolX: 12.5, symbolY: 10.5, align: "right", buttonSpacing: 3, height: 22, verticalAlign: "top", width: 24 } }; k.exporting = {
            type: "image/png", url: "https://export.highcharts.com/", printMaxWidth: 780, scale: 2, buttons: {
                contextButton: {
                    className: "highcharts-contextbutton", menuClassName: "highcharts-contextmenu", symbol: "menu", _titleKey: "contextButtonTitle", menuItems: [{ textKey: "printChart", onclick: function () { this.print() } }, { separator: !0 },
                    { textKey: "downloadPNG", onclick: function () { this.exportChart() } }, { textKey: "downloadJPEG", onclick: function () { this.exportChart({ type: "image/jpeg" }) } }, { textKey: "downloadPDF", onclick: function () { this.exportChart({ type: "application/pdf" }) } }, { textKey: "downloadSVG", onclick: function () { this.exportChart({ type: "image/svg+xml" }) } }]
                }
            }
        }; f.post = function (a, b, c) {
            var d; a = w("form", v({ method: "post", action: a, enctype: "multipart/form-data" }, c), { display: "none" }, u.body); for (d in b) w("input", { type: "hidden", name: d, value: b[d] },
            null, a); a.submit(); B(a)
        }; y(A.prototype, {
            sanitizeSVG: function (a, b) {
                if (b && b.exporting && b.exporting.allowHTML) { var c = a.match(/<\/svg>(.*?$)/); c && (c = '\x3cforeignObject x\x3d"0" y\x3d"0" width\x3d"' + b.chart.width + '" height\x3d"' + b.chart.height + '"\x3e\x3cbody xmlns\x3d"http://www.w3.org/1999/xhtml"\x3e' + c[1] + "\x3c/body\x3e\x3c/foreignObject\x3e", a = a.replace("\x3c/svg\x3e", c + "\x3c/svg\x3e")) } return a = a.replace(/zIndex="[^"]+"/g, "").replace(/isShadow="[^"]+"/g, "").replace(/symbolName="[^"]+"/g, "").replace(/jQuery[0-9]+="[^"]+"/g,
                "").replace(/url\(("|&quot;)(\S+)("|&quot;)\)/g, "url($2)").replace(/url\([^#]+#/g, "url(#").replace(/<svg /, '\x3csvg xmlns:xlink\x3d"http://www.w3.org/1999/xlink" ').replace(/ (NS[0-9]+\:)?href=/g, " xlink:href\x3d").replace(/\n/, " ").replace(/<\/svg>.*?$/, "\x3c/svg\x3e").replace(/(fill|stroke)="rgba\(([ 0-9]+,[ 0-9]+,[ 0-9]+),([ 0-9\.]+)\)"/g, '$1\x3d"rgb($2)" $1-opacity\x3d"$3"').replace(/&nbsp;/g, "\u00a0").replace(/&shy;/g, "\u00ad")
            }, getChartHTML: function () { this.inlineStyles(); return this.container.innerHTML },
            getSVG: function (a) {
                var b, c, d, q, m, g = v(this.options, a); u.createElementNS || (u.createElementNS = function (a, b) { return u.createElement(b) }); c = w("div", null, { position: "absolute", top: "-9999em", width: this.chartWidth + "px", height: this.chartHeight + "px" }, u.body); d = this.renderTo.style.width; m = this.renderTo.style.height; d = g.exporting.sourceWidth || g.chart.width || /px$/.test(d) && parseInt(d, 10) || 600; m = g.exporting.sourceHeight || g.chart.height || /px$/.test(m) && parseInt(m, 10) || 400; y(g.chart, {
                    animation: !1, renderTo: c, forExport: !0,
                    renderer: "SVGRenderer", width: d, height: m
                }); g.exporting.enabled = !1; delete g.data; g.series = []; t(this.series, function (a) { q = v(a.userOptions, { animation: !1, enableMouseTracking: !1, showCheckbox: !1, visible: a.visible }); q.isInternal || g.series.push(q) }); t(this.axes, function (a) { a.userOptions.internalKey = f.uniqueKey() }); b = new f.Chart(g, this.callback); a && t(["xAxis", "yAxis", "series"], function (d) { var e = {}; a[d] && (e[d] = a[d], b.update(e)) }); t(this.axes, function (a) {
                    var d = f.find(b.axes, function (b) {
                        return b.options.internalKey ===
                        a.userOptions.internalKey
                    }), e = a.getExtremes(), c = e.userMin, e = e.userMax; !d || void 0 === c && void 0 === e || d.setExtremes(c, e, !0, !1)
                }); d = b.getChartHTML(); d = this.sanitizeSVG(d, g); g = null; b.destroy(); B(c); return d
            }, getSVGForExport: function (a, b) { var c = this.options.exporting; return this.getSVG(v({ chart: { borderRadius: 0 } }, c.chartOptions, b, { exporting: { sourceWidth: a && a.sourceWidth || c.sourceWidth, sourceHeight: a && a.sourceHeight || c.sourceHeight } })) }, exportChart: function (a, b) {
                b = this.getSVGForExport(a, b); a = v(this.options.exporting,
                a); f.post(a.url, { filename: a.filename || "chart", type: a.type, width: a.width || 0, scale: a.scale, svg: b }, a.formAttributes)
            }, print: function () {
                var a = this, b = a.container, c = [], d = b.parentNode, f = u.body, m = f.childNodes, g = a.options.exporting.printMaxWidth, e, p; if (!a.isPrinting) {
                    a.isPrinting = !0; a.pointer.reset(null, 0); E(a, "beforePrint"); if (p = g && a.chartWidth > g) e = [a.options.chart.width, void 0, !1], a.setSize(g, void 0, !1); t(m, function (a, b) { 1 === a.nodeType && (c[b] = a.style.display, a.style.display = "none") }); f.appendChild(b); z.focus();
                    z.print(); setTimeout(function () { d.appendChild(b); t(m, function (a, b) { 1 === a.nodeType && (a.style.display = c[b]) }); a.isPrinting = !1; p && a.setSize.apply(a, e); E(a, "afterPrint") }, 1E3)
                }
            }, contextMenu: function (a, b, c, d, f, m, g) {
                var e = this, p = e.chartWidth, h = e.chartHeight, l = "cache-" + a, n = e[l], q = Math.max(f, m), r, k; n || (e[l] = n = w("div", { className: a }, { position: "absolute", zIndex: 1E3, padding: q + "px" }, e.container), r = w("div", { className: "highcharts-menu" }, null, n), k = function () { F(n, { display: "none" }); g && g.setState(0); e.openMenu = !1 },
                x(n, "mouseleave", function () { n.hideTimer = setTimeout(k, 500) }), x(n, "mouseenter", function () { clearTimeout(n.hideTimer) }), l = x(u, "mouseup", function (b) { e.pointer.inClass(b.target, a) || k() }), x(e, "destroy", l), t(b, function (a) { if (a) { var b; b = a.separator ? w("hr", null, null, r) : w("div", { className: "highcharts-menu-item", onclick: function (b) { b && b.stopPropagation(); k(); a.onclick && a.onclick.apply(e, arguments) }, innerHTML: a.text || e.options.lang[a.textKey] }, null, r); e.exportDivElements.push(b) } }), e.exportDivElements.push(r,
                n), e.exportMenuWidth = n.offsetWidth, e.exportMenuHeight = n.offsetHeight); b = { display: "block" }; c + e.exportMenuWidth > p ? b.right = p - c - f - q + "px" : b.left = c - q + "px"; d + m + e.exportMenuHeight > h && "top" !== g.alignOptions.verticalAlign ? b.bottom = h - d - q + "px" : b.top = d + m - q + "px"; F(n, b); e.openMenu = !0
            }, addButton: function (a) {
                var b = this, c = b.renderer, d = v(b.options.navigation.buttonOptions, a), f = d.onclick, m = d.menuItems, g, e, p = d.symbolSize || 12; b.btnCount || (b.btnCount = 0); b.exportDivElements || (b.exportDivElements = [], b.exportSVGElements = []);
                if (!1 !== d.enabled) {
                    var h = d.theme, l = h.states, n = l && l.hover, l = l && l.select, k; delete h.states; f ? k = function (a) { a.stopPropagation(); f.call(b, a) } : m && (k = function () { b.contextMenu(e.menuClassName, m, e.translateX, e.translateY, e.width, e.height, e); e.setState(2) }); d.text && d.symbol ? h.paddingLeft = C(h.paddingLeft, 25) : d.text || y(h, { width: d.width, height: d.height, padding: 0 }); e = c.button(d.text, 0, 0, k, h, n, l).addClass(a.className).attr({ title: b.options.lang[d._titleKey], zIndex: 3 }); e.menuClassName = a.menuClassName || "highcharts-menu-" +
                    b.btnCount++; d.symbol && (g = c.symbol(d.symbol, d.symbolX - p / 2, d.symbolY - p / 2, p, p).addClass("highcharts-button-symbol").attr({ zIndex: 1 }).add(e)); e.add().align(y(d, { width: e.width, x: C(d.x, b.buttonOffset) }), !0, "spacingBox"); b.buttonOffset += (e.width + d.buttonSpacing) * ("right" === d.align ? -1 : 1); b.exportSVGElements.push(e, g)
                }
            }, destroyExport: function (a) {
                var b = a ? a.target : this; a = b.exportSVGElements; var c = b.exportDivElements; a && (t(a, function (a, c) { a && (a.onclick = a.ontouchstart = null, b.exportSVGElements[c] = a.destroy()) }),
                a.length = 0); c && (t(c, function (a, c) { clearTimeout(a.hideTimer); G(a, "mouseleave"); b.exportDivElements[c] = a.onmouseout = a.onmouseover = a.ontouchstart = a.onclick = null; B(a) }), c.length = 0)
            }
        }); D.prototype.inlineToAttributes = "fill stroke strokeLinecap strokeLinejoin strokeWidth textAnchor x y".split(" "); D.prototype.inlineBlacklist = [/-/, /^(clipPath|cssText|d|height|width)$/, /^font$/, /[lL]ogical(Width|Height)$/, /perspective/, /TapHighlightColor/, /^transition/]; D.prototype.unstyledElements = ["clipPath", "defs", "desc"];
        A.prototype.inlineStyles = function () {
            function a(a) { return a.replace(/([A-Z])/g, function (a, b) { return "-" + b.toLowerCase() }) } function b(c) {
                var h, l, n, p = "", r, q; if (1 === c.nodeType && -1 === m.indexOf(c.nodeName)) {
                    l = z.getComputedStyle(c, null); n = "svg" === c.nodeName ? {} : z.getComputedStyle(c.parentNode, null); g[c.nodeName] || (e || (e = u.createElementNS(f.SVG_NS, "svg"), e.setAttribute("version", "1.1"), u.body.appendChild(e)), r = u.createElementNS(c.namespaceURI, c.nodeName), e.appendChild(r), g[c.nodeName] = v(z.getComputedStyle(r,
                    null)), e.removeChild(r)); for (h in l) { r = !1; for (q = k.length; q-- && !r;) r = k[q].test(h) || "function" === typeof l[h]; r || n[h] !== l[h] && g[c.nodeName][h] !== l[h] && (-1 !== d.indexOf(h) ? c.setAttribute(a(h), l[h]) : p += a(h) + ":" + l[h] + ";") } p && (h = c.getAttribute("style"), c.setAttribute("style", (h ? h + ";" : "") + p)); "text" !== c.nodeName && t(c.children || c.childNodes, b)
                }
            } var c = this.renderer, d = c.inlineToAttributes, k = c.inlineBlacklist, m = c.unstyledElements, g = {}, e; b(this.container.querySelector("svg")); e.parentNode.removeChild(e)
        }; H.menu =
        function (a, b, c, d) { return ["M", a, b + 2.5, "L", a + c, b + 2.5, "M", a, b + d / 2 + .5, "L", a + c, b + d / 2 + .5, "M", a, b + d - 1.5, "L", a + c, b + d - 1.5] }; A.prototype.renderExporting = function () { var a, b = this.options.exporting, c = b.buttons, d = this.isDirtyExporting || !this.exportSVGElements; this.buttonOffset = 0; this.isDirtyExporting && this.destroyExport(); if (d && !1 !== b.enabled) { for (a in c) this.addButton(c[a]); this.isDirtyExporting = !1 } x(this, "destroy", this.destroyExport) }; A.prototype.callbacks.push(function (a) {
            a.renderExporting(); x(a, "redraw", a.renderExporting);
            t(["exporting", "navigation"], function (b) { a[b] = { update: function (c, d) { a.isDirtyExporting = !0; v(!0, a.options[b], c); C(d, !0) && a.redraw() } } })
        })
    })(k)
});
