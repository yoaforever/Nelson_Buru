var transactionDisputeService = angular.module('transactionDispute', ['ngResource']);

transactionDisputeService.controller('MyDisputeCtrl', function (common,$scope, $route, $location, $stateParams, $state,$routeParams,logger,Session,Customer,Transactions,DisputeReasons,DisputeCategories,TransactionDispute) {

		var vm = this;

		var validator = common.validator.validateDispute();
		
		var notification = common.notification;

        vm.validator = validator;
		
		// Bindable properties and functions are placed on vm..
        vm.save = save;

        //Transaction
        vm.disputeinfo = {
            parenttransaction: {},
            dispute: {},
            isTransactionApproved: false
        };

        //Dispute Category
        vm.disputecategories = [];
        vm.selecteddisputecategory = {};
        vm.disputecategoryIsValid = true;

        //Dispute Reson
        vm.disputereasons = [];
        vm.selecteddisputereason = {};
        vm.disputereasonIsValid = true;

        //Amount 
        vm.amountIsValid = true;

        //JRB 03/30/2014
        vm.isValid = true;
        vm.isSaving = false;

        //YCR 3/5/2014
        vm.hasChanges = hasChanges;
        vm.canSave = canSave;
        vm.goToDashboard = goToDashboard;
        //YCR 11/6/2014
        vm.currentcustomer = {};
		
		
		
		var reasons = DisputeReasons.all();
		
		reasons.success(function (response) {
			vm.disputereasons = response;
		});
		
		var categories = DisputeCategories.all();
		
		categories.success(function (response) {
			vm.disputecategories = response;
		});
		
		var idOrtype = $location.path().substring($location.path().lastIndexOf('/') + 1);
		
		var getTransaction = Transactions.get(idOrtype);
	    getTransaction.success(function (response) {
			$scope.biller_id = response.biller_id;
	        var cust = Customer.get($scope.biller_id);
	        cust.success(function (response) {
				vm.legal_name = response.legal_name;
	        });
		});
		
		
		
		vm.title = 'Dispute Transaction';
		
		
		
		function validation() {

            var result = vm.validator.isValid(vm, vm.validator.validateObject);

            if (!result.isValid) {
                logger.logError('Please check required fields');
            }
            return result.isValid;
        }
		
		var dinfo = Transactions.get(idOrtype);
		
		dinfo.success(function (response) {
	    
			vm.disputeinfo.parenttransaction = response;
			vm.disputeinfo.parenttransaction.number = vm.disputeinfo.parenttransaction.number;
			vm.disputeinfo.isTransactionApproved = vm.disputeinfo.parenttransaction.transactions_status_id === 'PENDING';
		});
		
		function save() {
			if (canSave() && validation()) {
				vm.showLoading = true;
				vm.disputeinfo.dispute.disputeCategoryId = vm.selecteddisputecategory.id;
                vm.disputeinfo.dispute.disputeReasonId = vm.selecteddisputereason.id;
				vm.disputeinfo.dispute.disputedAmount = vm.disputeinfo.parenttransaction.disputedAmount;
				vm.disputeinfo.dispute.customerId = Session.customer_id();
				vm.disputeinfo.dispute.userId = Session.id();
				vm.disputeinfo.dispute.transactions_id = idOrtype;
				vm.disputeinfo.dispute.description = vm.disputeinfo.dispute.description;
				var request = TransactionDispute.create(vm.disputeinfo.dispute);
		        request.success(function (response) {
					vm.showLoading = false;
		            complete();
		        });
			}
		 }
		function complete() {
			vm.isSaving = false;
		    logger.logSuccess('Saved successfully');
			logger.log('Email send successfully');
		};
		function hasChanges() {
			return datacontext.hasChanges();
		}

        //TO-DO
        function canSave() {
            return true;
        };

        function goToDashboard() {
            var url = '/dashboard/home';
            $location.path(url)
        };
		 
		
        
    });

transactionDisputeService.factory("DisputeReasons", function ($http) {
	return{
		all : function () {
			var request = $http({method: 'GET', url: 'api/dispute_reason'});
			return request;
		}
	}
});
transactionDisputeService.factory("DisputeCategories", function ($http) {
	return{
		all : function () {
			var request = $http({method: 'GET', url: 'api/dispute_category'});
			return request;
		}
	}
});
transactionDisputeService.factory("TransactionDispute", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/transaction_dispute'});
            return request;
        },
        create: function (data) {
            console.log(data);
			var request = $http({method: 'GET', url: 'api/transaction_dispute/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/transaction_dispute/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/transaction_dispute/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

});

transactionDisputeService.factory("Transactions", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/transactions'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/transactions/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/transactions/' + id, {cache: true});
            return request;
        },
		print: function (id) { //This is function is for print written by Iblesoft
            
			var request = $http.get('api/transactions/jointab/' + id);
			return request;
        },
		printAll: function (id) { //This is function is for print All written by Iblesoft
            
			var request = $http.get('api/transactions/getAll/print');
			return request;
        },
        update: function (id, data) {
            var request = $http.put('api/transactions/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }
});







