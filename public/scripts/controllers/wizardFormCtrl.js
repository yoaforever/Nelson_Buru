(function () {
    "use strict";
    angular.module("myApp.wizardFormCtrl", [])
      .controller("wizardFormCtrl",
        ["$scope",
            function ($scope) {
                return $scope.wizard = {
                    firstName: "some name",
                    lastName: "",
                    email: "",
                    password: "",
                    age: "",
                    address: ""
                },
                    $scope.isValidateStep1 = function () {
                        return void 0
                    },
                    $scope.finishedWizard = function () {
                        return void 0
                    }
            }])
})();