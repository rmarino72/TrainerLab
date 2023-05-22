function refreshUserName() {
    var user = getFromStorage(STORAGE_USER);
    ajaxCall(USER_FULL + encodeURIComponent(user) + "/", 'GET', null, gotMyUser);
}

function gotMyUser(data) {

    if (!data.Outcome) {
        alertify.error(data.Message);
        return;
    }
    storeObject(STORAGE_USER_DATA, data.Data);
    $('#userFirstLast').html(data.Data.FirstName + " " + data.Data.LastName);
    if (data.Data.Role != "ADMIN") {
        $('#adminTitle').hide();
        $('#adminMenu').hide();
    }
    init();
}

function validateForm(formId, rules, messages) {
    let form = document.querySelector("#" + formId);
    new window.JustValidate("#" + formId, {
        rules: rules,
        messages: messages,
        invalidFormCallback: function () {
            let errorInputs = document.querySelectorAll("#" + formId + " input[required]");
            bsValidationBehavior(errorInputs, form);
            form.addEventListener("keyup", () => bsValidationBehavior(errorInputs, form));
        },
    });
}

function iAmAdmin() {
    var user_data = getObjectFromStorage(STORAGE_USER_DATA);
    if (user_data.Role != "ADMIN") {
        storeData(STORAGE_ERROR, "Non sei autorizzato a vedere questa pagina!");
        window.location.href = "Error";
    }
}

function fillChart(elem, title, labels, data) {
    var chart = new Chart($('#' + elem), {
        type: 'line',
        options: {

            legend: {
                display: false,
            },
        },
        data: {

            labels: labels,
            datasets: [
                {
                    fill: true,
                    lineTension: 0.3,
                    backgroundColor: "transparent",
                    borderColor: "#CF53F9",
                    pointBorderColor: "#CF53F9",
                    pointHoverBackgroundColor: "#CF53F9",
                    borderCapStyle: "butt",
                    borderDash: [],
                    borderDashOffset: 0.0,
                    borderJoinStyle: "miter",
                    borderWidth: 2,
                    pointBackgroundColor: "#CF53F9",
                    pointBorderWidth: 2,
                    pointHoverRadius: 4,
                    pointHoverBorderColor: "#fff",
                    pointHoverBorderWidth: 0,
                    pointRadius: 1,
                    pointHitRadius: 0,
                    label: title,
                    spanGaps: false,
                    data: data
                }

            ]
        }

    });
}