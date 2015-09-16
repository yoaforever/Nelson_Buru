
var myAttachments = angular.module('myAttachments', ['ngRoute', 'ngResource']);


        myAttachments.controller('AttachmentAllCtrl', ['$scope', 'TransactionTypes','$route', function ($scope, TransactionTypes, $route) {
              var getTransactionTypes = TransactionTypes.all();

                getTransactionTypes.success(function (response) {
                    $scope.transactions_types = response;
                });
            }]);
        
//         myAttachments.controller('AttachmentTypeCtrl', ['$scope', 'TransactionTypes','$route', function ($scope, TransactionTypes, $route) {
//               $scope.transactions_type_id = $scope.txn.transactions_types_id;
//                var getTransactionTypesDashb = TransactionTypes.get($scope.transactions_type_id);
//                getTransactionTypesDashb.success(function (response) {
//                    $scope.transactions_types = response;
//                    $scope.TransactionTypesDashb = $scope.transactions_types.description;
//
//                });
//            }]);

//    myTransatypes.factory("TransactionTypes", function ($http) {
//
//    return{
//        all: function () {
//            var request = $http({method: 'GET', url: 'api/transactions_types'});
//            return request;
//        },
//        create: function (data) {
//            var request = $http({method: 'GET', url: 'api/transactions_types/create', params: data});
//            return request;
//        },
//        get: function (id) {
//            var request = $http.get('api/transactions_types/' + id);
//            return request;
//        },
//        update: function (id, data) {
//            var request = $http.put('api/transactions_types/' + id, data);
//            return request;
//        },
//        delete: function (id) {
//            //delete a specific post
//        }
//    }
//
//})