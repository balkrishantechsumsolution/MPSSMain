﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CitizenPortalLib;
using CitizenPortalLib.DAL;
using System.Data;
using System.Text;

namespace CitizenPortal.WebApp.G2G.OUAT
{
    public partial class AttendanceSheetOUAT : System.Web.UI.Page
    {
        public DataTable dtGlobal;
        OISFDALReport obj = new OISFDALReport();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

 
                    drpCenter.Items.Insert(0, "Select");
                    drpCenter.SelectedValue = "Select";


                    DataSet ds = obj.GetOISFAppDetails("OU01", "", "", "", "", "", "", "", "", "", "");
                    drpDistrict.DataSource = ds.Tables[0];
                    drpDistrict.DataTextField = "District";
                    drpDistrict.DataValueField = "DistrictId";
                    drpDistrict.DataBind();

                    drpDistrict.Items.Insert(0, "Select");
                    drpDistrict.SelectedValue = "Select";


                }

            }
            catch (Exception ex)
            {


            }

        }

        protected void drpDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {

            DataSet ds = obj.GetOISFAppDetails("OU02", drpDistrict.SelectedValue, "", "", "", "", "", "", "", "", "");
            drpCenter.DataSource = ds.Tables[0];
            drpCenter.DataTextField = "ExaminationCentre";
            drpCenter.DataValueField = "Centerid";
            drpCenter.DataBind();
            drpCenter.Items.Insert(0, "Select");
            drpCenter.SelectedValue = "Select";


        }

        protected void drpCenter_SelectedIndexChanged(object sender, EventArgs e)
        {

     
        }


        public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
        {
            /* Verifies that the control is rendered */
        }

        public void Loadgrid()
        {


            DataSet ds = obj.GetOISFAppDetails("OU05", drpCenter.SelectedValue.ToString(), drpRange.SelectedValue, "", "", "", "", "", "", "", "");

            if (ds.Tables[0].Rows.Count > 0)
            {

                grdAttendanceSheet.DataSource = ds.Tables[0];
                dtGlobal = ds.Tables[0];
                grdAttendanceSheet.DataBind();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "No Data Found !!!", true);
                DataTable dtnull = null;
                grdAttendanceSheet.DataSource = dtnull;
                dtGlobal = dtnull;
                grdAttendanceSheet.DataBind();
            }
        }


        public void Loadgrid2()
        {


            DataSet ds = obj.GetOISFAppDetails("OU04", drpCenter.SelectedValue.ToString(), drpRange.SelectedValue, "", "", "", "", "", "", "", "");

            if (ds.Tables[0].Rows.Count > 0)
            {

                grdAttendanceSheet.DataSource = ds.Tables[0];
                dtGlobal = ds.Tables[0];
                grdAttendanceSheet.DataBind();
            }

            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "No Data Found !!!", true);
                DataTable dtnull1 = null;
                grdAttendanceSheet.DataSource = dtnull1;
                dtGlobal = dtnull1;
                grdAttendanceSheet.DataBind();
            }
        }


        protected void grdAttendanceSheet_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                System.Web.UI.HtmlControls.HtmlImage img = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("ProfilePhoto");
                img.Src =  dtGlobal.Rows[e.Row.RowIndex]["ApplicantImageStr"].ToString();


                System.Web.UI.HtmlControls.HtmlImage Img11 = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("Img1");
                Img11.Src = dtGlobal.Rows[e.Row.RowIndex]["Signature"].ToString();
            }
        }



        protected void btnPrint_Click(object sender, EventArgs e)
        {
            try
            {
                Loadgrid2();



                grdAttendanceSheet.UseAccessibleHeader = true;
                grdAttendanceSheet.HeaderRow.TableSection = TableRowSection.TableHeader;
                grdAttendanceSheet.FooterRow.TableSection = TableRowSection.TableFooter;
                grdAttendanceSheet.Attributes["style"] = "border-collapse:separate";
                foreach (GridViewRow row in grdAttendanceSheet.Rows)
                {
                    int pagebreakvalue = 8;
                    if (row.RowIndex == (pagebreakvalue) && row.RowIndex != 0)
                    {
                        row.Attributes["style"] = "page-break-before:always;";
                    }
                    else if (row.RowIndex > pagebreakvalue && row.RowIndex % pagebreakvalue == 0 && row.RowIndex != 0)
                    {
                        row.Attributes["style"] = "page-break-before:always;";
                    }
                }
                System.IO.StringWriter sw = new System.IO.StringWriter();
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                grdAttendanceSheet.RenderControl(hw);
               // string gridHTML =sw.ToString();
               // gridHTML= sw.ToString().Replace("\"", "'").Replace(System.Environment.NewLine, "");
                StringBuilder sb = new StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload = new function(){");
                sb.Append("var printWin = window.open('', '', 'left=0");
                sb.Append(",top=0,width=1000,height=600,status=0');");
                sb.Append("printWin.document.write(\"");



                OISFDALReport obj11 = new OISFDALReport();


                DataSet ds = obj.GetOISFAppDetails("OU03", drpCenter.SelectedValue.ToString(), "", "", "", "", "", "", "", "", "");

                DataTable dt = ds.Tables[0];
                string rollNumberRange = dt.Rows[0]["RollNoRange"].ToString();
               string ExamDate = dt.Rows[0]["ExamDate"].ToString();
                string style = "<style type = 'text/css'>thead {display:table-header-group;} tfoot{display:table-footer-group;}</style>";
                sb.Append("<table BORDER='1' rules='all'   id='grdAttendanceData' style='font-size:14px;width:100%;'>");
                sb.Append(" <tr><td><img src='download1.png' style='height: 43px; width: 71px' /></td><td  align='center'><b> ORISSA UNIVERSITY OF AGRICULTURE AND TECHNOLOGY, BHUBANESWAR <br/>UG.  COMMON ENTRANCE EXAMINATION - 2017<br/> ATTENDANCE SHEET</b> </td> </tr> ");
         
                sb.Append("<tr><td  align='center'>Center Name : </td> <td  align='center'>"+drpCenter.SelectedItem.Text.ToString()+ " </td></tr>");
                sb.Append("<tr><td  align='center'>Roll Range : " + rollNumberRange + "</td> <td  align='center'>Exam. Date : " + ExamDate + " </td></tr></table>");
                sb.Append(style + sw.ToString().Replace("\"", "'").Replace(System.Environment.NewLine, ""));


                sb.Replace("<tr style='page-break-before:always;'>				<td>", "<tr><td>Total candidates Present:</td></tr><tr><td>Total Candidate absent : &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Signature of the Invigilator</td></tr><tr style='page-break-before:always;'><td><table BORDER='1' rules='all'   id='grdAttendanceData' style='font-size:14px;width:100%;'><tr> <tr><td><img src='download1.png' style='height: 43px; width: 71px'   /></td><td  align='center'><b> ORISSA UNIVERSITY OF AGRICULTURE AND TECHNOLOGY, BHUBANESWAR <br/>UG.  COMMON ENTRANCE EXAMINATION - 2017<br/> ATTENDANCE SHEET</b> </td> </tr><tr><td  align='center'>Center Name : </td> <td  align='center'>" + drpCenter.SelectedItem.Text.ToString() + " </td></tr><tr><td  align='center'>Roll Range : " + rollNumberRange + "</td> <td  align='center'>Exam. Date : " + ExamDate + " </td></tr></table>");
                sb.Append("<table BORDER='1' style='font-size:14px;width:100%;'><tr><td>Total candidates Present:</td></tr><tr><td>Total Candidate absent : &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Signature of the Invigilator</td></tr></table>");

                sb.Append("\");");
                sb.Append("printWin.document.close();");
                sb.Append("printWin.focus();");
                sb.Append("printWin.print();");
                sb.Append("printWin.close();");
                sb.Append("};");
                sb.Append("</script>");
                ClientScript.RegisterStartupScript(this.GetType(), "GridPrint", sb.ToString());
                sb.Clear();

                sw.Flush();
                sw.Close();
                Loadgrid();





            }
            catch (Exception ex)
            {


            }
        }

        protected void drpRange_SelectedIndexChanged(object sender, EventArgs e)
        {
            Loadgrid();
        }
    }
}