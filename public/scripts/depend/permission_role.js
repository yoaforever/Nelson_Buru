
var PermissionRole = angular.module('PermissionRole', ['ngRoute', 'ngResource'])

        .controller('PermissionRoleCtrl', ['$scope', 'PermissionsRole', '$route', function ($scope, PermissionsRole, $route) {
                $scope.id = Session.customer_id();
                var getPermisosRole = PermissionsRole.searchPermissoRole($scope.id);

                getPermisosRole.success(function (response) {
                    $scope.permission_role = response;
                });
            }]);






PermissionRole.factory("PermissionsRole", function ($http) {

    return{
        searchPermissoRole: function (id) {
            var request = $http.get('api/permission_role/' + id);
            return request;
        }
    }

});