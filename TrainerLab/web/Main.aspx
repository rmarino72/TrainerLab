<%@ Register Src="~/Components/HeadApp.ascx" TagPrefix="uc1" TagName="Head" %>
<%@ Register Src="~/Components/FootApp.ascx" TagPrefix="uc1" TagName="Foot" %>
<uc1:Head runat="server" id="Head"/>
<br/>
<br/>

<div class="col-lg-12">
    <div class="container">
        <div class="card mb-0">
            <a name="top"></a>
            <div class="card-body pt-0">
                <input type="hidden" id="slot-id"/>
                <div class="alert alert-success" role="alert" id="eventDetail">
                    <strong class="h4 mb-0"><span class="material-symbols-outlined">calendar_month</span>&nbsp; Dettaglio evento</strong>
                    <hr/>
                    <div class="row">
                        <div class="col-lg-6">
                            Data: <span id="date-txt">12/12/2022</span>
                        </div>
                        <div class="col-lg-6">
                            Status: <span id="status-txt">LIBERO</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            Ora inizio: <span id="start-txt">10:00</span>
                        </div>
                        <div class="col-lg-6">
                            Ora fine: <span id="end-txt">10:00</span>
                        </div>
                    </div>
                    <hr/>
                    <button type="button" class="btn btn-success" id="book-btn">Prenota</button>
                    <button type="button" class="btn btn-secondary" id="delbooking-btn">Disdici</button>
                    <button type="button" class="btn btn-primary" id="closeevent-btn">Chiudi</button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="col-lg-12" id="mainPg">
    <div class="container">
        <div class="card mb-0">
            <div class="card-header">
                <h3 class="h4 mb-0"><span class="material-symbols-outlined">calendar_month</span>&nbsp; La Tua Agenda</h3>
            </div>
            <div class="card-body pt-0">
                <div class="row">
                    <div id="calendar" class="col-lg-12">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    var currentId = -1;
    function init()
    {
        $('#eventDetail').hide();
        $('#book-btn').hide();
        $('#book-btn').click(book);
        $('#delbooking-btn').hide();
        $('#delbooking-btn').click(free);
        $('#closeevent-btn').click(closeEvent);
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


    function refreshEvents(e) {
        var events = calendar.getEvents();
        events.forEach(e => { e.remove(); });

        var user = getFromStorage(STORAGE_USER);

        var interval = {};

        interval.Start = dateForCSharp(e.start);
        interval.End = dateForCSharp(e.end);

        ajaxCall(SCHEDULER_MYSLOT + user + "/", "POST", JSON.stringify(interval), gotEvents)
    }

    function gotEvents(data)
    {
        
        if (!data.Outcome) {
            alertify.error(data.Message);
            return;
        }
        {
            data.Data.forEach(e => {

                var event = {};
                event.id = e.Id;
                event.start = e.StartDateTime;
                event.end = e.EndDateTime;
                event.title = e.Status;
                event.description = e.FirstName + " " + e.LastName;

                if (e.Status == "FREE") {
                    event.title = "LIBERO";
                    event.backgroundColor = 'green';
                    event.description = "LIBERO";
                }
                if (e.Status == "BOOKED") {
                    event.title = "PRENOTATO";
                    event.backgroundColor = 'red';
                    event.description = "PRENOTATO";
                }
                if (e.Status == "BUSY") {
                    event.title = "Non disponibile";
                    event.backgroundColor = 'gray';
                    event.description = "Non disponibile";
                }
                if (e.Status == "CONFIRMED") {
                    event.title = "CONFERMATO";
                    event.backgroundColor = 'orange';
                    event.description = "CONFERMATO";
                }
                if (e.Status == "DONE") {
                    event.title = "SVOLTO";
                    event.backgroundColor = 'yellow';
                    event.textColor = "black";
                    event.description = "SVOLTO";
                }
                calendar.addEvent(event);
            });
        }
    }

    function editEvent(e)
    {
        $('#book-btn').hide();
        $('#delbooking-btn').hide();
        var id = e.event.id;
        ajaxCall(SCHEDULER_SLOT + id, 'GET', null, gotSlot);
    }

    function gotSlot(data)
    {
        if (!data.Outcome) {
            alertify.error(data.Message);
            return
        }

        
        var event = data.Data;
        currentId = event.Id;
        var status = "";
        var date = italianFormatDate(new Date(event.StartDateTime));
        var start = formatTime(new Date(event.StartDateTime));
        var end = formatTime(new Date(event.EndDateTime));
        $("#date-txt").text(date);
        $("#start-txt").text(start);
        $("#end-txt").text(end);

        if (event.Status == "FREE")
        {
            status = "LIBERO";
            $('#book-btn').show();
        }

        if (event.Status == "BOOKED" || event.Status == "CONFIRMED")
        {
            status = event.Status == "BOOKED" ? "PRENOTATO" : "CONFERMATO";
            $('#delbooking-btn').show();
        }
        $("#status-txt").text(status);
        $('#eventDetail').show();
        var aTag = $("a[name='top']");
        $('html,body').animate({ scrollTop: aTag.offset().top }, 'slow');
    }

    function closeEvent() {
        $('#eventDetail').hide();
    }

    function book()
    {
        var user = getFromStorage(STORAGE_USER);        
        ajaxCall(SCHEDULER_BOOK + user + "/" + currentId, 'POST', null, booked);
    }

    function free() {
        ajaxCall(SCHEDULER_FREE + currentId, 'POST', null, freed);
    }


    function booked(data) {
        if (!data.Outcome) {
            if (data.Code == 1) {
                alertify.error("Evento non piú prenotabile!");
            }
            else {
                alertify.error(data.Message);
            }
            return;
        }

        window.location.reload();
    }

    function freed(data)
    {
        if (!data.Outcome)
        {
            if (data.Code == 1) {
                alertify.error("Evento non piú annullabile!");
            }
            else
            {
                alertify.error(data.Message);
            }
            return;
        }
        
        window.location.reload();
    }
</script>

<uc1:Foot runat="server" id="Foot"/>