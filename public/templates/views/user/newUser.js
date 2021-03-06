﻿//YCR-06-19-2014
(function () {
    'use strict';

    // Controller name is handy for logging
    var controllerId = 'newUserCtrl';

    // Define the controller on the module.
    // Inject the dependencies. 
    // Point to the controller definition function.
    angular.module('myApp').controller(controllerId,
        ['common',
         'config',
         '$route', '$routeParams',
         '$location',
         '$resource',
         '$scope',
         'bootstrap.dialog',
         'datacontext','logger', newUserCtrl]);

    function newUserCtrl(common,
        config,
        $route, $routeParams,
        $location,
        $resource,
        $scope,
        bsDialog,
        datacontext,logger) {
        // Using 'Controller As' syntax, so we assign this to the vm variable (for viewmodel).
        var vm = this;
        var getLogFn = common.logger.getLogFn;
      
        var keyCodes = config.keyCodes;

        var validator = common.validator.validateUser();
        vm.validator = validator;

        // Bindable properties and functions are placed on vm.
        vm.title = 'New User';
        vm.save = save;
        vm.cancel = cancel;
        vm.user = { };      
        vm.goToDashboard = goToDashboard;
        vm.goToUserSettings = goToUserSettings;
        vm.hasChanges = hasChanges;
        vm.currentcustomer = {};

        vm.isSaving = false;
        vm.hasChanges = hasChanges;
        vm.saved = false;

        

        $routeParams.id = 0;
        var canceldialogVisible = false;
        //Call Controller Init Method
        activate();

        //Controller Init Method
        function activate() {            
                common.activateController([addNewUser()], controllerId)
                  .then(function () {  });          

        }             

        function save() {
            if (validation() && canSave()) {
                vm.isSaving = true;
                // datacontext.saveChanges().fin(complete);
                vm.currentcustomer = datacontext.getCurrentCustomer();        
                vm.user.currentcustomer = vm.currentcustomer.id;
                var initUser = {
                    name: vm.user.name,
                    lastName: vm.user.lastName,
                    email: vm.user.email,
                    userName: vm.user.userName,
                    active: true,
                    customerId: vm.currentcustomer.id
                }
               
                var api = $resource('/Account/AddUser', {}, { AddUser: { method: 'POST' } });

                api.AddUser(initUser, function (successResult) {
                   

                    if (!successResult.success) {
                        logger.logError(successResult.errors, 'error');
                        vm.isSaving = false;
                        vm.saved = false;
                    } else {
                        vm.isSaving = true;
                        vm.saved = true;
                       // logger.logSuccess("Saved successfully!");
                    }

                },
                function (errorResult) {
                    logger.logError(errorResult.data.Message, 'error');
                    vm.isSaving = false;
                    vm.saved = false;
                });



            };
            //function complete() {
            //    vm.isSaving = false;             
            //};
        }

        function cancel() {
            vm.title = 'HERE ---> Template PayAnyBiz Activated Loaded :) --> ';
        }
        
        function hasChanges() {
            return datacontext.hasUserChanges();
        }

        function canSave() {
            return vm.hasChanges() && !vm.isSaving;
        };

        function goToDashboard() {
            if (!canceldialogVisible) {
                var url = '/' + vm.returnTo;
                $location.path(url);
            }
        };

        function goToUserSettings() {
            if (!canceldialogVisible) {
                var url = '/userSettings';
                $location.path(url);
            }
        };

        

        function validation() {

            var result = vm.validator.isValid(vm.user, vm.validator.validateObject);

            if (!result.isValid) {
                logger.logError('Please check required fields', 'error');
            }
            return result.isValid;
        }

        //Load Function usually used to load data
        function addNewUser() {
            vm.currentcustomer = datacontext.getCurrentCustomer();
            var initUser = { active: true, customerId: vm.currentcustomer.id }
            vm.user = datacontext.addNewUser(initUser);
        }

       
        $scope.$on('$locationChangeStart', function (event, next, current) {
            
            if (canceldialogVisible) {
                event.preventDefault();
                return;
            }
            if (!vm.saved) {
                canceldialogVisible = true;
                var dlg = bsDialog.confirmationDialog('Please Confirm', 'Cancel ' + vm.title + '?');
                dlg.then(
                    //Ok Button
                    function (btn) {
                        canceldialogVisible = false;
                        vm.saved = true;
                        datacontext.cancelChanges();
                        $location.path(next);
                        return;
                    },
                    //Cancel Button (Not needed in this case, since not processed)
                   function (btn) {
                       canceldialogVisible = false;
                   });
                event.preventDefault();

            }
        });

       
    }
})();
