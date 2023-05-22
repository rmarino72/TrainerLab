<%@ Control Language="C#" CodeBehind="HeadApp.ascx.cs" Inherits="TrainerLab.Components.HeadApp" %>

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
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0"/>
    <!-- https://fonts.google.com/icons -->

    <link href="/assets/alertify/css/alertify.css" rel="stylesheet" type="text/css"/>
    <link href="/assets/alertify/css/themes/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="/assets/bootstrap-table/bootstrap-table.min.css" rel="stylesheet" type="text/css"/>
    <link href="/assets/css/select2.css" rel="stylesheet"/>

    <!-- Favicon-->
    <link rel="shortcut icon" href="/assets/img/fef.ico">
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

    <script src="/assets/js/select2.js"></script>


    <script src="/assets/js/libs.js" type="text/javascript"></script>
    <script src="/assets/js/config.js" type="text/javascript"></script>
    <script src="/assets/js/TLLibs.js" type="text/javascript"></script>

</head>
<body>

<div id="spinner-div">
    <div class="spinner-border text-primary" id="sp-div" role="status">
    </div>
</div>

<header class="header">
    <nav class="navbar navbar-expand-lg py-3 bg-dash-dark-2 border-bottom border-dash-dark-1 z-index-10">
        <div class="container-fluid d-flex align-items-center justify-content-between py-1">
            <div class="navbar-header d-flex align-items-center">
                <a class="navbar-brand text-uppercase text-reset" href="Main">
                    <div class="brand-text brand-big">
                        <img src="/assets/img/logo.png" width="160"/>
                    </div>
                    <div class="brand-text brand-sm">
                        <img src="/assets/img/logo_mini.png" width="50"/>
                    </div>
                </a>
                <button class="sidebar-toggle">
                    <svg class="svg-icon svg-icon-sm svg-icon-heavy transform-none">
                        <use xlink:href="#arrow-left-1"> </use>
                    </svg>
                </button>
            </div>

            <ul class="list-inline mb-0">
                <li class="list-inline-item dropdown">
                    <a class="nav-link dropdown-toggle text-sm text-reset px-1 px-lg-0" id="languages" rel="nofollow" data-bs-target="#" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img class="avatar shadow-0 img-fluid rounded-circle" src="/assets/img/user.png" alt="...">
                        <span class="ms-3 title" id="userFirstLast">
                        </span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end mt-sm-3 dropdown-menu-dark" aria-labelledby="languages">
                        <li>
                            <a class="dropdown-item" rel="nofollow" href="Me">
                                <span class="material-symbols-outlined">manage_accounts</span>
                                &nbsp; Dati personali
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" rel="nofollow" href="ChangePass">
                                <span class="material-symbols-outlined">key</span>
                                &nbsp; Cambia password
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" rel="nofollow" href="Logout">
                                <span class="material-symbols-outlined">logout</span>
                                &nbsp; Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>

<div class="d-flex align-items-stretch">
<!-- Sidebar Navigation-->
<nav id="sidebar">
    <!-- Sidebar Header-->
    <ul class="list-unstyled">

        <li class="sidebar-item">
            <a class="sidebar-link" href="Main">
                <span class="material-symbols-outlined">home</span>
                &nbsp; Home
            </a>
        </li>
        <li class="sidebar-item">
            <a class="sidebar-link" href="History">
                <span class="material-symbols-outlined">
                    clinical_notes
                </span>
                &nbsp; Anamnesi Personale
            </a>
        </li>

        <li class="sidebar-item">
            <a class="sidebar-link" href="ExerciseSheet">
                <span class="material-symbols-outlined">
                    assignment
                </span>
                &nbsp; Schede Esercizi
            </a>
        </li>

        <li class="sidebar-item">
            <a class="sidebar-link" href="PersonalPlan">
                <span class="material-symbols-outlined">
                    body_system
                </span>
                &nbsp; Le Tue Schede Allenamento
            </a>
        </li>
    </ul>


    <ul class="list-unstyled" id="adminMenu">
        <li class="sidebar-item">
            <a class="sidebar-link" href="#adminList" data-bs-toggle="collapse">
                <span class="material-symbols-outlined">admin_panel_settings</span>
                &nbsp;Area admin
            </a>
            <ul class="collapse list-unstyled " id="adminList">
                <li class="sidebar-item">
                    <a class="sidebar-link" href="User">
                        <span class="material-symbols-outlined">
                            group
                        </span>
                        &nbsp; Utenti
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="SetPass">
                        <span class="material-symbols-outlined">
                            lock_reset
                        </span>
                        &nbsp; Assegna Password
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="AgendaAdmin">
                        <span class="material-symbols-outlined">
                            calendar_month
                        </span>
                        &nbsp; Gestione Agenda
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="Anthropometry">
                        <span class="material-symbols-outlined">
                            monitor_weight
                        </span>
                        &nbsp; Antropometrica
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="MuscularGroup">
                        <span class="material-symbols-outlined">
                            fitness_center
                        </span>
                        &nbsp; Gruppo muscolari
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="Exercise">
                        <span class="material-symbols-outlined">
                            body_system
                        </span>
                        &nbsp; Esercizi
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="TrainingPlanManager">
                        <span class="material-symbols-outlined">
                            clinical_notes
                        </span>
                        &nbsp; Schede Allenamento
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="Setup">
                        <span class="material-symbols-outlined">
                            settings
                        </span>
                        &nbsp; Impostazioni
                    </a>
                </li>
            </ul>
        </li>
    </ul>
</nav>

<div class="page-content form-page">