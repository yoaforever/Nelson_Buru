var UIIdleTimeout = function () {
    return {
        //main function to initiate the module
        init: function () {
            // cache a reference to the countdown element so we don't have to query the DOM for it on each ping.
            var $countdown;
            $('body').append('<div id="idletimeout" class="toast toast-error">You session will be logged off in <span></span> seconds.Do you want to continue your session? <a id="idletimeout-resume" href="#">Click here</a>.</div>');
            // start the idle timer plugin
			$.idleTimeout('#idletimeout', '#idletimeout a', {
				idleAfter: 100,
				keepAliveURL: 'api/keepalive',
				serverResponseEquals: 'OK',
				onTimeout: function(){
					$(this).attr('style', 'display:none'); // hide the warning bar
					$.ajax({
					  method: "GET",
					  url: "api/login/destroy"
					}).done(function( msg ) {
						location.replace("/");
					});
				},
				onIdle: function(){
					$(this).attr('style', 'display:block'); // show the warning bar
				},
				onCountdown: function( counter ){
					$(this).find("span").html( counter ); // update the counter
				},
				onResume: function(){
					$(this).attr('style', 'display:none'); // hide the warning bar
				}
			});   
        }
    };
}();