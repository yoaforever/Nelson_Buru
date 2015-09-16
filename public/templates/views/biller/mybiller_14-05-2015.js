var billerServices = angular.module('billerServices', ['ngRoute', 'ngResource']);


billerServices.controller('MyBillerCurrentCtrl', function ($scope, $stateParams, $state, Session, BillerRelation) {

    $scope.id = Session.customer_id();
    var getCustomers = BillerRelation.searchCustomerRelation($scope.id);

    getCustomers.success(function (response) {
        $scope.customers = response;
    });

    var vm = this;
    vm.toggleDetail = toggleDetail;
    // vm.goToUserSettings = goToUserSettings;

    function toggleDetail(payor) {
        if (!payor) {
            payor.detailsVisbile = false;
            return;
        }
        var visible = !payor.detailsVisbile;
        $stateParams.id = payor.id;
        this.payor = payor;
        this.idRequested = payor.id;
        if (!visible) {
            var divid = '#' + payor.id;
            $(divid).remove();
        }
//            //JRB 11/0
        payor.detailsVisbile = visible;
        payor.showInlineAttchment = false;
    }
    ;



});



billerServices.controller('AllBillerCurrentCtrl', function ($scope, $stateParams, $state, Session, BillerAllRelation) {

    $scope.id = Session.customer_id();
    var getCustomers = BillerAllRelation.searchAllCustomerRelation($scope.id);

    getCustomers.success(function (response) {
        $scope.customers = response;
    });

    var vm = this;
    vm.toggleDetail = toggleDetail;
    // vm.goToUserSettings = goToUserSettings;

    function toggleDetail(payor) {
        if (!payor) {
            payor.detailsVisbile = false;
            return;
        }
        var visible = !payor.detailsVisbile;
        $stateParams.id = payor.id;
        this.payor = payor;
        this.idRequested = payor.id;
        if (!visible) {
            var divid = '#' + payor.id;
            $(divid).remove();
        }
//            //JRB 11/0
        payor.detailsVisbile = visible;
        payor.showInlineAttchment = false;
    }
    ;



});


billerServices.controller('MyBillerCtrl', function ($scope, $stateParams, $state, Biller) {

    var getCustomers = Biller.all();

    getCustomers.success(function (response) {
        $scope.customers = response;
    });

    var vm = this;
    vm.toggleDetail = toggleDetail;
    // vm.goToUserSettings = goToUserSettings;
    $stateParams.id = 0;
    function toggleDetail(payor) {
        if (!payor) {
            payor.detailsVisbile = false;
            return;
        }
        var visible = !payor.detailsVisbile;
        $stateParams.id = payor.id;
        this.payor = payor;
        this.idRequested = payor.id;
        if (!visible) {
            var divid = '#' + payor.id;
            $(divid).remove();
        }
//            //JRB 11/0
        payor.detailsVisbile = visible;
        payor.showInlineAttchment = false;
    }
    ;





});



billerServices.controller('MyNewBillerCtrl', function ($scope, $state, Session, States, Citys, Biller, toaster) {

    $scope.settings = {
        pageTitle: "New Biller", action: "Save"
    };

     var getStates = States.all();
    getStates.success(function (response) {
        $scope.states = response;
        $scope.myState = $scope.states[0].name;
    });

     var getCitys = Citys.all();
    getCitys.success(function (response) {
        $scope.citys = response;
        $scope.myCity = $scope.citys[0].name;
    });
    
    $scope.myVar = 0;
    $scope.customer_current = Session.customer_id();
    $scope.submit = function () {
        $scope.new.customer_current = $scope.customer_current;
        $scope.new.myState = $scope.new.myState.id;
        $scope.new.myCity = $scope.new.myCity.id;
        $scope.new.myCountry = $scope.new.myCountry.id;
        var request = Biller.create($scope.new);

        request.error(function (response) {
            $scope.flash = response.status;
            if (response.legal_name_err === 1 && response.email_err === 1) {
//                $scope.message = 'This name already exist in db';
//                $scope.messageEmail = 'This email already exist';
                toaster.pop({
                    type: 'info',
                    title: 'This company already exist.You have been sent an invitation'
                });
            } else
            if (response.legal_name_err === 1 && response.email_err !== 1) {
                $scope.message = 'This name already exist in db';
                $scope.messageEmail = null;
                toaster.pop({
                    type: 'error',
                    title: 'This name already exist with another email.'
                });
                return;
            }
            else
            if (response.legal_name_err !== 1 && response.email_err === 1) {
                $scope.messageEmail = 'This email already exist';
                $scope.message = null;
                toaster.pop({
                    type: 'info',
                    title: 'This email already exist in DB.You have been sent an invitation'
                });
                return;
            }
        });

        request.success(function (response) {
            $scope.flash = response.status;
            if (response.success === true) {
                toaster.pop({
                    type: 'success',
                    title: 'Biller Created Successfully'
                });

                toaster.pop({
                    type: 'info',
                    title: 'E-mail Send Succesfully'
                });
            }
        });
        $scope.$watch('myVar', function () {
            if ($scope.myVar === 0) {
                $state.reload();
            }
        });

    };
    
       $scope.cancel = function () {
        $state.reload();
    };
});

billerServices.controller('MyEditBillerCtrl', function ($scope, $state, $stateParams, States, Citys,Countrys, Customer, toaster) {

   
      var getCustomer = Customer.get($stateParams.id);
    getCustomer.success(function (response) {
        $scope.customer = response;
        $scope.state_id = $scope.customer.state_id;
        $scope.country_id = $scope.customer.country_id;
        $scope.city_id = $scope.customer.city_id;

        var getStates = States.get($scope.state_id);
        getStates.success(function (response) {
            $scope.states = response;
            $scope.myState = $scope.states.name;
        });
        var getContries = Countrys.get($scope.country_id);
        getContries.success(function (response) {
            $scope.countrys = response;
            $scope.myCountry = $scope.countrys.name;
        });
        var getCities = Citys.get($scope.city_id);
        getCities.success(function (response) {
            $scope.citys = response;
            $scope.myCity = $scope.citys.name;
        });

    });

    $scope.submit = function () {
        $scope.customer.myState = $scope.customer.myState.id;
        $scope.customer.myCity = $scope.customer.myCity.id;
        $scope.customer.myCountry = $scope.customer.myCountry.id;
        var request = Customer.update($stateParams.id, $scope.customer);

        request.success(function (response) {
            $scope.flash = response.status;
               if (response.success === true) {
                toaster.pop({
                    type: 'success',
                    title: 'Biller Updated Successfully'
                });

                toaster.pop({
                    type: 'info',
                    title: 'E-mail Send Succesfully'
                });
            }
        });
        
         request.error(function (response) {
            $scope.flash = response.status;
            // alert(response.legal_name_err);
            if (response.username_err === 1 && response.email_err === 1) {
                $scope.message = 'This name already exist in db';
                $scope.messageEmail = 'This email already exist';
                toaster.pop({
                    type: 'error',
                    title: 'Name and email already exist in DB.'
                });
                return;
            } else
            if (response.username_err === 1 && response.email_err !== 1) {
                $scope.message = 'This Name already exist in db';
                $scope.messageEmail = null;
                toaster.pop({
                    type: 'error',
                    title: 'This name already exist in DB.'
                });
                return;
            }
            else
            if (response.username_err !== 1 && response.email_err === 1) {
                $scope.messageEmail = 'This email already exist';
                $scope.message = null;
                toaster.pop({
                    type: 'error',
                    title: 'This email already exist in DB.'
                });
                return;
            }
            return false;
        });
    };
    
       $scope.cancel = function () {
        $state.reload();
    };

});


billerServices.controller('InviteBillerCtrl', function ($scope, Session, $state, Biller) {

    $scope.settings = {
        pageTitle: "Invite Biller", actions: "Send Invite"
    };
    $scope.customer_current = Session.customer_id();
    $scope.submit = function () {
        $scope.new.customer_current = $scope.customer_current;
        var request = Biller.create($scope.new);
        request.success(function (response) {
            $scope.flash = response.status;
            // $state.go($state.$current, null, { reload: true });
            $state.reload();
        });
        request.error(function (response) {
            $scope.flash = response.status;
            // alert(response.legal_name_err);
            if (response.legal_name_err === 1 && response.email_err === 1) {
                $scope.message = 'This name already exist in db';
                $scope.messageEmail = 'This email already exist';
            } else
            if (response.legal_name_err === 1 && response.email_err !== 1) {
                $scope.message = 'This name already exist in db';
                $scope.messageEmail = null;
            }
            else
            if (response.legal_name_err !== 1 && response.email_err === 1) {
                $scope.messageEmail = 'This email already exist';
                $scope.message = null;
            }
        });

    };

    $scope.cancel = function () {
        $state.reload();
    };
});



billerServices.factory("Customer", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/customers'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/customers/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/customers/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/customers/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

});


billerServices.factory("Biller", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/biller'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/biller/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/biller/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/biller/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

});


billerServices.factory("BillerRelation", function ($http) {

    return{
        searchCustomerRelation: function (id) {
            var request = $http.get('api/biller_relation/' + id);
            return request;
        }
    }

});


billerServices.factory("BillerAllRelation", function ($http) {

    return{
        searchAllCustomerRelation: function (id) {
            var request = $http.get('api/biller_all_relation/' + id);
            return request;
        }
    }

});
