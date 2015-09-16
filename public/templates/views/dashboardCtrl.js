angular.module('myDashboard', ['common', 'billerServices'])
        .controller('DashboardCtrl', function (common, $location, $routeParams,$interval,$timeout, $scope, $resource, Session, Customer, Permissions) {
        	$scope.$on('$viewContentLoaded', function() {
				angular.element('#loader img:last-child').attr('src','assets/images/bigspinner.gif');
	        	angular.element('#loader').css('background-color','#fff');
	        	angular.element('#loader img').css('width','6%');
	        	angular.element('#loader img').css('left','45%');
	        	angular.element('#loader img').css('top','40%');
				angular.element('#loader').css('overflow','hidden');
				loader().show();
	        	$timeout(function(){
        	    	loader().hide();
        	    }, 200);
				});
			var vm = this;
        	//angular.element('#loader').html('<div class="loading col-sm-6 col-sm-offset-3"><div class="progress progress-striped active"><div class="progress-bar" data-ng-model="vm.progressValue" style="width:100%"></div></div></div>');
        	//angular.element('#loader').html('<progressbar class="progress-striped active" animate="true" max="100" value="vm.progressValue" type="success"><i><span count-to="{{vm.countTo}}" duration="1" count-from="{{vm.countFrom}}"></span> / 100</i></progressbar>');
        	//angular.element('#loader').addClass('progressbarload');
        	
        	
    	    /*$scope.progressValue = 100;
    	    var amt = 20;
        	//$scope.countTo = amt;
        	//$scope.countFrom = 0;
        	 timeout = $timeout(function(){
        	    	//amt=amt+20;
	        		//$scope.amt = amt;
	        	    angular.element('#loader .progress-bar').css('width','100%');
        	    }, 200);
        	*/
            vm.title = 'Transactions Dashboard';
            vm.billerTabActive = true;
            vm.isbillerTabActive = true;
            vm.billervm = new DashboardTransactionView(dashboardviewtypes.BILLER);
            vm.payorvm = new DashboardTransactionView(dashboardviewtypes.PAYOR);

            vm.pageChanged = pageChanged;
            vm.refresh = refresh;
           // vm.search = search;
      
             $scope.permit=  Permissions.permiss();
            //vm.payorRefreshTransactionSelection = payorRefreshTransactionSelection;
            // vm.billerRefreshTransactionSelection = billerRefreshTransactionSelection;
            // vm.payorSelectUnSelectAll = payorSelectUnSelectAll;
            //vm.billerSelectUnSelectAll = billerSelectUnSelectAll;

//            vm.downloadFile = downloadFile;
//            vm.removeDocument = removeDocument;
//            vm.makePrivate = makePrivate;
//            vm.makePublic = makePublic;

//            var getConcurrentCustomer = Customer.all();
//
//            getConcurrentCustomer.success(function (response) {
//                $scope.customers = response;
//                $scope.mycurrentcustomer = $scope.customers[1];
//                var mycurrencustomerB = $scope.mycurrentcustomer;
//                return mycurrencustomerB;
//            });
//             vm.currentcustomer = vm.getConcurrentCustomer();

            // vm.tabSelectText = Session.customer_id();
            //  vm.tabSelectText = getCustomer;

            //  here I got the current customer
            vm.userNameCustomer = Session.userName();
            var getCustomer = Customer.get(Session.customer_id());
            getCustomer.success(function (response) {
                $scope.customers = response;
                $scope.mycurrentcustomer = $scope.customers;
                $scope.mycurrentcustomerName = $scope.customers.legal_name;
                
               
                /*var amt = 10;
               $timeout(function(){
            	   amt = amt+20;
                	angular.element('#loader .progress-bar').css('width','100%');
                },200).then(function(){
                	loader().hide();
                });*/
               	 
           


            // vm.tabSelectText= vm.currentcustomer.legal_name;//this is the test
            // vm.customers = getCustomers();
            // vm.txnCount = datacontext.getTxnCount();

            vm.filterTransactionsByNumber = filterTransactionsByNumber;
            vm.filterTransactionsByStatus = filterTransactionsByStatus;

            vm.goToDispute = goToDispute;
            vm.clearFilter = clearFilter;
            vm.sorting = sorting;
            // vm.sortFromMenu = sortFromMenu;
            //JRB 04/26/2014
            vm.getTransactionSectionId = getTransactionSectionId;
//            vm.getLocalStorage = getLocalStorage;
//
//            vm.showAttachments = showAttachments;
//            vm.loadAttachment = loadAttachment;
//
//            vm.makePayment = makePayment;
//
//            vm.goToPayment = goToPayment;

            //JRB 01/25/2014
            vm.changeVisibleTab = changeVisibleTab;
            //JRB 01/26/2014
            vm.showSelectedTransactions = showSelectedTransactions;
            vm.setSelectedToVerified = setSelectedToVerified;
            vm.setSelectedToVerifiedAndApproved = setSelectedToVerifiedAndApproved;
            vm.setSelectedToApproved = setSelectedToApproved;
            //JRB 05/25/2014
            vm.setSelectedToDispute = setSelectedToDispute;
            //YCR 02/23/2014
            vm.toggleDetail = toggleDetail;
            vm.templateUrl = "";

            vm.dueDateFromOpened = false;
            vm.dueDateToOpened = false;
            vm.dueDateFrompayorvmOpened = false;
            vm.dueDateTopayorvmOpened = false;
            vm.open = open;
			vm.SelectDashboard = SelectDashboard;

			function SelectDashboard(tab)
			{
				if(tab == 0)
					$location.path('/dashboard/biller');
                                     if(tab == 2)
					$location.path('/dashboard/customer_services');
				else
					$location.path('/dashboard/home');
			}
            //  vm.uploadAttachment = uploadAttachment;

            vm.attachment = {
                txnId: 0,
                type: {},
                description: ''
            };

            //YCR 10/22/2014
//            vm.sendEmail = sendEmail;
//
//            vm.getTxnCount = getTxnCount;

            //YCR 04/110/2014
            // 4 "filter" and "Order By" Purpose
            vm.categories = [];

            //YCR 06/06/2014 subscribe to txn total att change event
            vm.attchedfilescount = 0;
            $scope.$on('txnattcountchanged', function (event, args) {
                vm.attchedfilescount = args.value;
            });


            //YCR 07/06/2014  TABLES  START
            vm.select = function (page, viewmodel) {
                var end, start;

                viewmodel.paging.currentPage = page;
//                loadTransactionsAll(dashboardactiveviewmodels);


            };
            vm.numPerPage = 10;

            //TABLES BILLER END

//            vm.isLoading = false;


            //YCR 08-13-2014
//            vm.setTxnMouseOverTrue = setTxnMouseOverTrue;
//            vm.setTxnMouseOverFalse = setTxnMouseOverFalse


            //YCR 08/28/2014  
            //SignalR Section       

//            vm.onConnectedCallBack = onConnectedCallBack;
//            vm.onNewUserConnectedCallBack = onNewUserConnectedCallBack;

            vm.viewmodel = {};

            //YCR 11/3/2014
//            vm.canApprovePayment = canApprovePayment;
            //YCR 11/11/2014
//            vm.setTabSelected = setTabSelected;
            loader().hide();

            });
//        activate();
//        function activate() {
//
//            /* if (!datacontext.validSession())
//             return;*/
//
//            // common.activateController([loadLookups(), loadTransactionsAll(dashboardactiveviewmodels)], controllerId)
//            // .then(function () {
////            vm.tabSelectText = vm.getTxnCount().billerAll > 0 ? vm.mycurrentcustomer.legal_name + ' (biller account)' : vm.mycurrentcustomer.legal_name + ' (payor account)';
//            vm.tabSelectText= vm.mycurrentcustomer.legal_name + ' (biller account)';
//            vm.selectedBillerTab = vm.getTxnCount().billerAll > 0;
//            vm.selectedPayorTab = !vm.selectedBillerTab;
//            setTabSelected(vm.tabBillerSelected);
//            loadTabSelected();
//
//            // logger.log('PayAnyBiz Dashboard');
//            // });
//        }
//
//
//        function setTabSelected(selectedTab)
//        {
//            if (selectedTab == 0)
//            {
//                vm.tabSelectText = vm.mycurrentcustomer.legal_name + ' (biller account)';
//            }
//            else
//            {
//
//                vm.tabSelectText = vm.mycurrentcustomer.legal_name + ' (payor account)';
//            }
//
//            vm.selectedBillerTab = selectedTab == 0;
//            vm.selectedPayorTab = !vm.selectedBillerTab;
//
//            localStorage.setItem('activeTab', selectedTab);
//        }


            function loadTabSelected()
            {
          
				var activeTabData = localStorage.getItem('activeTab');
                if (activeTabData) {
                    vm.selectedBillerTab = activeTabData == 0;
                    vm.selectedPayorTab = !vm.selectedBillerTab;
                    vm.payorTabDisable = activeTabData == 1;
                    if (vm.selectedBillerTab) {
                        vm.tabSelectText = vm.mycurrentcustomer.legal_name + ' (biller account)';
                    }
                    else {

                        vm.tabSelectText = vm.mycurrentcustomer.legal_name + ' (payor account)';
                    }
                }
                else {
                    setTabSelected(false);
                }
            }

            //JRB 04/26/2014
            function getTransactionSectionId(id) {
                return 'txn_' + id;
            }


            function getFilteredTransactions() {
                return vm.filteredTransactions;
            }

            //JRB 01/25/2014
            function changeVisibleTab(tabidx) {
                vm.billerTabActive = tabidx === 0;
            }

            //Refres Paging Panel
            function RefreshPagingPanelVisibility(dashboardviewmodel) {
                dashboardviewmodel.paging.visible = (dashboardviewmodel.paging.currentPage > 1) || (dashboardviewmodel.transactions.length >= dashboardviewmodel.paging.pageSize && dashboardviewmodel.transactionCount > dashboardviewmodel.paging.pageSize);

            }


            function showSelectedTransactions(dashboardviewmodel) {
                if (dashboardviewmodel) {
                    if (!dashboardviewmodel.showingSeleted) {
                        dashboardviewmodel.showingSeleted = true;
                        dashboardviewmodel.showSeletedBtnTitle = ' Show ALL Transactions ';
                    }
                    else {
                        dashboardviewmodel.showingSeleted = false;
                        dashboardviewmodel.showSeletedBtnTitle = ' Show Seleted Transactions ';
                    }
                    dashboardviewmodel.gotoFirstPage();
                    loadTransactions(dashboardviewmodel);
                    RefreshPagingPanelVisibility(dashboardviewmodel);
                }
            }

            //JRB 01/26/2014
            function checkStatusChange(dashboardviewmodel, action) {
                if (dashboardviewmodel.totalSelectedAmount === 0) {
                    logger.log('No Transaction Seleted to ' + action);
                    //  alert('No Transaction Seleted to ' + action);
                    return false;
                }
                return true;
            }

            function setSelectedToVerified(dashboardviewmodel) {
                if (!checkStatusChange(dashboardviewmodel, 'Verify')) {
                    return;
                }

                return bsDialog.confirmationDialog('Confirm', 'Change selected Transactions status to Verified?')
                        .then(function () {
                            doChageStatusTo(dashboardviewmodel, transationStatuses.VERIFIED);
                        });
            }

            function setSelectedToVerifiedAndApproved(dashboardviewmodel) {
                //???? --> Check with Greyes
            }

            function setSelectedToApproved(dashboardviewmodel) {
                if (!checkStatusChange(dashboardviewmodel, 'Approve')) {
                    return;
                }

                var value = canApprovePayment(dashboardviewmodel);

                if (!value.canApprove) {
                    return bsDialog.alertErrorDialog('Warning!', value.errorMessage, 'ok')
                            .then(function () {
                                return;
                            });
                    return;
                }
                goToBatchPayment(dashboardviewmodel);

            }

            //05/25/2014
            function setSelectedToDispute(dashboardviewmodel) {
                if (!checkStatusChange(dashboardviewmodel, 'Dispute')) {
                    return;
                }


                var value = canDispute(dashboardviewmodel);

                if (!value.canApprove) {
                    return bsDialog.alertErrorDialog('Warning!', value.errorMessage, 'ok')
                            .then(function () {
                                return;
                            });
                    return;
                }


                goToBatchDispute(dashboardviewmodel);
            }

            //it has with logger
//      function doChageStatusTo(dashboardviewmodel, newstatus) {
//            datacontext.changeSeletecedTransactionStatusTo(dashboardviewmodel.isbiller, newstatus)
//            .then(changestatusSuccess, changestatusfailed);
//
//            function changestatusSuccess() {
//
//                if (!dashboardviewmodel.isbiller) {
//                    dashboardviewmodel.transactions.forEach(function (txn) {
//                        if (txn.selected) {
//                            sendEmail(txn, 0, 2);
//                        }
//                    });
//                };
//
//                loadTransactions(dashboardviewmodel);
//                refreshTransactionStatusStats(dashboardviewmodel);  
//            }
//            function changestatusfailed(error) {
//                logger.logError(error);
//            }
//        }

            function pageChanged(dashboardviewmodel, page) {
                if (!page) {
                    return;
                }
                dashboardviewmodel.paging.currentPage = page;
                loadTransactions(dashboardviewmodel, true);
            }

            function refresh() {
                //JRB 04/12/2014 Fixing Refresh crashing issue.
                loadTransactionsAll(dashboardactiveviewmodels);
            }

            function filter() {
                loadTransactions(dashboardviewmodel, false);
            }

            function goToDispute(item) {
                if (item && item.id) {
                    var url = '/dashboard/dispute/' + item.id;
                    $location.path(url)
                }
            }
            ;


            function goToBatchDispute(view) {
                var prmviwew = view.isbiller ? "B" : "P";
                //JRB 07/27/2014
                var url = '/batchdispute/' + prmviwew;
                $location.path(url);
            }
            ;

            //change the routes and id with stateParams
            function goToBatchPayment(view) {
                var prmviwew = view.isbiller ? "B" : "P";
                $routeParams.txntyp = prmviwew;



                //YCR 11/3/2014
                var url = '/payment/' + prmviwew;
                $location.path(url);
            }
            ;

//        function goToPayment(txn) {
//            txn.selected = true;
//            payorRefreshTransactionSelection(txn);
//            $routeParams.id = txn.id;
//            var url = '/payment/' + txn.id;
//            $location.path(url);
//        } ;

            function filterTransactionsByNumber(dashboardviewmodel, filter) {
                dashboardviewmodel.transactionStatusFilter = null;
                dashboardviewmodel.transactionNumberFilter = filter;
                loadTransactions(dashboardviewmodel, true);
            }
            ;

            function filterTransactionsByStatus(dashboardviewmodel, statusId) {
                switch (statusId) {
                    case 1:
                        if (dashboardviewmodel.isbiller) {
                            vm.billervm.selectedFilter = "Showing Pending transactions";

                        }
                        else {
                            vm.payorvm.selectedFilter = "Showing Pending transactions";
                        }
                        break;
                    case 2:
                        if (dashboardviewmodel.isbiller) {
                            vm.billervm.selectedFilter = "Showing Verified transactions";
                        }
                        else {
                            vm.payorvm.selectedFilter = "Showing Verified transactions";
                        }
                        break;
                    case 3:
                        if (dashboardviewmodel.isbiller) {
                            vm.billervm.selectedFilter = "Showing Approved transactions";
                        }
                        else {
                            vm.payorvm.selectedFilter = "Showing Approved transactions";
                        }
                        break;
                    case 4:
                        if (dashboardviewmodel.isbiller) {
                            vm.billervm.selectedFilter = "Showing Disputed transactions";
                        }
                        else {
                            vm.payorvm.selectedFilter = "Showing Disputed transactions";
                        }
                        break;
                    default:
                        vm.billervm.selectedFilter = "Showing All transactions";
                        vm.payorvm.selectedFilter = "Showing All transactions";

                }
                dashboardviewmodel.transactionNumberFilter = null;
                dashboardviewmodel.transactionStatusFilter = statusId;
                dashboardviewmodel.filterBy.statusCol = statusId;
                dashboardviewmodel.paging.currentPage = 1;
                loadTransactions(dashboardviewmodel);
            }
            ;

            function toggleDetail(viewmodel, txn) {
                if (!txn) {
                    return;
                }
                var visible = !txn.detailsVisbile;
                //if ( visible) {
                //    return;
                //}
                $routeParams.id = txn.id;
               // alert($routeParams.id);
                vm.txn = txn;
                vm.idRequested = txn.id;
                if (!visible) {
                    var divid = '#' + txn.id;
                    $(divid).remove();
                }
                txn.detailsVisbile = visible;
                txn.showInlineAttchment = false;
                // txn.locked = visible;           
                // getIsLocked(txn.id);

                //if (signalR.connectionActive) {
                //    signalR.myPABHub.server.lockTxn(txn.id, visible);
                //}




            }
            ;

            //Fixng Firefox $event not defined issue
            function search(dashboardviewmodel, $event) {
                //JRB 01/26/2014        
                if ($event) {
                    switch ($event.keyCode) {
                        case keyCodes.esc:

                            break;
                        case keyCodes.enter:

                            if (!dashboardviewmodel) {
                                return;
                            }
                            saveLocalStorage(dashboardviewmodel);
                            loadTransactions(dashboardviewmodel);
                            break;
                        case keyCodes.backspace:

                            break;
                        case keyCodes.del:

                            break;
                        default:

                            break;
                    }
                    if ($event.type == "click") {
                        if (!dashboardviewmodel) {
                            return;
                        }

                        saveLocalStorage(dashboardviewmodel);
                        loadTransactions(dashboardviewmodel);
                    }
                }


            }

            function clearFilter(dashboardviewmodel) {
                if (!dashboardviewmodel) {
                    return;
                }

                dashboardviewmodel.filterBySelectedcategory = {};
                dashboardviewmodel.filterBySelectedtype = {};

                dashboardviewmodel.filterBy =
                        {
                            payorCol: "",
                            billerCol: "",
                            categoryCol: "",
                            typeCol: "",
                            numberCol: "",
                            dueDateFromCol: "",
                            dueDateToCol: "",
                            amountCol: "",
                            relatedNbrCol: "",
                            statusCol: "",
                            payorRefCol: "",
                            allCol: ""
                        };
                saveLocalStorage(dashboardviewmodel);
                loadTransactions(dashboardviewmodel);

            }

            function sorting(dashboardviewmodel, fieldOrder, value) {

                switch (fieldOrder) {
                    case 'payorDesc':
                        dashboardviewmodel.filterOrderBy.payorSort = getSorting(value);
                        break;
                    case 'billerDesc':
                        dashboardviewmodel.filterOrderBy.billerSort = getSorting(value);
                        break;
                    case 'categoryDesc':
                        dashboardviewmodel.filterOrderBy.categorySort = getSorting(value);
                        break;
                    case 'typeDesc':
                        dashboardviewmodel.filterOrderBy.typeSort = getSorting(value);
                        break;
                    case 'numberDesc':
                        dashboardviewmodel.filterOrderBy.numberSort = getSorting(value);
                        break;
                    case 'dueDateDesc':
                        dashboardviewmodel.filterOrderBy.dueDateSort = getSorting(value);
                        break;
                    case 'amountDesc':
                        dashboardviewmodel.filterOrderBy.amountSort = getSorting(value);
                        break;
                    case 'relatedNbrDesc':
                        dashboardviewmodel.filterOrderBy.relatedNbrSort = getSorting(value);
                        break;
                    case 'statusDesc':
                        dashboardviewmodel.filterOrderBy.statusSort = getSorting(value);
                        break;
                    case 'payorRefDesc':
                        dashboardviewmodel.filterOrderBy.payorRefSort = getSorting(value);
                        break;
                }
                saveLocalStorage(dashboardviewmodel);
                loadTransactions(dashboardviewmodel, true);
            }

            function getSorting(value) {
                if (value == 2)
                    return 1;
                return ++value;
            }
          
        });


//myDashboard.service('ServiceCurrentCustomer', function () {
//	this.create = function (customer) {
//		this.id = customer.id;
//		this.legal_name = customer.legal_name;
//	};
//        this.destroy = function () {
//		this.id = null;
//		this.legal_name = null;
//	};
//});
//
//myDashboard.service('ServiceSesion', function () {
//	this.create = function (user) {
//		this.id_customer_user = user.customers_id;
//		//this.legal_name = customer.legal_name;
//	};
//});



var dashboardviewtypes = {
    PAYOR: 0,
    BILLER: 1
};
function DashboardTransactionView(dashboardviewtype) {
    this.isbiller = dashboardviewtype === dashboardviewtypes.BILLER;

    //JRB 05/07/2014
    var storageId = {
        filter: this.isbiller ? "dashboard.biller.filter" : "dashboard.payor.filter",
        sort: this.isbiller ? "dashboard.biller.sort" : "dashboard.payor.sort",
        activeTab: "activeTab"
    };

    //Transactions collection
    this.transactions = [];
    //YCR 11/11/2014 ACTIVE TAB
    this.activeTab = 0;

    //Counts management
    //Generic counts
    this.transactionCount = 0;
    this.transactionFilteredCount = 0;
    //Status counts 
    this.pendingCount = 0;
    this.verifiedCount = 0;
    this.approvedCount = 0;
    this.disputedCount = 0;

    //Filtering management
    this.transactionNumberFilter = null;
    this.transactionStatusFilter = null;
    this.filterOrderBy =
            {
                payorSort: 0,
                billerSort: 0,
                categorySort: 0,
                typeSort: 0,
                numberSort: 0,
                dueDateSort: 0,
                amountSort: 0,
                relatedNbrSort: 0,
                statusSort: 0,
                payorRefSort: 0
            };

    this.filterBy =
            {
                payorCol: "",
                billerCol: "",
                categoryCol: "",
                typeCol: "",
                numberCol: "",
                dueDateFromCol: "",
                dueDateToCol: "",
                amountCol: "",
                relatedNbrCol: "",
                statusCol: "",
                payorRefCol: "",
                allCol: ""
            };

    //JRB 05/07/2014
    this.SaveFilterSortToLocalStorage = function () {
        localStorage.setItem(storageId.filter, JSON.stringify(this.filterBy));
        localStorage.setItem(storageId.sort, JSON.stringify(this.filterOrderBy));
    }

    this.LoadFilterSortFromLocalStorage = function () {
        var filterdata = localStorage.getItem(storageId.filter);
        if (filterdata) {
            this.filterBy = JSON.parse(filterdata);

        }
        var sortdata = localStorage.getItem(storageId.sort);
        if (sortdata) {
            this.filterOrderBy = JSON.parse(sortdata);
        }


    }

    //Selection management
    this.totalSelectedAmount = 0;

    //Transaction Selection
    this.selectAllTransactions = false;
    this.showingSeleted = false;
    this.showSeletedBtnTitle = ' Show Seleted Transactions ';

    //Paging management
    this.paging = {
        currentPage: 1,
        maxPagesToShow: 5,
        pageSize: 10,
        visible: true
    };

    //JRB 05/29/2014
    this.getById = function (id) {
        var i = 0, len = this.transactions.length;
        for (; i < len; i++) {
            if (+this.transactions[i].id == +id) {
                return this.transactions[i];
            }
        }
        return null;
    }

    Object.defineProperty(this.paging, 'pageCount', {
        get: function () {
            return Math.floor(this.transactionFilteredCount / this.paging.pageSize) + 1;
        }
    });

    Object.defineProperty(this, 'pageAllSelected', {
        get: function () {
            if (this.transactions.length < 1) {
                return false;
            }
            for (var i = 0; i < this.transactions.length; i++) {
                if (!this.transactions[i].selected) {
                    return false;
                }
            }
            ;
            return true;
        }
    });

    this.gotoFirstPage = function () {
        this.paging.currentPage = 1;
    }
}



