var ftpService = angular.module('ftp', ['ngRoute', 'ngResource']);
ftpService.controller('ftpController', function ($scope,$q,Upload,$location,logger,$http,$route,$routeParams,Session,$modal,$log) {
	$scope.ftp = {};
	var request = $http.get('getFtp/'+Session.id());
	request.success(function(response) {
		$scope.ftp.ftp_host = response.ftp_host;
		$scope.ftp.ftp_user = response.ftp_username;
		$scope.ftp.ftp_pass = response.ftp_password;
		if(response.cron_time) { 
			var time = response.cron_time.split(":");
			$scope.ftp.hours = time[0];
			$scope.ftp.minutes = time[1];
		}
	});
	$scope.uploadedFiles = [];
	$scope.Queue = [];
	$scope.showUpload = 0;
	$scope.ftp.user_id = Session.id();
	$scope.ftp.customer_id = Session.customer_id();
	$scope.upload = function (files) {
		if (files && files.length) {
			for (var i = 0; i < files.length; i++) {
				var file = files[i];
				if($scope.Queue.indexOf(file) == -1)
				{
					$scope.Queue.push(file);
				}
				Upload.upload({
					url: 'api/attachments',
					fields: {
						'data': $scope.mail
					},
					file: file
				}).progress(function (evt) {
					var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
					$scope.log = 'progress: ' + progressPercentage + '% ' +evt.config.file.name + '\n' + $scope.log;
					$scope.progress = 1;
				}).success(function (data, status, headers, config) {
					if(data){
						$scope.progress = 0;
						$scope.uploadedFiles.push({'name': config.file.name});
						$scope.log = 'file ' + config.file.name + 'uploaded. Response: ' + JSON.stringify(data) + '\n' + $scope.log;
						$scope.files = '';
						$scope.showUpload = 1;
						if(!$scope.$$phase) {
							$scope.$apply();
						}
					}
				});
			}
		}
	};
	
	$scope.validateConnection = function() {
		
		if(!$scope.ftp.ftp_host)
		{
			logger.logError('FTP host name is required');
			return false;
		}
		if(!$scope.ftp.ftp_user)
		{
			logger.logError('FTP username is required');
			return false;
		}
		if(!$scope.ftp.ftp_pass)
		{
			logger.logError('FTP password is required');
			return false;
		}
		var deferredAbort = $q.defer();
		$scope.loading = 1;
		$scope.showMsg = 0;
		// Initiate the AJAX request.
		var request = $http({
			method: "post",
			url: "ftpSettings",
			data:$scope.ftp,
			timeout: 1000000000
		});
		var promise = request.then(
			function( response ) {
				if(response.data.error == true)
				{
					$scope.loading = 0;
					$scope.showMsg = 0;
					logger.logError(response.data.msg);
				}
				if(response.data.success == true)
				{
					$scope.loading = 0;
					$scope.showMsg = 1;
					$scope.MessageText = "Connected Successfully.";
				}
			},
			function( response ) {
				$scope.loading = 0;
				$scope.showMsg = 0;
				logger.log('Opps something went wrong');
			}
		);
	};
	$scope.removeFile = function(index) {
		$scope.Queue.splice(index, 1);
		$scope.uploadedFiles.splice(index, 1);
		$('.attch-lin #file_'+parseInt(index+1)).remove();
	};
	$scope.uploadFiles = function() {
		
		if(!$scope.ftp.ftp_host)
		{
			logger.logError('FTP host name is required');
			return false;
		}
		if(!$scope.ftp.ftp_user)
		{
			logger.logError('FTP username is required');
			return false;
		}
		if(!$scope.ftp.ftp_pass)
		{
			logger.logError('FTP password is required');
			return false;
		}
		if(!$scope.ftp.importType)
		{
			logger.logError('Please select import type');
			return false;
		}
		
		if($scope.Queue.length == 0)
		{
			logger.logError('You must select at least 1 file to upload. Please retry your upload!');
			return false;
		}
		$scope.uploadProgress = 1;
		Upload.upload({
			url: 'ftpSettings',
			fields: $scope.ftp,
			file: $scope.Queue,
			fileFormDataName: 'myFile[]'
		}).success(function (response, status, headers, config) {
			$scope.uploadProgress = 0;
			if(response.success == true) {
				logger.log(response.msg);
			}
			if(response.error == true) {
				logger.logError(response.msg);
			}
		});
	};
	$scope.updateFtpDetails = function() {
		
		if(!$scope.ftp.ftp_host)
		{
			logger.logError('FTP host name is required');
			return false;
		}
		if(!$scope.ftp.ftp_user)
		{
			logger.logError('FTP username is required');
			return false;
		}
		if(!$scope.ftp.ftp_pass)
		{
			logger.logError('FTP password is required');
			return false;
		}
		if($scope.ftp.hours == '' && $scope.ftp.minutes == '')
		{
			logger.logError('Please select time');
			return false;
		}
		var request = $http({
			method: "post",
			url: "saveFtp",
			data:$scope.ftp,
			timeout: 1000000000
		});
		var promise = request.then(
			function( response ) {
				console.log(response);
				if(response.data.error == true)
				{
					logger.logError(response.data.msg);
				}
				if(response.data.success == true)
				{
					logger.log(response.data.msg);
				}
			},
			function( response ) {
				logger.log('Opps something went wrong');
			}
		);
	};
});