'use strict';


angular


    .module('app', ['angularFileUpload'])


    .controller('AppController', ['$scope', 'FileUploader', '$timeout', function($scope, FileUploader, $timeout) {
        
		$scope.isSelected = !$scope.isSelected;		
		$scope.invalidmsg = "";
		var uploader = $scope.uploader = new FileUploader({
            url: '/trximport'
        });
        // FILTERS
        uploader.filters.push({
            name: 'customFilter',
            fn: function(item /*{File|FileLikeObject}*/, options) {
                return this.queue.length < 10;
            }
        });
		
        uploader.filters.push({
            name: 'typeFilter',
            fn: function(item /*{File|FileLikeObject}*/, options) {
            	if(item.name.indexOf('.csv')<=0)
            		{
            		$scope.invalidmsg+=item.name+" rejected due to invalid type\n";
            		  	$scope.showGreeting = true;
            		  	$timeout(function(){
            	          $scope.showGreeting = false;
            	       }, 2000);
            			return false;
            		}
                return true;
            }
        });
		
		
       // CALLBACKS
        uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
            //console.info('onWhenAddingFileFailed', item, filter, options);
        };
        uploader.onAfterAddingFile = function(fileItem,item) {
            //console.info('onAfterAddingFile', fileItem);

        	
        	//fileItem.remove();
            console.info('onAfterAddingFile', item);

        	$scope.invalidcolumns = "";
        	$scope.failedcolumns = "";
        	//console.info('item opt', file);
        	var flag = 0;
        	var r = new FileReader();
            r.onload = function(e) {
                var contents = e.target.result;
                var lines = contents.split('\n');
                var uploadedheader = lines[0].split(",");
                var dbheader = ["Amount","Payor","Biller","Type","Category","Invoice_Number","Related_No.","Due_Date","Arrival_Date","Departure_Date","Payor_Ref","Status"];
                //console.info('dheader',uploadedheader);
                //console.info('ddbheader',dbheader);
                
                //console.log(angular.equals(dbheader,uploadedheader));
                if(dbheader.length == uploadedheader.length)
                {
                	for(var i=0;i<uploadedheader.length;i++){
                		//console.log(uploadedheader.indexOf(String.prototype.trim.apply(dbheader[i])));
                		if(dbheader.indexOf(String.prototype.trim.apply(uploadedheader[i])) == -1){
                			flag++;
                		}
                	}
                }else flag++;
                
                if(flag){
                	fileItem.remove();
                	$scope.invalidcolumns += item.name +" rejected due to invalid columns";
					$scope.showValidColumns = true;
                	$scope.$apply();
                	$timeout(function(){
  					  $scope.showValidColumns = false;
  				    }, 3000);
                	return false;
                	//files = files.splice(f,1);  
                	//this.destroy();
                }
            }
            r.readAsText(item);
        };
        uploader.onAfterAddingAll = function(addedFileItems) {
            //console.info('onAfterAddingAll', addedFileItems);
        };
        uploader.onBeforeUploadItem = function(item) {
            console.info('onBeforeUploadItem', item);
        };
        uploader.onProgressItem = function(fileItem, progress) {
            //console.info('onProgressItem', fileItem, progress);
        };
        uploader.onProgressAll = function(progress) {
            //console.info('onProgressAll', progress);
        };
        uploader.onSuccessItem = function(fileItem, response, status, headers) {
            //console.info('onSuccessItem', fileItem, response, status, headers);
        	if(response.answer == "Error")
    		{
        		$scope.failedcsvclass = 'err-message';
        		if($scope.failedcolumns != "")
	        		$scope.failedcolumns += "<br/><br/>"+"Following Transactions in "+ fileItem.file.name +" are failed to import <br/>"+response.failedrows;
	        	else
	        		$scope.failedcolumns += "Following Transactions in "+ fileItem.file.name +" are failed to import <br/>"+response.failedrows;
        		$scope.showFailedColumns = true;	
    		}
        	else{
        		$scope.failedcsvclass = 'suc-message';
        		$scope.failedcolumns += response.failedrows;
        		$scope.showFailedColumns = true;
        		
        		$timeout(function(){$scope.showFailedColumns = false;},2000);
        	}
        };
        uploader.onErrorItem = function(fileItem, response, status, headers) {
            //console.info('onErrorItem', fileItem, response, status, headers);
        };
        uploader.onCancelItem = function(fileItem, response, status, headers) {
            //console.info('onCancelItem', fileItem, response, status, headers);
        };
        uploader.onCompleteItem = function(fileItem, response, status, headers) {
            //console.info('onCompleteItem', fileItem, response, status, headers);
        };
        uploader.onCompleteAll = function() {
            //console.info('onCompleteAll');
        };

       // console.info('uploader', uploader);
    }]).filter('breakFilter', function () {
        return function (text) {
            if (text !== undefined) return text.replace(/\n/g, '<br/>');
        };
    });