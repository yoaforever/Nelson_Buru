myApp.controller('ApplicationController', function ($scope, /*USER_ROLES,*/AuthService) {
    $scope.currentUser = null;
    $scope.error = false;
    $scope.errorMessage = '';
	$scope.loginData = {};
    // $scope.userRoles = USER_ROLES;
    $scope.isAuthorized = AuthService.isAuthorized;

    $scope.setCurrentUser = function (user) {
        $scope.currentUser = user;
    };
});

myApp.controller('LoginController', function ($scope,$rootScope, $location, AuthService, RegisterService, States, PasswordRecoveryService, toaster, Session, ChangePassSixtyDays, LockUserAttempts,$http) {

    $scope.register = {
        companyName: '',
        address: '',
        city: '',
        state: '',
        zipcode: '',
        phone: '',
        phoneExt: '',
        fax: '',
        dba: '',
        tin: '',
        duns: '',
        email: '',
        dBankName: '',
        dAccountNumber: '',
        dAccountNumberConfirm: '',
        dRoutingNumber: '',
        dRoutingNumberConfirm: '',
        cBankName: '',
        cAccountNumber: '',
        cAccountNumberConfirm: '',
        cRoutingNumber: '',
        cRoutingNumberConfirm: '',
        name: '',
        lastname: '',
        username: '',
        agree: false,
    };

    $scope.stepsValid = ['', false, false, false, false];

    $scope.validErrors = {
        companyName: [false, ''],
        address: [false, ''],
        city: [false, ''],
        state: [false, ''],
        zipcode: [false, ''],
        phone: [false, ''],
        phoneExt: [false, ''],
        fax: [false, ''],
        dba: [false, ''],
        tin: [false, ''],
        duns: [false, ''],
        email: [false, ''],
        dBankName: [false, ''],
        dAccountNumber: [false, ''],
        dAccountNumberConfirm: [false, ''],
        dRoutingNumber: [false, ''],
        dRoutingNumberConfirm: [false, ''],
        cBankName: [false, ''],
        cAccountNumber: [false, ''],
        cAccountNumberConfirm: [false, ''],
        cRoutingNumber: [false, ''],
        cRoutingNumberConfirm: [false, ''],
        name: [false, ''],
        lastname: [false, ''],
        username: [false, ''],
        agree: [false, ''],
    };

    $scope.notification = {title: '', type: ''};

    $scope.states = [];

    var getStates = States.all();

    getStates.success(function (response) {
        $scope.states = response;
       
    });


    $scope.showRegistration = function () {
        $('#modal-wizard').modal('show');
    }

    $scope.hideRegistration = function () {
        $('#modal-wizard').modal('hide');
    }
	$scope.cancelVerification = function() {
		Session.destroy();
		$location.path('/');
	}
	$scope.verifyLogin = function () {
		var verificationData = {"verificationCode": $scope.verification_code};
		$http({method: 'post', url: 'api/verify', data:verificationData}).then(function (res) {
			if(res.data.success == true)
			{
				$scope.error = false;
				$scope.errorMessage = '';
				var location = $rootScope.prevUrl;
				if(location.indexOf("transactionDetails") != -1) {
				   window.location = $rootScope.prevUrl;
				}else if(location.indexOf("transactionPdetails") != -1) {
				   window.location = $rootScope.prevUrl;
				}else {
					$location.path('/dashboard/home');									
				}
			}
			if(res.data.error == true)
			{
				$scope.error = 1;
				$scope.errorMessage = res.data.msg;
			}
		});
	};
    $scope.loginSubmit = function () {
        angular.element('#loader img:last-child').attr('src','assets/images/bigspinner.gif');
		angular.element('#loader').css('background-color','#fff');
		angular.element('#loader img').css('width','6%');
		angular.element('#loader img').css('left','45%');
		angular.element('#loader img').css('top','40%');
		angular.element('#loader').css('overflow','hidden');
		loader().show();
        AuthService.login($scope.loginData).then(function (user) {
            if(user.success == 'locked') {
				$scope.error = true;
				$scope.errorMessage = user.error;
				loader().hide();
				//return;
			}else if(user.success == false)
			{
				loader().hide();
				// var request = LockUserAttempts.lockUserAfterFourAttempts($scope.loginData.username);
				LockUserAttempts.lockUserAfterFourAttempts($scope.loginData.username).then(function (response){
					// alert(response.data.error);
					if (response.data.error == true) {
						$scope.error = true;
						$scope.errorMessage = "Please, try with forgot your password";
						return;
					}
					else {
						$scope.error = true;
						$scope.errorMessage = user.error;
						loader().hide();
					} 
				});
			}else {
				$http({method: 'get', url: 'api/check_ip', params: user.user}).then(function (res) {
				
					if(res.data.error == true)
					{                                     
						loader().hide();
						$location.path('/verify');
						return false; // break
					}else {                                         
						if (user.success == true) {
							ChangePassSixtyDays.changePasswordAfterSixtyDays(Session.id()).then(function (response){
							   if (response.data.error == true) {
									$scope.error = true;
									$scope.errorMessage = "Your user has been blocked, try with forgot your password";
									 loader().hide();
									return;
								} else {
									$scope.loginData.username = '';
									$scope.loginData.password = '';
									$scope.error = false;
									$scope.errorMessage = '';
									$scope.setCurrentUser(user.user);
									var location = $rootScope.prevUrl;
									if(location.indexOf("transactionDetails") != -1) {
									   window.location = $rootScope.prevUrl;
									}else if(location.indexOf("transactionPdetails") != -1) {
									   window.location = $rootScope.prevUrl;
									}else {
										$location.path('/dashboard/home');									
									}
								}
							});
						} 
					}
				});
			}

        });
    };

    $scope.recoveryEmail = '';
    $scope.recoveryError = {error: false, msg: ''};

    $scope.recoverySubmit = function () {
        loader().show();
        $('#forgotModal button').attr('disabled', 'disabled');

        PasswordRecoveryService.recovery({email: $scope.recoveryEmail}).then(function (result) {

            if (result.success == false)
            {
                $scope.recoveryError.error = true;
                $scope.recoveryError.msg = result.error.email[0];
            }
            else
            {
                $scope.recoveryError.error = false;
                $('#forgotModal').modal('hide');
                toaster.pop({
                    type: 'info',
                    title: 'E-mail Send Succesfully'
                });
            }

            $('#forgotModal button').removeAttr('disabled');
            loader().hide();
        });
    };

    $scope.registerSubmit = function () {
        loader().show();

        var data = $.extend(true, {}, $scope.register);
        data.state = data.state.id;

        $('#modal-wizard button').attr('disabled', 'disabled');
        RegisterService.register(data).then(function (result) {

            for (var key in $scope.validErrors) {
                $scope.validErrors[key] = [false, ''];
            }

            if (result.success == false)
            {
                var errors = result.error;
                for (var key in errors) {
                    $scope.validErrors[key] = [true, errors[key][0]];
                }

                $scope.stepsValid = ['', true, true, true, true];

                var stepToGo = $scope.currentStep;
                var index = 1;
                for (var key in $scope.validErrors) {

                    if ($scope.validErrors[key][0] == true)
                    {
                        if (index >= 1 && index <= 12) {
                            $scope.stepsValid[1] = false;
                            stepToGo = 1;
                        }
                        else if (index >= 13 && index <= 22) {
                            $scope.stepsValid[2] = false;
                            if (2 < stepToGo)
                                stepToGo = 2;
                        }
                        else if (index >= 23 && index <= 25) {
                            $scope.stepsValid[3] = false;
                            if (3 < stepToGo)
                                stepToGo = 3;
                        }
                        else
                            $scope.stepsValid[4] = false;
                    }
                    index++;
                }

                $scope.goToStep(stepToGo);
            }
            else
            {
                $scope.hideRegistration();
                $scope.notification.title = "Registration Successfully";
                $('#notificationModal').modal('show');
            }

            $('#modal-wizard button').removeAttr('disabled');
            loader().hide();
            console.log(result);
            console.log($scope.validErrors);
        });
    };

    $scope.copyToLeft = function () {
        $scope.register.dBankName = $scope.register.cBankName;
        $scope.register.dAccountNumber = $scope.register.cAccountNumber;
        $scope.register.dAccountNumberConfirm = $scope.register.cAccountNumberConfirm;
        $scope.register.dRoutingNumber = $scope.register.cRoutingNumber;
        $scope.register.dRoutingNumberConfirm = $scope.register.cRoutingNumberConfirm;
    };

    $scope.copyToRight = function () {
        $scope.register.cBankName = $scope.register.dBankName;
        $scope.register.cAccountNumber = $scope.register.dAccountNumber;
        $scope.register.cAccountNumberConfirm = $scope.register.dAccountNumberConfirm;
        $scope.register.cRoutingNumber = $scope.register.dRoutingNumber;
        $scope.register.cRoutingNumberConfirm = $scope.register.dRoutingNumberConfirm;
    };

    $scope.currentStep = 1;
    $scope.goToStep = function (step) {
        var $panes = $('.step-pane');
        $panes.removeClass('active');
        $($panes[step - 1]).addClass('active');
        $scope.currentStep = step;
    }
});

myApp.controller('LogoutController', function ($scope, $location, AuthService) {

    AuthService.logout().then(function () {

        $location.path('/');
    });
});
