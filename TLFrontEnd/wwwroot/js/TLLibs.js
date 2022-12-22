function refreshUserName(){
    var user = getFromStorage(STORAGE_USER);
    ajaxCall(USER_FULL + user, 'GET', null, gotMyUser);
}

function gotMyUser(data) {

    if (!data.Outcome) {
        alertify.error(data.Message);
        return;
    }
    storeObject(STORAGE_USER_DATA, data.Data);
    $('#userFirstLast').html(data.Data.FirstName + " " + data.Data.LastName);
    if (data.Data.Role != "ADMIN") 
    {
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

function iAmAdmin()
{
    var user_data = getObjectFromStorage(STORAGE_USER_DATA);
    if (user_data.Role != "ADMIN")
    {
        storeData(STORAGE_ERROR, "Non sei autorizzato a vedere questa pagina!");
        window.location.href = "Error";
    }
}