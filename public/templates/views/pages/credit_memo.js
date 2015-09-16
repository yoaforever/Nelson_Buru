var creditMemo = angular.module('creditMemo', ['ngRoute', 'ngResource']);

creditMemo.controller('creditMemoCtrl', function ($scope, $stateParams, $state, Customer, Session, Transactions, toaster) {


    var getCustomer = Customer.all();
    getCustomer.success(function (response) {
        $scope.customers = response;
    });
    
        var getTransactions = Transactions.all();
    getTransactions.success(function (response) {
        $scope.txns = response;
    });

    $scope.cancel = function () {
        $state.reload();
    };
});


creditMemo.factory("Customer", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/customers'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/customers/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/customers/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/customers/' + id, data);
            return request;
        },

        getbankinfo:function (id) {
            var request = $http.get('api/customerbankinfo/' + id);
            return request;
        },
        updatebankinfo:function (id,data) {
            var request = $http.put('api/updatecustomerbankinfo/' + id,data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

});

creditMemo.factory("Transactions", function ($http) {

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
            var request = $http.get('api/transactions/' + id);
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