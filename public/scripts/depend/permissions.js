
var Permission = angular.module('Permission', ['ngRoute', 'ngResource'])

        .controller('PermissionCtrl', ['$scope', 'BizAreas', '$route', function ($scope, Permissions, $route) {
                var getPermissions = Permissions.all();
                getPermissions.success(function (response) {
                    $scope.permissions = response;
                });
            }]);





Permission.factory("Permissions", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/permissions'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/permissions/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/permissions/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/permissions/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

})