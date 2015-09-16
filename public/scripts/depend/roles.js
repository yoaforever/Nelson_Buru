
var Role = angular.module('Role', ['ngRoute', 'ngResource'])

        .controller('RoleCtrl', ['$scope', 'Roles', '$route', function ($scope, Roles, $route) {
                var getRoles = Roles.all();
                getRoles.success(function (response) {
                    $scope.roles = response;
                     $scope.myRol = $scope.roles[0].id;
                });
            }]);





Role.factory("Roles", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/roles'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/roles/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/roles/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/roles/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

})