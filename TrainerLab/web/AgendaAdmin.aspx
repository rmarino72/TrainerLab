﻿<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head" />

<div class="col-lg-12" id="mainPg">

    <div class="row">
        <div class="col-lg-6">
            <div class="container">
                <div class="row">&nbsp;</div>
                <div class="card mb-0">
                    <div class="card-header">
                        <h3 class="h4 mb-0"><span class="material-symbols-outlined">calendar_month</span>&nbsp; Gestione Agenda</h3>
                    </div>
                    <div class="card-body pt-0">
                        <hr />
                        <button class="btn btn-primary" id="new-btn"><span class="material-symbols-outlined">add</span>&nbsp;Nuovo</button>
                        <hr />

                        <div id="calendar" class="col-lg-12">

                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="container">

                <div class="row">&nbsp;</div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card mb-0">
                            <div class="card-header">
                                <h3 class="h4 mb-0"><span class="material-symbols-outlined">calendar_month</span>&nbsp; Prossimi Appuntamenti</h3>
                            </div>
                            <div class="card-body pt-0">
                                <hr />

                                <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="nextTable">
                                    <thead>
                                        <tr>
                                            <th data-field="Id" data-visible="false">#</th>
                                            <th data-field="FirstName">Nome</th>
                                            <th data-field="LastName">Cognome</th>
                                            <th data-field="Email">Email</th>
                                            <th data-field="StartDateTime">Data e Ora</th>
                                        </tr>
                                    </thead>
                                    <tbody role="button"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">&nbsp;</div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card mb-0">
                            <div class="card-header">
                                <h3 class="h4 mb-0"><span class="material-symbols-outlined">calendar_month</span>&nbsp; Appuntamenti da confermare</h3>
                            </div>
                            <div class="card-body pt-0">
                                <hr />

                                <table class="table mb-0 table-striped table-sm" data-mobile-responsive="true" id="dataTable">
                                    <thead>
                                        <tr>
                                            <th data-field="Id" data-visible="false">#</th>
                                            <th data-field="FirstName">Nome</th>
                                            <th data-field="LastName">Cognome</th>
                                            <th data-field="Email">Email</th>
                                            <th data-field="StartDateTime">Data e Ora</th>
                                        </tr>
                                    </thead>
                                    <tbody role="button"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="editPg">

    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">calendar_month</span>&nbsp; Appuntamento</h3>
            </div>
            <div class="card-body pt-0">
                <form id="editForm" action="javascript:update();" method="get">
                    <hr />
                    <button class="btn btn-primary" type="button" id="delete-btn"><span class="material-symbols-outlined">delete</span>&nbsp;Elimina</button>
                    <hr />
                    <input type="hidden" id="slot-id" />
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="start-txt">Inizio *</label>
                                <input class="form-control" id="start-txt" type="datetime-local" name="startTxt" autocomplete="off" required data-validate-field="startTxt">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-material-group col-lg-12">
                                <label class="form-label" for="start-txt">Fine *</label>
                                <input class="form-control" id="end-txt" type="datetime-local" name="endTxt" autocomplete="off" required data-validate-field="endTxt">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-material-group col-lg-12">
                            <label class="form-label" for="status-cmb">Status *</label>
                            <select class="form-control" id="status-cmb" required name="statusCmb" required data-validate-field="statusCmb">
                                <option value=""> - </option>
                            </select>
                        </div>
                    </div>
                    <div class="row" id="user-row">
                        <div class="input-material-group col-lg-12">
                            <label class="form-label" for="user-cmb">Utente</label>
                            <select id="user-cmb" class="form-control">
                                <option class="form-control" value=""> - </option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-material-group col-lg-12">
                            <label class="form-label" for="description-txt">Annotazioni</label>
                            <textarea class="form-control" id="description-txt"></textarea>
                        </div>
                    </div>
                    <hr />
                    <button class="btn btn-primary" type="button" id="cancel-btn"><span class="material-symbols-outlined">close</span>&nbsp; Annulla</button>
                    <button class="btn btn-primary" type="submit" id="ok-btn"><span class="material-symbols-outlined">done</span>&nbsp; Ok</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>

    var initialized = false;
    var calendar = null;
    var editing = false;
    
    function init()
    {
        iAmAdmin();
        $('#new-btn').click(prepareForNew);
        $('#cancel-btn').click(cancel);
        $('#status-cmb').change(statusChanged);
        $('#user-cmb').select2();
        $('#user-cmb').prop('disabled', 'true');
        $('#editPg').hide();
        $('#delete-btn').click(deleteSlot);


        let rules = {
            startTxt: {
                required: true,
            },
            endTxt: {
                required: true,
            },
            statusCmb: {
                required: true,
            },
        };

        let messages = {
           
            startTxt: "Campo obbligatorio",
            endTxt: "Campo obbligatorio",
            statusCmb: "Campo obbligatorio",
        }

        validateForm('editForm', rules, messages);

        var calendarEl = document.getElementById('calendar');

        var options = {
            themeSystem: 'bootstrap5',
            initialView: 'dayGridMonth',
            height: "auto",
            locale: 'it',
            headerToolbar: {
                left: 'dayGridMonth,timeGridWeek,timeGridDay',
                center: 'title',
                right: null
            },
            footerToolbar: {
                left: 'prevYear,prev,today,next,nextYear',               
            },
            buttonText:
            {
                today: 'oggi',
                month: 'mese',
                week: 'settimana',
                day: 'giorno',
                list: 'lista'
            },
            datesSet: refreshEvents,
            eventClick: editEvent
        };

        calendar = new FullCalendar.Calendar(calendarEl, options);
        calendar.render();
        
    }

    function statusChanged()
    {
        var status = $('#status-cmb').val();
        if (status == '' || status == 'BUSY' || status == 'FREE') {
            $('#user-cmb').val('');
            $('#user-cmb').trigger('change');
            $('#user-cmb').prop('disabled', 'true');
        }
        else
        {
            $('#user-cmb').removeAttr('disabled');
        }
    }

    function deleteSlot() {
        alertify.confirm('Elimina appuntamento', 'Eliminare questo appuntamento?', confirmDelete, null);
    }

    function confirmDelete()
    {
        var id = $('#slot-id').val();
        ajaxCall(SCHEDULER_SLOT + id, 'DELETE', null, done);
    }

    function gotStatuses(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        data.Data.forEach(e => {
            $('#status-cmb').append($('<option/>', {
                value: e.Name,
                text: e.LabelIT
            }));
        });

        ajaxCall(USER_FULL, 'GET', null, gotUsers);
    }

    function gotUsers(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        data.Data.forEach(e => {

            var n = e.FirstName + " " + e.LastName;

            $('#user-cmb').append($('<option/>', {
                text: n.padEnd(40) + " - " + e.Email.padEnd(40) + " - " + italianFormatDate(new Date(e.BirthDate)),
                value: e.Email
            }));
        });
    }

    function refreshEvents(e)
    {
        var events = calendar.getEvents();
        events.forEach(e => { e.remove(); });

        var interval = new Object();

        interval.Start = dateForCSharp(e.start);
        interval.End = dateForCSharp(e.end);

        ajaxCall(SCHEDULER_SLOT, "POST", JSON.stringify(interval), gotEvents)
    }

    function editEvent(e)
    {
        var id = e.event.id;
        ajaxCall(SCHEDULER_SLOT + id, 'GET', null, gotSlot);
    }

    function gotSlot(data)
    {
        if (!data.Outcome)
        {
            alertify.error(data.Message);
            return
        }

        editing = true;
        resetForm("editForm");
        var event = data.Data;

        $('#slot-id').val(event.Id);
        $('#start-txt').val(event.StartDateTime);
        $('#end-txt').val(event.EndDateTime);
        $('#status-cmb').val(event.Status);
        $('#status-cmb').trigger('change');
        if (event.Email != null && !isEmpty(event.Email)) {
            $('#user-cmb').val(event.Email);
            $('#user-cmb').trigger('change');
        }
        
        $('#description-txt').val(event.Description);

        if (event.Status == "DONE")
        {
            $('#start-txt').attr("disabled", "true");
            $('#end-txt').attr("disabled", "true");
            $('#status-cmb').prop("disabled", "true");
            $('#user-cmb').prop("disabled", "true");
            $('#description-txt').attr("disabled", "true");
            $("#ok-btn").hide();
            $("#delete-btn").hide();
        }

        $('#editPg').show();
        $('#delete-btn').show();
        $('#mainPg').hide();
    }

    function gotEvents(data)
    {
        if (!data.Outcome)
        {
            alertify.error(data.Message);
            return;
        }
        
        data.Data.forEach(e => {

            var event = new Object();
            event.id = e.Id;
            event.start = e.StartDateTime;
            event.end = e.EndDateTime;
            event.title = e.Status;
            event.description = e.FirstName + " " + e.LastName;

            if (e.Status == "FREE")
            {
                event.title = "Libero";
                event.backgroundColor = 'green';
                event.description = "Libero";
            }
            if (e.Status == "BOOKED") {
                event.title = e.FirstName + " " + e.LastName;
                event.backgroundColor = 'red';
                event.description = e.Email;
            }
            if (e.Status == "BUSY") {
                event.title = "Non disponibile";
                event.backgroundColor = 'gray';
                event.description = e.Email;
            }
            if (e.Status == "CONFIRMED") {
                event.title = e.FirstName + " " + e.LastName;
                event.backgroundColor = 'orange';
                event.description = e.Email;
            }
            if (e.Status == "DONE") {
                event.title = e.FirstName + " " + e.LastName;
                event.backgroundColor = 'yellow';
                event.textColor = "black";
                event.description = e.Email;
            }
            calendar.addEvent(event);
        });
        
        ajaxCall(SCHEDULER_SLOT_BOOKED, 'GET', null, gotBooked);
    }


    function gotBooked(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }

        data.Data.forEach(e => {
            e.StartDateTime = italianFormatDateTime(new Date(e.StartDateTime));
        });

        fillDataTable('dataTable', data.Data, toConfirm, true);

        ajaxCall(SCHEDULER_SLOT_CONFIRMED, 'GET', null, gotConfirmed);

    }

    function gotConfirmed(data) {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }

        data.Data.forEach(e => {
            e.StartDateTime = italianFormatDateTime(new Date(e.StartDateTime));
        });

        fillDataTable('nextTable', data.Data, toConfirm, true);

        if (!initialized) {
            initialized = true;
            ajaxCall(SCHEDULER_SLOT_STATUS, 'GET', null, gotStatuses);
        }
    }

    function toConfirm(row)
    {
        var id = row.Id;
        ajaxCall(SCHEDULER_SLOT + id, 'GET', null, gotSlot);
    }

    function prepareForNew() {
        editing = false;
        resetForm("editForm");
        $('#editPg').show();
        $('#delete-btn').hide();
        $('#mainPg').hide();
    }

    function formToObj(withId = false) {
        var o = new Object();
        o.Id = withId ? $('#slot-id').val() : -1;
        o.StartDateTime = dateForCSharp(new Date($('#start-txt').val()));
        o.EndDateTime = dateForCSharp(new Date($('#end-txt').val()));
        o.Status = $('#status-cmb').val();
        o.Email = isEmpty($('#user-cmb').val()) ? null : $('#user-cmb').val();
        o.Description = $('#description-txt').val();
        return o;
    }

    function cancel()
    {
        window.location.reload();
    }

    function update()
    {
        var slot = formToObj(editing);
        if (!editing)
        {
            
            ajaxCall(SCHEDULER_SLOT, 'PUT', JSON.stringify(slot), done);
        }
        else
        {
            ajaxCall(SCHEDULER_SLOT, 'PATCH', JSON.stringify(slot), done);
        }
    }

    function done(data)
    {
        if (!data.Outcome)
        {
            if (data.Code == 1) {
                alertify.error("L'appuntamento si sovrappone ad altri");
            }
            else if (data.Code == 2) {
                alertify.error("Un appuntamento svolto non puó essere eliminato!");
            }
            else if (data.Code == 4) {
                alertify.error("Un appuntamento svolto non puó essere modificato!");
            }
            else
            {
                alertify.error(data.Message);
            }
            return;
        }
        cancel();
    }


</script>
<uc1:Foot runat="server" id="Foot" />