var payorServices = angular.module('payorServices', ['ngRoute', 'ngResource', 'myState', 'myCity']);


payorServices.controller('MyPayorCtrl', function ($scope, $stateParams, $state, Payor) {

    var getCustomers = Payor.all();

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


payorServices.controller('MyPayorCurrentCtrl', function ($scope, $stateParams, $state, Session, PayorRelation) {

    $scope.id = Session.customer_id();
    var getCustomers = PayorRelation.searchCustomerRelation($scope.id);

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

payorServices.controller('MyNewPayorCtrl', function ($scope, $state, States, Citys, Customer) {

    $scope.settings = {
        pageTitle: "New Payor", action: "Save"
    };

//    States.get(function (data) {
//        $scope.states = data.states;
//        $scope.myState = $scope.states[0];
//
//    });
//    
     var getStates = States.all();

    getStates.success(function (response) {
        $scope.states = response;
          $scope.myState = $scope.states[0];
    });
    Citys.get(function (data) {
        $scope.citys = data.citys;
        $scope.myCity = $scope.citys[0];

    });
    $scope.submit = function () {
        $scope.new.myState = $scope.new.myState.id;
        $scope.new.myCity = $scope.new.myCity.id;
        $scope.new.myCountry = $scope.new.myCountry.id;
        var request = Customer.create($scope.new);
        request.success(function (response) {
            $scope.flash = response.status;
            // $state.go($state.$current, null, { reload: true });
            $state.reload();
        });
    };
});


payorServices.controller('InvitePayorCtrl', function ($scope, $state, Session, Payor, toaster) {

    $scope.settings = {
        pageTitle: "Invite Payor", actions: "Send Invite"
    };

    $scope.new = {};
    $scope.myVar = 0;
    $scope.customer_current = Session.customer_id();
    $scope.submit = function () {

        $scope.new.customer_current = $scope.customer_current;
        var request = Payor.create($scope.new);
        request.success(function (response) {
//            $scope.flash = response.status;
            if (response.success === true) {
                toaster.pop({
                    type: 'success',
                    title: 'Payor Invited Successfully'
                });
                toaster.pop({
                    type: 'info',
                    title: 'E-mail Sent Succesfully'
                });
            }
        });
        request.error(function (response) {
            $scope.flash = response.status;
            // alert(response.legal_name_err);
            if (response.legal_name_err === 1 && response.email_err === 1) {
                $scope.message = 'This name already exists in db';
                $scope.messageEmail = 'This email already exists';
                toaster.pop({
                    type: 'info',
                    title: 'This company already exists. An invitation has been sent'
                });
                return;
            }else
              if (response.legal_name_err === 2 && response.email_err === 2) {
                $scope.message = 'You are already connected';
                $scope.messageEmail = 'You are already connected';
                toaster.pop({
                    type: 'info',
                    title: 'You are already connected. An email has been sent to you'
                });
                return;
            }else
            if (response.legal_name_err === 1 && response.email_err !== 1) {
                $scope.message = 'This name already exists in db';
                $scope.messageEmail = null;
                toaster.pop({
                    type: 'error',
                    title: 'This name already exists with another email.'
                });
                return;
            }
            else
            if (response.legal_name_err !== 1 && response.email_err === 1) {
                $scope.messageEmail = 'This email already exists';
                $scope.message = null;
                toaster.pop({
                    type: 'info',
                    title: 'This email already exists in DB. An invitation has been sent'
                });
                return;
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

payorServices.controller('PayorDashbCtrl', ['$scope', 'Customer', '$route', function ($scope, Customer, $route) {
        $scope.payor_id = $scope.txn.payor_id;
        var getPayorDashb = Customer.get($scope.payor_id);
        getPayorDashb.success(function (response) {
            $scope.customers = response;
            $scope.PayorDashb = $scope.customers.legal_name;

        });
    }]);


payorServices.controller('BillerDashbCtrl', ['$scope', 'Customer', '$route', function ($scope, Customer, $route) {
        $scope.biller_id = $scope.txn.biller_id;
        var getPayorDashb = Customer.get($scope.biller_id);
        getPayorDashb.success(function (response) {
            $scope.customers = response;
            $scope.BillerDashb = $scope.customers.legal_name;

        });
    }]);

payorServices.controller('MyEditPayorCtrl', function ($scope, $state, $stateParams, Countrys, States, Citys, Customer, toaster) {


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
        $scope.customer.state_id =  angular.element($('#state option:selected')).val();
        $scope.customer.city_id =  angular.element($('#city option:selected')).val();
        $scope.customer.country_id = angular.element($('#country option:selected')).val();
        var request = Customer.update($stateParams.id, $scope.customer);

        request.success(function (response) {
                $scope.flash = response.status;
            if (response.success === true) {
            
                //  alert($scope.flash);
                toaster.pop({
                    type: 'success',
                    title: 'Payor Updated Successfully'
                });
                toaster.pop({
                    type: 'info',
                    title: 'E-mail Sent Succesfully'
                });
                return;
            }
        });

        request.error(function (response) {
            $scope.flash = response.status;
            // alert(response.legal_name_err);
            if (response.username_err === 1 && response.email_err === 1) {
                $scope.message = 'This name already exists in db';
                $scope.messageEmail = 'This email already exists';
                toaster.pop({
                    type: 'error',
                    title: 'Name and email already exists in DB.'
                });
                return;
            } else
            if (response.username_err === 1 && response.email_err !== 1) {
                $scope.message = 'This Name already exists in db';
                $scope.messageEmail = null;
                toaster.pop({
                    type: 'error',
                    title: 'This name already exists in DB.'
                });
                return;
            }
            else
            if (response.username_err !== 1 && response.email_err === 1) {
                $scope.messageEmail = 'This email already exists';
                $scope.message = null;
                toaster.pop({
                    type: 'error',
                    title: 'This email already exists in DB.'
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


payorServices.factory("Customer", function ($http) {

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
        	console.log(id);
            var request = $http.get('api/customers/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/customers/' + id, data);
            return request;
        },
        getbankinfo:function (id) {
            var request = $http.get('api/customerbankinfo/' + id);
            return request;
        },
        updatebankinfo:function (id,data) {
            var request = $http.put('api/updatecustomerbankinfo/' + id,data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

});


payorServices.factory("Payor", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/payor'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/payor/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/payor/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/payor/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

});



payorServices.factory("PayorRelation", function ($http) {

    return{
        searchCustomerRelation: function (id) {
            var request = $http.get('api/payor_relation/' + id);
            return request;
        }
    }

});