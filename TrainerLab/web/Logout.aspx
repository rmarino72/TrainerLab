<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>

<br/>
<br/>
<div class="container">
    <div class="col-lg-12">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">logout</span>&nbsp; Logout</h3>
            </div>
            <br/>
            <br/>
            <div class="card-body pt-0">
                <div class="text-center">
                    Vuoi davvero effettuare il logout?
                    <br/>
                    <br/>
                    <button class="btn btn-primary" type="button" id="ok-btn"><span class="material-symbols-outlined">done</span>&nbsp; Si</button>
                    <button class="btn btn-primary" type="button" id="cancel-btn"><span class="material-symbols-outlined">close</span>&nbsp; No</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function init() {
        $('#ok-btn').click(logout);
        $('#cancel-btn').click(cancel);
    }


    function logout()
    {
        var user = getFromStorage(STORAGE_USER);
        ajaxCall(USER_LOGOUT + user + "/", "GET", null, loggedOut);
    }

    function loggedOut(data)
    {
        clearStorage();
        window.location = "Login";
    }

    function cancel()
    {
        window.location.href = "Main";
    }

    $(document).ready(init);
</script>


<uc1:Foot runat="server" id="Foot"/>