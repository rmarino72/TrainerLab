function refreshUserName(){
    var user = getFromStorage(STORAGE_USER);
    ajaxCall(USER_FULL + user, 'GET', null, gotMyUser);
}

function gotMyUser(data) {
    console.log(JSON.stringify(data));
    $('#userFirstLast').html(data.data.firstName + " " + data.data.lastName);
    if (data.data.role != "ADMIN") 
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