<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>


<br/>
<div class="container">

    <h3><span class="material-symbols-outlined">clinical_notes</span>&nbsp; Anamnesi personale </h3>

    <div class="row">
        <div class="col-lg-6 container-fluid">
            <br/>
            <div class="card">
                <div class="card-body">
                    <strong>
                        <span id="user-txt"></span>
                    </strong><br/>
                    <br/>
                    Email: <span id="email-txt"></span><br/>
                    <br/>
                    Et&agrave;: <span id="age-txt"></span><br/>
                    <br/>
                    Altezza m.: <span id="height-txt"></span>
                </div>
            </div>
        </div>
        <div class="col-lg-6 container-fluid">
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

<script>
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
        let user = getFromStorage(STORAGE_USER);
        ajaxCall(USER_FULL + user +"/", 'GET', null, gotUser);
    }

    function gotUser(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        $('#user-txt').text(data.Data.FirstName + " " + data.Data.LastName);
        $('#email-txt').text(data.Data.Email);
        $('#age-txt').text(data.Data.Age);
        $('#height-txt').text(data.Data.Height);
        ajaxCall(USER_ANTHROPOMETRY + data.Data.Email + "/", 'GET', null, gotList);
    }


    function gotList(data) 
    {

        if (!data.Outcome) 
        {
            alertify.error(data.Message);
            return;
        }
        let dt = data.Data;

        dt.forEach(e => {
            let dtTmp = new Date(e.Date);

            labels.push(dtTmp.getDate() + "/" + (dtTmp.getMonth() + 1));
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
        let user = getFromStorage(STORAGE_USER);
        ajaxCall(USER_PLICOMETRY + user + "/", 'GET', null, gotPlicoList);
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
</script>
<uc1:Foot runat="server" id="Foot"/>