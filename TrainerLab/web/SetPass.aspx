<%@ Page Language="C#" CodeBehind="SetPass.aspx.cs" Inherits="TrainerLab.web.SetPass" %>
<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>

<br />
<br />
<div class="col-lg-12" id="mainPg">

    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">lock_reset</span>&nbsp; Assegna Password</h3>
            </div>
            <div class="card-body pt-0">
                <div class="table-responsive">
                    <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="dataTable">
                        <thead>
                            <tr>
                                <th data-field="Id">#</th>
                                <th data-field="FirstName">Nome</th>
                                <th data-field="LastName">Cognome</th>
                                <th data-field="Email">Email</th>
                                <th data-field="BirthDate">Data di nascita</th>
                                <th data-field="City">Citt&agrave;</th>
                            </tr>
                        </thead>
                        <tbody role="button"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container" id="editPg">
    <div class="col-lg-12">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">lock_reset</span>&nbsp; Assegna Password</h3>
            </div>
            <div class="card-body pt-0">
                <form id="editForm" action="javascript:update();" method="get">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="email-txt">Email</label>
                                <input class="form-control" id="email-txt" type="email" name="emailTxt" autocomplete="off" required data-validate-field="emailTxt" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="password-txt">Password *</label>
                                <input class="form-control" id="password-txt" type="password" name="passwordTxt" autocomplete="off" required data-validate-field="passwordTxt">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="confirmPassword-txt">Conferma Password *</label>
                                <input class="form-control" id="confirmPassword-txt" type="password" name="confirmPasswordTxt" autocomplete="off" required data-validate-field="confirmPasswordTxt">
                            </div>
                        </div>
                    </div>
                    <hr />
                    <button class="btn btn-primary" type="button" id="cancel-btn"><span class="material-symbols-outlined">close</span>&nbsp; Annulla</button>
                    <button class="btn btn-primary" type="submit"><span class="material-symbols-outlined">done</span>&nbsp; Ok</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function init() {
        $('#editPg').hide();
        $('#cancel-btn').click(refreshPage);

        let rules = {
            passwordTxt: {
                required: true,
            },
            confirmPasswordTxt: {
                required: true,
            },
        };

        let messages = {
            confirmPasswordTxt: "Campo obbligatorio",
            passwordTxt: "Campo obbligatorio",
        }

        validateForm('editForm', rules, messages);
        ajaxCall(USER_FULL, 'GET', null, gotUsers);
    }
    function gotUsers(data) {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        data.Data.forEach(e => {
            e.BirthDate = italianFormatDate(new Date(e.BirthDate));
        });

        fillDataTable('dataTable', data.Data, setPass, true);

    }

    function setPass(row) {
        resetForm("editForm");
        var user = row.Email;
        $('#email-txt').val(user);
        $('#mainPg').hide();
        $('#editPg').show();
    }

    function update() {

        var pass = $('#password-txt').val();
        var confirmPass = $('#confirmPassword-txt').val();

        var dt = new Object();
        dt.Email = $('#email-txt').val();
        dt.OldPassword = '';
        dt.NewPassword = pass;
        dt.ConfirmPassword = confirmPass;

        ajaxCall(USER_PASS, 'POST', JSON.stringify(dt), changed);
        
    }
    function changed(data) {
        if (!data.Outcome) {
            if (data.Code == 1) {
                alertify.error("I valori di Password e Conferma Password non corrispondono");
                return;
            }
            
            alertify.error(data.Message);
            return;
        }
        alertify.success("Modifica password avvenuta con successo");
        $('#mainPg').show();
        $('#editPg').hide();

    }
</script>

<uc1:Foot runat="server" id="Foot"/>