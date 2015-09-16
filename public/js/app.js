var myApp = angular.module('myApp',
        ['ngRoute', 'ngStorage',
            'ngCookies',
            'mainControllers',
            'myDashboard',
            'userServices',
            'payorServices',
            'customersServices',
            'billerServices',
            'myCountry',
            'myState',
            'Permission',
            'myAttachments',
            'mytasks',
            'userProfile',
            'ftp',
//            'usertasks',
            'creditMemo',
            'compose',
            'transactionDispute',
            'DisputeCategory',
            'DisputeReason',
            'Role',
            'mypayment',
            'myReport',
            'myCity',
            'myTransatypes',
            'companyProfileServices',
            'transactionServices',
            'myBizArea',
            'ngAnimate', //tumba nav and header
            'toaster',
            "ngSanitize",
            'ngResource',
            'paginations',
            "ui.bootstrap", //me tumba el dashboard y sino no funciona datepicker
//    "ui.bootstrap.datepicker",
//    "ui.bootstrap.dateparser",
//    "ui.bootstrap.position",
//   //"ui.bootstrap.modal",
//   "ui.bootstrap.tabs",
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
            "myApp.nav.directives",
            //angel

            'chatServices',

            'ui.router',
            'ngDialog',
            'ngFileUpload',
			'branches'
        ]);

//This will handle all of our routing
myApp.config(function ($stateProvider, $urlRouterProvider) {

    // For any unmatched url, redirect to /
    // $urlRouterProvider.otherwise("/");
    $urlRouterProvider
            // .when("/newTransaction/:txntype", "templates/views/transaction/transaction.html")
//            .when("/home",   "partials/home.html")
//            .when("/login",  "partials/login.html")
            .otherwise("/");
	
    // Now set up the states
    $stateProvider
            .state('login', {
                url: "/",
                templateUrl: 'js/templates/login.html',
                controller: 'LoginController'
            })
            .state('verify', {
                url: "/verify",
                templateUrl: 'js/templates/verify.html',
                controller: 'LoginController'
            })
            .state('logout', {
                url: "/logout",
                controller: 'LogoutController'
            })
            .state('layout', {
                url: "/dashboard",
                templateUrl: 'templates/views/layout.html',
                controller: 'AppController',
            })
            .state({
                parent: "layout",
                name: "home",
                url: "/home",
                templateUrl: 'templates/views/dashboard.html',
                controller: 'DashboardCtrl',
                nav: 1,
                content: '<i class="icon-dashboard"></i> Dashboard'
            })
            .state({
                parent: "layout",
                name: "biller",
                url: "/biller",
                templateUrl: 'templates/views/dashboard_biller.html',
                controller: 'DashboardCtrl',
                nav: 1,
                content: '<i class="icon-dashboard"></i> Dashboard'
            })

            .state({
                parent: "layout",
                name: "customer_services",
                url: "/customer_services",
                templateUrl: 'templates/views/customer_services/customerServiceDashboard.html',
                controller: 'DashboardCtrl',
                nav: 1,
                content: '<i class="icon-dashboard"></i> Dashboard'
            })

            .state('layout.clientsList', {
                url: "/clientsList",
                templateUrl: 'templates/views/customer_services/clients.html',
                controller: ''
            })

            .state('layout.transactionsList', {
                url: "/transactionsList",
                templateUrl: 'templates/views/customer_services/transactions.html',
                controller: ''
            })

            //my routes//
            //this routes are of payors
//            .state('layout.newPayor', {
//                url: "/newPayor",
//                templateUrl: 'templates/views/payor/payor.html',
//                controller: 'MyNewPayorCtrl'
//            })

            .state('layout.invitePayor', {
                url: "/invitePayor",
                templateUrl: 'templates/views/payor/invitePayor.html',
                controller: 'MyNewPayorCtrl'
            })

            .state('layout.payorList', {
                url: "/payorList",
                templateUrl: 'templates/views/payor/payorList.html',
                controller: 'MyPayorCtrl'
            })

            //this routes are of billers
            .state('layout.newBiller', {
                url: "/newBiller",
                templateUrl: 'templates/views/biller/biller.html',
                controller: 'MyNewBillerCtrl'
            })

            .state('layout.addBiller', {
                url: "/addBiller",
                templateUrl: 'templates/views/biller/new_biller.html',
                controller: 'MyNewBillerCtrl'
            })

            .state('layout.billerList', {
                url: "/billerList",
                templateUrl: 'templates/views/biller/billerList.html',
                controller: 'MyBillerCtrl'
            })
			
            .state('layout.CSaddBiller', {
                url: "/CSaddBiller",
                templateUrl: 'templates/views/customer_services/new_biller.html',
                controller: 'MyNewCSBillerCtrl'
            })
			
			.state('layout.CSbillerList', {
                url: "/CSbillerList",
                templateUrl: 'templates/views/customer_services/CSbillerList.html',
                controller: 'BillersListCtrl'
            })
            .state('layout.inviteBiller', {
                url: "/inviteBiller",
                templateUrl: 'templates/views/biller/inviteBiller.html',
                controller: 'InviteBillerCtrl'
            })

            //this routes are of users
            .state('layout.newUser', {
                url: "/newUser",
                templateUrl: 'templates/views/user/newUser.html',
                controller: 'MyNewUserCtrl'
            })

            .state({
                parent: "layout",
                name: "user",
                url: "/user",
                templateUrl: 'templates/views/user/user.html',
                controller: 'MyUserCtrl'
            })

            .state({
                parent: "layout",
                name: "users",
                url: "/users/{company_id}",
                templateUrl: 'templates/views/customer_services/users.html',
                controller: 'ListUserCSCtrl'
            })

            .state('layout.newUserCS', {
                url: "/newUserCS",
                templateUrl: 'templates/views/customer_services/newUser.html',
                controller: 'NewUserCSCtrl'
            })
			.state('layout.newCSuser', {
                url: "/newCSuser",
                templateUrl: 'templates/views/customer_services/newCSuser.html',
                controller: 'NewUserCSCtrl'
            })
			.state({
                parent: "layout",
                name: "usersCS",
                url: "/usersCS",
                templateUrl: 'templates/views/customer_services/usersCS.html',
                controller: 'ListUserCSCtrl'
            })
			.state({
                parent: "layout",
                name: "customerFees",
                url: "/customerFees",
                templateUrl: 'templates/views/customer_services/customerFees.html',
                controller: 'ListUserCSCtrl'
            })

//            .state('layout.user.userTmplt',{
//                url: "/user/:id",
//                templateUrl: 'templates/views/user/userTmplt.html',
//                controller: 'MyEditUserCtrl'
//            })

            //this routes are of transaction
            .state({
                parent: "layout",
                name: "newTransaction",
                url: "/newTransaction/:id",
                templateUrl: 'templates/views/transaction/transaction.html',
                controller: 'MyNewTransactionCtrl'
            })
			.state({
                parent: "layout",
                name: "transactionDetails",
                url: "/transactionDetails/:id",
                templateUrl: 'templates/views/transaction/transactionDetails.html',
                controller: 'EditTransactionCtrl'
            })
			.state({
                parent: "layout",
                name: "transactionPdetails",
                url: "/transactionPdetails/:id",
                templateUrl: 'templates/views/transaction/transactionPdetails.html',
                controller: 'EditTransactionPCtrl'
            })
            .state({
                parent: "layout",
                name: "newTransactionP",
                url: "/newTransactionP/:id",
                templateUrl: 'templates/views/transaction/transactionPayor.html',
                controller: 'MyNewTransactionCtrl'
            })

            .state({
                parent: "layout",
                name: "transactionList",
                url: "/transactionList/:id",
                templateUrl: 'templates/views/transaction/transactionList.html',
                settings: {
                    nav: 2,
                    content: 'Transactions'
                }
            })

            .state({
                parent: "layout",
                name: "pending",
                url: "/pending/:id",
                templateUrl: 'templates/views/dashboard.html',
            })
            .state({
                parent: "layout",
                name: "payment",
                url: "/payment/:id",
                templateUrl: '/templates/views/payment/payment.html',
                title: "dispute Transaction",
                settings: {
                    nav: 5,
                    content: 'Dispute Transaction'
                }
            })

            .state({
                parent: "layout",
                name: "dispute",
                url: "/dispute/:id",
                templateUrl: 'templates/views/transaction/dispute.html',
                title: "dispute Transaction",
                settings: {
                    nav: 5,
                    content: 'Dispute Transaction'
                }
            })

            .state({
                parent: "layout",
                name: "ach-report",
                url: "/ach-report",
                templateUrl: '/templates/views/report/ach-report.html',
            })

            .state({
                parent: "layout",
                name: "failed-import-report",
                url: "/failed-import-report",
                templateUrl: '/templates/views/report/failed-import-report.html',
            })
            .state({
                parent: "layout",
                name: "list-report",
                url: "/list-report",
                templateUrl: '/templates/views/report/list-report.html',
                title: "dispute Transaction",
            })
            .state({
                parent: "layout",
                name: "list-failed-import-report",
                url: "/list-failed-import-report",
                templateUrl: '/templates/views/report/list-failed-import-report.html',
                title: "dispute Transaction",
            })
            //this routes are task
            .state({
                parent: "layout",
                name: "tasks",
                url: "/tasks",
                templateUrl: 'templates/views/tasks/tasks.html',
                title: 'tasks',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })

            //this routes are chat/message
            .state({
                parent: "layout",
                name: "chat",
                url: "/chat",
                templateUrl: 'templates/views/chatMessage/chat.html',
                title: 'chat',
                settings: {
                    nav: 1,
                    content: 'Chat'
                }
            })

            .state({
                parent: "layout",
                name: "compose",
                url: "/compose",
                templateUrl: 'templates/views/mail/compose.html',
                title: 'compose',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })
            .state({
                parent: "layout",
                name: "inbox",
                url: "/inbox",
                templateUrl: 'templates/views/mail/inbox.html',
                title: 'inbox',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })
            .state({
                parent: "layout",
                name: "sent items",
                url: "/sentitems",
                templateUrl: 'templates/views/mail/sentitems.html',
                title: 'sentitems',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })
            .state({
                parent: "layout",
                name: "drafts",
                url: "/drafts",
                templateUrl: 'templates/views/mail/drafts.html',
                title: 'drafts',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })
            .state({
                parent: "layout",
                name: "trash",
                url: "/trash",
                templateUrl: 'templates/views/mail/trash.html',
                title: 'spam',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })
            .state({
                parent: "layout",
                name: "webmaillogin",
                url: "/webmaillogin",
                templateUrl: 'templates/views/mail/webmaillogin.html',
                title: 'webmail login',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })
            .state({
                parent: "layout",
                name: "single",
                url: "/single/:id/:msgno/:folder",
                templateUrl: 'templates/views/mail/single.html',
                title: 'single',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })

            .state({
                parent: "layout",
                name: "company-profile",
                url: "/company-profile",
                templateUrl: '/templates/views/pages/company-profile.html',
                title: 'single',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })
			.state({
                parent: "layout",
                name: "invite-branch",
                url: "/invite-branch",
                templateUrl: '/templates/views/branch/invite-branch.html'
            })
            .state({
                parent: "layout",
                name: "ftps-settings",
                url: "/ftps-settings",
                templateUrl: '/templates/views/pages/ftps-settings.html',
                title: 'single',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })

            .state({
                parent: "layout",
                name: "myprofile",
                url: "/myprofile",
                templateUrl: '/templates/views/pages/profile.html',
                title: 'single',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })

            .state({
                parent: "layout",
                name: "credit_memo",
                url: "/credit_memo",
                templateUrl: '/templates/views/pages/credit_memo.html',
                title: 'single',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            })

            .state({
                parent: "layout",
                name: "secure-paymentForm",
                url: "/secure-paymentForm",
                templateUrl: '/templates/views/pages/secure-paymentForm.html',
                title: 'single',
                settings: {
                    nav: 1,
                    content: '<i class="icon-dashboard"></i> Dashboard'
                }
            });



});


myApp.config(function ($locationProvider, $httpProvider) {

    var interceptor = function ($location, $q) {

        return {
            request: function (config) {
                return config || $q.when(config)
            },
            response: function (response) {
                return response || $q.when(response);
            },
            responseError: function (response) {
                //Not Authorized
                if (response.status === 401) {
                    $location.path('/');
                }
                return $q.reject(response);
            }
        };
    }

    $httpProvider.interceptors.push(interceptor);
});

myApp.run(function ($rootScope, $state, $location, AuthService) {
	$rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState) {
		if (!AuthService.isAuthenticated()) {
            if (toState.name == 'verify')
            {
                //user is not logged in
                $location.path('/verify');
            } else if (toState.name != 'login')
            {
                AuthService.logout();
                //user is not logged in
                event.preventDefault();
                $state.go('login');
            }
        }
//        else
//        {
//            if (toState.name === 'login')
//            {
//                //user is logged in
//                event.preventDefault();
//                $state.go('layout.dashboard');
//            }
//        }
    });
	$rootScope.$on('$locationChangeSuccess',function(evt, absNewUrl, absOldUrl) {
		//console.log('success',absOldUrl);
		$rootScope.prevUrl = absOldUrl;
	});
	$rootScope.$on('$locationChangeStart',function(evt, absNewUrl, absOldUrl) {
		//console.log('success',absNewUrl);
		//$rootScope.prevUrl = absNewUrl;
	});
});

