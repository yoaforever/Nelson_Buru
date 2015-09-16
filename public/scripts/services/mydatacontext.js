(function () {
    'use strict';

    var serviceId = 'mydatacontext';
    angular.module('myApp').factory(serviceId, [ '$scope', '$location', mydatacontext]);

    function mydatacontext($scope, $location) {
         var primePromise;
        var txnCount = {};


        //JRB 12/28/2013
        manager.enableSaveQueuing(true);


        //JRB 12/15/2013
        var lookupCachedData = {};

        var storeMeta = {
            isLoaded: {
                transactions: false,
                users: false
            },
            changedData: {
                transactions: false,
                users: false
            }
        };

        //JRB 12/29/2013
        var transactionStatuses = {
            PENDING: 1,
            VERIFIED: 2,
            APPROVED: 3,
            DISPUTED: 4
        };
        
        var service = {
            addNewTransaction: addNewTransaction,
            addTransactionAddtionalRefNbr: addTransactionAddtionalRefNbr,
            addAttchment: addAttchment,
            addNewUser: addNewUser,
            addNewBiller: addNewBiller,
            addNewPayor: addNewPayor,
            addRelation: addRelation,
            //JRB 05/24/2014
            cancelChanges: cancelChanges,
            changeSeletecedTransactionStatusTo: changeSeletecedTransactionStatusTo,
            changeTransactionStatusTo: changeTransactionStatusTo,
            //
            getTransactions: getTransactions,
            getTransactionById: getTransactionById,
            addTransactionDispute: addTransactionDispute,
            getTransactionByIdLocally: getTransactionByIdLocally,
            getTransactionByIdFromServer: getTransactionByIdFromServer,
            getTransactionsCount: getTransactionsCount,
            getFilteredCount: getFilteredCount,
            getCountsForEachStatus: getCountsForEachStatus,
            getTransactionCatrgoriesLookup: getTransactionCatrgoriesLookup,
            getTransactionTypesLookup: getTransactionTypesLookup,
            getTransactionStatusLookup: getTransactionStatusLookup,
            getCustomersLookup: getCustomersLookup,
            getCurrentCustomer: getCurrentCustomer,
            getDisputeReasonLookup: getDisputeReasonLookup,
            getDisputeCategoryLookup: getDisputeCategoryLookup,
            getCitiesLookup: getCitiesLookup, //YCR 08/28/2014
            getStatesLookup: getStatesLookup, //YCR 08/28/2014
            getCountriesLookup: getCountriesLookup, //YCR 08/28/2014
            getPayorTotalSelectedAmount: getPayorTotalSelectedAmount,
            getTransactionRelatedNumbers: getTransactionRelatedNumbers,
            getTransactionDisputeInfo: getTransactionDisputeInfo,
            getTransactionHistory: getTransactionHistory,
            getAttachments: getAttachments,
            getTransactionBatchToDispute: getTransactionBatchToDispute, //JRB 05/25/2014.
            getTransactionBatchToApprove: getTransactionBatchToApprove,
            getStatusDescription: getStatusDescription, //JRB 05/29/2014 
            getUsers: getUsers,
            getUserById: getUserById,
            getBillerById: getBillerById,
            getBillers: getBillers,
            getPayors: getPayors,
            getNextTxnNumber: getNextTxnNumber,
            //
            hasTransactionChanges: hasTransactionChanges,
            hasUserChanges: hasUserChanges,
            //
            postTransactionSelectedValue: postTransactionSelectedValue,
            prime: prime,
            getTxnCount: getTxnCount,
            primeTxnCount: primeTxnCount,

            validSession: validSession,

            //05/25/2014
            rejectchanges: rejectchanges,
            //
            //JRB 09/09/2014 (C#20140817-1)
            removeTransactionAddtionalRefNbr: removeTransactionAddtionalRefNbr,
            //
            saveChanges: saveChanges,
            //
            transactionStatuses: transactionStatuses,
            getCurrentUser: getCurrentUser,
            //JRB 11/09/2014
            getUserProfile: getUserProfile,
            getUserInfoEnt: getUserInfoEnt,
            //YCR 11/11/2014
            getTransactionComments: getTransactionComments,
            addTxnComment: addTxnComment,
            getTasks: getTasks,
            addTask: addTask,
            removeTask: removeTask,

            //ANGEL
            test: test
        };
        
     
         function getTxnCount() {
            return txnCount;
        }
        return service;
    }
})();