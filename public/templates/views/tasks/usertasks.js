var tasksService = angular.module('usertasks', ['ngRoute', 'ngResource']);

tasksService.controller('taskCtrl', function ($scope,$rootScope,logger,$route,$routeParams,Session,Session,tasksService) {
	var vm = this;
		var keyCodes = {
        backspace: 8,
        tab: 9,
        enter: 13,
        esc: 27,
        space: 32,
        pageup: 33,
        pagedown: 34,
        end: 35,
        home: 36,
        left: 37,
        up: 38,
        right: 39,
        down: 40,
        insert: 45,
        del: 46,
        rClick: 0
    };
    
    vm.title = 'Tasks';
    vm.cancel = cancel;
    vm.tasks = [];
    vm.newTask = "";
    vm.remainingCount = 0;
    vm.editedTask = null;
    vm.statusFilter = { completed: !1 };
    vm.filter = filter;
    vm.add = add;
    vm.edit = edit;
    vm.doneEditing = doneEditing;
    vm.remove = remove;
    vm.completed = completed;
    vm.clearCompleted = clearCompleted;
    vm.markAll = markAll;
    
    function cancel() {
        vm.title = 'HERE ---> Template PayAnyBiz Activated Loaded :) --> ';
    }
    //Load Function usually used to load data
    var request = tasksService.all();
	request.success(function(response) {
		vm.tasks = response;
		vm.tasks.forEach(function (task) {
			if(task.completed == 0) {
				task.completed = !1;
			}else if(task.completed == 1) {
				task.completed = !0;
			}
			task.active = true;
		});	
		var activeTasks = tasksService.activeTasks();
		activeTasks.success(function(response){
			vm.remainingCount = response.length;
		});
	});
	
	function filter(filter)
	{
		switch (filter) {
			case "all":
				return vm.statusFilter = { active: !0 };
			case "active":
				return vm.statusFilter = { completed: !1};
			case "completed":
				return vm.statusFilter = { completed: !0 };
		}
	}

	function add()
	{
		var newTask = vm.newTask.trim();
		if (0 !== newTask.length)
		{
			var initValues = { title: newTask, completed: !1, userId: Session.id(), active:true }
			var request = tasksService.create(initValues);
			request.success(function(response) {
				vm.tasks = response;
				vm.tasks.forEach(function (task) {
					if(task.completed == 0) {
						task.completed = !1;
					}else if(task.completed == 1) {
						task.completed = !0;
					}
					task.active = true;
				});	
				vm.newTask = "";
				vm.remainingCount++;
				logger.log("Task list Updated."); 
			});
		}
	}

	function edit(task)
	{
		vm.editedTask = task;
	}

	function doneEditing(task)
	{
		vm.editedTask = null;
		task.title = task.title.trim();
		if (task.title) {                
			var request = tasksService.update(task.id,task);
			request.success(function(){
				//logger.log('Updated Successfully..');
			});
		}
		else {
			var request = tasksService.delete(task.id);
		  
		   
		}
		
	}

	function remove(task) {
		var index;
		vm.remainingCount -= task.completed ? 0 : 1;        
		var request = tasksService.delete(task.id);
		request.success(function(response){
			vm.tasks = response;
			vm.tasks.forEach(function (task) {
				if(task.completed == 0) {
					task.completed = !1;
				}else if(task.completed == 1) {
					task.completed = !0;
				}
				task.active = true;
			});	
		});
	}

	function completed(task) {
	
		vm.remainingCount += task.completed ? -1 : 1;
		var request = tasksService.update(task.id,task);
		task.completed ? vm.remainingCount > 0 ?
					   logger.log(1 === vm.remainingCount ? "Almost there! Only " + vm.remainingCount + " task left" : "Good job! Only " + vm.remainingCount + " tasks left") :
					   logger.logSuccess("Congrats! All done :)") : void 0;
	}

	function clearCompleted()
	{
		vm.tasks = vm.tasks.filter(function (val) {
			tasksService.delete(val.id);
			return !val.completed;
		});
	}

	function markAll(completed)
	{
		tasksService.markAll();
		var request = tasksService.all();
		request.success(function(response) {
			vm.tasks = response;		
			vm.tasks.forEach(function (task) {
				return task.completed = completed
			});
			vm.remainingCount = completed ? 0 : vm.tasks.length;
			completed ? logger.logSuccess("Congrats! All done :)") : void 0
		});
	}

	function save()
	{
		tasksService.saveChanges(            
		  function () {
			  logger.log("Task list Updated.");                
		  },
		  function (error) {
			  var msg = 'Error saving Task: ' + error.message;
			  logger.logError(msg, error);
		  });
	}

	$scope.$watch("vm.remainingCount == 0", function (val) {
		console.log(val);
		return vm.allChecked = val;
	});
	$scope.$watch("vm.remainingCount", function (newVal) {
		return $rootScope.$broadcast("vm.taskRemaining:changed", newVal)
	});

});

tasksService.factory("tasksService", function ($http) {

    return{
        all: function () {
            var request = $http.get('api/tasks');
            return request;
        },
		create: function (data) {
            var request = $http.post('api/tasks/create',data);
            return request;
        },
		update: function (id, data) {
            var request = $http.post('api/tasks/update/'+id,data);
            return request;
        },
        get: function (id) {
            var request = $http.get('api/tasks/' + id);
            return request;
        },
		markAll: function (id) {
            var request = $http.get('api/mark_all');
            return request;
        },
		activeTasks: function (id) {
            var request = $http.get('api/active_tasks');
            return request;
        },
        delete: function (id) {
            var request = $http.get('api/tasks/destroy/' + id);
			return request;
        }
    }

});
