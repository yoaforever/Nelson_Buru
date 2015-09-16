var companyProfileServices = angular.module('companyProfileServices', ['ngRoute', 'ngResource']);


companyProfileServices.controller('EditCompanyProfileCtrl', function ($scope, $state, $stateParams,Session,Customer, CompanyProfile,OFAC_API) {
var vm = this;
 //vm.company_profile= Session.userName();
 $scope.username=Session.userName();
    var getCustomer = Customer.get(Session.customer_id());
        getCustomer.success(function(response){
             $scope.customers = response;
            $scope.company_profile = $scope.customers;
           // $scope.mycurrentcustomerName = $scope.customers.legal_name;
                         
//            var    mycurrencustomerB = $scope.mycurrentcustomer;
//                return mycurrencustomerB; 
  var getCompany = OFAC_API.companySearch('aV3XTHPs7ygpmuDw0hNaFKYmUZjdWajqmeJTFSMfIDj',$scope.company_profile.legal_name);
        getCompany.success(function(response){
             $scope.company = response;
           // $scope.mycurrentcustomerName = $scope.customers.legal_name;
                         
//            var    mycurrencustomerB = $scope.mycurrentcustomer;
//                return mycurrencustomerB; 

        });
        });
       
//$scope.company_profile.username=Session.userName();
    $scope.submit = function () {
        $stateParams.id=0;
        $stateParams.id = $scope.company_profile.id;
        $scope.company_profile.username=$scope.username;
        var request = CompanyProfile.update($stateParams.id, $scope.company_profile);
//alert($scope.username);
        request.success(function (response) {
            $scope.flash = response.status;
            // alert($scope.flash);
            $state.reload();
        });
    }

});




companyProfileServices.factory("CompanyProfile", function ($http) {

    return{
        update: function (id, data) {
            var request = $http.put('api/company_profile/' + id, data);
            return request;
        }
    };

});

companyProfileServices.factory("OFAC_API", function ($http) {

    return{
        companySearch: function (api_key,name) {
            var request = $http.get('http://ofac.openach.com/api/companySearch/' +'api_key/' + api_key +'/'+ 'name/'+ name);
            return request;
        }
    };

});