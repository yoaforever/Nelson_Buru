﻿//YCR-06-19-2014
(function () {
    'use strict';

    // Controller name is handy for logging
    var controllerId = 'payorCtrl';

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
         'datacontext', 'logger', payorCtrl]);

    function payorCtrl(common,
        config,
        $route, $routeParams,
        $location,
        $resource,
        $scope,
        bsDialog,
        datacontext, logger) {
        // Using 'Controller As' syntax, so we assign this to the vm variable (for viewmodel).
        var vm = this;
        var getLogFn = common.logger.getLogFn;

        var keyCodes = config.keyCodes;

        var validator = common.validator.validateUser();
        vm.validator = validator;

        // Bindable properties and functions are placed on vm.
        vm.title = 'New Payor';
        vm.save = save;
        vm.cancel = cancel;
        vm.payor = {};
        vm.goToDashboard = goToDashboard;
        vm.goToUserSettings = goToUserSettings;
        vm.hasChanges = hasChanges;
        vm.currentcustomer = {};

        vm.isSaving = false;
        vm.hasChanges = hasChanges;
        vm.saved = false;



        $routeParams.id = 0;
        var canceldialogVisible = false;

        //YCR 08/29/2014
        vm.cities = [];
        vm.selectedCity = {};
        vm.states = [];
        vm.selectedState = {};
        vm.countries = [];
        vm.selectedCountry = {};

        //Call Controller Init Method
        activate();

        //Controller Init Method
        function activate() {
            if (!datacontext.validSession())
                return;

            common.activateController([loadLookups(), addNewPayor()], controllerId)
              .then(function () { });

        }

        function save() {
            if (validation() && canSave()) {
                vm.isSaving = true;
                // datacontext.saveChanges().fin(complete);
                vm.currentcustomer = datacontext.getCurrentCustomer();

                vm.payor.cityId = vm.selectedCity.id;
               
                datacontext.saveChanges().fin(complete);

            };
            function complete() {
                vm.isSaving = false;             
            };
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
            return true;


            var result = vm.validator.isValid(vm.user, vm.validator.validateObject);

            if (!result.isValid) {
                logger.logError('Please check required fields', 'error');
            }
            return result.isValid;
        }

        //Load Function usually used to load data
        function addNewPayor() {
            vm.currentcustomer = datacontext.getCurrentCustomer();
            var initpayor = { active: true, url:'_' }
            vm.payor = datacontext.addNewPayor(initpayor);
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
        
        function loadLookups() {

            vm.cities = datacontext.getCitiesLookup();

            vm.states = datacontext.getStatesLookup();

            vm.countries = datacontext.getCountriesLookup();

            vm.customers = datacontext.getCustomersLookup();
            vm.currentcustomer = datacontext.getCurrentCustomer();
        }
    }
})();
