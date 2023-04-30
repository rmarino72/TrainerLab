<%@ Page Language="C#" CodeBehind="ExerciseSheet.aspx.cs" Inherits="TrainerLab.web.ExerciseSheet" %>
<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head" />
<br />
<br />
<div class="col-lg-12" id="mainPg">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">assignment</span>&nbsp;Schede Esercizi</h3>
            </div>
            <div class="card-body pt-0">

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
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">assignment</span>&nbsp;&nbsp<span id="name_div">Dettaglio Esercizio</span></h3>
            </div>
            <div class="card-body pt-0">
                <br/>
                <div class="row">
                    <div class="col-lg-6">&nbsp;</div>
                    <div class="col-lg-6">
                        <img src="/assets/img/fitness.png" id="image-box" width="300" />
                    </div>
                </div>
                <hr />
                Gruppo muscolare: <span id="muscular_div">Bicipiti</span>
                <hr />
                <p id="description_div">
                    Descrizione esercizio
                </p>
                <hr />
                <button class="btn btn-primary" type="button" id="cancel-btn"><span class="material-symbols-outlined">close</span>&nbsp; Chiudi</button>
            </div>
        </div>
    </div>
</div>

<script>
    function init()
    {
        $('#editPg').hide();
        $('#cancel-btn').click(refreshPage);
        ajaxCall(EXERCISEPLAN_EXERCISE, 'GET', null, gotData);
    }
    
    function gotData(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }    
        fillDataTable('dataTable', data.Data, edit, true);
    }
    
    function edit(row)
    {
        ajaxCall(EXERCISEPLAN_EXERCISE + row.Id, 'GET', null, gotDetail);
    }
    
    function gotDetail(data)
    {
        if (!data.Outcome)
        {
            alertify.error(d.Message);
            return;
        }
        
        $('#name_div').html(data.Data.Name);
        $('#muscular_div').html(data.Data.MuscularGroupName);
        $('#description_div').html(data.Data.Description);
        
        if(data.Data.Path != null)
        {
            $('#image-box').attr('src', '/Images/' + data.Data.Path);
        }
        $('#editPg').show();
        $('#mainPg').hide();
    }
    
</script>
<uc1:Foot runat="server" id="Foot" />