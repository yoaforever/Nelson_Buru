var myReport = angular.module('myReport', ['ngResource']);

myReport.controller('ReportCtrl', ['$scope', '$stateParams', '$state', 'Report', function ($scope, $stateParams, $state, Report) {


        var getReport = Report.all();
        getReport.success(function (response) {
            $scope.report = response;

        });
        
         var getFailedImportReport= Report.getFailedImportReport();
        getFailedImportReport.success(function (response) {
            $scope.failed = response; 
//            alert($scope.failed[0].description);

        });
        
//         $scope.submit = function () {
//        $scope.new.myState = $scope.new.myState.id;
//        $scope.new.myCity = $scope.new.myCity.id;
//        $scope.new.myCountry = $scope.new.myCountry.id;
//        var request = Customer.create($scope.new);
//        request.success(function (response) {
//            $scope.flash = response.status;
//            // $state.go($state.$current, null, { reload: true });
//            $state.reload();
//        });
//    };

        var vm = this;

//YCR 07/08/2014
        vm.open = open;
        vm.departureDateOpened = false;
        vm.dueDateOpened = false;
//                 $scope.transactions.departure_date = vm.transactions.departure_date;

        function open($event, datepickerName) {

            switch (datepickerName) {
                case 'departureDateOpened':
                    vm.departureDateOpened = !0
                    break;
                case 'dueDateOpened':
                    vm.dueDateOpened = !0
                    break;
                case 'arrivalDateOpened':
                    vm.arrivalDateOpened = !0
                    break;
                case 'topayorvm':
                    vm.dueDateToOpened = !0
                    break;
            }

            return $event.preventDefault(),
                    $event.stopPropagation()

        }

    }]);




myReport.factory("Report", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/report'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/report/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/report/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/report/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        },
        
         getFailedImportReport: function () {
            var request = $http({method: 'GET', url: 'api/report/failed_import_report'});
            return request;
        },
    }

});







