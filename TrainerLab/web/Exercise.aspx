<%@ Page Language="C#" CodeBehind="Exercise.aspx.cs" Inherits="TrainerLab.web.Exercise" %>
<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>

<br/>
<br/>
<div class="col-lg-12" id="mainPg">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">body_system</span>&nbsp; Esercizi</h3>
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
                            <th data-field="MuscularGroup">Gruppo Muscolare</th>
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
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">body_system</span>&nbsp; Dettaglio Esercizio</h3>
            </div>
            <div class="card-body pt-0">
                <form id="editForm" action="javascript:update();" enctype="multipart/form-data" method="get">
                    <input type="hidden" id="id-txt"/>
                    <div class="row">
                        <div class="col-lg-6">&nbsp;</div>
                        <div class="col-lg-6">
                            <img src="/assets/img/fitness.png" id="image-box" width="300"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="Name-txt">Nome *</label>
                                <input class="form-control" id="Name-txt" type="text" name="NameTxt" autocomplete="off" required data-validate-field="NameTxt">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="MuscularGroup-cmb">Gruppo Muscolare *</label>
                                <select class="form-control" id="MuscularGroup-cmb" type="text" name="MuscularGroupTxt" required data-validate-field="MuscularGroupTxt">
                                    <option value=""> - </option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="Description-txt">Descrizione *</label>
                                <textarea class="form-control" rows="10" id="Description-txt" type="text" name="DescriptionTxt"  required data-validate-field="DescriptionTxt"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="ImageTxt">Immagine *</label>
                                <input type="file" class="form-control" id="ImageTxt"/>
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
        iAmAdmin();
        $('#editPg').hide();
        $('#new-btn').click(prepareForNew);
        $('#cancel-btn').click(refreshPage);
        let rules = {
                    NameTxt: {
                        required: true,
                    },
                    DescriptionTxt: {
                        required: true,
                    },
                    MuscularGroupTxt: {
                        required: true,
                    },
                    
                };
        
                let messages = {
                    NameTxt: "Campo obbligatorio",
                    DescriptionTxt: "Campo obbligatorio",
                    MuscularGroupTxt: "Campo obbligatorio",
                }
        
                validateForm('editForm', rules, messages);
        ajaxCall(EXERCISEPLAN_EXERCISE, 'GET', null, gotData);
    }
    function gotData(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }    
        fillDataTable('dataTable', data.Data, edit, true);
        resetForm('editForm');
        ajaxCall(EXERCISEPLAN_MUSCULARGROUP, 'GET', null, gotMuscularGroups);
    }
    function gotMuscularGroups(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        data.Data.forEach(e => {
            $('#MuscularGroup-cmb').append($('<option/>', {
                value: e.Name,
                text: e.Description
            }));
        });
    }
    
    function edit(row)
    {
        $('#Name-txt').attr("readonly", "true");
        ajaxCall(EXERCISEPLAN_EXERCISE + row.Id, 'GET', null, gotDetail);
    }
    
    function gotDetail(data)
    {
        if (!data.Outcome)
        {
            alertify.error(d.Message);
            return;
        }
        editing = true;
        $('#id-txt').val(data.Data.Id);
        $('#Name-txt').val(data.Data.Name);
        $('#MuscularGroup-cmb').val(data.Data.MuscularGroupName);
        $('#Description-txt').val(data.Data.Description);
        
        if(data.Data.Path != null)
        {
            $('#image-box').attr('src', '/Images/' + data.Data.Path);
        }
        $('#editPg').show();
        $('#mainPg').hide();
    }
    
    function prepareForNew()
    {
        editing = false;
        $('#Name-txt').removeAttr("readonly");
        $('#editPg').show();
        $('#mainPg').hide();
    }
    
    function getFormData()
    {
        let formData = new FormData();
        formData.append("Id", editing?$('#id-txt').val():"-1");
        formData.append("Name", $('#Name-txt').val());
        formData.append("MuscularGroup", $('#MuscularGroup-cmb').val());
        formData.append("Description", $('#Description-txt').val());
        formData.append("Image", isEmpty($('#ImageTxt').val())?null:document.getElementById('ImageTxt').files[0]);
        return formData;
    }
    
    function update()
    {
        let formData = getFormData();
        if(!editing)
        {
            sendForm(EXERCISEPLAN_EXERCISE, 'POST', formData, done);
        }
        else
        {
            sendForm(EXERCISEPLAN_EXERCISE, 'PATCH', formData, done);
        }
            
    }
    function done(d) 
    {
        if (!d.Outcome)
        {
            alertify.error(d.Message);
            return;
        }
        refreshPage();
    }
</script>

<uc1:Foot runat="server" id="Foot"/>