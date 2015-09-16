<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>PayAnyBiz</title>

	<!-- Fonts -->
	<link href='//fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/bower_components/bootstrap/dist/css/bootstrap.css">
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
<body>

	<div style="padding: 20px 0px; text-align: center;"><img src="/assets/images/pabLogo.PNG" alt="PayAnyBizLogo"></div>	

	@yield('content')

	<!-- Scripts -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.1/js/bootstrap.min.js"></script>

    <div id="loader" style="display: none; position: absolute; width: 100%; height: 100%; top: 0; left: 0; bottom: 0; right: 0; background-color: rgba(0, 0, 0, 0.6); z-index: 10000;">
	    <img src="/assets/images/loader.gif" alt="Loading..." style="position: absolute; top: 50%; left:50%; margin-top: -20px; margint-left:-2px; width: 40px;">
    </div>

    <script>
    	$(function(){
    		$('[data-loader=true]').click(function(){
    			loader().show();
    		});
    	});

        function loader() {
            return $('#loader');
        }
    </script> 

	@yield('js')
</body>
</html>
