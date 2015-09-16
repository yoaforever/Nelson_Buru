var post = angular.module('PostCtrl',['CRUDSrvc']);

post.controller('PostController',function($scope, $state, CRUD){

	var getPosts = CRUD.all();

	getPosts.success(function(response){
		$scope.posts = response;
	});

	$scope.submit = function(){
            var request = CRUD.create($scope.new);
                request.success(function(response){
                    $scope.flash = response.status;
                    // $state.go($state.$current, null, { reload: true });
                    $state.reload();
                });
        }
});

post.controller('EditPostController',function($scope,$state,$stateParams,CRUD){

        var getPost = CRUD.get($stateParams.id);
        getPost.success(function(response){
            $scope.post = response;
        });
 
        $scope.submit = function(){
            var request = CRUD.update($stateParams.id,$scope.post);
            request.success(function(response){
                $scope.flash = response.status;
                $state.reload();
            });
        }
 
});