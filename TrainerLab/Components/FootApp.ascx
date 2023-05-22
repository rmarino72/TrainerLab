<%@ Control Language="C#" CodeBehind="FootApp.ascx.cs" Inherits="TrainerLab.Components.FootApp" %>



</div>
</div>
<!--footer class="position-absolute bottom-0 bg-dash-dark-2 text-white text-center py-3 w-100 text-xs" id="footer"-->
<footer class="fixed-bottom bottom-0 bg-dash-dark-2 text-white text-center py-3 w-100 text-xs" id="footer">
    <div class="container-fluid text-center">
        <p class="mb-0 text-dash-gray">FF Studio - Via Roma 94 - 84070 Trentinara (SA)</p>
        <p class="mb-0 text-dash-gray">Trainer Lab - 2022 &copy; RM.</p>
    </div>
</footer>

<!-- JavaScript files-->
<!-- Main File-->
<script src="/assets/js/front.js"></script>
<script>// ------------------------------------------------------- //
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

        function showSpinner()
        {
            $('#spinner-div').attr("style", "display: flex;");
        }

        function hideSpinner() {
            $('#spinner-div').attr("style", "display: none;");
        }

        // this is set to BootstrapTemple website as you cannot
        // inject local SVG sprite (using only 'icons/orion-svg-sprite.svg' path)
        // while using file:// protocol
        // pls don't forget to change to your domain :)
        injectSvgSprite('https://bootstraptemple.com/files/icons/orion-svg-sprite.svg');
        $(document).on({
            ajaxStart: showSpinner,
            ajaxStop: hideSpinner
        });
        refreshUserName();</script>
<!-- FontAwesome CSS - loading as last, so it doesn't block rendering-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
</body>
</html>