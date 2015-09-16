var composeService = angular.module('compose', ['ngRoute', 'ngResource']);
	composeService.controller('ComposeCtrl', function ($scope, TransactionTypes,logger,$http, $route,$routeParams,Session, $modal,$log,Transactions) {
		$scope.mail = {};
		$scope.$watchCollection('data.tags',function(val){
			$scope.mail.receiver = val;
		});
		$scope.$watchCollection('data.cc',function(val){
			$scope.mail.cc = val;
		});
		$scope.$watchCollection('data.bcc',function(val){
			$scope.mail.bcc = val;
		});
		console.log($scope.mail);
		$scope.SendMail = function(){
			$scope.mail.mailContent;
			$scope.mail.subject;
			$scope.mail.current_user_id = Session.id();
			$scope.mail.current_customer_id = Session.customer_id();
			console.log($scope.mail);
			$http.post('api/sendmail',$scope.mail).success(function(response){
				if(response == 1)
				{
					logger.log("Mail Sent Successfully..");
				}else {
					logger.logError("Error While Sending mail.Please Try Again.");
				}
			});
		};
		
	}).
	directive('autoComplete',['$http','$timeout','Session', function($http,$timeout,Session){
    return {
        restrict:'AE',
        scope:{
            selectedTags:'=model'
        },
        templateUrl:'./templates/views/mail/autocomplete-template.html',
        link:function(scope,elem,attrs){
            scope.suggestions = [];
            scope.selectedTags = [];
            scope.selectedIndex = -1;
            scope.removeTag = function(index){
                scope.selectedTags.splice(index,1);
            }
			
			//console.log(scope.companies);
            scope.search = function(){
				scope.inputData = {};
				scope.inputData.term = scope.searchText;
				scope.inputData.user_id = Session.id();
				
				$http.post(attrs.url,scope.inputData).success(function(data){
					scope.showLoading = 1;
					$timeout(function() {
				      scope.suggestions = data;
						scope.selectedIndex = -1;
						scope.showLoading = 0;
				    }, 800);
					
                    scope.suggestions=data;
                    scope.selectedIndex=-1;
					
                });
            }
            scope.addToSelectedTags = function(index){
				if(scope.selectedTags.indexOf(scope.suggestions[index]) === -1){
					scope.selectedTags.push(scope.suggestions[index]);
                    scope.searchText = '';
                    scope.suggestions = [];
                }else
				{
					scope.selectedTags.splice(index,1);
                    scope.selectedTags.push(scope.suggestions[index]);
                    scope.searchText = '';
                    scope.suggestions = [];
				}
            }
            scope.checkKeyDown = function(event){
				
				if(event.keyCode === 40){
                    event.preventDefault();
                    if(scope.selectedIndex + 1 !== scope.suggestions.length){
                        scope.selectedIndex++;
						
                    }
                }
                else if(event.keyCode === 38){
                    event.preventDefault();
                    if(scope.selectedIndex - 1 !== -1){
                        scope.selectedIndex--;
                    }
                }
                else if(event.keyCode === 13){
                    scope.addToSelectedTags(scope.selectedIndex.email);
                }
            }
            scope.$watch('selectedIndex',function(val){
                if(val !== -1) {
					
                    scope.searchText = scope.suggestions[scope.selectedIndex];
                }
            });
        }
    }
}]);
composeService.controller('CountInbox', function ($scope,$http) {
	$scope.inboxCount = 0;
	$http.get('api/inboxCount').success(function(response){
		$scope.inboxCount = response;
	});
});
composeService.controller('MailDeleteCtrl', function ($scope,$http,$stateParams, $state,$location) {
	$scope.deleteMail = function() {
		$http.get('api/delete_mail/'+$stateParams.id+'/'+$stateParams.folder).success(function(response){
			$location.path('dashboard/inbox');
		});
	};
});
composeService.controller('MailActionCtrl', function ($scope,$http,$stateParams, $state) {
	
	$scope.mail = {};
	
	$scope.SendMail = function() {
		console.log($scope.mail);
	};
});
composeService.controller('CountDrafts', function ($scope,$http) {
	$scope.inboxCount = 0;
	$http.get('api/draftsCount').success(function(response){
		$scope.draftsCount = response;
	});
});
composeService.controller('MailDetailsCtrl', function ($scope,$http,$stateParams, $state,Session,logger,$log) {
	$scope.showCc = 0;
	$scope.mail = {};
	
	$http.get('api/mail_details/'+$stateParams.id+'/'+$stateParams.msgno+'/'+$stateParams.folder).success(function(response){
		$scope.EmailDetails = response.body;
		$scope.subject = response.subject;
		$scope.toDetails = response.toDetails;
		$scope.showCc = 1;
		$scope.ccDetails = response.ccDetails;
		$scope.mail.mailContent = response.body;
		$scope.attachments = response.attachments;
		$scope.msgId = $stateParams.id;
		$scope.msgNumber = $stateParams.msgno;
	});
	$scope.$watchCollection('data.tags',function(val){
		$scope.mail.receiver = val;
	});
	$scope.$watchCollection('data.cc',function(val){
		$scope.mail.cc = val;
	});
	$scope.$watchCollection('data.bcc',function(val){
		$scope.mail.bcc = val;
	});
	$scope.ReplayMail = function(){
		$scope.mail.mailContent;
		$scope.mail.subject;
		$scope.mail.current_user_id = Session.id();
		$scope.mail.current_customer_id = Session.customer_id();
		console.log($scope.mail);
		$http.post('api/replay',$scope.mail).success(function(response){
			if(response == 1)
			{
				logger.log("Mail Sent Successfully..");
			}else {
				logger.logError("Error While Sending mail.Please Try Again.");
			}
		});
	};
	$scope.FarwardMail = function(){
		$scope.mail.mailContent;
		$scope.mail.subject;
		$scope.mail.current_user_id = Session.id();
		$scope.mail.current_customer_id = Session.customer_id();
		console.log($scope.mail);
		$http.post('api/sendmail',$scope.mail).success(function(response){
			if(response == 1)
			{
				logger.log("Mail Sent Successfully..");
			}else {
				logger.logError("Error While Sending mail.Please Try Again.");
			}
		});
	};
	
	
	
});
composeService.controller('InboxCtrl', function ($scope,$rootScope,$location, TransactionTypes,logger,$http, $route,$routeParams,Session, $modal,$log,Transactions) {
	$scope.messages = {};
	$http.get('api/inbox').success(function(data){
		$scope.fromInfo = data.fromInfo;
		$scope.replayInfo = data.replayInfo;
		$scope.details = data.details;
		
	});
	$scope.wemailLogin = function() {
		if($rootScope.webmail == 1)
		{
			$location.path('dashboard/inbox');
		}else
		{
			$location.path('dashboard/webmaillogin');
		}
		
	}
	$scope.wemailLogout = function() {
		$rootScope.webmail = '';
		$location.path('dashboard/webmaillogin');
	};
	 $scope.toTimestamp = function(date) {
	    return Date.parse(date);
	 };
	 $scope.MessageDetails = function(id,msgno,folder) {
		$location.path('dashboard/single/'+id+'/'+msgno+'/'+folder);
	 };
});
composeService.controller('SentCtrl', function ($scope,$rootScope,$location, TransactionTypes,logger,$http, $route,$routeParams,Session, $modal,$log,Transactions) {
	$scope.messages = {};
	$http.get('api/sentitems').success(function(data){
		$scope.fromInfo = data.fromInfo;
		$scope.replayInfo = data.replayInfo;
		$scope.details = data.details;
		
	});
	$scope.wemailLogin = function() {
		if($rootScope.webmail == 1)
		{
			$location.path('dashboard/inbox');
		}else
		{
			$location.path('dashboard/webmaillogin');
		}
		
	}
	$scope.wemailLogout = function() {
		$rootScope.webmail = '';
		$location.path('dashboard/webmaillogin');
	};
	 $scope.toTimestamp = function(date) {
	    return Date.parse(date);
	 };
	 $scope.MessageDetails = function(id,msgno,folder) {
		$location.path('dashboard/single/'+id+'/'+msgno+'/'+folder);
	 };
});

composeService.controller('DraftsCtrl', function ($scope,$rootScope,$location, TransactionTypes,logger,$http, $route,$routeParams,Session, $modal,$log,Transactions) {
	$scope.messages = {};
	$http.get('api/drafts').success(function(data){
		$scope.fromInfo = data.fromInfo;
		$scope.replayInfo = data.replayInfo;
		$scope.details = data.details;
		
	});
	$scope.wemailLogin = function() {
		if($rootScope.webmail == 1)
		{
			$location.path('dashboard/inbox');
		}else
		{
			$location.path('dashboard/webmaillogin');
		}
		
	}
	$scope.wemailLogout = function() {
		$rootScope.webmail = '';
		$location.path('dashboard/webmaillogin');
	};
	 $scope.toTimestamp = function(date) {
	    return Date.parse(date);
	 };
	 $scope.MessageDetails = function(id,msgno,folder) {
		$location.path('dashboard/single/'+id+'/'+msgno+'/'+folder);
	 };
});
composeService.controller('TrashCtrl', function ($scope,$rootScope,$location, TransactionTypes,logger,$http, $route,$routeParams,Session, $modal,$log,Transactions) {
	$scope.messages = {};
	$http.get('api/trash').success(function(data){
		$scope.fromInfo = data.fromInfo;
		$scope.replayInfo = data.replayInfo;
		$scope.details = data.details;
		
	});
	$scope.wemailLogin = function() {
		if($rootScope.webmail == 1)
		{
			$location.path('dashboard/inbox');
		}else
		{
			$location.path('dashboard/webmaillogin');
		}
		
	}
	$scope.wemailLogout = function() {
		$rootScope.webmail = '';
		$location.path('dashboard/webmaillogin');
	};
	 $scope.toTimestamp = function(date) {
	    return Date.parse(date);
	 };
	 $scope.MessageDetails = function(id,msgno,folder) {
		$location.path('dashboard/single/'+id+'/'+msgno+'/'+folder);
	 };
});
composeService.controller('loginCtrl', function ($scope,$rootScope,$location, TransactionTypes,logger,$http, $route,$routeParams,Session, $modal,$log,Transactions) {
	$scope.loginData = {};
	$scope.loading = 0;
	$scope.loginSubmit = function() {
		$scope.loginData.username;
		$scope.loginData.password;
		$scope.loading = 1;
		$http.post('api/webmail_login', $scope.loginData).success(function(response){
			$scope.loading = 0;
			if(response == 1)
			{
				$rootScope.webmail = 1;
				$location.path('dashboard/inbox');
			}else
			{
				logger.logError('Invalid Credentails');
				$location.path('dashboard/webmaillogin');
			}
		});
	}
});
