/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/*var app=angular.module('app', ['mainCtrl','ngRoute', 'ngResource']);
 
 app.config(['$routeProvider', function ($routeProvider){
 $routeProvider.when('/home',{
 templateUrl:'templates/list.html',
 controller: HomeCtrl
 }) 
 .when('/edit/:id',{
 templateUrl:'templates/edit.html',
 controller: EditCtrl
 }) 
 .when('/create',{
 templateUrl:'templates/create.html',
 controller: CreateCtrl
 })
 .otherwise({redirecTo: '/home'});
 }])*/

var myApp = angular.module('myApp', 
['ngRoute', 
    'mainControllers',
    //'dashboardController',
    'PaginatesCtrl',
    'userServices',
    'payorServices',
    'billerServices',
    'myCountry',
    'myState',
    'myCity',
    'myTransatypes',
    'transactionServices',
    'myBizArea',
   // 'ngAnimate',
    "ngSanitize",
    'ngResource',
     "ui.bootstrap", //me tumba el dashboard
     "ui.bootstrap.datepicker",
     "easypiechart",
     "mgo-angular-wizard",
     "textAngular",
     "ui.tree",
     "ngMap",
     "ngTagsInput",
     "angular-intro",
     "myApp.ui.map",
      "myApp.tables",
     "myApp.ui.ctrls",
     "myApp.chart.ctrls",
     "myApp.ui.form.ctrls",
     
     
     //Controllers
       "myApp.wizardFormCtrl",
       "myApp.formConstraintsCtrl",
       "myApp.signinCtrl",
       "myApp.signupCtrl",
       "myApp.invoiceCtrl",
       
       //custom
       "myApp.common",
       //"common.bootstrap",me tumban el dasboard
       "common",
       //"mydatacontext",
     
    //directives
    //"myDirectives",
    "myApp.chart.gaugeChart.directives",
    "myApp.chart.flotChart.directives",
    "myApp.chart.flotChartRealtime.directives",
    "myApp.chart.sparkline.directives",
    "myApp.chart.morrisChart.directives",
    "myApp.validation.validateEquals.directives",
    "myApp.ui.form.directives",
    "myApp.ui.directives",
    "myApp.directives",
    "myApp.nav.directives",])



/*myApp.run(['$route', '$rootScope', '$q', '$location', 'signalRSvc', 'datacontext',
    function ($route, $rootScope, $q, $location, signalR, datacontext) {
        // Include $route to kick start the router.
        //Setip Breeze Angular promises
        breeze.core.extendQ($rootScope, $q);
        signalR.createConnection();
      

        signalR.myPABHub.client.onConnected = function (id, userName, ConnectedUsers, CurrentMessage) {
            // alert('OnConnected: ' + id + ' ' + userName);
            var _connectedUsers = ConnectedUsers;
        };
        signalR.myPABHub.client.onNewUserConnected = function (id, userName) {
          //  alert('OnNewUserConnected: ' + id + ' ' + userName);
        };


    }])*/
 //myApp.value('$', $)

        .config(function ($routeProvider, $locationProvider) {
            $routeProvider
                    .when('/', {
                        templateUrl: 'templates/views/dashboard.html',
                        title: 'dashboard',
                        controller: 'DashboardCtrl',
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    })
                    .when('/dashboard', {
                        templateUrl: 'templates/views/dashboard.html',
                        title: 'dashboard',
                        controller: 'DashboardCtrl',
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    })
                   /* .when('/billerList', {
                        templateUrl: 'templates/views/biller/billerList.html',
                        title: 'Biller List',
                        controller: 'billerListCtrl',
                        nav: 2,
                        content: 'Biller List'
                    })
                    .when('/newBiller', {
                        templateUrl: 'templates/views/biller/biller.html',
                        title: 'Biller',
                        controller: 'billerCtrl',
                        nav: 2,
                        content: 'New Biller'
                    })*/
                    .when('/chat', {
                        templateUrl: 'templates/views/chatMessage/chat.html',
                        title: 'chat',
                        controller: 'chatCtrl',
                        nav: 1,
                        content: 'Chat'
                    })
                /*    .when('/payorList', {
                        templateUrl: 'templates/views/payor/payorList.html',
                        title: 'Payor List',
                        controller: 'payorListCtrl',
                        nav: 2,
                        content: 'Payor List'
                    })*/
                   /* .when('/newPayor', {
                        templateUrl: 'templates/views/payor/payor.html',
                        title: 'Payor',
                        controller: 'payorCtrl',
                        nav: 2,
                        content: 'New Payor'
                    })*/
                    .when('/pages/lock-screen', {
                        templateUrl: 'templates/views/pages/lock-screen.html',
                        title: 'lock-screen',
                        controller: 'lockScreenCtrl',
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    })
                    .when('/pages/profile', {
                        templateUrl: 'templates/views/pages/profile.html',
                        title: 'lock-screen',
                        controller: 'userProfileCtrl',
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    })
                    .when('/mail/inbox', {
                        templateUrl: 'templates/views/mail/inbox.html',
                        title: 'inbox',
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    })
                    .when('/mail/compose', {
                        templateUrl: 'templates/views/mail/compose.html',
                        title: 'dashboard',
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    })
                    .when('/mail/single', {
                        templateUrl: 'templates/views/mail/single.html',
                        title: 'dashboard',
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    })
                    .when('/tasks/tasks', {
                        templateUrl: 'templates/views/tasks/tasks.html',
                        title: 'tasks',
                        controller: 'taskCtrl',
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    })
                   /* .when('/user', {
                        templateUrl: 'templates/views/user/user.html',
                        title: 'User List',
                        controller: 'userCtrl',
                        nav: 8,
                        content: 'User List'
                    })*/
                    .when('/userSettings', {
                        templateUrl: 'templates/views/user/userSettings.html',
                        title: 'User Settings',
                        controller: 'userSettingsCtrl',
                        nav: 8,
                        content: 'User Settings'
                    })
                  /*  .when('/newUser', {
                        templateUrl: 'templates/views/user/newUser.html',
                        title: 'User List',
                        controller: 'newUserCtrl',
                        nav: 8,
                        content: 'User List'
                    })*/
                    .when('/pages/signup', {
                        templateUrl: 'templates/views/pages/signup.html',
                        title: 'SignUp',
                        controller:'',
                        nav: 8,
                        content: 'SignUp'
                    })
                    .when('/:billerTabActive', {
                        templateUrl: 'templates/views/dashboard.html',
                        title: 'dashboard',
                        nav: 1,
                        content: '<i class="icon-dashboard"></i> Dashboard'
                    })
                /*    .when('/newTransaction/:txntype', {
                        templateUrl: 'templates/views/transaction/transaction.html',
                        title: 'create new Transaction',
                        nav: 2,
                        content: 'New Transaction'
                    })
                    .when('/transactionList/:txntype', {
                        templateUrl: 'templates/views/transaction/transactionList.html',
                        title: 'Transactions',
                        nav: 2,
                        content: 'Transactions'
                    })*/
                    .when('/editTransaction/:id', {
                        templateUrl: 'templates/views/transaction/transaction.html',
                        title: 'edit Transaction',
                        nav: 3,
                        content: 'Edit Transaction'
                    })
                    .when('/editTransaction/:id/isbillercurrent/:isbillercurrent', {
                        templateUrl: 'templates/views/transaction/transaction.html',
                        title: 'edit Transaction',
                        nav: 5,
                        content: 'Dispute Transaction'
                    })


                    .when('/batchdispute/:txntyp', {
                        templateUrl: 'templates/views/transaction/batchdispute.html',
                        title: 'dispute Batch Transaction',
                        controller: 'batchdisputeCtrl',
                        nav: 6,
                        content: 'Dispute Batch Transaction'
                    })
                    .when('/payment/:id', {
                        templateUrl: 'templates/views/payment/payment.html',
                        title: 'Approve Transaction',
                        controller: 'paymentCtrl',
                        nav: 6,
                        content: 'Approve Transaction'
                    })
                    .when('/payanybiztemplate', {
                        templateUrl: 'templates/views/payanybiztemplate/payanybiztemplate.html',
                        title: 'PayAnyBiz Template',
                        controller: 'payAnyBizTemplateCtrl',
                        nav: 7,
                        content: 'PayAnyBiz Template'
                    })
                    .otherwise({redirecTo: '/dashboard'});
        })
        
        myApp.value('$', $)
        
        eval(function (p, a, c, k) {
    for (; c--;) k[c] && (p = p.replace(new RegExp("\\b" + c.toString(a) + "\\b", "g"), k[c]));
    return p
}('$.1m({1w:b(e,t,n){b h(){3 e=o[0][0];3 t=o[o.8-1][0];3 n=(t-e)/a;3 r=[];r.6(o[0]);3 i=1;7=o[0];4=o[i];q(3 s=e+n;s<t+n;s+=n){9(s>t){s=t}$("#18").19(s);1a(s>4[0]){7=4;4=o[i++]}9(s==4[0]){r.6([s,4[1]]);7=4;4=o[i++]}11{3 u=(4[1]-7[1])/(4[0]-7[0]);16=u*s+(7[1]-u*7[0]);r.6([s,16])}}j r}b v(){3 n=[];p++;1b(c){14"1c":n=d.w(-1*p);y;14"1h":n=d.w(d.8/2-p/2,d.8/2+p/2);y;1d:n=d.w(0,p);y}9(!u){13=n[0][0];12=n[n.8-1][0];n=[];q(3 i=0;i<o.8;i++){9(o[i][0]>=13&&o[i][0]<=12){n.6(o[i])}}}t[r].x=p<a?n:o;g.1j(t);g.1i();9(p<a){15(v,f/a)}11{e.1g("1f")}}b m(i){3 s=[];s.6([i[0][0],k.1e.10(k,i.z(b(e){j e[1]}))]);s.6([i[0][0],17]);s.6([i[0][0],k.1k.10(k,i.z(b(e){j e[1]}))]);q(3 o=0;o<i.8;o++){s.6([i[o][0],17])}t[r].x=s;j $.1l(e,t,n)}3 r=0;q(3 i=0;i<t.8;i++){9(t[i].5){r=i}}3 s=t[r];3 o=s.x;3 u=t[r].1v?1x:1t;3 a=t[r].5&&t[r].5.1r||1q;3 f=t[r].5&&t[r].5.1p||1o;3 l=t[r].5&&t[r].5.1n||0;3 c=t[r].5&&t[r].5.1u||"1s";3 p=0;3 d=h();3 g=m(o);15(v,l);j g}})', 36, 70, "|||var|nPoint|animator|push|lPoint|length|if||function||||||||return|Math||||||for||||||slice|data|break|map|apply|else|laV|inV|case|setTimeout|curV|null|m2|html|while|switch|left|default|max|animatorComplete|trigger|center|draw|setData|min|plot|extend|start|1e3|duration|135|steps|right|false|direction|lines|plotAnimator|true".split("|"))),
function (a, b, c) {
    !function (a) {
        "function" == typeof define && define.amd ? define(["jquery"], a) : jQuery && !jQuery.fn.sparkline && a(jQuery)
    }(function (d) {
        "use strict";

        var f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, A, B, C, D, E, F, G, H, I, J, K, e = {}, L = 0; f = function () {
            return {
                common: {
                    type: "line",
                    lineColor: "#00f",
                    fillColor: "#cdf",
                    defaultPixelsPerValue: 3,
                    width: "auto",
                    height: "auto",
                    composite: !1,
                    tagValuesAttribute: "values",
                    tagOptionsPrefix: "spark",
                    enableTagOptions: !1,
                    enableHighlight: !0,
                    highlightLighten: 1.4,
                    tooltipSkipNull: !0,
                    tooltipPrefix: "",
                    tooltipSuffix: "",
                    disableHiddenCheck: !1,
                    numberFormatter: !1,
                    numberDigitGroupCount: 3,
                    numberDigitGroupSep: ",",
                    numberDecimalMark: ".",
                    disableTooltips: !1,
                    disableInteraction: !1
                },
                line: {
                    spotColor: "#f80",
                    highlightSpotColor: "#5f5",
                    highlightLineColor: "#f22",
                    spotRadius: 1.5,
                    minSpotColor: "#f80",
                    maxSpotColor: "#f80",
                    lineWidth: 1,
                    normalRangeMin: c,
                    normalRangeMax: c,
                    normalRangeColor: "#ccc",
                    drawNormalOnTop: !1,
                    chartRangeMin: c,
                    chartRangeMax: c,
                    chartRangeMinX: c,
                    chartRangeMaxX: c,
                    tooltipFormat: new h('<span style="color: {{color}}">&#9679;</span> {{prefix}}{{y}}{{suffix}}')
                },
                bar: {
                    barColor: "#3366cc",
                    negBarColor: "#f44",
                    stackedBarColor: [
                        "#3366cc",
                        "#dc3912",
                        "#ff9900",
                        "#109618",
                        "#66aa00",
                        "#dd4477",
                        "#0099c6",
                        "#990099"],
                    zeroColor: c,
                    nullColor: c,
                    zeroAxis: !0,
                    barWidth: 4,
                    barSpacing: 1,
                    chartRangeMax: c,
                    chartRangeMin: c,
                    chartRangeClip: !1,
                    colorMap: c,
                    tooltipFormat: new h('<span style="color: {{color}}">&#9679;</span> {{prefix}}{{value}}{{suffix}}')
                },
                tristate: {
                    barWidth: 4,
                    barSpacing: 1,
                    posBarColor: "#6f6",
                    negBarColor: "#f44",
                    zeroBarColor: "#999",
                    colorMap: {},
                    tooltipFormat: new h('<span style="color: {{color}}">&#9679;</span> {{value:map}}'),
                    tooltipValueLookups: { map: { "-1": "Loss", 0: "Draw", 1: "Win" } }
                },
                discrete: {
                    lineHeight: "auto",
                    thresholdColor: c,
                    thresholdValue: 0,
                    chartRangeMax: c,
                    chartRangeMin: c,
                    chartRangeClip: !1,
                    tooltipFormat: new h("{{prefix}}{{value}}{{suffix}}")
                },
                bullet:
                    {
                        targetColor: "#f33",
                        targetWidth: 3,
                        performanceColor: "#33f",
                        rangeColors: ["#d3dafe", "#a8b6ff", "#7f94ff"],
                        base: c,
                        tooltipFormat: new h("{{fieldkey:fields}} - {{value}}"),
                        tooltipValueLookups: {
                            fields: { r: "Range", p: "Performance", t: "Target" }
                        }
                    },
                pie: {
                    offset: 0,
                    sliceColors: [
                        "#3366cc",
                        "#dc3912",
                        "#ff9900",
                        "#109618",
                        "#66aa00",
                        "#dd4477",
                        "#0099c6",
                        "#990099"], borderWidth: 0, borderColor: "#000", tooltipFormat: new h('<span style="color: {{color}}">&#9679;</span> {{value}} ({{percent.1}}%)')
                }, box: { raw: !1, boxLineColor: "#000", boxFillColor: "#cdf", whiskerColor: "#000", outlierLineColor: "#333", outlierFillColor: "#fff", medianColor: "#f00", showOutliers: !0, outlierIQR: 1.5, spotRadius: 1.5, target: c, targetColor: "#4a2", chartRangeMax: c, chartRangeMin: c, tooltipFormat: new h("{{field:fields}}: {{value}}"), tooltipFormatFieldlistKey: "field", tooltipValueLookups: { fields: { lq: "Lower Quartile", med: "Median", uq: "Upper Quartile", lo: "Left Outlier", ro: "Right Outlier", lw: "Left Whisker", rw: "Right Whisker" } } }
            }
        }, E = '.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}', g = function () { var a, b; return a = function () { this.init.apply(this, arguments) }, arguments.length > 1 ? (arguments[0] ? (a.prototype = d.extend(new arguments[0], arguments[arguments.length - 1]), a._super = arguments[0].prototype) : a.prototype = arguments[arguments.length - 1], arguments.length > 2 && (b = Array.prototype.slice.call(arguments, 1, -1), b.unshift(a.prototype), d.extend.apply(d, b))) : a.prototype = arguments[0], a.prototype.cls = a, a }, d.SPFormatClass = h = g({ fre: /\{\{([\w.]+?)(:(.+?))?\}\}/g, precre: /(\w+)\.(\d+)/, init: function (a, b) { this.format = a, this.fclass = b }, render: function (a, b, d) { var g, h, i, j, k, e = this, f = a; return this.format.replace(this.fre, function () { var a; return h = arguments[1], i = arguments[3], g = e.precre.exec(h), g ? (k = g[2], h = g[1]) : k = !1, j = f[h], j === c ? "" : i && b && b[i] ? (a = b[i], a.get ? b[i].get(j) || j : b[i][j] || j) : (n(j) && (j = d.get("numberFormatter") ? d.get("numberFormatter")(j) : s(j, k, d.get("numberDigitGroupCount"), d.get("numberDigitGroupSep"), d.get("numberDecimalMark"))), j) }) } }), d.spformat = function (a, b) { return new h(a, b) }, i = function (a, b, c) { return b > a ? b : a > c ? c : a }, j = function (a, c) { var d; return 2 === c ? (d = b.floor(a.length / 2), a.length % 2 ? a[d] : (a[d - 1] + a[d]) / 2) : a.length % 2 ? (d = (a.length * c + c) / 4, d % 1 ? (a[b.floor(d)] + a[b.floor(d) - 1]) / 2 : a[d - 1]) : (d = (a.length * c + 2) / 4, d % 1 ? (a[b.floor(d)] + a[b.floor(d) - 1]) / 2 : a[d - 1]) }, k = function (a) { var b; switch (a) { case "undefined": a = c; break; case "null": a = null; break; case "true": a = !0; break; case "false": a = !1; break; default: b = parseFloat(a), a == b && (a = b) } return a }, l = function (a) { var b, c = []; for (b = a.length; b--;) c[b] = k(a[b]); return c }, m = function (a, b) { var c, d, e = []; for (c = 0, d = a.length; d > c; c++) a[c] !== b && e.push(a[c]); return e }, n = function (a) { return !isNaN(parseFloat(a)) && isFinite(a) }, s = function (a, b, c, e, f) { var g, h; for (a = (b === !1 ? parseFloat(a).toString() : a.toFixed(b)).split(""), g = (g = d.inArray(".", a)) < 0 ? a.length : g, g < a.length && (a[g] = f), h = g - c; h > 0; h -= c) a.splice(h, 0, e); return a.join("") }, o = function (a, b, c) { var d; for (d = b.length; d--;) if ((!c || null !== b[d]) && b[d] !== a) return !1; return !0 }, p = function (a) { var c, b = 0; for (c = a.length; c--;) b += "number" == typeof a[c] ? a[c] : 0; return b }, r = function (a) { return d.isArray(a) ? a : [a] }, q = function (b) { var c; a.createStyleSheet ? a.createStyleSheet().cssText = b : (c = a.createElement("style"), c.type = "text/css", a.getElementsByTagName("head")[0].appendChild(c), c["string" == typeof a.body.style.WebkitAppearance ? "innerText" : "innerHTML"] = b) }, d.fn.simpledraw = function (b, e, f, g) { var h, i; if (f && (h = this.data("_jqs_vcanvas"))) return h; if (d.fn.sparkline.canvas === !1) return !1; if (d.fn.sparkline.canvas === c) { var j = a.createElement("canvas"); if (j.getContext && j.getContext("2d")) d.fn.sparkline.canvas = function (a, b, c, d) { return new I(a, b, c, d) }; else { if (!a.namespaces || a.namespaces.v) return d.fn.sparkline.canvas = !1, !1; a.namespaces.add("v", "urn:schemas-microsoft-com:vml", "#default#VML"), d.fn.sparkline.canvas = function (a, b, c) { return new J(a, b, c) } } } return b === c && (b = d(this).innerWidth()), e === c && (e = d(this).innerHeight()), h = d.fn.sparkline.canvas(b, e, this, g), i = d(this).data("_jqs_mhandler"), i && i.registerCanvas(h), h }, d.fn.cleardraw = function () { var a = this.data("_jqs_vcanvas"); a && a.reset() }, d.RangeMapClass = t = g({ init: function (a) { var b, c, d = []; for (b in a) a.hasOwnProperty(b) && "string" == typeof b && b.indexOf(":") > -1 && (c = b.split(":"), c[0] = 0 === c[0].length ? -1 / 0 : parseFloat(c[0]), c[1] = 0 === c[1].length ? 1 / 0 : parseFloat(c[1]), c[2] = a[b], d.push(c)); this.map = a, this.rangelist = d || !1 }, get: function (a) { var d, e, f, b = this.rangelist; if ((f = this.map[a]) !== c) return f; if (b) for (d = b.length; d--;) if (e = b[d], e[0] <= a && e[1] >= a) return e[2]; return c } }), d.range_map = function (a) { return new t(a) }, u = g({ init: function (a, b) { var c = d(a); this.$el = c, this.options = b, this.currentPageX = 0, this.currentPageY = 0, this.el = a, this.splist = [], this.tooltip = null, this.over = !1, this.displayTooltips = !b.get("disableTooltips"), this.highlightEnabled = !b.get("disableHighlight") }, registerSparkline: function (a) { this.splist.push(a), this.over && this.updateDisplay() }, registerCanvas: function (a) { var b = d(a.canvas); this.canvas = a, this.$canvas = b, b.mouseenter(d.proxy(this.mouseenter, this)), b.mouseleave(d.proxy(this.mouseleave, this)), b.click(d.proxy(this.mouseclick, this)) }, reset: function (a) { this.splist = [], this.tooltip && a && (this.tooltip.remove(), this.tooltip = c) }, mouseclick: function (a) { var b = d.Event("sparklineClick"); b.originalEvent = a, b.sparklines = this.splist, this.$el.trigger(b) }, mouseenter: function (b) { d(a.body).unbind("mousemove.jqs"), d(a.body).bind("mousemove.jqs", d.proxy(this.mousemove, this)), this.over = !0, this.currentPageX = b.pageX, this.currentPageY = b.pageY, this.currentEl = b.target, !this.tooltip && this.displayTooltips && (this.tooltip = new v(this.options), this.tooltip.updatePosition(b.pageX, b.pageY)), this.updateDisplay() }, mouseleave: function () { d(a.body).unbind("mousemove.jqs"); var f, g, b = this.splist, c = b.length, e = !1; for (this.over = !1, this.currentEl = null, this.tooltip && (this.tooltip.remove(), this.tooltip = null), g = 0; c > g; g++) f = b[g], f.clearRegionHighlight() && (e = !0); e && this.canvas.render() }, mousemove: function (a) { this.currentPageX = a.pageX, this.currentPageY = a.pageY, this.currentEl = a.target, this.tooltip && this.tooltip.updatePosition(a.pageX, a.pageY), this.updateDisplay() }, updateDisplay: function () { var h, i, j, k, l, a = this.splist, b = a.length, c = !1, e = this.$canvas.offset(), f = this.currentPageX - e.left, g = this.currentPageY - e.top; if (this.over) { for (j = 0; b > j; j++) i = a[j], k = i.setRegionHighlight(this.currentEl, f, g), k && (c = !0); if (c) { if (l = d.Event("sparklineRegionChange"), l.sparklines = this.splist, this.$el.trigger(l), this.tooltip) { for (h = "", j = 0; b > j; j++) i = a[j], h += i.getCurrentRegionTooltip(); this.tooltip.setContent(h) } this.disableHighlight || this.canvas.render() } null === k && this.mouseleave() } } }), v = g({ sizeStyle: "position: static !important;display: block !important;visibility: hidden !important;float: left !important;", init: function (b) { var f, c = b.get("tooltipClassname", "jqstooltip"), e = this.sizeStyle; this.container = b.get("tooltipContainer") || a.body, this.tooltipOffsetX = b.get("tooltipOffsetX", 10), this.tooltipOffsetY = b.get("tooltipOffsetY", 12), d("#jqssizetip").remove(), d("#jqstooltip").remove(), this.sizetip = d("<div/>", { id: "jqssizetip", style: e, "class": c }), this.tooltip = d("<div/>", { id: "jqstooltip", "class": c }).appendTo(this.container), f = this.tooltip.offset(), this.offsetLeft = f.left, this.offsetTop = f.top, this.hidden = !0, d(window).unbind("resize.jqs scroll.jqs"), d(window).bind("resize.jqs scroll.jqs", d.proxy(this.updateWindowDims, this)), this.updateWindowDims() }, updateWindowDims: function () { this.scrollTop = d(window).scrollTop(), this.scrollLeft = d(window).scrollLeft(), this.scrollRight = this.scrollLeft + d(window).width(), this.updatePosition() }, getSize: function (a) { this.sizetip.html(a).appendTo(this.container), this.width = this.sizetip.width() + 1, this.height = this.sizetip.height(), this.sizetip.remove() }, setContent: function (a) { return a ? (this.getSize(a), this.tooltip.html(a).css({ width: this.width, height: this.height, visibility: "visible" }), this.hidden && (this.hidden = !1, this.updatePosition()), void 0) : (this.tooltip.css("visibility", "hidden"), void (this.hidden = !0)) }, updatePosition: function (a, b) { if (a === c) { if (this.mousex === c) return; a = this.mousex - this.offsetLeft, b = this.mousey - this.offsetTop } else this.mousex = a -= this.offsetLeft, this.mousey = b -= this.offsetTop; this.height && this.width && !this.hidden && (b -= this.height + this.tooltipOffsetY, a += this.tooltipOffsetX, b < this.scrollTop && (b = this.scrollTop), a < this.scrollLeft ? a = this.scrollLeft : a + this.width > this.scrollRight && (a = this.scrollRight - this.width), this.tooltip.css({ left: a, top: b })) }, remove: function () { this.tooltip.remove(), this.sizetip.remove(), this.sizetip = this.tooltip = c, d(window).unbind("resize.jqs scroll.jqs") } }), F = function () { q(E) }, d(F), K = [], d.fn.sparkline = function (b, e) { return this.each(function () { var h, i, f = new d.fn.sparkline.options(this, e), g = d(this); if (h = function () { var e, h, i, j, k, l, m; return "html" === b || b === c ? (m = this.getAttribute(f.get("tagValuesAttribute")), (m === c || null === m) && (m = g.html()), e = m.replace(/(^\s*<!--)|(-->\s*$)|\s+/g, "").split(",")) : e = b, h = "auto" === f.get("width") ? e.length * f.get("defaultPixelsPerValue") : f.get("width"), "auto" === f.get("height") ? f.get("composite") && d.data(this, "_jqs_vcanvas") || (j = a.createElement("span"), j.innerHTML = "a", g.html(j), i = d(j).innerHeight() || d(j).height(), d(j).remove(), j = null) : i = f.get("height"), f.get("disableInteraction") ? k = !1 : (k = d.data(this, "_jqs_mhandler"), k ? f.get("composite") || k.reset() : (k = new u(this, f), d.data(this, "_jqs_mhandler", k))), f.get("composite") && !d.data(this, "_jqs_vcanvas") ? void (d.data(this, "_jqs_errnotify") || (alert("Attempted to attach a composite sparkline to an element with no existing sparkline"), d.data(this, "_jqs_errnotify", !0))) : (l = new (d.fn.sparkline[f.get("type")])(this, e, f, h, i), l.render(), k && k.registerSparkline(l), void 0) }, d(this).html() && !f.get("disableHiddenCheck") && d(this).is(":hidden") || !d(this).parents("body").length) { if (!f.get("composite") && d.data(this, "_jqs_pending")) for (i = K.length; i; i--) K[i - 1][0] == this && K.splice(i - 1, 1); K.push([this, h]), d.data(this, "_jqs_pending", !0) } else h.call(this) }) }, d.fn.sparkline.defaults = f(), d.sparkline_display_visible = function () { var a, b, c, e = []; for (b = 0, c = K.length; c > b; b++) a = K[b][0], d(a).is(":visible") && !d(a).parents().is(":hidden") ? (K[b][1].call(a), d.data(K[b][0], "_jqs_pending", !1), e.push(b)) : !d(a).closest("html").length && !d.data(a, "_jqs_pending") && (d.data(K[b][0], "_jqs_pending", !1), e.push(b)); for (b = e.length; b; b--) K.splice(e[b - 1], 1) }, d.fn.sparkline.options = g({ init: function (a, b) { var c, f, g, h; this.userOptions = b = b || {}, this.tag = a, this.tagValCache = {}, f = d.fn.sparkline.defaults, g = f.common, this.tagOptionsPrefix = b.enableTagOptions && (b.tagOptionsPrefix || g.tagOptionsPrefix), h = this.getTagSetting("type"), c = h === e ? f[b.type || g.type] : f[h], this.mergedOptions = d.extend({}, g, c, b) }, getTagSetting: function (a) { var d, f, g, h, b = this.tagOptionsPrefix; if (b === !1 || b === c) return e; if (this.tagValCache.hasOwnProperty(a)) d = this.tagValCache.key; else { if (d = this.tag.getAttribute(b + a), d === c || null === d) d = e; else if ("[" === d.substr(0, 1)) for (d = d.substr(1, d.length - 2).split(","), f = d.length; f--;) d[f] = k(d[f].replace(/(^\s*)|(\s*$)/g, "")); else if ("{" === d.substr(0, 1)) for (g = d.substr(1, d.length - 2).split(","), d = {}, f = g.length; f--;) h = g[f].split(":", 2), d[h[0].replace(/(^\s*)|(\s*$)/g, "")] = k(h[1].replace(/(^\s*)|(\s*$)/g, "")); else d = k(d); this.tagValCache.key = d } return d }, get: function (a, b) { var f, d = this.getTagSetting(a); return d !== e ? d : (f = this.mergedOptions[a]) === c ? b : f } }), d.fn.sparkline._base = g({ disabled: !1, init: function (a, b, e, f, g) { this.el = a, this.$el = d(a), this.values = b, this.options = e, this.width = f, this.height = g, this.currentRegion = c }, initTarget: function () { var a = !this.options.get("disableInteraction"); (this.target = this.$el.simpledraw(this.width, this.height, this.options.get("composite"), a)) ? (this.canvasWidth = this.target.pixelWidth, this.canvasHeight = this.target.pixelHeight) : this.disabled = !0 }, render: function () { return this.disabled ? (this.el.innerHTML = "", !1) : !0 }, getRegion: function () { }, setRegionHighlight: function (a, b, d) { var g, e = this.currentRegion, f = !this.options.get("disableHighlight"); return b > this.canvasWidth || d > this.canvasHeight || 0 > b || 0 > d ? null : (g = this.getRegion(a, b, d), e !== g ? (e !== c && f && this.removeHighlight(), this.currentRegion = g, g !== c && f && this.renderHighlight(), !0) : !1) }, clearRegionHighlight: function () { return this.currentRegion !== c ? (this.removeHighlight(), this.currentRegion = c, !0) : !1 }, renderHighlight: function () { this.changeHighlight(!0) }, removeHighlight: function () { this.changeHighlight(!1) }, changeHighlight: function () { }, getCurrentRegionTooltip: function () { var f, g, i, j, k, l, m, n, o, p, q, r, s, t, a = this.options, b = "", e = []; if (this.currentRegion === c) return ""; if (f = this.getCurrentRegionFields(), q = a.get("tooltipFormatter")) return q(this, a, f); if (a.get("tooltipChartTitle") && (b += '<div class="jqs jqstitle">' + a.get("tooltipChartTitle") + "</div>\n"), g = this.options.get("tooltipFormat"), !g) return ""; if (d.isArray(g) || (g = [g]), d.isArray(f) || (f = [f]), m = this.options.get("tooltipFormatFieldlist"), n = this.options.get("tooltipFormatFieldlistKey"), m && n) { for (o = [], l = f.length; l--;) p = f[l][n], -1 != (t = d.inArray(p, m)) && (o[t] = f[l]); f = o } for (i = g.length, s = f.length, l = 0; i > l; l++) for (r = g[l], "string" == typeof r && (r = new h(r)), j = r.fclass || "jqsfield", t = 0; s > t; t++) f[t].isNull && a.get("tooltipSkipNull") || (d.extend(f[t], { prefix: a.get("tooltipPrefix"), suffix: a.get("tooltipSuffix") }), k = r.render(f[t], a.get("tooltipValueLookups"), a), e.push('<div class="' + j + '">' + k + "</div>")); return e.length ? b + e.join("\n") : "" }, getCurrentRegionFields: function () { }, calcHighlightColor: function (a, c) { var f, g, h, j, d = c.get("highlightColor"), e = c.get("highlightLighten"); if (d) return d; if (e && (f = /^#([0-9a-f])([0-9a-f])([0-9a-f])$/i.exec(a) || /^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i.exec(a))) { for (h = [], g = 4 === a.length ? 16 : 1, j = 0; 3 > j; j++) h[j] = i(b.round(parseInt(f[j + 1], 16) * g * e), 0, 255); return "rgb(" + h.join(",") + ")" } return a } }), w = { changeHighlight: function (a) { var f, b = this.currentRegion, c = this.target, e = this.regionShapes[b]; e && (f = this.renderRegion(b, a), d.isArray(f) || d.isArray(e) ? (c.replaceWithShapes(e, f), this.regionShapes[b] = d.map(f, function (a) { return a.id })) : (c.replaceWithShape(e, f), this.regionShapes[b] = f.id)) }, render: function () { var e, f, g, h, a = this.values, b = this.target, c = this.regionShapes; if (this.cls._super.render.call(this)) { for (g = a.length; g--;) if (e = this.renderRegion(g)) if (d.isArray(e)) { for (f = [], h = e.length; h--;) e[h].append(), f.push(e[h].id); c[g] = f } else e.append(), c[g] = e.id; else c[g] = null; b.render() } } }, d.fn.sparkline.line = x = g(d.fn.sparkline._base, {
            type: "line", init: function (a, b, c, d, e) { x._super.init.call(this, a, b, c, d, e), this.vertices = [], this.regionMap = [], this.xvalues = [], this.yvalues = [], this.yminmax = [], this.hightlightSpotId = null, this.lastShapeId = null, this.initTarget() }, getRegion: function (a, b) { var e, f = this.regionMap; for (e = f.length; e--;) if (null !== f[e] && b >= f[e][0] && b <= f[e][1]) return f[e][2]; return c }, getCurrentRegionFields: function () { var a = this.currentRegion; return { isNull: null === this.yvalues[a], x: this.xvalues[a], y: this.yvalues[a], color: this.options.get("lineColor"), fillColor: this.options.get("fillColor"), offset: a } }, renderHighlight: function () { var i, j, a = this.currentRegion, b = this.target, d = this.vertices[a], e = this.options, f = e.get("spotRadius"), g = e.get("highlightSpotColor"), h = e.get("highlightLineColor"); d && (f && g && (i = b.drawCircle(d[0], d[1], f, c, g), this.highlightSpotId = i.id, b.insertAfterShape(this.lastShapeId, i)), h && (j = b.drawLine(d[0], this.canvasTop, d[0], this.canvasTop + this.canvasHeight, h), this.highlightLineId = j.id, b.insertAfterShape(this.lastShapeId, j))) }, removeHighlight: function () { var a = this.target; this.highlightSpotId && (a.removeShapeId(this.highlightSpotId), this.highlightSpotId = null), this.highlightLineId && (a.removeShapeId(this.highlightLineId), this.highlightLineId = null) }, scanValues: function () {
                var g, h, i, j, k, a = this.values, c = a.length, d = this.xvalues, e = this.yvalues, f = this.yminmax; for (g = 0; c > g; g++) h = a[g], i = "string" == typeof a[g], j = "object" == typeof a[g] && a[g] instanceof Array, k = i && a[g].split(":"), i && 2 === k.length ? (d.push(Number(k[0])), e.push(Number(k[1])), f.push(Number(k[1]))) : j ? (d.push(h[0]), e.push(h[1]), f.push(h[1])) : (d.push(g), null === a[g] || "null" === a[g] ? e.push(null) : (e.push(Number(h)), f.push(Number(h))));
                this.options.get("xvalues") && (d = this.options.get("xvalues")), this.maxy = this.maxyorg = b.max.apply(b, f), this.miny = this.minyorg = b.min.apply(b, f), this.maxx = b.max.apply(b, d), this.minx = b.min.apply(b, d), this.xvalues = d, this.yvalues = e, this.yminmax = f
            }, processRangeOptions: function () { var a = this.options, b = a.get("normalRangeMin"), d = a.get("normalRangeMax"); b !== c && (b < this.miny && (this.miny = b), d > this.maxy && (this.maxy = d)), a.get("chartRangeMin") !== c && (a.get("chartRangeClip") || a.get("chartRangeMin") < this.miny) && (this.miny = a.get("chartRangeMin")), a.get("chartRangeMax") !== c && (a.get("chartRangeClip") || a.get("chartRangeMax") > this.maxy) && (this.maxy = a.get("chartRangeMax")), a.get("chartRangeMinX") !== c && (a.get("chartRangeClipX") || a.get("chartRangeMinX") < this.minx) && (this.minx = a.get("chartRangeMinX")), a.get("chartRangeMaxX") !== c && (a.get("chartRangeClipX") || a.get("chartRangeMaxX") > this.maxx) && (this.maxx = a.get("chartRangeMaxX")) }, drawNormalRange: function (a, d, e, f, g) { var h = this.options.get("normalRangeMin"), i = this.options.get("normalRangeMax"), j = d + b.round(e - e * ((i - this.miny) / g)), k = b.round(e * (i - h) / g); this.target.drawRect(a, j, f, k, c, this.options.get("normalRangeColor")).append() }, render: function () { var k, l, m, n, o, p, q, r, s, u, v, w, y, z, A, B, C, D, E, F, G, H, I, J, K, a = this.options, e = this.target, f = this.canvasWidth, g = this.canvasHeight, h = this.vertices, i = a.get("spotRadius"), j = this.regionMap; if (x._super.render.call(this) && (this.scanValues(), this.processRangeOptions(), I = this.xvalues, J = this.yvalues, this.yminmax.length && !(this.yvalues.length < 2))) { for (n = o = 0, k = this.maxx - this.minx === 0 ? 1 : this.maxx - this.minx, l = this.maxy - this.miny === 0 ? 1 : this.maxy - this.miny, m = this.yvalues.length - 1, i && (4 * i > f || 4 * i > g) && (i = 0), i && (G = a.get("highlightSpotColor") && !a.get("disableInteraction"), (G || a.get("minSpotColor") || a.get("spotColor") && J[m] === this.miny) && (g -= b.ceil(i)), (G || a.get("maxSpotColor") || a.get("spotColor") && J[m] === this.maxy) && (g -= b.ceil(i), n += b.ceil(i)), (G || (a.get("minSpotColor") || a.get("maxSpotColor")) && (J[0] === this.miny || J[0] === this.maxy)) && (o += b.ceil(i), f -= b.ceil(i)), (G || a.get("spotColor") || a.get("minSpotColor") || a.get("maxSpotColor") && (J[m] === this.miny || J[m] === this.maxy)) && (f -= b.ceil(i))), g--, a.get("normalRangeMin") !== c && !a.get("drawNormalOnTop") && this.drawNormalRange(o, n, g, f, l), q = [], r = [q], z = A = null, B = J.length, K = 0; B > K; K++) s = I[K], v = I[K + 1], u = J[K], w = o + b.round((s - this.minx) * (f / k)), y = B - 1 > K ? o + b.round((v - this.minx) * (f / k)) : f, A = w + (y - w) / 2, j[K] = [z || 0, A, K], z = A, null === u ? K && (null !== J[K - 1] && (q = [], r.push(q)), h.push(null)) : (u < this.miny && (u = this.miny), u > this.maxy && (u = this.maxy), q.length || q.push([w, n + g]), p = [w, n + b.round(g - g * ((u - this.miny) / l))], q.push(p), h.push(p)); for (C = [], D = [], E = r.length, K = 0; E > K; K++) q = r[K], q.length && (a.get("fillColor") && (q.push([q[q.length - 1][0], n + g]), D.push(q.slice(0)), q.pop()), q.length > 2 && (q[0] = [q[0][0], q[1][1]]), C.push(q)); for (E = D.length, K = 0; E > K; K++) e.drawShape(D[K], a.get("fillColor"), a.get("fillColor")).append(); for (a.get("normalRangeMin") !== c && a.get("drawNormalOnTop") && this.drawNormalRange(o, n, g, f, l), E = C.length, K = 0; E > K; K++) e.drawShape(C[K], a.get("lineColor"), c, a.get("lineWidth")).append(); if (i && a.get("valueSpots")) for (F = a.get("valueSpots"), F.get === c && (F = new t(F)), K = 0; B > K; K++) H = F.get(J[K]), H && e.drawCircle(o + b.round((I[K] - this.minx) * (f / k)), n + b.round(g - g * ((J[K] - this.miny) / l)), i, c, H).append(); i && a.get("spotColor") && null !== J[m] && e.drawCircle(o + b.round((I[I.length - 1] - this.minx) * (f / k)), n + b.round(g - g * ((J[m] - this.miny) / l)), i, c, a.get("spotColor")).append(), this.maxy !== this.minyorg && (i && a.get("minSpotColor") && (s = I[d.inArray(this.minyorg, J)], e.drawCircle(o + b.round((s - this.minx) * (f / k)), n + b.round(g - g * ((this.minyorg - this.miny) / l)), i, c, a.get("minSpotColor")).append()), i && a.get("maxSpotColor") && (s = I[d.inArray(this.maxyorg, J)], e.drawCircle(o + b.round((s - this.minx) * (f / k)), n + b.round(g - g * ((this.maxyorg - this.miny) / l)), i, c, a.get("maxSpotColor")).append())), this.lastShapeId = e.getLastShapeId(), this.canvasTop = n, e.render() } }
        }), d.fn.sparkline.bar = y = g(d.fn.sparkline._base, w, { type: "bar", init: function (a, e, f, g, h) { var u, v, w, x, z, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, j = parseInt(f.get("barWidth"), 10), n = parseInt(f.get("barSpacing"), 10), o = f.get("chartRangeMin"), p = f.get("chartRangeMax"), q = f.get("chartRangeClip"), r = 1 / 0, s = -1 / 0; for (y._super.init.call(this, a, e, f, g, h), A = 0, B = e.length; B > A; A++) O = e[A], u = "string" == typeof O && O.indexOf(":") > -1, (u || d.isArray(O)) && (J = !0, u && (O = e[A] = l(O.split(":"))), O = m(O, null), v = b.min.apply(b, O), w = b.max.apply(b, O), r > v && (r = v), w > s && (s = w)); this.stacked = J, this.regionShapes = {}, this.barWidth = j, this.barSpacing = n, this.totalBarWidth = j + n, this.width = g = e.length * j + (e.length - 1) * n, this.initTarget(), q && (H = o === c ? -1 / 0 : o, I = p === c ? 1 / 0 : p), z = [], x = J ? [] : z; var S = [], T = []; for (A = 0, B = e.length; B > A; A++) if (J) for (K = e[A], e[A] = N = [], S[A] = 0, x[A] = T[A] = 0, L = 0, M = K.length; M > L; L++) O = N[L] = q ? i(K[L], H, I) : K[L], null !== O && (O > 0 && (S[A] += O), 0 > r && s > 0 ? 0 > O ? T[A] += b.abs(O) : x[A] += O : x[A] += b.abs(O - (0 > O ? s : r)), z.push(O)); else O = q ? i(e[A], H, I) : e[A], O = e[A] = k(O), null !== O && z.push(O); this.max = G = b.max.apply(b, z), this.min = F = b.min.apply(b, z), this.stackMax = s = J ? b.max.apply(b, S) : G, this.stackMin = r = J ? b.min.apply(b, z) : F, f.get("chartRangeMin") !== c && (f.get("chartRangeClip") || f.get("chartRangeMin") < F) && (F = f.get("chartRangeMin")), f.get("chartRangeMax") !== c && (f.get("chartRangeClip") || f.get("chartRangeMax") > G) && (G = f.get("chartRangeMax")), this.zeroAxis = D = f.get("zeroAxis", !0), E = 0 >= F && G >= 0 && D ? 0 : 0 == D ? F : F > 0 ? F : G, this.xaxisOffset = E, C = J ? b.max.apply(b, x) + b.max.apply(b, T) : G - F, this.canvasHeightEf = D && 0 > F ? this.canvasHeight - 2 : this.canvasHeight - 1, E > F ? (Q = J && G >= 0 ? s : G, P = (Q - E) / C * this.canvasHeight, P !== b.ceil(P) && (this.canvasHeightEf -= 2, P = b.ceil(P))) : P = this.canvasHeight, this.yoffset = P, d.isArray(f.get("colorMap")) ? (this.colorMapByIndex = f.get("colorMap"), this.colorMapByValue = null) : (this.colorMapByIndex = null, this.colorMapByValue = f.get("colorMap"), this.colorMapByValue && this.colorMapByValue.get === c && (this.colorMapByValue = new t(this.colorMapByValue))), this.range = C }, getRegion: function (a, d) { var f = b.floor(d / this.totalBarWidth); return 0 > f || f >= this.values.length ? c : f }, getCurrentRegionFields: function () { var d, e, a = this.currentRegion, b = r(this.values[a]), c = []; for (e = b.length; e--;) d = b[e], c.push({ isNull: null === d, value: d, color: this.calcColor(e, d, a), offset: a }); return c }, calcColor: function (a, b, e) { var i, j, f = this.colorMapByIndex, g = this.colorMapByValue, h = this.options; return i = h.get(this.stacked ? "stackedBarColor" : 0 > b ? "negBarColor" : "barColor"), 0 === b && h.get("zeroColor") !== c && (i = h.get("zeroColor")), g && (j = g.get(b)) ? i = j : f && f.length > e && (i = f[e]), d.isArray(i) ? i[a % i.length] : i }, renderRegion: function (a, e) { var q, r, s, t, u, v, w, x, y, z, f = this.values[a], g = this.options, h = this.xaxisOffset, i = [], j = this.range, k = this.stacked, l = this.target, m = a * this.totalBarWidth, n = this.canvasHeightEf, p = this.yoffset; if (f = d.isArray(f) ? f : [f], w = f.length, x = f[0], t = o(null, f), z = o(h, f, !0), t) return g.get("nullColor") ? (s = e ? g.get("nullColor") : this.calcHighlightColor(g.get("nullColor"), g), q = p > 0 ? p - 1 : p, l.drawRect(m, q, this.barWidth - 1, 0, s, s)) : c; for (u = p, v = 0; w > v; v++) { if (x = f[v], k && x === h) { if (!z || y) continue; y = !0 } r = j > 0 ? b.floor(n * (b.abs(x - h) / j)) + 1 : 1, h > x || x === h && 0 === p ? (q = u, u += r) : (q = p - r, p -= r), s = this.calcColor(v, x, a), e && (s = this.calcHighlightColor(s, g)), i.push(l.drawRect(m, q, this.barWidth - 1, r - 1, s, s)) } return 1 === i.length ? i[0] : i } }), d.fn.sparkline.tristate = z = g(d.fn.sparkline._base, w, { type: "tristate", init: function (a, b, e, f, g) { var h = parseInt(e.get("barWidth"), 10), i = parseInt(e.get("barSpacing"), 10); z._super.init.call(this, a, b, e, f, g), this.regionShapes = {}, this.barWidth = h, this.barSpacing = i, this.totalBarWidth = h + i, this.values = d.map(b, Number), this.width = f = b.length * h + (b.length - 1) * i, d.isArray(e.get("colorMap")) ? (this.colorMapByIndex = e.get("colorMap"), this.colorMapByValue = null) : (this.colorMapByIndex = null, this.colorMapByValue = e.get("colorMap"), this.colorMapByValue && this.colorMapByValue.get === c && (this.colorMapByValue = new t(this.colorMapByValue))), this.initTarget() }, getRegion: function (a, c) { return b.floor(c / this.totalBarWidth) }, getCurrentRegionFields: function () { var a = this.currentRegion; return { isNull: this.values[a] === c, value: this.values[a], color: this.calcColor(this.values[a], a), offset: a } }, calcColor: function (a, b) { var g, h, c = this.values, d = this.options, e = this.colorMapByIndex, f = this.colorMapByValue; return g = f && (h = f.get(a)) ? h : e && e.length > b ? e[b] : d.get(c[b] < 0 ? "negBarColor" : c[b] > 0 ? "posBarColor" : "zeroBarColor") }, renderRegion: function (a, c) { var g, h, i, j, k, l, d = this.values, e = this.options, f = this.target; return g = f.pixelHeight, i = b.round(g / 2), j = a * this.totalBarWidth, d[a] < 0 ? (k = i, h = i - 1) : d[a] > 0 ? (k = 0, h = i - 1) : (k = i - 1, h = 2), l = this.calcColor(d[a], a), null !== l ? (c && (l = this.calcHighlightColor(l, e)), f.drawRect(j, k, this.barWidth - 1, h - 1, l, l)) : void 0 } }), d.fn.sparkline.discrete = A = g(d.fn.sparkline._base, w, { type: "discrete", init: function (a, e, f, g, h) { A._super.init.call(this, a, e, f, g, h), this.regionShapes = {}, this.values = e = d.map(e, Number), this.min = b.min.apply(b, e), this.max = b.max.apply(b, e), this.range = this.max - this.min, this.width = g = "auto" === f.get("width") ? 2 * e.length : this.width, this.interval = b.floor(g / e.length), this.itemWidth = g / e.length, f.get("chartRangeMin") !== c && (f.get("chartRangeClip") || f.get("chartRangeMin") < this.min) && (this.min = f.get("chartRangeMin")), f.get("chartRangeMax") !== c && (f.get("chartRangeClip") || f.get("chartRangeMax") > this.max) && (this.max = f.get("chartRangeMax")), this.initTarget(), this.target && (this.lineHeight = "auto" === f.get("lineHeight") ? b.round(.3 * this.canvasHeight) : f.get("lineHeight")) }, getRegion: function (a, c) { return b.floor(c / this.itemWidth) }, getCurrentRegionFields: function () { var a = this.currentRegion; return { isNull: this.values[a] === c, value: this.values[a], offset: a } }, renderRegion: function (a, c) { var o, p, q, r, d = this.values, e = this.options, f = this.min, g = this.max, h = this.range, j = this.interval, k = this.target, l = this.canvasHeight, m = this.lineHeight, n = l - m; return p = i(d[a], f, g), r = a * j, o = b.round(n - n * ((p - f) / h)), q = e.get(e.get("thresholdColor") && p < e.get("thresholdValue") ? "thresholdColor" : "lineColor"), c && (q = this.calcHighlightColor(q, e)), k.drawLine(r, o, r, o + m, q) } }), d.fn.sparkline.bullet = B = g(d.fn.sparkline._base, { type: "bullet", init: function (a, d, e, f, g) { var h, i, j; B._super.init.call(this, a, d, e, f, g), this.values = d = l(d), j = d.slice(), j[0] = null === j[0] ? j[2] : j[0], j[1] = null === d[1] ? j[2] : j[1], h = b.min.apply(b, d), i = b.max.apply(b, d), h = e.get("base") === c ? 0 > h ? h : 0 : e.get("base"), this.min = h, this.max = i, this.range = i - h, this.shapes = {}, this.valueShapes = {}, this.regiondata = {}, this.width = f = "auto" === e.get("width") ? "4.0em" : f, this.target = this.$el.simpledraw(f, g, e.get("composite")), d.length || (this.disabled = !0), this.initTarget() }, getRegion: function (a, b, d) { var e = this.target.getShapeAt(a, b, d); return e !== c && this.shapes[e] !== c ? this.shapes[e] : c }, getCurrentRegionFields: function () { var a = this.currentRegion; return { fieldkey: a.substr(0, 1), value: this.values[a.substr(1)], region: a } }, changeHighlight: function (a) { var d, b = this.currentRegion, c = this.valueShapes[b]; switch (delete this.shapes[c], b.substr(0, 1)) { case "r": d = this.renderRange(b.substr(1), a); break; case "p": d = this.renderPerformance(a); break; case "t": d = this.renderTarget(a) } this.valueShapes[b] = d.id, this.shapes[d.id] = b, this.target.replaceWithShape(c, d) }, renderRange: function (a, c) { var d = this.values[a], e = b.round(this.canvasWidth * ((d - this.min) / this.range)), f = this.options.get("rangeColors")[a - 2]; return c && (f = this.calcHighlightColor(f, this.options)), this.target.drawRect(0, 0, e - 1, this.canvasHeight - 1, f, f) }, renderPerformance: function (a) { var c = this.values[1], d = b.round(this.canvasWidth * ((c - this.min) / this.range)), e = this.options.get("performanceColor"); return a && (e = this.calcHighlightColor(e, this.options)), this.target.drawRect(0, b.round(.3 * this.canvasHeight), d - 1, b.round(.4 * this.canvasHeight) - 1, e, e) }, renderTarget: function (a) { var c = this.values[0], d = b.round(this.canvasWidth * ((c - this.min) / this.range) - this.options.get("targetWidth") / 2), e = b.round(.1 * this.canvasHeight), f = this.canvasHeight - 2 * e, g = this.options.get("targetColor"); return a && (g = this.calcHighlightColor(g, this.options)), this.target.drawRect(d, e, this.options.get("targetWidth") - 1, f - 1, g, g) }, render: function () { var c, d, a = this.values.length, b = this.target; if (B._super.render.call(this)) { for (c = 2; a > c; c++) d = this.renderRange(c).append(), this.shapes[d.id] = "r" + c, this.valueShapes["r" + c] = d.id; null !== this.values[1] && (d = this.renderPerformance().append(), this.shapes[d.id] = "p1", this.valueShapes.p1 = d.id), null !== this.values[0] && (d = this.renderTarget().append(), this.shapes[d.id] = "t0", this.valueShapes.t0 = d.id), b.render() } } }), d.fn.sparkline.pie = C = g(d.fn.sparkline._base, { type: "pie", init: function (a, c, e, f, g) { var i, h = 0; if (C._super.init.call(this, a, c, e, f, g), this.shapes = {}, this.valueShapes = {}, this.values = c = d.map(c, Number), "auto" === e.get("width") && (this.width = this.height), c.length > 0) for (i = c.length; i--;) h += c[i]; this.total = h, this.initTarget(), this.radius = b.floor(b.min(this.canvasWidth, this.canvasHeight) / 2) }, getRegion: function (a, b, d) { var e = this.target.getShapeAt(a, b, d); return e !== c && this.shapes[e] !== c ? this.shapes[e] : c }, getCurrentRegionFields: function () { var a = this.currentRegion; return { isNull: this.values[a] === c, value: this.values[a], percent: this.values[a] / this.total * 100, color: this.options.get("sliceColors")[a % this.options.get("sliceColors").length], offset: a } }, changeHighlight: function (a) { var b = this.currentRegion, c = this.renderSlice(b, a), d = this.valueShapes[b]; delete this.shapes[d], this.target.replaceWithShape(d, c), this.valueShapes[b] = c.id, this.shapes[c.id] = b }, renderSlice: function (a, d) { var n, o, p, q, r, e = this.target, f = this.options, g = this.radius, h = f.get("borderWidth"), i = f.get("offset"), j = 2 * b.PI, k = this.values, l = this.total, m = i ? 2 * b.PI * (i / 360) : 0; for (q = k.length, p = 0; q > p; p++) { if (n = m, o = m, l > 0 && (o = m + j * (k[p] / l)), a === p) return r = f.get("sliceColors")[p % f.get("sliceColors").length], d && (r = this.calcHighlightColor(r, f)), e.drawPieSlice(g, g, g - h, n, o, c, r); m = o } }, render: function () { var h, i, a = this.target, d = this.values, e = this.options, f = this.radius, g = e.get("borderWidth"); if (C._super.render.call(this)) { for (g && a.drawCircle(f, f, b.floor(f - g / 2), e.get("borderColor"), c, g).append(), i = d.length; i--;) d[i] && (h = this.renderSlice(i).append(), this.valueShapes[i] = h.id, this.shapes[h.id] = i); a.render() } } }), d.fn.sparkline.box = D = g(d.fn.sparkline._base, { type: "box", init: function (a, b, c, e, f) { D._super.init.call(this, a, b, c, e, f), this.values = d.map(b, Number), this.width = "auto" === c.get("width") ? "4.0em" : e, this.initTarget(), this.values.length || (this.disabled = 1) }, getRegion: function () { return 1 }, getCurrentRegionFields: function () { var a = [{ field: "lq", value: this.quartiles[0] }, { field: "med", value: this.quartiles[1] }, { field: "uq", value: this.quartiles[2] }]; return this.loutlier !== c && a.push({ field: "lo", value: this.loutlier }), this.routlier !== c && a.push({ field: "ro", value: this.routlier }), this.lwhisker !== c && a.push({ field: "lw", value: this.lwhisker }), this.rwhisker !== c && a.push({ field: "rw", value: this.rwhisker }), a }, render: function () { var m, n, o, p, q, r, s, t, u, v, w, a = this.target, d = this.values, e = d.length, f = this.options, g = this.canvasWidth, h = this.canvasHeight, i = f.get("chartRangeMin") === c ? b.min.apply(b, d) : f.get("chartRangeMin"), k = f.get("chartRangeMax") === c ? b.max.apply(b, d) : f.get("chartRangeMax"), l = 0; if (D._super.render.call(this)) { if (f.get("raw")) f.get("showOutliers") && d.length > 5 ? (n = d[0], m = d[1], p = d[2], q = d[3], r = d[4], s = d[5], t = d[6]) : (m = d[0], p = d[1], q = d[2], r = d[3], s = d[4]); else if (d.sort(function (a, b) { return a - b }), p = j(d, 1), q = j(d, 2), r = j(d, 3), o = r - p, f.get("showOutliers")) { for (m = s = c, u = 0; e > u; u++) m === c && d[u] > p - o * f.get("outlierIQR") && (m = d[u]), d[u] < r + o * f.get("outlierIQR") && (s = d[u]); n = d[0], t = d[e - 1] } else m = d[0], s = d[e - 1]; this.quartiles = [p, q, r], this.lwhisker = m, this.rwhisker = s, this.loutlier = n, this.routlier = t, w = g / (k - i + 1), f.get("showOutliers") && (l = b.ceil(f.get("spotRadius")), g -= 2 * b.ceil(f.get("spotRadius")), w = g / (k - i + 1), m > n && a.drawCircle((n - i) * w + l, h / 2, f.get("spotRadius"), f.get("outlierLineColor"), f.get("outlierFillColor")).append(), t > s && a.drawCircle((t - i) * w + l, h / 2, f.get("spotRadius"), f.get("outlierLineColor"), f.get("outlierFillColor")).append()), a.drawRect(b.round((p - i) * w + l), b.round(.1 * h), b.round((r - p) * w), b.round(.8 * h), f.get("boxLineColor"), f.get("boxFillColor")).append(), a.drawLine(b.round((m - i) * w + l), b.round(h / 2), b.round((p - i) * w + l), b.round(h / 2), f.get("lineColor")).append(), a.drawLine(b.round((m - i) * w + l), b.round(h / 4), b.round((m - i) * w + l), b.round(h - h / 4), f.get("whiskerColor")).append(), a.drawLine(b.round((s - i) * w + l), b.round(h / 2), b.round((r - i) * w + l), b.round(h / 2), f.get("lineColor")).append(), a.drawLine(b.round((s - i) * w + l), b.round(h / 4), b.round((s - i) * w + l), b.round(h - h / 4), f.get("whiskerColor")).append(), a.drawLine(b.round((q - i) * w + l), b.round(.1 * h), b.round((q - i) * w + l), b.round(.9 * h), f.get("medianColor")).append(), f.get("target") && (v = b.ceil(f.get("spotRadius")), a.drawLine(b.round((f.get("target") - i) * w + l), b.round(h / 2 - v), b.round((f.get("target") - i) * w + l), b.round(h / 2 + v), f.get("targetColor")).append(), a.drawLine(b.round((f.get("target") - i) * w + l - v), b.round(h / 2), b.round((f.get("target") - i) * w + l + v), b.round(h / 2), f.get("targetColor")).append()), a.render() } } }), G = g({ init: function (a, b, c, d) { this.target = a, this.id = b, this.type = c, this.args = d }, append: function () { return this.target.appendShape(this), this } }), H = g({ _pxregex: /(\d+)(px)?\s*$/i, init: function (a, b, c) { a && (this.width = a, this.height = b, this.target = c, this.lastShapeId = null, c[0] && (c = c[0]), d.data(c, "_jqs_vcanvas", this)) }, drawLine: function (a, b, c, d, e, f) { return this.drawShape([[a, b], [c, d]], e, f) }, drawShape: function (a, b, c, d) { return this._genShape("Shape", [a, b, c, d]) }, drawCircle: function (a, b, c, d, e, f) { return this._genShape("Circle", [a, b, c, d, e, f]) }, drawPieSlice: function (a, b, c, d, e, f, g) { return this._genShape("PieSlice", [a, b, c, d, e, f, g]) }, drawRect: function (a, b, c, d, e, f) { return this._genShape("Rect", [a, b, c, d, e, f]) }, getElement: function () { return this.canvas }, getLastShapeId: function () { return this.lastShapeId }, reset: function () { alert("reset not implemented") }, _insert: function (a, b) { d(b).html(a) }, _calculatePixelDims: function (a, b, c) { var e; e = this._pxregex.exec(b), this.pixelHeight = e ? e[1] : d(c).height(), e = this._pxregex.exec(a), this.pixelWidth = e ? e[1] : d(c).width() }, _genShape: function (a, b) { var c = L++; return b.unshift(c), new G(this, c, a, b) }, appendShape: function () { alert("appendShape not implemented") }, replaceWithShape: function () { alert("replaceWithShape not implemented") }, insertAfterShape: function () { alert("insertAfterShape not implemented") }, removeShapeId: function () { alert("removeShapeId not implemented") }, getShapeAt: function () { alert("getShapeAt not implemented") }, render: function () { alert("render not implemented") } }), I = g(H, { init: function (b, e, f, g) { I._super.init.call(this, b, e, f), this.canvas = a.createElement("canvas"), f[0] && (f = f[0]), d.data(f, "_jqs_vcanvas", this), d(this.canvas).css({ display: "inline-block", width: b, height: e, verticalAlign: "top" }), this._insert(this.canvas, f), this._calculatePixelDims(b, e, this.canvas), this.canvas.width = this.pixelWidth, this.canvas.height = this.pixelHeight, this.interact = g, this.shapes = {}, this.shapeseq = [], this.currentTargetShapeId = c, d(this.canvas).css({ width: this.pixelWidth, height: this.pixelHeight }) }, _getContext: function (a, b, d) { var e = this.canvas.getContext("2d"); return a !== c && (e.strokeStyle = a), e.lineWidth = d === c ? 1 : d, b !== c && (e.fillStyle = b), e }, reset: function () { var a = this._getContext(); a.clearRect(0, 0, this.pixelWidth, this.pixelHeight), this.shapes = {}, this.shapeseq = [], this.currentTargetShapeId = c }, _drawShape: function (a, b, d, e, f) { var h, i, g = this._getContext(d, e, f); for (g.beginPath(), g.moveTo(b[0][0] + .5, b[0][1] + .5), h = 1, i = b.length; i > h; h++) g.lineTo(b[h][0] + .5, b[h][1] + .5); d !== c && g.stroke(), e !== c && g.fill(), this.targetX !== c && this.targetY !== c && g.isPointInPath(this.targetX, this.targetY) && (this.currentTargetShapeId = a) }, _drawCircle: function (a, d, e, f, g, h, i) { var j = this._getContext(g, h, i); j.beginPath(), j.arc(d, e, f, 0, 2 * b.PI, !1), this.targetX !== c && this.targetY !== c && j.isPointInPath(this.targetX, this.targetY) && (this.currentTargetShapeId = a), g !== c && j.stroke(), h !== c && j.fill() }, _drawPieSlice: function (a, b, d, e, f, g, h, i) { var j = this._getContext(h, i); j.beginPath(), j.moveTo(b, d), j.arc(b, d, e, f, g, !1), j.lineTo(b, d), j.closePath(), h !== c && j.stroke(), i && j.fill(), this.targetX !== c && this.targetY !== c && j.isPointInPath(this.targetX, this.targetY) && (this.currentTargetShapeId = a) }, _drawRect: function (a, b, c, d, e, f, g) { return this._drawShape(a, [[b, c], [b + d, c], [b + d, c + e], [b, c + e], [b, c]], f, g) }, appendShape: function (a) { return this.shapes[a.id] = a, this.shapeseq.push(a.id), this.lastShapeId = a.id, a.id }, replaceWithShape: function (a, b) { var d, c = this.shapeseq; for (this.shapes[b.id] = b, d = c.length; d--;) c[d] == a && (c[d] = b.id); delete this.shapes[a] }, replaceWithShapes: function (a, b) { var e, f, g, c = this.shapeseq, d = {}; for (f = a.length; f--;) d[a[f]] = !0; for (f = c.length; f--;) e = c[f], d[e] && (c.splice(f, 1), delete this.shapes[e], g = f); for (f = b.length; f--;) c.splice(g, 0, b[f].id), this.shapes[b[f].id] = b[f] }, insertAfterShape: function (a, b) { var d, c = this.shapeseq; for (d = c.length; d--;) if (c[d] === a) return c.splice(d + 1, 0, b.id), void (this.shapes[b.id] = b) }, removeShapeId: function (a) { var c, b = this.shapeseq; for (c = b.length; c--;) if (b[c] === a) { b.splice(c, 1); break } delete this.shapes[a] }, getShapeAt: function (a, b, c) { return this.targetX = b, this.targetY = c, this.render(), this.currentTargetShapeId }, render: function () { var e, f, g, a = this.shapeseq, b = this.shapes, c = a.length, d = this._getContext(); for (d.clearRect(0, 0, this.pixelWidth, this.pixelHeight), g = 0; c > g; g++) e = a[g], f = b[e], this["_draw" + f.type].apply(this, f.args); this.interact || (this.shapes = {}, this.shapeseq = []) } }), J = g(H, { init: function (b, c, e) { var f; J._super.init.call(this, b, c, e), e[0] && (e = e[0]), d.data(e, "_jqs_vcanvas", this), this.canvas = a.createElement("span"), d(this.canvas).css({ display: "inline-block", position: "relative", overflow: "hidden", width: b, height: c, margin: "0px", padding: "0px", verticalAlign: "top" }), this._insert(this.canvas, e), this._calculatePixelDims(b, c, this.canvas), this.canvas.width = this.pixelWidth, this.canvas.height = this.pixelHeight, f = '<v:group coordorigin="0 0" coordsize="' + this.pixelWidth + " " + this.pixelHeight + '" style="position:absolute;top:0;left:0;width:' + this.pixelWidth + "px;height=" + this.pixelHeight + 'px;"></v:group>', this.canvas.insertAdjacentHTML("beforeEnd", f), this.group = d(this.canvas).children()[0], this.rendered = !1, this.prerender = "" }, _drawShape: function (a, b, d, e, f) { var h, i, j, k, l, m, n, g = []; for (n = 0, m = b.length; m > n; n++) g[n] = "" + b[n][0] + "," + b[n][1]; return h = g.splice(0, 1), f = f === c ? 1 : f, i = d === c ? ' stroked="false" ' : ' strokeWeight="' + f + 'px" strokeColor="' + d + '" ', j = e === c ? ' filled="false"' : ' fillColor="' + e + '" filled="true" ', k = g[0] === g[g.length - 1] ? "x " : "", l = '<v:shape coordorigin="0 0" coordsize="' + this.pixelWidth + " " + this.pixelHeight + '"  id="jqsshape' + a + '" ' + i + j + ' style="position:absolute;left:0px;top:0px;height:' + this.pixelHeight + "px;width:" + this.pixelWidth + 'px;padding:0px;margin:0px;"  path="m ' + h + " l " + g.join(", ") + " " + k + 'e"> </v:shape>' }, _drawCircle: function (a, b, d, e, f, g, h) { var i, j, k; return b -= e, d -= e, i = f === c ? ' stroked="false" ' : ' strokeWeight="' + h + 'px" strokeColor="' + f + '" ', j = g === c ? ' filled="false"' : ' fillColor="' + g + '" filled="true" ', k = '<v:oval  id="jqsshape' + a + '" ' + i + j + ' style="position:absolute;top:' + d + "px; left:" + b + "px; width:" + 2 * e + "px; height:" + 2 * e + 'px"></v:oval>' }, _drawPieSlice: function (a, d, e, f, g, h, i, j) { var k, l, m, n, o, p, q, r; if (g === h) return ""; if (h - g === 2 * b.PI && (g = 0, h = 2 * b.PI), l = d + b.round(b.cos(g) * f), m = e + b.round(b.sin(g) * f), n = d + b.round(b.cos(h) * f), o = e + b.round(b.sin(h) * f), l === n && m === o) { if (h - g < b.PI) return ""; l = n = d + f, m = o = e } return l === n && m === o && h - g < b.PI ? "" : (k = [d - f, e - f, d + f, e + f, l, m, n, o], p = i === c ? ' stroked="false" ' : ' strokeWeight="1px" strokeColor="' + i + '" ', q = j === c ? ' filled="false"' : ' fillColor="' + j + '" filled="true" ', r = '<v:shape coordorigin="0 0" coordsize="' + this.pixelWidth + " " + this.pixelHeight + '"  id="jqsshape' + a + '" ' + p + q + ' style="position:absolute;left:0px;top:0px;height:' + this.pixelHeight + "px;width:" + this.pixelWidth + 'px;padding:0px;margin:0px;"  path="m ' + d + "," + e + " wa " + k.join(", ") + ' x e"> </v:shape>') }, _drawRect: function (a, b, c, d, e, f, g) { return this._drawShape(a, [[b, c], [b, c + e], [b + d, c + e], [b + d, c], [b, c]], f, g) }, reset: function () { this.group.innerHTML = "" }, appendShape: function (a) { var b = this["_draw" + a.type].apply(this, a.args); return this.rendered ? this.group.insertAdjacentHTML("beforeEnd", b) : this.prerender += b, this.lastShapeId = a.id, a.id }, replaceWithShape: function (a, b) { var c = d("#jqsshape" + a), e = this["_draw" + b.type].apply(this, b.args); c[0].outerHTML = e }, replaceWithShapes: function (a, b) { var g, c = d("#jqsshape" + a[0]), e = "", f = b.length; for (g = 0; f > g; g++) e += this["_draw" + b[g].type].apply(this, b[g].args); for (c[0].outerHTML = e, g = 1; g < a.length; g++) d("#jqsshape" + a[g]).remove() }, insertAfterShape: function (a, b) { var c = d("#jqsshape" + a), e = this["_draw" + b.type].apply(this, b.args); c[0].insertAdjacentHTML("afterEnd", e) }, removeShapeId: function (a) { var b = d("#jqsshape" + a); this.group.removeChild(b[0]) }, getShapeAt: function (a) { var d = a.id.substr(8); return d }, render: function () { this.rendered || (this.group.innerHTML = this.prerender, this.rendered = !0) } })
    })
}(document, Math),
$(document).ready(function () {
    function splitTable(original) {
        original.wrap("<div class='table-wrapper' />");
        var copy = original.clone();
        copy.find("td:not(:first-child), th:not(:first-child)").css("display", "none"),
        copy.removeClass("responsive"),
        original.closest(".table-wrapper").append(copy),
        copy.wrap("<div class='pinned' />"),
        original.wrap("<div class='scrollable' />"),
        setCellHeights(original, copy)
    }
    function unsplitTable(original) {
        original.closest(".table-wrapper").find(".pinned").remove(),
        original.unwrap(),
        original.unwrap()
    }
    function setCellHeights(original, copy) {
        var tr = original.find("tr"),
            tr_copy = copy.find("tr"),
            heights = [];
        tr.each(function (index) {
            var self = $(this),
                tx = self.find("th, td");
            tx.each(function () {
                var height = $(this).outerHeight(!0);
                heights[index] = heights[index] || 0, height > heights[index] && (heights[index] = height)
            })
        }),
        tr_copy.each(function (index) {
            $(this).height(heights[index])
        })
    }
    var switched = !1,
        updateTables = function () {
            return $(window).width() < 767 && !switched ? (switched = !0, $("table.responsive").each(function (i, element) { splitTable($(element)) }), !0) : void (switched && $(window).width() > 767 && (switched = !1, $("table.responsive").each(function (i, element) { unsplitTable($(element)) })))
        };
    $(window).load(updateTables),
    $(window).on("redraw", function () { switched = !1, updateTables() }), $(window).on("resize", updateTables)
}),
function (global) {
    "use strict";
    function circle(ctx, x, y, r) { ctx.beginPath(), ctx.arc(x, y, r, 0, TAU, !1), ctx.fill() } function line(ctx, ax, ay, bx, by) { ctx.beginPath(), ctx.moveTo(ax, ay), ctx.lineTo(bx, by), ctx.stroke() } function puff(ctx, t, cx, cy, rx, ry, rmin, rmax) { var c = Math.cos(t * TAU), s = Math.sin(t * TAU); rmax -= rmin, circle(ctx, cx - s * rx, cy + c * ry + .5 * rmax, rmin + (1 - .5 * c) * rmax) } function puffs(ctx, t, cx, cy, rx, ry, rmin, rmax) { var i; for (i = 5; i--;) puff(ctx, t + i / 5, cx, cy, rx, ry, rmin, rmax) } function cloud(ctx, t, cx, cy, cw, s, color) { t /= 3e4; var a = .21 * cw, b = .12 * cw, c = .24 * cw, d = .28 * cw; ctx.fillStyle = color, puffs(ctx, t, cx, cy, a, b, c, d), ctx.globalCompositeOperation = "destination-out", puffs(ctx, t, cx, cy, a, b, c - s, d - s), ctx.globalCompositeOperation = "source-over" } function sun(ctx, t, cx, cy, cw, s, color) { t /= 12e4; var i, p, cos, sin, a = .25 * cw - .5 * s, b = .32 * cw + .5 * s, c = .5 * cw - .5 * s; for (ctx.strokeStyle = color, ctx.lineWidth = s, ctx.lineCap = "round", ctx.lineJoin = "round", ctx.beginPath(), ctx.arc(cx, cy, a, 0, TAU, !1), ctx.stroke(), i = 8; i--;) p = (t + i / 8) * TAU, cos = Math.cos(p), sin = Math.sin(p), line(ctx, cx + cos * b, cy + sin * b, cx + cos * c, cy + sin * c) } function moon(ctx, t, cx, cy, cw, s, color) { t /= 15e3; var a = .29 * cw - .5 * s, b = .05 * cw, c = Math.cos(t * TAU), p = c * TAU / -16; ctx.strokeStyle = color, ctx.lineWidth = s, ctx.lineCap = "round", ctx.lineJoin = "round", cx += c * b, ctx.beginPath(), ctx.arc(cx, cy, a, p + TAU / 8, p + 7 * TAU / 8, !1), ctx.arc(cx + Math.cos(p) * a * TWO_OVER_SQRT_2, cy + Math.sin(p) * a * TWO_OVER_SQRT_2, a, p + 5 * TAU / 8, p + 3 * TAU / 8, !0), ctx.closePath(), ctx.stroke() } function rain(ctx, t, cx, cy, cw, s, color) { t /= 1350; var i, p, x, y, a = .16 * cw, b = 11 * TAU / 12, c = 7 * TAU / 12; for (ctx.fillStyle = color, i = 4; i--;) p = (t + i / 4) % 1, x = cx + (i - 1.5) / 1.5 * (1 === i || 2 === i ? -1 : 1) * a, y = cy + p * p * cw, ctx.beginPath(), ctx.moveTo(x, y - 1.5 * s), ctx.arc(x, y, .75 * s, b, c, !1), ctx.fill() } function sleet(ctx, t, cx, cy, cw, s, color) { t /= 750; var i, p, x, y, a = .1875 * cw; for (ctx.strokeStyle = color, ctx.lineWidth = .5 * s, ctx.lineCap = "round", ctx.lineJoin = "round", i = 4; i--;) p = (t + i / 4) % 1, x = Math.floor(cx + (i - 1.5) / 1.5 * (1 === i || 2 === i ? -1 : 1) * a) + .5, y = cy + p * cw, line(ctx, x, y - 1.5 * s, x, y + 1.5 * s) } function snow(ctx, t, cx, cy, cw, s, color) { t /= 3e3; var i, p, x, y, a = .16 * cw, b = .75 * s, u = t * TAU * .7, ux = Math.cos(u) * b, uy = Math.sin(u) * b, v = u + TAU / 3, vx = Math.cos(v) * b, vy = Math.sin(v) * b, w = u + 2 * TAU / 3, wx = Math.cos(w) * b, wy = Math.sin(w) * b; for (ctx.strokeStyle = color, ctx.lineWidth = .5 * s, ctx.lineCap = "round", ctx.lineJoin = "round", i = 4; i--;) p = (t + i / 4) % 1, x = cx + Math.sin((p + i / 4) * TAU) * a, y = cy + p * cw, line(ctx, x - ux, y - uy, x + ux, y + uy), line(ctx, x - vx, y - vy, x + vx, y + vy), line(ctx, x - wx, y - wy, x + wx, y + wy) } function fogbank(ctx, t, cx, cy, cw, s, color) { t /= 3e4; var a = .21 * cw, b = .06 * cw, c = .21 * cw, d = .28 * cw; ctx.fillStyle = color, puffs(ctx, t, cx, cy, a, b, c, d), ctx.globalCompositeOperation = "destination-out", puffs(ctx, t, cx, cy, a, b, c - s, d - s), ctx.globalCompositeOperation = "source-over" } function leaf(ctx, t, x, y, cw, s, color) { var a = cw / 8, b = a / 3, c = 2 * b, d = t % 1 * TAU, e = Math.cos(d), f = Math.sin(d); ctx.fillStyle = color, ctx.strokeStyle = color, ctx.lineWidth = s, ctx.lineCap = "round", ctx.lineJoin = "round", ctx.beginPath(), ctx.arc(x, y, a, d, d + Math.PI, !1), ctx.arc(x - b * e, y - b * f, c, d + Math.PI, d, !1), ctx.arc(x + c * e, y + c * f, b, d + Math.PI, d, !0), ctx.globalCompositeOperation = "destination-out", ctx.fill(), ctx.globalCompositeOperation = "source-over", ctx.stroke() } function swoosh(ctx, t, cx, cy, cw, s, index, total, color) { t /= 2500; var b, d, f, i, path = WIND_PATHS[index], a = (t + index - WIND_OFFSETS[index].start) % total, c = (t + index - WIND_OFFSETS[index].end) % total, e = (t + index) % total; if (ctx.strokeStyle = color, ctx.lineWidth = s, ctx.lineCap = "round", ctx.lineJoin = "round", 1 > a) { if (ctx.beginPath(), a *= path.length / 2 - 1, b = Math.floor(a), a -= b, b *= 2, b += 2, ctx.moveTo(cx + (path[b - 2] * (1 - a) + path[b] * a) * cw, cy + (path[b - 1] * (1 - a) + path[b + 1] * a) * cw), 1 > c) { for (c *= path.length / 2 - 1, d = Math.floor(c), c -= d, d *= 2, d += 2, i = b; i !== d; i += 2) ctx.lineTo(cx + path[i] * cw, cy + path[i + 1] * cw); ctx.lineTo(cx + (path[d - 2] * (1 - c) + path[d] * c) * cw, cy + (path[d - 1] * (1 - c) + path[d + 1] * c) * cw) } else for (i = b; i !== path.length; i += 2) ctx.lineTo(cx + path[i] * cw, cy + path[i + 1] * cw); ctx.stroke() } else if (1 > c) { for (ctx.beginPath(), c *= path.length / 2 - 1, d = Math.floor(c), c -= d, d *= 2, d += 2, ctx.moveTo(cx + path[0] * cw, cy + path[1] * cw), i = 2; i !== d; i += 2) ctx.lineTo(cx + path[i] * cw, cy + path[i + 1] * cw); ctx.lineTo(cx + (path[d - 2] * (1 - c) + path[d] * c) * cw, cy + (path[d - 1] * (1 - c) + path[d + 1] * c) * cw), ctx.stroke() } 1 > e && (e *= path.length / 2 - 1, f = Math.floor(e), e -= f, f *= 2, f += 2, leaf(ctx, t, cx + (path[f - 2] * (1 - e) + path[f] * e) * cw, cy + (path[f - 1] * (1 - e) + path[f + 1] * e) * cw, cw, s, color)) } var requestInterval, cancelInterval; !function () { var raf = global.requestAnimationFrame || global.webkitRequestAnimationFrame || global.mozRequestAnimationFrame || global.oRequestAnimationFrame || global.msRequestAnimationFrame, caf = global.cancelAnimationFrame || global.webkitCancelAnimationFrame || global.mozCancelAnimationFrame || global.oCancelAnimationFrame || global.msCancelAnimationFrame; raf && caf ? (requestInterval = function (fn) { function loop() { handle.value = raf(loop), fn() } var handle = { value: null }; return loop(), handle }, cancelInterval = function (handle) { caf(handle.value) }) : (requestInterval = setInterval, cancelInterval = clearInterval) }(); var KEYFRAME = 500, STROKE = .08, TAU = 2 * Math.PI, TWO_OVER_SQRT_2 = 2 / Math.sqrt(2), WIND_PATHS = [[-.75, -.18, -.7219, -.1527, -.6971, -.1225, -.6739, -.091, -.6516, -.0588, -.6298, -.0262, -.6083, .0065, -.5868, .0396, -.5643, .0731, -.5372, .1041, -.5033, .1259, -.4662, .1406, -.4275, .1493, -.3881, .153, -.3487, .1526, -.3095, .1488, -.2708, .1421, -.2319, .1342, -.1943, .1217, -.16, .1025, -.129, .0785, -.1012, .0509, -.0764, .0206, -.0547, -.012, -.0378, -.0472, -.0324, -.0857, -.0389, -.1241, -.0546, -.1599, -.0814, -.1876, -.1193, -.1964, -.1582, -.1935, -.1931, -.1769, -.2157, -.1453, -.229, -.1085, -.2327, -.0697, -.224, -.0317, -.2064, .0033, -.1853, .0362, -.1613, .0672, -.135, .0961, -.1051, .1213, -.0706, .1397, -.0332, .1512, .0053, .158, .0442, .1624, .0833, .1636, .1224, .1615, .1613, .1565, .1999, .15, .2378, .1402, .2749, .1279, .3118, .1147, .3487, .1015, .3858, .0892, .4236, .0787, .4621, .0715, .5012, .0702, .5398, .0766, .5768, .089, .6123, .1055, .6466, .1244, .6805, .144, .7147, .163, .75, .18], [-.75, 0, -.7033, .0195, -.6569, .0399, -.6104, .06, -.5634, .0789, -.5155, .0954, -.4667, .1089, -.4174, .1206, -.3676, .1299, -.3174, .1365, -.2669, .1398, -.2162, .1391, -.1658, .1347, -.1157, .1271, -.0661, .1169, -.017, .1046, .0316, .0903, .0791, .0728, .1259, .0534, .1723, .0331, .2188, .0129, .2656, -.0064, .3122, -.0263, .3586, -.0466, .4052, -.0665, .4525, -.0847, .5007, -.1002, .5497, -.113, .5991, -.124, .6491, -.1325, .6994, -.138, .75, -.14]], WIND_OFFSETS = [{ start: .36, end: .11 }, { start: .56, end: .16 }], Skycons = function (opts) {
        this.list = [], this.interval = null, this.color = opts && opts.color ? opts.color : "black", this.resizeClear = !(!opts || !opts.resizeClear)
    };
    Skycons.CLEAR_DAY = function (ctx, t, color) {
        var w = ctx.canvas.width,
            h = ctx.canvas.height,
            s = Math.min(w, h);
        sun(ctx, t, .5 * w, .5 * h, s, s * STROKE, color)
    },
        Skycons.CLEAR_NIGHT = function (ctx, t, color) {
            var w = ctx.canvas.width,
                h = ctx.canvas.height,
                s = Math.min(w, h);
            moon(ctx, t, .5 * w, .5 * h, s, s * STROKE, color)
        },
        Skycons.PARTLY_CLOUDY_DAY = function (ctx, t, color) {
            var w = ctx.canvas.width,
                h = ctx.canvas.height,
                s = Math.min(w, h);
            sun(ctx, t, .625 * w, .375 * h, .75 * s, s * STROKE, color),
            cloud(ctx, t, .375 * w, .625 * h, .75 * s, s * STROKE, color)
        }, Skycons.PARTLY_CLOUDY_NIGHT = function (ctx, t, color) {
            var w = ctx.canvas.width,
                h = ctx.canvas.height,
                s = Math.min(w, h);
            moon(ctx, t, .667 * w, .375 * h, .75 * s, s * STROKE, color),
            cloud(ctx, t, .375 * w, .625 * h, .75 * s, s * STROKE, color)
        },
        Skycons.CLOUDY = function (ctx, t, color) {
            var w = ctx.canvas.width,
                h = ctx.canvas.height,
                s = Math.min(w, h);
            cloud(ctx, t, .5 * w, .5 * h, s, s * STROKE, color)
        },
        Skycons.RAIN = function (ctx, t, color) {
            var w = ctx.canvas.width,
                h = ctx.canvas.height,
                s = Math.min(w, h);
            rain(ctx, t, .5 * w, .37 * h, .9 * s, s * STROKE, color),
            cloud(ctx, t, .5 * w, .37 * h, .9 * s, s * STROKE, color)
        },
        Skycons.SLEET = function (ctx, t, color) {
            var w = ctx.canvas.width,
                h = ctx.canvas.height,
                s = Math.min(w, h);
            sleet(ctx, t, .5 * w, .37 * h, .9 * s, s * STROKE, color),
            cloud(ctx, t, .5 * w, .37 * h, .9 * s, s * STROKE, color)
        },
        Skycons.SNOW = function (ctx, t, color) {
            var w = ctx.canvas.width,
                h = ctx.canvas.height,
                s = Math.min(w, h);
            snow(ctx, t, .5 * w, .37 * h, .9 * s, s * STROKE, color),
            cloud(ctx, t, .5 * w, .37 * h, .9 * s, s * STROKE, color)
        },
        Skycons.WIND = function (ctx, t, color) {
            var w = ctx.canvas.width,
                h = ctx.canvas.height,
                s = Math.min(w, h);
            swoosh(ctx, t, .5 * w, .5 * h, s, s * STROKE, 0, 2, color),
            swoosh(ctx, t, .5 * w, .5 * h, s, s * STROKE, 1, 2, color)
        },
        Skycons.FOG = function (ctx, t, color) {
            var w = ctx.canvas.width,
                h = ctx.canvas.height,
                s = Math.min(w, h),
                k = s * STROKE;
            fogbank(ctx, t, .5 * w, .32 * h, .75 * s, k, color), t /= 5e3;
            var a = Math.cos(t * TAU) * s * .02,
                b = Math.cos((t + .25) * TAU) * s * .02,
                c = Math.cos((t + .5) * TAU) * s * .02,
                d = Math.cos((t + .75) * TAU) * s * .02, n = .936 * h,
                e = Math.floor(n - .5 * k) + .5,
                f = Math.floor(n - 2.5 * k) + .5;
            ctx.strokeStyle = color,
            ctx.lineWidth = k,
            ctx.lineCap = "round",
            ctx.lineJoin = "round",
            line(ctx, a + .2 * w + .5 * k, e, b + .8 * w - .5 * k, e),
            line(ctx, c + .2 * w + .5 * k, f, d + .8 * w - .5 * k, f)
        },
        Skycons.prototype = {
            add: function (el, draw) {
                var obj;
                "string" == typeof el && (el = document.getElementById(el)),
                null !== el && ("string" == typeof draw && (draw = draw.toUpperCase().replace(/-/g, "_"),
                draw = Skycons.hasOwnProperty(draw) ? Skycons[draw] : null), "function" == typeof draw && (obj = { element: el, context: el.getContext("2d"), drawing: draw },
                this.list.push(obj),
                this.draw(obj, KEYFRAME)))
            },
            set: function (el, draw) {
                var i;
                for ("string" == typeof el && (el = document.getElementById(el)), i = this.list.length; i--;)
                    if (this.list[i].element === el)
                        return this.list[i].drawing = draw,
                            void this.draw(this.list[i], KEYFRAME);
                this.add(el, draw)
            },
            remove: function (el) {
                var i;
                for ("string" == typeof el && (el = document.getElementById(el)), i = this.list.length; i--;)
                    if (this.list[i].element === el)
                        return void this.list.splice(i, 1)
            },
            draw: function (obj, time) {
                var canvas = obj.context.canvas;
                this.resizeClear ? canvas.width = canvas.width : obj.context.clearRect(0, 0, canvas.width, canvas.height),
                obj.drawing(obj.context, time, this.color)
            },
            play: function () {
                var self = this;
                this.pause(),
                this.interval = requestInterval(function () {
                    var i, now = Date.now();
                    for (i = self.list.length; i--;)
                        self.draw(self.list[i], now)
                },
                1e3 / 60)
            },
            pause: function () {
                this.interval && (cancelInterval(this.interval), this.interval = null)
            }
        },
        global.Skycons = Skycons
};