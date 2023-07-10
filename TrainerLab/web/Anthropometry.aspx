<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>


<br/>

<div class="col-lg-12" id="mainPg">

    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">monitor_weight</span>&nbsp; Anamnesi Antropometrica</h3>
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


        <button type="button" class="btn btn-primary" id="cancel-list-btn"><span class="material-symbols-outlined">arrow_back_ios</span>&nbsp; Indietro</button>
        <hr/>
        <h2>
            <span id="user-txt"></span>
        </h2>
        <br/>
        <div class="row">
            <div class="col-lg-4 container-fluid">
                <br/>

                <div class="card mb-0">
                    <div class="card-header">
                        <h3 class="h4 mb-0"><span class="material-symbols-outlined">monitor_weight</span>&nbsp; Antropometriche </h3>
                    </div>

                    <div class="card-body pt-0">
                        <button type="button" class="btn btn-primary" id="new-btn"><span class="material-symbols-outlined">add</span>&nbsp; Nuovo</button> &nbsp;
                        <hr/>
                        <div class="table-responsive">
                            <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="listTable">
                                <thead>
                                <tr>
                                    <th data-field="Id" data-visible="false">#</th>
                                    <th data-field="Date">Data e Ora</th>
                                </tr>
                                </thead>
                                <tbody role="button"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 container-fluid">
                <br/>

                <div class="card mb-0">
                    <div class="card-header">
                        <h3 class="h4 mb-0"><span class="material-symbols-outlined">body_fat</span>&nbsp; Plicometriche</h3>
                    </div>
                    <div class="card-body pt-0">
                        <button type="button" class="btn btn-primary" id="new-btn-plico"><span class="material-symbols-outlined">add</span>&nbsp; Nuovo</button> &nbsp;
                        <hr/>
                        <div class="table-responsive">
                            <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="plicoTable">
                                <thead>
                                <tr>
                                    <th data-field="Id" data-visible="false">#</th>
                                    <th data-field="Date">Data e Ora</th>
                                </tr>
                                </thead>
                                <tbody role="button"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-header">
                        <h3 class="h4 mb-0">Peso kg.</h3>
                    </div>
                    <div class="card-body">
                        <canvas id="weightChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <hr/>

        <h3> Misura circonferenze in cm.</h3>
        <div class="row">
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Spalle</strong>
                        <canvas id="shoulderChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Torace</strong>
                        <canvas id="chestChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Vita</strong>
                        <canvas id="bellyChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Fianchi</strong>
                        <canvas id="hipsChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Braccio sinistro</strong>
                        <canvas id="armLChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Braccio destro</strong>
                        <canvas id="armRChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Coscia sinistra</strong>
                        <canvas id="thighLChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Coscia destra</strong>
                        <canvas id="thighRChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Poplaccio sinistro</strong>
                        <canvas id="calfLChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Polpaccio Destro</strong>
                        <canvas id="calfRChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid"></div>
            <div class="col-lg-4 container-fluid"></div>
        </div>
        <hr/>
        
        <h3> Valutazioni</h3>
        <div class="row">
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>BMI</strong>
                        <canvas id="bmiChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <hr/>

        <h3> Plicometria</h3>
        <div class="row">
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Pettorale</strong>
                        <canvas id="pectoralChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Ascellare</strong>
                        <canvas id="axillaryChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Sopra Iliaca</strong>
                        <canvas id="suprailiacChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Addominale</strong>
                        <canvas id="abdominalChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Coscia</strong>
                        <canvas id="thighChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Subscapolare</strong>
                        <canvas id="subscapularChart"></canvas>
                    </div>
                </div>
            </div>
        </div> 
        <div class="row">
            <div class="col-lg-4 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Tricipite</strong>
                        <canvas id="tricepsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>        
    </div>
</div>

<div class="col-lg-12" id="editPg">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">monitor_weight</span>&nbsp; Scheda Antropometrica <span id="user-txt"></span></h3>
            </div>
            <div class="card-body pt-0">

                <form id="editForm" action="javascript:update();" method="get">
                    <input type="hidden" id="anthropometry-id"/>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="date-txt">Data e Ora *</label>
                                <input class="form-control" id="date-txt" type="datetime-local" name="dateTxt" required data-validate-field="dateTxt">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="height-txt">Altezza in m.</label>
                                <input class="form-control" id="height-txt" type="number" name="heightTxt" required data-validate-field="heightTxt">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="weight-txt">Peso in kg.</label>
                                <input class="form-control" id="weight-txt" type="number" name="weightTxt" required data-validate-field="weightTxt">
                            </div>
                        </div>
                    </div>
                    <div class="row">&nbsp;</div>
                    <div class="row">&nbsp;
                        <strong>BMI</strong>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                
                                <input class="form-control" id="bmi-txt" type="number" readonly="readonly">
                            </div>                    
                        </div>
                    </div>
                    <div class="row">&nbsp;</div>
                    <div class="row">
                        <strong>Misurazione circonferenze in cm.</strong>
                    </div>
                    <div class="row">

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="shoulder-txt">spalle </label>
                                <input class="form-control" id="shoulder-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="chest-txt">torace </label>
                                <input class="form-control" id="chest-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="belly-txt">vita </label>
                                <input class="form-control" id="belly-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="hips-txt">fianchi </label>
                                <input class="form-control" id="hips-txt" type="number">
                            </div>
                        </div>

                    </div>
                    <div class="row">

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="armleft-txt">braccio sinistro </label>
                                <input class="form-control" id="armleft-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="armright-txt">braccio destro </label>
                                <input class="form-control" id="armright-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="thighleft-txt">coscia sinistra </label>
                                <input class="form-control" id="thighleft-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="thighright-txt">coscia destra </label>
                                <input class="form-control" id="thighright-txt" type="number">
                            </div>
                        </div>

                    </div>

                    <div class="row">

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="calfleft-txt">polpaccio sinistro </label>
                                <input class="form-control" id="calfleft-txt" type="number">
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="calfright-txt">polpaccio destro </label>
                                <input class="form-control" id="calfright-txt" type="number">
                            </div>
                        </div>

                    </div>

                    <div class="row">

                        <div class="col-lg-12">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="notes-txt">note </label>
                                <textarea id="notes-txt" class="form-control"></textarea>
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

<div id="plicoPg" class="col-lg-12">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">body_fat</span>&nbsp; Scheda Plicometria <span id="user-txt"></span></h3>
            </div>
            <div class="card-body pt-0">
                <form id="plicoForm" action="javascript:updateplico();" method="get">
                    <input type="hidden" id="plicometry-id"/>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="plicodate-txt">Data e Ora *</label>
                                <input class="form-control" id="plicodate-txt" type="datetime-local" name="plicodateTxt" required data-validate-field="plicodateTxt">
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">&nbsp;</div>
                    <div class="row">
                        <strong>Misurazione plicometria in mm.</strong>
                    </div>

                    <div class="row">

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="pectoral-txt">pettorale </label>
                                <input class="form-control" id="pectoral-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="axillary-txt">ascellare </label>
                                <input class="form-control" id="axillary-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="suprailiac-txt">sopra iliaca </label>
                                <input class="form-control" id="suprailiac-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="abdominal-txt">addominale </label>
                                <input class="form-control" id="abdominal-txt" type="number">
                            </div>
                        </div>

                    </div>

                    <div class="row">

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="thigh-txt">coscia </label>
                                <input class="form-control" id="thigh-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="subscapular-txt">subscapolare </label>
                                <input class="form-control" id="subscapular-txt" type="number">
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="triceps-txt">tricipite </label>
                                <input class="form-control" id="triceps-txt" type="number">
                            </div>
                        </div>

                    </div>
                    <div class="row">

                        <div class="col-lg-12">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="pliconotes-txt">note </label>
                                <textarea id="pliconotes-txt" class="form-control"></textarea>
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <button class="btn btn-primary" type="button" id="plico-cancel-btn"><span class="material-symbols-outlined">close</span>&nbsp; Annulla</button>
                    <button class="btn btn-primary" type="button" id="plico-preview-btn"><span class="material-symbols-outlined">preview</span>&nbsp; Anteprima</button>
                    <button class="btn btn-primary" type="submit"><span class="material-symbols-outlined">done</span>&nbsp; Ok</button>
                </form>
            </div>
        </div>
    </div>
</div>
<div id="plicoPrevPg" class="col-lg-12">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">preview</span>&nbsp; Anteprima Scheda Plicometria - <span id="prev-user-txt"></span></h3>
            </div>
        </div>
        <div class="card-body pt-0">
            <br/>
            <br/>
            <h3>Plicometriche:</h3>
            <canvas id="plicoChart"></canvas>
            <br/>
            <br/>
            <h3>Percentuali corporee:</h3>
            <canvas id="percentagePie"></canvas>
            
            <hr/>
            <button class="btn btn-primary" type="button" id="plico-prev-cancel-btn"><span class="material-symbols-outlined">close</span>&nbsp; Chiudi</button>
        </div>
    </div>
</div>
<script>

    let currentUser = null;
    let editing = false;
    let labels = [];
    let weightData = [];
    let shoulderData = [];
    let chestData = [];
    let bellyData = [];
    let hipsData = [];
    let armLData = [];
    let armRData = [];
    let thighLData = [];
    let thighRData = [];
    let calfLData = [];
    let calfRData = [];
    let bmiData = [];
    let pectoralData = [];
    let axillaryData = [];
    let suprailiacData = [];
    let abdominalData = [];
    let thighData = [];
    let subscapualrData = [];
    let tricepsData = [];
    
    function init()
    {
        iAmAdmin();

        $('#cancel-list-btn').click(refreshPage);
        $('#cancel-btn').click(cancel);
        $('#plico-cancel-btn').click(cancel);
        $('#new-btn').click(prepareForNew);
        $('#new-btn-plico').click(prepareForNewPlico);
        $('#plico-preview-btn').click(plicoPreview);
        $('#plico-prev-cancel-btn').click(plicoPreviewCancel);
        $('#listPg').hide();
        $('#editPg').hide();
        $('#plicoPg').hide();
        $('#plicoPrevPg').hide();
        $("#weight-txt").on('change keyup paste', bmi);
        $("#height-txt").on('change keyup paste', bmi);
        
        let rules = {
           
            dateTxt: {
                required: true,
            },
            heightTxt: {
                required: true,
            },
            weightTxt: {
                required: true,
            }
        };
        let messages = {
            dateTxt: "Inserire una data ed un'ora valida",
            heightTxt: "Inserire un valore di altezza valido",
            weightTxt: "Inserire un valore di peso",
        }

        validateForm('editForm', rules, messages);

        rules = {

            plicodateTxt: {
                required: true,
            }
        };
        messages = {
            plicodateTxt: "Inserire una data ed un'ora valida",
        }

        validateForm('plicoForm', rules, messages);
        ajaxCall(USER_FULL, 'GET', null, gotUsers);
    }
    
    function plicoPreview()
    {
        $('#plicoPg').hide();
        $('#plicoPrevPg').show();
        
        var plicoSum = 0;
        var data = [];
        data.push(parseFloat($('#pectoral-txt').val()));
        data.push(parseFloat($('#axillary-txt').val()));
        data.push(parseFloat($('#suprailiac-txt').val()));
        data.push(parseFloat($('#abdominal-txt').val()));
        data.push(parseFloat($('#thigh-txt').val()));
        data.push(parseFloat($('#subscapular-txt').val()));
        data.push(parseFloat($('#triceps-txt').val()));
        
        for(var i=0; i<data.length; i++)
            plicoSum += data[i];
        
        var pc=$('#plicoChart');
        new Chart(pc, {
                type: "bar",
                options: {
                    scales: {
                        xAxes: [
                            {
                                display: true,
                                gridLines: {
                                    color: "transparent",
                                },
                            },
                        ],
                        yAxes: [
                            {
                                display: true,
                                gridLines: {
                                    color: "transparent",
                                },
                            },
                        ],
                    },
                },
                data: {
                    labels: ["Pettorale", "Ascellare", "Sopra Iliaca", "Addominale", "Coscia", "Subscapolare", "Tricipite"],
                    datasets: [
                        {
                            label: "Valori pliche",
                            backgroundColor: ["#864DD9", "#864DD9", "#864DD9", "#864DD9", "#864DD9", "#864DD9", "#864DD9"],
                            hoverBackgroundColor: ["#864DD9", "#864DD9", "#864DD9", "#864DD9", "#864DD9", "#864DD9", "#864DD9"],
                            borderColor: ["#864DD9", "#864DD9", "#864DD9", "#864DD9", "#864DD9", "#864DD9", "#864DD9"],
                            borderWidth: 0.5,
                            data: data,
                        
                        },
                    ],
                },
            });
        
        ajaxCall(USER_PERCENTAGE + currentUser + "/" + plicoSum + "/", 'get', null, gotPercentage);
    }
    
    function gotPercentage(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        
        var chartData = [];
        chartData.push(data.Data.FatPercentage);
        chartData.push(100 - data.Data.FatPercentage);
        var pieChart = $('#percentagePie');
        new Chart(pieChart, {
                type: "pie",
                options: {
                    legend: {
                        display: true,
                        position: "left",
                    },
                },
                data: {
                    labels: ["% massa grassa", "% massa magra"],
                    datasets: [
                        {
                            data: chartData,
                            borderWidth: 0,
                            backgroundColor: ["#723ac3", "#864DD9", "#9762e6", "#a678eb"],
                            hoverBackgroundColor: ["#723ac3", "#864DD9", "#9762e6", "#a678eb"],
                        },
                    ],
                },
            });
        
            var pieChartExample = {
                responsive: true,
            };
    }
    
    function plicoPreviewCancel()
    {
        $('#plicoPg').show();
        $('#plicoPrevPg').hide();
    }

    function gotUsers(data) {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        data.Data.forEach(e => {
            e.BirthDate = italianFormatDate(new Date(e.BirthDate));
        });

        fillDataTable('dataTable', data.Data, updateListPage, true);
    }

    function updateListPage(r)
    {
        let email = r.Email;
        currentUser = email;
        ajaxCall(USER_ANTHROPOMETRY + email + "/", 'GET', null, gotList);
    }

    function gotList(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        var dt = data.Data;

        dt.forEach(e => {
            let dtTmp = new Date(e.Date);
            e.Date = italianFormatDateTime(dtTmp);
            labels.push(dtTmp.getDate() + "/" + (dtTmp.getMonth()+1));
            weightData.push(e.Weight);
            shoulderData.push(e.ShoulderCirc);
            chestData.push(e.ChestCirc);
            bellyData.push(e.BellyCirc);
            hipsData.push(e.HipsCirc);
            armLData.push(e.ArmLeftCirc);
            armRData.push(e.ArmRightCirc);
            thighLData.push(e.ThighLeftCirc);
            thighRData.push(e.ThighRightCirc);
            calfLData.push(e.CalfLeftCirc);
            calfRData.push(e.CalfRightCirc);
            bmiData.push(e.BMI);
        });
        fillChart('weightChart', 'kg.', labels.slice(-15), weightData.slice(-15));

        fillChart('shoulderChart', 'spalle', labels.slice(-15), shoulderData.slice(-15));
        fillChart('chestChart', 'torace', labels.slice(-15), chestData.slice(-15));
        fillChart('bellyChart', 'vita', labels.slice(-15), bellyData.slice(-15));

        fillChart('hipsChart', 'fianchi', labels.slice(-15), hipsData.slice(-15));
        fillChart('armLChart', 'braccio sx', labels.slice(-15), armLData.slice(-15));
        fillChart('armRChart', 'braccio dx', labels.slice(-15), armRData.slice(-15));

        fillChart('thighLChart', 'fianchi', labels.slice(-15), thighLData.slice(-15));
        fillChart('thighRChart', 'braccio sx', labels.slice(-15), thighRData.slice(-15));
        fillChart('calfLChart', 'braccio dx', labels.slice(-15), calfLData.slice(-15));
        fillChart('calfRChart', 'braccio dx', labels.slice(-15), calfRData.slice(-15));
        
        fillChart('bmiChart', 'bmi', labels.slice(-15), bmiData.slice(-15));

        fillDataTable('listTable', dt.reverse(), prepareForEdit, true);
        ajaxCall(USER_FULL + currentUser + "/", 'GET', null, gotUser);
    }
    
    function gotPlicoList(data)
    {
        if (!data.Outcome) 
        {
            alertify.error(data.Message);
            return;
        }
        let dt = data.Data;

        dt.forEach(e => 
        {
            let dtTmp = new Date(e.Date);
            labels.push(dtTmp.getDate() + "/" + (dtTmp.getMonth() + 1));
            pectoralData.push(e.Pectoral);
            axillaryData.push(e.Axillary);
            suprailiacData.push(e.Suprailiac);
            abdominalData.push(e.Abdominal);
            thighData.push(e.Thigh);
            subscapualrData.push(e.Subscapular);
            tricepsData.push(e.Triceps);
        });
        
        fillChart('pectoralChart', 'kg.', labels.slice(-15), pectoralData.slice(-15));
        fillChart('axillaryChart', 'kg.', labels.slice(-15), axillaryData.slice(-15));
        fillChart('suprailiacChart', 'kg.', labels.slice(-15), suprailiacData.slice(-15));
        fillChart('abdominalChart', 'kg.', labels.slice(-15), abdominalData.slice(-15));
        fillChart('thighChart', 'kg.', labels.slice(-15), thighData.slice(-15));
        fillChart('subscapularChart', 'kg.', labels.slice(-15), subscapualrData.slice(-15));
        fillChart('tricepsChart', 'kg.', labels.slice(-15), tricepsData.slice(-15));
    }

    function gotUser(data) {

        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        $('#user-txt').text(data.Data.FirstName + " " + data.Data.LastName);
        $('#prev-user-txt').text(data.Data.FirstName + " " + data.Data.LastName);
        ajaxCall(USER_PLICOMETRY + currentUser + "/", 'GET', null, gotPlicometries);

    }

    function gotPlicometries(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        var dt = data.Data;


        dt.forEach(e => {
            var dtTmp = new Date(e.Date);
            e.Date = italianFormatDateTime(dtTmp);
        });

        fillDataTable('plicoTable', dt.reverse(), prepareForEditPlico, true);
        
        ajaxCall(USER_PLICOMETRY + currentUser + "/", 'GET', null, gotPlicoList);

        $('#mainPg').hide();
        $('#listPg').show();
        $('#editPg').hide();
    }

    function prepareForNew()
    {
        editing = false;
        resetForm('editForm');
        ajaxCall(USER_FULL + currentUser + "/", "GET", null, readyForNew);
    }

    function prepareForNewPlico() {
        editing = false;
        resetForm('plicoForm');
        var dt = new Date();
        $('#plicodate-txt').val(dt.toJSON().slice(0, 16));
        $('#plicoPg').show();
        $('#listPg').hide();
    }

    function readyForNew(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        $('#height-txt').val(data.Data.Height);
        var dt = new Date();
        $('#date-txt').val(dt.toJSON().slice(0, 16));
        $('#editPg').show();
        $('#listPg').hide();
    }

    function prepareForEdit(r)
    {
        ajaxCall(USER_ANTHROPOMETRY + currentUser + "/" + r.Id, "GET", null, gotAnthropometry);
    }

    function prepareForEditPlico(r) {
        ajaxCall(USER_PLICOMETRY + currentUser + "/" + r.Id, "GET", null, gotPlicometry);
    }

    function gotPlicometry(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        editing = true;
        resetForm('plicoForm');
        var o = data.Data;
        $('#plicometry-id').val(o.Id);
        $('#plicodate-txt').val(o.Date);
        $('#pectoral-txt').val(o.Pectoral);
        $('#axillary-txt').val(o.Axillary);
        $('#suprailiac-txt').val(o.Suprailiac);
        $('#abdominal-txt').val(o.Abdominal);
        $('#thigh-txt').val(o.Thigh);
        $('#subscapular-txt').val(o.Subscapular);
        $('#triceps-txt').val(o.Triceps);
        $('#pliconotes-txt').val(o.Notes);
        $('#plicoPg').show();
        $('#listPg').hide();
    }

    function gotAnthropometry(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        editing = true;
        resetForm('editForm');
        var o = data.Data;
        $('#anthropometry-id').val(o.Id);
        $('#height-txt').val(o.Height);
        $('#date-txt').val(o.Date);
        $('#weight-txt').val(o.Weight);
        $('#shoulder-txt').val(o.ShoulderCirc);
        $('#belly-txt').val(o.BellyCirc);
        $('#chest-txt').val(o.ChestCirc);
        $('#hips-txt').val(o.HipsCirc);
        $('#armleft-txt').val(o.ArmLeftCirc);
        $('#armright-txt').val(o.ArmRightCirc);
        $('#thighleft-txt').val(o.ThighLeftCirc);
        $('#thighright-txt').val(o.ThighRightCirc);
        $('#calfleft-txt').val(o.CalfLeftCirc);
        $('#calfright-txt').val(o.CalfRightCirc);
        $('#bmi-txt').val(o.BMI);
        $('#notes-txt').val(o.Notes);
        $('#editPg').show();
        $('#listPg').hide();
    }

    function cancel()
    {
        $('#editPg').hide();
        $('#plicoPg').hide();
        $('#listPg').show();
    }

    function update()
    {
        var a = formToObj(editing);
        if (!editing)
        {
            ajaxCall(USER_ANTHROPOMETRY, 'POST', JSON.stringify(a), updated);
        }
        else
        {
            ajaxCall(USER_ANTHROPOMETRY, 'PATCH', JSON.stringify(a), updated);
        }
    }

    function updateplico() {
        var a = plicoformToObj(editing);
        if (!editing) {
            ajaxCall(USER_PLICOMETRY, 'POST', JSON.stringify(a), updated);
        }
        else {
            ajaxCall(USER_PLICOMETRY, 'PATCH', JSON.stringify(a), updated);
        }
    }

    function updated(data) {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        var r = {};
        r.Email = currentUser;
        updateListPage(r);
    }

    function formToObj(withId=false)
    {
        var o = {};
        o.Id = withId ? parseInt($('#anthropometry-id').val()) : -1;
        o.FirstName = "";
        o.LastName = "";
        o.BirthDate = dateForCSharp(new Date())
        o.Sex = "";
        o.Height = nullable(parseFloat($('#height-txt').val()));
        o.Email = currentUser;
        o.Date = dateForCSharp(new Date($('#date-txt').val()));
        o.Weight = nullable(parseFloat($('#weight-txt').val()));
        o.ShoulderCirc = nullable(parseFloat($('#shoulder-txt').val()));
        o.BellyCirc = nullable(parseFloat($('#belly-txt').val()));
        o.ChestCirc = nullable(parseFloat($('#chest-txt').val()));
        o.HipsCirc = nullable(parseFloat($('#hips-txt').val()));
        o.ArmLeftCirc = nullable(parseFloat($('#armleft-txt').val()));
        o.ArmRightCirc = nullable(parseFloat($('#armright-txt').val()));
        o.ThighLeftCirc = nullable(parseFloat($('#thighleft-txt').val()));
        o.ThighRightCirc = nullable(parseFloat($('#thighright-txt').val()));
        o.CalfLeftCirc = nullable(parseFloat($('#calfleft-txt').val()));
        o.CalfRightCirc = nullable(parseFloat($('#calfright-txt').val()));
        o.Notes = nullable($('#notes-txt').val());
        o.LastUpdateDateTime = dateForCSharp(new Date());
        o.BMI = nullable($('#bmi-txt').val());
        return o;
    }

    function plicoformToObj(withId = false) {
        var o = {};
        o.Id = withId ? $('#plicometry-id').val() : -1;
        o.Date = dateForCSharp(new Date($('#plicodate-txt').val()));
        o.Email = currentUser;
        o.Pectoral = nullable($('#pectoral-txt').val());
        o.Axillary = nullable($('#axillary-txt').val());
        o.Suprailiac = nullable($('#suprailiac-txt').val());
        o.Abdominal = nullable($('#abdominal-txt').val());
        o.Thigh = nullable($('#thigh-txt').val());
        o.Subscapular = nullable($('#subscapular-txt').val());
        o.Triceps = nullable($('#triceps-txt').val());
        o.Notes = nullable($('#pliconotes-txt').val());
        o.LastUpdateDateTime = dateForCSharp(new Date());
        return o;
    }
    
    function bmi()
    {
        let bmi = null;
        let height = $('#height-txt').val();
        let weight = $('#weight-txt').val();
        if(!isEmpty(weight) && !isEmpty(height))
        {
            let h = parseFloat(height);
            let w = parseFloat(weight);
            bmi = w/(h*h);
            bmi = bmi.toFixed(2);
        }
        $('#bmi-txt').val(bmi);
    }

</script>

<uc1:Foot runat="server" id="Foot"/>