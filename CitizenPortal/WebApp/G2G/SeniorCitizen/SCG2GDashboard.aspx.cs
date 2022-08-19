﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using CitizenPortalLib.BLL;
using CitizenPortalLib;

namespace CitizenPortal.WebApp.G2G.SeniorCitizen
{
    public partial class SCG2GDashboard : BasePage
    {
        G2GDashboardBLL m_G2GDashboardBLL = new G2GDashboardBLL();
        SeniorCitizenBLL m_SeniorCitizenBLL = new SeniorCitizenBLL();

        string LoginID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    BindDummyGridrow();
            //}

            if (!IsPostBack)
            {
                //txtFromDate.Text = DateTime.Now.ToString("dd-MM-yyyy");
                //txtToDate.Text = DateTime.Now.ToString("dd-MM-yyyy");

                KioskRegistrationBLL t_KioskRegistrationBLL = new KioskRegistrationBLL();
                System.Data.DataTable dtDistrict = t_KioskRegistrationBLL.GetDistrictFromState("21");
                LoginID = Session["LoginID"].ToString();

                //ddlDistrict.DataTextField = "DistrictName";
                //ddlDistrict.DataValueField = "DistrictCode";
                //ddlDistrict.DataSource = dtDistrict;
                //ddlDistrict.DataBind();
                //ddlDistrict.Items.Insert(0, new ListItem("-Select-", "0"));
                //BindPSList();
                /*Issue of New ID Card Tab visible only for Nodal Officer dept.*/
                if (LoginID.Contains("NO."))
                {
                    DivIssueCard.Visible = true;
                    DivDispatch.Visible = false;
                    DivDelivery.Visible = true;
                    DivDistrict.Visible = false;
                    DivPs.Visible = false;
                }
                else if (LoginID.Contains("ANO."))
                {
                    DivIssueCard.Visible = true;
                    DivDispatch.Visible = false;
                    DivDelivery.Visible = true;
                    DivDistrict.Visible = false;
                    DivPs.Visible = false;
                }
                else if (LoginID.Contains("PSNodalOfficer"))
                {
                    DivIssueCard.Visible = true;
                    DivDispatch.Visible = false;
                    DivDelivery.Visible = true;
                    DivDistrict.Visible = false;
                    DivPs.Visible = false;
                }
                else if (LoginID.Contains("IIC."))
                {
                    DivIssueCard.Visible = false;
                    DivDelivery.Visible = false;
                    DivDistrict.Visible = false;
                    DivPs.Visible = false;
                }
                else
                {
                    DivIssueCard.Visible = false;
                    DivDelivery.Visible = false;
                    DivDistrict.Visible = true;
                    DivPs.Visible = true;

                }
                if (LoginID.Contains("ACPReserve"))
                {
                   
                    DivDispatch.Visible = true;
                }
                else
                {
                    DivDispatch.Visible = false;

                }

            }

            Data();

        }


        public void BindDummyGridrow()
        {
            DataTable dt = new DataTable();
            //dt.Columns.Add("Select");
            dt.Columns.Add("Sl. No.");
            dt.Columns.Add("Application ID");
            dt.Columns.Add("Application Date");
            dt.Columns.Add("Application Name");
            dt.Columns.Add("Service Name");
            dt.Columns.Add("Status");
            dt.Columns.Add("Delivery Date");
            dt.Columns.Add("Payment");
            dt.Columns.Add("Document");
            dt.Columns.Add("Certificate");
            dt.Columns.Add("Remark");
            dt.Columns.Add("Action");
            grdView.DataSource = dt;
            grdView.DataBind();
        }

        DataControlFieldCell GetCellByName(GridViewRow Row, String CellName)
        {
            foreach (DataControlFieldCell Cell in Row.Cells)
            {
                if (Cell.ContainingField.ToString() == CellName)
                    return Cell;
            }
            return null;
        }

        protected void grdView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    int i = 0;
                    HtmlAnchor t_Anchor = null;
                    //HiddenField HDFCurrentUrl = new HiddenField();
                    HtmlInputHidden HDFCurrentUrl = new HtmlInputHidden();                                    
                    HDFCurrentUrl.ID = "HDF" + e.Row.RowIndex;
                    //hide for the time being on 21 july as per Niraj Sir
                    TableCell Cell = GetCellByName(e.Row, "Output");

                    LoginID = Session["LoginID"].ToString();
                    string userr = e.Row.Cells[6].Text;
                    if (LoginID.Contains(e.Row.Cells[6].Text))
                    {
                        if (LoginID.Contains("ACPReserve"))
                        {
                            if (LoginID.Contains(e.Row.Cells[6].Text))
                            {
                                HDFCurrentUrl.Value = Convert.ToString(e.Row.Cells[8].Text);
                            }
                            else { HDFCurrentUrl.Value = Convert.ToString(e.Row.Cells[7].Text); }
                            e.Row.Cells[10].Attributes.Add("style", "display:block");
                          
                        }
                        else
                        {
                            //url for action
                            HDFCurrentUrl.Value = Convert.ToString(e.Row.Cells[8].Text);
                            //e.Row.Cells[8].Attributes.Add("style", "display:block");
                           
                        }
                    }
                    else
                    {
                        if (LoginID.Contains("ACPReserve"))
                        {
                            //url for action
                            if (LoginID.Contains(e.Row.Cells[6].Text))
                            {
                                HDFCurrentUrl.Value = Convert.ToString(e.Row.Cells[8].Text);
                            }
                            else { HDFCurrentUrl.Value = Convert.ToString(e.Row.Cells[7].Text); }
                            e.Row.Cells[10].Attributes.Add("style", "display:block");
                           
                        }
                        else
                        {
                            //url for ack
                            HDFCurrentUrl.Value = Convert.ToString(e.Row.Cells[7].Text);
                            //e.Row.Cells[8].Attributes.Add("style", "display:block");
                           
                        }
                    }
                    if (Cell != null)
                    {
                        t_Anchor = new HtmlAnchor();
                        t_Anchor.ID = "ViewDocument_" + e.Row.RowIndex;

                        t_Anchor.InnerHtml = "View";

                        t_Anchor.Attributes.Add("onclick", "ViewOutput('', '" + e.Row.Cells[0].Text + "', '" + e.Row.Cells[1].Text + "')");

                        t_Anchor.Attributes.Add("style", "cursor:pointer;font-size:10pt;font-family:Arial;color:Firebrick;text-decoration:none;");
                        Cell.Controls.Add(t_Anchor);
                        Cell.Attributes.Add("Title", "View");
                        Cell.Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");
                        t_Anchor = null;
                    }
                    //End Here
                    i = e.Row.Cells.Count - 1;

                    t_Anchor = new HtmlAnchor();
                    t_Anchor.ID = "TakeAction_" + e.Row.RowIndex;

                    t_Anchor.InnerHtml = "View";

                    t_Anchor.Attributes.Add("onclick", "TakeAction('" + HDFCurrentUrl.Value + "', '" + e.Row.Cells[0].Text + "', '" + e.Row.Cells[1].Text + "')");

                    t_Anchor.Attributes.Add("style", "cursor:pointer;font-size:10pt;font-family:Arial;color:Firebrick;text-decoration:none;");
                   
                    e.Row.Cells[i].Controls.Add(HDFCurrentUrl);
                    e.Row.Cells[i].Attributes.Add("Title", "View");
                    e.Row.Cells[i].Controls.Add(t_Anchor);
                    e.Row.Cells[i].Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");

                    i++;

                    t_Anchor = null;


                    //HDFCurrentUrl = null;
                }

                if (e.Row.RowType == DataControlRowType.DataRow
                || e.Row.RowType == DataControlRowType.Header
                || e.Row.RowType == DataControlRowType.Footer)
                {

                    e.Row.Cells[0].Attributes.Add("style", "display:none");
                    e.Row.Cells[5].Attributes.Add("style", "display:none");
                    e.Row.Cells[6].Attributes.Add("style", "display:none");
                    e.Row.Cells[7].Attributes.Add("style", "display:none");
                    e.Row.Cells[8].Attributes.Add("style", "display:none");

                    //LoginID = Session["LoginID"].ToString();
                    //if (LoginID.Contains("ACPReserved"))
                    //{

                    //    e.Row.Cells[11].Attributes.Add("style", "display:none");
                    //    e.Row.Cells[10].Attributes.Add("style", "display:none");

                    //}
                    //else
                    //{
                    //    //e.Row.Cells[8].Attributes.Add("style", "display:block");
                    //    e.Row.Cells[9].Attributes.Add("style", "display:none");
                    //    e.Row.Cells[10].Attributes.Add("style", "display:none");

                    //}


                    //e.Row.Cells[7].Attributes.Add("style", "display:none");
                }

                //if ((e.Row.RowType == DataControlRowType.Footer))
                //{
                //    e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Left;

                //    e.Row.Font.Bold = true;

                //    double t_ServiceUsedl = 0;
                //    HtmlAnchor t_Anchor = default(HtmlAnchor);
                //    t_Anchor = new HtmlAnchor();
                //    double t_Total = 0;
                //    //Int32 i = default(Int32);


                //    DataTable t_DT = (DataTable)GDNatPark.DataSource;

                //    e.Row.Cells[0].Text = "Total:";
                //    e.Row.Cells[0].Attributes.Add("style", "text-align:left;");

                //    if (e.Row.Cells.Count <= 29)
                //    {
                //        //' for the Footer, display the totals
                //        for (int i = 0; i < 29; i++)
                //        {
                //            if (i != 0 && i != 1 && i != 2 && i != 8 && i != 14 && i != 17 && i != 21 && i != 26 && i != 27)
                //            {
                //                t_ServiceUsedl = Convert.ToDouble(t_DT.Compute("Sum([" + t_DT.Columns[i].ColumnName + "])", ""));
                //                e.Row.Cells[i].Text = t_ServiceUsedl.ToString();
                //                e.Row.Cells[i].Attributes.Add("style", "text-align:right;");
                //            }
                //        }

                //    }

                //}
            }
            catch (Exception exx)
            {

            }
        }


        protected void grdView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            
            //GetSelectedRec();
            grdView.PageIndex = e.NewPageIndex;
            grdView.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Data();
        }
        public void Data()
        {
            try
            {
                string FromDate = "";
                string ToDate = "";
                string Status = "";
                string category = "";
                string DistrictCode = "";
                string AppID = "";                
                string RollNo = "";
                int Department;
                string PoliceStation = "";


                LoginID = Session["LoginID"].ToString();
                Department = Convert.ToInt32(Session["Department"].ToString());

                //if (ddlCategory.SelectedValue != "")
                //{
                //    category = ddlCategory.SelectedValue;
                //}

                //if (ddlCategory.SelectedValue == "0")
                //{
                //    string m_Message = "Please Select Application Type.";
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + m_Message + "');", true);
                //    return;
                //}

                if (ddlDistrict.SelectedIndex > 0)
                {
                    DistrictCode = ddlDistrict.SelectedItem.Text;
                }
                if (ddlPS.SelectedIndex > 0)
                {
                    PoliceStation = ddlPS.SelectedItem.Text;
                }

                if (txtFromDate.Text != "" && txtToDate.Text != "")
                {
                    FromDate = Convert.ToDateTime(txtFromDate.Text).ToString("yyyy-MM-dd");
                    ToDate = Convert.ToDateTime(txtToDate.Text).ToString("yyyy-MM-dd");
                }

                if (txtAppID.Text != null && txtAppID.Text != "")
                {
                    AppID = txtAppID.Text;
                    if (AppID.Length != 12)
                    {
                        string m_Message = "Reference ID must be of 12 digit number.";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + m_Message + "');", true);
                        return;
                    }
                }

                //if (txtRoll.Text != null && txtRoll.Text != "")
                //{
                //    RollNo = txtRoll.Text;
                //    if (RollNo.Length != 6)
                //    {
                //        string m_Message = "Roll Number must be of 6 digit number.";
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + m_Message + "');", true);
                //        return;
                //    }
                //}

                Status = ddlStatus.SelectedValue;

                DataTable dt = new DataTable();
                dt = m_G2GDashboardBLL.GetSeniorCitizenG2GData(LoginID, Department, category, DistrictCode, FromDate, ToDate, Status, AppID, RollNo, PoliceStation);
                if (dt.Rows.Count > 0)
                {
                    grdView.DataSource = dt;
                    grdView.DataBind();
                    lblMsg.Text = "";
                    lblMsg.Visible = false;
                    grdView.Visible = true;
                }
                else
                {

                    //dt.Rows.Add(dt.NewRow());
                    //grdView.DataSource = dt;
                    //grdView.DataBind();
                    //int columncount = grdView.Rows[0].Cells.Count;
                    //grdView.Rows[0].Cells.Clear();
                    //grdView.Rows[0].Cells.Add(new TableCell());
                    //grdView.Rows[0].Cells[0].ColumnSpan = columncount;
                    //grdView.Rows[0].Cells[0].Text = "No Records Found";
                    lblMsg.Text = "No Records Found";
                    lblMsg.Visible = true;
                    grdView.Visible = false;
                }

                lblTotalRecords.InnerText = dt.Rows.Count.ToString();
            }
            catch (Exception ex)
            {

            }
        }
        public void BindPSList(string DistrictCode)
        {
            try
            {
              
                DataTable dt = new DataTable();
                dt = m_SeniorCitizenBLL.GetDistrictPoliceStations(DistrictCode);
                if (dt!=null && dt.Rows.Count > 0)
                {
                    ddlPS.DataSource = dt;
                    ddlPS.DataTextField = "Police_Station";
                    ddlPS.DataValueField = "RowID";
                    ddlPS.DataBind();
                    ddlPS.Items.Insert(0, new ListItem("--Select--", "0"));
                }
            }
            catch (Exception e)
            {

            }

        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindPSList(ddlDistrict.SelectedValue);
            }
            catch (Exception ex)
            {

            }
        }
    }
}