
var myBizArea = angular.module('myBizArea', ['ngRoute', 'ngResource'])

        .controller('BizAreaCtrl', ['$scope', 'BizAreas', '$route', function ($scope, BizAreas, $route) {
                var getCustomers = BizAreas.all();
                getCustomers.success(function (response) {
                    $scope.biz_areass = response;
                });
            }])


        .controller('BizAreaDasbCtrl', ['$scope', 'BizAreas', '$route', function ($scope, BizAreas, $route) {

                $scope.biz_area_id = $scope.txn.biz_area_id;
                var getAreaSelect = BizAreas.get($scope.biz_area_id);
                getAreaSelect.success(function (response) {
                    $scope.biz_areass = response;
                    $scope.BizAreadashb = $scope.biz_areass[0];

                });
            }]);




myBizArea.factory("BizAreas", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/biz_areass'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/biz_areass/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/biz_areass/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/biz_areass/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

})