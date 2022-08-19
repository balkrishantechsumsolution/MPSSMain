﻿<%@ Page Title="" Language="C#" MasterPageFile="~/WebApp/G2G/Master/G2GMaster.Master" AutoEventWireup="true" CodeBehind="BulkPayAppList.aspx.cs" Inherits="CitizenPortal.WebApp.G2G.BulkPayment.BulkPayAppList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Data Entry Report View</title>
    <script src="/WebApp/Login/js/jquery-1.12.3.js"></script>
    <script src="/Scripts/jquery-ui-1.11.4.min.js"></script>
    <script src="/Scripts/jquery.msgBox.js"></script>
    <link href="/PortalStyles/msgBoxLight.css" rel="stylesheet" />
    <script src="/WebApp/Login/js/jquery.dataTables.min.js"></script>
    <script src="/WebApp/Citizen/Forms/Js/jqueryDataTableButtons-1.2.4.js"></script>

    <link href="/PortalStyles/jquery-ui.min.css" rel="stylesheet" />
    <link href="/WebApp/Login/css/bootstrap.css" rel="stylesheet" />
    <link href="/g2c/css/hmepge.bootstrap.css" rel="stylesheet" />
    <link href="/WebApp/Citizen/Forms/Css/jQueryDataTableButtons.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {


            debugger;
            var table = $("table[id$='DataGridView']").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable
                ({
                    dom: 'Bfrtip',
                    buttons: ['pageLength'],
                    "lengthMenu": [[10, 50, 100], [10, 50, 100]],
                    "iDisplayLength": 10
                });

            $("div[id$='LoadingDiv']").hide(800);
            $("div[id$='DisplayGrid']").show(800);
            $('#DivAmt').hide();

            //calculate sum of selected rows
            $('[id*=chkappid]').on('change', function () {
                var value = 0;
                $('[id*=chkappid]:checked').each(function () {
                    var row = $(this).closest('tr');
                    value = value + parseInt(row.find('[id*=lbltotalamt]').html());
                });
                $('#tamt').text(value);
                if (value != null && value != '') {
                    $('#DivAmt').show(800);
                }
            });
        });

        function checkActive() {
            if (($('#ContentPlaceHolder1_ddlExamType').val() == '2') && ($('#ContentPlaceHolder1_ddlSemester').val() == '5SEM')) {
                alert('Data not received for 5SEM Back Student from University!')
                $('#ContentPlaceHolder1_ddlSemester').val(0);
                return false;
            }
        }

        //function getSelected() {
        //    debugger;
        //    var table = $("table[id$='DataGridView']");
        //    var checkedValues = $("input:checkbox:checked", "table[id$='DataGridView']").map(function () {
        //        return $(this).closest('tr').find('td:nth-child(0)').text();
        //    }).get();
        //    console.log(checkedValues.join(", "));
        //}
    </script>
    <style>
        .ui-widget-header {
            color: #333 !important;
            font-weight: normal !important;
        }

        .pagination {
            color: #000 !important;
            display: block !important;
            margin: 0 !important;
            padding: 10px;
        }

            .pagination label {
                display: inline-block;
                max-width: 100%;
                margin-bottom: 5px;
                font-weight: bold;
            }

        .SrvDiv {
            background-color: #fff;
            border: solid 1px #ddd;
            color: #045abc;
            width: 32.1%;
            margin: .5%;
            float: left;
            padding: .5%;
            overflow: auto;
            font-size: 18px;
            border-radius: 5px;
            border-left: solid 5px #B65838;
        }

            .SrvDiv a {
                color: #472A26;
                font-size: .9em;
                text-decoration: none;
                font-weight: bold;
            }

                .SrvDiv a:hover {
                    color: #5AB1D0;
                    font-size: .9em;
                    text-decoration: none;
                    font-weight: bolder;
                }

            .SrvDiv img {
                margin-right: 10px;
                border: none;
            }

            .SrvDiv span {
                line-height: 20px;
                margin: 10px 0 0 0;
                color: #767676;
                font-size: .65em;
            }

        table.dataTable thead .sorting, table.dataTable thead .sorting_asc, table.dataTable thead .sorting_desc, table.dataTable thead .sorting_asc_disabled, table.dataTable thead .sorting_desc_disabled {
            background-color: #2f4e6c !important;
        }

        div.dataTables_wrapper div.dataTables_info {
            color: #2f4e6c !important;
        }

        #DataGridView .current {
            background-color: #2f4e6c !important;
            color: #fff !important;
        }

        #tamt {
            display: inline-block;
            font-size: 1.2em;
            color: #fff;
            vertical-align: middle;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="Manager1" runat="server"></asp:ScriptManager>
    <div class="container-fluid">
        <div id="page-wrapper" style="min-height: 500px !important;">
            <div class="row">
                <div class="col-lg-12 cscPgehd">
                    <h2 class="form-heading"><i class="fa fa-pencil-square-o"></i>Bulk Payment Application List</h2>
                </div>
            </div>
            <%---Start of Filter----%>
            <div class="row" style="">
                <div class="col-md-12 box-container">
                    <div class="box-heading">
                        <h4 class="box-title register-num">Search Filter
                        </h4>
                    </div>
                    <div class="box-body box-body-open">

                        <%--<div class="col-xs-12 col-sm-6 col-md-6 col-lg-2" >
                            <div class="form-group">
                                <label class="manadatory" for="ddlGender">
                                    Service Name
                                </label>
                                <asp:DropDownList ID="ddlService" runat="server" CssClass="form-control">
                                    <asp:ListItem>Select Service</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlService" InitialValue="0"
                                    ErrorMessage="Please select service name." ValidationGroup="G" ForeColor="Red" />
                            </div>
                        </div>--%>
                        <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                            <div class="form-group">
                                <label class="" for="ddlCollege">
                                    College</label>
                                <asp:DropDownList ID="ddlCollege" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlCollege" InitialValue="0"
                                    ErrorMessage="Please select College." ValidationGroup="G" ForeColor="Red" />
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                            <div class="form-group">
                                <label class="manadatory" for="txtFromDate">
                                    Branch 
                                </label>
                                <asp:DropDownList ID="ddlBranch" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="0" ControlToValidate="ddlBranch"
                                    ErrorMessage="Please select branch." ValidationGroup="G" ForeColor="Red" />
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-3 col-md-2 col-lg-2">
                            <div class="form-group">
                                <label class="manadatory" for="ddlExamType">
                                    Exam Type
                                </label>
                                <asp:DropDownList ID="ddlExamType" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="Regular"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Back"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlExamType" InitialValue="0"
                                    ErrorMessage="Please select exam type." ValidationGroup="G" ForeColor="Red" />
                            </div>

                        </div>
                        <div class="col-xs-12 col-sm-3 col-md-2 col-lg-2">
                            <div class="form-group">
                                <label class="manadatory" for="ddlExamYear">
                                    Exam Year
                                </label>
                                <asp:DropDownList ID="ddlExamYear" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                    <asp:ListItem Value="2020" Text="2020"></asp:ListItem>
                                    <asp:ListItem Value="2019" Text="2019"></asp:ListItem>
                                    <asp:ListItem Value="2018" Text="2018"></asp:ListItem>
                                    <asp:ListItem Value="2017" Text="2017"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlExamYear" InitialValue="0"                                     ErrorMessage="Please Select Exam Year." ValidationGroup="G" ForeColor="Red" />
                            </div>

                        </div>
                        <div class="col-xs-12 col-sm-3 col-md-2 col-lg-2">
                            <div class="form-group">
                                <label class="manadatory" for="ddlSemester">
                                    Semester
                                </label>
                                <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-control" onchange="checkActive();">
                                    <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                    <asp:ListItem Value="1SEM" Text="1st Semester"></asp:ListItem>
                                    <asp:ListItem Value="2SEM" Text="2nd Semester"></asp:ListItem>
                                    <asp:ListItem Value="3SEM" Text="3rd Semester"></asp:ListItem>
                                    <asp:ListItem Value="4SEM" Text="4th Semester"></asp:ListItem>
                                    <asp:ListItem Value="5SEM" Text="5th Semester"></asp:ListItem>
                                    <asp:ListItem Value="6SEM" Text="6th Semester"></asp:ListItem>
                                    <asp:ListItem Value="Regd" Text="Registration Fee"></asp:ListItem>
                                    
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlSemester" InitialValue="0"
                                    ErrorMessage="Please Select Semester." ValidationGroup="G" ForeColor="Red" />
                            </div>

                        </div>
                        <div class="col-xs-12 col-sm-3 col-md-2 col-lg-2">
                            <div class="form-group">
                                <label class="" for="ddlPayStatus">
                                    Status
                                </label>
                                <asp:DropDownList ID="ddlPayStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                    <asp:ListItem Value="Y" Text="Paid"></asp:ListItem>
                                    <asp:ListItem Value="N" Text="UnPaid"></asp:ListItem>
                                    <asp:ListItem Value="P">Pending</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" InitialValue="0" ControlToValidate="ddlPayStatus"
                                    ErrorMessage="Please select payment status." ValidationGroup="G" ForeColor="Red" SetFocusOnError="true" EnableClientScript="true" />
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                            <div class="form-group">
                                <label class="" for="txtRollNo">
                                    Roll No
                                </label>
                                <asp:TextBox ID="txtRollNo" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-1 text-right">
                            <div class="form-group">
                                <label>
                                    &nbsp;</label><asp:Button ID="btnSearch" runat="server" CausesValidation="true" CssClass="btn btn-success"
                                        Text="Search" OnClick="btnSearch_Click" ValidationGroup="G" />
                            </div>
                        </div>

                        <div class="clearfix">
                        </div>

                    </div>

                    <div id="divDetails" runat="server"></div>
                        <div class="mtop15"></div>
                        <div class="box-heading">
                            <h4 class="box-title register-num">Application List
                            </h4>
                        </div>
                        <div class="box-body box-body-open">
                            <div style="text-align:center;color:red;font-weight:bold;padding:3px">
							Note: BULKPAYMENT HAS BEEN RESTRICTED TILL THE CONFIRMATION FROM UNIVERSITY <br/>Any student willing to change their SEC-B subject they need to login through Student Login (Subject can be changed before and after payment).<br/>
							Student who have changed their GE subject in 3rd Semester they need to change their GE subject after login through Student Login
							<br/>If any discrepancy (mis-match) in Paper or Payable amount, Please acknowledge @ 7749991461 or e-mail to help.ocap@gmail.com </div>
                            
                            <div class="row text-center" id="LoadingDiv" runat="server">
                                <div>Please Wait While Data Is Being Loaded...</div>
                                <img src="/WebApp/Login/Loading_hourglass_88px.gif" />
                            </div>
                            <div id="DisplayGrid" style="display: none" runat="server">
                                <div class="col-md-12 box-container">
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="overflow-y: auto;">
                                        <asp:GridView ID="DataGridView" runat="server" Width="98%" OnPreRender="DataGridView_PreRender"
                                            AutoGenerateColumns="false" OnRowDataBound="grdView_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkappid" runat="server" />
                                                        <asp:HiddenField ID="HdfAppID" runat="server" Value='<%#Eval("AppID")%>' />
                                                        <asp:HiddenField ID="hfPayflag" runat="server" Value='<%#Eval("PayFlag")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%-- <asp:BoundField DataField="AppID" HeaderText="AppID" />--%>
                                                <asp:BoundField DataField="RollNo" HeaderText="Roll No" />
                                                <asp:BoundField DataField="Name" HeaderText="Name" />
                                                <asp:BoundField DataField="BranchName" HeaderText="Branch Name" />
                                                <asp:BoundField DataField="CollegeCode" HeaderText="College" />
                                              
                                                <asp:BoundField DataField="LateFeeAmount" HeaderText="Late Fees" />
                                                <asp:TemplateField HeaderText="Exam Fees">
                                                <ItemTemplate>
                                                        <asp:Label ID="lblExamFee" runat="server" Text='<%#Eval("ExamFees") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Other Charges">
                                                <ItemTemplate>
                                                        <asp:Label ID="OtherCharges" runat="server" Text='<%#Eval("OtherCharges") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Late Fees">
                                                <ItemTemplate>
                                                        <asp:Label ID="lblLateFee" runat="server" Text='<%#Eval("LateFeeAmount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Portal Fee">
                                                <ItemTemplate>
                                                        <asp:Label ID="lblPortalFee" runat="server" Text='<%#Eval("PortalFee") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>                                                
                                                <%-- <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" />--%>
                                                <asp:TemplateField HeaderText="Total Amount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbltotalamt" runat="server" Text='<%#Eval("TotalAmount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="View" >
                                                    <ItemTemplate>                                                        
                                                        <asp:HyperLink ID="View" runat="server"  NavigateUrl='<%# "/WebApp/G2G/Bulkpayment/Acknowledgement.aspx?AppID=" + Eval("BatchID") + "&SvcID=1457" %>' Text="Receipt"
                                                    
                                                        onclick="window.open (this.href, 'popupwindow',  'width=800,height=600,scrollbars,resizable'); return false;" Target="_blank" Font-Underline="true" ToolTip="View Action">
                                                     </asp:HyperLink>
                                                    </ItemTemplate>
                                                    
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>


                                </div>
                            </div>
                            <div id="DivAmt" class="col-lg-12 text-center">
                                <span class="btn btn-success btn-lg">Total Amount:
                            <label id="tamt"></label>
                                </span>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <!---------------Remarks Fields----------->
                        <div class="mtop15"></div>
                        <div class="box-heading">
                            <h4 class="box-title register-num">Generate Batch
                            </h4>
                        </div>
                        <div class="box-body box-body-open">

                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-1">
                                <div class="form-group">
                                    Remarks<span class="manadatory"></span>
                                </div>

                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-8">
                                <div class="form-group">
                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="txtRemarks" ForeColor="Red"
                                        ErrorMessage="Please enter remarks." ValidationGroup="K" Display="Dynamic" SetFocusOnError="true" />
                                </div>

                            </div>

                            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3 text-right">
                                <div class="form-group">

                                    <asp:Button ID="GenrateBatch" runat="server" CausesValidation="true" CssClass="btn btn-primary"
                                        Text="Proceed for Payment" OnClick="GenrateBatch_Click" ValidationGroup="K" />
                                </div>
                            </div>

                            <div class="clearfix">
                            </div>

                        </div>
                    

                    <div class="clearfix"></div>
                </div>
            </div>

            <%----END of Filter-----%>
        </div>
    </div>

</asp:Content>
