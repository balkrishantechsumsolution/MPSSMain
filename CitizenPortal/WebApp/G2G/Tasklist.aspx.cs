﻿using CitizenPortalLib;
using CitizenPortalLib.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CitizenPortal.WebApp.G2G
{
    public partial class Tasklist : AdminBasePage
    {
        G2GDashboardBLL m_G2GDashboardBLL = new G2GDashboardBLL();
        List<string> Checked = new List<string>();

        bool m_DispPanel = false;
        string m_Status = "";
        bool m_DispCheckBox = false;
        string m_ServiceID = "";
        string m_Message = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            string LoginID = "";
            HFServiceID.Value = "994";

            if (!IsPostBack)
            { 
                HFSelection.Value = "0";
            }

            int Department;

            LoginID = Session["LoginID"].ToString();
            Department = Convert.ToInt32(Session["Department"].ToString());

            
            GeneratePanels(LoginID, Department);

            BindGrid(LoginID, Department);
            
        }

        void GeneratePanels(string LoginID, int Department)
        {
            DataSet ds = m_G2GDashboardBLL.GetPendingServices(LoginID, Department);


            if (ds != null)
            {
                Panel t_Panel = null;

                if(ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                {
                    //pnlPendingForAcceptance
                    t_Panel = pnlPendingForAcceptance;

                    t_Panel.Controls.Add(new LiteralControl("<ul>"));

                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        t_Panel.Controls.Add(new LiteralControl("<li>"));
                        t_Panel.Controls.Add(new LiteralControl("<a href='#' onclick='javascript:return PendingForAcceptance(0, " + ds.Tables[0].Rows[i]["SvcID"].ToString() + ");'>"));
                        t_Panel.Controls.Add(new LiteralControl(ds.Tables[0].Rows[i]["SvcName"].ToString()));

                        t_Panel.Controls.Add(new LiteralControl("<span>"));
                        t_Panel.Controls.Add(new LiteralControl(ds.Tables[0].Rows[i]["SvcCount"].ToString()));
                        t_Panel.Controls.Add(new LiteralControl("</span>"));
                        t_Panel.Controls.Add(new LiteralControl("</a>"));

                        t_Panel.Controls.Add(new LiteralControl("</li>"));

                    }

                    t_Panel.Controls.Add(new LiteralControl("</ul>"));

                    t_Panel = null;
                }

                if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                {
                    //pnlPendingForApproval
                    t_Panel = pnlPendingForApproval;

                    t_Panel.Controls.Add(new LiteralControl("<ul>"));

                    for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                    {
                        t_Panel.Controls.Add(new LiteralControl("<li>"));
                        t_Panel.Controls.Add(new LiteralControl("<a href='#' onclick='javascript:return PendingForApproval(1, " + ds.Tables[1].Rows[i]["SvcID"].ToString() + ");'>"));

                        t_Panel.Controls.Add(new LiteralControl(ds.Tables[1].Rows[i]["SvcName"].ToString()));

                        t_Panel.Controls.Add(new LiteralControl("<span>"));
                        t_Panel.Controls.Add(new LiteralControl(ds.Tables[1].Rows[i]["SvcCount"].ToString()));
                        t_Panel.Controls.Add(new LiteralControl("</span>"));
                        t_Panel.Controls.Add(new LiteralControl("</a>"));

                        t_Panel.Controls.Add(new LiteralControl("</li>"));

                    }

                    t_Panel.Controls.Add(new LiteralControl("</ul>"));

                    t_Panel = null;
                }

                if (ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
                {
                    //pnlPendingForAction
                    t_Panel = pnlPendingForAction;

                    t_Panel.Controls.Add(new LiteralControl("<ul>"));

                    for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                    {
                        t_Panel.Controls.Add(new LiteralControl("<li>"));
                        t_Panel.Controls.Add(new LiteralControl("<a href='#' onclick='javascript:return PendingForAction(2, " + ds.Tables[2].Rows[i]["SvcID"].ToString() + ");'>"));

                        t_Panel.Controls.Add(new LiteralControl(ds.Tables[2].Rows[i]["SvcName"].ToString()));

                        t_Panel.Controls.Add(new LiteralControl("<span>"));
                        t_Panel.Controls.Add(new LiteralControl(ds.Tables[2].Rows[i]["SvcCount"].ToString()));
                        t_Panel.Controls.Add(new LiteralControl("</span>"));
                        t_Panel.Controls.Add(new LiteralControl("</a>"));

                        t_Panel.Controls.Add(new LiteralControl("</li>"));

                    }

                    t_Panel.Controls.Add(new LiteralControl("</ul>"));

                    t_Panel = null;
                }

                if (ds.Tables[3] != null && ds.Tables[3].Rows.Count > 0)
                {
                    //pnlPendingForAssignment
                    t_Panel = pnlPendingForAssignment;

                    t_Panel.Controls.Add(new LiteralControl("<ul>"));

                    for (int i = 0; i < ds.Tables[3].Rows.Count; i++)
                    {
                        t_Panel.Controls.Add(new LiteralControl("<li>"));
                        t_Panel.Controls.Add(new LiteralControl("<a href='#' onclick='javascript:return PendingForAction(2, " + ds.Tables[3].Rows[i]["SvcID"].ToString() + ");'>"));

                        t_Panel.Controls.Add(new LiteralControl(ds.Tables[3].Rows[i]["SvcName"].ToString()));

                        t_Panel.Controls.Add(new LiteralControl("<span>"));
                        t_Panel.Controls.Add(new LiteralControl(ds.Tables[3].Rows[i]["SvcCount"].ToString()));
                        t_Panel.Controls.Add(new LiteralControl("</span>"));
                        t_Panel.Controls.Add(new LiteralControl("</a>"));

                        t_Panel.Controls.Add(new LiteralControl("</li>"));

                    }

                    t_Panel.Controls.Add(new LiteralControl("</ul>"));

                    t_Panel = null;
                }

            }

        }

        void BindGrid(string LoginID, int Department)
        {

            DataTable dt = null;
            if (HFSelection.Value != "" && HFSelectedSvcID.Value != "")
            {
                DataSet ds = null;
                int Selection = Convert.ToInt32(HFSelection.Value);

                ds = m_G2GDashboardBLL.GetG2GPendingForSelectedService(LoginID, Department, Selection.ToString(), HFSelectedSvcID.Value);

                dt = ds.Tables[Selection];


            }
            else
            {
                dt = m_G2GDashboardBLL.GetG2GPendingForAcceptance(LoginID, Department);
            }


            grdView.Columns.Clear();
            BoundField t_BoundField;

            t_BoundField = new BoundField();
            t_BoundField.HeaderText = "Select";
            grdView.Columns.Add(t_BoundField);


            for (int i = 0; i < dt.Columns.Count; i++)
            {
                t_BoundField = new BoundField();
                t_BoundField.DataField = dt.Columns[i].ColumnName;
                t_BoundField.SortExpression = dt.Columns[i].ColumnName;
                t_BoundField.HeaderText = dt.Columns[i].ColumnName;

                grdView.Columns.Add(t_BoundField);
            }


            grdView.DataSource = dt;
            grdView.DataBind();

            lblTotalRecords.InnerText = dt.Rows.Count.ToString();

        }

        void GetSelectedRec()
        {
            if (ViewState["Checked"] != null)
            {
                Checked = (List<string>)ViewState["Checked"];
            }
            foreach (GridViewRow rows in grdView.Rows)
            {
                if (rows.Cells[0].Controls.Count > 0 && rows.Cells[0].Controls[0].GetType().FullName.Equals(typeof(CheckBox).FullName))
                {
                    CheckBox chk = rows.Cells[0].Controls[0] as CheckBox;
                    if (chk.Checked == true)
                    {
                        if (!Checked.Contains(chk.ID))
                            Checked.Add(chk.ID);
                    }
                    else
                    {
                        if (Checked.Contains(chk.ID))
                            Checked.Remove(chk.ID);
                    }
                }
            }
            ViewState.Remove("Checked");
            ViewState["Checked"] = Checked;
        }

        string GetRecords()
        {
            GetSelectedRec();
            string t_RowID = "";
            if (ViewState["Checked"] != null)
            {
                Checked = (List<string>)ViewState["Checked"];
                int t_itemcount = Checked.Count;
                if (t_itemcount == 0)
                {
                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "PageScript", "alert('Please Select a Record');", true);
                    return "";
                }
                for (int i = 0; i < t_itemcount; i++)
                {
                    if (i > 0)
                        t_RowID = t_RowID + ",";

                    t_RowID += Checked[i].Split('_')[0];
                }
                Checked.Clear();
                ViewState["Checked"] = Checked;
                return t_RowID;
            }
            return "";
        }

        protected void grdView_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Attributes.Add("Style", "text-align:center");

            }
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
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int i = 0;
                HtmlAnchor t_Anchor = null;


                e.Row.Cells[0].Controls.Clear();

                CheckBox t_chk = new CheckBox();

                t_chk.ID = e.Row.Cells[1].Text + "_Chk";
                t_chk.Enabled = true;
                if (ViewState["Checked"] != null && ((List<string>)ViewState["Checked"]).Contains(t_chk.ID))
                {
                    t_chk.Checked = true;
                }
                else
                {
                    t_chk.Checked = false;
                }

                e.Row.Cells[0].Controls.Add(t_chk);


                TableCell Cell = GetCellByName(e.Row, "Document");
                if (Cell != null)
                {
                    t_Anchor = new HtmlAnchor();
                    t_Anchor.ID = "ViewDocument_" + e.Row.RowIndex;

                    t_Anchor.InnerHtml = "View";

                    t_Anchor.Attributes.Add("onclick", "ViewDoc('', '" + e.Row.Cells[1].Text + "', '" + e.Row.Cells[2].Text + "')");

                    t_Anchor.Attributes.Add("style", "cursor:pointer;font-size:10pt;font-family:Arial;color:Firebrick;text-decoration:none;");
                    Cell.Controls.Add(t_Anchor);
                    Cell.Attributes.Add("Title", "View");
                    Cell.Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");
                    t_Anchor = null;
                }

                i = e.Row.Cells.Count - 1;

                t_Anchor = new HtmlAnchor();
                t_Anchor.ID = "TakeAction_" + e.Row.RowIndex;

                t_Anchor.InnerHtml = "View";

                t_Anchor.Attributes.Add("onclick", "TakeAction('', '" + e.Row.Cells[2].Text + "', '" + e.Row.Cells[3].Text + "')");

                t_Anchor.Attributes.Add("style", "cursor:pointer;font-size:10pt;font-family:Arial;color:Firebrick;text-decoration:none;");
                e.Row.Cells[i].Controls.Add(t_Anchor);
                e.Row.Cells[i].Attributes.Add("Title", "View");
                e.Row.Cells[i].Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");

                i++;

                t_Anchor = null;
            }

            if (e.Row.RowType == DataControlRowType.DataRow
            || e.Row.RowType == DataControlRowType.Header
            || e.Row.RowType == DataControlRowType.Footer)
            {

                e.Row.Cells[1].Attributes.Add("style", "display:none");
                e.Row.Cells[2].Attributes.Add("style", "display:none");

            }
        }

        protected void grdView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //GetSelectedRec();
            grdView.PageIndex = e.NewPageIndex;
            grdView.DataBind();
        }

        protected void btnAccept_Click(object sender, EventArgs e)
        {
            ProcessApplications("A");
        }

        void ProcessApplications(string ActionType)
        {
            string t_MailBody = "";

            string t_RowID = GetRecords();

            if (string.IsNullOrEmpty(t_RowID))
            {
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Message", "alert('Select Records to continue');", true);
                return;
            }

            //string t_Status = "A";
            //m_Message = "Approved";
            //string t_Script = "";
            //string t_Kiosks = "";
            string t_CreatedBy = Session["LoginID"].ToString();
            //string[] t_RowIDArr = t_RowID.Split(',');
        
            DataTable ds = m_G2GDashboardBLL.ProcessApplications(t_RowID, t_CreatedBy, ActionType);


            //ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Message", t_Script, true);
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            ProcessApplications("R");
        }
    }
}