<%@ Page Language="C#" CodeBehind="PersonalPlan.aspx.cs" Inherits="TrainerLab.web.PersonalPlan" %>

<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>



<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>
<div class="col-lg-12" id="listPg">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">body_system</span>&nbsp; Schede di Allenamento Personali<span id="username"></span></h3>
            </div>
        </div>
        <div class="card-body pt-0">
            <br/>
            <br/>

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
                <h3 class="h4 mb-0 text-center"><span class="material-symbols-outlined">clinical_notes</span>&nbsp; Scheda di Allenamento</h3>
            </div>
            <div class="card-body">
                <br/>
                <button id="cancelBtn" class="btn btn-danger" type="button"><span class="material-symbols-outlined">cancel</span> Chiudi</button>
                <br/>
                <br/>
                <h4>Nome della scheda: <span id="name-txt"></span></h4><br/>
                <h4>Data: <span id="date-txt"></span></h4>
                <br/>
                <h4>Annotazioni sul piano di allenamento:</h4>
                <br/>
                <pre>
<span id="Notes-txt"></span>
</pre>
                <br/>
                <hr/>
                <br/>
                <div id="day1Div">
                    <h4 class="text-center">Giorno 1</h4>
                    <br/>
                    <div id="day1Id"></div>
                    <br/>
                </div>
                <div id="day2Div">
                    <h4 class="text-center">Giorno 2</h4>
                    <br/>
                    <div id="day2Id"></div>
                    <br/>
                </div>
                <div id="day3Div">
                    <h4 class="text-center">Giorno 3</h4>
                    <br/>
                    <div id="day3Id"></div>
                    <br/>
                </div>
                <div id="day4Div">
                    <h4 class="text-center">Giorno 4</h4>
                    <br/>
                    <div id="day4Id"></div>
                    <br/>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
let htmls = [];
function init()
{
    let userData = getObjectFromStorage(STORAGE_USER_DATA);
    let userId = userData.Id;
    $('#editPg').hide();
    $('#day1Div').hide();
    $('#day2Div').hide();
    $('#day3Div').hide();
    $('#day4Div').hide();
    $('#cancelBtn').click(refreshPage);
    ajaxCall(EXERCISEPLAN_TRAININGPLAN_BYUSER + userId, 'GET', null, gotList);
}
function initData()
{    
    htmls[0] = '';
    htmls[1] = '';
    htmls[2] = '';
    htmls[3] = '';
}

function gotList(data)
{
    if (!data.Outcome) {
        alertify.error(data.Message);
        return;
    }
    
    data.Data.forEach(e => 
    {
        e.Date = italianFormatDate(new Date(e.Date));
    });
    
    fillDataTable('listTable', data.Data, showPlan, true);
}

function showPlan(row)
{
    ajaxCall(EXERCISEPLAN_TRAININGPLAN + row.Id +'/', 'GET', null, gotPlanForId);
}

function gotPlanForId(data)
{
    if (!data.Outcome) {
        alertify.error(data.Message);
        return;
    }
    initData();
   
    
    let htmls = ['','','',''];
    
    
    data.Data.forEach(e =>
    {
        let currentDay = e.Day;
        let h = '<b>' + e.ExerciseName + '</b><br/><br/>';
        
        h = h + "- Serie: " + e.Sequences + "<br/>";
        h = h + "- Ripetizioni: " + e.Repetitions + "<br/>";
        h = h + "- Tempo: " + e.Time + "<br/><br/>";
        h = h + "Annotazioni per questo esercizio:<br/><br/><pre>" + e.Notes + "</pre><br/>";
        
        h = h + "<hr/>";
        
        htmls[currentDay - 1] = htmls[currentDay - 1] + h;
        
    });
    
    $('#day1Id').html(htmls[0]);
    $('#day2Id').html(htmls[1]);
    $('#day3Id').html(htmls[2]);
    $('#day4Id').html(htmls[3]);
    
    
    let lastOne = data.Data[data.Data.length - 1];
    //$('#trainingplan-id').val(lastOne.TrainingPlanId);
    $('#name-txt').html(lastOne.Name);
    $('#date-txt').html(italianFormatDate(new Date(lastOne.Date)));
    let days = parseInt(lastOne.Day);
    $('#Notes-txt').html(lastOne.Description);
    
    if(days > 0)
    {
        $('#day1Div').show();
    }
    if(days > 1)
    {
        $('#day2Div').show();
    }
    if(days > 2)
    {
        $('#day3Div').show();
    }
    if(days > 3)
    {
        $('#day4Div').show();
    }
    
    $('#listPg').hide();
    $('#editPg').show();
}

</script>

<uc1:Foot runat="server" id="Foot"/>