var userProfile = angular.module('userProfile', ['ngRoute', 'ngResource']);

userProfile.controller('userProfileCtrl', function ($scope, $stateParams, $state, Users, Session, UpdateUserProfile, toaster, logger) {

    $scope.user_id = Session.id();
    var getUsers = Users.get($scope.user_id);
    getUsers.success(function (response) {
        $scope.users = response;
    });
    

    
        $scope.myVar = 0;
       $scope.submit = function () {
           $scope.users.image_profile = angular.element($('#file')).val(); 
           alert($scope.users.image_profile);
           $scope.users.old_password = $scope.old_password;
            $scope.users.confirm_password = $scope.confirm_password;
        var request = UpdateUserProfile.updateProfile(Session.id(),$scope.users);
        request.success(function (response) {
            if (response.success === true) {
                 $scope.password_old='';
                $scope.password_confirm  ='';
                $scope.message_new_p ='';
                $scope.users.password ='';
                $scope.old_password='';
                $scope.confirm_password='';
//                toaster.pop({
//                    type: 'success',
//                    title: 'User Profile Updated Successfully'
//                });
//                toaster.pop({
//                    type: 'info',
//                    title: 'E-mail Send Succesfully'
//                });
//               
//              //  return;
//                $state.reload();
             logger.logSuccess('User Profile Updated Successfully.');
             logger.log('E-mail Send Succesfully.');
            }
           
         
        });
        if(logger){
              $state.reload();   
            }

        request.error(function (response) {
            //  $scope.flash = response.status;
            if (response.password_err === 1) {
                $scope.message_new_p = 'Need 8-16 characters!';
                 $scope.password_old='';
                $scope.password_confirm  ='';
//                $scope.messageEmail = 'This email already exist';
                toaster.pop({
                    type: 'error',
                    title: 'The password should contains between 8-15 characters'
                });
                return;
            } else
            if (response.password_err === 2) {
                $scope.message_new_p = 'Need lowercase letter!';
                 $scope.password_old='';
                $scope.password_confirm  ='';
                toaster.pop({
                    type: 'error',
                    title: 'The password should contains lowercase letter'
                });
                return;
            }
            if (response.password_err === 3) {
                $scope.message_new_p = 'Need capital letter!';
                 $scope.password_old='';
                $scope.password_confirm  ='';
                toaster.pop({
                    type: 'error',
                    title: 'The password should contains capital letter'
                });
                return;
            }
            if (response.password_err === 4) {
                $scope.message_new_p = 'Need numbers!';
                 $scope.password_old='';
                $scope.password_confirm  ='';
                toaster.pop({
                    type: 'error',
                    title: 'The password should contains number'
                });
                return;
            }
            if (response.password_err === 0) {
                $scope.password_old = 'This is not the old password!';
                 $scope.message_new_p='';
                $scope.password_confirm  ='';
                toaster.pop({
                    type: 'error',
                    title: 'This is not the old password'
                });
                return;
            }
              if (response.password_err === 6) {
                $scope.password_confirm = 'Password not match!';
                $scope.message_new_p= '';
                $scope.password_old='';
                toaster.pop({
                    type: 'error',
                    title: 'This password not match'
                });
                return;
            }
             if (response.password_err === 7) {
                $scope.message_new_p = 'Need a  different password of previous password!';
                $scope.password_old='';
                $scope.password_confirm  ='';
                toaster.pop({
                    type: 'error',
                    title: 'This password cannot be the same previous password'
                });
                return;
            }
            else
             if (response.password_err === 5) {
                $scope.message_new_p = 'Need special characters. Ex. !@#$%&-_!';
                 $scope.password_old='';
                $scope.password_confirm  ='';
                toaster.pop({
                    type: 'error',
                    title: 'The password should contains special character'
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


userProfile.factory("Users", function ($http) {

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
         searchDataUser: function (id) {
            var request = $http.get('api/search_data_user/' + id);
            return request;
        },
        delete: function (id) {
            //delete a specific post
        }
    }

});


userProfile.factory("UpdateUserProfile", function ($http) {

    return{
        updateProfile: function (id, data) {
            var request = $http.post('api/update_user_profile/' + id, data);
            return request;
        }
    }

});