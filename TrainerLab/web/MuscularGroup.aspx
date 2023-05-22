<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>
<br/>
<br/>
<div class="col-lg-12" id="mainPg">

    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">fitness_center</span>&nbsp; Gruppi Muscolari</h3>
            </div>
            <div class="card-body pt-0">
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-primary" id="new-btn"><span class="material-symbols-outlined">add</span>&nbsp; Nuovo</button>
                </div>
                <div class="table-responsive">
                    <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="dataTable">
                        <thead>
                        <tr>
                            <th data-field="Id" data-visible="false">#</th>
                            <th data-field="Name">Nome</th>
                            <th data-field="Description">Descrizione</th>
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
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">fitness_center</span>&nbsp; Dettaglio Gruppo Muscolare</h3>
            </div>
            <div class="card-body pt-0">
                <form id="editForm" action="javascript:update();" method="get">
                    <input type="hidden" id="id-txt"/>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="Name-txt">Nome *</label>
                                <input class="form-control" id="Name-txt" type="text" name="NameTxt" autocomplete="off" required data-validate-field="NameTxt">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="Description-txt">Descrizione *</label>
                                <input class="form-control" id="Description-txt" type="text" name="DescriptionTxt" autocomplete="off" required data-validate-field="DescriptionTxt">
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <button class="btn btn-primary" type="button" id="cancel-btn"><span class="material-symbols-outlined">close</span>&nbsp; Annulla</button>
                    <button class="btn btn-primary" type="submit"><span class="material-symbols-outlined">done</span>&nbsp; Ok</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>

    var editing = false;    
    function init()
    {
        $('#editPg').hide();
        $('#new-btn').click(prepareForNew);
        $('#cancel-btn').click(refreshPage);
        iAmAdmin();
        let rules = {
            NameTxt: {
                required: true,
            },
            DescriptionTxt: {
                required: true,
            },
        };
    
        let messages = {
            NameTxt: "Campo obbligatorio",
            DescriptionTxt: "Campo obbligatorio",
        }
    
        validateForm('editForm', rules, messages);
        ajaxCall(EXERCISEPLAN_MUSCULARGROUP, 'GET', null, gotData);
    }

    function gotData(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }    
        fillDataTable('dataTable', data.Data, edit, true);
    }
    
    function prepareForNew()
    {
        editing = false;
        resetForm("editForm");
        $('#Name-txt').removeAttr("readonly");
    
        $('#mainPg').hide();
        $('#editPg').show();
    }
    
    function update()
    {
        var o = formToObj(editing);
        if (!editing) {
            ajaxCall(EXERCISEPLAN_MUSCULARGROUP, 'POST', JSON.stringify(o), done);
        }
        else {
            ajaxCall(EXERCISEPLAN_MUSCULARGROUP, 'PATCH', JSON.stringify(o), done);
        }
    }

    function done(d) {
        if (!d.Outcome)
        {
            alertify.error(d.Message);
            return;
        }
        refreshPage();
    }

    function formToObj(withId = false)
    {
        var obj = {};
        obj.Id = withId ? $('#id-txt').val() : 0;
        obj.Name = $('#Name-txt').val();
        obj.Description = $('#Description-txt').val();
        return obj;
    }

    function edit(row)
    {
        $('#Name-txt').attr("readonly", "true");
        resetForm("editForm");
        var id = row.Id;
        ajaxCall(EXERCISEPLAN_MUSCULARGROUP + id, 'GET', null, gotDetail);
    }

    function gotDetail(d)
    {
         if (!d.Outcome) {
            alertyfy.error(d.Message);
            return;
        }
        editing = true;
        var obj = d.Data;
        $('#id-txt').val( obj.Id);
        $('#Name-txt').val(obj.Name);
        $('#Description-txt').val(obj.Description);
        
        $('#mainPg').hide();
        $('#editPg').show();
    }

</script>
<uc1:Foot runat="server" id="Foot"/>