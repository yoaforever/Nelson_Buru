
var myCountry = angular.module('myCountry', ['ngRoute', 'ngResource'])


.controller('CountryCtrl', function ($scope, $stateParams, $state, Countrys) {

    var getCountries = Countrys.all();

    getCountries.success(function (response) {
        $scope.countrys = response;
        $scope.mCountry = $scope.countrys.name;
        $scope.myCountry = $scope.countrys[0].name;
    });
    
    })


//        .factory('Countrys', function ($resource) {
//            return $resource('api/countrys/:id', {id: "@_id"}, {
//                update: {method: "PUT", params: {id: "@id"}},
//            })
//        })

        .factory("Countrys", function ($http) {

            return{
                all: function () {
                    var request = $http({method: 'GET', url: 'api/countrys'});
                    return request;
                },
                create: function (data) {
                    var request = $http({method: 'GET', url: 'api/countrys/create', params: data});
                    return request;
                },
                get: function (id) {
                    var request = $http.get('api/countrys/' + id);
                    return request;
                },
                update: function (id, data) {
                    var request = $http.put('api/countrys/' + id, data);
                    return request;
                },
                delete: function (id) {
                    //delete a specific post
                }
            };

        });