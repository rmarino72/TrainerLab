//*************************** AJAX

var _success_func = null;
var _success_data = null;
var refreshed_yet = false;

function encode(s) {
    return encodeURIComponent(s).replace(/%20/g, '+');
}
function urlencodeFormData(fd) {
    var s = '';

    for (var pair of fd.entries()) {
        if (typeof pair[1] == 'string') {
            s += (s ? '&' : '') + encode(pair[0]) + '=' + encode(pair[1]);
        }
    }
    return s;
}

function _error(data) {
    if (data.status == 401) {
        alertify.alert("Error", "Session expired!", function () {
            clearStorage();
            window.location = "Login";
            return;
        });
    }

    if (data.status == 404) {
        alertify.error("Page not found!");
    }

    if (data.status == 500) {
        alertify.alert("An internal error has occurred.");
        return;
    }
    else {
        var err_code = "ERROR " + data.status + ": ";
        var resp = JSON.parse(data.responseText);
        if (resp.detail) {
            if (resp.detail[0]) {
                if (resp.detail[0].msg) {
                    alertify.error(err_code + resp.detail[0].msg);
                    return;
                }
            }
            alertify.error(err_code + resp.detail);
            return;
        }
        alertify.error("An error has occurred: " + err_code + data.responseText);
    }
}

function _success(data, status, xhr)
{
    _success_data = data;
    var token = xhr.getResponseHeader('token');
    localStorage["tlab_token"] = token;
    _success_func(_success_data);    
}



function ajaxCall(api, type, data, success, error = _error) {
    var url = api;
    var token = getFromStorage("tlab_token");
    var user = getFromStorage("tlab_user");
    _success_func = success;
    $.ajax({
        url: url,
        contentType: "application/json",
        type: type,
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', "Basic " + btoa(user + ":" + token));
        },
        data: data,
        success: _success,
        error: error
    });
}


//*************************** LOCAL STORAGE

function storeData(key, value) {
    localStorage[key] = value;
}

function storeObject(key, object) {
    storeData(key, JSON.stringify(object));
}

function getFromStorage(key) {
    return localStorage[key];
}

function getObjectFromStorage(key) {
    var data = getFromStorage(key);
    if (!data) {
        return null;
    }
    return JSON.parse(data);
}

function deleteInStorage(key) {
    localStorage.removeItem(key);
}

function clearStorage() {
    localStorage.clear();
}

//********************************* BOOTSTRAP TABLE

function fillDataTable(tableId, data, onClickCB = null, showHeader = false) {
    $('#' + tableId).bootstrapTable('destroy');
    var tableOptions = {
        data: data,
        cardView: false,
        trimOnSearch: false,
        pagination: true,
        search: true,
        pageLength: 25,
        showHeader: showHeader,
    };

    if (onClickCB != null) {
        tableOptions.onClickRow = onClickCB;
    }
    var table = $('#' + tableId).bootstrapTable(tableOptions);
    return table;
}

//************************************* FORMS

function refreshPage() {
    location.reload();
}

function resetForm(formId) {
    $('#' + formId).find("input[type=text], textarea").val("");
    $('#' + formId).find("input[type=number]").val("");
    $('#' + formId).find("input[type=phone]").val("");
    $('#' + formId).find("input[type=date]").val("");
    $('#' + formId).find("input[type=email]").val("");
    $('#' + formId).find("select").val("");
    $('#' + formId).find("input[type=checkbox]").removeAttr("checked");
}

function resetSelect(selectId) {
    $('#' + selectId).empty();
}

/**
* @param {string} str
* @returns {boolean} 
*/
function isEmpty(str) {
    return (!str || 0 === str.length);
}

/**
* @param {string} str 
* @returns {boolean}
*/
function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}

/**
* returns true if email is a valid mail address
* @param {string} email
* @returns {Boolean} 
*/
function validateEmail(email) {
    return (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email));
}

/**
* returns true if value is a valid phone number
* @param {string} value
* @returns {Boolean}
*/
function validatePhoneNumber(value) {
    var phoneno = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im;
    return phoneno.test(value);
}

function isInteger(value) {
    return !isNaN(value) && parseInt(Number(value)) == value && !isNaN(parseInt(value, 10));
}

function isFloat(n) {
    return Number(n) === n && n % 1 !== 0;
}

function pad(n, width, z) {
    z = z || '0';
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

function validateCurrency(value) {
    var regex = /^\d+(?:\.\d{0,2})$/;
    return regex.test(value);
}

function formatPrice(value) {
    var v = value.replace(',', '.');
    if (v == '') {
        return "0.00";
    }
    if (isNaN(v)) {
        return "0.00";
    }
    else {
        return "" + parseFloat(v).toFixed(2);
    }
}


//************************************* DATE TIME

function getLocalDate()
{
    return DateTimeUtils.convertUTCDateToLocalDate(new Date());
}

function convertUTCDateToLocalDate(date)
{
    var newDate = new Date(date.getTime() + date.getTimezoneOffset() * 60 * 1000);
    var offset = date.getTimezoneOffset() / 60;
    var hours = date.getHours();
    newDate.setHours(hours - offset);
    return newDate;
}

function dateForCSharp(date)
{
    return date.toJSON();
}

function italianFormatFullDateTime(date)
{
    var options = { 'weekday': 'long', 'month': '2-digit', 'year': 'numeric', 'day': '2-digit', 'hour': '2-digit', 'minute': '2-digit' };
    return date.toLocaleString('it-IT', options);
}

function italianFormatDateTime(date) {
    var options = { 'day': 'numeric', 'month': '2-digit', 'year': 'numeric', 'day': '2-digit', 'hour': '2-digit', 'minute': '2-digit' };
    return date.toLocaleString('it-IT', options);
}

function italianFormatDate(date)
{
    var options = { 'day': 'numeric', 'month': '2-digit', 'year': 'numeric', 'day': '2-digit' };
    return date.toLocaleString('it-IT', options);
}

function dateForInput(dt)
{
    var date = new Date(dt);
    return "" + date.getFullYear() + "-" + StringUtils.pad(date.getMonth() + 1, 2) + "-" + StringUtils.pad(date.getDate(), 2);
}

function splitDateFormat(dateStr)
{
    return dateStr.split("/").reverse().join("/");
}