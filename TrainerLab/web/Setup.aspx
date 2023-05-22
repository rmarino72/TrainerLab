﻿<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>

<br/>
<br/>
<div class="container">
    <div class="col-lg-12">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">settings</span>&nbsp; Impostazioni</h3>
            </div>
            <div class="card-body pt-0">
                <form action="javascript:update();" id="editForm" method="get">
                    <input type="hidden" id="config-id"/>
                    <div class="row">
                        <div class="input-material-group col-lg-12">
                            <label class="form-label" for="dismisstolerance-txt">Tolleranza disdetta appuntamento in ore *</label>
                            <input class="form-control" id="dismisstolerance-txt" type="number" name="dismisstoleranceTxt" autocomplete="off" required data-validate-field="dismisstoleranceTxt">
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
    function init()
    {
        iAmAdmin();
        let rules = {
            dismisstoleranceTxt: {
                required: true,
            },
            
        };

        let messages = {
            dismisstoleranceTxt: "Inserire un numero intero valido",
        }
        validateForm('editForm', rules, messages);
        ajaxCall(APP_CONFIG, 'GET', null, gotConfig);
    }

    function gotConfig(data)
    {
        if (!data.Outcome)
        {
            alertify.error(data.Message);
            return;
        }
        var config = data.Data;
        $('#config-id').val(config.Id);
        $('#dismisstolerance-txt').val(config.DismissTolerance);
    }

    function update()
    {
        var config = {};
        config.Id = $('#config-id').val();
        config.DismissTolerance = $('#dismisstolerance-txt').val();

        ajaxCall(APP_CONFIG, 'PATCH', JSON.stringify(config), updated);
    }

    function updated(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        alertify.success("impostazioni salvate con successo!");
    }


</script>
<uc1:Foot runat="server" id="Foot"/>