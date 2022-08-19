﻿<%@ Page Title="" Language="C#" MasterPageFile="~/WebApp/Kiosk/Master/KioskMaster.Master" AutoEventWireup="true" CodeBehind="FormB.aspx.cs" Inherits="CitizenPortal.WebApp.Kiosk.OUAT.FORMB" %>

<%@ Register Src="~/WebApp/Control/FormTitle.ascx" TagPrefix="uc1" TagName="FormTitle" %>
<%@ Register Src="~/WebApp/Control/PhysicalTestDeclaration.ascx" TagPrefix="uc1" TagName="PhysicalTestDeclaration" %>
<%@ Register Src="~/WebApp/Control/SearchRecord.ascx" TagPrefix="uc1" TagName="SearchRecord" %>
<%@ Register Src="~/WebApp/Control/ServiceInformation.ascx" TagPrefix="uc1" TagName="ServiceInformation" %>
<%@ Register Src="~/WebApp/Control/OUATUndertaking.ascx" TagPrefix="uc1" TagName="OUATUndertaking" %>
<%@ Register Src="~/WebApp/Control/OUATDeclaration.ascx" TagPrefix="uc1" TagName="OUATDeclaration" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/jquery-ui-1.11.4.min.js"></script>
    <script src="/Scripts/jquery.msgBox.js"></script>
    <link href="/PortalStyles/msgBoxLight.css" rel="stylesheet" />
    <script src="/Scripts/fileupload/vendor/jquery.ui.widget.js"></script>
    <script src="/Scripts/fileupload/jquery.iframe-transport.js"></script>
    <script src="/Scripts/fileupload/jquery.fileupload.js"></script>
    <script src="/PortalScripts/ServiceLanguage.js?v=<%=CitizenPortal.Common.GlobalValues.JSVersion%>"></script>
    <link href="/PortalStyles/jquery-ui.min.css" rel="stylesheet" />
    <script src="/WebApp/Scripts/CommonScript.js?v=<%=CitizenPortal.Common.GlobalValues.JSVersion%>"></script>
    <script src="/WebApp/Scripts/ValidationScript.js?v=<%=CitizenPortal.Common.GlobalValues.JSVersion%>"></script>
    <script src="FORMB.js?v=<%=CitizenPortal.Common.GlobalValues.JSVersion%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#divReserved').hide();
            $('#divEmplyeeCase').hide();
            $('#divNRI').hide();
            $('#divAgro').hide();
            $('#divResevation').hide();
            $("#divMarks").hide();
            $("#divGCH").hide();
            $("#divWO").hide();
            $("#divPH").hide();
            $("#divKM").hide();
            $("#divInstruction").hide();
        });

        var bool = 0;
        function ckhInfo() {
            if (bool == 1) {
                bool = 0;
                $('#divInfo').slideDown(500);
            }
            else {
                bool = 1;
                $('#divInfo').slideUp(500);
            }
        }

        function fuShowHideDiv(divID, isTrue) {
           
            debugger;
            //alert(divID);
            if (isTrue == "1") {
                $('#' + divID).show(500);
            }
            if (isTrue == "0") {
                hidedive();
                $('#' + divID).hide(500);
            }
        }

        function fnLanguage(divID) {
            debugger;
            //alert(divID);
            if (divID == "divResi") {
                $('#divResi').show(500);
                $('#divLang').hide(500);
                $("#divInstruction").show(500);
            }
            if (divID == "divLang") {
                $('#divResi').hide(500);
                $('#divLang').show(500);
                $("#divInstruction").hide(500);
            }
        }

        function fnClose() {
            $('#divLogin').hide();
        }
        function fnShowLogin() {
            $('#divLogin').show();
        }

        $(document).ready(function () {
            //debugger;
            $(function () {
                $("#Photo").change(function () {
                    if (this.files && this.files[0]) {
                        var reader = new FileReader();
                        reader.onload = imageIsLoaded;
                        reader.readAsDataURL(this.files[0]);
                    }
                });
            });

            function imageIsLoaded(e) {
                $('#imgPhoto').attr('src', e.target.result);
            };
            m_ServiceID = $('#HFServiceID').val();
        });



        $(document).ready(function () { $("#ddlSearch").prop('disabled', true); $("#divNonAadhar").hide(); });
    </script>
    <script type="text/javascript">
        function ChangeLanguage(p_Lang) {

            var t_Lang = p_Lang;

            if (p_Lang == null) t_Lang = document.getElementById('HFCurrentLang').value;

            //if (document.getElementById('HFCurrentLang').value != "") t_Lang = document.getElementById('HFCurrentLang').value;

            if (t_Lang == "1") t_Lang = "2";
            else t_Lang = "1";


            document.getElementById('HFCurrentLang').value = t_Lang;
            //alert(p_Lang);
            //alert(document.getElementById('HFCurrentLang').value);
            //window.location.reload();
            document.forms[0].submit();
            return true;
        }


    </script>

    <style>
        .ui-widget-header {
            color: #333 !important;
            font-weight: normal !important;
        }

        .table > tbody > tr > th {
            padding: 5px !important;
            text-align: center;
            vertical-align: middle !important;
        }

        .table > tbody > tr > td {
            padding: 10px !important;
        }

        .othrinfohd {
            background-color: #ececec !important;
        }

        #CheckBoxList1 > tbody > tr > td {
            padding: 0px 20px 10px 10px !important;
        }

        .form-heading {
            color: #820000;
            text-align: left;
            border-left: 15px solid #ce6d07;
            border-right: 2px solid #ce6d07;
            border-top: 1px solid #d8d8d8;
            border-bottom: 1px solid #d8d8d8;
            background: rgba(0, 0, 0, .075);
            padding: 10px 20px 10px 15px;
            border-top-right-radius: 2px;
            border-top-left-radius: 2px;
            text-transform: uppercase;
            font-weight: bold;
            font-size: x-large;
        }

            .form-heading span {
                font-size: 30px;
                padding-left: 0;
            }

        #instn p {
            line-height: 20px;
            color: #777;
            display: flex;
        }

        #instn .mleft10 {
            margin-left: 10px !important;
        }

        #instn li {
            color: #777;
            display: flex;
        }

        .msgBox {
            width: 600px !important;
            overflow: auto;
            height: 656px;
        }

        .msgBoxContent {
            width: 468px !important;
        }

        .msgError {
            background-color: yellow;
        }

        .div.msgBoxImage {
            margin: 5px 5px 0 5px;
            display: inline-block;
            float: left;
            height: 75px;
            width: 75px;
        }

        #divOtherInfo label {
            display: inline !important;
        }

        p {
            color: #000000 !important;
            font-family: Arial !important;
        }

        .modalBackground {
            background-color: #000;
            filter: alpha(opacity=90);
            opacity: 0.6;
            left: 0;
            position: absolute;
            top: 0;
            width: 100%;
            z-index: 10000;
            height: 1000%;
        }

        #progressbar12 {
            width: 300px;
            height: 14px;
            background-color: #00aeff;
            filter: progid:DXImageTransform.Microsoft.gradient(GradientType=1,startColorstr=#00aeff, endColorstr=#ff0000);
            background-image: -moz-linear-gradient(left, #00aeff 40%, #ff0000 80%,#2fff00 100%);
            background-image: linear-gradient(left, #00aeff 40%, #ff0000 80%,#2fff00 100%);
            background-image: -webkit-linear-gradient(left, #00aeff 40%, #ff0000 80%,#2fff00 100%);
            background-image: -o-linear-gradient(left, #00aeff 40%, #ff0000 80%,#2fff00 100%);
            background-image: -ms-linear-gradient(left, #00aeff 40%, #ff0000 80%,#2fff00 100%);
            background-image: -webkit-gradient(linear, left bottom, right bottom, color-stop(40%,#00aeff), color-stop(80%,#ff0000),color-stop(100%,#2fff00));
        }

        .text-danger {
            color: maroon !important;
            font-size: 20px;
            font-family: Arial;
        }

        .auto-style1 {
            left: -1px;
            top: 0px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server" ClientIDMode="Static">

    <div id="progressbar" class="modalBackground" runat="server" clientidmode="Static" style="height: 700%; border: 1px solid #ccc; display: none;">
        <div style="z-index: 105; left: 40%; position: absolute; top: 70%;" class="text-center">
            <img id="imgloader" alt="" runat="server" src="/WebApp/Kiosk/Images/loading.gif" style="height: 200px;" />
            <p class="text-danger">
                Please do not refresh or click back button<br />
                as Request is Processing....
            </p>
        </div>
    </div>

    <div id="intrnlContent" ng-app="appmodule">
        <div ng-controller="ctrl">
            <div id="page-wrapper" style="min-height: 311px;">
                <div class="row">
                    <div class="col-lg-12">
                    </div>
                </div>

                <div class="row" id="divCitizenProfile">
                    <div>
                        <div class="clearfix">
                            <%--<uc1:FormTitle runat="server" ID="FormTitle" />--%>
                            <h2 class="form-heading">
                                <span class="col-lg-10 p0"><i class="fa fa-pencil-square-o"></i>Application Form For Admission into OUAT-UG Course 2017-18 <%--{{resourcesData.lblOISFTitle}}--%>
                                </span>
                                <span class="col-lg-2 p0 text-right" style="font-size: 15px;">Language : 
                                    <input type="button" id="btnLang" class="btn-link" runat="server" onclick="javascript: return ChangeLanguage();" /><i class="fa fa-hand-o-up"></i></span>
                                <span class="clearfix"></span>
                            </h2>
                        </div>
                        <div style="margin-top: -10px">
                            <h2 class="text-center">
                                <span style="font-family: 'Arial Rounded MT'; color: #ce6d07; font-size: 30px; font-weight: bold; text-shadow: 0px 1px 3px #727272;">FORM-'B'
                                </span><span class="clearfix"></span>
                            </h2>
                        </div>
                        <div class="row">
                            <div class="col-md-12 box-container" id="">
                                <div class="box-heading">
                                    <h4 class="box-title">Instruction to Fill the Form 
                               
                                <span class="col-md-6 pull-right" style="font-style: normal; cursor: pointer; font-size: 12px; text-align: right; padding: 0;" onclick="ckhInfo();">
                                    <i class="fa fa-info-circle" style="cursor: pointer; font-size: 15px;" title="Information">&nbsp;&nbsp;</i>Help&nbsp;&nbsp;<i class="fa fa-hand-o-up"></i></span><span class="clearfix"></span>
                                    </h4>
                                </div>
                                <uc1:ServiceInformation runat="server" ID="ServiceInformation" />

                            </div>
                        </div>                        
                        <div class="row">

                            <div id="" class="col-md-9 p0">
                                <div class="col-md-12 box-container" style="">
                                    <div class="box-heading">
                                        <h4 class="box-title">Application Details 
                                        </h4>
                                    </div>
                                    <div class="box-body box-body-open">
                                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="txtAppID">
                                                    Application Number
                                                </label>
                                                <input class="form-control"  name="ApplicationNo" type="text" value="KH1289600442" id="txtAppID" maxlength="12" readonly="true"
                                                    autofocus />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="" for="chkPreference">
                                                    Entrance Roll No.
                                                </label>
                                                <input class="form-control" placeholder="" name="txtRollNo" type="text" value="" id="txtRollNo" readonly
                                                    autofocus />
                                            </div>
                                        </div>


                                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlApplication">
                                                    Transaction Number
                                                </label>
                                                <input class="form-control" placeholder="Unpaid" name="txtAadhaar" type="text" value="" id="txtTransNo"
                                                    autofocus />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlApplication">
                                                    Transaction Date
                                                </label>
                                                <input class="form-control"  placeholder="Unpaid" name="txtTransDate" type="text" value="" id="txtTransDate"
                                                    autofocus />
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>

                                <div id="divDetails" class="col-md-12 box-container">
                                    <div class="box-heading" id="Div4">
                                        <h4 class="box-title">{{resourcesData.applicantDetails}}
                                        </h4>
                                    </div>
                                    <div class="box-body box-body-open">
                                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="firstname">
                                                    {{resourcesData.nameoftheCandidate}}</label>
                                                <input id="FirstName" class="form-control" placeholder="Full Name" name="FirstName" onchange="return checkLength(this);" onkeypress="return ValidateAlpha(event);" type="text" autofocus="" maxlength="40" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="MotherName">
                                                    {{resourcesData.motherName}}</label>
                                                <input id="MotherName" class="form-control" placeholder="Mother's Name" name="Mother Name" type="text" value="" autofocus="" maxlength="40" onchange="return checkLength(this);" onkeypress="return ValidateAlpha(event);" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="FatherName">
                                                    {{resourcesData.fatherName}}</label>
                                                <input id="FatherName" class="form-control" placeholder="Father's Name" name="Father Name" type="text" value="" autofocus="" maxlength="40" onchange="return checkLength(this);" onkeypress="return ValidateAlpha(event);" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlApplication">
                                                    Aadhaar Number
                                                </label>
                                                <input class="form-control" placeholder="Enter 12 digit Aadhaar Number" name="txtAadhaar" type="text" value="" id="UID" maxlength="12" onkeypress="return isNumberKey(event);" readonly
                                                    autofocus />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="DOB">
                                                    {{resourcesData.dateofBirth}} <span style="font-size: 11px;">{{resourcesData.AsperHSCCertificate}}</span></label>
                                                <input id="DOB" class="form-control" placeholder="DOB" name="DOB" value="" autofocus="" onkeypress="return ValidateAlpha(event);" onkeydown=" return allowBackspace(event);" maxlength="12" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3 pright0">

                                            <div class="form-group">
                                                <label for="Age">
                                                    Age as on 31.12.2017</label>
                                                <div class="col-xs-4 pleft0 pright0">
                                                    <input id="Year" class="form-control mtop0" placeholder="Year" name="Year" value="" maxlength="3" autofocus="" />
                                                </div>
                                                <div class="col-xs-4 pleft0 pright0">
                                                    <input id="Month" class="form-control mtop0" placeholder="Month" name="Month" value="" maxlength="3" autofocus="" />
                                                </div>
                                                <div class="col-xs-4 pleft0 ">
                                                    <input id="Day" class="form-control mtop0" placeholder="Day" name="Day" value="" maxlength="3" autofocus="" />
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlGender">
                                                    {{resourcesData.lblAppGender}}</label>
                                                <select class="form-control" data-val="true" data-val-number="Gender" data-val-required="Please select gender." id="ddlGender" name="Gender">
                                                    <option value="0">--Select Gender--</option>
                                                    <option value="M">Male</option>
                                                    <option value="F">Female</option>
                                                    <option value="T">Transgender</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="MobileNo">
                                                    {{resourcesData.religion}}</label>

                                                <select class="form-control" data-val="true" data-val-number="Religion" data-val-required="Please select your Category" id="religion" name="Religion">
                                                    <option value="Select Religion">Select</option>
                                                    <option value="Hindu">Hindu</option>
                                                    <option value="Islam">Islam</option>
                                                    <option value="Jain">Jain</option>
                                                    <option value="Sikh">Sikh</option>
                                                    <option value="Christian">Christian</option>
                                                    <option value="Budhist">Budhist</option>
                                                    <option value="Other">Other's</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="category">
                                                    {{resourcesData.category}}</label>
                                                <select class="form-control" data-val="true" data-val-number="Category" data-val-required="Please select your Category" id="category" name="Category">
                                                    <option value="Select Category">--Select Category--</option>
                                                    <option value="SC">SC</option>
                                                    <option value="ST">ST</option>
                                                    <option value="General">General</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="txtTongue">
                                                    {{resourcesData.motherTongue}}</label>
                                                <select class="form-control" data-val="true" data-val-number="mothertongue" id="txtTongue" name="txtTongue">
                                                    <option value="0">--Select Mother Tongue--</option>
                                                    <option value="Assamese (Asamiya)">Assamese (Asamiya)</option>
                                                    <option value="Bengali (Bangla)">Bengali (Bangla)</option>
                                                    <option value="Bodo">Bodo</option>
                                                    <option value="Dogri">Dogri</option>
                                                    <option value="English">English</option>
                                                    <option value="Gujarati">Gujarati</option>
                                                    <option value="Hindi">Hindi</option>
                                                    <option value="Kannada">Kannada</option>
                                                    <option value="Kashmiri">Kashmiri</option>
                                                    <option value="Konkani">Konkani</option>
                                                    <option value="Maithili">Maithili</option>
                                                    <option value="Malayalam">Malayalam</option>
                                                    <option value="Marathi">Marathi</option>
                                                    <option value="Meitei (Manipuri)">Meitei (Manipuri)</option>
                                                    <option value="Nepali">Nepali</option>
                                                    <option value="Odia">Odia</option>
                                                    <option value="Punjabi">Punjabi</option>
                                                    <option value="Sanskrit">Sanskrit</option>
                                                    <option value="Santali">Santali</option>
                                                    <option value="Sindhi">Sindhi</option>
                                                    <option value="Tamil">Tamil</option>
                                                    <option value="Telugu">Telugu</option>
                                                    <option value="Urdu">Urdu</option>
                                                    <option value="Other">Other</option>
                                                </select>
                                                <%--<input id="txtTongue" class="form-control inputbox_bluebdr" name="txtTongue" placeholder="Mother Tongue" type="text" value="" autocomplete="off" />--%>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="nationality">
                                                    {{resourcesData.nationality}}</label>
                                                <select class="form-control" data-val="true" data-val-number="Nationality" id="nationality" name="nationality">
                                                    <option value="Indian">Indian</option>
                                                    <option value="NRI">NRI</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="manadatory" for="MobileNo">
                                                    {{resourcesData.mobileno}}</label><%--onblur="return MobileNoValidation();"--%>
                                                <input id="MobileNo" class="form-control inputbox_bluebdr" maxlength="10" name="MobileNo" placeholder="Mobile Number" onkeypress="return isNumberKey(event); " type="text" value="" autocomplete="off" />
                                            </div>
                                        </div>

                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                            <div class="form-group">
                                                <label class="" for="phoneno">
                                                    {{resourcesData.alternatemobile}} <%--<span style="font-size: 11px;">{{resourcesData.withSTDCode}}</span>--%></label>
                                                <input id="phoneno" class="form-control" placeholder="Alternate Mobile Number" name="Alternate Mobile Number" value="" maxlength="10" onkeypress="return isNumberKey(event);" autofocus="" />

                                                <div class="col-xs-4 pleft0 pright1" style="display: none;">
                                                    <input id="stdcode" class="form-control" placeholder="STD Code" name="Std" value="" maxlength="5" onkeypress="return isNumberKey(event);" autofocus="" />

                                                    <div class="col-xs-12 pright0 pleft0">
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label for="EmailID">
                                                    {{resourcesData.emailID}}</label>
                                                <input id="EmailID" class="form-control" placeholder="Email Id" name="Email Id" type="email" value="" maxlength="30" autofocus="" style="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12" style="display: none">
                                            <p class="ptop10"><i class="fa fa-info-circle pright5" style="color: #000;"></i>SC,ST SEBC candidates should attach self attested copy of respective Caste Certificate.<span style="color: red;">*</span></p>

                                        </div>

                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                            </div>

                            <div id="" class="col-md-3 p0">
                                <div id="divHelp" class="col-md-12 box-container" style="display: none;">
                                    <div class="box-heading">
                                        <h4 class="box-title manadatory">Help Manuals 
                                        </h4>
                                    </div>
                                    <div class="box-body box-body-open">
                                        <div class="col-xs-12 col-sm-6 col-md-12 col-lg-12">
                                            <label class="btn-link text-left"><i class="fa fa-hand-o-up"></i><a href="../../../g2c/Downloads/Video/PlayVideo.html" target="_blank">Video - How to fill the form</a></label>
                                            <label class="btn-link text-left"><i class="fa fa-hand-o-up"></i><a href="../../../g2c/Downloads/PDF/ConstablesRecruitment.pdf" target="_blank">Read advertisement / Notification</a></label>
                                            <label class="btn-link text-left"><i class="fa fa-hand-o-up"></i><a href="../../../g2c/Downloads/PDF/ResizeImage.pdf" target="_blank">How to check and resize image</a></label>
                                        </div>
                                        <div class="clearfix">
                                        </div>
                                    </div>
                                </div>
                                <div id="divPhoto" class="col-md-12 box-container">
                                    <div class="box-heading">
                                        <h4 class="box-title manadatory">{{resourcesData.applicantPhotograph}}
                                        </h4>
                                    </div>
                                    <div class="box-body box-body-open p0">
                                        <div class="col-lg-12">
                                            <img class="form-control" src="/webApp/kiosk/Images/photo.png" name="ProfilePhoto" style="height: 220px" id="myImg" />
                                            <input class="camera" id="File1" name="Photoupload" type="file" style="display: none;" />
                                        </div>
                                        <div class="clearfix">
                                        </div>
                                    </div>
                                </div>
                                <div id="divSign" class="col-md-12 box-container">
                                    <div class="box-heading">
                                        <h4 class="box-title manadatory">{{resourcesData.applicantSignature}}
                                        </h4>
                                    </div>
                                    <div class="box-body box-body-open p0">
                                        <div class="col-lg-12">
                                            <img class="form-control" src="/WebApp/Kiosk/OISF/img/signature.png" name="signaturecustomer" style="height: 150px" id="mySign" />
                                            <input class="camera" id="File2" name="Photoupload" type="file" style="display: none;" />
                                        </div>
                                        <div class="clearfix">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="divAddress" class="row" style="display: none;">
                            <div class="col-md-6 box-container mTop15">
                                <div class="box-heading">
                                    <h4 class="box-title">{{resourcesData.permanentAddress}}
                                    </h4>
                                </div>

                                <div class="box-body box-body-open">
                                    <div class="box-body box-body-open">
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label class="manadatory" for="AddressLine1">
                                                    {{resourcesData.addressLine1}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address1$AddressLine1" type="text" id="PAddressLine1" class="form-control" placeholder="First Line Address" maxlength="40" onchange="return checkLength(this);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label for="AddressLine2">
                                                    {{resourcesData.addressLine2}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address1$AddressLine2" type="text" id="PAddressLine2" class="form-control" placeholder="Second Line Address" maxlength="40" onchange="return checkLength(this);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label class="manadatory" for="RoadStreetName">
                                                    {{resourcesData.roadStreetName}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address1$RoadStreetName" type="text" id="PRoadStreetName" class="form-control" placeholder="Road / Street Name" maxlength="40" onchange="return checkLength(this);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label for="LandMark">
                                                    {{resourcesData.landmark}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address1$LandMark" type="text" id="PLandMark" class="form-control" placeholder="Landmark" maxlength="40" onchange="return checkLength(this);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="Locality">
                                                    {{resourcesData.locality}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address1$Locality" type="text" id="PLocality" class="form-control" placeholder="Locality" maxlength="40" onchange="return checkLength(this);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlState">
                                                    {{resourcesData.state}}
                                                </label>
                                                <select name="ctl00$ContentPlaceHolder1$Address1$ddlState" id="PddlState" class="form-control" data-val="true" data-val-number="State." data-val-required="Please select state">
                                                </select>
                                                <input id="txtState" class="form-control" placeholder="Enter State Name" name="txtState" type="text" value=""
                                                    autofocus runat="server" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlDistrict">
                                                    {{resourcesData.district}}
                                                </label>
                                                <select name="ctl00$ContentPlaceHolder1$Address1$ddlDistrict" id="PddlDistrict" class="form-control" data-val="true" data-val-number="District." data-val-required="Please select District.">
                                                    <option value="0">Select District</option>
                                                </select>
                                                <input id="txtDistrict" class="form-control" placeholder="Enter District Name" name="txtDistrict" type="text" value=""
                                                    autofocus runat="server" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlTaluka">
                                                    {{resourcesData.blockTaluka}}
                                                </label>
                                                <select name="ctl00$ContentPlaceHolder1$Address1$ddlTaluka" id="PddlTaluka" class="form-control" data-val="true" data-val-number="Taluka." data-val-required="Please select block.">
                                                    <option value="0">Select Block</option>
                                                </select>
                                                <input id="txtBlock" class="form-control" placeholder="Enter Block Name" name="txtBlock" type="text" value=""
                                                    autofocus runat="server" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory text-nowrap" for="ddlVillage">
                                                    {{resourcesData.panchayatVillageCity}}
                                                </label>
                                                <select name="ctl00$ContentPlaceHolder1$Address1$ddlVillage" id="PddlVillage" class="form-control" data-val="true" data-val-number="State." data-val-required="Please select panchayat">
                                                    <option value="0">Select Panchayat</option>
                                                </select>
                                                <input id="txtPanchayat" class="form-control" placeholder="Enter Panchayat Name" name="txtPanchayat" type="text" value=""
                                                    autofocus runat="server" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="PIN">
                                                    {{resourcesData.pincode}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address1$PinCode" type="text" id="PPinCode" class="form-control" placeholder="PIN" maxlength="6" onkeypress="return isNumberKey(event);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                        </div>
                                    </div>

                                    <div class="clearfix">
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-6 box-container mTop15">
                                <div class="box-heading">
                                    <h4 class="box-title">{{resourcesData.presentAddress}} <span style="font-size: 13px; padding-right: 0">{{resourcesData.forcorrespondence}}</span>
                                        <span class="col-md-5 pull-right" style="font-style: normal; font-size: 12px; text-align: right; padding-right: 0; padding-left: 0;">
                                            <input id="chkAddress" type="checkbox" style="vertical-align: bottom;" onclick="javascript: fnCopyAddress(this.checked);" />{{resourcesData.sameasPermanentAddress}}</span><span class="clearfix">
                                            </span>
                                    </h4>
                                </div>
                                <div class="box-body box-body-open">
                                    <div class="box-body box-body-open">
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label class="manadatory" for="AddressLine1">
                                                    {{resourcesData.addressLine1}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address2$AddressLine1" type="text" id="CAddressLine1" class="form-control" placeholder="First Line Address" maxlength="40" onchange="return checkLength(this);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label for="AddressLine2">
                                                    {{resourcesData.addressLine2}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address2$AddressLine2" type="text" id="CAddressLine2" class="form-control" placeholder="Second Line Address" maxlength="40" onchange="return checkLength(this);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label class="manadatory" for="RoadStreetName">
                                                    {{resourcesData.roadStreetName}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address2$RoadStreetName" type="text" id="CRoadStreetName" class="form-control" placeholder="Road / Street Name" maxlength="40" onchange="return checkLength(this);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label for="LandMark">
                                                    {{resourcesData.landmark}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address2$LandMark" type="text" id="CLandMark" class="form-control" placeholder="Landmark" maxlength="40" onchange="return checkLength(this);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="Locality">
                                                    {{resourcesData.locality}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address2$Locality" type="text" id="CLocality" class="form-control" placeholder="Locality" maxlength="40" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlState">
                                                    {{resourcesData.state}}
                                                </label>
                                                <select name="ctl00$ContentPlaceHolder1$Address2$ddlState" id="CddlState" class="form-control" data-val="true" data-val-number="State." data-val-required="Please select state">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlDistrict">
                                                    {{resourcesData.district}}
                                                </label>
                                                <select name="ctl00$ContentPlaceHolder1$Address2$ddlDistrict" id="CddlDistrict" class="form-control" data-val="true" data-val-number="District." data-val-required="Please select District.">
                                                    <option value="0">Select District</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="ddlTaluka">
                                                    {{resourcesData.blockTaluka}}
                                                </label>
                                                <select name="ctl00$ContentPlaceHolder1$Address2$ddlTaluka" id="CddlTaluka" class="form-control" data-val="true" data-val-number="Taluka." data-val-required="Please select block.">
                                                    <option value="0">Select Block</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory text-nowrap" for="ddlVillage">
                                                    {{resourcesData.panchayatVillageCity}}
                                                </label>
                                                <select name="ctl00$ContentPlaceHolder1$Address2$ddlVillage" id="CddlVillage" class="form-control" data-val="true" data-val-number="Village." data-val-required="Please select panchayat">
                                                    <option value="0">Select Panchayat</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                            <div class="form-group">
                                                <label class="manadatory" for="PIN">
                                                    {{resourcesData.pincode}}
                                                </label>
                                                <input name="ctl00$ContentPlaceHolder1$Address2$PinCode" type="text" id="CPinCode" class="form-control" placeholder="PIN" maxlength="6" onkeypress="return isNumberKey(event);" autofocus="" />
                                            </div>
                                        </div>
                                        <div class="clearfix">
                                        </div>
                                    </div>

                                </div>
                                <div class="clearfix">
                                </div>
                            </div>

                        </div>

                        <%--End Reservation Detail--%>
                    <div id="divOtherInfo" class="col-md-12 box-container pleft0 pright0">
                        <div class="box-heading">
                            <h4 class="box-title pleft0">Reservation Quota Details
                            </h4>
                        </div>
                        <div class="box-body box-body-open">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                                <div class="form-group">
                                    <div class="col-lg-12 othrinfohd">
                                        <div class="col-md-9 pleft0">
                                            <p><span><span class="fom-Numbx">1.</span> {{resourcesData.reservedseat}}</span></p>
                                        </div>
                                        <div class="col-md-3 pleft0 pright0">
                                            <div class="col-xs-6 pleft0">
                                                <input type="radio" name="reserved" id="rbtnReservedY" value="yes" onclick="return fuShowHideDiv('divReserved', 1);" />{{resourcesData.yes}}
                                            <label for="rbtnReservedY"></label>

                                            </div>
                                            <div class="col-xs-6">
                                                <input type="radio" name="reserved" id="rbtnReservedN" value="no" onclick="return fuShowHideDiv('divReserved', 0);" />
                                                {{resourcesData.no}}
                                            <label for="rbtnReservedN"></label>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--<div class="clearfix"></div>--%>
                                <div id="divReserved" class="form-group">
                                    <div class="col-lg-12 othrinfosubhd2">
                                        <div class="col-md-4 pleft0">
                                            <p class="pleft27 manadatory"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.seatcategory}}</p>
                                        </div>
                                        <div class="col-md-8 pleft0 pright0">
                                            <div class="col-xs-12 pleft0 pright0">
                                                <asp:CheckBoxList ID="CheckBoxList1" runat="Server" RepeatDirection="Horizontal" RepeatColumns="3" onchange="fnReservationQuota();">
                                                    
                                                    <asp:ListItem Text="Green Card Holder" Value="202"></asp:ListItem>
                                                    <asp:ListItem Text="Physically Handicapped" Value="203"></asp:ListItem>
                                                    <asp:ListItem Text="NRI Sponsorship" Value="204"></asp:ListItem>
                                                    <asp:ListItem Text="Western Odisha" Value="206"></asp:ListItem>
                                                    <asp:ListItem Text="OUAT Employee" Value="207"></asp:ListItem>
                                                    <asp:ListItem Text="Kashmir Migrant" Value="209"></asp:ListItem>
                                                </asp:CheckBoxList>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                                <%--Start Green Card Holder Detail--%>
                                <div id="divGCH">
                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfohd">
                                            <div class="col-md-9 pleft0">
                                                <p><span><span class="fom-Numbx"><i class="fa fa-hand-o-right"></i></span><b>Reservation details under Green Card Holder quota</b></span></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="">
                                                <p class=""><i class="fa fa-info-circle pright5" style="color: #000;"></i>Green Card Holder candidate needs to upload <b>Scanned copy of GREEN CARD depicting the name of the candidate and his/her parents</b> in attachment page. Please refer <b>Clause 3.2 of UG Prospectus - 2017</b> <span style="color: red;">*</span></p>

                                            </div>                                            
                                        </div>
                                    </div>
                                </div>
                                <%--End Green Card Holder Details--%>

                                <%--StartPhysical Handicap Detail--%>
                                <div id="divPH">
                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfohd">
                                            <div class="col-md-9 pleft0">
                                                <p><span><span class="fom-Numbx"><i class="fa fa-hand-o-right"></i></span><b>Reservation details under Physically Handicapped quota</b></span></p>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0 pright0">
                                                <p class="ptop5 pleft27 manadatory"><i class="fa fa-arrow-right pright "></i>Physical Handicapped type?</p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                
                                                        <div class="col-xs-12 pleft0">
                                                            <div class="col-xs-6 pleft0"><input type="radio" name="HandicapType" id="rbtnHandicapTypeY" value="P" />Permanent</div>
                                                            <div class="col-xs-6 pleft0"><input type="radio" name="HandicapType" id="rbtnHandicapTypeN" value="T" />Temporary      </div>                                                      
                                            
                                                        </div>
                                                        
                                                    

                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0 pright0">
                                                <p class="ptop5 pleft27 manadatory"><i class="fa fa-arrow-right pright "></i>Which part of the body is Handicapped?</p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-12 pleft0">
                                                    <input id="txtHandicappedPart" class="form-control" name="txtHandicappedPart" type="text" placeholder="Handicapped Body Part" value="" autofocus="" />

                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0">
                                                <p class="ptop5 pleft27 manadatory"><i class="fa fa-arrow-right pright5"></i>Percentage of Handicapped<%--No.of service years--%></p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-3 pleft0 text-right">
                                                    <input id="txtHandiPercent" class="form-control mtop0" placeholder="%" name="txtHandiPercent" value="" maxlength="2" style="text-align:right" />

                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="">
                                                <p class=""><i class="fa fa-info-circle pright5" style="color: #000;"></i>Handicapped Candidate need to upload <b>Physical Handicapped certificate from Competent Medical Authority</b> in attachment page. Please refer <b>Clause 3.2 of UG Prospectus - 2017</b> <span style="color: red;">*</span></p>

                                            </div>                                            
                                        </div>
                                    </div>
                                </div>
                                <%--End Physical Handicap Details--%>

                                <%--Start NRI Detail--%>
                                <div class="form-group" id="divNRI">
                                    <div class="col-lg-12 othrinfohd">
                                        <div class="col-md-9 pleft0">
                                            <p><span><span class="fom-Numbx"><i class="fa fa-hand-o-right"></i></span><b>Reservation details under NRI Sponsorship quota</b></span></p>
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <%--<div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0">
                                                <p class="pleft27 ptop5"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.sponsorperson}}</p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-12 pright0 pleft0">

                                                    <input id="txtSponsor" class="form-control" name="txtSponsor" placeholder="Sponsoring Person Name" type="text" value="" autofocus="" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0">
                                                <p class="pleft27 ptop5"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.sponsorrelation}}</p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-12 pright0 pleft0">

                                                    <select name="ddlSponsorRelation" id="ddlSponsorRelation" class="form-control" data-val="true" data-val-number="Relation" data-val-required="Please select Relationship with Sponsoring Person">
                                                        <option value="0">--Select--</option>
                                                        <option value="101">Father</option>
                                                        <option value="102">Mother</option>
                                                        <option value="103">Uncle</option>
                                                        <option value="104">Anuty</option>
                                                        <option value="105">Brother</option>
                                                        <option value="106">Sister</option>
                                                        <option value="101">Grand-Father</option>
                                                        <option value="102">Grand-Mother</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0">
                                                <p class="pleft27 ptop5"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.sponsoremail}}</p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-12 pright0 pleft0">


                                                    <input id="txtSponsorEmail" class="form-control" name="txtSponsorEmail" placeholder="Sponsoring Person Email ID" type="text" value="" autofocus="" />

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0">
                                                <p class="pleft27"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.sponsormobile}}</p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-12 pright0 pleft0">

                                                    <input id="txtSponsorMobile" class="form-control" name="txtSponsorMobile" placeholder="Sponsoring Person Mobile No" type="text" value="" autofocus="" />

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-4 pleft0">
                                                <p class="pleft27 ptop5"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.nriadressIndia}}</p>
                                            </div>
                                            <div class="col-md-8 pleft0 pright0">
                                                <div class="col-xs-12 pright0 pleft0">


                                                    <input id="txtNRIAddressIndia" class="form-control" name="txtNRIAddressIndia" placeholder="Complete NRI Permanent Address in India" type="text" value="" autofocus="" />

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-4 pleft0">
                                                <p class="pleft27"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.nriaddressAbroad}}</p>
                                            </div>
                                            <div class="col-md-8 pleft0 pright0">
                                                <div class="col-xs-12 pright0 pleft0">


                                                    <input id="txtNRIAddressAbroad" class="form-control" name="txtNRIAddressAbroad" placeholder="Complete NRI Present Address in Abroad" type="text" value="" autofocus="" />

                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>--%>
                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfosubhd2">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="">
                                            <p class=""><i class="fa fa-info-circle pright5" style="color: #000;"></i>NRI Candidate need to fill the <b>ANNEXURE-III,</b> and upload it (in attachment page) with supporting documents (<b>Valid passport, Valid Visa / proof of permanent residential certificate and residence proof</b>) in English version. Please refer <b>Clause 3.6 of UG Prospectus - 2017</b> <span style="color: red;">*</span></p>
                                        </div>
                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 text-right" style="display:none">
                                            <p class="">
                                                <i class="fa fa-file-pdf-o"></i>
                                                <input type="button" id="Button2" class="btn-link" runat="server" onclick="javascript: return downloadAnnexure3();" value="Download ANNEXURE-III" />
                                                <i class="fa fa-download"></i>
                                            </p>
                                        </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--End of NRI Details--%>

                                <%--Start Western Odisha Detail --%>
                                <div id="divWO">
                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfohd">
                                            <div class="col-md-9 pleft0">
                                                <p><span><span class="fom-Numbx"><i class="fa fa-hand-o-right"></i></span><b>Reservation details under Western Odisha quota</b></span></p>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0 pright0">
                                                <p class="ptop5 pleft27"><i class="fa fa-arrow-right pright5"></i>Please select residing District of Western Odisha </p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-12 pleft0">
                                                    <select name="ddlWesternDistrict" id="ddlWesternDistrict" class="form-control" data-val="true" data-val-number="ddlWesternDistrict" data-val-required="Please select Residence Type">
                                                        <option value="0">--Select Western Odisha District--</option>
                                                        <option value="900">Angul (Athamallick Sub Division)</option>
                                                        <option value="901">Bargarh</option>
                                                        <option value="902">Balangir</option>
                                                        <option value="903">Boudh</option>
                                                        <option value="904">Deogarh</option>
                                                        <option value="905">Jharsuguda</option>
                                                        <option value="906">Kalahandi</option>
                                                        <option value="907">Nuapada</option>
                                                        <option value="908">Sambalpur</option>
                                                        <option value="909">Sonepur</option>
                                                        <option value="910">Sundargarh</option>                                                        
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="">
                                                <p class=""><i class="fa fa-info-circle pright5" style="color: #000;"></i>Western Odisha candidate need to upload <b>Permanent Residential Certificate </b>in attachment page. Please refer <b>Clause 3.4 of UG Prospectus - 2017</b> <span style="color: red;">*</span></p>

                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                <%--End Westeern Odisah Details--%>

                                <%--Start Employee Detail --%>
                                <div class="form-group" id="divEmplyeeCase">
                                    <div class="col-lg-12 othrinfohd">
                                        <div class="col-md-9 pleft0">
                                            <p><span><span class="fom-Numbx"><i class="fa fa-hand-o-right"></i></span><b>Reseavation under OUAT Employee quota</b></span></p>
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <div style="display: none">
                                            <div class="col-lg-12 othrinfosubhd2">
                                                <div class="col-md-9 pleft0">
                                                    <p class="pleft27 ptop5"><i class="fa fa-arrow-right pright5"></i>Name of the Employee<%--{{resourcesData.section8e}}--%></p>
                                                </div>
                                                <div class="col-md-3 pleft0 pright0">
                                                    <div class="col-xs-12 pright0 pleft0">
                                                        <input id="txtEmployeeName" class="form-control" name="txtEmployeeName" type="text" value="" autofocus="" placeholder="Name of the Employee" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12 othrinfosubhd2">
                                                <div class="col-md-9 pleft0">
                                                    <p class="pleft27 ptop5"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.empcode}}</p>
                                                </div>
                                                <div class="col-md-3 pleft0 pright0">
                                                    <div class="col-xs-12 pright0 pleft0">
                                                        <input id="txtEmpCode" class="form-control" name="txtEmpCode" type="text" value="" autofocus="" placeholder="Employee Code" title="Enter the employee code no." />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12 othrinfosubhd2">
                                                <div class="col-md-9 pleft0">
                                                    <p class="pleft27 ptop5"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.designation}}</p>
                                                </div>
                                                <div class="col-md-3 pleft0 pright0">
                                                    <div class="col-xs-12 pright0 pleft0">
                                                        <input id="txtDesignation" class="form-control" name="txtDesignation" type="text" value="" autofocus="" placeholder="Employee Designation" title="Enter the employee's designation" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12 othrinfosubhd2">
                                                <div class="col-md-9 pleft0">
                                                    <p class="pleft27"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.statusservice}}</p>
                                                </div>
                                                <div class="col-md-3 pleft0 pright0">
                                                    <div class="col-xs-12 pright0 pleft0">
                                                        <select name="ddlAcquitted" id="ddlServiceStatus" class="form-control" data-val="true" data-val-number="Service" data-val-required="Please select Status of Service">
                                                            <option value="0">--Select--</option>
                                                            <option value="101">Serving (Continuing)</option>
                                                            <option value="102">Retired</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12 othrinfosubhd2">
                                                <div class="col-md-9 pleft0">
                                                    <p class="pleft27 ptop5"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.officeOUAT}}</p>
                                                </div>
                                                <div class="col-md-3 pleft0 pright0">
                                                    <div class="col-xs-12 pright0 pleft0">
                                                        <input id="txtOffice" class="form-control" name="txtOffice" type="text" value="" autofocus="" placeholder="Office Name" title="Enter Name of the Office Serving / Last Served" />

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12 othrinfosubhd2">
                                                <div class="col-md-9 pleft0">
                                                    <p class="pleft27"><i class="fa fa-arrow-right pright5"></i>{{resourcesData.relationcandidate}}</p>
                                                </div>
                                                <div class="col-md-3 pleft0 pright0">
                                                    <div class="col-xs-12 pright0 pleft0">
                                                        <select name="ddlEmpRelation" id="ddlEmpRelation" class="form-control" data-val="true" data-val-number="Relation" data-val-required="Please select Relation">
                                                            <option value="0">--Select--</option>
                                                            <option value="101">Father</option>
                                                            <option value="102">Mother</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                         <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="">
                                                <p class=""><i class="fa fa-info-circle pright5" style="color: #000;"></i>OUAT Employee reservation category applicant need to upload the <b>scanned copy of filled Annexure-IV</b>. Please refer <b>Clause 3.5.4 of UG Prospectus - 2017</b> <span style="color: red;">*</span></p>
                                                
                                            </div>
                                            
                                        </div>

                                        <%---Start of EmployeeDetails----%>

                                        <%----End of EmployeeDetails-----%>
                                    </div>
                                </div>
                                <%--End of Employee Details--%>

                                <%--Start Kashmir Migrant Detail --%>
                                <div id="divKM">
                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfohd">
                                            <div class="col-md-9 pleft0">
                                                <p><span><span class="fom-Numbx"><i class="fa fa-hand-o-right"></i></span><b>Reseavation details under Kashmiri Migrant quota</b></span></p>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0">
                                                <p class="ptop5 pleft27"><i class="fa fa-arrow-right pright5"></i>Period of Stay in Kashmir</p>
                                            </div>
                                            <div class="col-md-3 pleft0">
                                                <div class="col-xs-6 pleft0">
                                                    {{resourcesData.from}}
                                        <input id="txtKMFrom" class="form-control" name="txtKMFrom" type="text" placeholder="DD/MM/YY" value="" autofocus="" />

                                                </div>
                                                <div class="col-xs-6 pleft0 pright0">
                                                    {{resourcesData.to}}
                                                <input id="txtKMTo" class="form-control" name="txtKMTo" type="text" placeholder="DD/MM/YY" value="" autofocus="" />

                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-md-9 pleft0">
                                                <p class="ptop5 pleft27"><i class="fa fa-arrow-right pright5"></i>Duration of Stay<%--No.of service years--%></p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-3 pleft0 pright0">
                                                    <input id="SevsYear" class="form-control mtop0" placeholder="Year" name="SevsYear" value="" maxlength="3" readonly="readonly" />

                                                </div>
                                                <div class="col-xs-4  pright0">
                                                    <input id="SevsMonth" class="form-control mtop0" placeholder="Month" name="SevsMonth" value="" maxlength="3" readonly="readonly" />
                                                </div>
                                                <div class="col-xs-5">
                                                    <input id="SevsDay" class="form-control mtop0" placeholder="Day" name="SevsDay" value="" maxlength="3" readonly="readonly" />

                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2">
                                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="">
                                                <p class=""><i class="fa fa-info-circle pright5" style="color: #000;"></i>To avail the reserved seat under Kashmiri Migrant, the candidate should have resided in Kashmir for at leat 5 Years between 01/01/1980 to 31/12/1999. They must upload Migration Certificate in attachment page. Please refer <b>Clause 3.5.2 of UG Prospectus - 2017</b> <span style="color: red;">*</span></p>

                                            </div>                                            
                                        </div>
                                    </div>
                                </div>
                                <%--End Kashmir Migrant Details--%>
                            </div>
                            <div class="clearfix">
                            </div>
                        </div>
                    </div>
                    <%--End Reservation Detail--%>

                        <div class="col-md-12 box-container pleft0 pright0" id="divHSC">
                            <div class="box-heading">
                                <h4 class="box-title">{{resourcesData.educationalQualificationofHSC}}
                                </h4>
                            </div>
                            <div class="box-body box-body-open p0">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p0">
                                    <div class="form-group" style="margin-bottom: 0">
                                        <table style="width: 100%; margin: 0;" class="table-striped table-bordered table">
                                            <tbody>
                                                <tr>
                                                    <th style="width: 75px;">
                                                        <label class="">
                                                            {{resourcesData.boardRollNo}}</label>
                                                    </th>
                                                    <th>
                                                        <label class="manadatory">
                                                            Name of the Board / Council, State</label></th>
                                                    <th style="">
                                                        <label class="manadatory">
                                                            {{resourcesData.nameoftheExaminationPassed}}</label>
                                                    </th>
                                                    <th style="width: 75px;">
                                                        <label class="manadatory">
                                                            {{resourcesData.yearofPassing}}</label>
                                                    </th>
                                                    <%--<th style="width: 75px;">
                                                        <label class="manadatory">
                                                            {{resourcesData.examCleared}}</label>
                                                    </th>--%>
                                                    <th style="width: 125px;">
                                                        <label class="manadatory">
                                                            {{resourcesData.grade}}</label>
                                                    </th>
                                                    <th style="width: 75px; white-space: normal;">
                                                        <label class="manadatory" id="lblTotalMarks">
                                                            {{resourcesData.totalMarks}}</label></th>
                                                    <th style="width: 75px;">
                                                        <label class="manadatory">
                                                            {{resourcesData.markSecured}}</label></th>
                                                    <th style="width: 75px;">
                                                        <label class="">
                                                            {{resourcesData.percentage}}</label></th>

                                                </tr>
                                                <tr>
                                                    <td>
                                                        <input id="txtBoardRollNo" class="form-control" placeholder="Roll of Board" name="txtBoardRollNo" type="text" value="" autofocus="" maxlength="30" />

                                                    </td>
                                                    <td>
                                                        <input id="txtBoardName" class="form-control" placeholder="Name of the Board / Council, State" name="txtBoardName" type="text" value="" autofocus="" maxlength="30" /></td>
                                                    <td>
                                                        <input id="txtExmntnName" class="form-control" placeholder="Examination Name" name="txtExmntnName" type="text" value="" autofocus="" maxlength="30"  />

                                                    </td>
                                                    <td>
                                                        <select name="txtPssngYr" id="txtPssngYr" class="form-control" data-val="true" data-val-number="Board" data-val-required="Please select.">
                                                            <option value="0">Select Year</option>
                                                            <option value="1998">1998</option>
                                                            <option value="1999">1999</option>
                                                            <option value="2000">2000</option>
                                                            <option value="2001">2001</option>
                                                            <option value="2002">2002</option>
                                                            <option value="2003">2003</option>
                                                            <option value="2004">2004</option>
                                                            <option value="2005">2005</option>
                                                            <option value="2006">2006</option>
                                                            <option value="2007">2007</option>
                                                            <option value="2008">2008</option>
                                                            <option value="2009">2009</option>
                                                            <option value="2010">2010</option>
                                                            <option value="2011">2011</option>
                                                            <option value="2012">2012</option>
                                                            <option value="2013">2013</option>
                                                            <option value="2014">2014</option>
                                                            <option value="2015">2015</option>
                                                            <option value="2016">2016</option>
                                                        </select>
                                                    </td>
                                                    <%--<td> 
                                                        <select name="ddlPasstype" id="ddlPasstype" class="form-control" data-val="true" data-val-number="Board" data-val-required="Please select District.">
                                                            <option value="0">Select Passing Type</option>
                                                            <option value="101">First attempt</option>
                                                            <option value="102">Compartmental</option>
                                                            <option value="103">Suplimentary</option>
                                                        </select>                                                       
                                                    </td>--%>
                                                    <td>
                                                        <select name="ddlPctgeCalclte" id="ddlPctgeCalclte" class="form-control" data-val="" data-val-number="" data-val-required="Please Select.">
                                                            <option value="0">-Select-</option>
                                                            <option value="502">Percentage</option>
                                                            <option value="501">CGPA</option>

                                                        </select>
                                                    </td>
                                                    <td>
                                                        <input id="txtTotalMarks" class="form-control" placeholder="Total Marks" name="txtTMarks" type="text" value="" autofocus="" maxlength="4" onkeypress="return isNumberKeyDecimal(event); " />
                                                    </td>
                                                    <td>
                                                        <input id="txtMarkSecure" class="form-control" placeholder="Marks Secure" name="txtMkSecure" type="text" value="" autofocus="" maxlength="4" onkeypress="return isNumberKey(event); " />
                                                    </td>
                                                    <td>
                                                        <input id="txtPercentage" class="form-control" name="txtPrcntge" type="text" value="" readonly="true" maxlength="5" />
                                                    </td>

                                                </tr>
                                            </tbody>
                                        </table>
                                        <div class="clearfix"></div>

                                    </div>
                                </div>
                                <div class="clearfix">
                                </div>
                            </div>
                        </div>
                        <%-- Start Subject Details of Class 12 --%>
                        <div class="row" id="divHSc2" runat="server">
                            <div class="col-md-12 box-container">
                                <div class="box-heading">
                                    <h4 class="box-title register-num">{{resourcesData.hSc2ouat}}
                                    </h4>
                                </div>
                                <div class="box-body box-body-open" style="">
                                    <div class="auto-style1" style="padding: 0px; margin-top: -15px">
                                        <table style="width: 100%; margin: 0;" class="table-striped table-bordered table">
                                            <tbody>
                                                <tr>
                                                    <th style="width: 75px;">
                                                        <label class="">
                                                            {{resourcesData.boardRollNo}}</label>
                                                    </th>
                                                    <th>
                                                        <label class="manadatory">
                                                            Name of the Board / Council, State</label></th>
                                                    <th style="">
                                                        <label class="manadatory">
                                                            Name of the Examination Passed (10+2 Sc.)</label>
                                                    </th>
                                                    <th style="width: 75px;">
                                                        <label class="manadatory">
                                                            {{resourcesData.yearofPassing}}</label>
                                                    </th>
                                                    <%--<th style="width: 75px;">
                                                        <label class="manadatory">
                                                            {{resourcesData.examCleared}}</label>
                                                    </th>--%>
                                                    <th style="width: 125px;">
                                                        <label class="manadatory">
                                                            {{resourcesData.grade}}</label>
                                                    </th>
                                                    <th style="width: 75px; white-space: normal;">
                                                        <label class="manadatory" id="lblTotalMarks2">
                                                            {{resourcesData.totalMarks}}</label></th>
                                                    <th style="width: 75px;">
                                                        <label class="manadatory">
                                                            {{resourcesData.markSecured}}</label></th>
                                                    <th style="width: 75px;">
                                                        <label class="">
                                                            {{resourcesData.percentage}}</label></th>

                                                </tr>
                                                <tr>
                                                    <td>
                                                        <input id="txtBoardRollNo2" class="form-control" placeholder="Roll of Board" name="txtBoardRollNo2" type="text" value="" autofocus="" maxlength="30" />

                                                    </td>
                                                    <td>
                                                        <input id="txtBoardName2" class="form-control" placeholder="Name of the Board / Council, State" name="txtBoardName2" type="text" value="" autofocus="" maxlength="30"  /></td>
                                                    <td>
                                                        <input id="txtExmntnName2" class="form-control" placeholder="Examination Name" name="txtExmntnName2" type="text" value="" autofocus="" maxlength="30"  />

                                                    </td>
                                                    <td>
                                                        <select name="txtPssngYr2" id="txtPssngYr2" class="form-control" data-val="true" data-val-number="Board" data-val-required="Please select.">
                                                            <option value="0">Select Year</option>
                                                            <option value="1998">1998</option>
                                                            <option value="1999">1999</option>
                                                            <option value="2000">2000</option>
                                                            <option value="2001">2001</option>
                                                            <option value="2002">2002</option>
                                                            <option value="2003">2003</option>
                                                            <option value="2004">2004</option>
                                                            <option value="2005">2005</option>
                                                            <option value="2006">2006</option>
                                                            <option value="2007">2007</option>
                                                            <option value="2008">2008</option>
                                                            <option value="2009">2009</option>
                                                            <option value="2010">2010</option>
                                                            <option value="2011">2011</option>
                                                            <option value="2012">2012</option>
                                                            <option value="2013">2013</option>
                                                            <option value="2014">2014</option>
                                                            <option value="2015">2015</option>
                                                            <option value="2016">2016</option>
                                                            <option value="2017">2017</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <select name="ddlPctgeCalclte2" id="ddlPctgeCalclte2" class="form-control" data-val="" data-val-number="" data-val-required="Please Select.">
                                                            <option value="0">-Select-</option>
                                                            <option value="502">Percentage</option>
                                                            <%--<option value="501">CGPA</option>--%>

                                                        </select>
                                                    </td>
                                                    <td>
                                                        <input id="txtTotalMarks2" class="form-control" placeholder="Total Marks" name="txtTotalMarks2" type="text" value="" autofocus="" maxlength="4" onkeypress="return isNumberKeyDecimal(event); " />
                                                    </td>
                                                    <td>
                                                        <input id="txtMarkSecure2" class="form-control" placeholder="Marks Secure" name="txtMarkSecure2" type="text" value="" autofocus="" maxlength="4" onkeypress="return isNumberKey(event); " />
                                                    </td>
                                                    <td>
                                                        <input id="txtPercentage2" class="form-control" name="txtPercentage2" type="text" value="" readonly="true" maxlength="5" />
                                                    </td>

                                                </tr>
                                            </tbody>
                                        </table>


                                    </div>
                                    <div class="clearfix">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--End Subject Details of Class 12--%>

                        <%-- Start Subject Details of Class 12 --%>
                        <div class="row" id="div1" runat="server">
                            <div class="col-md-12 box-container">
                                <div class="box-heading">
                                    <h4 class="box-title register-num">Select Marks Pattern and enter the marks scrored in 10+2 Science Examination
                                    </h4>
                                </div>
                                <div class="box-body box-body-open" style="padding: 0px;">
                                    <table style="width: 100%; margin: 0;" class="table-striped table-bordered table">
                                        <tr>
                                            <td>
                                                <input type="radio" name="marks" id="rbtnMarkN" value="yes2" onchange="return checked();" onclick="return fuMarksPartern('1');" />CHSE Marks Pattern (Separate marks for Theory & Practical)
                                             </td>
                                            <td>                                                
                                                <input type="radio" name="marks" id="rbtnMarkY" value="yes1" onchange="return checked();" onclick="return fuMarksPartern('0');" />ICSE / CBSE & Other Board Marks Pattern (Combined marks including Theory & Practical)
                                           
                                                </td>

                                        </tr>
                                    </table>
                                    <div style="color: #820000; font-weight: bold;">
                                        <p style="color: #820000 !important;">For CHSE : Enter zero (0 as numeric) for mathematics or Botany and Zoology if not studied.</p>
                                        <p style="color: #820000 !important;">For CBSE, ICSC and other boards: Enter zero (0 as numeric) for Mathematics or Biology if not studied. </p>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <div class="row" id="divMarks">
                                        <div class="form-group col-md-12" style="margin-bottom: 0 !important;">
                                            <table style="width: 100%; margin-bottom: 0;" class="table table-striped table-bordered">
                                                <tbody>
                                                    <tr>
                                                        <th style="text-align: center;">
                                                            <asp.Label for="">
                                                                Sl. No.</asp.Label></th>
                                                        <th style="text-align: center; width: 20%;">
                                                            <label class="manadatory" for="">
                                                                Name of Subject</label>
                                                        </th>
                                                        <th style="text-align: center;">
                                                            <label id="lblTheoryTotal">
                                                                Total Mark in Theory</label>
                                                        </th>
                                                        <th style="text-align: center;">
                                                            <label id="lblTheoryObtain">
                                                                Mark Obtain in Theory</label>
                                                        </th>
                                                        <th style="text-align: center;" id="thPTM">
                                                            <label id="lblPractTotal">
                                                                Total Mark<br />
                                                                in Practical</label>
                                                        </th>
                                                        <th style="text-align: center;" id="thPMO">
                                                            <label id="lblPractObtain">
                                                                Marks Obtain<br />
                                                                Practical</label>
                                                        </th>
                                                        <th style="text-align: center;"><label id="lblMarks">
                                                               </label></th>
                                                        <th style="text-align: center;"><label id="lblObtain">
                                                                </label></th>
                                                    </tr>
                                                    <tr>
                                                        <td style="">1.</td>
                                                        <td style="">
                                                            <select name="ddlSubject" id="ddlSubjectPhysics" class="form-control" data-val="true" data-val-number="Village." data-val-required="Please select subject">

                                                                <option value="Physics">Physics</option>

                                                            </select>
                                                        </td>
                                                        <td style="">
                                                            <input id="txtTMT_Physics" class="form-control" placeholder="0" name="txtTotalPhysics0" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td style="">
                                                            <input id="txtMOT_Physics" class="form-control" placeholder="0" name="txtTotalPhysics1" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td style="" id="tdPTMP">
                                                            <input id="txtTMP_Physics" class="form-control" placeholder="0" name="txtTotalPhysics" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus />
                                                        </td>
                                                        <td style="" id="thPMOP">
                                                            <input id="txtMOP_Physics" class="form-control" placeholder="0" name="txtMarksObtainPhysics" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus maxlength="99" />
                                                        </td>
                                                        <td style="">
                                                            <input id="txtTMTP_Physics" class="form-control" placeholder="0" name="txtTotalPhysics15" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>
                                                        <td style="">
                                                            <input id="txtTMOTP_Physics" class="form-control" placeholder="0" name="txtTotalPhysics10" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="">2.</td>
                                                        <td style="">
                                                            <select name="ddlSubject" id="ddlSubjectChemistry" class="form-control" data-val="true" data-val-required="Please select subject">

                                                                <option value="Chemistry">Chemistry</option>

                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input id="txtTMT_Chemistry" class="form-control" placeholder="0" name="txtTotalPhysics2" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td>
                                                            <input id="txtMOT_Chemistry" class="form-control" placeholder="0" name="txtTotalPhysics3" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td id="tdPTMC">
                                                            <input id="txtTMP_Chemistry" class="form-control" placeholder="0" name="txtTotalChemistry" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus />
                                                        </td>
                                                        <td style="text-align: right" id="thPMOC">
                                                            <input id="txtMOP_Chemistry" class="form-control" placeholder="0" name="txtMarksObtainChemistry" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus maxlength="99" />
                                                        </td>
                                                        <td style="text-align: right">
                                                            <input id="txtTMTP_Chemistry" class="form-control" placeholder="0" name="txtTotalPhysics16" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>
                                                        <td style="text-align: right"> 
                                                            <input id="txtTMOTP_Chemistry" class="form-control" placeholder="0" name="txtTotalPhysics11" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="">3.</td>
                                                        <td style="">
                                                            <select name="ddlSubject" id="ddlSubjectMath" class="form-control" data-val="true" data-val-required="Please select subject">

                                                                <option value="Mathematics">Mathematics</option>
                                                            </select>
                                                        </td>
                                                        <td style="">
                                                            <input id="txtTMT_Maths" class="form-control" placeholder="0" name="txtTotalPhysics4" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td style="">
                                                            <input id="txtMOT_Maths" class="form-control" placeholder="0" name="txtTotalPhysics5" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td style="" id="tdPTMPM">
                                                            <input id="txtTMP_Maths" class="form-control" placeholder="0" name="txtTotalMath" type="text" value="0" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" />
                                                        </td>
                                                        <td style="" id="thPMOM">
                                                            <input id="txtMOP_Maths" class="form-control" placeholder="0" name="txtMarksObtainMath" type="text" value="0" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" />
                                                        </td>
                                                        <td style="">
                                                            <input id="txtTMTP_Maths" class="form-control" placeholder="0" name="txtTotalPhysics17" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>
                                                        <td style="">
                                                            <input id="txtTMOTP_Maths" class="form-control" placeholder="0" name="txtTotalPhysics12" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="">4.</td>
                                                        <td style="">
                                                            <%--<select name="ddlSubject" id="ddlSubjectBio" class="form-control" data-val="true" data-val-required="Please select subject">

                                                                <option value="Biology">Botany</option>
                                                            </select>--%>
                                                            <span id="ddlSubjectBio">Botany</span>
                                                        </td>
                                                        <td style="">
                                                            <input id="txtTMT_Botany" class="form-control" placeholder="0" name="txtTotalPhysics6" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td style="">
                                                            <input id="txtMOT_Botany" class="form-control" placeholder="0" name="txtTotalPhysics7" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td style="" id="tdPTMB">
                                                            <input id="txtTMP_Botany" class="form-control" placeholder="0" name="txtTotalBio" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus />
                                                        </td>
                                                        <td style="" id="thPMOB">
                                                            <input id="txtMOP_Botany" class="form-control" placeholder="0" name="txtMarksObtainBio" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus maxlength="99" />
                                                        </td>
                                                        <td style="">
                                                            <input id="txtTMTP_Botany" class="form-control" placeholder="0" name="txtTotalPhysics18" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>

                                                        <td style="">
                                                            <input id="txtTMOTP_Botany" class="form-control" placeholder="0" name="txtTotalPhysics13" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>

                                                    </tr>
                                                    <tr id="trZoo">
                                                        <td style="">5.</td>
                                                        <td style="">
                                                            <select name="ddlSubjectZoo" id="ddlSubjectZoo" class="form-control" data-val="true" data-val-required="Please select subject">

                                                                <option value="Zoology">Zoology</option>
                                                            </select>
                                                        </td>
                                                        <td style="">
                                                            <input id="txtTMT_Zoology" class="form-control" placeholder="0" name="txtTotalPhysics8" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td style="">
                                                            <input id="txtMOT_Zoology" class="form-control" placeholder="0" name="txtTotalPhysics9" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus /></td>
                                                        <td style="" id="tdPTMPZ">
                                                            <input id="txtTMP_Zoology" class="form-control" placeholder="0" name="txtTotalZoo" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus />
                                                        </td>
                                                        <td style="" id="thPMOZ">
                                                            <input id="txtMOP_Zoology" class="form-control" placeholder="0" name="txtMarksObtainZoo" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus maxlength="99" />
                                                        </td>
                                                        <td style="">
                                                            <input id="txtTMTP_Zoology" class="form-control" placeholder="0" name="txtTotalPhysics19" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>

                                                        <td style="">
                                                            <input id="txtTMOTP_Zoology" class="form-control" placeholder="0" name="txtTotalPhysics14" type="text" value="" style="text-align: right" onchange="TotalMarksInTheory();" maxlength="3" onkeypress="return isNumberKey(event);"
                                                                autofocus readonly="true" /></td>

                                                    </tr>
                                                    <tr style="font-weight: bold; display: none;">
                                                        <td style="text-align: left; font-weight: bold;" colspan="2">TOTAL</td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" style="font-weight: bolder;" id="txtTMT_Total">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" style="font-weight: bolder;" id="txtMOT_Total">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;" id="tdPTMPT">
                                                            <label runat="server" style="font-weight: bolder;" id="txtTMP_Total">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;" id="thPMOT">
                                                            <label runat="server" style="font-weight: bolder;" id="txtMOP_Total">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" style="font-weight: bolder;" id="txtTMTP_Total">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" style="font-weight: bolder;" id="txtTMOTP_Total">0</label></td>

                                                    </tr>
                                                    <tr style="font-weight: bold">
                                                        <td style="" colspan="2">Marks in PCM
                                                            <label runat="server" style="font-weight: bolder; margin-left: 20px; width: 50px; float: right;" id="lblPCM">(  0%  )</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" id="txtTMT_PCM">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" id="txtMOT_PCM">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;" id="tdPTMPTPCM">
                                                            <label runat="server" id="txtTMP_PCM">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;" id="thPMOPCM">
                                                            <label runat="server" id="txtMOP_PCM">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" id="txtTMTP_PCM">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" id="txtTMOTP_PCM">0</label></td>

                                                    </tr>
                                                    <tr style="font-weight: bold">
                                                        <td style="" colspan="2">Marks in PCB
                                                            <label runat="server" style="font-weight: bolder; margin-left: 20px; width: 50px; float: right;" id="lblPCB">(  0%  )</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" id="txtTMT_PCB">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" id="txtMOT_PCB">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;" id="tdPTMPTPCB">
                                                            <label runat="server" id="txtTMP_PCB">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;" id="thPMOPCB">
                                                            <label runat="server" id="txtMOP_PCB">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" id="txtTMTP_PCB">0</label></td>
                                                        <td style="text-align: right; font-weight: bold;">
                                                            <label runat="server" id="txtTMOTP_PCB">0</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix">
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--End Subject Details of Class 12--%>
                    <%-- Start Subject Details of Class 12 --%>
                    <div class="row" id="divAgro" runat="server">
                        <div class="col-md-12 box-container">
                            <div class="box-heading">
                                <h4 class="box-title register-num">{{resourcesData.diplomaAgro}}
                                </h4>
                            </div>
                            <div class="box-body box-body-open" style="">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding: 0px; margin-top: -15px">

                                    <table style="width: 100%; margin: 0;" class="table-striped table-bordered table">
                                        <tbody>
                                            <tr>
                                                <th style="width: 75px;">
                                                    <label class="manadatory">
                                                        {{resourcesData.boardRollNo}}</label>
                                                </th>
                                                <th style="">
                                                    <label class="manadatory">
                                                        {{resourcesData.state}}</label></th>
                                                <th style="">
                                                    <label class="manadatory">
                                                        {{resourcesData.nameoftheBoardCouncil}}</label></th>
                                                <th style="">
                                                    <label class="manadatory">
                                                        {{resourcesData.nameoftheExaminationPassed}}</label>
                                                </th>
                                                <th style="width: 75px;">
                                                    <label class="manadatory">
                                                        {{resourcesData.yearofPassing}}</label>
                                                </th>
                                                <th style="width: 75px;">
                                                    <label class="manadatory">
                                                        {{resourcesData.grade}}</label>
                                                </th>
                                                <th style="width: 100px;">
                                                    <label class="manadatory" id="lblTotalAgro">
                                                        {{resourcesData.totalMarks}}</label></th>
                                                <th style="width: 75px;">
                                                    <label class="manadatory">
                                                        {{resourcesData.markSecured}}</label></th>
                                                <th style="width: 75px;">
                                                    <label class="">
                                                        {{resourcesData.percentage}}</label></th>

                                            </tr>
                                            <tr>
                                                <td>
                                                    <input id="txtBoardRollNoAgro" class="form-control" placeholder="Roll of Board" name="txtBoardRollNo" type="text" value="" autofocus="" maxlength="30" />

                                                </td>
                                                <td>
                                                    <select name="EddlBoardState" id="EddlBoardStateAgro" class="form-control" data-val="true" data-val-number="Board" data-val-required="Please select State.">
                                                    </select></td>
                                                <td>
                                                    <select name="ddlBoard" id="ddlBoardAgro" class="form-control" data-val="true" data-val-number="Board" data-val-required="Please select District.">
                                                        <option value="0">-Select-</option>
                                                    </select></td>
                                                <td>
                                                    <input id="txtExmntnNameAgro" class="form-control" placeholder="Examination Name" name="txtExmntnName" type="text" value="" autofocus="" maxlength="30" onkeypress="return ValidateAlpha(event);" />

                                                </td>
                                                <td>
                                                    <select name="txtPssngYr" id="txtPssngYrAgro" class="form-control" data-val="true" data-val-number="Board" data-val-required="Please select.">
                                                        <option value="0">Select Year</option>
                                                        <option value="1998">1998</option>
                                                        <option value="1999">1999</option>
                                                        <option value="2000">2000</option>
                                                        <option value="2001">2001</option>
                                                        <option value="2002">2002</option>
                                                        <option value="2003">2003</option>
                                                        <option value="2004">2004</option>
                                                        <option value="2005">2005</option>
                                                        <option value="2006">2006</option>
                                                        <option value="2007">2007</option>
                                                        <option value="2008">2008</option>
                                                        <option value="2009">2009</option>
                                                        <option value="2010">2010</option>
                                                        <option value="2011">2011</option>
                                                        <option value="2012">2012</option>
                                                        <option value="2013">2013</option>
                                                        <option value="2014">2014</option>
                                                        <option value="2015">2015</option>
                                                        <option value="2016">2016</option>
                                                        <option value="2016">2016</option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <select name="ddlPctgeCalclte" id="ddlPctgeCalclteAgro" class="form-control" data-val="" data-val-number="" data-val-required="Please Select.">
                                                        <option value="0">-Select-</option>
                                                        <option value="502">Percentage</option>
                                                        <option value="501">CGPA</option>

                                                    </select>
                                                </td>
                                                <td>
                                                    <input id="txtTotalMarksAgro" class="form-control" placeholder="Total Marks" name="txtTMarks" type="text" value="" autofocus="" maxlength="4" onkeypress="return isNumberKeyDecimal(event); " />
                                                </td>
                                                <td>
                                                    <input id="txtMarkSecureAgro" class="form-control" placeholder="Marks Secure" name="txtMkSecure" type="text" value="" autofocus="" maxlength="4" onkeypress="return isNumberKey(event); " />
                                                </td>
                                                <td>
                                                    <input id="txtPercentageAgro" class="form-control" name="txtPrcntge" type="text" value="" readonly="true" maxlength="5" />
                                                </td>

                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="clearfix">
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--End Subject Details of Class 12--%>

                    
                                       <%---Start of Other Information----%>
                        <div id="divOtherInfoDomicile" class="col-md-12 box-container pleft0 pright0">
                            <div class="box-heading">
                                <h4 class="box-title pleft0">Domicile Information
                                </h4>
                            </div>
                            <div class="box-body box-body-open">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfohd">
                                            <div class="col-md-9 pleft0 ">
                                                <p>
                                                    <span class="dplyflex">
                                                        <span id="isOdia" class="manadatory">Has the Candidate passed Odia as one of the subject in HSC Examination?</span>
                                                    </span>
                                                </p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-6 pleft0">
                                                    <input type="radio" name="radio1" id="yes" value="yes" onclick="return fnLanguage('divLang');" />
                                                    <label for="yes">{{resourcesData.yes}}</label>
                                                </div>
                                                <div class="col-xs-6">
                                                    <input type="radio" name="radio1" id="no" value="no" onclick="return fnLanguage('divResi');" />
                                                    <label for="no">{{resourcesData.no}}</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-lg-12 othrinfosubhd2" id="divLang">
                                            <div class="col-md-9 pleft0">
                                                <p class="pleft27"><i class="fa fa-arrow-right pright5"></i> <span id="chkAbility">{{resourcesData.noabilitytoOdialang}}</span></p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-4 pleft0" style="white-space: nowrap;">
                                                    <input type="checkbox" name="readOdiya" id="readOdiya" />{{resourcesData.read}}
                                    <label for="checkbox"></label>

                                                </div>
                                                <div class="col-xs-4" style="white-space: nowrap;">
                                                    <input type="checkbox" name="writeOdiya" id="writeOdiya" />{{resourcesData.write}}
                                            <label for="checkbox"></label>

                                                </div>
                                                <div class="col-xs-4" style="white-space: nowrap;">
                                                    <input type="checkbox" name="spkOdiya" id="spkOdiya" />{{resourcesData.speak}}<label for="checkbox"></label>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2" id="divResi">
                                            <div class="col-md-9 pleft0">
                                                <p class="pleft27"><i class="fa fa-arrow-right pright5"></i>Residence Type (Need to provide valid document when asked)</p>
                                            </div>
                                            <div class="col-md-3 pleft0 pright0">
                                                <div class="col-xs-12 pleft0 pright0">
                                                    <select name="ddlResidence" id="ddlResidence" class="form-control" data-val="true" data-val-number="ddlResidence" data-val-required="Please select Residence Type">
                                                        <option value="0">--Select Residence Type--</option>
                                                        <option value="200">Permanent resident of Odisha.</option>
                                                        <option value="201">Odia candidate residing outside Odisha.</option>
                                                        <option value="202">Outside state Candidate's whose parents are serverving in Odisha</option>
                                                    </select>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-lg-12 othrinfosubhd2" id="divInstruction">

                                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="">
                                                <p class=""><i class="fa fa-info-circle pright5" style="color: #000;"></i>Candidate need to upload the <b>Domicile Certificate</b> with FORM-'B' (in attachment page). Please refer <b>Clause 2.2</b> <span style="color: red;">*</span></p>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="clearfix"></div>

                                </div>
                                <div class="clearfix">
                                </div>
                            </div>
                        </div>
                        <%---Start of Other Information----%>

                <%---Start of Declaration----%>
                
                        <uc1:OUATDeclaration runat="server" ID="OUATDeclaration" ClientIDMode="Static" />
                                    <%----End of Declaration-----%>
                    <div class="row">
                        <div class="col-md-12 box-container" style="margin-top: 5px;">
                            <div class="box-body box-body-open" style="text-align: center;">
                                <span style="color:maroon;font-size:20px;font-weight:bold">
                                    Please recheck the Application FORM-B before submitting the Application. No edit or correction shall be entertained. 
                                </span>
                            </div>
                        </div>
                    </div>

                <div id="divBtn" class="row">
                    <div class="col-md-12 box-container" style="margin-top: 5px;">
                        <div class="box-body box-body-open" style="text-align: center;">
                            <input type="button" id="btnSubmit" class="btn btn-success" value="Next"   title="Proceed to Upload Necessary Document" />
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Cancel" ToolTip="Refresh the page"
                                CssClass="btn btn-danger" PostBackUrl=""
                                Text="Cancel" />
                            <asp:Button ID="btnHome" runat="server"
                                CssClass="btn btn-primary" PostBackUrl="" ToolTip="Back to Home Page"
                                Text="Home" />
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                </div>
            </div>
        </div>
    </div>
 </div>
    <asp:HiddenField ID="HFServiceID" runat="server" Value="388" />
    <asp:HiddenField ID="HFb64" runat="server" />
    <asp:HiddenField ID="HFSizeOfPhoto" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="HFUIDData" runat="server" />
    <asp:HiddenField ID="HFb64Sign" runat="server" />
    <asp:HiddenField ID="HFSizeOfSign" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="HFCurrentLang" runat="server" ClientIDMode="Static" />

</asp:Content>
