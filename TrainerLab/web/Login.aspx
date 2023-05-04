﻿
<!DOCTYPE html>
<html>
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

    <link href="/assets/alertify/css/alertify.css" rel="stylesheet" type="text/css" />
    <link href="/assets/alertify/css/themes/bootstrap.css" rel="stylesheet" type="text/css" />

    <!-- Favicon-->
    <link rel="shortcut icon" href="/assets/img/F&f.ico">
    <!-- Tweaks for older IEs-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
</head>
<body>
    <div class="login-page">
        <div class="container d-flex align-items-center position-relative py-5">
            <div class="card shadow-sm w-100 rounded overflow-hidden bg-none">
                <div class="card-body p-0">
                    <div class="row gx-0 align-items-stretch">
                        <!-- Logo & Information Panel-->
                        <div class="col-lg-6">
                            <div class="d-flex justify-content-center flex-column p-4 h-100">
                                <img src="/assets/img/logo.png" />
                            </div>
                        </div>
                        <!-- Form Panel    -->
                        <div class="col-lg-6 bg-white">
                            <div class="d-flex align-items-center px-4 px-lg-5 h-100 bg-dash-dark-2">
                                <form class="login-form py-5 w-100" method="get" action="javascript:login();">
                                    <h1>Login</h1>
                                    <div class="input-material-group mb-3">
                                        <input class="input-material" id="login-username" type="email" name="loginUsername" autocomplete="off" required data-validate-field="loginUsername">
                                        <label class="label-material" for="login-username">Email</label>
                                    </div>
                                    <div class="input-material-group mb-4">
                                        <input class="input-material" id="login-password" type="password" name="loginPassword" required data-validate-field="loginPassword">
                                        <label class="label-material" for="login-password">Password</label>
                                    </div>
                                    <button class="btn btn-primary mb-3" id="login" type="submit">Login</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="login-footer text-center position-absolute bottom-0 start-0 w-100">

            <p class="mb-0 text-dash-gray">Trainer Lab - 2022 &copy; RM.</p>

        </div>
    </div>
    <!-- JavaScript files-->
    <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/vendor/just-validate/js/just-validate.min.js"></script>
    <script src="/assets/vendor/chart.js/Chart.min.js"></script>
    <script src="/assets/vendor/choices.js/public/assets/scripts/choices.min.js"></script>
    <script src="/assets/js/jquery-3.6.1.min.js" type="text/javascript"></script>
    <script src="/assets/alertify/alertify.js" type="text/javascript"></script>
    <script src="/assets/js/libs.js" type="text/javascript"></script>
    <script src="/assets/js/config.js" type="text/javascript"></script>
    <script src="/assets/js/TLLibs.js" type="text/javascript"></script>
    <!-- Main File-->
    <script src="/assets/js/front.js"></script>

    <script>var user = null;
        function login() {
            var o = new Object();

            user = $('#login-username').val();
            o.Email = user;
            o.Password = $('#login-password').val();

            $.ajax({
                url: "/login",
                contentType: "application/json",
                type: "POST",
                data: JSON.stringify(o),
                success: logged,
                error: error
            });
        }

        function logged(data) {
            if (!data.Outcome) {
                if (data.Code === 1) {
                    alertify.error("User not found");
                    return;
                }
                if (data.Code === 2) {
                    alertify.error("Wrong password");
                    return;
                }
            }
            localStorage["tlab_user"] = user;
            localStorage["tlab_token"] = data.Data.Value;
            window.location = "Main";
           
        }

        function error(data) {
            if (data.status == 401) {
                alertify.alert("Error", "Session expired!", function () {
                    clearStorage();
                    window.location = "index.php";
                    return;
                });
            }

            if (data.status == 404) {
                alertify.error("Page not found!");
            }

            if (data.status == 500) {
                alertify.alert("An internal error has occurred.");
                return;
            }
            else {
                var err_code = "ERROR " + data.status + ": ";
                var resp = JSON.parse(data.responseText);
                if (resp.detail) {
                    if (resp.detail[0]) {
                        if (resp.detail[0].msg) {
                            alertify.error(err_code + resp.detail[0].msg);
                            return;
                        }
                    }
                    alertify.error(err_code + resp.detail);
                    return;
                }
                alertify.error("An error has occurred: " + err_code + data.responseText);
            }
        }


        // ------------------------------------------------------- //
        //   Inject SVG Sprite -
        //   see more here
        //   https://css-tricks.com/ajaxing-svg-sprite/
        // ------------------------------------------------------ //
        function injectSvgSprite(path) {

            var ajax = new XMLHttpRequest();
            ajax.open("GET", path, true);
            ajax.send();
            ajax.onload = function (e) {
                var div = document.createElement("div");
                div.className = 'd-none';
                div.innerHTML = ajax.responseText;
                document.body.insertBefore(div, document.body.childNodes[0]);
            }
        }
        // this is set to BootstrapTemple website as you cannot
        // inject local SVG sprite (using only 'icons/orion-svg-sprite.svg' path)
        // while using file:// protocol
        // pls don't forget to change to your domain :)
        injectSvgSprite('https://bootstraptemple.com/files/icons/orion-svg-sprite.svg');</script>
    <!-- FontAwesome CSS - loading as last, so it doesn't block rendering-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
</body>
</html>