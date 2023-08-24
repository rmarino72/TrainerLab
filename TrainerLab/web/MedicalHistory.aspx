<%@ Page Language="C#" CodeBehind="MedicalHistory.aspx.cs" Inherits="TrainerLab.web.MedicalHistory" %>
<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>
<br/>

<div class="col-lg-12" id="mainPg">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">monitor_weight</span>&nbsp; Anamnesi </h3>
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
            <div class="col-lg-12">
                <br/>

                <div class="card mb-0">
                    <div class="card-header">
                        <h3 class="h4 mb-0"><span class="material-symbols-outlined">monitor_weight</span>&nbsp;Schede Antropometriche </h3>
                    </div>

                    <div class="card-body pt-0">
                        <button type="button" class="btn btn-primary" id="new-btn"><span class="material-symbols-outlined">add</span>&nbsp; Nuovo</button> &nbsp;
                        <hr/>
                        <div class="table-responsive">
                            <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="listTable">
                                <thead>
                                <tr>
                                    <th data-field="Id" data-visible="false">#</th>
                                    <th data-field="Name">Nome Scheda</th>
                                    <th data-field="DateTime">Data e Ora</th>
                                </tr>
                                </thead>
                                <tbody role="button"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <hr />
            <div class="col-lg-12 container-fluid">
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
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Spalle</strong>
                        <canvas id="shoulderChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Torace</strong>
                        <canvas id="chestChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Vita</strong>
                        <canvas id="bellyChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Fianchi</strong>
                        <canvas id="hipsChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Braccio sinistro</strong>
                        <canvas id="armLChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Braccio destro</strong>
                        <canvas id="armRChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Coscia sinistra</strong>
                        <canvas id="thighLChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Coscia destra</strong>
                        <canvas id="thighRChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Poplaccio sinistro</strong>
                        <canvas id="calfLChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Polpaccio Destro</strong>
                        <canvas id="calfRChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <hr/>
        
        <h3> Valutazioni</h3>
        <div class="row">
            <div class="col-lg-6 container-fluid">
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
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Pettorale</strong>
                        <canvas id="pectoralChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Ascellare</strong>
                        <canvas id="axillaryChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Sopra Iliaca</strong>
                        <canvas id="suprailiacChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Addominale</strong>
                        <canvas id="abdominalChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Coscia</strong>
                        <canvas id="thighChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
                <br/>
                <div class="card">
                    <div class="card-body">
                        <strong>Subscapolare</strong>
                        <canvas id="subscapularChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 container-fluid">
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
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">monitor_weight</span>&nbsp; Scheda Antropometrica <span id="user2-txt"></span></h3>
            </div>
            <div class="card-body pt-0">
                <form id="editForm" method="get" action="javascript:update();">
                    <button class="btn btn-primary" type="button" id="delete-btn"><span class="material-symbols-outlined">delete</span>&nbsp; Elimina</button>
                    &nbsp;
                    <button class="btn btn-primary" type="button" id="preview-btn" onclick="preview()"><span class="material-symbols-outlined">preview</span>&nbsp; Anteprima</button>
                    <input type="hidden" id="medicalAnthropometryId"/>
                    <div class="row">
                         <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="name-txt">Nome Scheda *</label>
                                <input class="form-control" id="name-txt" type="text" name="nameTxt" required data-validate-field="nameTxt">
                            </div>
                        </div>
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
                                <input class="form-control" id="height-txt" type="number" name="heightTxt"  data-validate-field="heightTxt">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="weight-txt">Peso in kg.</label>
                                <input class="form-control" id="weight-txt" type="number" name="weightTxt"  data-validate-field="weightTxt">
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
                    <hr/>
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
                    <hr/>
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
                                <label class="form-label" for="notes-txt">note </label>
                                <textarea id="notes-txt" class="form-control"></textarea>
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <button class="btn btn-primary" type="button" id="cancel-btn"><span class="material-symbols-outlined">close</span>&nbsp; Chiudi</button>
                    <button class="btn btn-primary" type="submit" ><span class="material-symbols-outlined">save</span>&nbsp; Salva</button>
                    
                    
                </form>
            </div>
        </div>
    </div>
</div>

<div id="previewPg" class="col-lg-12">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">preview</span>&nbsp; Anteprima Scheda Plicometria - <span id="prev-user-txt"></span></h3>
            </div>
        </div>
        <div class="card-body pt-0">
            <br/>
            <br/>
            <h3>Misure:</h3><br/>
            <br/>
            <table>
                <tr><td>Altezza (m.):         </td><td>&nbsp;&nbsp;<span id="m0"></span></td></tr>
                <tr><td>Peso (kg.):           </td><td>&nbsp;&nbsp;<span id="m1"></span></td></tr>
                <tr><td>&nbsp;                </td><td>&nbsp;&nbsp;<span></span></td></tr>
                <tr><td>BMI Calcolato:        </td><td>&nbsp;&nbsp;<span id="m2"></span></td></tr>
            </table>
            <br/>
            <br/>
            <b>MISURE CIRCONFERENZE (cm.)</b><br/>
            <table>
                <tr><td>Spalle:      </td><td>&nbsp;&nbsp;<span id="c0"></span></td></tr>
                <tr><td>Torace:      </td><td>&nbsp;&nbsp;<span id="c1"></span></td></tr>
                <tr><td>Vita:        </td><td>&nbsp;&nbsp;<span id="c2"></span></td></tr>
                <tr><td>Fianchi:     </td><td>&nbsp;&nbsp;<span id="c3"></span></td></tr>
                <tr><td>Braccio Sx:  </td><td>&nbsp;&nbsp;<span id="c4"></span></td></tr>
                <tr><td>Braccio Dx:  </td><td>&nbsp;&nbsp;<span id="c5"></span></td></tr>
                <tr><td>Coscia Sx:   </td><td>&nbsp;&nbsp;<span id="c6"></span></td></tr>
                <tr><td>Coscia Dx:   </td><td>&nbsp;&nbsp;<span id="c7"></span></td></tr>
                <tr><td>Polpaccio Sx:</td><td>&nbsp;&nbsp;<span id="c8"></span></td></tr>
                <tr><td>Polpaccio Dx:</td><td>&nbsp;&nbsp;<span id="c9"></span></td></tr>
            </table>
            <br/>
            <br/>
            <h3>Plicometriche:</h3><br/>
            <br/>
            <b>MISURE PLICHE (mm.)</b><br/>
            <br/>
            <table>
            <tr><td>Pettorale:      </td><td>&nbsp;&nbsp;<span id="pl0"></span></td></tr>
            <tr><td>Ascellare:      </td><td>&nbsp;&nbsp;<span id="pl1"></span></td></tr>
            <tr><td>Sopra iliaca:   </td><td>&nbsp;&nbsp;<span id="pl2"></span></td></tr>
            <tr><td>Addominale:     </td><td>&nbsp;&nbsp;<span id="pl3"></span></td></tr>
            <tr><td>Coscia:         </td><td>&nbsp;&nbsp;<span id="pl4"></span></td></tr>
            <tr><td>Subscapolare:   </td><td>&nbsp;&nbsp;<span id="pl5"></span></td></tr>
            <tr><td>Tricipite:      </td><td>&nbsp;&nbsp;<span id="pl6"></span></td></tr>
            </table>
            <canvas id="plicoChart"></canvas>
            <br/>
            <br/>
            <h3>Percentuali corporee:</h3>
            <br/>
            <b>Massa magra: <span id="perc1"></span>%</b><br/>
            <b>Massa grassa <span id="perc0"></span>%</b><br/>
            <canvas id="percentagePie"></canvas>
            
            <hr/>
            <button class="btn btn-primary" type="button" id="prev-cancel-btn"><span class="material-symbols-outlined">close</span>&nbsp; Chiudi</button>
            <button class="btn btn-primary" type="button" id="print-btn" onclick="print()"><span class="material-symbols-outlined">print</span>&nbsp; Stampa</button>
        </div>
    </div>
</div>

<script>

let currentUser = null;
let editing = false;
let changed = false;

let rules = {
        nameTxt: {
            required: true,
        },   
        dateTxt: {
            required: true,
        }
    };
    let messages = {
        nameTxt: "Il nome della scheda &egrave; obbligatorio",
        dateTxt: "Inserire una data ed un'ora valida",
        heightTxt: "Inserire un valore di altezza valido",
        weightTxt: "Inserire un valore di peso",
    }

    function emptyFunction()
    {}
function init()
{
    iAmAdmin();

    validateForm('editForm', rules, messages);
    
    $('#cancel-list-btn').click(refreshPage);
    $('#cancel-btn').click(cancel);
    $('#new-btn').click(prepareForNew);
    $('#delete-btn').click(deleteMA);
    $('#prev-cancel-btn').click(previewCancel);
    $('#listPg').hide();
    $('#editPg').hide();
    $('#previewPg').hide();
    
    $('#name-txt').on('change keyup paste', change);
    $('#medicalAnthropometryId').on('change keyup paste', change);   
    $('#date-txt').on('change keyup paste', change);
    $('#shoulder-txt').on('change keyup paste', change);
    $('#belly-txt').on('change keyup paste', change);
    $('#chest-txt').on('change keyup paste', change);
    $('#hips-txt').on('change keyup paste', change);
    $('#armleft-txt').on('change keyup paste', change);
    $('#armright-txt').on('change keyup paste', change);
    $('#thighleft-txt').on('change keyup paste', change);
    $('#thighright-txt').on('change keyup paste', change);
    $('#calfleft-txt').on('change keyup paste', change);
    $('#calfright-txt').on('change keyup paste', change);
    $('#bmi-txt').on('change keyup paste', change);
    $('#plicometry-id').on('change keyup paste', change);
    $('#pectoral-txt').on('change keyup paste', change);
    $('#axillary-txt').on('change keyup paste', change);
    $('#suprailiac-txt').on('change keyup paste', change);
    $('#abdominal-txt').on('change keyup paste', change);
    $('#thigh-txt').on('change keyup paste', change);
    $('#subscapular-txt').on('change keyup paste', change);
    $('#triceps-txt').on('change keyup paste', change);
    $('#notes-txt').on('change keyup paste', change);
    
    $("#weight-txt").on('change keyup paste', bmi);
    $("#height-txt").on('change keyup paste', bmi);
            
    ajaxCall(USER_FULL, 'GET', null, gotUsers);
}

function change()
{
    changed = true;
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

function updateListPage(r) {
    let email = r.Email;
    currentUser = email;
    ajaxCall(USER_MEDICALANTHROPOMETRY + email + "/", 'GET', null, gotList);
}

function gotList(data)
{
    if (!data.Outcome) {
        alertify.error(data.Message);
        return;
    }
    
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
    
    data.Data.forEach(e => {
        let dtTmp = new Date(e.DateTime);
        e.DateTime = italianFormatDateTime(dtTmp);
        
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
        bmiData.push(e.Bmi);
        pectoralData.push(e.Pectoral);
        axillaryData.push(e.Axillary);
        suprailiacData.push(e.Suprailiac);
        abdominalData.push(e.Abdominal);
        thighData.push(e.Thigh);
        subscapualrData.push(e.Subscapular);
        tricepsData.push(e.Triceps);
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
    fillChart('pectoralChart', 'kg.', labels.slice(-15), pectoralData.slice(-15));
    fillChart('axillaryChart', 'kg.', labels.slice(-15), axillaryData.slice(-15));
    fillChart('suprailiacChart', 'kg.', labels.slice(-15), suprailiacData.slice(-15));
    fillChart('abdominalChart', 'kg.', labels.slice(-15), abdominalData.slice(-15));
    fillChart('thighChart', 'kg.', labels.slice(-15), thighData.slice(-15));
    fillChart('subscapularChart', 'kg.', labels.slice(-15), subscapualrData.slice(-15));
    fillChart('tricepsChart', 'kg.', labels.slice(-15), tricepsData.slice(-15));
    
    fillDataTable('listTable', data.Data.reverse(), prepareForEdit, true);
    ajaxCall(USER_FULL + currentUser + "/", 'GET', null, gotUser);
}

function gotUser(data) {

    if (!data.Outcome) {
        alertify.error(data.Message);
        return;
    }
    $('#user-txt').text(data.Data.FirstName + " " + data.Data.LastName);
    $('#user2-txt').text(data.Data.FirstName + " " + data.Data.LastName);
    $('#prev-user-txt').text(data.Data.FirstName + " " + data.Data.LastName);
    $('#mainPg').hide();
    $('#listPg').show();
    $('#editPg').hide();

}

function prepareForEdit(r)
{
    changed = false;
    $('#delete-btn').show();
    $('#preview-btn').show();
    $('#name-txt').attr("readonly", "true");
    $('#date-txt').attr("readonly", "true");
    editing = true;
    ajaxCall(USER_MEDICALANTHROPOMETRY + currentUser + "/" + r.Id +"/", "GET", null, gotAnthropometry);
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
    $('#name-txt').val(o.Name);
    $('#medicalAnthropometryId').val(o.Id);
    $('#height-txt').val(o.Height);
    $('#date-txt').val(o.DateTime);
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
    $('#bmi-txt').val(o.Bmi);
    $('#plicometry-id').val(o.Id);
    $('#pectoral-txt').val(o.Pectoral);
    $('#axillary-txt').val(o.Axillary);
    $('#suprailiac-txt').val(o.Suprailiac);
    $('#abdominal-txt').val(o.Abdominal);
    $('#thigh-txt').val(o.Thigh);
    $('#subscapular-txt').val(o.Subscapular);
    $('#triceps-txt').val(o.Triceps);
    $('#notes-txt').val(o.Notes);
    $('#editPg').show();
    $('#listPg').hide();
}

function prepareForNew()
{
    changed = false;
    editing = false;
    $('#name-txt').removeAttr("readonly");
    $('#date-txt').removeAttr("readonly");
    $('#delete-btn').hide();
    $('#preview-btn').hide();
    resetForm('editForm');
    ajaxCall(USER_FULL + currentUser + "/", "GET", null, readyForNew);
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

function formToObj(withId=false)
    {
        var o = {};
        o.Id = withId ? parseInt($('#medicalAnthropometryId').val()) : -1;
        o.Name = $('#name-txt').val();
        o.Height = nullable(parseFloat($('#height-txt').val()));
        o.Mail = currentUser;
        o.DateTime = dateForCSharp(new Date($('#date-txt').val()));
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
        o.Pectoral = nullable(parseFloat($('#pectoral-txt').val()));
        o.Axillary = nullable(parseFloat($('#axillary-txt').val()));
        o.Suprailiac = nullable(parseFloat($('#suprailiac-txt').val()));
        o.Abdominal = nullable(parseFloat($('#abdominal-txt').val()));
        o.Thigh = nullable(parseFloat($('#thigh-txt').val()));
        o.Subscapular = nullable(parseFloat($('#subscapular-txt').val()));
        o.Triceps = nullable(parseFloat($('#triceps-txt').val()));
        o.Notes = $('#notes-txt').val();
        o.LastUpdateDateTime = dateForCSharp(new Date());
        o.Bmi = nullable(parseFloat($('#bmi-txt').val()));
        return o;
    }
    
    function confirmCancel()
    {
        var r = {};
        changed = false;
        r.Email = currentUser;
        updateListPage(r);
    }
    
    function cancel()
    {
        if(!changed) 
            confirmCancel();
        else 
            alertify.confirm("Annulla", "Sono state apportate delle modifiche. Annullare comunque?", confirmCancel, null);
    }
    
    function update()
    {
        let a = formToObj(editing);
        let method = editing?'patch':'post';
        ajaxCall(USER_MEDICALANTHROPOMETRY, method, JSON.stringify(a), updated);
    }
    
    function bmi()
    {
        change();
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
    
    function updated(data) {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        var r = {};
        changed = false;
        let id = data.Data.Id;
        $('#medicalAnthropometryId').val(id);
        editing = true;
        $('#delete-btn').show();
        $('#preview-btn').show();
        $('#name-txt').attr("readonly", "true");
        $('#date-txt').attr("readonly", "true");
        alertify.success("Modifiche salvate con successo");
    }
    
    function deleteMA()
    {
        alertify.confirm("Elimina", "Vuoi elminiare questa scheda definitivamente?", confirmDelete, null);
    }
    
    function confirmDelete()
    {
        let id = $('#medicalAnthropometryId').val();
        ajaxCall(USER_MEDICALANTHROPOMETRY + id, 'delete', null, deleted);
    }
    
    function deleted(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        let r = {};
        r.Email = currentUser;
        updateListPage(r);
    }

    function preview()
    {
        if(!changed)
            doPreview();
        else
            alertify.confirm("Anteprima", "I dati modificati saranno prima salvati. Continuare?", save, null);
    }
        
    function save()
    {        
        var a = formToObj(true);
        ajaxCall(USER_MEDICALANTHROPOMETRY, 'PATCH', JSON.stringify(a), doPreview);
    }
    
    function doPreview()
    {
        changed = false;
        $('#editPg').hide();
        $('#previewPg').show();
        
        $('#m0').html($('#height-txt').val());
        $('#m1').html($('#weight-txt').val());
        $('#m2').html($('#bmi-txt').val());
        
        $('#c0').html($('#shoulder-txt').val());
        $('#c1').html($('#chest-txt').val());
        $('#c2').html($('#belly-txt').val());
        $('#c3').html($('#hips-txt').val());
        $('#c4').html($('#armleft-txt').val());
        $('#c5').html($('#armright-txt').val());
        $('#c6').html($('#thighleft-txt').val());
        $('#c7').html($('#thighright-txt').val());
        $('#c8').html($('#calfleft-txt').val());
        $('#c9').html($('#calfright-txt').val());
        
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
        $('#pl0').html(data[0]);
        $('#pl1').html(data[1]);
        $('#pl2').html(data[2]);
        $('#pl3').html(data[3]);
        $('#pl4').html(data[4]);
        $('#pl5').html(data[5]);
        $('#pl6').html(data[6]);
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
        chartData.push((100 - data.Data.FatPercentage).toFixed(2));
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
        $('#perc1').html(chartData[1]);
        $('#perc0').html(chartData[0]);
    }
    
    function previewCancel()
    {
        $('#editPg').show();
        $('#previewPg').hide();
    }
    
    function print()
    {
        let id = $('#medicalAnthropometryId').val();
        ajaxCall(USER_PRINTANTHRO + id, 'get', null, printed);
    }
    
    function printed(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        window.open("/Tmp/"+data.Message);
    }
    
</script>
<uc1:Foot runat="server" id="Foot"/>