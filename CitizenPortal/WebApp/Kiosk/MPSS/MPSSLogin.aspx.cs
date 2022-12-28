﻿using CitizenPortalLib.DataStructs;
using iTextSharp.text.pdf;
using java.lang;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SqlHelper;
using sun.net.www.content.text;
using sun.security.jca;
using sun.swing;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Exception = System.Exception;


namespace CitizenPortal.WebApp.Kiosk.MPSS
{
    public partial class MPSSLogin : System.Web.UI.Page
    {
        static data sqlhelper = new data();
        string t_LoginID;
        string t_UserType;
        protected void Page_Load(object sender, EventArgs e)
        {
            HdnField.Value = txtUserName.ToString();


            if (!Page.IsPostBack)
            {
                try
                {
                    P();
                    Session.Add("RandomNo", 0);
                    Random randomclass = new Random();
                    Session["RandomNo"] = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(randomclass.Next().ToString(), "MD5");
                    //end of md5 encryption
                    hdnRandomNo.Value = Session["RandomNo"].ToString();
                    //btnchangepass.Attributes.Add("onclick", "javascript:return md5auth('" + Convert.ToString(Session["RandomNo"]) + "');");

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {


                ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "isPostBack = true;", true);
            }
            //End logic

            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();

                var chkUserType = 0;

                if (rdSchool.Checked)
                {
                    chkUserType = 1;
                }

                if (rdDEOE.Checked)
                {
                    chkUserType = 2;
                }

                if (rdADMIN.Checked)
                {
                    chkUserType = 3;
                }


                var UserName = txtUserName.Text.Trim();
                var Password = txtPassword.Text.Trim();
                SqlParameter[] parameter = {
                        new SqlParameter("@UserName",UserName),
                         new SqlParameter("@UserType",chkUserType)

            };
                //dt = sqlhelper.ExecuteDataTable("GetMPBOCLoginSP", parameter);

                dt = sqlhelper.ExecuteDataTable("GetMPSSPassLoginSP", parameter);

                string Curretntpass = txtPassword.Text;
                string pwd1 = dt.Rows[0]["EncPassword"].ToString();
                string pwd3 = Encrpt(Session["SaltKey"].ToString());//convert Rndno into md5
                string pwd2 = Encrpt(pwd1.ToLower() + pwd3.ToLower());
                if (Curretntpass.ToLower() == pwd2.ToLower())//match both md5 value is same
                {
                    if (dt.Rows.Count > 0)
                    {

                        Session["G2GID"] = dt.Rows[0]["G2GID"].ToString();
                        Session["LoginID"] = dt.Rows[0]["UserName"].ToString();
                        Session["FullName"] = dt.Rows[0]["FullName"].ToString();
                        Session["MenuRole"] = dt.Rows[0]["MenuRole"].ToString();
                        Session["Role"] = dt.Rows[0]["Role"].ToString();
                        Session["CurrentCulture"] = dt.Rows[0]["CurrentCulture"].ToString();
                        Session["__SessionHelper__"] = "";
                        Session["sRole"] = dt.Rows[0]["sRole"].ToString();
                        Session["UserType"] = dt.Rows[0]["UserType"].ToString();
                        Session["Department"] = dt.Rows[0]["Department"].ToString();
                        Session["HomePage"] = dt.Rows[0]["HomePage"].ToString();

                        string strAuthToken = Guid.NewGuid().ToString();
                        Session["AuthToken"] = strAuthToken;
                        Response.Cookies.Add(new HttpCookie("AuthToken", strAuthToken));


                        Response.Redirect(Session["HomePage"].ToString());

                    }
                    else
                    {
                        Label1.Text = "Your username and Password is incorrect";
                        Label1.ForeColor = System.Drawing.Color.Red;

                    }
                }
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                Label1.ForeColor = System.Drawing.Color.Red;

            }
        }

        public void P()
        {
            Random randomclass = new Random();
            string num = randomclass.Next().ToString();
            Session["SaltKey"] = num;
            // HDNSaltKey.Value = num;
        }
        //Encrypt string in javascript and C# by the same way sha256 to get same results
        public static string Encrpt(string value)
        {
            string p = "";
            var message = Encoding.ASCII.GetBytes(value);
            SHA256Managed hashString = new SHA256Managed();
            string hex = "";

            var hashValue = hashString.ComputeHash(message);
            foreach (byte x in hashValue)
            {
                hex += System.String.Format("{0:x2}", x);
            }

            p = hex;

            return p;
        }

        //public static string SHA512(string input)
        //{
        //    var bytes = System.Text.Encoding.UTF8.GetBytes(input);
        //    using (var hash = System.Security.Cryptography.SHA512.Create())
        //    {
        //        var hashedInputBytes = hash.ComputeHash(bytes);

        //        // Convert to text
        //        // StringBuilder Capacity is 128, because 512 bits / 8 bits in byte * 2 symbols for byte 
        //        var hashedInputStringBuilder = new System.Text.StringBuilder(128);
        //        foreach (var b in hashedInputBytes)
        //            hashedInputStringBuilder.Append(b.ToString("X2"));
        //        return hashedInputStringBuilder.ToString();
        //    }
        //}
    }
}