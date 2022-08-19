﻿
using CitizenPortalLib;
using CitizenPortalLib.BLL;
using CitizenPortalLib.DAL;
using System;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CitizenPortal.WebApp.G2G.SU
{
    public partial class BulkAdmitCard : BasePage
    {
        public DataTable dtGlobal;
        private AttendentSheetBLL obj = new AttendentSheetBLL();
        CBCSAdmissionFormBLL m_AdmissionFormBLL = new CBCSAdmissionFormBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                CollegeList();
                BranchList();
            }
        }
        public void CollegeList()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = m_AdmissionFormBLL.Get_CollegeList();
                if (dt != null && dt.Rows.Count > 0)
                {
                    ddlCollege.DataSource = dt;
                    ddlCollege.DataTextField = "CollegeName";
                    ddlCollege.DataValueField = "CollegeCode";
                    ddlCollege.DataBind();
                    ddlCollege.Items.Insert(0, new ListItem("Select", ""));
                    //if (!Session["LoginID"].ToString().Contains("Admin") && !Session["LoginID"].ToString().Contains("Univ") && !Session["LoginID"].ToString().Contains("SOEC"))
                    if (Session["menuRole"].ToString() == "College" || Session["menuRole"].ToString() == "Principal")
                    {
                        ddlCollege.SelectedIndex = ddlCollege.Items.IndexOf(ddlCollege.Items.FindByValue(Session["LoginID"].ToString().Substring(0, 3)));
                        ddlCollege.Enabled = false;
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }

        public void BranchList()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = m_AdmissionFormBLL.GetCBCSCourseLists();
                if (dt != null && dt.Rows.Count > 0)
                {
                    ddlBranch.DataSource = dt;
                    ddlBranch.DataTextField = "Course";
                    ddlBranch.DataValueField = "BranchCode";
                    ddlBranch.DataBind();
                    ddlBranch.Items.Insert(0, new ListItem("Select", ""));
                }
            }
            catch (Exception ex)
            {

            }
        }
        protected void ddlSemester_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        public void Loadgrid()
        {
            DataSet ds = new DataSet();
            string m_BranchCode = "", m_CollegeCode = "", m_ExamType = "", m_ExamYear = "", m_Semester = "", m_Range="", m_RollNo = "", m_ServiceID = "1450", m_Registration = "";

            if (ddlBranch.SelectedValue != "0")
            {
                m_BranchCode = ddlBranch.SelectedItem.Value;
            }
            if (ddlCollege.SelectedValue != "0")
            {
                m_CollegeCode = ddlCollege.SelectedItem.Value;
            }
            if (ddlExamType.SelectedValue != "0")
            {
                m_ExamType = ddlExamType.SelectedItem.Text;
            }
            if (ddlSession.SelectedValue != "0")
            {
                m_ExamYear = ddlSession.SelectedItem.Text;
            }
            if (ddlSemester.SelectedValue != "0")
            {
                m_Semester = ddlSemester.SelectedItem.Value;
            }
            if (ddlRange.SelectedValue != "0")
            {
                m_Range = ddlRange.SelectedItem.Value;
            }
            if (TxtRollNo.Text != "")
            {
                m_RollNo = TxtRollNo.Text;
            }

            string m_PrintFlag = "N";

            ds = obj.GetAttendentSheetDetails(m_BranchCode, m_CollegeCode, m_ExamType, m_ExamYear, m_Semester,m_Range, m_RollNo, m_ServiceID, m_Registration, m_PrintFlag);

            if (ds.Tables[0].Rows.Count > 0)
            {
                grdAttendanceSheet.DataSource = ds.Tables[0];
                dtGlobal = ds.Tables[0];
                grdAttendanceSheet.DataBind();
            }
        }
        public void PrintGrid()
        {
            DataSet ds = new DataSet();
            string m_BranchCode = "", m_CollegeCode = "", m_ExamType = "", m_ExamYear = "", m_Semester = "", m_Range="", m_RollNo = "", m_ServiceID = "1450", m_Registration = "";

            if (ddlBranch.SelectedValue != "0")
            {
                m_BranchCode = ddlBranch.SelectedItem.Value;
            }
            if (ddlCollege.SelectedValue != "0")
            {
                m_CollegeCode = ddlCollege.SelectedItem.Value;
            }
            if (ddlExamType.SelectedValue != "0")
            {
                m_ExamType = ddlExamType.SelectedItem.Text;
            }
            if (ddlSession.SelectedValue != "0")
            {
                m_ExamYear = ddlSession.SelectedItem.Text;
            }
            if (ddlSemester.SelectedValue != "0")
            {
                m_Semester = ddlSemester.SelectedItem.Value;
            }
            if (ddlRange.SelectedValue != "0")
            {
                m_Range = ddlRange.SelectedItem.Value;
            }
            if (TxtRollNo.Text != "")
            {
                m_RollNo = TxtRollNo.Text;
            }
            string m_PrintFlag = "N";
            ds = obj.GetAttendentSheetDetails(m_BranchCode, m_CollegeCode, m_ExamType, m_ExamYear, m_Semester, m_Range, m_RollNo, m_ServiceID, m_Registration, m_PrintFlag);

            if (ds.Tables[0].Rows.Count > 0)
            {
                grdAttendanceSheet.DataSource = ds.Tables[0];
                dtGlobal = ds.Tables[0];
                grdAttendanceSheet.DataBind();
            }
            

        }

        //protected void grdAttendanceSheet_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        System.Web.UI.HtmlControls.HtmlImage img = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("ProfilePhoto");
        //        img.Src = dtGlobal.Rows[e.Row.RowIndex]["ApplicantImageStr"].ToString();

        //        System.Web.UI.HtmlControls.HtmlImage Img11 = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("Img1");
        //        Img11.Src = dtGlobal.Rows[e.Row.RowIndex]["ImageSign"].ToString();
        //    }
        //}

        public void Loadgrid2()
        {
            DataSet ds = new DataSet();
            string m_BranchCode = "", m_CollegeCode = "", m_ExamType = "", m_ExamYear = "", m_Semester = "", m_Range="", m_RollNo = "", m_ServiceID = "1450", m_Registration = "";

            if (ddlBranch.SelectedValue != "0")
            {
                m_BranchCode = ddlBranch.SelectedItem.Value;
            }
            if (ddlCollege.SelectedValue != "0")
            {
                m_CollegeCode = ddlCollege.SelectedItem.Value;
            }
            if (ddlExamType.SelectedValue != "0")
            {
                m_ExamType = ddlExamType.SelectedItem.Text;
            }
            if (ddlSession.SelectedValue != "0")
            {
                m_ExamYear = ddlSession.SelectedItem.Text;
            }
            if (ddlSemester.SelectedValue != "0")
            {
                m_Semester = ddlSemester.SelectedItem.Value;
            }
            if (ddlRange.SelectedValue != "0")
            {
                m_Range = ddlRange.SelectedItem.Value;
            }
            if (TxtRollNo.Text != "")
            {
                m_RollNo = TxtRollNo.Text;
            }
            string m_PrintFlag = "Y";
            ds = obj.GetAttendentSheetDetails(m_BranchCode, m_CollegeCode, m_ExamType, m_ExamYear, m_Semester, m_Range, m_RollNo, m_ServiceID, m_Registration, m_PrintFlag);

            if (ds.Tables[0].Rows.Count > 0)
            {
                grdAttendanceSheet.DataSource = ds.Tables[0];
                dtGlobal = ds.Tables[0];
                grdAttendanceSheet.DataBind();
            }
            
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                Loadgrid();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + ex.Message + "');", true);
            }
        }

        public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void drpRange_SelectedIndexChanged(object sender, EventArgs e)
        {
            Loadgrid();
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            string m_PrintFlag = "";
            
            try
            {

                Loadgrid2();

                grdAttendanceSheet.UseAccessibleHeader = true;
                //grdAttendanceSheet.HeaderRow.TableSection = TableRowSection.TableHeader;
                //grdAttendanceSheet.FooterRow.TableSection = TableRowSection.TableFooter;
               

                grdAttendanceSheet.Attributes["style"] = "border-collapse:separate";
                foreach (DataListItem row in grdAttendanceSheet.Items)
                {
                    int pagebreakvalue = 1;
                    if (row.ItemIndex == (pagebreakvalue) && row.ItemIndex != 0)
                    {
                        row.Attributes["style"] = "page-break-before:always;";
                    }
                    else if (row.ItemIndex > pagebreakvalue && row.ItemIndex % pagebreakvalue == 0 && row.ItemIndex != 0)
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

                DataSet ds = new DataSet();
                string m_BranchCode = "", m_CollegeCode = "", m_ExamType = "", m_ExamYear = "", m_Semester = "", m_Range="", m_RollNo = "", m_ServiceID = "1450", m_Registration = "";

                if (ddlBranch.SelectedValue != "0")
                {
                    m_BranchCode = ddlBranch.SelectedItem.Value;
                }
                if (ddlCollege.SelectedValue != "0")
                {
                    m_CollegeCode = ddlCollege.SelectedItem.Value;
                }
                if (ddlExamType.SelectedValue != "0")
                {
                    m_ExamType = ddlExamType.SelectedItem.Text;
                }
                if (ddlSession.SelectedValue != "0")
                {
                    m_ExamYear = ddlSession.SelectedItem.Text;
                }
                if (ddlSemester.SelectedValue != "0")
                {
                    m_Semester = ddlSemester.SelectedItem.Value;
                }
                if (ddlRange.SelectedValue != "0")
                {
                    m_Range = ddlRange.SelectedItem.Value;
                }
                if (TxtRollNo.Text != "")
                {
                    m_RollNo = TxtRollNo.Text;
                }

                m_PrintFlag = "Y";

                ds = obj.GetAttendentSheetDetails(m_BranchCode, m_CollegeCode, m_ExamType, m_ExamYear, m_Semester, m_Range, m_RollNo, m_ServiceID, m_Registration, m_PrintFlag);

                DataTable dt = ds.Tables[0];
                string rollNumberRange = "";//dt.Rows[0]["RollNoRange"].ToString();
                string ExamDate = "";
                string style = "";
                sb.Append("<table rules='all'   id='grdAttendanceData' style='width:100%;'><tr><td>");
                //sb.Append(" <tr><td rowspan='3'><img src='data:image/png;base64,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' style='height: 43px;' /></td><td  align='center'><b>CHHATTISGARH SWAMI VIVEKANAD TECHNICAL UNIVERSITY</b><br>RAIPUR<br> ATTENDANCE SHEET-" + ddlSemester.SelectedItem.Text.ToString() + " " + ddlSession.SelectedItem.Text.ToString() + " </td> </tr> ");

                //sb.Append("<tr><td  align='center'> <b>" + ddlCollege.SelectedItem.Text.ToString() + " </b></td></tr>");
                //sb.Append("<tr> <td  align='center'> <b>" + ddlBranch.SelectedItem.Text.ToString() + " </b> </td></tr></table>");
                sb.Append(style + sw.ToString().Replace("\"", "'").Replace(System.Environment.NewLine, ""));

                sb.Replace("<tr style='page-break-before:always;'><td>", "<tr><td>Total candidates Present:</td></tr><tr><td>Total Candidate absent : &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Signature of the Invigilator</td></tr><tr style='page-break-before:always;'><td><table rules='all'   id='grdAttendanceData' style='font-size:14px;width:100%;'><tr> <tr><td><img src='download1.png' style='height: 43px; width: 71px'/></td><td  align='center'><b><CHHATTISGARH SWAMI VIVEKANAD TECHNICAL UNIVERSITY</b><<br>Raipur<br> ATTENDANCE SHEET-" + ddlSemester.SelectedItem.Text.ToString() + " " + ddlSession.SelectedItem.Text.ToString() + "     </td> </tr><tr><td  align='center'>College Name : </td> <td  align='center'><b> " + ddlCollege.SelectedItem.Text.ToString() + " </b></td></tr><tr><td  align='center'>Roll Range : " + rollNumberRange + "</td> <td  align='center'>Exam. Date : <b>" + ExamDate + "</b> </td></tr></table>");
                sb.Append("</td></tr></table>");

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
                PrintGrid();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + ex.ToString() + "');", true);
            }
        }

        protected void grdAttendanceSheet_ItemDataBound(object sender, DataListItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item ||
             e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.Item.DataItem != null)
                {
                    System.Web.UI.HtmlControls.HtmlImage img = (System.Web.UI.HtmlControls.HtmlImage)e.Item.FindControl("ProfilePhoto");
                    img.Src = dtGlobal.Rows[e.Item.ItemIndex]["ApplicantImageStr"].ToString();

                    System.Web.UI.HtmlControls.HtmlImage Img11 = (System.Web.UI.HtmlControls.HtmlImage)e.Item.FindControl("Img1");
                    Img11.Src = dtGlobal.Rows[e.Item.ItemIndex]["ImageSign"].ToString();

                    string t_RollNo = dtGlobal.Rows[e.Item.ItemIndex]["RollNo"].ToString();
                    try
                    {
                        Common.QRCode.QRCode qrCode = (Common.QRCode.QRCode)e.Item.FindControl("QRCode");
                        qrCode.GenerateQRCodeDetails("1449", t_RollNo);

                    }
                    catch (Exception ex) { }
                }

            }

            

            /**/
            DataRowView drv = e.Item.DataItem as DataRowView;
            GridView innerDataList = e.Item.FindControl("grdPaper") as GridView;
            DataSet t_DS = new DataSet();

            t_DS = obj.GetAttendentPaperDetails(dtGlobal.Rows[e.Item.ItemIndex]["RollNo"].ToString(), ddlSemester.SelectedItem.Value, ddlSession.SelectedItem.Value);

            if (t_DS.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow rw in t_DS.Tables[0].Rows)
                {
                    innerDataList.DataSource = t_DS.Tables[0];
                    innerDataList.DataBind();
                }
            }
            
        }


    }
}