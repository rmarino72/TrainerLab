﻿
<!DOCTYPE html>
<html lang="it-it">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>FF Studio</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Choices.js-->
    <link rel="stylesheet" href="/assets/vendor/choices.js/public/assets/styles/choices.min.css">
    <!-- Google fonts - Muli-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="/assets/css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="/assets/css/custom.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <!-- https://fonts.google.com/icons -->

    <link href="/assets/alertify/css/alertify.css" rel="stylesheet" type="text/css" />
    <link href="/assets/alertify/css/themes/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="/assets/bootstrap-table/bootstrap-table.min.css" rel="stylesheet" type="text/css" />

    <!-- Favicon-->
    <link rel="shortcut icon" href="/assets/img/f&f.ico">
    <!-- Tweaks for older IEs-->
    <!--[if lt IE 9]>

    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->


    <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/vendor/just-validate/js/just-validate.js"></script>
    <script src="/assets/vendor/chart.js/Chart.min.js"></script>
    <script src="/assets/vendor/choices.js/public/assets/scripts/choices.min.js"></script>
    <script src="/assets/js/charts-home.js"></script>
    <script src="/assets/js/jquery-3.6.1.min.js" type="text/javascript"></script>
    <script src="/assets/alertify/alertify.js" type="text/javascript"></script>
    <script src="/assets/bootstrap-table/bootstrap-table.min.js" type="text/javascript"></script>
    <script src="/assets/bootstrap-table/extensions/mobile/bootstrap-table-mobile.js" type="text/javascript"></script>
    <script src="/assets/bootstrap-table/locale/bootstrap-table-it-IT.js" type="text/javascript"></script>
    <script src="/assets/fullcalendar/index.global.js" type="text/javascript"></script>
    <!-- https://fullcalendar.io/docs -->
    <script src="/assets/js/libs.js" type="text/javascript"></script>
    <script src="/assets/js/config.js" type="text/javascript"></script>
    <script src="/assets/js/TLLibs.js" type="text/javascript"></script>

</head>
<body>

    <div class="container">

        <br />
        <br />
        <br />
        <br />
        <div class="card mb-0">
            <div class="card-header">
                <h1><span class="material-symbols-outlined">error</span>&nbsp; Si è verificato un errore</h1>
            </div>
            <br />
            <br />
            <div class="card-body pt-0">
                <div class="text-center">
                    <h3 id="message">Messaggio di errore</h3>
                    <br />
                    <br />
                    <button class="btn btn-primary" type="button" onclick="goLogin();"><span class="material-symbols-outlined">done</span>&nbsp; Torna al Login</button>
                    
                </div>
            </div>
        </div>
    </div>

    <script>


        function goLogin() {
            window.location = "Login";
        }

        var msg = getFromStorage(STORAGE_ERROR);
        if (msg)
        {
            $('#message').text(msg);
            
        }
        clearStorage();
        

    </script>

</body>
</html>