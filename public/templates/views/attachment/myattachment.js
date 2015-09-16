var myAttachments = angular.module('myAttachments', ['ngRoute', 'ngResource']);

	myAttachments.controller('AttachmentAllCtrl', function ($scope, TransactionTypes,logger, $route,$routeParams,Session,Attachments,$modal, $log,Transactions) {
		  var vm = this;
		  vm.transaction = {};
		  vm.fileNameChaged = fileNameChaged;
		  vm.attchedfilescount = 3;
		  vm.attachments = {};
		  vm.fileDescription = '';
		  vm.customer_id = Session.customer_id();		  
		  vm.removeDocument=removeDocument;
		  vm.loadAttachment = loadAttachment;
		  vm.sendEmail = sendEmail;
		  vm.downloadFile = downloadFile;
		  if(typeof $routeParams.id != 'undefined') {
			  vm.transaction.id = $routeParams.id;
			  var files = Attachments.get(vm.transaction.id);
			  files.success(function (response) {
				vm.attachments = response;
			  });
		  }
			
		  vm.attachmenttypes = [];//[{ id: 1, description: 'BOL' }, { id: 2, description: 'Invoice' }, { id: 3, description: 'Dispute' }, { id: 4, description: 'Other' }];
		  vm.selectedattachmenttype = {};  
		  var getTransactionTypes = TransactionTypes.all();
		  getTransactionTypes.success(function (response) {
			$scope.transactions_types = response;
		  });
		function loadAttachment(txn)
		{
		  var files = Attachments.get(txn.id);
		  
		  files.success(function (response) {
			$scope.items = response;
			var getTransactionTypes = TransactionTypes.all();
			getTransactionTypes.success(function (response) {
				$scope.items.transactions_types = response;
			});
			$scope.items.transactions = txn;
			console.log($scope.items);
	        var modalInstance = $modal.open({
	            templateUrl: './templates/views/attachment/attachmentMode.html',
	            controller: 'ModalInstanceCtrl',
	            size: 'lg',
	            resolve: {
	                items: function () {
	                    return $scope.items;
	                }
	            }
	        });
	        modalInstance.result.then(function (selectedItem) {
	        }, function () {
	            $log.info('Modal dismissed at: ' + new Date());
	        });
		});
	}
	function sendEmail(item)
	{
		var attachments = item;
		attachments.customer_id = Session.customer_id();
		var request = Attachments.send(item.id,attachments);
		request.success(function(response) {
			logger.log("Email sent successfully");
		});
	}
	function fileNameChaged(value) {			
	 if (validation()) {
			uploadFile(value);
		}
	}
	
	function validation() {
		var error = 0;
		//Transaction type
		if (!$.isEmptyObject(vm.selectedattachmenttype)) {
			vm.typeIsValid = true;
		}
		else {
			vm.typeIsValid = false;
			error++;
		};

		if (error > 0) {
			logger.logError('Please select an attachment type', 'error');
			vm.isValid = false;
			return false;
		}
		return true;;
	}
	
	function downloadFile(item) 
	{
            if (!item) {
                return;
            }

        window.open('/downloadAttachment', '_blank');

    }
	
	
	function removeDocument(item)
	{
		var attachment_id = item.id;
		var transactions_id = item.transaction_id;
		filepath = item.file_path;
		var formData = new FormData();
		formData.append("attachment_id", attachment_id);
		formData.append("filepath", filepath);
		formData.append("transactions_id", transactions_id);
		formData.append("file_name", item.file_name);
		$.ajax({
			type: "POST",
			url: "/deleteAttachment",
			contentType: false,
			processData: false,
			data: formData,
			cache: false,
			success: function (response) {		

				if(response.success == false)
				{
					logger.logError(response.msg);
					
				}else
				{
					logger.log('Deleted Successfully');	
				}
				
				var files = Attachments.get(transactions_id);
				files.success(function (response) {
					vm.attachments = response;
					$scope.items = vm.attachments;
					var getTransactionTypes = TransactionTypes.all();
						getTransactionTypes.success(function (response) {
						$scope.items.transactions_types = response;
					});
					var getTransaction = Transactions.get(transactions_id);
					getTransaction.success(function (response) {
						$scope.items.transactions = response;
					});
				});
				
			},
			error: function (err) {							
				
				logger.logError('Error:' + err.message);

			}
		});		
	}
	
	function uploadFile(value) {

		vm.showLoading = true;
		
		vm.loadingMsg = 'Uploading file...';
		var files = $('#Attachmentfile');
		console.log(files);
		var transactions_id = $('#txnId').val();
		if (files.length > 0) {
			if (window.FormData !== undefined) {
				var formData = new FormData();
				var opmlFile = $('#Attachmentfile')[0];
				var files = opmlFile.files[0];
				
				formData.append("opmlFile", opmlFile.files[0]);
				formData.append("txnId", transactions_id);
				formData.append("txnType", vm.selectedattachmenttype.id);
				formData.append("isPublic", vm.docIspublic);
				formData.append("customerId", vm.customer_id);
				formData.append("fileDescription", vm.fileDescription);
				
				if(files.name.split('.').pop() =='doc' || files.name.split('.').pop() =='xls' || files.name.split('.').pop() =='txt' || files.name.split('.').pop() =='jpg' || files.name.split('.').pop() =='jpeg' || files.name.split('.').pop() =='docx' || files.name.split('.').pop() =='png' || files.name.split('.').pop() =='pdf')
				{
					if(opmlFile.size <= 20971520){							
						$.ajax({
							type: "POST",
							url: "/uploading",
							contentType: false,
							processData: false,
							data: formData,
							cache: false,
							success: function (response) {
								if(response.success == false) {
									logger.logError(response.msg);
								}else {
									logger.log('Uploaded Successfully');
								}
								vm.fileDescription = "";
								vm.showLoading = false;
								vm.loadingMsg = '';
								var files = Attachments.get(transactions_id);
								files.success(function (response) {
									vm.attachments = response;
									$scope.items = vm.attachments;
									var getTransactionTypes = TransactionTypes.all();
										getTransactionTypes.success(function (response) {
										$scope.items.transactions_types = response;
									});
									var getTransaction = Transactions.get(transactions_id);
									getTransaction.success(function (response) {
										$scope.items.transactions = response;
									});
								});
								
							},
							error: function (err) {
								vm.showLoading = false;
								vm.loadingMsg = '';
								logger.logError('Error:' + err.message);
							}
						}); 
					}
					else
					{
						logger.log("File size is more 20 Mb!");
					}
				}
				else
				{
					logger.log("Invalid File!");
				} 
			} else {
				logger.log("Browser issue!");
			}
		}
	};
			
			
});
myAttachments.factory("Attachments", function ($http) {

    return{
        get: function (id) {			
            var request = $http.get('getattachments/' + id);	
			return request;
        },
		send: function (id,data) {			
            var request = $http.put('attachment/email/' + id, {params:data});	
			return request;
        }
    }

});
