﻿<%@ Page Title="" Language="C#" MasterPageFile="~/WebApp/Kiosk/Master/KioskMaster.Master" AutoEventWireup="true" CodeBehind="DocumnetVerification.aspx.cs" Inherits="CitizenPortal.WebApp.Kiosk.VerificationSU.DocumnetVerification" %>

<%@ Register Src="~/WebApp/Control/FormTitle.ascx" TagPrefix="uc1" TagName="FormTitle" %>
<%@ Register Src="~/WebApp/Control/Address.ascx" TagPrefix="uc1" TagName="Address" %>
<%@ Register Src="~/WebApp/Control/ApplicationSteps.ascx" TagPrefix="uc1" TagName="ApplicationSteps" %>
<%@ Register Src="~/WebApp/Control/Declaration.ascx" TagPrefix="uc1" TagName="Declaration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/jquery-ui-1.11.4.min.js"></script>
    <script src="/Scripts/jquery.msgBox.js"></script>
    <link href="/PortalStyles/msgBoxLight.css" rel="stylesheet" />
    <script src="/Scripts/fileupload/vendor/jquery.ui.widget.js"></script>
    <script src="/Scripts/fileupload/jquery.iframe-transport.js"></script>
    <script src="/Scripts/fileupload/jquery.fileupload.js"></script>
    <script src="/PortalScripts/ServiceLanguage.js"></script>
    <link href="/PortalStyles/jquery-ui.min.css" rel="stylesheet" />
    <script src="../../Scripts/ValidationScript.js"></script>
    <script src="../../Scripts/CommonScript.js"></script>
    <script src="DocumnetVerification.js"></script>
    <style>
        .ui-widget-header {
            color: #333 !important;
            font-weight: normal !important;
        }
        .ui-widget-header {
            color: #333 !important;
            font-weight: normal !important;
        }

        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="intrnlContent" ng-app="appmodule">
        <div ng-controller="ctrl">
            <div id="page-wrapper" style="min-height: 500px !important;">
                <div class="row">
                    <div class="col-lg-12">
                    </div>
                </div>
                <div class="clearfix">
                    <%--<uc1:FormTitle runat="server" ID="FormTitle" />--%>
                    <h2 class="form-heading"><i class="fa fa-pencil-square-o"></i>{{titleData.lblTitle}}
                    </h2>
                </div>
                <div class="clearfix">
                    <uc1:ApplicationSteps runat="server" ID="ApplicationSteps" />
                </div>

                <div class="row" id="divDetail" runat="server">
                    <%---Start of DeceasedDetails----%>
                    <div class="col-md-6 box-container mTop15">
                        <div class="box-heading">
                            <h4 class="box-title">Candidate Details <span style="font-size:12px;">(whose document is to be verified)</span>
                            </h4>
                        </div>
                        <div class="box-body box-body-open">        
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="form-group">
                                    <label class="manadatory" for="ddlStudent">
                                        Student Type</label>
                                    <select name="ddlStudent" id="ddlStudent" class="form-control" data-val="true" data-val-number="" data-val-required="Please select Trade Name">
                                        <option value="0">Select Type of Student</option>
                                        <option value="1">Regular</option>
                                        <option value="2">Non Collegiate</option>
                                        <option value="3">Distance Student</option>
                                    </select>
                                </div>
                            </div>                    
                            <div class="col-xs-6 col-sm-6 col-md-12 col-lg-4">
                                <div class="form-group">
                                    <label class="manadatory" for="txtRegistration">
                                        Registration No.</label>
                                    <input id="txtRegistration" class="form-control" placeholder="Registration Number as a student of State Council" name=" txtRegistration" type="text" value=""
                                      maxlength="22" autofocus />
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-12 col-lg-4">
                                <div class="form-group">
                                    <label class="manadatory" for="txtRoll">
                                        Roll No.</label>
                                    <input id="txtRoll" class="form-control" placeholder="Roll Number" name="txtRoll" type="text" value=""
                                       autofocus />
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="form-group">
                                    <label class="manadatory" for="ddlPassing">
                                        Year of Passing</label>
                                    <select class="form-control" data-val="true" data-val-number="Session"
                                        data-val-required="Please select Session" id="ddlPassing" name="ddlSession" runat="server">
                                        <option value="0">Select Year of Passing</option>
                                        <option value="101">2016</option>
                                        <option value="102">2015</option>
                                        <option value="103">2014</option>
                                        <option value="104">2013</option>
                                        <option value="105">2012</option>
                                        <option value="106">2011</option>
                                        <option value="101">2010</option>
                                        <option value="102">2009</option>
                                        <option value="103">2008</option>
                                        <option value="104">2007</option>
                                        <option value="105">2006</option>
                                        <option value="106">2005</option>
                                        <option value="103">2004</option>
                                        <option value="104">2003</option>
                                        <option value="105">2002</option>
                                        <option value="106">2001</option>
                                    </select>                                    
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="form-group">
                                    <label class="manadatory" for="ddlBranch">
                                        Branch</label>
                                    <select class="form-control" data-val="true" data-val-number="Branch"
                                        data-val-required="Please select Branch" id="ddlBranch" name="ddlBranch" runat="server">
                                        <option value="0">Select Branch</option>
                                        <option value="BAHons">B.A (Hons.)</option>
                                        <option value="BAPass">B.A (Pass.)</option>
                                        <option value="BComHons">B.Com (Hons.)</option>
                                        <option value="BComPass">B.Com (Pass.)</option>
                                        <option value="ScHons">B.Sc (Hons.)</option>
                                        <option value="ScPass">B.Sc (Pass.)</option>

                                    </select>
                                </div>
                            </div>                           
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="form-group">
                                    <label class="" for="ddlResult">
                                        Result</label>
                                    <select name="ddlResult" id="ddlResult" class="form-control" data-val="true" data-val-number="" data-val-required="Please select Trade Name">
                                        <option value="0">--Select Result--</option>
                                        <option value="Distinction">Distinction</option>
                                        <option value="Hons">Hons</option>
                                        <option value="1">1st Division</option>
                                        <option value="2">2nd Division</option>
                                        <option value="3">3rd Division</option>
                                        <option value="Passed">Passed</option>

                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-12">
                                <div class="form-group">
                                    <label class="manadatory" for="ddlCollege">
                                        Name of College</label>
                                        <select name="ddlCollege" id="ddlCollege" class="form-control" data-val="true" data-val-number="" data-val-required="Please select Institute Name">
                                            <option value="0">Select College Name</option>
                                        </select>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3" style="display:none">
                                <div class="form-group">
                                    <label class="manadatory" for="ddlApplicantType">
                                        Applicant Type</label>
                                    <select class="form-control" data-val="true" data-val-number="Session" onchange="fnApplicantType();"
                                        data-val-required="Please select Session" id="ddlApplicantType" name="ddlApplicantType">
                                        <option value="0">Select Applicant Type</option>
                                        <option value="101">Student</option>
                                        <option value="102">Institue</option>
                                        <option value="102">Organisation</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-12">
                                <div class="form-group">
                                    <label class="manadatory" for="txtInstitute" >
                                        Name of Candidate (whose verification is to be done)</label>
                                    <input id="txtName" class="form-control" placeholder="Enter Name of the Candidate/Student" name=" txtInstitute" type="text" value=""
                                      maxlength="22" onkeypress="return ValidateAlpha(event)"  autofocus />
                                </div>
                            </div>
                             
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-12">
                                <div class="form-group">
                                    <label class="" for="txReason" id="lblReason">
                                        Reason</label>
                                    <input id="txReason" class="form-control" placeholder="Reason " name=" txReason" type="text" value=""
                                    maxlength="22" onkeypress="return ValidateAlpha(event)"      autofocus />
                                </div>
                            </div>

                            <div class="clearfix">
                            </div>
                        </div>
                    </div>
                    <%----End of DeceasedDetails-----%>
                    <div class="col-md-6 box-container mTop15">
                        <div class="box-heading">
                            <h4 class="box-title">Company / Institute  Details <span style="font-size:12px">(who wants verification)</span>
                            </h4>
                        </div>
                        <div class="box-body box-body-open">  
                           <div class="col-xs-12 col-sm-6 col-md-6 col-lg-12" id="divApplicant">
                                <div class="form-group">
                                    <label class="manadatory" for="txtInstitute" id="lblApplicant">
                                        Name of Institute / Organisation (who wants verification document)</label>
                                    <input id="txtInstitute" class="form-control" placeholder="Enter Name of the Institute" name=" txtInstitute" type="text" value=""
                                     maxlength="50" onkeypress="return AlphaNumeric(event)"   autofocus />
                                </div>
                            </div>
                            <uc1:Address runat="server" ID="Address2" ClientIDMode="Inherit" />

                            <div class="clearfix">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 box-container" id="Div2">
                        <div class="box-heading">
                            <h4 class="box-title register-num">{{resourcesData.lblDeclaration}}
                            </h4>
                        </div>
                        <%--<uc1:Declaration runat="server" id="Declaration" />--%>
                        <uc1:Declaration runat="server" ID="Declaration" />
                    </div>
                </div>
                <%----End of Declaration-----%>

                <%---Start of Button----%>
                <div class="row" id="divButton" runat="server">
                    <div class="col-md-12 box-container" id="divBtn">
                        <div class="box-body box-body-open" style="text-align: center;">
                            <input type="button" id="btnSubmit" class="btn btn-success" value="Next =>>" />
                            <asp:Button ID="btnCancel" runat="server" CausesValidation="True" CommandName="Cancel"
                                CssClass="btn btn-danger" PostBackUrl=""
                                Text="Cancel" />
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                </div>
                <%---End of Button----%>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="HFServiceID" runat="server" Value="" />
    <input type="text" ng-show="false" id="ngServiceID" name="ServiceID" ng-value="ServiceID" value="100" ng-model="ServiceID" runat="server" visible="false" />
</asp:Content>
