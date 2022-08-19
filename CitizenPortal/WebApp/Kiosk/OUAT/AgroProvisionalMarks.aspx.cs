﻿using CitizenPortalLib.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ServiceModel;
using System.Web.Services;
using CitizenPortalLib.ServiceInterface;

namespace CitizenPortal.WebApp.Kiosk.OUAT
{
    public partial class AgroProvisionalMarks : System.Web.UI.Page
    {
        OUATBLL m_OUATBLL = new OUATBLL();
        string m_AppID, m_ServiceID;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["AppID"] == null) return;
            if (Request.QueryString["SvcID"] == null) return;

            m_AppID = Request.QueryString["AppID"].ToString();
            m_ServiceID = Request.QueryString["SvcID"].ToString();


            DataSet dt = m_OUATBLL.OUATAgroProvisional(m_ServiceID, m_AppID);
            DataTable dtApp = dt.Tables[0];
            DataTable dtProvisionalMark = dt.Tables[1];

            if (dtApp.Rows.Count != 0)
            {
                lblAppID.Text = dtApp.Rows[0]["AppID"].ToString();
                lblAppDate.Text = Convert.ToDateTime(dtApp.Rows[0]["CreatedOn"]).ToString("dd/MM/yyyy HH:mm:ss");
                lblAppname.Text = dtApp.Rows[0]["FullName"].ToString();
                lblFather.Text = dtApp.Rows[0]["FatherName"].ToString();
                lblMobile.Text = dtApp.Rows[0]["Mobile"].ToString();
                lblEmail.Text = dtApp.Rows[0]["EmailId"].ToString();
                lblDOB.Text = dtApp.Rows[0]["DOB"].ToString();
                lblAge.Text = dtApp.Rows[0]["Age"].ToString() + "years";
                lblCategory.Text = dtApp.Rows[0]["Religion"].ToString() + " (" + dtApp.Rows[0]["Category"].ToString() + ") ";
                //ProfilePhoto.Src = "data:image/png;base64," + dtApp.Rows[0]["ApplicantImageStr"].ToString();
                ProfilePhoto.Src = dtApp.Rows[0]["ApplicantImageStr"].ToString();
                ProfileSign.Src = dtApp.Rows[0]["ImageSign"].ToString();
                lblRollNo.Text = dtApp.Rows[0]["RollNumber"].ToString();
                lblVenue.Text = dtApp.Rows[0]["CenterName"].ToString();
                lblDate.Text = dtApp.Rows[0]["AllocationTime"].ToString();
                //lblDate.Text = Convert.ToDateTime(dtApp.Rows[0]["AllocationTime"]).ToString("dd/MM/yyyy");
                lblGender.Text = dtApp.Rows[0]["Gender"].ToString();
                lblMother.Text = dtApp.Rows[0]["mothername"].ToString();
                lblAddress.Text = dtApp.Rows[0]["CurrentFullAddress"].ToString();
                lblDistrict.Text = dtApp.Rows[0]["CurrentDistrict"].ToString();
                lblSubdistrict.Text = dtApp.Rows[0]["CurrentBlock"].ToString();
                lblVillage.Text = dtApp.Rows[0]["CurrentPanchayat"].ToString();
                lblPin.Text = dtApp.Rows[0]["CurrentPinCode"].ToString();
                lblCenter.Text = dtApp.Rows[0]["centre"].ToString();
                lblStream.Text = dtApp.Rows[0]["stream"].ToString();

                lblTM10.Text = dtProvisionalMark.Rows[0]["10th_totalmarks"].ToString();
                lblMO10.Text = dtProvisionalMark.Rows[0]["10th_marksobtained"].ToString();
                lblPER10.Text = dtProvisionalMark.Rows[0]["10th_cgpa_percantage"].ToString();
                lblWEG10.Text = dtProvisionalMark.Rows[0]["10% of 10th Percentage"].ToString();

                lblTM12.Text = dtProvisionalMark.Rows[0]["12th_TotalMarks"].ToString();
                lblMO12.Text = dtProvisionalMark.Rows[0]["12th_MarksObtained"].ToString();
                //lblPCMB.Text = dtProvisionalMark.Rows[0]["PCM_PCBMarksText"].ToString();
                lblPER12.Text = dtProvisionalMark.Rows[0]["12th_cgpa_percantage"].ToString();
                lblWEG12.Text = dtProvisionalMark.Rows[0]["10% of 12th Percentage"].ToString();

                lblTM13.Text = dtProvisionalMark.Rows[0]["Diploma_totalmarks"].ToString();
                lblMO13.Text = dtProvisionalMark.Rows[0]["Diploma_marksobtained"].ToString();
                lblPER13.Text = dtProvisionalMark.Rows[0]["Diploma_cgpa_percantage"].ToString();
                lblWEG13.Text = dtProvisionalMark.Rows[0]["30% of Diploma Percentage"].ToString();

                lblTMEE.Text = dtProvisionalMark.Rows[0]["EntranceMarks"].ToString();
                lblMOEE.Text = dtProvisionalMark.Rows[0]["Marks in Written"].ToString();
                lblPEREE.Text = dtProvisionalMark.Rows[0]["Entrance Percentage"].ToString();
                lblWEGEE.Text = dtProvisionalMark.Rows[0]["50% of Entrance"].ToString();

                lblTOLWEG.Text = dtProvisionalMark.Rows[0]["TotalWeightage"].ToString();
                lblRank.Text = dtProvisionalMark.Rows[0]["Rank"].ToString();

                try
                {
                    QRCode1.GenerateQRCodeApplication(m_ServiceID, m_AppID);
                }
                catch { }
            }
            else
            {
                string m_Message = "Sorry! Admit Card for Reference No. "+ m_AppID + " not generate. Please complete the Application and make payment against the Reference ID.";
                lblMsg.Text = m_Message;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + m_Message + "');window.close();", true);
            }
        }


        static string m_ServiceURL = System.Configuration.ConfigurationManager.AppSettings["AddressService"].ToString();

        public interface IService1Channel : IAddressService, IClientChannel
        { }
        [WebMethod]
        public static string PrintAgroAdmitLog(string prefix, string RollNo, string AppID)
        {
            string URL = "";

            URL = m_ServiceURL;

            HttpContext.Current.Session["DatabaseName"] = "MasterDB";

            string text;
            using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new BasicHttpBinding()))
            {
                IService1Channel proxy = factory.CreateChannel(new EndpointAddress(URL));
                using (OperationContextScope scope = new OperationContextScope(proxy))
                {
                    //List<Tuple<string, string>> nvc = GetSessionValues();

                    //MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    //System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.PrintAgroAdmitLog(RollNo, AppID);

                }
            }

            return text;

        }
    }
}