﻿function InitaliseMap(e) { var t = { controls: [], maxExtent: bounds, maxResolution: .0343479336057932, projection: "EPSG:4326", units: "degrees" }; var n = document.getElementById("map"); map = new OpenLayers.Map(n, t); LoadBaseLayers(map); InitBasicMapControl(); VectorLayer_Point = InitVectorLayer(map); InitSelectControl(map, VectorLayer_Point, false); map.zoomToExtent(bounds) } function UpdateMap(e) { CleanPopUps(); progressBar(true); var t = AddPincodePoints(e, VectorLayer_Point); if (t) { map.zoomToExtent(bounds); LayerLoadingProcess(VectorLayer_Point) } else { progressBar(false) } return t } function AddPincodePoints(e, t) { var n = false; t.removeAllFeatures(); var r = GetPointByPincode(e); if (window.DOMParser) { parser = new DOMParser; xmlDoc = parser.parseFromString(r, "text/xml") } else { xmlDoc = new ActiveXObject("Microsoft.XMLDOM"); xmlDoc.async = false; xmlDoc.loadXML(r) } var s = xmlDoc.getElementsByTagName("Table"); if (s.length > 0) { n = true; for (i = 0; i < s.length; i++) { var o = s[i].getElementsByTagName("Latitude")[0].childNodes[0].nodeValue; o = o + .005; var u = s[i].getElementsByTagName("Longitude")[0].childNodes[0].nodeValue; u = u - .003; var a = s[i].getElementsByTagName("KioskID")[0].childNodes[0].nodeValue; var f = s[i].getElementsByTagName("OMTID")[0].childNodes[0].nodeValue; var l = s[i].getElementsByTagName("VLECode")[0].childNodes[0].nodeValue; var c = s[i].getElementsByTagName("Name")[0].childNodes[0].nodeValue; var h = s[i].getElementsByTagName("CareOf")[0].childNodes[0].nodeValue; if (typeof s[i].getElementsByTagName("Building")[0].childNodes[0] !== "undefined") { var p = s[i].getElementsByTagName("Building")[0].childNodes[0].nodeValue } else { var p = "" } if (typeof s[i].getElementsByTagName("Street")[0].childNodes[0] !== "undefined") { var d = s[i].getElementsByTagName("Street")[0].childNodes[0].nodeValue } else { var d = "" } if (typeof s[i].getElementsByTagName("Landmark")[0].childNodes[0] !== "undefined") { var v = s[i].getElementsByTagName("Landmark")[0].childNodes[0].nodeValue } else { var v = "" } if (typeof s[i].getElementsByTagName("Locality")[0].childNodes[0] !== "undefined") { var m = s[i].getElementsByTagName("Locality")[0].childNodes[0].nodeValue } else { var m = "" } var g = s[i].getElementsByTagName("PinCode")[0].childNodes[0].nodeValue; var y = p + " " + d + " " + v + " " + m + " " + g; var b = s[i].getElementsByTagName("Mobile")[0].childNodes[0].nodeValue; var w = s[i].getElementsByTagName("EmailId")[0].childNodes[0].nodeValue; var E = { KioskID: a, OMTID: f, VLECode: l, Name: c, CareOf: h, Address: y, Mobile: b, EmailId: w }; var S = new OpenLayers.Feature.Vector(new OpenLayers.Geometry.Point(u, o), E); t.addFeatures(S) } } else { n = false } return n } function InitBasicMapControl() { map.addControl(new OpenLayers.Control.Navigation) } function LayerLoadingProcess(e) { map.zoomTo(map.getZoom() + 1); map.zoomToExtent(e.getDataExtent()); setTimeout(function () { progressBar(false) }, 8e3); map.zoomTo(map.getZoom() - 1) } function progressBar(e) { if (e) { document.getElementById("progress").style.display = "block"; document.getElementById("progress").style.visibility = "visible" } else { document.getElementById("progress").style.display = "none"; document.getElementById("progress").style.visibility = "hidden" } } format = "image/jpeg"; var map; var baseLayer, VectorLayer_Point; OpenLayers.DOTS_PER_INCH = 90.71428571428572; var bounds = new OpenLayers.Bounds(72.64978991999999, 15.606179999999998, 80.89912007999999, 22.02903000000009); var in_options = { internalProjection: new OpenLayers.Projection("EPSG:900913"), externalProjection: new OpenLayers.Projection("EPSG:4326") }