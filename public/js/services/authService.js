
myApp.factory('AuthService', function ($http, Session) {
    var authService = {};

    authService.login = function (credentials) {
        return $http({method: 'get', url: 'api/login/auth', params: credentials})
                .then(function (res) {
                    if (res.data.success === true)
                    {
                        Session.create(res.data.user);
                    }
                    return res.data;
                });
    };
	authService.checkIp = function (user) {
        return $http({method: 'get', url: 'api/check_ip', params: user})
                .then(function (res) {
					if (res.data.success === true)
                    {
                       return 1;
                    }else
					{
						return 0;
					}
				});
    };
    authService.logout = function (credentials) {
        return $http({method: 'GET', url: 'api/login/destroy'})
                .then(function () {
                    Session.destroy();
                });
    };

    authService.isAuthenticated = function () {
        return !!Session.id();
    };

    return authService;
});


myApp.service('Session', function ($localStorage, $sessionStorage) {
    this.create = function (user) {
        $sessionStorage.user = user;
        // this.id = user.id;
        // this.userName = user.username;
        //       this.customer_id =user.customers_id;
    };
    this.destroy = function () {
        $sessionStorage.user = undefined;
        // this.id = null;
        // this.userName = null;
    };
    this.id = function () {
        return (typeof $sessionStorage.user === 'undefined') ? null : $sessionStorage.user.id;
    };
    this.userName = function () {
        return (typeof $sessionStorage.user === 'undefined') ? null : $sessionStorage.user.username;
    };
    this.customer_id = function () {
        return (typeof $sessionStorage.user === 'undefined') ? null : $sessionStorage.user.customers_id;
    };
    this.role_id = function () {
        return (typeof $sessionStorage.user === 'undefined') ? null : $sessionStorage.user.role_id;
    };
    this.name = function () {
        return (typeof $sessionStorage.user === 'undefined') ? null : $sessionStorage.user.name;
    };
});

myApp.factory('RegisterService', function ($http) {
    var regService = {};

    regService.getStates = function () {
        return $http.get('api/states')
                .then(function (res) {
                    return res.data.states;
                });
    };

    regService.register = function (data) {
        return $http({method: 'get', url: 'api/register', params: data})
                .then(function (res) {
                    return res.data;
                });
    };

    return regService;
});


//myApp.service('Permissions', function (Session, $scope) {
//    $scope.role_id = Session.role_id();
//     this.permiss = function ($scope) {
//          if ($scope.role_id == 5) {
//            $scope.nav = "admin";
//        }
//        if ($scope.role_id == 2) {
//            $scope.nav1 = "roll base";
//        }
//        if ($scope.role_id == 3) {
//            $scope.nav2 = "roll user";
//        }
//        else
//        if ($scope.role_id == 6) {
//            $scope.nav3 = "biller roll";
//        }
//
//    };
//});

myApp.service('Permissions',function(Session){
        this.role_id = Session.role_id();
     this.permiss = function (role_id) {
          if (this.role_id == 5) {
            this.nav = "admin";
        }
        if (this.role_id == 2) {
            this.nav1 = "roll base";
        }
        if (this.role_id == 3) {
            this.nav2 = "roll user";
        }
        else
        if (this.role_id == 6) {
            this.nav3 = "biller roll";
        }
     };
    });

myApp.factory('PasswordRecoveryService', function ($http) {
    var recoveryService = {};

    recoveryService.recovery = function (data) {
        return $http({method: 'get', url: 'api/recovery', params: data})
                .then(function (res) {
                    return res.data;
                });
    };

    return recoveryService;
});

    
    myApp.factory("ChangePassSixtyDays", function ($http) {

    return{
        changePasswordAfterSixtyDays: function (id) {
            var request = $http.get('api/change_password_old/' + id);
            return request;
        }
    };
    

    
});

       myApp.factory("LockUserAttempts", function ($http) {

    return{
        lockUserAfterFourAttempts: function (id) {
            var request = $http.get('api/lock_user_attempts/' + id);
            return request;
        }
    };
    });