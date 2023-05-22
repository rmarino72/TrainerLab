<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>
<br/>
<br/>
<div class="container">
    <div class="col-lg-12">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">manage_accounts</span>&nbsp; I tuoi dati</h3>
            </div>
            <div class="card-body pt-0">
                <form id="editForm" action="javascript:update();" method="get">
                    <input type="hidden" id="id-txt"/>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="firstName-txt">Nome *</label>
                                <input class="form-control" id="firstName-txt" type="text" name="firstNameTxt" autocomplete="off" required data-validate-field="firstNameTxt">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="lastName-txt">Cognome *</label>
                                <input class="form-control" id="lastName-txt" type="text" name="lastNameTxt" autocomplete="off" required data-validate-field="lastNameTxt">
                            </div>
                        </div>
                    </div>
                    <div class="row" id="roleRow">
                        <div class="col-lg-12">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="role-cmb">Ruolo *</label>
                                <select class="form-control" id="role-cmb" name="roleCmb" required data-validate-field="roleCmb">
                                    <option value=""> - </option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="email-txt">Email *</label>
                                <input class="form-control in" id="email-txt" type="text" name="phoneTxt" autocomplete="off" required data-validate-field="emaiTxt" readonly>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="phone-txt">Telefono *</label>
                                <input class="form-control" id="phone-txt" type="text" name="phoneTxt" autocomplete="off" required data-validate-field="phoneTxt">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="birthDate-txt">Data di Nascita *</label>
                                <input class="form-control" id="birthDate-txt" type="date" name="birthDateTxt" autocomplete="off" required data-validate-field="birthDateTxt">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="sex-cmb">Genere *</label>
                                <select class="form-control" id="sex-cmb" name="sexCmb" required data-validate-field="sexCmb">
                                    <option value=""> - </option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="region-cmb">Regione</label>
                                <select class="form-control" id="region-cmb">
                                    <option value=""> - </option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="province-cmb">Provincia</label>
                                <select class="form-control" id="province-cmb">
                                    <option value=""> - </option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="city-cmb">Comune</label>
                                <select class="form-control" id="city-cmb">
                                    <option value=""> - </option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="cap-txt">CAP</label>
                                <input class="form-control" id="cap-txt" type="text">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="address-txt">Via / Piazza</label>
                                <input class="form-control" id="address-txt" type="text">
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="number-txt">N.</label>
                                <input class="form-control" id="number-txt" type="text">
                            </div>
                        </div>
                    </div>

                    <hr/>
                    <button class="btn btn-primary" type="submit"><span class="material-symbols-outlined">done</span>&nbsp; Aggiorna</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    $('#roleRow').hide();
    var region = null;
    var province = null;
    var city = null;
    var role = null;
    var cap = null;
    function init() {

        $('#region-cmb').change(loadProvinces);
        $('#province-cmb').change(loadCities);
        $('#city-cmb').change(refreshCap);

        let rules = {
            emaiTxt: {
                required: true,
                email: true,
            },
            phoneTxt: {
                required: true,
                phone: true,
            },
            firstNameTxt: {
                required: true,
            },
            lastNameTxt: {
                required: true,
            },
            birthDateTxt: {
                required: true,
                date: true,
            },
            sexCmb: {
                required: true
            },
            roleCmb: {
                required: true
            }
        };

        let messages = {
            emaiTxt: "Inserire una mail valida",
            phoneTxt: "Inserire un numero di telefono valido",
            firstNameTxt: "Campo obbligatorio",
            lastNameTxt: "Campo obbligatorio",
            birthDateTxt: "Inserire una data valida",
            sexCmb: "Campo obbligatorio",
            roleCmb: "Campo obbligatorio",
        }

        validateForm('editForm', rules, messages);
        loadSex();
    }

    function loadSex() {
        ajaxCall(USER_SEX, 'GET', null, gotSex);
    }

    function gotSex(data) {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        data.Data.forEach(e => {
            $('#sex-cmb').append($('<option/>', {
                value: e.Name,
                text: e.LabelIT
            }));
        });
        var user = getFromStorage(STORAGE_USER);
        ajaxCall(USER_FULL + user + "/", 'GET', null, gotFullUser);
    }

    function gotFullUser(d) {
        if (!d.Outcome) {
            alertyfy.error(d.Message);
            return;
        }
        editing = true;
        var obj = d.Data;
        $('#id-txt').val(obj.Id);
        $('#email-txt').val(obj.Email);
        $('#phone-txt').val(obj.Phone);
        $('#firstName-txt').val(obj.FirstName);
        $('#lastName-txt').val(obj.LastName);
        $('#sex-cmb').val(obj.Sex);
        role = obj.Role;
        $('#birthDate-txt').val(dateForInput(new Date(obj.BirthDate)));
        $('#address-txt').val(obj.AddressStreet);
        $('#number-txt').val(obj.AddressStreetNumber);
        region = obj.Region;
        city = obj.City;
        province = obj.Province;
        $('#cap-txt').val(obj.CAP);
        loadRoles();

    }

    function loadRoles() {
        ajaxCall(USER_ROLE, 'GET', null, gotRoles);
    }

    function gotRoles(data) {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        data.Data.forEach(e => {
            $('#role-cmb').append($('<option/>', {
                value: e.Name,
                text: e.LabelIT
            }));
        });
        $('#role-cmb').val(role);
        loadRegions();
    }

    function loadRegions() {
        ajaxCall(USER_REGION, 'GET', null, gotRegions);
    }

    function gotRegions(data) {
        if (!data.Outcome) {
            alertify.error(data.message);
            return;
        }
        data.Data.forEach(e => {
            $('#region-cmb').append($('<option/>', {
                value: e.Value,
                text: e.Value
            }));
        });
        if (region != null) {
            $('#region-cmb').val(region);
        }

        if (province != null && !isEmpty(province)) {
            loadProvinces();
        }
    }

    function loadProvinces() {
        resetSelect('province-cmb');
        resetSelect('city-cmb');
        $('#province-cmb').append($('<option/>', {
            value: "",
            text: "-"
        }));
        $('#city-cmb').append($('<option/>', {
            value: "",
            text: "-"
        }));
        if (city == null || isEmpty(city)) {
            refreshCap();
        }
        if (!isEmpty($('#region-cmb').val())) {
            ajaxCall(USER_PROVINCE + $('#region-cmb').val(), 'GET', null, gotProvinces);
        }

    }

    function gotProvinces(data) {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }

        data.Data.forEach(e => {
            $('#province-cmb').append($('<option/>', {
                value: e.Abbreviation,
                text: e.Name
            }));
        });
        $('#province-cmb').val(province);
        if (city != null && !isEmpty(city)) {
            loadCities();
        }
    }

    function loadCities() {
        resetSelect('city-cmb');
        $('#city-cmb').append($('<option/>', {
            value: "",
            text: "-"
        }));
        if (city == null || isEmpty(city)) {
            refreshCap();
        }
        if (!isEmpty($('#province-cmb').val())) {
            ajaxCall(USER_CITY + $('#province-cmb').val(), 'GET', null, gotCities);
        }
    }

    function gotCities(data) {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }

        data.Data.forEach(e => {
            $('#city-cmb').append($('<option/>', {
                value: e.CAP,
                text: e.Name
            }));
        });

        $("#city-cmb option").filter(function () {
            //may want to use $.trim in here
            return $(this).text() == city;
        }).attr('selected', true);

    }

    function refreshCap() {
        $('#cap-txt').val($('#city-cmb').val());
    }

    function formToObj(withId = false) {
        var obj = {};
        obj.Id = withId ? $('#id-txt').val() : 0;
        obj.Email = $('#email-txt').val();
        obj.Phone = $('#phone-txt').val();
        obj.FirstName = $('#firstName-txt').val();
        obj.LastName = $('#lastName-txt').val();
        obj.Sex = $('#sex-cmb').val();
        obj.SexDesc = null;
        obj.Role = $('#role-cmb').val();
        obj.RoleDesc = null;
        obj.BirthDate = dateForCSharp(new Date(splitDateFormat($('#birthDate-txt').val())));
        obj.AddressStreet = $('#address-txt').val();
        obj.AddressStreetNumber = $('#number-txt').val();
        obj.Region = $('#region-cmb').val();
        obj.City = $('#city-cmb option:selected').text();
        obj.Province = $('#province-cmb').val();
        obj.CAP = $('#cap-txt').val();
        return obj;
    }

    function update() {
        var user = formToObj(editing);
        if (!editing) {
            ajaxCall(USER, 'POST', JSON.stringify(user), done);
        }
        else {
            ajaxCall(USER, 'PATCH', JSON.stringify(user), done);
        }
    }

    function done(d) {
        if (!d.Outcome) {
            alertify.error(d.Message);
            return;
        }
        alertify.success("Dati aggiornati!");
    }
</script>
<uc1:Foot runat="server" id="Foot"/>