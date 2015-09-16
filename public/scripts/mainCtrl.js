/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
angular.module('mainCtrl', [])
        .controller('MainController', function ($scope, $route, $routeParams) {
            $scope.$route = $route;
            $scope.$routeParams = $routeParams;
        })

        .controller('HomeController', function ($scope) {
            $scope.name = "HomeController";
        })
        .controller('EditController', function ($scope, $routeParams) {
            $scope.name = "EditController";
            $scope.params = $routeParams;
        })
        .controller('CreateController', function ($scope) {
            $scope.name = "CreateController";
        })

