var tokenKey = 'accessToken';


//Minions
function ShowMinionList() {

    var token = sessionStorage.getItem(tokenKey);
    var headers = {};
    if (token) {
        headers.Authorization = 'Bearer ' + token;
    }

    $.ajax({
        url: '/clients/',
        dataType: "html",
        type: 'GET',
        headers: headers,
        success: function (data) {
            $('#sec_minionList').html(data);
           
        },
        fail: function () {
            $('#sec_minionList').html("<h3>Login into the application to view the resources</h1>");
        }
    });
}

ShowMinionList();


function ShowMinionDetail(id) {

    var token = sessionStorage.getItem(tokenKey);
    var headers = {};
    if (token) {
        headers.Authorization = 'Bearer ' + token;
    }

    $.ajax({
        url: '/clients/Details/',
        dataType: "html",
        type: 'GET',
        data: { id: id },
        headers: headers,
        success: function (data) {
            $('#sec_MinionViewholder').html(data);
            ShowJobs();
            NewJob(id);
        },
        fail: function () {
            $('#sec_MinionViewholder').html("<h3>Error loading the view</h3>");
        }
    });
}



function CheckIfMinionOnline(id, domElement) {

    var token = sessionStorage.getItem(tokenKey);
    var headers = {};
    if (token) {
        headers.Authorization = 'Bearer ' + token;
    }

    var ctype;

    $.ajax({
        url: '/clients/ProbeMinion/',
        dataType: "json",
        type: 'GET',
        data: { id: id },
        headers: headers,
        success: function (data) {

            var onlineStatus = data[0] == "OK" ? "label label-success" : "label label-warning";
            var connectionType;

            if (data[1] == "CommEthernetIp") {
                connectionType = "Ethernet";
            }
            else if (data[1] == "CommWireless80211Ip") {
                connectionType = "Wireless";
            }
            else {
                connectionType = "No Connection";
            }
            ctype = connectionType;
            var d = "#" + domElement;
            $(d).parent().find(".status").html("<span class='" + onlineStatus + "'>"+ connectionType + "</span>")

            console.log("Minion online");

        },
        fail: function () {
            console.log("Minion offline");
        }
    });

    return ctype;
}

//User
function LogOut() {

    var token = sessionStorage.getItem(tokenKey);
    var headers = {};
    if (token) {
        headers.Authorization = 'Bearer ' + token;
    }

    $.ajax({
        type: 'POST',
        url: '/api/Account/Logout',
        async: true,
        headers: headers
    }).done(function (data) {
        // Successfully logged out. Delete the token.
        self.user('');
        sessionStorage.removeItem(tokenKey);
        location.reload(true);
    }).fail(showError);

   
}

//Jobs
function ShowJobs(reset) {

    if (reset) {
        $('#sec_cliJobs').html("");
    }

    var token = sessionStorage.getItem(tokenKey);
    var headers = {};
    if (token) {
        headers.Authorization = 'Bearer ' + token;
    }

    $.ajax({
        url: '/jobs/',
        dataType: "html",
        type: 'GET',
        headers: headers,
        success: function (data) {
            $('#sec_cliJobs').html(data);

        },
        fail: function () {
            $('#sec_cliJobs').html("<h3>Login into the application to view the resources</h1>");
        }
    });
}

function NewJob(clientId) {

    var token = sessionStorage.getItem(tokenKey);
    var headers = {};
    if (token) {
        headers.Authorization = 'Bearer ' + token;
    }

    $.ajax({
        url: '/jobs/Create',
        dataType: "html",
        type: 'GET',
        headers: headers,
        data: {clientId: clientId },
        success: function (data) {
            $('#sec_newJob').html(data);

        },
        fail: function () {
            $('#sec_newJob').html("<h3>Login into the application to view the resources</h1>");
        }
    });
}

function ValidateAddJobFields() {
    
    var name = $("#Name");
    if ($(name).val() == "") {
        $(name).addClass("errorf");
        return false;
    }
    else {
        $(name).removeClass("errorf");
    }


    var toExecute = $("#toExecute");
    var isImmediate = $('#executeImmediately').is(":checked");
    if (!isImmediate) {
        if ($(toExecute).val() == "") {
            $(toExecute).addClass("errorf");
            return false;
        }
        else {
            $(toExecute).removeClass("errorf");
        }
    }
    else {
        $(toExecute).removeClass("errorf");
    }

   
    var Command = $("#Command");
    if ($(Command).val() == "") {
        $(Command).addClass("errorf");
        return false;
    }
    else {
        $(Command).removeClass("errorf");
    }

    return true;
    
}

function CreateJob() {
    //Manual validation. I wasn't able to include a real validation framework due to time. But i know there's a way to bind Razor validation to these partials views, but for the moment, the best intention is to give a better UX

    //In any case, this would be a two-way validation, since the model must be valid to be processed. We're just being verbose here with the user.

    var formValid = ValidateAddJobFields();

    if (!formValid) {
        ShowMinionWindowAlert("Error!", " There are empty fields. Please fill all the required information. Execution time can only left blank if the Execute immediately checkbox is checked", 0);
    }
    else {

        $.ajax({
            url: '/jobs/Create',
            dataType: "json",
            type: 'POST',
            data: $("#sec_newJob form").serialize(),
            success: function (data) {
                $('#newJobCollapse').collapse("hide");
                ShowJobs(true);
                ShowMinionWindowAlert("Success!", "Job was successfully added.", 1);
            },
            fail: function (jq, ts, e) {
                ShowMinionWindowAlert("Error!", e, 0);
            }
        });
    }
}


function CheckJobsTypesVisibility(type) {

    switch (type) {

        case 0:
            $("#sec_cliJobs .alert-success").show();
            $("#sec_cliJobs .alert-info").show();
            $("#sec_cliJobs .alert-danger").show();
            break;
        case 1:
            $("#sec_cliJobs .alert-success").hide();
            $("#sec_cliJobs .alert-info").show();
            $("#sec_cliJobs .alert-danger").hide();
            break;
        case 2:
            $("#sec_cliJobs .alert-success").show();
            $("#sec_cliJobs .alert-info").hide();
            $("#sec_cliJobs .alert-danger").hide();
            break;
        case 3:
            $("#sec_cliJobs .alert-success").hide();
            $("#sec_cliJobs .alert-info").hide();
            $("#sec_cliJobs .alert-danger").show();
            break;

        default:
            break;
    }
    
}


//BASE, CUSTOM, ETC
//TODO: Make factory design pattern class
function ShowMinionWindowAlert(strong, message, type) {

    var lblHolder = $("#sec_minionAlert div");
    lblHolder.removeClass();
    lblHolder.addClass("alert");

    var lbl_strong = $("#sec_minionAlert strong");
    var lbl_message = $("#sec_minionAlert span");

    switch (type) { //0=Error,1=Success,2=friendlyMessage,3=warningMessage

        case 0:
            lblHolder.addClass("alert-danger");
            break;
        case 1:
            lblHolder.addClass("alert-success");
            break;
        case 2:
            lblHolder.addClass("alert-primary");
            break;
        case 3:
            lblHolder.addClass("alert-warning");
            break;
        default:
            break;
        
    }

    $(lbl_strong).html(strong);
    $(lbl_message).html(message);
}

 