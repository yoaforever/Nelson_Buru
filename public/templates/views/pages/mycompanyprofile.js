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

  var getCompany = OFAC_API.companySearch($scope.company_profile.legal_name);
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

companyProfileServices.controller('EditBankInfoCtrl', function ($scope,logger, $state, $stateParams,Session,Customer, CompanyProfile, States, Citys, Countrys) {
	var vm = this;
	 $scope.username=Session.userName();
	 var getCustomer = Customer.getbankinfo(Session.customer_id());
     getCustomer.success(function(response){
         $scope.customer = response.customer;
		 console.log(response.customer);
         $scope.customer.citySelected     = {'id':response.customer.city_id,'name':response.customer.cityname};
         $scope.customer.stateSelected    = {'id':response.customer.state_id,'name':response.customer.statename};
         $scope.customer.countrySelected  = {'id':response.customer.country_id,'name':response.customer.countryname};
         
         var cityresponse = Citys.get(response.customer.state_id);
         cityresponse.success(function(data){
          $scope.citys = data;
          $scope.myCity = $scope.citys;
         });
         
         
         var statesresponse = States.all();
         statesresponse.success(function(data){
        	 $scope.states  = data;
        	 $scope.myState = $scope.states;
         });
         
         var countriesresponse = Countrys.all();
         countriesresponse.success(function(data){
        	 $scope.countries  = data;
        	 $scope.mycountry = $scope.countries;
         });
     });

     $scope.submit = function () {
		 var request = Customer.updatebankinfo(Session.customer_id(),$scope.customer);
    	 request.success(function (response) {
             logger.log('Successfully updated');
    		 $state.reload();
         });
     }
     $scope.cancel = function(){
    	 $state.reload();
     }
})
.directive('onlyDigits', function () {
    return {
        require: 'ngModel',
        restrict: 'A',
        link: function (scope, element, attr, ctrl) {
          function inputValue(val) {
            if (val) {
              var digits = val.replace(/[^0-9]/g, '');

              if (digits !== val) {
                ctrl.$setViewValue(digits);
                ctrl.$render();
              }
              return parseInt(digits,10);
            }
            return undefined;
          }            
          ctrl.$parsers.push(inputValue);
        }
      };
  })
  .directive('postalCode', function () {
    return {
      require: 'ngModel',
      restrict: 'A',
      link: function (scope, element, attr, ctrl) {
        function inputValue(val) {
          if (val) {
        	 var digits = val.replace(/[^0-9]/g, '');
            if (val.length > 5 || digits !== val)
            {
            	//val = val.substr(0, 5);
                ctrl.$setViewValue(digits.substr(0, 5));
                ctrl.$render();
            }
            return parseInt(digits,10);
            
          }
          return undefined;
        }            
        ctrl.$parsers.push(inputValue);
      }
    };
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
        companySearch: function (name) {
            var request = $http.get('http://ofac.openach.com/api/companySearch/api_key/aV3XTHPs7ygpmuDw0hNaFKYmUZjdWajqmeJTFSMfIDj/name/'+ name);
            return request;
        }
    };

});


