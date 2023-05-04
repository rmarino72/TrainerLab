<%@ Page Language="C#" CodeBehind="TrainingPlanManager.aspx.cs" Inherits="TrainerLab.web.TrainingPlanManager" %>
<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head" />
<br/>

<div class="col-lg-12" id="mainPg">

    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">clinical_notes</span>&nbsp; Schede Allenamento</h3>
            </div>
            <div class="card-body pt-0">
                <div class="table-responsive">
                    <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="dataTable">
                        <thead>
                            <tr>
                                <th data-field="Id" data-visible="false">#</th>
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
<div class="col-lg-12" id="listPg">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">clinical_notes</span>&nbsp; Schede di Allenamento di <span id="username"></span></h3>
            </div>
        </div>
        <div class="card-body pt-0">
            <br/>
            <br/>
            <button type="button" class="btn btn-primary" id="cancel-list-btn"><span class="material-symbols-outlined">arrow_back_ios</span>&nbsp; Indietro</button>
            <button type="button" class="btn btn-primary" id="new-btn"><span class="material-symbols-outlined">add</span>&nbsp; Nuovo</button> &nbsp;
            <div class="table-responsive">
                <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="listTable">
                    <thead>
                        <tr>
                            <th data-field="Id" data-visible="false">#</th>
                            <th data-field="Date">Data</th>
                            <th data-field="Name">Nome</th>
                        </tr>
                    </thead>
                    <tbody role="button"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="col-lg-12" id="editPg">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">clinical_notes</span>&nbsp; Scheda di Allenamento di <span id="username-edit"></span></h3>
            </div>
        </div>
        <div class="card-body pt-0">
        
            <form id="editForm" action="javascript:update();" method="get">
                <input type="hidden" id="user-id" />
                <div class="row">
                    <div class="col-lg-4">
                        <div class="input-material-group col-lg-12">
                            <label class="form-label" for="date-txt">Data *</label>
                            <input class="form-control" id="date-txt" type="date" name="dateTxt" required data-validate-field="dateTxt">
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="input-material-group col-lg-12">
                            <label class="form-label" for="name-txt">Nome Scheda *</label>
                            <input class="form-control" id="name-txt" type="text" name="nameTxt" required data-validate-field="nameTxt">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8">
                        <div class="input-material-group col-lg-4">
                            <label class="form-label" for="days-txt">Giorni previsti dal piano *</label>
                            <select class="form-control" id="days-txt" required data-validate-field="daysTxt">
                                <option value=""> - </option>
                                <option value="1"> 1 </option>
                                <option value="2"> 2 </option>
                                <option value="3"> 3 </option>
                            </select>
                        </div>
                    </div>                    
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    let editing = false;
    function init()
    {
        iAmAdmin();
        $('#cancel-list-btn').click(cancelList);
        $('#listPg').hide();
        $('#editPg').hide();
        $('#new-btn').click(prepareForNew);
        ajaxCall(USER_FULL, 'GET', null, gotUsers);
        
    }
    
    function gotUsers(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        data.Data.forEach(e => {
            e.BirthDate = italianFormatDate(new Date(e.BirthDate));
        });

        fillDataTable('dataTable', data.Data, getUserList, true);
    }
    
    function getUserList(row)
    {
        $('#username').html(row.FirstName + " " + row.LastName);
        $('#username-edit').html(row.FirstName + " " + row.LastName);
        $('#user-id').val(row.Id);
        ajaxCall(EXERCISEPLAN_TRAININGPLAN + row.Id, 'GET', null, gotList);
    }
    
    function prepareForNew()
    {
        editing = false;
        $('#listPg').hide();
        $('#editPg').show();
    }
    
    function gotList(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        
        data.Data.forEach(e => {
            e.Date = italianFormatDate(new Date(e.Date));
        });
        
        fillDataTable('listTable', data.Data, null, true);
        $('#listPg').show();
        $('#mainPg').hide();
    }
    
    function cancelList()
    {
        $('#listPg').hide();
        $('#mainPg').show();
    }
    
</script>
<uc1:Foot runat="server" id="Foot" />

