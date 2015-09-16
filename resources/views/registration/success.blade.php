@extends('layouts.default')

@section('content')
<div class="container-fluid">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="panel panel-default">
				<div class="panel-heading">
				</div>
				<div class="panel-body">
					<img src="/assets/images/info.png" />

					<h5>Your Password was successfully changed</h5>
					<br>

					<p>Now you'll be redirected to the Login Page in <span id="timer">5 second(s)</span>....</p>
				</div>
			</div>
		</div>
	</div>
</div>

@append

@section('js')
	
    <script>
        var counter = 5;
        (function () {
            // your page initialization code here
            // the DOM will be available here
            setTimeout(function () {
                window.location = window.location.origin;
            }, 5000);

            //setTimeout
            setInterval(function () {
                counter = counter - 1;
                $('span#timer').html(counter + " second(s)");
            }, 1000);
        })();
    </script>
@append