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
                <input type="hidden" id="trainingplan-id" />
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
                                <option value="4"> 4 </option>
                            </select>
                        </div>
                    </div>                    
                </div>
                <hr/>
                <div id="day1-div">
                    <h5>Giorno 1</h5>
                    <br/>
                    <button type="button" onclick="addExercise(1);" class="btn btn-primary" id="addday1-btn"><span class="material-symbols-outlined">add</span>&nbsp;Aggiungi</button> &nbsp;
                    <br/>
                    <br/>
                    <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="day1-tbl">
                        <thead>
                            <tr>
                                <th data-field="Id" data-visible="false">#</th>
                                <th data-field="Day" data-visible="false">#</th>
                                <th data-field="SeqNumber" data-visible="false">#</th>
                                <th data-field="ExerciseId" data-visible="false">#</th>
                                <th data-field="ExerciseName">Nome Esercizio</th>
                                <th data-field="Time">Tempo</th>
                                <th data-field="Sequences">Sequenze</th>
                                <th data-field="Repetitions">Ripetizioni</th>
                                <th data-field="ExerciseNotes" data-visible="false">#</th>
                                <th data-field="MuscularGroupId" data-visible="false">#</th>
                            </tr>
                        </thead>
                        <tbody role="button"></tbody>
                    </table>
                    <hr/>
                </div>
                <div id="day2-div">
                    <h5>Giorno 2</h5>    
                    <br/>
                    <button type="button" onclick="addExercise(2);" class="btn btn-primary" id="addday2-btn"><span class="material-symbols-outlined">add</span>&nbsp;Aggiungi</button> &nbsp;
                    <br/>
                    <br/>
                    <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="day2-tbl">
                        <thead>
                            <tr>
                                <th data-field="Id" data-visible="false">#</th>
                                <th data-field="Day" data-visible="false">#</th>
                                <th data-field="SeqNumber" data-visible="false">#</th>
                                <th data-field="ExerciseId" data-visible="false">#</th>
                                <th data-field="ExerciseName">Nome Esercizio</th>
                                <th data-field="Time">Tempo</th>
                                <th data-field="Sequences">Sequenze</th>
                                <th data-field="Repetitions">Ripetizioni</th>
                                <th data-field="ExerciseNotes" data-visible="false">#</th>
                                <th data-field="MuscularGroupId" data-visible="false">#</th>
                            </tr>
                        </thead>
                        <tbody role="button"></tbody>
                    </table>
                    <hr/>
                </div>
                <div id="day3-div">
                    <h5>Giorno 3</h5>    
                    <br/>
                    <button type="button" onclick="addExercise(3);" class="btn btn-primary" id="addday3-btn"><span class="material-symbols-outlined">add</span>&nbsp;Aggiungi</button> &nbsp;
                    <br/>
                    <br/>
                    <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="day3-tbl">
                        <thead>
                            <tr>
                                <th data-field="Id" data-visible="false">#</th>
                                <th data-field="Day" data-visible="false">#</th>
                                <th data-field="SeqNumber" data-visible="false">#</th>
                                <th data-field="ExerciseId" data-visible="false">#</th>
                                <th data-field="ExerciseName">Nome Esercizio</th>
                                <th data-field="Time">Tempo</th>
                                <th data-field="Sequences">Sequenze</th>
                                <th data-field="Repetitions">Ripetizioni</th>
                                <th data-field="ExerciseNotes" data-visible="false">#</th>
                                <th data-field="MuscularGroupId" data-visible="false">#</th>
                            </tr>
                        </thead>
                        <tbody role="button"></tbody>
                    </table>
                    <hr/>
                </div>
                <div id="day4-div">
                    <h5>Giorno 4</h5>    
                    <br/>
                    <button type="button" class="btn btn-primary" onclick="addExercise(4);" id="addday4-btn"><span class="material-symbols-outlined">add</span>&nbsp;Aggiungi</button> &nbsp;
                    <br/>
                    <br/>
                    <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="day4-tbl">
                        <thead>
                            <tr>
                                <th data-field="Id" data-visible="false">#</th>
                                <th data-field="Day" data-visible="false">#</th>
                                <th data-field="SeqNumber" data-visible="false">#</th>
                                <th data-field="ExerciseId" data-visible="false">#</th>
                                <th data-field="ExerciseName">Nome Esercizio</th>
                                <th data-field="Time">Tempo</th>
                                <th data-field="Sequences">Sequenze</th>
                                <th data-field="Repetitions">Ripetizioni</th>
                                <th data-field="ExerciseNotes" data-visible="false">#</th>
                                <th data-field="MuscularGroupId" data-visible="false">#</th>
                            </tr>
                        </thead>
                        <tbody role="button"></tbody>
                    </table>
                    <hr/>
                </div>
                <br/>
                <div class="row">
                    <div class="col-lg-12">
                        <label class="form-label" for="Notes-txt">Note:</label>
                        <textarea id="Notes-txt" class="form-control"></textarea>
                    </div>
                </div>
                <br/>
                <br/>
                <button type="button" class="btn btn-primary" id="cancel-btn"><span class="material-symbols-outlined">arrow_back_ios</span>&nbsp; Indietro</button>
                <button type="submit" class="btn btn-primary"><span class="material-symbols-outlined">done</span>&nbsp; Ok</button> &nbsp;
            </form>
        </div>
    </div>
</div>
<div class="col-lg-12" id="editExercisePg">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">exercise</span>&nbsp; Selezione esercizio</h3>
            </div>
        </div>
        <div class="card-body pt-0">
        
            <form id="editExerciseForm" action="javascript:updateExercise();" method="get">
                <input type="hidden" id="editExerciseId"/>
                <input type="hidden" id="editExerciseName"/>
                <br/>
                <br/>
                <button id="deleteExercise" type="button" class="btn btn-danger"><span class="material-symbols-outlined">delete</span>&nbsp; Elimina dalla lista</button>
                <br/>
                <br/>
                <div class="row">
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
                                 <label class="form-label" for="Exercise-cmb">Esercizio *</label>
                                 <select class="form-control" id="Exercise-cmb" type="text" name="ExerciseTxt" required data-validate-field="ExerciseTxt">
                                     <option value=""> - </option>
                                 </select>
                             </div>
                         </div>
                    </div>
                    <div class="row">&nbsp;</div>
                    <div class="row">
                        <div class="col-lg-4">
                            <img src="/assets/img/fitness.png" width="100%" id="exercise-img"/>
                        </div>
                        <div class="col-lg-8">
                            <label class="form-label" for="exercisedesc-txt">Descrizione esercizio:</label>
                            <textarea class="form-control" id="exercisedesc-txt" readonly="" rows="10"></textarea>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="Time-txt">Durata:</label>
                                <input class="form-control" id="Time-txt" type="text" autocomplete="off">
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="Sequences-txt">Serie:</label>
                                <input class="form-control" id="Sequences-txt" type="text" autocomplete="off">
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="Repetitions-txt">Ripetizioni:</label>
                                <input class="form-control" id="Repetitions-txt" type="text" autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <label class="form-label" for="ExerciseNotes-txt">Note:</label>
                            <textarea id="ExerciseNotes-txt" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
                <br/>
                <br/>
                <button type="button" class="btn btn-primary" id="cancel-exercise-btn"><span class="material-symbols-outlined">arrow_back_ios</span>&nbsp; Indietro</button>
                <button type="submit" class="btn btn-primary"><span class="material-symbols-outlined">done</span>&nbsp; Ok</button> &nbsp;
            </form>
        </div>
    </div>
</div>
<script>
    let editing = false;
    let currentDay = 0;
    let currentMuscularGroup = null;
    let currentExerciseId = null;
    let currentSeqNumber = -1;
    let editingExercise = false;
    function init()
    {
        iAmAdmin();
        
        let rules = {
            MuscularGroupTxt: {
                required: true,
            },
            ExerciseTxt: {
                required: true,
            },
        };
        let messages = {
            MuscularGroupTxt: "Campo obbligatorio",
            ExerciseTxt: "Campo obbligatorio",
        }
    
        validateForm('editExerciseForm', rules, messages);
        
        $('#cancel-list-btn').click(cancelList);
        $('#cancel-btn').click(cancelEdit);
        $('#cancel-exercise-btn').click(cancelExercise);
        $('#deleteExercise').click(deleteExercise);
        $('#listPg').hide();
        $('#editPg').hide();
        $('#editExercisePg').hide();
        $('#days-txt').change(showDays);
        $('#MuscularGroup-cmb').change(selectMuscularGroup);
        $('#Exercise-cmb').change(selectExercise);
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
        ajaxCall(EXERCISEPLAN_TRAININGPLAN_BYUSER + row.Id, 'GET', null, gotList);
    }
    
    function initData()
    {
        let o = {};
        o.day1 = [];
        o.day2 = [];
        o.day3 = [];
        o.day4 = [];
        storeObject(STORAGE_TRAININGPLANDETAIL, o);
    }
    
    function prepareForNew()
    {
        editing = false
        initData();
        showDays();
        $('#deleteExercise').hide();
        $('#listPg').hide();
        $('#editPg').show();
    }
    
    function cancelEdit()
    {
        $('#listPg').show();
        $('#editPg').hide();
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
        
        fillDataTable('listTable', data.Data, editPlan, true);
        $('#listPg').show();
        $('#mainPg').hide();
    }
    
    function cancelList()
    {
        $('#listPg').hide();
        $('#mainPg').show();
    }
    
    function showDays()
    {        
        let d = 0;
        let days = $('#days-txt').val();
        if(!isEmpty(days))  d = parseInt(days);
        if (d > 0) $('#day1-div').show(); else $('#day1-div').hide();
        if (d > 1) $('#day2-div').show(); else $('#day2-div').hide();
        if (d > 2) $('#day3-div').show(); else $('#day3-div').hide();
        if (d > 3) $('#day4-div').show(); else $('#day4-div').hide();
        let tp = getObjectFromStorage(STORAGE_TRAININGPLANDETAIL);
        fillDataTable('day1-tbl', tp.day1, editExercise, true, false);
        fillDataTable('day2-tbl', tp.day2, editExercise, true, false);
        fillDataTable('day3-tbl', tp.day3, editExercise, true, false);
        fillDataTable('day4-tbl', tp.day4, editExercise, true, false);
    }
    
    function addExercise(day)
    {
        editingExercise = false;
        $('#deleteExercise').hide();
        currentDay = day;
        resetForm('editExerciseForm');
        resetSelect('MuscularGroup-cmb');
        ajaxCall(EXERCISEPLAN_MUSCULARGROUP, 'GET', null, gotMuscularGroups);
    }
    
    function gotMuscularGroups(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        $('#MuscularGroup-cmb').append($('<option/>', {
            value: "",
            text: " - "
        }));
        data.Data.forEach(e => {
            $('#MuscularGroup-cmb').append($('<option/>', {
                value: e.Name,
                text: e.Description
            }));
        });
        $('#editPg').hide();
        
        $('#editExercisePg').show();
        if (editingExercise)
        {
            $('#MuscularGroup-cmb').val(currentMuscularGroup);
            selectMuscularGroup();
        }
    }
    
    function cancelExercise()
    {
        $('#editPg').show();
        $('#editExercisePg').hide();
    }
    
    function selectMuscularGroup()
    {
        resetSelect('Exercise-cmb');
        $('#Exercise-cmb').append($('<option/>', {
            value: "",
            text: " - "
        }));
        $('#exercisedesc-txt').val("");
        $('#exercise-img').attr("src", "/assets/img/fitness.png");
        let muscularGroup = $('#MuscularGroup-cmb').val();
        if(!isEmpty(muscularGroup)) ajaxCall(EXERCISEPLAN_EXERCISE_BYMUSCULARGROUP + muscularGroup +"/", 'GET', null, gotExercises);
    }
    
    function gotExercises(data)
    {
         if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        
         data.Data.forEach(e => {
             $('#Exercise-cmb').append($('<option/>', {
                 value: e.Id,
                 text: e.Name
             }));
         });
         if(editingExercise)
         {
            $('#Exercise-cmb').val(currentExerciseId);
            selectExercise();
         }
    }
    
    function selectExercise()
    {
        let id = $('#Exercise-cmb').val();
        $('#exercisedesc-txt').val("");
        $('#exercise-img').attr("src", "/assets/img/fitness.png");
        
        if(!isEmpty(id))
        {
            ajaxCall(EXERCISEPLAN_EXERCISE + id , 'GET', null, gotExerciseDesc);
        }
    }
    
    function gotExerciseDesc(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        let ex = data.Data;
        $('#editExerciseId').val(ex.Id);
        $('#editExerciseName').val(ex.Name);
        $('#exercisedesc-txt').val(ex.Description);
        if(!isEmpty(ex.Path))
        {
            $('#exercise-img').attr("src", "/Images/"+ex.Path);
        }
    }
    
    function formToObj()
    {
        let tp = getObjectFromStorage(STORAGE_TRAININGPLANDETAIL);
        let day = currentDay==1?tp.day1:currentDay==2?tp.day2:currentDay==3?tp.day3:tp.day4;
        let lastSeqNumber = day.length;
        
        let o = {};
        o.Id = editing?parseInt($('#editExerciseId').val()):-1;
        o.ExerciseId = parseInt($('#Exercise-cmb').val());
        o.Repetitions = $('#Repetitions-txt').val();
        o.Sequences = $('#Sequences-txt').val();
        o.Time = $('#Time-txt').val();
        o.MuscularGroupId = $('#MuscularGroup-cmb').val();
        o.ExerciseName = $('#editExerciseName').val();
        o.ExerciseNotes = $('#ExerciseNotes-txt').val();
        o.Day = currentDay;
        o.SeqNumber = editingExercise?currentSeqNumber : lastSeqNumber+1 ;
        return o;
    }        
    
    function updateExercise()
    {
        let ex = formToObj();
        let tp = getObjectFromStorage(STORAGE_TRAININGPLANDETAIL)
        let day = currentDay==1?tp.day1:currentDay==2?tp.day2:currentDay==3?tp.day3:tp.day4;
        if(!editingExercise)
        {
            day.push(ex);
        }
        else
        {
            day[currentSeqNumber - 1] = ex;
        }
        storeObject(STORAGE_TRAININGPLANDETAIL, tp);
        showDays();
        cancelExercise();
    }
    
    function update()
    {
        editingExercise = true;
        let Details = [];
        let tpId = editing?parseInt($('#trainingplan-id').val()):-1;
        let userId = parseInt($('#user-id').val());
        let numOfDays = parseInt($('#days-txt').val())
        let tp = getObjectFromStorage(STORAGE_TRAININGPLANDETAIL);
        for (var d = 1; d<= numOfDays; d++)
        {
            let day = d===1?tp.day1:d===2?tp.day2:d===3?tp.day3:tp.day4;
            day.forEach( e => {
                let o = {};
                o.Id = -1;
                o.TrainingPlanId = tpId;
                o.Day = d;
                o.SeqNumber = e.SeqNumber;
                o.ExerciseId = e.ExerciseId;
                o.Time = e.Time;
                o.Sequences = e.Sequences;
                o.Repetitions = e.Repetitions;
                o.Notes = e.ExerciseNotes;
                Details.push(o);
            });
        }
        let trainingP = {};
        trainingP.Id = tpId;
        trainingP.Details = Details;
        trainingP.Name = $('#name-txt').val();
        trainingP.Description = $('#Notes-txt').val();
        trainingP.Date = dateForCSharp(new Date($('#date-txt').val()));
        trainingP.User = userId;
        
        let method = editing?'PATCH':'POST';
        ajaxCall(EXERCISEPLAN_TRAININGPLAN, method, JSON.stringify(trainingP), edited);
    }
    
    function edited(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        let id = parseInt($('#user-id').val());
        $('#editPg').hide();
        ajaxCall(EXERCISEPLAN_TRAININGPLAN_BYUSER + id, 'GET', null, gotList);
    }
    
    function editPlan(row)
    {
        editing = true;
        ajaxCall(EXERCISEPLAN_TRAININGPLAN + row.Id +'/', 'GET', null, gotPlanForId)
    }
    
    function gotPlanForId(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        initData();
        let tp = getObjectFromStorage(STORAGE_TRAININGPLANDETAIL);
        
        data.Data.forEach(e =>
        {
            let currentDay = e.Day;
            let day = currentDay==1?tp.day1:currentDay==2?tp.day2:currentDay==3?tp.day3:tp.day4;
            let o = {};
            o.Id = e.Id;
            o.ExerciseId = e.ExerciseId;
            o.Repetitions = e.Repetitions;
            o.Sequences = e.Sequences;
            o.Time = e.Time;
            o.MuscularGroupId = e.MuscularGroup;
            o.ExerciseName = e.ExerciseName;
            o.ExerciseNotes = e.Notes;
            o.Day = currentDay;
            o.SeqNumber = e.SeqNumber;
            
            day.push(o);
        });
        
        storeObject(STORAGE_TRAININGPLANDETAIL, tp);
        
        let lastOne = data.Data[data.Data.length - 1];
        $('#trainingplan-id').val(lastOne.TrainingPlanId);
        $('#name-txt').val(lastOne.Name);
        $('#date-txt').val(dateForInput(lastOne.Date));
        $('#days-txt').val(lastOne.Day);
        $('#Notes-txt').val(lastOne.Description);
        showDays();
        $('#listPg').hide();
        $('#editPg').show();
    }
    
    function editExercise(row)
    {
        editingExercise = true;
        resetForm('editExerciseForm');
        $('#deleteExercise').show();
        $('#editExerciseId').val(row.Id);
        currentDay = parseInt(row.Day);
        currentMuscularGroup = row.MuscularGroupId;
        currentExerciseId = row.ExerciseId;
        $('#Time-txt').val(row.Time);
        $('#Sequences-txt').val(row.Sequences);
        $('#Repetitions-txt').val(row.Repetitions);
        $('#ExerciseNotes-txt').val(row.ExerciseNotes);
        currentSeqNumber = parseInt(row.SeqNumber);
        resetSelect('MuscularGroup-cmb');
        ajaxCall(EXERCISEPLAN_MUSCULARGROUP, 'GET', null, gotMuscularGroups);
    }
    
    function deleteExercise()
    {
        alertify.confirm("Rimuovere questo esercizio dall'elenco?", confirmDeleteExercise);          
    }
    
    function confirmDeleteExercise()
    {
        let tp = getObjectFromStorage(STORAGE_TRAININGPLANDETAIL);
        let day = currentDay==1?tp.day1:currentDay==2?tp.day2:currentDay==3?tp.day3:tp.day4;
        day.splice(currentSeqNumber - 1, 1);
        let s = 0;
        day.forEach(e => 
        {
            s++;
            e.SeqNumber = s;
        });
        storeObject(STORAGE_TRAININGPLANDETAIL, tp);
        showDays();
        cancelExercise();
    }
    
</script>
<uc1:Foot runat="server" id="Foot" />

