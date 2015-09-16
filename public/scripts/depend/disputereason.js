
var DisputeReason = angular.module('DisputeReason', ['ngRoute', 'ngResource']);


        DisputeReason.controller('DisputeReasonCtrl', ['$scope', 'DisputeReason','$route', function ($scope, DisputeReason, $route) {
              var getDisputeReason = DisputeReason.all();

                getDisputeReason.success(function (response) {
                    $scope.dispute_reason = response;
                });
            }]);
        
//         DisputeReason.controller('TransatypesDashbCtrl', ['$scope', 'TransactionTypes','$route', function ($scope, TransactionTypes, $route) {
//               $scope.transactions_type_id = $scope.txn.transactions_types_id;
//                var getTransactionTypesDashb = TransactionTypes.get($scope.transactions_type_id);
//                getTransactionTypesDashb.success(function (response) {
//                    $scope.transactions_types = response;
//                    $scope.TransactionTypesDashb = $scope.transactions_types.description;
//
//                });
//            }]);

    DisputeReason.factory("DisputeReason", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/dispute_reason'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/dispute_reason/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/dispute_reason/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/dispute_reason/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    };

});