
var DisputeCategory = angular.module('DisputeCategory', ['ngRoute', 'ngResource']);


        DisputeCategory.controller('DisputeCategoryCtrl', ['$scope', 'DisputeCategory','$route', function ($scope, DisputeCategory, $route) {
              var getDisputeCategory = DisputeCategory.all();

                getDisputeCategory.success(function (response) {
                    $scope.dispute_category = response;
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

    DisputeCategory.factory("DisputeCategory", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/dispute_category'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/dispute_category/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/dispute_category/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/dispute_category/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    };

});