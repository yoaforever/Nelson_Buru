
var myCity = angular.module('myCity', ['ngRoute', 'ngResource'])

//
//        .controller('CityCtrl', ['$scope', 'Citys','$route', function ($scope, Citys, $route) {
//               Citys.get(function(data){
//                 $scope.citys =data.citys; 
//                 $scope.myCity = $scope.citys[0];
//                 
//               })
//            }])

.controller('CityCtrl', function ($scope, $stateParams, $state, Citys) {

    var getCities = Citys.all();

    getCities.success(function (response) {
        $scope.citys = response;
    });
    
    })




//        .factory('Citys', function ($resource) {
//            return $resource('api/citys/:id', {id: "@_id"}, {
//        update: {method: "PUT", params: {id: "@id"}},
//            })
//        })
        
         .factory("Citys", function ($http) {

            return{
                all: function () {
                    var request = $http({method: 'GET', url: 'api/citys'});
                    return request;
                },
                create: function (data) {
                    var request = $http({method: 'GET', url: 'api/citys/create', params: data});
                    return request;
                },
                get: function (id) {
                    var request = $http.get('api/citys/' + id);
                    return request;
                },
                update: function (id, data) {
                    var request = $http.put('api/citys/' + id, data);
                    return request;
                },
                delete: function (id) {
                    //delete a specific post
                }
            };

        });