var transactionServices = angular.module('transactionServices', ['ngResource']);
transactionServices.filter('startFrom', function() {
    return function(input, start) {
        if (input) {
            start = +start; //parse to int
            return input.slice(start);
        }
        return [];
    }
});
transactionServices.controller('MyTransactionCtrl', ['$scope', '$stateParams', '$state', 'Transactions', function($scope, $stateParams, $state, Transactions) {


    var getTransactions = Transactions.all();
    getTransactions.success(function(response) {
        $scope.transactions = response;
        $scope.mycurrentcustomer = null;
    });
    var vm = this;
    vm.toggleDetail = toggleDetail;
    //JRB 04/26/2014  Refactoring Pupilo's code.
    $stateParams.id = 0;

    function toggleDetail(txn) {
        if (!txn) {
            return;
        }
        var visible = !txn.detailsVisbile;
        $stateParams.id = txn.id;
        vm.txn = txn;
        vm.idRequested = txn.id;
        if (!visible) {
            var divid = '#' + txn.id;
            $(divid).remove();
        }
        txn.detailsVisbile = visible;
        txn.showInlineAttchment = false;
    };
}])

transactionServices.controller('TransactionStatusCtrl', ['$scope', '$stateParams', '$state', 'TransactionStatus', '$route', function($scope, $stateParams, $state, TransactionStatus) {

    var getTransactionStatus = TransactionStatus.all();
    getTransactionStatus.success(function(response) {
        $scope.transaction_status = response;
    });
}])

//For print the transactions
transactionServices.controller('printCtrl', function($scope, $stateParams, $window) {

    $scope.print = function() {
        $window.print();
    }
})
transactionServices.controller('cumulativePrint', function($scope, $stateParams, $window) {

        $scope.print = function(divName) {
            var divToPrint = angular.element(document.getElementById(divName));
            newWin = window.open();
            newWin.document.write(divToPrint[0].innerHTML);
            newWin.location.reload();
            newWin.focus();
            newWin.print();
            newWin.close();
        }
    })
    //For print the transactions -- end -- -by Ible Soft

transactionServices.controller('TransactionStatusDescriptionCtrl', ['$scope', '$stateParams', '$state', 'TransactionStatus', 'Transactions', function($scope, $stateParams, $state, TransactionStatus, Transactions) {
    $stateParams.id = $scope.transactions.transactions_status_id;
    var getTransactionStatus = TransactionStatus.get($stateParams.id);
    getTransactionStatus.success(function(response) {
        $scope.transaction_status = response;
    });
}])

.controller('MyNewTransactionCtrl', ['$scope', '$state', 'Session', 'BizAreas', 'TransactionTypes', 'PayorRelation', 'Transactions', 'toaster', 'ngDialog', '$location', '$window', '$route', function($scope, $state, Session, BizAreas, TransactionTypes, PayorRelation, Transactions, toaster, ngDialog, $window, $route) {

    $scope.settings = {
        pageTitle: "New Transaction",
        action: "Save"
    };
    $scope.transactions = {
        biller_id: "",
        payor_id: "",
        transactions_types_id: "",
        number: "",
        amount: "",
        due_date: "",
        biz_area_id: "",
        relatednumber: "",
        departure_date: "",
        arrival_date: "",
        payorrefnumber: "",
        description: "",
    };
    $scope.customer_current = Session.customer_id();
    $scope.formats = ['MM/dd/yyyy', 'dd.MM.yyyy', 'shortDate'];
    $scope.format = $scope.formats[0];
    $scope.form_create_biller_transaction = {};
    $scope.submit = function() {
        $scope.txneditamount = '';
        $scope.mycurrentcustomer = '';
        $scope.due_date = '';
        $scope.myTransatype = '';
        $scope.myArea = '';
        $scope.payorRefNumber = '';
        $scope.number = '';
        $scope.relatednumber = '';
        $scope.inputRequired = true;
        if (!$scope.form_create_biller_transaction.mycurrentcustomer.$viewValue) {
            $scope.mycurrentcustomer = 'Payor is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.txneditamount.$viewValue) {
            $scope.txneditamount = 'Amount is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.due_date.$viewValue) {
            $scope.due_date = 'Due Date is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.myTransatype.$viewValue) {
            $scope.myTransatype = 'Type is Required';
            $scope.inputRequired = false;
        }
        /*
        if (!$scope.form_create_biller_transaction.payorRefNumber.$viewValue) {
             $scope.payorRefNumber = 'Payor Ref Numbers  Required';
        	$scope.inputRequired = false;
        }*/
        if (!$scope.form_create_biller_transaction.number.$viewValue) {
            $scope.number = 'Number is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.myArea.$viewValue) {
            $scope.myArea = 'Category is Required';
            $scope.inputRequired = false;
        }
        //                    if ($scope.form_create_biller_transaction.relatednumber.$invalid) {
        //                        $scope.relatednumber = 'Related Number is Required';
        //                    }

        if ($scope.inputRequired) {
            $scope.formData = {};
            $scope.formData.alwayscurrentcustomer = $scope.customer_current;
            $scope.formData.myArea = $scope.transactions.myArea.id;
            $scope.formData.biz_area_id = $scope.transactions.myArea.id;
            $scope.formData.due_date = vm.transactions.due_date;
            $scope.formData.departure_date = vm.transactions.departure_date;
            $scope.formData.arrival_date = vm.transactions.arrival_date;
            $scope.formData.number = $scope.transactions.number;
            $scope.formData.amount = $scope.transactions.amount;
            $scope.formData.payorrefnumber = $scope.transactions.payorrefnumber;
            $scope.formData.relatednumber = $scope.transactions.relatednumber;
            $scope.formData.description = $scope.transactions.description;
            $scope.formData.mycurrentcustomer = $scope.transactions.mycurrentcustomer.id;
            $scope.formData.myTransatype = $scope.transactions.myTransatype.id;
            $scope.formData.transactions_types_id = $scope.transactions.myTransatype.id;
            $scope.formData.customer_current = $scope.customer_current;
            var request = Transactions.create($scope.formData);
            request.success(function(response) {
                if (response.success === true) {

                    toaster.pop({
                        type: 'success',
                        title: 'Transaction Created Succesfully'
                    });
                    toaster.pop({
                        type: 'info',
                        title: 'E-mail Send Succesfully'
                    });
                    $scope.transactions = {
                        number: "",
                        amount: "",
                        due_date: "",
                        relatednumber: "",
                        departure_date: "",
                        arrival_date: "",
                        payorrefnumber: "",
                        description: ""
                    };
                }

                if (response.error == true) {
                    if (response.number == 2) {
                        toaster.pop({
                            type: 'error',
                            title: 'Transaction number cannot be duplicate, For example transaction number-1'
                        });
                    }
                }
            });
            request.error(function(response) {
                toaster.pop({
                    type: 'error',
                    title: 'Whoops something went wrong'
                });

            });
        }

    };
    $scope.cancel = function() {
        ngDialog.open({
            template: '\
                                <p>Are you sure you want to Cancel New Transaction?</p></br>\
                                <div class="ngdialog-buttons" data-ng-controller="MyNewTransactionCtrl">\
                                    <button type="button" class="ngdialog-button btn-warning" ng-click="closeThisDialog(0)">Cancel</button>\
                                    <button type="button" class="ngdialog-button btn-primary" ng-click="reloadPage(1)">OK</button>\
                                </div>',
            plain: true,
            showClose: true,
            closeByDocument: true,
            closeByEscape: true
        });
        //                   $state.reload();
    };
    $scope.reloadPage = function() {
        ngDialog.close();
        $state.reload();
    };
    var vm = this;
    vm.open = open;
    vm.departureDateOpened = false;
    vm.dueDateOpened = false;
    //                 $scope.transactions.departure_date = vm.transactions.departure_date;

    function open($event, datepickerName) {

        switch (datepickerName) {
            case 'departureDateOpened':
                vm.departureDateOpened = !0;
                break;
            case 'dueDateOpened':
                vm.dueDateOpened = !0;
                break;
            case 'arrivalDateOpened':
                vm.arrivalDateOpened = !0;
                break;
            case 'topayorvm':
                vm.dueDateToOpened = !0;
                break;
        }

        return $event.preventDefault(),
            $event.stopPropagation()

    }
}]);


transactionServices.controller('MyNewTrxnCtrl', ['$scope', '$http', '$state', 'Session', 'BizAreas', 'TransactionTypes', 'PayorRelation', 'Transactions', 'toaster', 'ngDialog', '$location', '$window', '$route', function($scope, $http, $state, Session, BizAreas, TransactionTypes, PayorRelation, Transactions, toaster, ngDialog, $window, $route) {


    $scope.settings = {
        pageTitle: "New Transaction",
        action: "Save"
    };
    $scope.transactions = {
        id: "",
        biller_id: "",
        payor_id: "",
        transactions_types_id: "",
        number: "",
        amount: "",
        due_date: "",
        biz_area_id: "",
        relatednumber: "",
        departure_date: "",
        arrival_date: "",
        payorrefnumber: "",
        mycurrentcustomer: "",
        description: "",
    };
    $scope.customer_current = Session.customer_id();
    $scope.formats = ['MM/dd/yyyy', 'dd.MM.yyyy', 'shortDate'];
    $scope.format = $scope.formats[0];
    $scope.form_create_biller_transaction = {};

    $scope.autoSave = function() {
        $scope.transactions.alwayscurrentcustomer = $scope.customer_current;
        $scope.transactions.customer_current = $scope.customer_current;
        console.log($scope.transactions.mycurrentcustomer);
        $scope.transactions.mycurrentcustomer = $scope.transactions.mycurrentcustomer;
        $scope.transactions.transactions_status_id = 8;
        var request = $http({
            method: "GET",
            url: 'api/autoSaveBiller',
            params: $scope.transactions
        }).success(function(response) {
            if (response.error == true) {
                if (response.number == 2) {
                    toaster.pop({
                        type: 'error',
                        title: 'Transaction number cannot be duplicate, For example transaction number-1'
                    });
                } else {
                    toaster.pop({
                        type: 'error',
                        title: 'Whoops something went wrong'
                    });
                }
            } else {
                $scope.transactions.id = response.id;
                console.log($scope.transactions);
            }
        });
    }
    $scope.submit = function() {
        $scope.txneditamount = '';
        $scope.mycurrentcustomer = '';
        $scope.due_date = '';
        $scope.myTransatype = '';
        $scope.myArea = '';
        $scope.payorRefNumber = '';
        $scope.number = '';
        $scope.relatednumber = '';
        $scope.inputRequired = true;
        if (!$scope.form_create_biller_transaction.mycurrentcustomer.$viewValue) {
            $scope.mycurrentcustomer = 'Payor is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.txneditamount.$viewValue) {
            $scope.txneditamount = 'Amount is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.due_date.$viewValue) {
            $scope.due_date = 'Due Date is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.myTransatype.$viewValue) {
            $scope.myTransatype = 'Type is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.number.$viewValue) {
            $scope.number = 'Number is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.myArea.$viewValue) {
            $scope.myArea = 'Category is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_biller_transaction.relatednumber.$viewValue) {
            $scope.relatednumber = 'Related Number is Required';
            $scope.inputRequired = false;
        }
        if ($scope.inputRequired) {
            $scope.transactions.transactions_status_id = 1;
            var request = $http({
                method: "GET",
                url: 'api/autoSaveBiller',
                params: $scope.transactions
            });
            request.success(function(response) {
                if (response.success === true) {
                    toaster.pop({
                        type: 'success',
                        title: 'Transaction Created Succesfully'
                    });
                    toaster.pop({
                        type: 'info',
                        title: 'E-mail Send Succesfully'
                    });
                    $scope.transactions = {
                        number: "",
                        amount: "",
                        due_date: "",
                        relatednumber: "",
                        departure_date: "",
                        arrival_date: "",
                        payorrefnumber: "",
                        description: ""
                    };
                }

                if (response.error == true) {
                    if (response.number == 2) {
                        toaster.pop({
                            type: 'error',
                            title: 'Transaction number cannot be duplicate, For example transaction number-1'
                        });
                    }
                }
            });
            request.error(function(response) {
                toaster.pop({
                    type: 'error',
                    title: 'Whoops something went wrong'
                });

            });
        }
    };


    var vm = this;
    vm.open = open;
    vm.departureDateOpened = false;
    vm.dueDateOpened = false;
    //                 $scope.transactions.departure_date = vm.transactions.departure_date;

    function open($event, datepickerName) {

        switch (datepickerName) {
            case 'departureDateOpened':
                vm.departureDateOpened = !0;
                break;
            case 'dueDateOpened':
                vm.dueDateOpened = !0;
                break;
            case 'arrivalDateOpened':
                vm.arrivalDateOpened = !0;
                break;
            case 'topayorvm':
                vm.dueDateToOpened = !0;
                break;
        }

        return $event.preventDefault(),
            $event.stopPropagation()

    }
}]);


transactionServices.controller('MyNewTrxnPCtrl', ['$scope', '$http', '$state', 'Session', 'BizAreas', 'TransactionTypes', 'PayorRelation', 'Transactions', 'toaster', 'ngDialog', function($scope, $http, $state, Session, BizAreas, TransactionTypes, PayorRelation, Transactions, toaster, ngDialog) {
    $scope.settings = {
        pageTitle: "New Transaction",
        action: "Save"
    };
    $scope.transactions = {
        id: "",
        biller_id: "",
        payor_id: "",
        transactions_types_id: "",
        number: "",
        amount: "",
        due_date: "",
        biz_area_id: "",
        myTransatype: "",
        relatednumber: "",
        departure_date: "",
        arrival_date: "",
        payorrefnumber: "",
        description: ""
    };
    $scope.payor_id = Session.customer_id();
    $scope.formats = ['MM/dd/yyyy', 'dd.MM.yyyy', 'shortDate'];
    $scope.format = $scope.formats[0];
    $scope.form_create_payor_transaction = {};

    $scope.autoSave = function() {
        $scope.formData = {};
        $scope.transactions.alwayscurrentcustomer = $scope.payor_id;
        $scope.transactions.myArea = $scope.transactions.myArea;
        $scope.transactions.biz_area_id = $scope.transactions.myArea;
        $scope.transactions.due_date = $scope.transactions.due_date;
        $scope.transactions.departure_date = $scope.transactions.departure_date;
        $scope.transactions.arrival_date = $scope.transactions.arrival_date;
        $scope.transactions.mycurrentcustomer = $scope.payor_id;
        $scope.transactions.number = $scope.transactions.number;
        $scope.transactions.amount = $scope.transactions.amount;
        $scope.transactions.payorrefnumber = $scope.transactions.payorrefnumber;
        $scope.transactions.relatednumber = $scope.transactions.relatednumber;
        $scope.transactions.description = $scope.transactions.description;
        $scope.transactions.myTransatype = $scope.transactions.myTransatype;
        $scope.transactions.transactions_types_id = $scope.transactions.myTransatype;
        $scope.transactions.customer_current = $scope.transactions.mybillerselect;
        $scope.transactions.transactions_status_id = 8;
        console.log($scope.transactions);
        var request = $http({
            method: "GET",
            url: 'api/autoSaveBiller',
            params: $scope.transactions
        }).success(function(response) {
            if (response.error == true) {
                if (response.number == 2) {
                    toaster.pop({
                        type: 'error',
                        title: 'Transaction number cannot be duplicate, For example transaction number-1'
                    });
                } else {
                    toaster.pop({
                        type: 'error',
                        title: 'Whoops something went wrong'
                    });
                }
            } else {
                $scope.transactions.id = response.id;
                console.log($scope.transactions);
            }
        });
    };
    $scope.submit = function() {
        $scope.txneditamount = '';
        $scope.mybillerselect = '';
        $scope.due_date = '';
        $scope.myTransatype = '';
        $scope.myArea = '';
        $scope.payorRefNumber = '';
        $scope.number = '';
        $scope.relatednumber = '';
        $scope.inputRequired = true;
        if (!$scope.form_create_payor_transaction.mybillerselect.$viewValue) {
            $scope.mybillerselect = 'Biller is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_payor_transaction.txneditamount.$viewValue) {
            $scope.txneditamount = 'Amount is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_payor_transaction.due_date.$viewValue) {
            $scope.due_date = 'Due Date is Required';
        }
        if (!$scope.form_create_payor_transaction.myTransatype.$viewValue) {
            $scope.myTransatype = 'Type is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_payor_transaction.myArea.$viewValue) {
            $scope.myArea = 'Category is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_payor_transaction.number.$viewValue) {
            $scope.number = 'Number is Required';
            $scope.inputRequired = false;
        }
        //            if ($scope.form_create_payor_transaction.relatednumber.$invalid) {
        //                $scope.relatednumber = 'Related Number is Required';
        //            }
        if ($scope.inputRequired) {
            $scope.transactions.transactions_status_id = 1;
            var request = $http({
                method: "GET",
                url: 'api/autoSaveBiller',
                params: $scope.transactions
            });
            request.success(function(response) {
                if (response.success === true) {
                    toaster.pop({
                        type: 'success',
                        title: 'Transaction Created Succesfully'
                    });
                    toaster.pop({
                        type: 'info',
                        title: 'E-mail Send Succesfully'
                    });
                    $scope.transactions = {
                        number: "",
                        amount: "",
                        due_date: "",
                        relatednumber: "",
                        departure_date: "",
                        arrival_date: "",
                        payorrefnumber: "",
                        description: ""
                    };
                }
                if (response.error == true) {
                    if (response.number == 2) {
                        toaster.pop({
                            type: 'error',
                            title: 'Transaction number cannot be duplicate, For example transaction number-1'
                        });
                    }
                }
            });
            request.error(function(response) {
                if (response.number == 2) {
                    toaster.pop({
                        type: 'error',
                        title: 'Transaction number cannot be duplicate, For example transaction number-1'
                    });
                } else {
                    toaster.pop({
                        type: 'error',
                        title: 'Whoops something went wrong'
                    });
                }
            });
        }
    };
    $scope.cancel = function() {
        ngDialog.open({
            template: '\
                                <p>Are you sure you want to Cancel New Transaction?</p></br>\
                                <div class="ngdialog-buttons" data-ng-controller="MyNewTransactionCtrl">\
                                    <button type="button" class="ngdialog-button btn-warning" ng-click="closeThisDialog(0)">Cancel</button>\
                                    <button type="button" class="ngdialog-button btn-primary" ng-click="reloadPage(1)">OK</button>\
                                </div>',
            plain: true,
            showClose: true,
            closeByDocument: true,
            closeByEscape: true
        });
        //                   $state.reload();
    };
    $scope.reloadPage = function() {
        ngDialog.close();
        $state.reload();
    };
    var vm = this;
    //YCR 07/08/2014
    vm.open = open;
    vm.departureDateOpened = false;
    vm.dueDateOpened = false;
    //                 $scope.transactions.departure_date = vm.transactions.departure_date;

    function open($event, datepickerName) {

        switch (datepickerName) {
            case 'departureDateOpened':
                vm.departureDateOpened = !0;
                break;
            case 'dueDateOpened':
                vm.dueDateOpened = !0
                break;
            case 'arrivalDateOpened':
                vm.arrivalDateOpened = !0;
                break;
            case 'topayorvm':
                vm.dueDateToOpened = !0;
                break;
        }

        return $event.preventDefault(),
            $event.stopPropagation()

    }
}]);


transactionServices.controller('MyNewTransactionPCtrl', ['$scope', '$state', 'Session', 'BizAreas', 'TransactionTypes', 'PayorRelation', 'Transactions', 'toaster', 'ngDialog', function($scope, $state, Session, BizAreas, TransactionTypes, PayorRelation, Transactions, toaster, ngDialog) {
    $scope.settings = {
        pageTitle: "New Transaction",
        action: "Save"
    };
    $scope.transactions = {
        biller_id: "",
        payor_id: "",
        transactions_types_id: "",
        number: "",
        amount: "",
        due_date: "",
        biz_area_id: "",
        relatednumber: "",
        departure_date: "",
        arrival_date: "",
        payorrefnumber: "",
        description: ""
    };
    $scope.payor_id = Session.customer_id();
    $scope.formats = ['MM/dd/yyyy', 'dd.MM.yyyy', 'shortDate'];
    $scope.format = $scope.formats[0];
    $scope.form_create_payor_transaction = {};
    $scope.submit = function() {
        $scope.txneditamount = '';
        $scope.mybillerselect = '';
        $scope.due_date = '';
        $scope.myTransatype = '';
        $scope.myArea = '';
        $scope.payorRefNumber = '';
        $scope.number = '';
        $scope.relatednumber = '';
        $scope.inputRequired = true;
        if (!$scope.form_create_payor_transaction.mybillerselect.$viewValue) {
            $scope.mybillerselect = 'Biller is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_payor_transaction.txneditamount.$viewValue) {
            $scope.txneditamount = 'Amount is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_payor_transaction.due_date.$viewValue) {
            $scope.due_date = 'Due Date is Required';
        }
        if (!$scope.form_create_payor_transaction.myTransatype.$viewValue) {
            $scope.myTransatype = 'Type is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_payor_transaction.myArea.$viewValue) {
            $scope.myArea = 'Category is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_create_payor_transaction.number.$viewValue) {
            $scope.number = 'Number is Required';
            $scope.inputRequired = false;
        }
        //            if ($scope.form_create_payor_transaction.relatednumber.$invalid) {
        //                $scope.relatednumber = 'Related Number is Required';
        //            }
        if ($scope.inputRequired) {
            $scope.formData = {};
            $scope.formData.alwayscurrentcustomer = $scope.payor_id;
            $scope.formData.myArea = $scope.transactions.myArea.id;
            $scope.formData.biz_area_id = $scope.transactions.myArea.id;
            $scope.formData.due_date = vm.transactions.due_date;
            $scope.formData.departure_date = vm.transactions.departure_date;
            $scope.formData.arrival_date = vm.transactions.arrival_date;
            $scope.formData.mycurrentcustomer = $scope.payor_id;
            $scope.formData.number = $scope.transactions.number;
            $scope.formData.amount = $scope.transactions.amount;
            $scope.formData.payorrefnumber = $scope.transactions.payorrefnumber;
            $scope.formData.relatednumber = $scope.transactions.relatednumber;
            $scope.formData.description = $scope.transactions.description;
            $scope.formData.myTransatype = $scope.transactions.myTransatype.id;
            $scope.formData.transactions_types_id = $scope.transactions.myTransatype.id;
            $scope.formData.customer_current = $scope.transactions.mybillerselect.id;
            var request = Transactions.create($scope.formData);

            request.success(function(response) {
                if (response.success === true) {
                    toaster.pop({
                        type: 'success',
                        title: 'Transaction Created Succesfully'
                    });
                    toaster.pop({
                        type: 'info',
                        title: 'E-mail Send Succesfully'
                    });
                    $scope.transactions = {
                        number: "",
                        amount: "",
                        due_date: "",
                        relatednumber: "",
                        departure_date: "",
                        arrival_date: "",
                        payorrefnumber: "",
                        description: ""
                    };
                }
                if (response.error == true) {
                    if (response.number == 2) {
                        toaster.pop({
                            type: 'error',
                            title: 'Transaction number cannot be duplicate, For example transaction number-1'
                        });
                    }
                }
            });
            request.error(function(response) {
                if (response.number == 2) {
                    toaster.pop({
                        type: 'error',
                        title: 'Transaction number cannot be duplicate, For example transaction number-1'
                    });
                } else {
                    toaster.pop({
                        type: 'error',
                        title: 'Whoops something went wrong'
                    });
                }

            });

        }
    };
    $scope.cancel = function() {
        ngDialog.open({
            template: '\
                                <p>Are you sure you want to Cancel New Transaction?</p></br>\
                                <div class="ngdialog-buttons" data-ng-controller="MyNewTransactionCtrl">\
                                    <button type="button" class="ngdialog-button btn-warning" ng-click="closeThisDialog(0)">Cancel</button>\
                                    <button type="button" class="ngdialog-button btn-primary" ng-click="reloadPage(1)">OK</button>\
                                </div>',
            plain: true,
            showClose: true,
            closeByDocument: true,
            closeByEscape: true
        });
        //                   $state.reload();
    };
    $scope.reloadPage = function() {
        ngDialog.close();
        $state.reload();
    };
    var vm = this;
    //YCR 07/08/2014
    vm.open = open;
    vm.departureDateOpened = false;
    vm.dueDateOpened = false;
    //                 $scope.transactions.departure_date = vm.transactions.departure_date;

    function open($event, datepickerName) {

        switch (datepickerName) {
            case 'departureDateOpened':
                vm.departureDateOpened = !0;
                break;
            case 'dueDateOpened':
                vm.dueDateOpened = !0
                break;
            case 'arrivalDateOpened':
                vm.arrivalDateOpened = !0;
                break;
            case 'topayorvm':
                vm.dueDateToOpened = !0;
                break;
        }

        return $event.preventDefault(),
            $event.stopPropagation()

    }
}]);
//start the below code generate the QR Code			
transactionServices.directive('qrcode', ['$window', function($window) {

    var canvas2D = !!$window.CanvasRenderingContext2D,
        levels = {
            'L': 'Low',
            'M': 'Medium',
            'Q': 'Quartile',
            'H': 'High'
        },
        draw = function(context, qr, modules, tile) {
            for (var row = 0; row < modules; row++) {
                for (var col = 0; col < modules; col++) {
                    var w = (Math.ceil((col + 1) * tile) - Math.floor(col * tile)),
                        h = (Math.ceil((row + 1) * tile) - Math.floor(row * tile));
                    context.fillStyle = qr.isDark(row, col) ? '#000' : '#fff';
                    context.fillRect(Math.round(col * tile),
                        Math.round(row * tile), w, h);
                }
            }
        };
    return {
        restrict: 'E',
        template: '<canvas class="qrcode"></canvas>',
        link: function(scope, element, attrs) {
            var domElement = element[0],
                $canvas = element.find('canvas'),
                canvas = $canvas[0],
                context = canvas2D ? canvas.getContext('2d') : null,
                download = 'download' in attrs,
                href = attrs.href,
                link = download || href ? document.createElement('a') : '',
                trim = /^\s+|\s+$/g,
                error,
                version,
                errorCorrectionLevel,
                data,
                size,
                modules,
                tile,
                qr,
                $img,
                setVersion = function(value) {
                    version = Math.max(1, Math.min(parseInt(value, 10), 10)) || 4;
                },
                setErrorCorrectionLevel = function(value) {
                    errorCorrectionLevel = value in levels ? value : 'M';
                },
                setData = function(value) {
                    if (!value) {
                        return;
                    }

                    data = value.replace(trim, '');
                    qr = qrcode(version, errorCorrectionLevel);
                    qr.addData(data);
                    try {
                        qr.make();
                    } catch (e) {
                        error = e.message;
                        return;
                    }

                    error = false;
                    modules = qr.getModuleCount();
                },
                setSize = function(value) {
                    size = parseInt(value, 10) || modules * 2;
                    tile = size / modules;
                    canvas.width = canvas.height = size;
                },
                render = function() {
                    if (!qr) {
                        return;
                    }

                    if (error) {
                        if (link) {
                            link.removeAttribute('download');
                            link.title = '';
                            link.href = '#_';
                        }
                        if (!canvas2D) {
                            domElement.innerHTML = '<img src width="' + size + '"' +
                                'height="' + size + '"' +
                                'class="qrcode">';
                        }
                        scope.$emit('qrcode:error', error);
                        return;
                    }

                    if (download) {
                        domElement.download = 'qrcode.png';
                        domElement.title = 'Download QR code';
                    }

                    if (canvas2D) {
                        draw(context, qr, modules, tile);
                        if (download) {
                            domElement.href = canvas.toDataURL('image/png');
                            return;
                        }
                    } else {
                        domElement.innerHTML = qr.createImgTag(tile, 0);
                        $img = element.find('img');
                        $img.addClass('qrcode');
                        if (download) {
                            domElement.href = $img[0].src;
                            return;
                        }
                    }

                    if (href) {
                        domElement.href = href;
                    }
                };
            if (link) {
                link.className = 'qrcode-link';
                $canvas.wrap(link);
                domElement = link;
            }


            setVersion(attrs.version);
            setErrorCorrectionLevel(attrs.errorCorrectionLevel);
            setSize(attrs.size);
            attrs.$observe('version', function(value) {
                if (!value) {
                    return;
                }

                setVersion(value);
                setData(data);
                setSize(size);
                render();
            });
            attrs.$observe('errorCorrectionLevel', function(value) {
                if (!value) {
                    return;
                }

                setErrorCorrectionLevel(value);
                setData(data);
                setSize(size);
                render();
            });
            attrs.$observe('data', function(value) {
                if (!value) {
                    return;
                }

                setData(value);
                setSize(size);
                render();
            });
            attrs.$observe('size', function(value) {
                if (!value) {
                    return;
                }

                setSize(value);
                render();
            });
            attrs.$observe('href', function(value) {
                if (!value) {
                    return;
                }
                href = value;
                render();
            });
        }
    };
}]);
//the above code generate the QR code by Ible Soft
//For print the transactions -- start -- -by Ible Soft
transactionServices.controller('cumulativePrintpreview', function($scope, $state, $modal, $log, logger, TransactionTypes, BizAreas, $routeParams, Session, Customer, Transactions) {

    var biller_id = Session.customer_id();
    var getTransaction = Transactions.printAllPayor(biller_id);
    $scope.open = function(size) {
        var modalInstance = $modal.open({
            templateUrl: './templates/views/printAllBiller.html',
            controller: 'ModalInstanceCtrl',
            size: 'lg',
            resolve: {
                items: function() {
                    return getTransaction;
                }
            }
        });
    }
});

transactionServices.controller('cumulativePrintpreviewPayor', function($scope, $state, $modal, $log, logger, TransactionTypes, BizAreas, $routeParams, Session, Customer, Transactions) {
    var payor_id = Session.customer_id();
    var getTransaction = Transactions.printAll(payor_id);
    $scope.open = function(size) {
        var modalInstance = $modal.open({
            templateUrl: './templates/views/printAllPayor.html',
            controller: 'ModalInstanceCtrl',
            size: 'lg',
            resolve: {
                items: function() {
                    return getTransaction;
                }
            }
        });
    }
});

transactionServices.controller('BillerName', function($scope, $state, $modal, $log, logger, TransactionTypes, BizAreas, $routeParams, Session, Customer, Transactions) {

    var getPayorBillerLogin = Customer.get(Session.customer_id());
    getPayorBillerLogin.success(function(response) {
        $scope.customers = response;
        $scope.mycurrentcustomerName = $scope.customers.legal_name;
        $scope.legal_name = $scope.mycurrentcustomerName;
        $scope.customer_address = $scope.customers.address;
        $scope.customer_phone = $scope.customers.phone;
        $scope.customer_fax = $scope.customers.fax;
    });
    $scope.date = new Date();
    $scope.imageUrl = 'assets/images/pabLogo.png';
});
//For print the transactions -- end -- -by Ible Soft			

//We have add the $ model and $log to the belwo function by Iblesoft

transactionServices.controller('EditTransactionCtrl', function($scope, toaster, logger, $state, $modal, $log, TransactionTypes, BizAreas, $routeParams, Session, $stateParams, Customer, Transactions, ngDialog, TransactionStatus, ListSortedPayor, Transaction_dispute, Transaction_history, TransactionBudget, Attachments, TrxComments, User) {
    loader().hide();
    if ($stateParams.id) {
        $routeParams.id = $stateParams.id;
    }
    var getTransaction = Transactions.get($routeParams.id);
    getTransaction.success(function(response) {
        $scope.transactions = response;
        $scope.data_txn = $scope.transactions;
        $scope.id_payor_select = $scope.transactions.payor_id;
        $scope.id_biller_login = $scope.transactions.biller_id;
        $scope.biz_area_id = $scope.transactions.biz_area_id;
        $scope.ispayorcurrent = $scope.transactions.payor_id === Session.customer_id();
        $scope.isbillercurrent = $scope.transactions.biller_id === Session.customer_id();
        $scope.transactions_types_id = $scope.transactions.transactions_types_id;

        if ($scope.transactions.transactions_status_id == 4) {
            var dispute_txn_history = Transaction_history.dispute($routeParams.id);
            dispute_txn_history.success(function(response) {
                $scope.disputehistory = response;
            });
        }
        var txn_history = Transaction_history.get($routeParams.id);
        txn_history.success(function(response) {
            $scope.history = response;
        });

        if ($scope.transactions.transactions_status_id == 4) {
            var disputeDetails = Transaction_dispute.get($routeParams.id);
            disputeDetails.success(function(response) {
                if (angular.isObject(response[0])) {
                    $scope.disputeinfo = response[0];
                    $scope.selecteddisputecategory = $scope.disputeinfo.category_description;
                    $scope.selecteddisputereason = $scope.disputeinfo.reason_description;
                    $scope.disputeDesc = $scope.disputeinfo.description;
                }
            });
        }
        var getPayorSelect = ListSortedPayor.listSortedPayor($routeParams.id);
        getPayorSelect.success(function(response) {
            $scope.payor_list_first_selected = response;
            if ($scope.payor_list_first_selected[0]) {
                $scope.transactions.payor_id = $scope.payor_list_first_selected[0];
                $scope.payor_legalname = $scope.payor_list_first_selected[0].legal_name;
            }
            // alert($scope.user);
        });
        var getSelectTransactionTypes = TransactionTypes.get($scope.transactions_types_id);
        getSelectTransactionTypes.success(function(response) {
            $scope.transaction_types = response;
            $scope.transactions.transactions_types_id = $scope.transaction_types[0];
        });
        var getAreaSelect = BizAreas.get($scope.biz_area_id);
        getAreaSelect.success(function(response) {
            $scope.biz_areass = response;
            $scope.transactions.biz_area_id = $scope.biz_areass[0];
        });

        var Dispcomments = TrxComments.get($routeParams.id);
        Dispcomments.success(function(response) {
            $scope.disputeComments = response;
        });

        var userDetails = User.getDetails($scope.id_payor_select);
        userDetails.success(function(response) {
            for (i = 0; i < response.length; i++) {
                $scope.user = response[i];
            }
        });

        var userDetails = User.get(Session.id());
        userDetails.success(function(response) {
            $scope.myuser = response;
        });

        var getPayorBillerLogin = Customer.get(Session.customer_id());
        getPayorBillerLogin.success(function(response) {
            $scope.customers = response;
            $scope.mycurrentcustomer = $scope.customers;
            $scope.mycurrentcustomerName = $scope.customers.legal_name;
        });

    });



    var getverifyCreatorTxn = Transactions.get($routeParams.id);
    getverifyCreatorTxn.success(function(response) {
        $scope.pending = response;
        $scope.mycurrenuser = $scope.pending.creator;

    });

    $scope.verifyCreatorTxn = function() {
        var verify = false;
        if (Session.id() == $scope.mycurrenuser) {
            verify = true;
            return verify;
        }
        return verify;
    }




    // $scope.transactions.legal_name = $scope.mycurrentcustomerName;
    //     alert($routeParams.id);
    //    $scope.transactions.id = $routeParams.id;

    //Start Below code added by Iblesoft find End

    $scope.dialog = function(size) {
        var modalInstance = $modal.open({
            templateUrl: './templates/views/print_transaction.html',
            controller: 'ModalInstanceCtrl',
            size: 'lg',
            resolve: {
                items: function() {
                    return Transactions.print_transactions_details($routeParams.id);
                }
            }
        });
        modalInstance.result.then(function(selectedItem) {
            $scope.selected = selectedItem;
        }, function() {
            $log.info('Modal dismissed at: ' + new Date());
        });
    };
    //Ent the the above code added by Iblesoft find Start

    function SelectedVerified() {
        $scope.transactions_status = 2;
        $scope.transactions.transactions_status_id = $scope.transactions_status;
    }

    function SelectedApproved() {
        $scope.transactions_status = 3;
        $scope.transactions.transactions_status_id = $scope.transactions_status;
    }



    function SelectedDispute() {
        $scope.mybillerName = $scope.mycurrentcustomerName;
        $scope.id_txn = $routeParams.id;
    }
    $scope.transactions_status = 0;
    $scope.$watch('transactions_status', function() {
        if ($scope.transactions_status !== 0) {
            $scope.submit();
        }
    });
    $scope.customer_current = Session.customer_id();
    $scope.form_update_biller_transaction = {};
    $scope.submit = function() {
        $scope.amount = '';
        $scope.pay_legalname = '';
        $scope.due_date = '';
        $scope.myTransatype = '';
        $scope.myBizAreaTxn = '';
        $scope.payorrefnumber = '';
        $scope.number = '';
        $scope.description = '';
        $scope.relatednumber = '';
        $scope.inputRequired = true;
        if (!$scope.form_update_biller_transaction.pay_legalname.$viewValue) {
            $scope.pay_legalname = 'Payor is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_biller_transaction.amount.$viewValue) {
            $scope.amount = 'Amount is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_biller_transaction.due_date.$viewValue) {
            $scope.due_date = 'Due Date is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_biller_transaction.myTransatype.$viewValue) {
            $scope.myTransatype = 'Type is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_biller_transaction.myBizAreaTxn.$viewValue) {
            $scope.myBizAreaTxn = 'Category is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_biller_transaction.payorrefnumber.$viewValue) {
            $scope.payorrefnumber = 'Payor Ref Numberss  Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_biller_transaction.number.$viewValue) {
            $scope.number = 'Number is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_biller_transaction.relatednumber.$viewValue) {
            $scope.relatednumber = 'Related Number is Required';
            $scope.inputRequired = false;
        }
        if ($scope.inputRequired) {
            // $scope.transactions.biz_area_id = $scope.transactions.biz_areass.id;
            if ($scope.transactions.transactions_status_id == 8) {
                $scope.transactions.transactions_status_id = 1;
            }
            $scope.transactions.due_date = $scope.transactions.due_date;
            $scope.transactions.departure_date = $scope.transactions.departure_date;
            $scope.transactions.arrival_date = $scope.transactions.arrival_date;
            //$scope.transactions.mycurrentcustomer = $scope.transactions.mycurrentcustomer.id;
            $scope.transactions.transactions_types_id = $scope.transactions.transactions_types_id.id;
            $scope.transactions.payor_id = $scope.transactions.payor_id.id;
            $scope.transactions.biz_area_id = $scope.transactions.biz_area_id.id;
            $scope.transactions.alwayscurrentcustomer = $scope.customer_current;
            $scope.transactions.user_id = Session.id();
            console.log($scope.transactions);
            var request = Transactions.update($routeParams.id, $scope.transactions);
            request.success(function(response) {
                $scope.inputRequired = true;
                if (response.success === true) {
                    $scope.flash = response.status;
                    logger.logSuccess('<b>Transaction Updated Succesfully</b>');
                    logger.log('<b>E-mail Send Succesfully</b>');
                    /*toaster.pop({
						type: 'success',
						title: 'Transaction Created Succesfully'
					});
					toaster.pop({
						type: 'info',
						title: 'E-mail Send Succesfully'
					});*/
                }
            });
            request.error(function(response) {
                logger.logError('<b>Whoops something went wrong</b>');
            });
            $state.reload('#biller_table');
        }
    };
    $scope.cancel = function() {
        ngDialog.open({
            template: '\
                                <p>Are you sure you want to Cancel Updated Transaction?</p></br>\
                                <div class="ngdialog-buttons" data-ng-controller="EditTransactionCtrl">\
                                    <button type="button" class="ngdialog-button btn-warning" ng-click="closeThisDialog(0)">Cancel</button>\
                                    <button type="button" class="ngdialog-button btn-primary" ng-click="reloadPage(1)">OK</button>\
                                </div>',
            plain: true,
            showClose: true,
            closeByDocument: true,
            closeByEscape: true
        });
        //                   $state.reload();
    };
    $scope.reloadPage = function() {
        ngDialog.close();
        $state.reload();
    };


    $scope.cancel_status = function() {
        ngDialog.open({
            template: '\
                                <p>Reason for cancel transaction</p></br>\
                        <textarea class="form-control" id="reason" data-ng-controller="EditTransactionCtrl" rows="3"></textarea></br>\
                                <div class="ngdialog-buttons" data-ng-controller="EditTransactionCtrl">\
                                    <button type="button" class="ngdialog-button btn-warning" ng-click="closeThisDialog(0)">Cancel</button>\
                                    <button type="button" class="ngdialog-button btn-primary" ng-click="reloadPageCancel(1)">OK</button>\
                                </div>',
            plain: true,
            showClose: true,
            closeByDocument: true,
            closeByEscape: true
        });
        //                   $state.reload();
    };

    $scope.reloadPageCancel = function() {
        ngDialog.close();
        $scope.transactions.user_id = Session.id();
        $scope.transactions.reason = angular.element($('#reason')).val();
        $scope.transactions.transactions_status_id = $scope.transactions.transactions_status_id;
        var request = TransactionStatus.cancel($routeParams.id, $scope.transactions);
        request.success(function(response) {
            if (response.success == true) {
                $state.reload();
                logger.log('The transaction has been canceled.');
            }
            if (response.success == false) {
                $state.reload();
                logger.log(response.msg);
            }

        });
        // $state.reload();
    };


    /*
     * @author : iblesoft
     * @desc:Manage transactions budget Details.
     */
    $scope.relatednumbers = {};
    $scope.relatedNumber = {};
    $scope.relatedNumberTotalAmount = 0;
    var request = TransactionBudget.get($routeParams.id);
    request.success(function(response) {

        $scope.relatednumbers = response;

        $scope.getRelatedNumberTotalAmount = function() {
            var result = calculateRelatedAmount($scope.relatednumbers);
            return result;
        }

        function calculateRelatedAmount(results) {
            $scope.relatedNumberTotalAmount = 0;
            results.forEach(function(r) {
                $scope.relatedNumberTotalAmount = parseInt($scope.relatedNumberTotalAmount) + parseInt(r.amount);
            });
            return $scope.relatedNumberTotalAmount;
        }
        $scope.getRelatedNumberTotalRemaining = function() {
            var totalRemain = $scope.relatedNumberTotalAmount;
            if ($scope.transactions) {
                totalRemain = parseInt($scope.transactions.amount) - parseInt($scope.relatedNumberTotalAmount);
            }
            return totalRemain;
        }
        $scope.removeRelatedNumber = function(relNumb) {
            var request = TransactionBudget.delete(relNumb.id, relNumb);
            request.success(function(response) {
                $scope.relatedNumber.number = "";
                $scope.relatedNumber.container = "";
                $scope.relatedNumber.amount = 0;
                $scope.relatednumbers = response;
            });
        }


        $scope.addRelatedNumber = function($event) {

            if ($event.type == "click") {
                $scope.relatedNumber.transactions_id = $routeParams.id;
                $scope.relatedNumber.user_id = Session.id();
                var request = TransactionBudget.create($scope.relatedNumber);
                request.success(function(response) {
                    $scope.relatedNumber.number = "";
                    $scope.relatedNumber.container = "";
                    $scope.relatedNumber.amount = 0;
                    $scope.relatednumbers = response;
                });
            }
        }

    });
    // End of Manage Transaction Budget Details//
    var vm = this;
    vm.open = open;
    vm.SelectedVerified = SelectedVerified;
    vm.SelectedApproved = SelectedApproved;
    vm.SelectedDispute = SelectedDispute;
    vm.addDisputeComment = addDisputeComment;
    vm.saveDisputeComment = saveDisputeComment;
    vm.SelectedPause = SelectedPause;
    vm.SelectedReapproved = SelectedReapproved;
    vm.SelectedCancel = SelectedCancel;

    vm.attchedfilescount = '';
    vm.approvePartialPayment = approvePartialPayment;
    vm.getRelatedNumberTotalAmount = vm.getRelatedNumberTotalAmount;
    vm.goToPayment = goToPayment;
    vm.departureDateOpened = false;
    vm.dueDateOpened = false;
    var files = Attachments.get($routeParams.id);
    files.success(function(response) {
        vm.attchedfilescount = response.length;
    });

    function open($event, datepickerName) {

        switch (datepickerName) {
            case 'departureDateOpened':
                vm.departureDateOpened = !0;
                break;
            case 'dueDateOpened':
                vm.dueDateOpened = !0;
                break;
            case 'arrivalDateOpened':
                vm.arrivalDateOpened = !0;
                break;
            case 'topayorvm':
                vm.dueDateToOpened = !0;
                break;
        }

        return $event.preventDefault(),
            $event.stopPropagation()

    }


    $scope.balance_dispute = function() {
        ngDialog.open({
            template: '\
                                <p>Do you want to create a new transaction with the balance of the previous transaction?</p></br>\
                                <div class="ngdialog-buttons" data-ng-controller="EditTransactionCtrl">\
                                    <button type="button" class="ngdialog-button btn-warning" ng-click="CancelPageBalance(0)">Cancel</button>\
                                    <button type="button" class="ngdialog-button btn-primary" ng-click="reloadPageBalance(1)">OK</button>\
                                </div>',
            plain: true,
            showClose: true,
            closeByDocument: true,
            closeByEscape: true
        });
        //                   $state.reload();
    };



    function addDisputeComment(txn) {
        $scope.showReply = true;
    }

    function saveDisputeComment() {

        var initValues = {
            transactionId: $scope.transactions.id,
            customerId: Session.customer_id(),
            comments: vm.comment,
            userId: Session.id(),
            active: true
        };
        var request = TrxComments.create(initValues);
        request.success(function(response) {
            vm.comment = '';
            Dispcomments = TrxComments.get($routeParams.id);
            Dispcomments.success(function(response) {
                $scope.disputeComments = response;
            });
            logger.logSuccess('Saved data successfully.');
            $scope.showReply = false;
            //$state.reload();	
        });
    }

    $scope.CancelPageBalance = function() {
        ngDialog.close();
        $scope.transactions.user_id = Session.id();
        $scope.transactions.balance_dispute = 2;
        var request = TransactionStatus.approvedwithdispute($routeParams.id, $scope.transactions);
        request.success(function(response) {
            logger.logSuccess('The transaction has been Approved.');
        });
        $state.reload();
    };

    $scope.reloadPageBalance = function() {
        ngDialog.close();
        $scope.transactions.user_id = Session.id();
        $scope.transactions.balance_dispute = 1;
        var request = TransactionStatus.approvedwithdispute($routeParams.id, $scope.transactions);
        request.success(function(response) {
            logger.logSuccess('The transaction has been Approved.');
        });
        // $state.reload();
    };

    function SelectedApproved() {
        $scope.transactions.user_id = Session.id();
        var request = TransactionStatus.approvedwithdispute($routeParams.id, $scope.transactions);
        request.success(function(response) {
            logger.logSuccess('The transaction has been Approved.');
        });
    }

    function approvePartialPayment() {
        SelectedApproved();
        $state.reload();
    }

    function SelectedVerified() {
        $scope.transactions.user_id = Session.id();
        var request = TransactionStatus.verify($routeParams.id, $scope.transactions);
        request.success(function(response) {
            //            $state.reload(); This function is changing the status and is not executing the email notification
            $state.reload();
            logger.log('The transaction has been verified.');
        });
    }

    function SelectedPause() {
        $scope.transactions.user_id = Session.id();
        var request = TransactionStatus.pause($routeParams.id, $scope.transactions);
        request.success(function(response) {
            $state.reload();
            logger.log('The transaction has been paused.');
        });
    }

    function SelectedCancel() {
        ngDialog.close();
        $scope.transactions.user_id = Session.id();
        $scope.transactions.transactions_status_id = $scope.transactions.transactions_status_id;

        var request = TransactionStatus.cancel($routeParams.id, $scope.transactions);
        request.success(function(response) {
            $state.reload();
            logger.log('The transaction has been canceled.');
        });
    }

    function SelectedReapproved() {
        $scope.transactions.user_id = Session.id();
        var request = TransactionStatus.reapprove($routeParams.id, $scope.transactions);
        request.success(function(response) {
            $state.reload();
            logger.log('The transaction has been reapprove.');
        });
    }


    function goToPayment(txn) {
        $routeParams.id = txn.id;
        var url = '/dashboard/payment/' + txn.id;
        $location.path(url);
    }
});

transactionServices.controller('EditTransactionPCtrl', function($scope, $rootScope, $stateParams, toaster, logger, $location, $state, $modal, $log, TransactionTypes, BizAreas, $routeParams, Session, Customer, Transactions, TransactionStatus, ngDialog, ListBiller, Transaction_dispute, Transaction_history, TrxComments, User, TransactionBudget, Attachments) {

    loader().hide();
    if ($stateParams.id) {
        $routeParams.id = $stateParams.id;
    }
    var getTransaction = Transactions.get($routeParams.id);
    getTransaction.success(function(response) {
        $scope.transactions = response;
        $scope.data_txn = $scope.transactions;
        $scope.id_biller_select = $scope.transactions.biller_id;
        $scope.id_payor_login = $scope.transactions.payor_id;
        $scope.biz_area_id = $scope.transactions.biz_area_id;
        $scope.transactions_types_id = $scope.transactions.transactions_types_id;
        var getBillerSelect = ListBiller.listSortedBiller($routeParams.id);
        getBillerSelect.success(function(response) {
            $scope.biller_list_first_selected = response;
            $scope.transactions.biller_id = $scope.biller_list_first_selected[0];
            $scope.biller_legalname = $scope.biller_list_first_selected[0].legal_name;
        });
        if ($scope.transactions.transactions_status_id == 4) {
            var dispute_txn_history = Transaction_history.dispute($routeParams.id);
            dispute_txn_history.success(function(response) {
                $scope.disputehistory = response;
            });
        }
        var txn_history = Transaction_history.get($routeParams.id);
        txn_history.success(function(response) {
            $scope.history = response;
        });

        if ($scope.transactions.transactions_status_id == 4) {
            var disputeDetails = Transaction_dispute.get($routeParams.id);

            disputeDetails.success(function(response) {
                if (angular.isObject(response[0])) {
                    $scope.disputeinfo = response[0];
                    $scope.selecteddisputecategory = $scope.disputeinfo.category_description;
                    $scope.selecteddisputereason = $scope.disputeinfo.reason_description;
                    $scope.disputeDesc = $scope.disputeinfo.description;
                }
            });
        }

        var getSelectTransactionTypes = TransactionTypes.get($scope.transactions_types_id);
        getSelectTransactionTypes.success(function(response) {
            $scope.transaction_types = response;
            $scope.transactions.transactions_types_id = $scope.transaction_types[0];
        });
        var getAreaSelect = BizAreas.get($scope.biz_area_id);
        getAreaSelect.success(function(response) {
            $scope.biz_areass = response;
            $scope.transactions.biz_area_id = $scope.biz_areass[0];
        });

        var getPayorBillerLogin = Customer.get(Session.customer_id());
        getPayorBillerLogin.success(function(response) {
            $scope.customers = response;
            $scope.mycurrentcustomer = $scope.customers;
            $scope.mycurrentcustomerName = $scope.customers.legal_name;
        });
        var Dispcomments = TrxComments.get($routeParams.id);
        Dispcomments.success(function(response) {
            $scope.disputeComments = response;
        });

        var userDetails = User.get(Session.id());
        userDetails.success(function(response) {
            $scope.user = response;
        });

    });



    var getPayorBillerLogin = Customer.get(Session.customer_id());
    getPayorBillerLogin.success(function(response) {
        $scope.customers = response;
        $scope.mycurrentcustomer = $scope.customers;
        $scope.mycurrentcustomerName = $scope.customers.legal_name;
    });

    var getverifyCreatorTxn = Transactions.get($routeParams.id);
    getverifyCreatorTxn.success(function(response) {
        $scope.pending = response;
        $scope.mycurrenuser = $scope.pending.creator;

    });

    $scope.verifyCreatorTxn = function() {
        var verify = false;
        if (Session.id() == $scope.mycurrenuser) {
            verify = true;
            return verify;
        }
        return verify;
    }

    //Start Below code added by Iblesoft find End
    $scope.dialog = function(size) {
        var modalInstance = $modal.open({
            templateUrl: './templates/views/print_transaction_payor.html',
            controller: 'ModalInstanceCtrl',
            size: 'lg',
            resolve: {
                items: function() {
                    return Transactions.print_transactions_details_payor($routeParams.id);
                }
            }
        });
        modalInstance.result.then(function(selectedItem) {
            $scope.selected = selectedItem;
        }, function() {
            $log.info('Modal dismissed at: ' + new Date());
        });
    };

    function SelectedDispute() {
        $scope.mybillerName = $scope.mycurrentcustomerName;
        $scope.id_txn = $routeParams.id;
    }
    $scope.transactions_status = 0;
    $scope.$watch('transactions_status', function() {
        if ($scope.transactions_status !== 0) {
            $scope.submit();
        }
    });
    $scope.customer_current = Session.customer_id();
    $scope.form_update_payor_transaction = {};
    $scope.submit = function() {
        $scope.amount = '';
        $scope.mybillerselect = '';
        $scope.due_date = '';
        $scope.myTransatype = '';
        $scope.myArea = '';
        $scope.payorrefnumber = '';
        $scope.number = '';
        $scope.relatednumber = '';
        $scope.inputRequired = true;
        $scope.description = '';
        if (!$scope.form_update_payor_transaction.mybillerselect.$viewValue) {
            $scope.mybillerselect = 'Biller is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_payor_transaction.amount.$viewValue) {
            $scope.amount = 'Amount is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_payor_transaction.due_date.$viewValue) {
            $scope.due_date = 'Due Date is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_payor_transaction.myTransatype.$viewValue) {
            $scope.myTransatype = 'Type is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_payor_transaction.myArea.$viewValue) {
            $scope.myArea = 'Category is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_payor_transaction.number.$viewValue) {
            $scope.number = 'Number is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_payor_transaction.payorrefnumber.$viewValue) {
            $scope.payorrefnumber = 'Payor Ref Number is Required';
            $scope.inputRequired = false;
        }
        if (!$scope.form_update_payor_transaction.relatednumber.$viewValue) {
            $scope.relatednumber = 'Related Number is Required';
            $scope.inputRequired = false;
        }

        if ($scope.inputRequired) {
            // $scope.transactions.biz_area_id = $scope.transactions.biz_areass.id;
            if ($scope.transactions.transactions_status_id == 8) {
                $scope.transactions.transactions_status_id = 1;
            }
            $scope.transactions.due_date = $scope.transactions.due_date;
            $scope.transactions.departure_date = $scope.transactions.departure_date;
            $scope.transactions.arrival_date = $scope.transactions.arrival_date;
            $scope.transactions.transactions_types_id = $scope.transactions.transactions_types_id.id;
            $scope.transactions.biller_id = $scope.transactions.biller_id.id;
            $scope.transactions.biz_area_id = $scope.transactions.biz_area_id.id;
            $scope.transactions.alwayscurrentcustomer = $scope.customer_current;
            $scope.transactions.user_id = Session.id();
            var request = Transactions.update($routeParams.id, $scope.transactions);
            request.success(function(response) {
                if (response.success === true) {
                    $scope.flash = response.status;
                    logger.logSuccess('<b>Transaction Updated Succesfully</b>');
                    logger.log('<b>E-mail Send Succesfully</b>');
                    /*
			toaster.pop({
				type: 'success',
				title: 'Transaction Updated Succesfully'
			});
			toaster.pop({
				type: 'info',
				title: 'E-mail Send Succesfully'
			});
		*/
                }

            });
            request.error(function(response) {
                logger.logError('<b>Whoops something went wrong</b>');
            });
            $state.reload();
        }
    };
    $scope.cancel = function() {
        ngDialog.open({
            template: '\
                                <p>Are you sure you want to Cancel New Transaction?</p></br>\
                                <div class="ngdialog-buttons" data-ng-controller="MyNewTransactionCtrl">\
                                    <button type="button" class="ngdialog-button btn-warning" ng-click="closeThisDialog(0)">Cancel</button>\
                                    <button type="button" class="ngdialog-button btn-primary" ng-click="reloadPage(1)">OK</button>\
                                </div>',
            plain: true,
            showClose: true,
            closeByDocument: true,
            closeByEscape: true
        });
        //                   $state.reload();
    };
    $scope.reloadPage = function() {
        ngDialog.close();
        $state.reload();
    };


    $scope.cancel_status = function() {
        ngDialog.open({
            template: '\
                                <p>Reason for cancel transaction</p></br>\
                        <textarea class="form-control" id="reason" data-ng-controller="EditTransactionPCtrl" rows="3"></textarea></br>\
                                <div class="ngdialog-buttons" data-ng-controller="EditTransactionPCtrl">\
                                    <button type="button" class="ngdialog-button btn-warning" ng-click="closeThisDialog(0)">Cancel</button>\
                                    <button type="button" class="ngdialog-button btn-primary" ng-click="reloadPageCancel(1)">OK</button>\
                                </div>',
            plain: true,
            showClose: true,
            closeByDocument: true,
            closeByEscape: true
        });
        //                   $state.reload();
    };

    $scope.reloadPageCancel = function() {
        ngDialog.close();
        $scope.transactions.user_id = Session.id();
        $scope.transactions.reason = angular.element($('#reason')).val();
        $scope.transactions.transactions_status_id = $scope.transactions.transactions_status_id;
        var request = TransactionStatus.cancel($routeParams.id, $scope.transactions);
        request.success(function(response) {
            if (response.success == false) {
                logger.log(response.msg);
            }
            if (response.success == true) {
                $state.reload();
                logger.log('The transaction has been canceled.');
            }
        });
        // $state.reload();
    };
    /*
     * @author : iblesoft
     * @desc:Manage transactions budget Details.
     */
    $scope.relatednumbers = {};
    $scope.relatedNumber = {};
    $scope.relatedNumberTotalAmount = 0;
    var request = TransactionBudget.get($routeParams.id);
    request.success(function(response) {

        $scope.relatednumbers = response;

        $scope.getRelatedNumberTotalAmount = function() {
            var result = calculateRelatedAmount($scope.relatednumbers);
            return result;
        }

        function calculateRelatedAmount(results) {
            $scope.relatedNumberTotalAmount = 0;
            results.forEach(function(r) {
                $scope.relatedNumberTotalAmount = parseInt($scope.relatedNumberTotalAmount) + parseInt(r.amount);
            });
            return $scope.relatedNumberTotalAmount;
        }
        $scope.getRelatedNumberTotalRemaining = function() {
            var totalRemain = $scope.relatedNumberTotalAmount;
            if ($scope.transactions) {
                totalRemain = parseInt($scope.transactions.amount) - parseInt($scope.relatedNumberTotalAmount);
            }
            return totalRemain;
        }
        $scope.removeRelatedNumber = function(relNumb) {
            var request = TransactionBudget.delete(relNumb.id, relNumb);
            request.success(function(response) {
                $scope.relatedNumber.number = "";
                $scope.relatedNumber.container = "";
                $scope.relatedNumber.amount = 0;
                $scope.relatednumbers = response;
            });
        }


        $scope.addRelatedNumber = function($event) {

            if ($event.type == "click") {
                $scope.relatedNumber.transactions_id = $routeParams.id;
                $scope.relatedNumber.user_id = Session.id();
                var request = TransactionBudget.create($scope.relatedNumber);
                request.success(function(response) {
                    $scope.relatedNumber.number = "";
                    $scope.relatedNumber.container = "";
                    $scope.relatedNumber.amount = 0;
                    $scope.relatednumbers = response;
                });
            }
        }

    });
    // End of Manage Transaction Budget Details//
    var vm = this;
    //YCR 07/08/2014
    vm.open = open;
    vm.SelectedVerified = SelectedVerified;
    vm.SelectedApproved = SelectedApproved;
    vm.SelectedDispute = SelectedDispute;
    vm.SelectedCancel = SelectedCancel;
    vm.departureDateOpened = false;
    vm.goToPayment = goToPayment;
    vm.dueDateOpened = false;
    vm.addDisputeComment = addDisputeComment;
    vm.saveDisputeComment = saveDisputeComment;
    vm.approvePartialPayment = approvePartialPayment;
    vm.comment = '';

    vm.attchedfilescount = '';
    var files = Attachments.get($routeParams.id);
    files.success(function(response) {
        vm.attchedfilescount = response.length;
    });

    function open($event, datepickerName) {

        switch (datepickerName) {
            case 'departureDateOpened':
                vm.departureDateOpened = !0
                break;
            case 'dueDateOpened':
                vm.dueDateOpened = !0
                break;
            case 'arrivalDateOpened':
                vm.arrivalDateOpened = !0
                break;
            case 'topayorvm':
                vm.dueDateToOpened = !0
                break;
        }

        return $event.preventDefault(),
            $event.stopPropagation()

    }

    function SelectedApproved() {
        $scope.transactions.user_id = Session.id();
        var request = TransactionStatus.approvedwithdispute($routeParams.id, $scope.transactions);
        request.success(function(response) {
            logger.logSuccess('The transaction has been Approved.');
            $state.reload();
        });
    }

    function addDisputeComment(txn) {
        $scope.showReply = true;
    }

    function saveDisputeComment() {

        var initValues = {
            transactionId: $scope.transactions.id,
            customerId: Session.customer_id(),
            comments: vm.comment,
            userId: Session.id(),
            active: true
        };
        var request = TrxComments.create(initValues);
        request.success(function(response) {
            vm.comment = '';
            Dispcomments = TrxComments.get($routeParams.id);
            Dispcomments.success(function(response) {
                $scope.disputeComments = response;
            });
            logger.logSuccess('Saved data successfully.');
            $scope.showReply = false;
            //$state.reload();	
        });
    }

    function approvePartialPayment() {
        SelectedApproved();
        $state.reload();
    }

    function SelectedVerified() {
        $scope.transactions.user_id = Session.id();
        var request = TransactionStatus.verify($routeParams.id, $scope.transactions);
        request.success(function(response) {
            if (response.success) logger.log(response.msg);
            if (!response.success) logger.log(response.msg);
        });
        //        $state.reload();
    }

    function SelectedCancel() {
        ngDialog.close();
        $scope.transactions.user_id = Session.id();
        $scope.transactions.transactions_status_id = $scope.transactions.transactions_status_id;

        var request = TransactionStatus.cancel($routeParams.id, $scope.transactions);
        request.success(function(response) {
            $state.reload();
            logger.log('The transaction has been canceled.');
        });
    }

    function goToPayment(txn) {
        $routeParams.id = txn.id;
        var url = '/dashboard/payment/' + txn.id;
        $location.path(url);
    }
});
//Added by Iblesoft
transactionServices.factory("User", function($http) {
    return {
        get: function(id) {
            var request = $http({
                method: 'GET',
                url: 'api/users/' + id
            });
            return request;
        },
        getDetails: function(id) {
            var request = $http({
                method: 'GET',
                url: 'api/users/get_details/' + id
            });
            return request;
        },
        searchDataUser: function(id) {
            var request = $http.get('api/search_data_user/' + id);
            return request;
        }
    }
});

transactionServices.factory("TransactionBudget", function($http) {
    return {
        all: function() {
            var request = $http({
                method: 'GET',
                url: 'api/transaction_budget/'
            });
            return request;
        },
        create: function(data) {
            var request = $http({
                method: 'GET',
                url: 'api/transaction_budget/create',
                params: data
            });
            return request;
        },
        get: function(id) {
            var request = $http.get('api/transaction_budget/' + id);
            return request;
        },
        delete: function(id, data) {
            var request = $http({
                method: 'GET',
                url: 'api/transaction_budget/delete/' + id,
                params: data
            });
            return request;
        }
    }
});

transactionServices.factory("Transactions", function($http) {

    return {
        all: function() {
            var request = $http({
                method: 'GET',
                url: 'api/transactions'
            });
            return request;
        },
        create: function(data) {
            var request = $http({
                method: 'GET',
                url: 'api/transactions/create',
                params: data
            });
            return request;
        },
        get: function(id) {
            var request = $http.get('api/transactions/' + id);
            return request;
        },
        print_transactions_details: function(id) { //This is function is for print written by Iblesoft

            var request = $http.get('api/transactions/print_transactions_details/' + id);
            return request;
        },
        print_transactions_details_payor: function(id) { //This is function is for print written by Iblesoft

            var request = $http.get('api/transactions/print_transactions_details_payor/' + id);
            return request;
        },
        printAll: function(id) { //This is function is for print All written by Iblesoft

            var request = $http.get('api/transactions/print_all/biller/' + id);
            return request;
        },
        printAllPayor: function(id) { //This is function is for print All written by Iblesoft

            var request = $http.get('api/transactions/print_all/payor/' + id);
            return request;
        },
        update: function(id, data) {
            var request = $http.put('api/transactions/' + id, data);
            return request;
        },
        verifyCreatorTxn: function(id) {
            var request = $http.get('api/transactions/verify_creator_txn' + id);
            return request;
        },
		showneedtrans: function(data) {
            var request = $http.post('api/transactions/neededtransactions', data);
            return request;
        }, 
        delete: function(id) {
            //delete a specific post
        }
    }
});
transactionServices.controller('TransaStatusCtrl', ['$scope', 'TransactionStatus', '$route', function($scope, TransactionStatus, $route) {
    $scope.transaction_status_id = 1;
    var getTransactionStatusD = TransactionStatus.get($scope.transaction_status_id);
    getTransactionStatusD.success(function(response) {
        $scope.transaction_status = response;
        $scope.TransactionTypesDashb = $scope.transaction_status.id;
    });
}]);
transactionServices.factory("TransactionStatus", function($http) {

    return {
        all: function() {
            var request = $http({
                method: 'GET',
                url: 'api/transaction_status'
            });
            return request;
        },
        create: function(data) {
            var request = $http({
                method: 'GET',
                url: 'api/transaction_status/create',
                params: data
            });
            return request;
        },
        get: function(id) {
            var request = $http.get('api/transaction_status/' + id);
            return request;
        },
        update: function(id, data) {
            var request = $http.put('api/transaction_status/' + id, data);
            return request;
        },
        verify: function(id, data) {
            var request = $http.put('api/transaction_status/verify/' + id, data);

            return request;
        },
        approvedwithdispute: function(id, data) {
            var request = $http.put('api/transaction_status/approve_with_dispute/' + id, data);
            return request;
        },
        pause: function(id, data) {
            var request = $http.put('api/transaction_status/pause/' + id, data);
            return request;
        },
        reapprove: function(id, data) {
            var request = $http.put('api/transaction_status/reapprove/' + id, data);
            return request;
        },
        cancel: function(id, data) {
            var request = $http.put('api/transaction_status/cancel/' + id, data);
            return request;
        },
        delete: function(id) {
            //delete a specific post
        }
    }

});

transactionServices.factory("TrxComments", function($http) {

    return {
        all: function() {
            var request = $http({
                method: 'GET',
                url: 'api/trx_comments'
            });
            return request;
        },
        create: function(data) {
            var request = $http({
                method: 'GET',
                url: 'api/trx_comments/create',
                params: data
            });
            return request;
        },
        get: function(id) {
            var request = $http.get('api/trx_comments/fetch/' + id);
            return request;
        },
        delete: function(id) {
            //delete a specific post
        }
    }
});


transactionServices.factory("TransactionTypes", function($http) {

    return {
        all: function() {
            var request = $http({
                method: 'GET',
                url: 'api/transactions_types'
            });
            return request;
        },
        create: function(data) {
            var request = $http({
                method: 'GET',
                url: 'api/transactions_types/create',
                params: data
            });
            return request;
        },
        get: function(id) {
            var request = $http.get('api/transactions_types/' + id);
            return request;
        },
        update: function(id, data) {
            var request = $http.put('api/transactions_types/' + id, data);
            return request;
        },
        delete: function(id) {
            //delete a specific post
        }
    }

});
transactionServices.factory("BizAreas", function($http) {

    return {
        all: function() {
            var request = $http({
                method: 'GET',
                url: 'api/biz_areass'
            });
            return request;
        },
        create: function(data) {
            var request = $http({
                method: 'GET',
                url: 'api/biz_areass/create',
                params: data
            });
            return request;
        },
        get: function(id) {
            var request = $http.get('api/biz_areass/' + id);
            return request;
        },
        update: function(id, data) {
            var request = $http.put('api/biz_areass/' + id, data);
            return request;
        },
        delete: function(id) {
            //delete a specific post
        }
    }

});

transactionServices.factory("Transaction_dispute", function($http) {
    return {
        get: function(id) {
            var request = $http.get('api/transaction_dispute/details/' + id);
            return request;
        }
    }
});
transactionServices.controller('BillerTxtCtrl', function($rootScope, $scope, $stateParams, $state, $route, TransactionStatus, Session, BillerTxt, $cookies, $cookieStore, $location) {
    var vm = this;
    var filterData = {};
    $scope.isLoading = true;
    vm.isLoading = false;
    vm.search = search;
    vm.billervm = {};
    vm.dueDateFromOpened = false;
    vm.dueDateToOpened = false;
    vm.dueDateFromOpened = false;
    vm.open = open;
    vm.filterStatus = filterStatus;
    vm.billervm.filterBy = {
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
    $scope.biller_id = Session.customer_id();
    if ($rootScope.number) filterData.number = $rootScope.number;
    if ($rootScope.rnumber) filterData.rnumber = $rootScope.rnumber;
    if ($rootScope.dueDateFromCol) filterData.dueDateFromCol = $rootScope.dueDateFromCol;
    if ($rootScope.dueDateToCol) filterData.dueDateToCol = $rootScope.dueDateToCol;
    if ($rootScope.search_type) filterData.search_type = $rootScope.search_type;
    if ($rootScope.payor) filterData.payor = $rootScope.payor;
    if ($rootScope.category) filterData.category = $rootScope.category;
    if ($rootScope.type) filterData.type = $rootScope.type;
    filterData.transactions_status_id = $rootScope.transactions_status_id;
    filterData.biller_id = Session.customer_id();
    var getTransactions = BillerTxt.searchTxtBiller(filterData);
    getTransactions.success(function(response) {

        $scope.isLoading = false;
        $scope.transaction_biller = response;
        clearSearchData();
        $scope.currentPage = 1; //current page
        $scope.entryLimit = 10; //max no of items to display in a page
        $scope.filteredItems = $scope.transaction_biller.length; //Initially for no filter

        $scope.totalItems = $scope.transaction_biller.length;

        $scope.filter = function() {
            $timeout(function() {
                $scope.filteredItems = $scope.filtered.length;
            }, 10);
        };
        $scope.sort_by = function(predicate) {
            $scope.predicate = predicate;
            $scope.reverse = !$scope.reverse;
        };
        $scope.$watch('currentPage + entryLimit', function() {
            vm.isLoading = true;
            var begin = (($scope.currentPage - 1) * $scope.entryLimit),
                end = begin + $scope.entryLimit;
            $scope.filteredTodos = $scope.transaction_biller.slice(begin, end);
            vm.isLoading = false;
        });

    });

    function clearSearchData() {
        $rootScope.number = '';
        $rootScope.rnumber = '';
        $rootScope.dueDateFromCol = '';
        $rootScope.dueDateToCol = '';
        $rootScope.search_type = '';
        $rootScope.payor = '';
        $rootScope.category = '';
        $rootScope.type = '';
        //$rootScope.transactions_status_id = '';
    }

    function filterStatus(status_txn_id) {

        var details = {};
        details.biller_id = Session.customer_id();
        $rootScope.biller_id = Session.customer_id();
        $rootScope.transactions_status_id = status_txn_id;
        details.transactions_status_id = status_txn_id;
        $state.reload();

    }

    function search(inputData) {

        $rootScope.biller_id = Session.customer_id();
        $rootScope.number = inputData.filterBy.numberCol;
        $rootScope.rnumber = inputData.filterBy.relatedNbrCol;
        $rootScope.dueDateFromCol = inputData.filterBy.dueDateFromCol;
        $rootScope.dueDateToCol = inputData.filterBy.dueDateToCol;
        $rootScope.search_type = 2;
        if (inputData.filterBy.payorName) $rootScope.payor = inputData.filterBy.payorName.id;
        if (inputData.filterBy.myArea) $rootScope.category = vm.billervm.filterBy.myArea.id;
        if (inputData.filterBy.myTransatype) $rootScope.type = inputData.filterBy.myTransatype.id;

        $state.reload();

    }

    function open($event, datepickerName) {

        switch (datepickerName) {
            case 'from':
                vm.dueDateFromOpened = !0
                break;
            case 'to':
                vm.dueDateToOpened = !0
                break;
            case 'frompayorvm':
                vm.dueDateFrompayorvmOpened = !0
                break;
            case 'topayorvm':
                vm.dueDateTopayorvmOpened = !0
                break;
        }

        return $event.preventDefault(),
            $event.stopPropagation()

    }



    vm.toggleDetail = toggleDetail;
    //vm.billerStatus = billerStatus;
    //    vm.filterStatus = filterStatus;
    //JRB 04/26/2014  Refactoring Pupilo's code.
    $stateParams.id = 0;

    function toggleDetail(txn) {
        if (!txn) {
            return;
        }
        var visible = !txn.detailsVisbile;
        $stateParams.id = txn.id;
        vm.txn = txn;
        vm.idRequested = txn.id;
        if (!visible) {
            var divid = '#' + txn.id;
            $(divid).remove();
        }
        txn.detailsVisbile = visible;
        txn.showInlineAttchment = false;
    };
});
transactionServices.factory("BillerTxt", function($http) {

    return {
        searchTxtBiller: function(data) {
            var request = $http({
                method: 'GET',
                url: 'api/transaction_biller',
                params: data
            });
            // var request = $http.put('api/transaction_biller/',data);
            return request;
        }
    }

});

transactionServices.controller('CustomerTxtCtrl', function($rootScope, $scope, $stateParams, $state, $route, TransactionStatus, Session, CustomerTxt, $cookies, $cookieStore, $location) {
    var vm = this;
    var filterData = {};
    $scope.isLoading = true;
    vm.isLoading = false;
    vm.search = search;
    vm.billervm = {};
    vm.dueDateFromOpened = false;
    vm.dueDateToOpened = false;
    vm.dueDateFromOpened = false;
    vm.open = open;
    vm.filterStatus = filterStatus;
    vm.billervm.filterBy = {
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
    $scope.biller_id = Session.customer_id();
    if ($rootScope.number) filterData.number = $rootScope.number;
    if ($rootScope.rnumber) filterData.rnumber = $rootScope.rnumber;
    if ($rootScope.dueDateFromCol) filterData.dueDateFromCol = $rootScope.dueDateFromCol;
    if ($rootScope.dueDateToCol) filterData.dueDateToCol = $rootScope.dueDateToCol;
    if ($rootScope.search_type) filterData.search_type = $rootScope.search_type;
    if ($rootScope.payor) filterData.payor = $rootScope.payor;
    if ($rootScope.category) filterData.category = $rootScope.category;
    if ($rootScope.type) filterData.type = $rootScope.type;
    filterData.transactions_status_id = $rootScope.transactions_status_id;
    filterData.biller_id = Session.customer_id();
    var getTransactions = CustomerTxt.searchTxtCustomer(filterData);
    getTransactions.success(function(response) {

        $scope.isLoading = false;
        $scope.transaction_biller = response;
        clearSearchData();
        $scope.currentPage = 1; //current page
        $scope.entryLimit = 10; //max no of items to display in a page
        $scope.filteredItems = $scope.transaction_biller.length; //Initially for no filter

        $scope.totalItems = $scope.transaction_biller.length;

        $scope.filter = function() {
            $timeout(function() {
                $scope.filteredItems = $scope.filtered.length;
            }, 10);
        };
        $scope.sort_by = function(predicate) {
            $scope.predicate = predicate;
            $scope.reverse = !$scope.reverse;
        };
        $scope.$watch('currentPage + entryLimit', function() {
            vm.isLoading = true;
            var begin = (($scope.currentPage - 1) * $scope.entryLimit),
                end = begin + $scope.entryLimit;
            $scope.filteredTodos = $scope.transaction_biller.slice(begin, end);
            vm.isLoading = false;
        });

    });

    function clearSearchData() {
        $rootScope.number = '';
        $rootScope.rnumber = '';
        $rootScope.dueDateFromCol = '';
        $rootScope.dueDateToCol = '';
        $rootScope.search_type = '';
        $rootScope.payor = '';
        $rootScope.category = '';
        $rootScope.type = '';
        //$rootScope.transactions_status_id = '';
    }

    function filterStatus(status_txn_id) {

        var details = {};
        details.biller_id = Session.customer_id();
        $rootScope.biller_id = Session.customer_id();
        $rootScope.transactions_status_id = status_txn_id;
        details.transactions_status_id = status_txn_id;
        $state.reload();

    }

    function search(inputData) {

        $rootScope.biller_id = Session.customer_id();
        $rootScope.number = inputData.filterBy.numberCol;
        $rootScope.rnumber = inputData.filterBy.relatedNbrCol;
        $rootScope.dueDateFromCol = inputData.filterBy.dueDateFromCol;
        $rootScope.dueDateToCol = inputData.filterBy.dueDateToCol;
        $rootScope.search_type = 2;
        if (inputData.filterBy.payorName) $rootScope.payor = inputData.filterBy.payorName.id;
        if (inputData.filterBy.myArea) $rootScope.category = vm.billervm.filterBy.myArea.id;
        if (inputData.filterBy.myTransatype) $rootScope.type = inputData.filterBy.myTransatype.id;

        $state.reload();

    }

    function open($event, datepickerName) {

        switch (datepickerName) {
            case 'from':
                vm.dueDateFromOpened = !0
                break;
            case 'to':
                vm.dueDateToOpened = !0
                break;
            case 'frompayorvm':
                vm.dueDateFrompayorvmOpened = !0
                break;
            case 'topayorvm':
                vm.dueDateTopayorvmOpened = !0
                break;
        }

        return $event.preventDefault(),
            $event.stopPropagation()

    }



    vm.toggleDetail = toggleDetail;
    //vm.billerStatus = billerStatus;
    //    vm.filterStatus = filterStatus;
    //JRB 04/26/2014  Refactoring Pupilo's code.
    $stateParams.id = 0;

    function toggleDetail(txn) {
        if (!txn) {
            return;
        }
        var visible = !txn.detailsVisbile;
        $stateParams.id = txn.id;
        vm.txn = txn;
        vm.idRequested = txn.id;
        if (!visible) {
            var divid = '#' + txn.id;
            $(divid).remove();
        }
        txn.detailsVisbile = visible;
        txn.showInlineAttchment = false;
    };
});

transactionServices.factory("CustomerTxt", function($http) {

    return {
        searchTxtCustomer: function(data) {
            var request = $http({
                method: 'GET',
                url: 'api/transaction_customer',
                params: data
            });
            // var request = $http.put('api/transaction_biller/',data);
            return request;
        }
    }

});

transactionServices.factory("ListBiller", function($http) {

    return {
        listSortedBiller: function(id) {
            var request = $http.get('api/biller_list_first_selected/' + id);
            return request;
        }
    }
});
transactionServices.controller('CountAllBillerTxtCtrl', function($scope, $stateParams, $state, Session, CountAllBillerTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountAllBillerTxt.countAllBillerTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_all_transactions = response;
    });
});
transactionServices.factory("CountAllBillerTxt", function($http) {

    return {
        countAllBillerTxt: function(id) {
            var request = $http.get('api/count_all_transactions/' + id);
            return request;
        }
    }

});
transactionServices.controller('CountPendingBillerTxtCtrl', function($scope, $stateParams, $state, Session, CountPendingBillerTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountPendingBillerTxt.countPendingBillerTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_pending_transaction = response;
    });
});
transactionServices.factory("CountPendingBillerTxt", function($http) {

    return {
        countPendingBillerTxt: function(id) {
            var request = $http.get('api/count_pending_transaction/' + id);
            return request;
        }
    }

});
transactionServices.controller('CountVerifiedBillerTxtCtrl', function($scope, $stateParams, $state, Session, CountVerifiedBillerTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountVerifiedBillerTxt.countVerifiedBillerTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_verified_transaction = response;
    });
});
transactionServices.factory("CountVerifiedBillerTxt", function($http) {

    return {
        countVerifiedBillerTxt: function(id) {
            var request = $http.get('api/count_verified_transaction/' + id);
            return request;
        }
    }

});
transactionServices.controller('CountApprovedBillerTxtCtrl', function($scope, $stateParams, $state, Session, CountApprovedBillerTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountApprovedBillerTxt.countApprovedBillerTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_approved_transaction = response;
    });
});
transactionServices.factory("CountApprovedBillerTxt", function($http) {

    return {
        countApprovedBillerTxt: function(id) {
            var request = $http.get('api/count_approved_transaction/' + id);
            return request;
        }
    }

});
transactionServices.controller('CountDisputeBillerTxtCtrl', function($scope, $stateParams, $state, Session, CountDisputedBillerTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountDisputedBillerTxt.countDisputedBillerTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_disputed_transaction = response;
    });
});
transactionServices.factory("CountDisputedBillerTxt", function($http) {

    return {
        countDisputedBillerTxt: function(id) {
            var request = $http.get('api/count_disputed_transaction/' + id);
            return request;
        }
    }

});

transactionServices.controller('PayorTxtCtrl', function($rootScope, $scope, $stateParams, $state, Session, PayorTxt, $cookies, $cookieStore, $location) {
    var vm = this;
    vm.isLoading = false;
    $scope.isLoading = true;
    vm.dueDateFromOpened = false;
    vm.dueDateToOpened = false;
    vm.dueDateFrompayorvmOpened = false;
    vm.dueDateTopayorvmOpened = false;
    vm.open = open;
    vm.search = search;
    vm.payorvm = {};
    vm.payorvm.filterBy = {
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

    var filterData = {};
    filterData.payor_id = Session.customer_id();
    filterData.transactions_status_id = $rootScope.transactions_status_id;
    if ($rootScope.number) filterData.number = $rootScope.number;
    if ($rootScope.rnumber) filterData.rnumber = $rootScope.rnumber;
    if ($rootScope.dueDateFromCol) filterData.dueDateFromCol = $rootScope.dueDateFromCol;
    if ($rootScope.dueDateToCol) filterData.dueDateToCol = $rootScope.dueDateToCol;
    if ($rootScope.search_type) filterData.search_type = $rootScope.search_type;
    if ($rootScope.biller) filterData.biller = $rootScope.biller;
    if ($rootScope.category) filterData.category = $rootScope.category;
    if ($rootScope.type) filterData.type = $rootScope.type;

    var getTransactions = PayorTxt.searchTxtPayor(filterData);
    getTransactions.success(function(response) {
        $scope.isLoading = false;
        $scope.transaction_payor = response;

        clearSearchData();

        $scope.currentPage = 1; //current page
        $scope.entryLimit = 10; //max no of items to display in a page
        $scope.filteredItems = $scope.transaction_payor.length; //Initially for no filter

        $scope.totalItems = $scope.transaction_payor.length;


        $scope.filter = function() {
            $timeout(function() {
                $scope.filteredItems = $scope.filtered.length;
            }, 10);
        };

        $scope.filter = function() {
            $timeout(function() {
                $scope.filteredItems = $scope.filtered.length;
            }, 10);
        };
        $scope.sort_by = function(predicate) {
            $scope.predicate = predicate;
            $scope.reverse = !$scope.reverse;
        };
        $scope.$watch('currentPage + entryLimit', function() {
            vm.isLoading = true;
            var begin = (($scope.currentPage - 1) * $scope.entryLimit),
                end = begin + $scope.entryLimit;
            $scope.filteredTodos = $scope.transaction_payor.slice(begin, end);
            vm.isLoading = false;
        });
    });

    function clearSearchData() {
        $rootScope.number = '';
        $rootScope.rnumber = '';
        $rootScope.dueDateFromCol = '';
        $rootScope.dueDateToCol = '';
        $rootScope.search_type = '';
        $rootScope.biller = '';
        $rootScope.category = '';
        $rootScope.type = '';
        //$rootScope.transactions_status_id = '';
    }

    //  var status_txn_id = 0;

    function payorStatus(status_txn_id) {
        var details = {};
        details.payor_id = Session.customer_id();
        $rootScope.payor_id = Session.customer_id();
        $rootScope.transactions_status_id = status_txn_id;
        $state.reload("#payor_table");
    }

    function search(inputData) {
        $rootScope.payor_id = Session.customer_id();
        $rootScope.number = inputData.filterBy.numberCol;
        $rootScope.rnumber = inputData.filterBy.relatedNbrCol;
        $rootScope.dueDateFromCol = inputData.filterBy.dueDateFromCol;
        $rootScope.dueDateToCol = inputData.filterBy.dueDateToCol;
        $rootScope.search_type = 2;
        if (inputData.filterBy.billerCol) $rootScope.biller = inputData.filterBy.billerCol.id;
        if (inputData.filterBy.categoryCol) $rootScope.category = inputData.filterBy.categoryCol.id;
        if (inputData.filterBy.typeCol) $rootScope.type = inputData.filterBy.typeCol.id;

        $state.reload("#payor_table");
    }


    vm.toggleDetail = toggleDetail;
    vm.payorStatus = payorStatus;
    //JRB 04/26/2014  Refactoring Pupilo's code.
    $stateParams.id = 0;

    function toggleDetail(txn) {
        if (!txn) {
            return;
        }
        var visible = !txn.detailsVisbile;
        $stateParams.id = txn.id;
        vm.txn = txn;
        vm.idRequested = txn.id;
        if (!visible) {
            var divid = '#' + txn.id;
            $(divid).remove();
        }
        txn.detailsVisbile = visible;
        txn.showInlineAttchment = false;

    };

    function open($event, datepickerName) {

        switch (datepickerName) {
            case 'from':
                vm.dueDateFromOpened = !0
                break;
            case 'to':
                vm.dueDateToOpened = !0
                break;
            case 'frompayorvm':
                vm.dueDateFrompayorvmOpened = !0
                break;
            case 'topayorvm':
                vm.dueDateTopayorvmOpened = !0
                break;
        }

        return $event.preventDefault(),
            $event.stopPropagation()

    }


});
transactionServices.factory("PayorTxt", function($http) {

    return {
        searchTxtPayor: function(data) {
            var request = $http({
                method: 'GET',
                url: 'api/transaction_payor',
                params: data
            });
            // var request = $http.put('api/transaction_biller/',data);
            return request;
        }
    }

});
transactionServices.factory("ListSortedPayor", function($http) {

    return {
        listSortedPayor: function(id) {
            var request = $http.get('api/payor_list_first_selected/' + id);
            return request;
        }
    }
});
transactionServices.controller('CountAllPayorTxtCtrl', function($scope, $stateParams, $state, Session, CountAllPayorTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountAllPayorTxt.countAllPayorTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_all_payor_transactions = response;
    });
});
transactionServices.factory("CountAllPayorTxt", function($http) {

    return {
        countAllPayorTxt: function(id) {
            var request = $http.get('api/count_all_payor_transactions/' + id);
            return request;
        }
    }

});
transactionServices.controller('CountPendingPayorTxtCtrl', function($scope, $stateParams, $state, Session, CountPendingPayorTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountPendingPayorTxt.countPendingPayorTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_pending_transaction_transaction = response;
    });
});
transactionServices.factory("CountPendingPayorTxt", function($http) {

    return {
        countPendingPayorTxt: function(id) {
            var request = $http.get('api/count_pending_transaction_transaction/' + id);
            return request;
        }
    }

});
transactionServices.controller('CountVerifiedPayorTxtCtrl', function($scope, $stateParams, $state, Session, CountVerifiedPayorTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountVerifiedPayorTxt.countVerifiedPayorTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_verified_payor_transaction = response;
    });
});
transactionServices.factory("CountVerifiedPayorTxt", function($http) {

    return {
        countVerifiedPayorTxt: function(id) {
            var request = $http.get('api/count_verified_payor_transaction/' + id);
            return request;
        }
    }

});

transactionServices.factory("Transaction_history", function($http) {

    return {
        get: function(id) {
            var request = $http.get('api/transaction_history/' + id);
            return request;
        },
        dispute: function(id) {
            var request = $http.get('api/transaction_history/dispute/' + id);
            return request;
        }
    }

});

transactionServices.controller('CountApprovedPayorTxtCtrl', function($scope, $stateParams, $state, Session, CountApprovedPayorTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountApprovedPayorTxt.countApprovedPayorTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_approved_payor_transaction = response;
    });
});
transactionServices.factory("CountApprovedPayorTxt", function($http) {

    return {
        countApprovedPayorTxt: function(id) {
            var request = $http.get('api/count_approved_payor_transaction/' + id);
            return request;
        }
    }

});
transactionServices.controller('CountDisputePayorTxtCtrl', function($scope, $stateParams, $state, Session, CountDisputedPayorTxt) {

    $scope.id = Session.customer_id();
    var getTransactions = CountDisputedPayorTxt.countDisputedPayorTxt($scope.id);
    getTransactions.success(function(response) {
        $scope.count_disputed_payor_transaction = response;
    });
});
transactionServices.factory("CountDisputedPayorTxt", function($http) {

    return {
        countDisputedPayorTxt: function(id) {
            var request = $http.get('api/count_disputed_payor_transaction/' + id);
            return request;
        }
    }

});