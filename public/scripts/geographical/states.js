
var myState = angular.module('myState', ['ngRoute', 'ngResource'])

.controller('StateCtrl', function ($scope, $stateParams, $state, States) {

    var getStates = States.all();

    getStates.success(function (response) {
        $scope.states = response;
    });
    
    })

//        .factory('States', function ($resource) {
//            return $resource('api/states/:id', {id: "@_id"}, {
//        update: {method: "PUT", params: {id: "@id"}},
//            })
//        })
        
   .factory("States", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/states'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/states/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/states/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/states/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    };

});