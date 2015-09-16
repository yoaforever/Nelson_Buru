var composeService = angular.module('compose', ['ngRoute', 'ngResource']);
	composeService.controller('ComposeCtrl', function ($scope, TransactionTypes,logger,$http, $route,$routeParams,Session, $modal,$log,Transactions) {
		$scope.mail = {};
		$scope.$watchCollection('data.tags',function(val){
			$scope.mail.receiver = val;
		});
		$scope.SendMail = function(){
			$scope.mail.mailContent;
			$scope.mail.current_user_id = Session.id();
			$scope.mail.current_customer_id = Session.customer_id();
			$http.post('api/sendmail',$scope.mail).success(function(data){
				
			});
		};
	}).
	directive('autoComplete',['$http','$timeout','Session', function($http,$timeout,Session){
    return {
        restrict:'AE',
        scope:{
            selectedTags: '=model'
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