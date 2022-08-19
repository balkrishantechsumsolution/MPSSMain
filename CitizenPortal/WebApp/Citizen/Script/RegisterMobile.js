﻿
$(document).ready(function () {
    //alert("Test");
    $('#divMsg').hide();

    $('#divOTP').hide();
    $('#btnProceed').show();
    $('#btnValidateOTP').hide();
    $('#btnOTP').show();
    $('#divbtnOTP').hide();
    $("#ContentPlaceHolder1_btnProceed").bind("click", function (e) { return GetData(); });

});

function ValidateMobile() {
    debugger;
    $('#divMsg').hide();
    var MobileNo = $("#txtMobile").val();
    var length = MobileNo.length;
    $("#divMsgTitle").text("Validate Form!");
    $("#divMsgDtls").text("Please enter 10 digit mobile number.");
    if ($("#txtMobile").val() == "") {
        alert("Please enter 10 digit mobile number.");
        $("#txtMobile").focus();
        $('#divMsg').show();
        return false;
    }

    if (eval(length) < 10) {
        alert("Mobile number should be 10 digit");
        $("#txtMobile").focus();
        $("#txtMobile").val("");
        $('#divMsg').show();
        return false;
    }


    $.when(
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: '/WebApp/Citizen/Forms/RegisterMobile.aspx/ValidateMobile',
        data: '{"prefix": "","Data":"' + MobileNo + '"}',
        processData: false,
        dataType: "json",
        success: function (response) {

        },
        error: function (a, b, c) {
            alert("2." + a.responseText);
        }
    })).then(function (data, textStatus, jqXHR) {
        debugger;
        var obj = jQuery.parseJSON(data.d);
        var html = "";
        var strMobile = "";
        AppID = obj.AppID;

        if (obj.Status == "Error") {
            result = false;
        }

        if (AppID != null && AppID != "") {

            if (AppID == MobileNo)
                result = true;
        }

        if (result /*&& jqXHRData_IMG_result*/) {
            $("#txtMobile").prop('disabled', true);
            $('#divOTP').show();
            $('#divbtnOTP').show();
            $('#btnValidateOTP').show();
            $('#btnOTP').val("Re-validate Mobile No.");
            $("#divMsgTitle").text("Information!");
            $("#divMsgDtls").text("6 Digit OTP Code has been Sent  to  your registered mobile no.");
            $('#divMsg').show();
            fnGenOTP();
        }
        else {
            //alert('Sorry! Something went wrong, please try again.');
            alert('Your Mobile is not registered , please fill your profile to Register your Mobile Number.');
            //$('#btnOTP').val('Re-generate OTP');

            $("#MobileNo").val(MobileNo);
            $("#divCitizenProfile").show();
            $("#divSearch").hide();
            $("#HFOTPDone").val("Y");
            $("#HFMobileNo").val(MobileNo);

        }
        
    });// end of Then function of main Data Insert Function



    return false;
}

function GetData() {

    var MobileNo = $("#UID").val();

    $.when(
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: '/WebApp/Citizen/Forms/RegisterMobile.aspx/GetProfile',
        data: '{"prefix": "","Data":"' + MobileNo + '"}',
        processData: false,
        dataType: "json",
        success: function (response) {

        },
        error: function (a, b, c) {
            alert("2." + a.responseText);
        }
    })).then(function (data, textStatus, jqXHR) {
        debugger;
        var obj = jQuery.parseJSON(data.d);
        var html = "";
        var strMobile = "";
        AppID = obj.AppID;
        result = true;

        if (result /*&& jqXHRData_IMG_result*/) {
            
            window.location.href = "/WebApp/Citizen/Forms/CitizenProfile.aspx?URL=WebApp/Kiosk/Habisha/Habisha.aspx&SvcID=387&ProfileID=" + AppID;
            return true;
        }
        else {
            alert('Sorry! Something went wrong, please try again.');
            $('#btnOTP').val('Re-generate OTP');
        }
        //alert("Basic detail saved from Aadhaar.");
        //    window.location.href = url + '?UID=' + AppID + '&SvcID=' + svcid + '&DPT=' + dpt + '&DIST=' + dist + '&BLK=' + blk + '&PAN=' + pan + '&OFC=' + ofc + '&OFR=' + ofr;

    });// end of Then function of main Data Insert Function

    return false;

}

function fnGenOTP1111() {

    debugger;
    var temp = "Gunwant";
    var AppID = "";
    var result = false;

    var MobileNo = $("#UID");

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: '/WebApp/Citizen/Forms/RegisterMobile.aspx/GenerateOTP',
        data: '{"prefix": "","Data":"' + MobileNo + '"}',
        processData: false,
        dataType: "json",
        success: function (response) {
            var arr = eval(response.d);
            var html = "";
            var strMobile = arr[0].AppID;

            if (strOTP != "" && strOTP != null) {
                alert('The 6 digit OTP Code has been SMS to ' + strMobile + '\Please enter the OTP Code to verify');
                $('#btnOTP').val('Re-generate OTP');
                $('#divOTP').show();
            }
            else {
                alert('Sorry! Something went wrong, please try again.');
                $('#btnOTP').val('Re-generate OTP');
            }
        },
        error: function (a, b, c) {
            alert("2." + a.responseText);
        }
    });


    //var datavar = {

    //    'aadhaarNumber': UID

    //};

    //var obj = {
    //    "prefix": "'" + temp + "'",
    //    "Data": $.stringify(datavar, null, 4)
    //};


    //$.when(
    //    $.ajax({
    //        type: "POST",
    //        contentType: "application/json; charset=utf-8",
    //        url: '/UID/VerifyUID.aspx/GenerateOTP',
    //        data: $.stringify(obj, null, 4),
    //        processData: false,
    //        dataType: "json",
    //        success: function (response) {
    //            var arr = eval(response.d);
    //            var html = "";
    //            var strMobile = arr[0].Name;

    //            if (strOTP != "" && strOTP != null) {
    //                alert('The 6 digit OTP has been SMS to ' + strMobile + '\Please enter the no to verify');
    //                $('#btnOTP').val('Re-generate OTP');
    //                $('#divOTP').show();
    //            }
    //            else {
    //                alert('Sorry! Something went wrong, please try again.');
    //                $('#btnOTP').val('Re-generate OTP');
    //            }
    //        },
    //        error: function (a, b, c) {
    //            result = false;
    //            alert("5." + a.responseText);
    //        }
    //    })
    //    ).then(function (data, textStatus, jqXHR) {

    //        var obj = jQuery.parseJSON(data.d);
    //        var html = "";
    //        AppID = obj.AppID;
    //        result = true;

    //        if (result /*&& jqXHRData_IMG_result*/) {
    //            alert("Application submitted successfully. Reference No. : " + obj.AppID + " Please attach necessary document.");
    //            window.location.href = '../Forms/Attachment.aspx?SvcID=' + svcid + '&AppID=' + obj.AppID + '&UID=' + uid;
    //        }

    //    });// end of Then function of main Data Insert Function
    //"AppID":"527771851384_101180_29-09-2016 19:36:07_9234567890","Status":"Success","intStatus":1}

    return false;




}

//function fnOpenUID() {
//    debugger;
//    var UID = getQueryString("aadhaarNumber");
//    var TransID = getQueryString("transactionId");
//    var EID = "0";
//    var left = (screen.width / 2) - (560 / 2);
//    var top = (screen.height / 2) - (400 / 2);
//    window.location.href = '/UID/Default.aspx?aadhaarNumber=' + UID + '&kycTypesToUse=OTP&transactionId=' + UID;
//    //window.close();
//}

//function fnGenOTP123() {
//    debugger;
//    //if (!ValidateForm()) {
//    //    return;
//    //}

//    var temp = "Gunwant";
//    var AppID = "";
//    var result = false;

//    var UID = getQueryString("aadhaarNumber");
//    var TransID = getQueryString("transactionId");

//    var datavar = {

//        'aadhaarNumber': UID,
//        'SMSID': UID,
//        'OTP': "",

//    };

//    var obj = {
//        "prefix": "'" + temp + "'",
//        "Data": $.stringify(datavar, null, 4)
//    };


//    $.when(
//        $.ajax({
//            type: "POST",
//            contentType: "application/json; charset=utf-8",
//            url: '/UID/VerifyUID.aspx/GenerateOTP',
//            data: $.stringify(obj, null, 4),
//            processData: false,
//            dataType: "json",
//            success: function (response) {

//            },
//            error: function (a, b, c) {
//                result = false;
//                alert("5." + a.responseText);
//            }
//        })
//        ).then(function (data, textStatus, jqXHR) {

//            var obj = jQuery.parseJSON(data.d);
//            var html = "";
//            AppID = obj.AppID;
//            result = true;

//            if (result /*&& jqXHRData_IMG_result*/) {
//                alert("Application submitted successfully. Reference ID : " + obj.AppID + " Please attach necessary document.");
//                window.location.href = '../Forms/Attachment.aspx?SvcID=' + svcid + '&AppID=' + obj.AppID + '&UID=' + uid;
//            }

//        });// end of Then function of main Data Insert Function

//    return false;
//}

var AppID = "";
function fnGenOTP() {

    debugger;
    var temp = "Gunwant";

    var result = false;

    //var UID = getQueryString("aadhaarNumber");
    //var TransID = getQueryString("transactionId");

    var MobileNo = $("#txtMobile").val();

    $.when(
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: '/WebApp/Citizen/Forms/RegisterMobile.aspx/GenerateOTP',
        data: '{"prefix": "","Data":"' + MobileNo + '"}',
        processData: false,
        dataType: "json",
        success: function (response) {

        },
        error: function (a, b, c) {
            alert("2." + a.responseText);
        }
    })).then(function (data, textStatus, jqXHR) {
        debugger;
        var obj = jQuery.parseJSON(data.d);
        var html = "";
        var strMobile = "";
        AppID = obj.AppID;
        var temp = AppID.split('_');
        strMobile = temp[3];
        result = true;

        if (result /*&& jqXHRData_IMG_result*/) {
            alert('The 6 digit OTP code has been SMS to ' + strMobile + ' \Please Enter the no. to verify');

            $('#divOTP').show();
            $('#btnProceed').hide();
            $('#btnValidateOTP').show();
            $('#btnOTP').hide();
        }
        else {
            alert('Sorry! Something went wrong, please try again.');
            $('#btnOTP').val('Re-generate OTP');
        }
        //alert("Basic detail saved from Aadhaar.");
        //    window.location.href = url + '?UID=' + AppID + '&SvcID=' + svcid + '&DPT=' + dpt + '&DIST=' + dist + '&BLK=' + blk + '&PAN=' + pan + '&OFC=' + ofc + '&OFR=' + ofr;

    });// end of Then function of main Data Insert Function

    return false;
}

function fnValidateOTP() {

    debugger;
    var temp = "Gunwant";

    var result = false;
    //var temp = AppID.split('_');
    //var strMobile = temp[0];
    //var UID = temp[0];
    //var OTP = temp[1];
    AppID = AppID;
    $.when(
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: '/WebApp/Citizen/Forms/RegisterMobile.aspx/ValidateOTP',
        data: '{"prefix": "","Data":"' + AppID + '","EnteredOTP":"' + $('#txtOTP').val() + '"}',
        processData: false,
        dataType: "json",
        success: function (response) {

        },
        error: function (a, b, c) {
            alert("2." + a.responseText);
        }
    })).then(function (data, textStatus, jqXHR) {
        debugger;
        var obj = jQuery.parseJSON(data.d);
        var html = "";
        var strMobile = "";
        var strReturn = obj.AppID;
        var temp = strReturn.split('_');
        var cnt = temp[6];
        result = true;

        if (cnt == 1) {
            alert('OTP successfully validated');
            //fnUIDJSonValue(temp[0]);
        }
        else {
            alert('OTP Validation Failed! Please Enter correct 6 digit OTP  No.received as SMS from Lokaseba Adhikara -CAP, Odisha Govt.');

        }
        //alert("Basic detail saved from Aadhaar.");
        //    window.location.href = url + '?UID=' + AppID + '&SvcID=' + svcid + '&DPT=' + dpt + '&DIST=' + dist + '&BLK=' + blk + '&PAN=' + pan + '&OFC=' + ofc + '&OFR=' + ofr;

    });// end of Then function of main Data Insert Function

    return false;
}

function fnFetchUIDDetails() {
    alert('OTP Validated')
}

function SubmitUIDData() {
    debugger;
    //alert($("#HFUID1").val());
    //var t_Json = $("#HFUID").val();
    var t_Json = $("#HFUID1").val();
    window.opener.document.getElementById('HFUIDData').value = t_Json;
    window.opener.document.forms[0].submit();
    self.close();
}

function fnUIDJSonValue(MobileNo) {

    debugger;
    var temp = "Gunwant";

    var result = false;

    var UID = getQueryString("aadhaarNumber");
    var TransID = getQueryString("transactionId");

    $.when(
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: '/WebApp/Citizen/Forms/RegisterMobile.aspx/GetUIDJSon',
        data: '{"prefix": "","Data":"' + MobileNo + '"}',
        processData: false,
        dataType: "json",
        success: function (response) {

        },
        error: function (a, b, c) {
            alert("2." + a.responseText);
        }
    })).then(function (data, textStatus, jqXHR) {
        debugger;
        var obj = jQuery.parseJSON(data.d);
        var html = "";
        var strMobile = "";
        AppID = obj.AppID;
        var temp = AppID.split('_');
        strMobile = temp[0];
        result = true;

        if (result /*&& jqXHRData_IMG_result*/) {
            var t_Json = AppID;//$("#HFUID1").val();
            window.opener.document.getElementById('HFUIDData').value = t_Json;
            window.opener.document.forms[0].submit();
            self.close();
        }
        else {
            alert('Sorry! Something went wrong, please try again.');

        }
        //alert("Basic detail saved from Aadhaar.");
        //    window.location.href = url + '?UID=' + AppID + '&SvcID=' + svcid + '&DPT=' + dpt + '&DIST=' + dist + '&BLK=' + blk + '&PAN=' + pan + '&OFC=' + ofc + '&OFR=' + ofr;

    });// end of Then function of main Data Insert Function

    return false;
}
