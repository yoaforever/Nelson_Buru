<!doctype html>
<html lang="en">
  <head>
    <title>PayAnyBiz</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--css-->
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="bower_components/weather-icons/css/weather-icons.min.css">
	<link rel="stylesheet" href="./scripts/jScrollPane/jScrollPane.css">
    <!--js-->
    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>-->
    <!-- This is the css of library to dialog and message -->
     <link rel="stylesheet" href="bower_components/angularjs-toaster/toaster.min.css">
     <link rel="stylesheet" href="bower_components/angular-ngdialog/css/ngDialog.css">
	<link rel="stylesheet" href="bower_components/angular-ngdialog/css/ngDialog-theme-default.css">
	<link rel="stylesheet" href="bower_components/angular-ngdialog/css/ngDialog-theme-plain.css">
    <script src="bower_components/bootstrap/dist/js/bootstrap.js"></script>
  </head>
  <body ng-app="myApp" ng-controller="ApplicationController">
    
	<div id="wrapper" ui-view></div>

    <!--angular-->
    <script src="bower_components/angular/angular.js"></script>
	<script src="bower_components/qrcode/qrcode.js"></script>
	<script src="bower_components/qrcode/qrcode_UTF8.js"></script>
     <script src="bower_components/angular-ui-route/angular-ui-router.js"></script>      
    <script src="bower_components/angular-resource/angular-resource.js"></script> <!-- load our service -->
    <script src="bower_components/angular-route/angular-route.js"></script>
<!--    <script src="bower_components/ui.bootstrap/src/datepicker/datepicker.js"></script>
    <script src="bower_components/ui.bootstrap/src/dateparser/dateparser.js"></script>
    <script src="bower_components/ui.bootstrap/src/position/position.js"></script>
    <script src="bower_components/ui.bootstrap/src/tabs/tabs.js"></script>-->
    <script src="bower_components/angular-sanitize/angular-sanitize.js"></script>
    <script src="bower_components/angular-animate/angular-animate.js"></script>
       <script src="bower_components/angularjs-toaster/toaster.js"></script>
    <script src="bower_components/angular-ngStorage/ngStorage.js"></script>
     <script src="bower_components/angular-ngdialog/js/ngDialog.js"></script>
<!--     <script src="bower_components/bower-angular-cookies/angular-cookies.min.js"></script>-->
     <script src="bower_components/bower-angular-cookies/angular-cookies.js"></script>
<!--     <script src="bower_components/bower-angular-cookies/angular-cookies.min.js.map"></script>-->

    <!--main script-->    
    <script src="js/app.js"></script>    
<!--    <script src="scripts/app.js"></script>-->

    <!--angular controllers-->
    <script src="js/services/authService.js"></script>    
    <script src="js/controllers/loginController.js"></script>
<!--    <script src="js/controllers/postController.js"></script>-->
    
    <!--<script src="scripts/mainCtrl.js"></script>-->
    <script src="scripts/myApp.localization.js"></script>
    <script src="scripts/mainControllers.js"></script>  
    <!--falta por subir a los buruburu-->
<!--    <script src='scripts/roundProgress.js'></script>-->

    <!--geographical-->
    <script src="./scripts/geographical/countrys.js"></script>
    <script src="./scripts/geographical/states.js"></script>
    <script src="./scripts/geographical/citys.js"></script>

    <script src="./scripts/depend/transatypes.js"></script>
    <script src="./scripts/depend/bizareas.js"></script>
    <script src="./scripts/depend/permissions.js"></script>
    <script src="./scripts/depend/roles.js"></script>
    <script src="./scripts/depend/disputecategory.js"></script>
    <script src="./scripts/depend/disputereason.js"></script>

    <!--Externals Controllers-->
    <script src="./scripts/controllers/formConstraintsCtrl.js"></script>
    <script src="./scripts/controllers/invoiceCtrl.js"></script>
    <script src="./scripts/controllers/signinCtrl.js"></script>
    <script src="./scripts/controllers/signupCtrl.js"></script>
    <script src="./scripts/controllers/wizardFormCtrl.js"></script>    
    
    
    <!--Views-->
   <!-- <script src="./templates/views/test.js"></script>-->
 <!--  <script src="./templates/views/admin/admin.js"></script>-->
<!--    <script src="./templates/views/attachment/attachment.js"></script>-->
    <script src="./templates/views/attachment/myattachment.js"></script>
<!-- buru buru   <script src="./templates/views/tasks/usertasks.js"></script>-->
   
	<script src="./templates/views/biller/biller.js"></script>
    <script src="./templates/views/biller/billerList.js"></script>
    <script src="./templates/views/biller/billerTmplt.js"></script>
    <script src="./templates/views/biller/mybiller.js"></script>
    <script src="./templates/views/chatMessage/chat.js"></script>
     <script src="./templates/views/customer_services/mycustomers.js"></script>
    <script src="./templates/views/createInvoice/createInvoice.js"></script>
    <script src="./templates/views/latestInvoices/latestInvoices.js"></script>
   <!-- <script src="./templates/views/layout/appCtrl.js"></script>-->
    <script src="./templates/views/pages/lock-screen.js"></script>
    <script src="./templates/views/pages/profile.js"></script>
      <script src="./templates/views/pages/credit_memo.js"></script>
    <script src="./templates/views/pages/mycompanyprofile.js"></script>
    <script src="./templates/views/payanybiztemplate/payanybiztemplate.js"></script>
    <script src="./templates/views/payanybiztemplate/payanybiztemplate.js"></script>
    <script src="./templates/views/payor/payor.js"></script>
    <script src="./templates/views/payor/mypayor.js"></script>
    <script src="./templates/views/payor/payorList.js"></script>
    <script src="./templates/views/payor/payorTmplt.js"></script>
    <script src="./templates/views/tasks/mytasks.js"></script>
	<script src="./templates/views/mail/compose.js"></script>
    <script src="./templates/views/transaction/batchdispute.js"></script>
    <script src="./templates/views/transaction/mydispute.js"></script>
   <!-- <script src="./templates/views/transaction/transaction.js"></script>-->
    <script src="./templates/views/transaction/mytransaction.js"></script>
    <script src="./templates/views/transaction/transactionListCtrl.js"></script>
    <script src="./templates/views/transaction/transactionTmplt.js"></script>
    <script src="./templates/views/user/myApp.directives.js"></script>
    <script src="./templates/views/user/newUser.js"></script>
    <script src="./templates/views/user/user.js"></script>
    <script src="./templates/views/user/myuser.js"></script>
    <script src="./templates/views/user/userSettings.js"></script>
    <script src="./templates/views/user/userTmplt.js"></script>
    <script src="./templates/views/dashboardCtrl.js"></script>
    <script src="./templates/views/payment/mypayment.js"></script>
    <script src="./templates/views/report/myreport.js"></script>
	<!-- For ftp Setting -->
	<script src="./templates/views/pages/ftp.js"></script>
	<!-- For Branches -->
	<script src="./templates/views/branch/branches.js"></script>
	<!-- for File upload -->
	<script src="bower_components/upload/ng-file-upload.js"></script>
    <!--Directives-->
    <script src="scripts/directives/gaugeChart.directives.js"></script>
    <script src="scripts/directives/flotChart.directives.js"></script>
    <script src="scripts/directives/flotChartRealtime.directives.js"></script>
    <script src="scripts/directives/sparkline.directives.js"></script>
    <script src="scripts/directives/morrisChart.directives.js"></script>
    <script src="scripts/directives/form.directives.js"></script>
    <script src="scripts/directives/validateEquals.directives.js"></script>
    <script src="scripts/directives/ui.directives.js"></script>
    <script src="scripts/directives/nav.directives.js"></script>
    <script src="scripts/directives/myApp.directives.js"></script>  

    <!--extras-->
    <script src="scripts/extra/spin.js"></script>
    <script src=" scripts/extra/q.js"></script>
    <!--<script src="scripts/extra/vendor.js"></script>-->
    <script src="scripts/extra/ui.js"></script>
    <script src="scripts/extra/demo.js"></script>
    <script src="scripts/extra/popup.js"></script>
  

    <script src="scripts/pagination.js"></script>

    <!--Common-->
    <script src="scripts/common/signalRSvc.js"></script>
    <script src="scripts/common/common.js"></script>
    <script src="scripts/common/logger.js"></script>
    <script src="scripts/common/bootstrap/bootstrap.dialog.js"></script>
    <script src="scripts/common/myResource.js"></script>
    <script src="scripts/common/notification.js"></script>
    <script src="scripts/common/validator.js"></script>
	
    <!-- scrollpane buru buru sin subir -->
	<script src="./scripts/jScrollPane/jquery.mousewheel.js"></script>
    <script src="./scripts/jScrollPane/jScrollPane.min.js"></script>
    <div id="loader" style="display: none; position: fixed;background-color:#fff;overflow: hidden; width: 100%; height: 100%; top: 0; left: 0; bottom: 0; right: 0; background-color: rgba(0, 0, 0, 0.6); z-index: 10000;">
	<img ng-init="src='/assets/images/bigspinner.gif'" ng-src="{{src}}" alt="Loading Your Dashboard Settings" style="overflow:hidden;position: absolute; top: 50%; left:50%; margin-top: -20px; margint-left:-2px; width: 40px;">
	<!--<img src="assets/images/bigspinner.gif" alt="Loading Your Dashboard Settings" style="position: fixed;top: 29%;left: 32%;width: 31%;">-->
    </div>
	<script>
        function loader() {
            return $('#loader');
        }
    </script>
	
  </body>
</html>