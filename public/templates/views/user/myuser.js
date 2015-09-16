var userServices = angular.module('userServices', ['ngRoute', 'ngResource']);


userServices.controller('MyUserCtrl', function ($scope, $stateParams, $state, ListUsersRol,Permissions, Session) {

    $scope.user_id = Session.id();
    var getUsers = ListUsersRol.listMyUsersRol($scope.user_id);
    getUsers.success(function (response) {
        $scope.users = response;
    });
   $scope.permit=  Permissions.permiss();

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

userServices.controller('MyNewUserCtrl', function ($scope, $state, $location, Users, Session, Roles, toaster) {

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
    $scope.customer_current = Session.customer_id();
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

    $scope.cancel = function () {
        $state.reload();
    };
});

userServices.controller('MyEditUserCtrl', function ($scope, $state, $stateParams, Users, toaster) {


    $scope.submit = function () {
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
//            $scope.flash = response.status;
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


userServices.factory("Users", function ($http) {

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


userServices.factory("ListUsersRol", function ($http) {

    return{
        listMyUsersRol: function (id) {
            var request = $http.get('api/list_users_rol/' + id);
            return request;
        }
    }

});

