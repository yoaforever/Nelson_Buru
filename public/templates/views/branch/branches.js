var billerServices = angular.module('branches', ['ngRoute', 'ngResource']);
billerServices.controller('inviteBranchCtrl', function ($scope, $stateParams, $state, Session,Branches,logger) {
	$scope.branch = {};
	$scope.branch.customer_id = Session.customer_id();
	$scope.submit = function() {
		var request = Branches.create($scope.branch);
		request.success(function(response) {
			if(response.success == true) {
				logger.log('Invitation Sent Successfully');
			}
			
		});
	}
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
billerServices.factory("Branches", function ($http) {
	return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/branches'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/branches/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/biller/' + id);
            return request;
        },
        searchBillersNotConnected: function (id) {
            var request = $http.get('api/search_biller_not_connected/' + id);
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
        searchBillersNotConnected: function (id) {
            var request = $http.get('api/search_biller_not_connected/' + id);
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


