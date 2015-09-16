var chatServices = angular.module('chatServices', ['ngRoute', 'ngResource']);

chatServices.controller('chatCtrl', function ($scope, $state, $interval,$stateParams,$http,Session,Customer,CompanyUsers,logger) {
	if($state.current.name == 'chat') {
	 $scope.current_username = Session.userName();
		var chat = {
     		data : {
     			lastID 		: 0,
     			noActivity	: 0,
	     		messagelen  : 0	
     		},
     		init : function(){
     			// Converting the #chatLineHolder div into a jScrollPane,
     			// and saving the plugin's API in chat.data:
     			chat.data.jspAPI = $('#chatLineHolder').jScrollPane({
     				verticalDragMinHeight: 12,
     				verticalDragMaxHeight: 12
     			}).data('jsp');
     			var working = false;
     		// Submitting a new chat entry:
     		},
     		
     		addChatLine : function(params){
     			// All times are displayed in the user's timezone
     			//console.log(params.time);
     			var d = new Date();
     			if(params.time) {
     				
     				// PHP returns the time in UTC (GMT). We use it to feed the date
     				// object and later output it in the user's timezone. JavaScript
     				// internally converts it for us.
     				//d.setUTCHours(params.time.hours,params.time.minutes);
     				d.setHours(params.time.hours);
     				d.setMinutes(params.time.minutes);
     				var ampm = params.time.ampm;
     			}
     			else{
     				var ampm = (d.getHours()>12 ? 'pm' : 'am');
     			}
     		
     			params.time = (d.getHours() < 10 ? '0' : '' ) + (d.getHours()>12 ? d.getHours()-12 : d.getHours())+':'+
     						  (d.getMinutes() < 10 ? '0':'') + d.getMinutes()+' '+ampm;
     			
     			var markup = chat.render('chatLine',params),
     				exists = $('#chatLineHolder .chat-'+params.id);

     			if(exists.length){
     				exists.remove();
     			}
     			
     			if(!chat.data.lastID){
     				// If this is the first chat, remove the
     				// paragraph saying there aren't any:
     				
     				$('#chatLineHolder p').remove();
     			}
     			
     			// If this isn't a temporary chat:
     			if(params.id.toString().charAt(0) != 't'){
     				var previous = $('#chatLineHolder .chat-'+(+params.id - 1));
     				if(previous.length){
     					previous.after(markup);
     				}
     				else chat.data.jspAPI.getContentPane().append(markup);
     			}
     			else chat.data.jspAPI.getContentPane().append(markup);
     			
     			// As we added new content, we need to
     			// reinitialise the jScrollPane plugin:
     			
     			chat.data.jspAPI.reinitialise();
     			chat.data.jspAPI.scrollToBottom(true);
     			
     		},
     		render : function(template,params){
     			
     			var arr = [];
     			switch(template){
     				case 'loginTopBar':
     					arr = [
     					'<span><img src="',params.gravatar,'" width="23" height="23" />',
     					'<span class="name">',params.name,
     					'</span><a href="" class="logoutButton rounded">Logout</a></span>'];
     				break;
     				
     				case 'chatLine':
     					arr = [
     						'<div class="chat chat-',params.id,' rounded"><span class="gravatar"><img src="',params.gravatar,
     						'" width="23" height="23" onload="this.style.visibility=\'visible\'" />','</span><span class="author">',params.author,
     						':</span><span class="text">',params.message,'</span><span class="time">',params.time,'</span></div>'];
     				break;
     				
     				case 'user':
     					arr = [
     						'<div class="user" title="',params.name,'"><img src="',
     						params.gravatar,'" width="30" height="30" onload="this.style.visibility=\'visible\'" /></div>'
     					];
     				break;
     			}
     			
     			// A single array join is faster than
     			// multiple concatenations
     			
     			return arr.join('');
     			
     		},
     		
     		getChats : function (senderid, receiverid, callback) {
     			var nextRequest = 1000;
     			if($scope.receiverid == receiverid){
     			var response = $http.post('api/chataction/getchats',{'senderid':senderid,'receiverid':receiverid});
    			//console.log(response);
    			response.success(function(response){
    				
    				if(chat.data.messagelen < response.chats.length)
    				{
    					for(var i=0;i<response.chats.length;i++){
		    				chat.addChatLine(response.chats[i]);
		    			}
    					chat.data.messagelen = response.chats.length;
    				}else{
    					var i=response.chats.length; //to define lastID in next if statement
    				}
    				
    				if(response.chats.length){
    					chat.data.noActivity = 0;
    					chat.data.lastID = response.chats[i-1].id;
    				}
    				else{
    					chat.data.noActivity++;
    				}
    				//console.log("chatid:"+chat.data.lastID);
    				if(!chat.data.lastID){
    					//chat.data.jspAPI.getContentPane().html('<p class="noChats">No chats yet</p>');
    					$(".jspPane").css('top','0');
    					$(".jspPane").html('<p class="noChats">No chats yet</p>'); 
    				}
    				
    				// Setting a timeout for the next request,
    				// depending on the chat activity:
    				
    				// 2 seconds
    				if(chat.data.noActivity > 3){
    					nextRequest = 2000;
    				}
    				
    				if(chat.data.noActivity > 10){
    					nextRequest = 5000;
    				}
    				
    				// 15 seconds
    				if(chat.data.noActivity > 20){
    					nextRequest = 15000;
    				}
    				
    					
    			  });
    			setTimeout(callback,nextRequest);
     			}
    			},//getChats
    		getUsersFromCompany : function(companyname,customer_id){
        		 var getCompanyUsers = CompanyUsers.getOtherCompanyUsers(companyname,customer_id);
                 getCompanyUsers.success(function(resultusers){
                 	    $scope.othercompanyusers = resultusers.companyusers;
                 	
                 });
     		}
     }
	
	 $(document).ready(function(){
			// Run the init method on document ready:
			chat.init();
			
		});
	var vm = this;
	$scope.img_online = 1;
	 	$scope.userid = Session.id();
 		$scope.username=Session.userName();
 		var getCustomer = Customer.get(Session.customer_id());
        getCustomer.success(function(response){
            $scope.customer = response;
            $scope.currcomp = response.legal_name;
            var getCompanyUsers = CompanyUsers.getUsers(response.id, response);
            getCompanyUsers.success(function(resultusers){
            	//if(resultusers.companyusers.length!=0)
	                $scope.otherusers = resultusers.companyusers;
					console.log($scope.otherusers);
            	
            });
            var getOtherCompanies = CompanyUsers.getOtherCompanies(response.id);
            getOtherCompanies.success(function(resultcompanies){
            	//if(resultusers.companyusers.length!=0)
	                $scope.othercompanies = resultcompanies;
            	
            });
			var getChtStat = CompanyUsers.getchatstatus($scope.userid);
			getChtStat.success(function(result){
				$scope.img_online = result;
			});
        });
        
		
		
        $scope.userClick = function(obj){
			$(".jspPane").html('<p class="noChats"></p>');
        	chat.data.lastID = 0;
        	chat.data.messagelen = 0;
        	var receiverid = obj.target.attributes.cid.value;
        	$scope.receiverid = receiverid;
        	$scope.chatuser = obj.target.attributes.cname.value;
        	$scope.chatuserid = obj.target.attributes.cid.value;
        	//console.log('asdfsf');
        	$("#chatBottomBar").show();
        	
        	(function getChatsTimeoutFunction(){
    			chat.getChats($("#userid").val(),receiverid,getChatsTimeoutFunction);
    		})();
        }
		
		$scope.online = function(stat){
			$scope.cht= {};
        	$scope.cht.userid = Session.id();
			$scope.cht.compid = Session.customer_id();
			$scope.cht.status = stat;
			var request = CompanyUsers.setvisibility($scope.cht);
			request.success(function(){
				if(stat==1){
					logger.log('<b>Status Updated To Online</b>');
				}
				else{
					logger.log('<b>Status Updated To Away</b>');
				}
				$state.reload();
			});
			var getChtStat = CompanyUsers.getchatstatus($scope.userid);
			getChtStat.success(function(result){
				$scope.img_online = result;
			});
			
        }        
        
        $scope.companyClick = function(obj){
        	
        	$scope.chatwithcompany = obj.target.attributes.othercompanyname.value;
        	var companynm = $scope.chatwithcompany; 
        	
        	chat.getUsersFromCompany(companynm,Session.customer_id());
        	
        	$("#othercompanies").hide();
        	$("#othercompanyusers").show();
        	
        }
        
        $('#backtocompanies').on('click',function(){
        	$("#othercompanies").show();
        	$("#othercompanyusers").hide();	
        });
        
        $('#chatText').keydown(function(event) {
            if (event.keyCode == 13) {
                $("#chatsubmitfrm").submit();
                return false;
             }
        });
        
        //$scope.chatSubmit
        $scope.submit = function(event){
			event.preventDefault();
        	var text = $('#chatText').val();
        	var receiverid = $("#currentreceiverid").val();
        	if(text.length == 0){
				return false;
			}
			
			if(chat.working) return false;
			chat.working = true;
			
			// Assigning a temporary ID to the chat:
			var tempID = 't'+Math.round(Math.random()*1000000),
				params = {
					id			: tempID,
					author		: chat.data.name,
					gravatar	: chat.data.gravatar,
					message		: text.replace(/</g,'&lt;').replace(/>/g,'&gt;')
				};

			// Using our addChatLine method to add the chat
			// to the screen immediately, without waiting for
			// the AJAX request to complete:
			
			chat.addChatLine($.extend({},params));
			
			// Using our tzPOST wrapper method to send the chat
			// via a POST AJAX request:
			
			var response = $http.post('api/chataction/submitchat',{'senderid':Session.id(),'receiverid':receiverid,'message':text});
			response.success(function(result){
				chat.working = false;
				$('#chatText').val('');
				$('div.chat-'+tempID).remove();
				
				params['id'] = result.insertID;
				chat.addChatLine($.extend({},params));
			});
			
			return false;
        }    
        
        
//$scope.company_profile.username=Session.userName();
    /*$scope.submit = function () {
        $stateParams.id=0;
        $stateParams.id = $scope.company_profile.id;
        $scope.company_profile.username=$scope.username;
        var request = CompanyProfile.update($stateParams.id, $scope.company_profile);
        request.success(function (response) {
            $scope.flash = response.status;
            // alert($scope.flash);
            $state.reload();
        });
    }*/
	
	}
	$interval(function(){ 
		var request = $http.post('api/chataction/getReceivedMsgs',{'receiverid':Session.id()});
		request.success(function(response) {
			$scope.messages = response.chats;
		});
	 },3000);
});

chatServices.factory("CompanyUsers", function ($http) {
    return{
        getUsers: function (id, data) {
        	var request = $http.put('api/company_users/' + id, data);
            return request;
        },
     	getChats : function (senderid, receiverid, chat) {
     		var response = $http.post('api/chataction/getchats',{'senderid':senderid,'receiverid':receiverid});
			response.success(function(response){
				for(var i=0;i<response.chats.length;i++){
					chat.addChatLine(response.chats[i]);
				}
				
				if(response.chats.length){
					chat.data.noActivity = 0;
					chat.data.lastID = response.chats[i-1].id;
				}
				else{
					chat.data.noActivity++;
				}
				if(!chat.data.lastID){
					//chat.data.jspAPI.getContentPane().html('<p class="noChats">No chats yet</p>');
					$(".jspPane").css('top','0');
					$(".jspPane").html('<p class="noChats">No chats yet</p>'); 
				}
				
				// Setting a timeout for the next request,
				// depending on the chat activity:
				
				var nextRequest = 1000;
				
				// 2 seconds
				if(chat.data.noActivity > 3){
					nextRequest = 2000;
				}
				
				if(chat.data.noActivity > 10){
					nextRequest = 5000;
				}
				
				// 15 seconds
				if(chat.data.noActivity > 20){
					nextRequest = 15000;
				}
				//setTimeout(callback,nextRequest);
			  });
			},//getChats
			getOtherCompanies: function (id) {
	        	var request = $http.put('api/chatcompanies/'+id);
	            return request;
	        },
	        getOtherCompanyUsers: function (companyname,customer_id) {
	        	var request = $http.put('api/chatcompanyusers/',{'company':companyname,'customer_id':customer_id});
	            return request;
	        },
			setvisibility: function(data){
				var request = $http.post('api/set_visibility',data);
				return request;
			},
			getchatstatus: function(id){
				var request = $http.get('api/chatstatus/'+id);
				return request;
			}
    }
	
});
chatServices.controller('receivedMsgsCtrl', function ($scope,Session, $state, $stateParams,$http,Session,$interval,Customer,CompanyUsers,logger) {
	$interval(function(){ 
		var request = $http.post('api/chataction/getReceivedMsgs',{'receiverid':Session.id()});
		request.success(function(response) {
			$scope.messages = response.chats;
		});
	 },3000);
	 
	 $scope.updateStatus = function(id) { 
		var request = $http.post('api/chat_messages/'+id,{'status':1});
		request.success(function(response) {
			if(response.success == true) { 
				$state.go('chat');
			}
		});
	 };
	 
}).filter('timeago', function() {
        return function(input, p_allowFuture) {
            var substitute = function (stringOrFunction, number, strings) {
                    var string = $.isFunction(stringOrFunction) ? stringOrFunction(number, dateDifference) : stringOrFunction;
                    var value = (strings.numbers && strings.numbers[number]) || number;
                    return string.replace(/%d/i, value);
                },
                nowTime = (new Date()).getTime(),
                date = (new Date(input)).getTime(),
                //refreshMillis= 6e4, //A minute
                allowFuture = p_allowFuture || false,
                strings= {
                    prefixAgo: null,
                    prefixFromNow: null,
                    suffixAgo: "ago",
                    suffixFromNow: "from now",
                    seconds: "less than a minute",
                    minute: "about a minute",
                    minutes: "%d minutes",
                    hour: "about an hour",
                    hours: "about %d hours",
                    day: "a day",
                    days: "%d days",
                    month: "about a month",
                    months: "%d months",
                    year: "about a year",
                    years: "%d years"
                },
                dateDifference = nowTime - date,
                words,
                seconds = Math.abs(dateDifference) / 1000,
                minutes = seconds / 60,
                hours = minutes / 60,
                days = hours / 24,
                years = days / 365,
                separator = strings.wordSeparator === undefined ?  " " : strings.wordSeparator,
            
                // var strings = this.settings.strings;
                prefix = strings.prefixAgo,
                suffix = strings.suffixAgo;
                
            if (allowFuture) {
                if (dateDifference < 0) {
                    prefix = strings.prefixFromNow;
                    suffix = strings.suffixFromNow;
                }
            }

            words = seconds < 45 && substitute(strings.seconds, Math.round(seconds), strings) ||
            seconds < 90 && substitute(strings.minute, 1, strings) ||
            minutes < 45 && substitute(strings.minutes, Math.round(minutes), strings) ||
            minutes < 90 && substitute(strings.hour, 1, strings) ||
            hours < 24 && substitute(strings.hours, Math.round(hours), strings) ||
            hours < 42 && substitute(strings.day, 1, strings) ||
            days < 30 && substitute(strings.days, Math.round(days), strings) ||
            days < 45 && substitute(strings.month, 1, strings) ||
            days < 365 && substitute(strings.months, Math.round(days / 30), strings) ||
            years < 1.5 && substitute(strings.year, 1, strings) ||
            substitute(strings.years, Math.round(years), strings);

            return $.trim([prefix, words, suffix].join(separator));
            // conditional based on optional argument
            // if (somethingElse) {
            //     out = out.toUpperCase();
            // }
            // return out;
        }
    });;