<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head" />

<br />
<br />
<div class="container">
    <div class="col-lg-12">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">key</span>&nbsp; Cambia Password</h3>
            </div>
            <div class="card-body pt-0">
                <form id="editForm" action="javascript:update();" method="get">
                    <div class="row">

                        <div class="input-material-group col-lg-4">
                            <label class="form-label" for="oldPass-txt">Password attuale *</label>
                            <input class="form-control" id="oldPass-txt" type="password" name="oldPassTxt" autocomplete="off" required data-validate-field="oldPassTxt">
                        </div>
                        <div class="input-material-group col-lg-4">
                            <label class="form-label" for="newPass-txt">Nuova password *</label>
                            <input class="form-control" id="newPass-txt" type="password" name="newPassTxt" autocomplete="off" required data-validate-field="newPassTxt">
                        </div>
                        <div class="input-material-group col-lg-4">
                            <label class="form-label" for="confirmPass-txt">Conferma password *</label>
                            <input class="form-control" id="confirmPass-txt" type="password" name="confirmPassTxt" autocomplete="off" required data-validate-field="confirmPassTxt">
                        </div>
                    </div>
                    <hr />
                    <button class="btn btn-primary" type="submit"><span class="material-symbols-outlined">done</span>&nbsp; Ok</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function init() {
        let rules = {
            oldPassTxt: {
                required: true
            },
            newPassTxt: {
                required: true,
            },
            confirmPassTxt: {
                required: true,
            },
        };

        let messages = {
            oldPassTxt: "Campo obbligatorio",
            newPassTxt: "Campo obbligatorio",
            confirmPassTxt: "Campo obbligatorio",
        }
        validateForm('editForm', rules, messages);
    }

    function update()
    {
        var dt = new Object();
        dt.Email = getFromStorage(STORAGE_USER);
        dt.OldPassword = $('#oldPass-txt').val();
        dt.NewPassword = $('#newPass-txt').val();
        dt.ConfirmPassword = $('#confirmPass-txt').val();

        ajaxCall(USER_PASS, 'POST', JSON.stringify(dt), changed);
    }

    function changed(data)
    {
        if (!data.Outcome)
        {
            if (data.Code == 1)
            {
                alertify.error("I valori di Password e Conferma Password non corrispondono");
                return;
            }
            if (data.Code == 2)
            {
                alertify.error("Password attuale errata");
                return;
            }
            alertify.error(data.Message);
            return;
        }
        alertify.success("Modifica password avvenuta con successo");
    
    }

</script>
<uc1:Foot runat="server" id="Foot" />