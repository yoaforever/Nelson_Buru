var customersServices = angular.module('customersServices', ['ngRoute', 'ngResource']);
customersServices.controller('AllCustomersCtrl', function ($scope, $stateParams, $state, Customer,CountCustomer, CountUser, CountBiller, CountPayor, CountPending,CountVerified, CountApprove, CountDispute, CountPause, CountCanceled ) {

    var getCustomers = Customer.all();
    getCustomers.success(function (response) {
        $scope.customers = response;
		$scope.currentPage = 1; //current page
        $scope.entryLimit = 15; //max no of items to display in a page
        $scope.filteredItems = $scope.customers.length; //Initially for no filter

        $scope.totalItems = $scope.customers.length;

        $scope.filter = function() {
            $timeout(function() {
                $scope.filteredItems = $scope.filtered.length;
            }, 10);
        };
        $scope.sort_by = function(predicate) {
            $scope.predicate = predicate;
            $scope.reverse = !$scope.reverse;
        };
        $scope.$watch('currentPage + entryLimit', function() {
            $scope.isLoading = true;
            var begin = (($scope.currentPage - 1) * $scope.entryLimit),
                end = begin + $scope.entryLimit;
            $scope.filteredTodos = $scope.customers.slice(begin, end);
            $scope.isLoading = false;
        });
    });
    
    var getCountCustomers = CountCustomer.countCustomers();
     getCountCustomers.success(function (response) {
        $scope.count_customers = response;
    });
    
     var getCountUsers = CountUser.countUsers();
     getCountUsers.success(function (response) {
        $scope.count_users = response;
    });
    
      var getCountBillers = CountBiller.countBillers();
     getCountBillers.success(function (response) {
        $scope.count_billers = response;
    });
    
     var getCountPayors = CountPayor.countPayors();
     getCountPayors.success(function (response) {
        $scope.count_payors = response;
    });
    
      var getCountPending = CountPending.countAllPending();
     getCountPending.success(function (response) {
        $scope.count_pending = response;
    });
    
      var getCountVerified = CountVerified.countAllVerified();
     getCountVerified.success(function (response) {
        $scope.count_verified = response;
    });
    
      var getCountApprove = CountApprove.countAllApproved();
     getCountApprove.success(function (response) {
        $scope.count_approve = response;
    });
    
      var getCountDispute = CountDispute.countAllDisputed();
     getCountDispute.success(function (response) {
        $scope.count_dispute = response;
    });
    
      var getCountPause = CountPause.countAllPaused();
     getCountPause.success(function (response) {
        $scope.count_pause = response;
    });
    
      var getCountCanceled = CountCanceled.countAllCanceled();
     getCountCanceled.success(function (response) {
        $scope.count_canceled = response;
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


customersServices.controller('StateCustomers', function ($scope, $stateParams, $state,States) {

    $scope.id = $scope.payor.state_id;
    var getStates = States.get($scope.id);
    getStates.success(function (response) {
        $scope.states = response;
          $scope.myState = $scope.states.name;
    });
});

customersServices.controller('CitiesCustomers', function ($scope, $stateParams, $state,Citys) {

    $scope.id = $scope.payor.state_id;
    var getCities = Citys.get($scope.id);
    getCities.success(function (response) {
        $scope.cities = response;
          $scope.myCity = $scope.cities.name;
    });
});


customersServices.controller('MyNewCSBillerCtrl', function ($scope, $state, Session, States, Citys, Biller, toaster,Customer) {

    $scope.settings = {
        pageTitle: "New Biller", action: "Save"
    };
	
	var getCustomers = Customer.all();
    getCustomers.success(function (response) {
        $scope.customers = response;
	});
   
	$scope.isBillerCreate = false;
      $scope.checkCreateBiller= function () {
    $scope.isBillerCreate = true;
    };

    $scope.myVar = 0;
    //$scope.customer_current = $scope.comapny_info;
    $scope.cities = {};
     $scope.states = {};
    $scope.submit = function () {
        //$scope.new.customer_current = $scope.comapny_info;
        $scope.new.myState = angular.element($('#state option:selected')).val();
        $scope.new.myCity = angular.element($('#city option:selected')).val();
        $scope.new.myCountry = angular.element($('#country option:selected')).val();
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

customersServices.factory("Customer", function ($http) {

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







customersServices.controller('EditCompanyProfileCSCtrl', function ($scope, $state,toaster, $stateParams,Session,Customer, CompanyProfile,OFAC_API, serveData) {

var vm = this;
 //vm.company_profile= Session.userName();
  var getCustomer = Customer.get($stateParams.id);
// $scope.username=Session.userName();
//    var getCustomer = Customer.get(Session.customer_id());
        getCustomer.success(function(response){
             $scope.customers = response;
            $scope.company_profile = $scope.customers;
           // $scope.mycurrentcustomerName = $scope.customers.legal_name;
                         
//            var    mycurrencustomerB = $scope.mycurrentcustomer;
//                return mycurrencustomerB; 
  var getCompany = OFAC_API.companySearch('aV3XTHPs7ygpmuDw0hNaFKYmUZjdWajqmeJTFSMfIDj',$scope.company_profile.legal_name);
        getCompany.success(function(response){
             $scope.company = response;
        });
        });
       
//$scope.company_profile.username=Session.userName();
    $scope.submit = function () {
        $stateParams.id=0;
        $stateParams.id = $scope.company_profile.id;
        $scope.company_profile.username=$scope.username;
        var request = CompanyProfile.update($stateParams.id, $scope.company_profile);

        request.success(function (response) {
           if (response.success === true) {
                toaster.pop({
                    type: 'success',
                    title: 'Company Profile Updated Successfully'
                });
                toaster.pop({
                    type: 'info',
                    title: 'E-mail Sent Succesfully'
                });
            }
        });
    }
    
    $scope.obj = serveData;
   $scope.obj.company_id= $stateParams.id;
});
customersServices.controller('CSUsersCtrl', function ($scope, $state, $stateParams, ListUsers,serveData) {
	
	var getUsers = ListUsers.listUsersByRole(8);
    getUsers.success(function (response) {
        $scope.users = response;
    });
	var vm = this;
    vm.toggleDetail = toggleDetail;
    // vm.goToUserSettings = goToUserSettings;
    $stateParams.id = 0;
    function toggleDetail(user) {
        if (!user) {
            user.detailsVisbile = false;
            return;
        }
        var visible = !user.detailsVisbile;
        $stateParams.id = user.id;
        this.user = user;
		if(vm.user.active == 1) {
			vm.user.active = true;
		}else {
			vm.user.active = false;
		}
		if(vm.user.sendInternalMsg == 1) {
			vm.user.sendInternalMsg = true;
		}else {
			vm.user.sendInternalMsg = false;
		}
        this.idRequested = user.id;
        if (!visible) {
            var divid = '#' + user.id;
            $(divid).remove();
        }
//            //JRB 11/0
        user.detailsVisbile = visible;
        user.showInlineAttchment = false;
    }
    ;
});
customersServices.controller('CSUserEditCtrl', function ($scope, $state, $stateParams, Users, toaster,serveData) {

    $scope.obj = serveData;
    $scope.customer_current = $scope.obj.company_id;
    
	$scope.submit = function () {
	    $scope.user.customer_current = $scope.customer_current;
		var request = Users.update($stateParams.id, $scope.user);
		$scope.myVar = 0;
		request.success(function (response) {
		// $scope.flash = response.status;
			$scope.myVar = 1;
			if (response.success === true) {
				toaster.pop({
					type: 'success',
					title: 'User Update Successfully'
				});
				toaster.pop({
					type: 'info',
					title: 'E-mail Send Succesfully'
				});
			}
			return;
		});
		request.error(function (response) {
			$scope.flash = response.status;
			// alert(response.legal_name_err);
			if (response.username_err === 1 && response.email_err === 1) {
				$scope.message = 'This username already exist in db';
				 toaster.pop({
					type: 'error',
					title: 'User  already exist in DB.'
				});
				return;
			} else
			if (response.username_err === 1 && response.email_err !== 1) {
				$scope.message = 'This usernaname already exist in db';
				$scope.messageEmail = null;
				toaster.pop({
					type: 'error',
					title: 'This username already exist in DB.'
				});
				return;
			}
			else
			if (response.username_err !== 1 && response.email_err === 1) {
				$scope.messageEmail = 'This email already exist in this company';
				$scope.message = null;
				 toaster.pop({
					type: 'error',
					title: 'This email already exist in this  company.'
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
customersServices.controller('TxnBillerCtrl', function ($scope, $state, $stateParams, $filter, Transactions, serveData, Customer, TransactionStatus) {
	var getCustomers = Customer.all();
    getCustomers.success(function (response) {
        $scope.customers = response;
	});
	
	var getStatus = TransactionStatus.all();
	getStatus.success(function (response) {
        $scope.status_types = response;
	});
	
	var vm = this;
    vm.toggleDetail = toggleDetail;
    //JRB 04/26/2014  Refactoring Pupilo's code.
    $stateParams.id = 0;

    function toggleDetail(txn) {
		if (!txn) {
            return;
        }
        var visible = !txn.detailsVisbile;
        $stateParams.id = txn.id;
        vm.txn = txn;
        vm.idRequested = txn.id;
        if (!visible) {
            var divid = '#' + txn.id;
            $(divid).remove();
        }
        txn.detailsVisbile = visible;
        txn.showInlineAttchment = false;
    };
	
	$scope.showBillers = function() {
		$scope.cust_id = $scope.customer_name;
		if($scope.cust_id){
			var getType = Customer.get($scope.cust_id);
			getType.success(function (response) {
				$scope.typecustomer = response.type_customer;
				if($scope.typecustomer == 1){
					if(angular.element("#accType option[value='Payor']").length == 0) {
						angular.element('#accType').append(new Option('Payor','Payor'));
					}
					if(angular.element("#accType option[value='Biller']").length > 0) {
						angular.element("#accType option[value='Biller']").remove();
					}
				}
				else{
					if(angular.element("#accType option[value='Biller']").length == 0) {
						angular.element('#accType').append(new Option('Biller','Biller'));
					}
					if(angular.element("#accType option[value='Payor']").length == 0) {
						angular.element('#accType').append(new Option('Payor','Payor'));
					}
				}
			});
		}
		else{
			if(angular.element("#accType option[value='Payor']").length > 0) {
				angular.element("#accType option[value='Payor']").remove();
			}
			if(angular.element("#accType option[value='Biller']").length > 0) {
				angular.element("#accType option[value='Biller']").remove();
			}
		}
		$scope.transData = {};
		$scope.transData.customer_id = $scope.cust_id;
		$scope.transData.customer_id_1 = $scope.customer_name_1;
		$scope.transData.typebiller = $scope.isbiller;
		$scope.transData.stat = $scope.status;
		
		var getReqTransactions = Transactions.showneedtrans($scope.transData);
		getReqTransactions.success(function(response){
			$scope.isLoading = false;
			$scope.transaction_biller = response;
			$scope.currentPage = 1; //current page
			$scope.entryLimit = 20; //max no of items to display in a page
			$scope.filteredItems = $scope.transaction_biller.length; //Initially for no filter
			$scope.totalItems = $scope.transaction_biller.length;
			$scope.filter = function() {
				$timeout(function() {
					$scope.filteredItems = $scope.filtered.length;
				}, 10);
			};
			$scope.sort_by = function(predicate) {
				$scope.predicate = predicate;
				$scope.reverse = !$scope.reverse;
			};
			$scope.$watch('currentPage + entryLimit', function() {
				vm.isLoading = true;
				var begin = (($scope.currentPage - 1) * $scope.entryLimit),
					end = begin + $scope.entryLimit;
				$scope.filteredTodos = $scope.transaction_biller.slice(begin, end);
				vm.isLoading = false;
			});
		});
	};
	$scope.showBillers();
});

customersServices.controller('BillersListCtrl', function ($scope, $state, $stateParams, ListUsers,serveData,Customer,BillerAllRelation, AllBillers) {
	
	var getCustomers = Customer.all();
    getCustomers.success(function (response) {
        $scope.customers = response;
	});	
	
	var vm = this;
    vm.toggleDetail = toggleDetail;
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
    };
	$scope.showBillers = function() {
		var cust_id = $scope.customer_name;
		if(cust_id){
		    var getCustomers = BillerAllRelation.searchAllCustomerRelation(cust_id);
		    getCustomers.success(function (response) {
		        $scope.reqcustomers = response;
		    });
		}
		else{
			var allbillers = AllBillers.allCustomerRelation();
			allbillers.success(function (response) {
		        $scope.reqcustomers = response;
		    });
		}
	};
	$scope.showBillers();
});

customersServices.controller('TxnPayorCtrl', function ($scope, $state, $stateParams, ListUsers,serveData) {
	
});
customersServices.controller('ListUserCSCtrl', function ($scope, $state, $stateParams, ListUsers,serveData, logger,$http) {
 
    //$scope.company_id =$scope.company_profile.id;
	//$scope.obj.company_id
	//console.log($stateParams.company_id);
	$scope.obj = serveData;
    var getUsers = ListUsers.listUsersByCompany($stateParams.company_id);
    getUsers.success(function (response) {
        $scope.users = response;
	});
	
    var vm = this;
    vm.toggleDetail = toggleDetail;
    // vm.goToUserSettings = goToUserSettings;
    $stateParams.id = 0;
    function toggleDetail(user) {
        if (!user) {
            user.detailsVisbile = false;
            return;
        }
		this.user = user;
		if(user.active == 1) {
			user.active = true;
		}else {
			user.active = false;
		}
		if(user.is_locked == 1) {
			user.is_locked = true;
		}else {
			user.is_locked = false;
		}
        var visible = !user.detailsVisbile;
        $stateParams.id = user.id;
        this.user = user;
        this.idRequested = user.id;
        if (!visible) {
            var divid = '#' + user.id;
            $(divid).remove();
        }
//            //JRB 11/0
        user.detailsVisbile = visible;
        user.showInlineAttchment = false;
    };
	
	$scope.SaveLockStatus = function(user_id,status) {
		var request = $http.post('api/users/lock_user/' + user_id, {'lockStatus':status});
		request.success(function(response) { 
			logger.log('Status updated successfully.');
		});
	};
	$scope.SaveProfileStatus = function(user_id,status) {
		var request = $http.post('api/users/user_status/' + user_id, {'status':status});
		request.success(function(response) { 
			logger.log('Status updated successfully.');
		});
		//alert(status);
	};

});

customersServices.controller('NewUserCSCtrl', function ($scope, $state, $location, Users, Session,UsersCS, Roles, toaster,serveData) {

    $scope.settings = {
        pageTitle: "New User", action: "Saves"
    };

    var getRoles = Roles.all();
	
    getRoles.success(function (response) {
        $scope.roles = response;
        $scope.myRolSelect = $scope.roles[0];
    });

    $scope.myVar = 0;
    $scope.role_id = $scope.myRolSelect;
    $scope.obj = serveData;
    $scope.customer_current = $scope.obj.company_id;
    $scope.submit = function () {
        $scope.new.myRolSelect = $scope.myRolSelect.id;
        $scope.new.customer_current = $scope.customer_current;
        var request = Users.create($scope.new);
        request.success(function (response) {
            if (response.success === true) {
                toaster.pop({
                    type: 'success',
                    title: 'User Create Successfully'
                });
                toaster.pop({
                    type: 'info',
                    title: 'E-mail Send Succesfully'
                });
               
                return;
            }
			$scope.myVar = 1;
        });


        request.error(function (response) {
            //  $scope.flash = response.status;
            if (response.username_err === 1 && response.email_err === 1) {
                $scope.message = 'This username already exist in db';
//                $scope.messageEmail = 'This email already exist';
                toaster.pop({
                    type: 'error',
                    title: 'User already exist in DB. Insert new user'
                });
                return;
            } else
            if (response.username_err === 1 && response.email_err !== 1) {
                $scope.message = 'This username already exist in db';
                $scope.messageEmail = null;
                toaster.pop({
                    type: 'error',
                    title: 'This username already exist in DB. Insert your data with another username'
                });
                return;
            }
            else
            if (response.user_customer === 1 && response.email_err === 1) {
                $scope.messageEmail = 'This email already exist in this company';
                $scope.message = null;
                toaster.pop({
                    type: 'error',
                    title: 'This email already exist in this company.Insert your data with another email'
                });
                return;
            }

            return false;
        });

        $scope.$watch('myVar', function () {
            if ($scope.myVar === 1) {
                $state.reload();
            }
        });
    };
	$scope.createCSUser = function () {
        //$scope.new.myRolSelect = 8;
        $scope.new.customer_current = Session.customer_id();
        var request = UsersCS.create($scope.new);
        request.success(function (response) {
            if (response.success === true) {
                toaster.pop({
                    type: 'success',
                    title: 'User Create Successfully'
                });
                toaster.pop({
                    type: 'info',
                    title: 'E-mail Send Succesfully'
                });
               
                return;
            }
			$scope.myVar = 1;
        });


        request.error(function (response) {
            //  $scope.flash = response.status;
            if (response.username_err === 1 && response.email_err === 1) {
                $scope.message = 'This username already exist in db';
//                $scope.messageEmail = 'This email already exist';
                toaster.pop({
                    type: 'error',
                    title: 'User already exist in DB. Insert new user'
                });
                return;
            } else
            if (response.username_err === 1 && response.email_err !== 1) {
                $scope.message = 'This username already exist in db';
                $scope.messageEmail = null;
                toaster.pop({
                    type: 'error',
                    title: 'This username already exist in DB. Insert your data with another username'
                });
                return;
            }
            else
            if (response.user_customer === 1 && response.email_err === 1) {
                $scope.messageEmail = 'This email already exist in this company';
                $scope.message = null;
                toaster.pop({
                    type: 'error',
                    title: 'This email already exist in this company.Insert your data with another email'
                });
                return;
            }

            return false;
        });

        $scope.$watch('myVar', function () {
            if ($scope.myVar === 1) {
                $state.reload();
            }
        });
    };
    $scope.cancel = function () {
        $state.reload();
    };
});

customersServices.controller('EditUserCSCtrl', function ($scope, $state, $stateParams, Users, toaster,serveData,$http) {

    $scope.obj = serveData;
    $scope.customer_current = $scope.obj.company_id;
    $scope.lockOrUnlock = function(lockStatus) {
		var request = $http.post('api/users/lock_user/' + $scope.user.id, {'lockStatus':lockStatus});
	};
	$scope.submit = function () {
    $scope.user.customer_current = $scope.customer_current;
        var request = Users.update($stateParams.id, $scope.user);
         $scope.myVar = 0;
        request.success(function (response) {
//            $scope.flash = response.status;
                $scope.myVar = 1;
                if (response.success === true) {
                    toaster.pop({
                        type: 'success',
                        title: 'User Update Successfully'
                    });
                    toaster.pop({
                        type: 'info',
                        title: 'E-mail Send Succesfully'
                    });
                }
                return;
        });
        request.error(function (response) {
            $scope.flash = response.status;
            // alert(response.legal_name_err);
            if (response.username_err === 1 && response.email_err === 1) {
                $scope.message = 'This username already exist in db';
                 toaster.pop({
                    type: 'error',
                    title: 'User  already exist in DB.'
                });
                return;
            } else
            if (response.username_err === 1 && response.email_err !== 1) {
                $scope.message = 'This usernaname already exist in db';
                $scope.messageEmail = null;
                toaster.pop({
                    type: 'error',
                    title: 'This username already exist in DB.'
                });
                return;
            }
            else
            if (response.username_err !== 1 && response.email_err === 1) {
                $scope.messageEmail = 'This email already exist in thi company';
                $scope.message = null;
                 toaster.pop({
                    type: 'error',
                    title: 'This email already exist in this  company.'
                });
                  return;
            }
         return false;
        });

//        $scope.$watch('myVar', function () {
//            if ($scope.myVar === 0) {
//                $state.reload();
//            }
//            ;
//        });
    };

    $scope.cancel = function () {
        $state.reload();
    };

});
customersServices.controller('customerFeesCtrl', function ($scope, $state, $stateParams, ListUsers,serveData,Customer,CompanyFees,logger) {
	$scope.overNightFees = {};
	$scope.rapidFees = {};
	$scope.creditFees = {};
	$scope.txn_fee = '';
	$scope.txn_percentage = '';
	var getCustomers = Customer.all();
    getCustomers.success(function (response) {
        $scope.customers = response;
		$scope.currentPage = 1; //current page
        $scope.entryLimit = 15; //max no of items to display in a page
        $scope.filteredItems = $scope.customers.length; //Initially for no filter

        $scope.totalItems = $scope.customers.length;

        $scope.filter = function() {
            $timeout(function() {
                $scope.filteredItems = $scope.filtered.length;
            }, 10);
        };
        $scope.sort_by = function(predicate) {
            $scope.predicate = predicate;
            $scope.reverse = !$scope.reverse;
        };
        $scope.$watch('currentPage + entryLimit', function() {
            $scope.isLoading = true;
            var begin = (($scope.currentPage - 1) * $scope.entryLimit),
                end = begin + $scope.entryLimit;
            $scope.filteredTodos = $scope.customers.slice(begin, end);
            $scope.isLoading = false;
        });
    });
	
	$scope.saveTransactionFee = function(amount,feeType,percentage) {
		if(amount == '') {
			logger.logError('Please enter the amount.');
			return false;
		}
		if(isNaN(amount)) {
			logger.logError('Please enter valid amount.');
			return false;
		}
		if(percentage == '') {
			logger.logError('Please enter the amount.');
			return false;
		}
		if(isNaN(percentage)) {
			logger.logError('Please enter valid amount.');
			return false;
		}
		$scope.formData = {};
		$scope.formData.customer_id = $stateParams.id;
		$scope.formData.transactionFee = amount;
		$scope.formData.feeType = feeType;
		$scope.formData.percentage = percentage;
		var request = CompanyFees.SaveOrUpdate($scope.formData);
		request.success(function(response) {
			if(response.success = true) {
				logger.log('Saved Successfully.');
			}
		});
	};
	$scope.saveOvernightFee = function(amount,feeType,percentage) {
		if(amount == '') {
			logger.logError('Please enter the amount.');
			return false;
		}
		if(isNaN(amount)) {
			logger.logError('Please enter valid amount.');
			return false;
		}
		$scope.formData = {};
		$scope.formData.customer_id = $stateParams.id;
		$scope.formData.transactionFee = amount;
		$scope.formData.feeType = feeType;
		$scope.formData.percentage = percentage;
		var request = CompanyFees.SaveOrUpdate($scope.formData);
		request.success(function(response) {
			if(response.success = true) {
				logger.log('Saved Successfully.');
			}
		});
	};
	$scope.saveRapidPay = function(amount,feeType,percentage) {
		if(amount == '') {
			logger.logError('Please enter the amount.');
			return false;
		}
		if(isNaN(amount)) {
			logger.logError('Please enter valid amount.');
			return false;
		}
		$scope.formData = {};
		$scope.formData.customer_id = $stateParams.id;
		$scope.formData.transactionFee = amount;
		$scope.formData.feeType = feeType;
		$scope.formData.percentage = percentage;
		var request = CompanyFees.SaveOrUpdate($scope.formData);
		request.success(function(response) {
			if(response.success = true) {
				logger.log('Saved Successfully.');
				return false;
			}
		});
	};
	$scope.saveCreditFee = function(amount,feeType,percentage) {
		if(amount == '') {
			logger.logError('Please enter the amount.');
			return false;
		}
		if(isNaN(amount)) {
			logger.logError('Please enter valid amount.');
			return false;
		}
		$scope.formData = {};
		$scope.formData.customer_id = $stateParams.id;
		$scope.formData.transactionFee = amount;
		$scope.formData.feeType = feeType;
		$scope.formData.percentage = percentage;
		var request = CompanyFees.SaveOrUpdate($scope.formData);
		request.success(function(response) {
			if(response.success = true) {
				logger.log('Saved Successfully.');
			}
		});
	};
	$scope.makeDefault = function(feeType) {
		var request = CompanyFees.setFeeType($stateParams.id,feeType);
		request.success(function(response) {
			logger.log('Saved successfully.');
		});
	};
	$scope.getBillerList = function() {
		
	};
	vm = this;
	vm.toggleDetail = toggleDetail;
    //vm.billerStatus = billerStatus;
    //vm.filterStatus = filterStatus;
    //JRB 04/26/2014  Refactoring Pupilo's code.
    $stateParams.id = 0;

    function toggleDetail(txn) {
        if (!txn) {
            var visible = false;
			return;
        }
        var visible = !txn.detailsVisbile;
        $stateParams.id = txn.id;
        vm.txn = txn;
        vm.idRequested = txn.id;
        if (!visible) {
            var divid = '#' + txn.id;
            $(divid).remove();
        }
        txn.detailsVisbile = visible;
        txn.showInlineAttchment = false;
    };
});
customersServices.controller('customerFeesListCtrl', function ($scope, $state, $stateParams, ListUsers,serveData,Customer,CompanyFees) {
	$scope.isDefault = 0;
	var feeType = Customer.get($stateParams.id);
	feeType.success(function(response) {
		$scope.isDefault = response.fee_type;
	});
	var request = CompanyFees.get($stateParams.id);
	request.success(function(response) {
		$scope.customerFees = response;
		$scope.txnFees = {amount : '',percentage : ''};
		$scope.overNightFees = {amount : '',percentage : ''};
		$scope.rapidFees = {amount : '',percentage : ''};
		$scope.creditFees = {amount : '',percentage : ''};
		angular.forEach($scope.customerFees, function(value, key) {
			if(value.fee_type == 1) {
				$scope.txnFees.amount = value.amount;
				$scope.txnFees.percentage = value.percentage; 
			}
			if(value.fee_type == 2) {
				$scope.overNightFees.amount = value.amount;
				$scope.overNightFees.percentage = value.percentage; 
			}
			if(value.fee_type == 3) {
				$scope.rapidFees.amount = value.amount;
				$scope.rapidFees.percentage = value.percentage; 
			}
			if(value.fee_type == 4) {
				$scope.creditFees.amount = value.amount;
				$scope.creditFees.percentage = value.percentage; 
			}
		});
	});
});
customersServices.factory("CompanyProfile", function ($http) {

    return{
        update: function (id, data) {
            var request = $http.put('api/company_profile/' + id, data);
            return request;
        }  
        };
});



customersServices.factory("OFAC_API", function ($http) {

    return{
        companySearch: function (api_key,name) {
            var request = $http.get('http://ofac.openach.com/api/companySearch/' +'api_key/' + api_key +'/'+ 'name/'+ name);
            return request;
        }
    };

});

customersServices.factory("CountCustomer", function ($http) {

    return{
           countCustomers: function () {
            var request = $http({method: 'GET', url: 'api/count_customers/'});
            return request;
        },
    };

});

customersServices.factory("CountUser", function ($http) {

    return{
           countUsers: function () {
            var request = $http({method: 'GET', url: 'api/count_users/'});
            return request;
        },
    };

});

customersServices.factory("CountBiller", function ($http) {

    return{
           countBillers: function () {
            var request = $http({method: 'GET', url: 'api/count_billers/'});
            return request;
        },
    };

});

customersServices.factory("CountPayor", function ($http) {

    return{
           countPayors: function () {
            var request = $http({method: 'GET', url: 'api/count_payors/'});
            return request;
        },
    };

});
customersServices.factory("CountPending", function ($http) {

    return{
           countAllPending: function () {
            var request = $http({method: 'GET', url: 'api/count_pending/'});
            return request;
        },
    };

});
customersServices.factory("CountVerified", function ($http) {

    return{
           countAllVerified: function () {
            var request = $http({method: 'GET', url: 'api/count_verified/'});
            return request;
        },
    };

});
customersServices.factory("CountApprove", function ($http) {

    return{
           countAllApproved: function () {
            var request = $http({method: 'GET', url: 'api/count_approved/'});
            return request;
        },
    };

});
customersServices.factory("CountDispute", function ($http) {

    return{
           countAllDisputed: function () {
            var request = $http({method: 'GET', url: 'api/count_disputed/'});
            return request;
        },
    };

});
customersServices.factory("CountPause", function ($http) {

    return{
           countAllPaused: function () {
            var request = $http({method: 'GET', url: 'api/count_paused/'});
            return request;
        },
    };

});
customersServices.factory("CountCanceled", function ($http) {

    return{
           countAllCanceled: function () {
            var request = $http({method: 'GET', url: 'api/count_canceled/'});
            return request;
        },
    };

});



customersServices.factory("Users", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/users'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/users/create', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/users/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/users/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }
});

customersServices.factory("UsersCS", function ($http) {

    return{
        all: function () {
            var request = $http({method: 'GET', url: 'api/users'});
            return request;
        },
        create: function (data) {
            var request = $http({method: 'GET', url: 'api/newCSuser', params: data});
            return request;
        },
        get: function (id) {
            var request = $http.get('api/users/' + id);
            return request;
        },
        update: function (id, data) {
            var request = $http.put('api/users/' + id, data);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }
});



customersServices.factory("ListUsers", function ($http) {

    return{
        listUsersByCompany: function (id) {
            var request = $http.get('api/user_by_company/' + id);
            return request;
        },
		listUsersByRole: function (id) {
            var request = $http.get('api/user_by_role/' + id);
            return request;
        }
    }

});

/*id sharing  between controllers*/
customersServices.service('serveData', [function () 
{
	return {
		company_id : 0
	};
}]);

customersServices.factory("CompanyFees", function ($http) {

    return{
        SaveOrUpdate: function (data) {
            var request = $http.post('api/company_fees', data);
            return request;
        },
		get: function (id) {
            var request = $http.get('api/company_fees/'+id);
            return request;
        },
		setFeeType : function(customer_id,fee_type) {
			var request = $http.post('api/set_customer_fee/'+customer_id, {'fee_type':fee_type});
			return request;
        }
	}
});
