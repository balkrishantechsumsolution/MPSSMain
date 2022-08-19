﻿using CitizenPortalLib;
using CitizenPortalLib.DataStructs;
using CitizenPortalLib.ServiceInterface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CitizenPortal.WebApp.Kiosk.OUAT
{
    public partial class FORMA : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //HFServiceID.Value = "932";

            string culture = "en-GB";

            //if (((HiddenField)Page.Master.FindControl("HFLang")).Value == "")
            //{
            //    ((HiddenField)Page.Master.FindControl("HFLang")).Value = "1";
            //    btnLang.Value = "1";

            //}

            //if (((HiddenField)Page.Master.FindControl("HFLang")).Value != "")
            //{
            //    if (((HiddenField)Page.Master.FindControl("HFLang")).Value == "1")
            //    {
            //        culture = "en-GB";
            //    }
            //    else if (((HiddenField)Page.Master.FindControl("HFLang")).Value == "2")
            //    {
            //        culture = "hi-IN";
            //    }
            //}

            if (HFCurrentLang.Value == "")
            {
                HFCurrentLang.Value = "1";
                btnLang.Value = "ଓଡ଼ିଆ";

            }

            if (HFCurrentLang.Value != "")
            {
                if (HFCurrentLang.Value == "1")
                {
                    culture = "en-GB";
                    HFCurrentLang.Value = "1";
                    btnLang.Value = "Odia";
                }
                else if (HFCurrentLang.Value == "2")
                {
                    culture = "or-IN";
                    HFCurrentLang.Value = "2";
                    btnLang.Value = "English";
                }
            }

            Session["CurrentCultureLabels"] = culture;
        }

        static string m_ServiceURL = System.Configuration.ConfigurationManager.AppSettings["AddressService"].ToString();


        public static T ToObjectFromJSON<T>(string jsonString)
        {
            var serializer = new System.Runtime.Serialization.Json.DataContractJsonSerializer(typeof(T));
            var memoryStream = new System.IO.MemoryStream(System.Text.Encoding.Unicode.GetBytes(jsonString));
            var newObject = (T)serializer.ReadObject(memoryStream);
            memoryStream.Close();
            return newObject;
        }

        public interface IService1Channel : IAddressService, IClientChannel
        { }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public static string InsertData(string prefix, string Data)
        {
            string noNewLines = Data.Replace("\n", "");
            OUATFormA_DT viewModel = ToObjectFromJSON<OUATFormA_DT>(noNewLines);

            string URL = "";
            URL = m_ServiceURL;


            if (HttpContext.Current.Session["CitizenID"] != null)
            {
                viewModel.CitizenProfileID = HttpContext.Current.Session["CitizenID"].ToString();
            }

            string text;
            BasicHttpBinding binding = new BasicHttpBinding();
            binding.MaxReceivedMessageSize = 10485760;
            binding.MaxBufferSize = 10485760;
            binding.MaxBufferPoolSize = 10485760;

            //WebHttpBinding binding1 = new WebHttpBinding();
            //binding1.MaxReceivedMessageSize = 10485760;

            using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(binding))
            {
                IService1Channel proxy = factory.CreateChannel(new EndpointAddress(URL));
                using (OperationContextScope scope = new OperationContextScope(proxy))
                {
                    List<Tuple<string, string>> nvc = GetSessionValues();

                    MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.InsertOUATFormA(viewModel);
                }
            }

            return text;

        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public static string GetOUATFormADataForEdit(string prefix, string UID, string AppID)
        {
            //IAddressService _proxy = GetProxy();
            //string text = _proxy.GetVillage("", SubDistrictCode);
            //return text;
            string URL = "";

            //if (HttpContext.Current.Request.Url.AbsoluteUri.Contains("localhost"))
            //    URL = "http://localhost:52349/AddressService.svc";
            //else
            //    URL = "http://citizenportalservice.azurewebsites.net/AddressService.svc";

            URL = m_ServiceURL;

            HttpContext.Current.Session["DatabaseName"] = "MasterDB";

            string text;
            BasicHttpBinding binding = new BasicHttpBinding();
            binding.MaxReceivedMessageSize = 10485760;
            binding.MaxBufferSize = 10485760;
            binding.MaxBufferPoolSize = 10485760;


            //using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new WSHttpBinding(SecurityMode.None, false)))
            using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(binding))
            {
                IService1Channel proxy = factory.CreateChannel(new EndpointAddress(URL));
                using (OperationContextScope scope = new OperationContextScope(proxy))
                {
                    List<Tuple<string, string>> nvc = GetSessionValues();

                    MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.GetOUATFormADataForEdit("", UID, AppID);

                }
            }

            return text;
        }

        [WebMethod]
        public static string GetDistrict_OUAT(string prefix, string StateCode)
        {
            //IAddressService _proxy = GetProxy();
            //string text = _proxy.GetDistrict("", StateCode);
            //return text;
            string URL = "";

            //if (HttpContext.Current.Request.Url.AbsoluteUri.Contains("localhost"))
            //    URL = "http://localhost:52349/AddressService.svc";
            //else
            //    URL = "http://citizenportalservice.azurewebsites.net/AddressService.svc";

            URL = m_ServiceURL;

            HttpContext.Current.Session["DatabaseName"] = "MasterDB";

            string text;
            //using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new WSHttpBinding(SecurityMode.None, false)))
            using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new BasicHttpBinding()))
            {
                IService1Channel proxy = factory.CreateChannel(new EndpointAddress(URL));
                using (OperationContextScope scope = new OperationContextScope(proxy))
                {
                    List<Tuple<string, string>> nvc = GetSessionValues();// new List<Tuple<string, string>>();

                    //string dbCon = HttpContext.Current.Session["DatabaseName"].ToString();
                    //string culture = HttpContext.Current.Session["CurrentCulture"].ToString();

                    //string ID = "";

                    //if (HttpContext.Current.Session["G2GID"] != null)
                    //{
                    //    ID = HttpContext.Current.Session["G2GID"].ToString();
                    //}
                    //else if (HttpContext.Current.Session["KioskID"] != null)
                    //{
                    //    ID = HttpContext.Current.Session["KioskID"].ToString();
                    //}

                    //nvc.Add(new Tuple<string, string>("G2GID", ID));
                    //nvc.Add(new Tuple<string, string>("KioskID", ID));
                    //nvc.Add(new Tuple<string, string>("CurrentCulture", culture));

                    //MessageHeader<string> mhg = new MessageHeader<string>(dbCon);
                    //System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("SQLServer", "DB");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    //mhg = new MessageHeader<string>(culture);
                    //untyped = mhg.GetUntypedHeader("Session", "CurrentCulture");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    //mhg = new MessageHeader<string>(ID);
                    //untyped = mhg.GetUntypedHeader("Session", "KioskID");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.GetDistrict_OUAT("", StateCode);

                }
            }

            return text;

        }

        [WebMethod]
        public static string GetSubDistrict_OUAT(string prefix, string DistrictCode)
        {
            //IAddressService _proxy = GetProxy();
            //string text = _proxy.GetSubDistrict("", DistrictCode);
            //return text;
            string URL = "";

            //if (HttpContext.Current.Request.Url.AbsoluteUri.Contains("localhost"))
            //    URL = "http://localhost:52349/AddressService.svc";
            //else
            //    URL = "http://citizenportalservice.azurewebsites.net/AddressService.svc";

            URL = m_ServiceURL;

            HttpContext.Current.Session["DatabaseName"] = "MasterDB";

            string text;
            //using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new WSHttpBinding(SecurityMode.None, false)))
            using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new BasicHttpBinding()))
            {
                IService1Channel proxy = factory.CreateChannel(new EndpointAddress(URL));
                using (OperationContextScope scope = new OperationContextScope(proxy))
                {
                    List<Tuple<string, string>> nvc = GetSessionValues(); //new List<Tuple<string, string>>();

                    //string dbCon = HttpContext.Current.Session["DatabaseName"].ToString();
                    //string culture = HttpContext.Current.Session["CurrentCulture"].ToString();

                    //string ID = "";

                    //if (HttpContext.Current.Session["G2GID"] != null)
                    //{
                    //    ID = HttpContext.Current.Session["G2GID"].ToString();
                    //}
                    //else if (HttpContext.Current.Session["KioskID"] != null)
                    //{
                    //    ID = HttpContext.Current.Session["KioskID"].ToString();
                    //}

                    //nvc.Add(new Tuple<string, string>("G2GID", ID));
                    //nvc.Add(new Tuple<string, string>("KioskID", ID));
                    //nvc.Add(new Tuple<string, string>("CurrentCulture", culture));

                    //MessageHeader<string> mhg = new MessageHeader<string>(dbCon);
                    //System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("SQLServer", "DB");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    //mhg = new MessageHeader<string>(culture);
                    //untyped = mhg.GetUntypedHeader("Session", "CurrentCulture");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    //mhg = new MessageHeader<string>(ID);
                    //untyped = mhg.GetUntypedHeader("Session", "KioskID");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.GetBlock_OUAT("", DistrictCode);

                }
            }

            return text;

        }

        [WebMethod]
        public static string GetVillage_OUAT(string prefix, string SubDistrictCode)
        {
            //IAddressService _proxy = GetProxy();
            //string text = _proxy.GetVillage("", SubDistrictCode);
            //return text;
            string URL = "";

            //if (HttpContext.Current.Request.Url.AbsoluteUri.Contains("localhost"))
            //    URL = "http://localhost:52349/AddressService.svc";
            //else
            //    URL = "http://citizenportalservice.azurewebsites.net/AddressService.svc";

            URL = m_ServiceURL;

            HttpContext.Current.Session["DatabaseName"] = "MasterDB";

            string text;
            //using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new WSHttpBinding(SecurityMode.None, false)))
            using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new BasicHttpBinding()))
            {
                IService1Channel proxy = factory.CreateChannel(new EndpointAddress(URL));
                using (OperationContextScope scope = new OperationContextScope(proxy))
                {
                    List<Tuple<string, string>> nvc = GetSessionValues(); // new List<Tuple<string, string>>();

                    //string dbCon = HttpContext.Current.Session["DatabaseName"].ToString();
                    //string culture = HttpContext.Current.Session["CurrentCulture"].ToString();

                    //string ID = "";

                    //if (HttpContext.Current.Session["G2GID"] != null)
                    //{
                    //    ID = HttpContext.Current.Session["G2GID"].ToString();
                    //}
                    //else if (HttpContext.Current.Session["KioskID"] != null)
                    //{
                    //    ID = HttpContext.Current.Session["KioskID"].ToString();
                    //}

                    //nvc.Add(new Tuple<string, string>("G2GID", ID));
                    //nvc.Add(new Tuple<string, string>("KioskID", ID));
                    //nvc.Add(new Tuple<string, string>("CurrentCulture", culture));

                    //MessageHeader<string> mhg = new MessageHeader<string>(dbCon);
                    //System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("SQLServer", "DB");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    //mhg = new MessageHeader<string>(culture);
                    //untyped = mhg.GetUntypedHeader("Session", "CurrentCulture");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    //mhg = new MessageHeader<string>(ID);
                    //untyped = mhg.GetUntypedHeader("Session", "KioskID");
                    //OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.GetPanchayat_OUAT("", SubDistrictCode);

                }
            }

            return text;
        }

        static List<Tuple<string, string>> GetSessionValues()
        {
            List<Tuple<string, string>> nvc = new List<Tuple<string, string>>();
            string culture = HttpContext.Current.Session["CurrentCulture"].ToString();
            string userType = HttpContext.Current.Session["UserType"].ToString();
            string ID = "";

            if (HttpContext.Current.Session["G2GID"] != null)
            {
                ID = HttpContext.Current.Session["G2GID"].ToString();
            }
            else if (HttpContext.Current.Session["KioskID"] != null)
            {
                ID = HttpContext.Current.Session["KioskID"].ToString();
            }
            else if (HttpContext.Current.Session["CitizenID"] != null)
            {
                ID = HttpContext.Current.Session["CitizenID"].ToString();
            }

            nvc.Add(new Tuple<string, string>("ID", ID));
            nvc.Add(new Tuple<string, string>("UserType", userType));
            nvc.Add(new Tuple<string, string>("CurrentCulture", culture));

            return nvc;
        }


        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public static string GetCitizenProfileData(string prefix, string Data)
        {
            //IAddressService _proxy = GetProxy();
            //string text = _proxy.GetVillage("", SubDistrictCode);
            //return text;
            string URL = "";

            //if (HttpContext.Current.Request.Url.AbsoluteUri.Contains("localhost"))
            //    URL = "http://localhost:52349/AddressService.svc";
            //else
            //    URL = "http://citizenportalservice.azurewebsites.net/AddressService.svc";

            URL = m_ServiceURL;

            HttpContext.Current.Session["DatabaseName"] = "MasterDB";

            string text;
            //using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new WSHttpBinding(SecurityMode.None, false)))
            using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new BasicHttpBinding()))
            {
                IService1Channel proxy = factory.CreateChannel(new EndpointAddress(URL));
                using (OperationContextScope scope = new OperationContextScope(proxy))
                {
                    List<Tuple<string, string>> nvc = new List<Tuple<string, string>>();

                    string dbCon = HttpContext.Current.Session["DatabaseName"].ToString();
                    string culture = HttpContext.Current.Session["CurrentCulture"].ToString();

                    string ID = "";

                    if (HttpContext.Current.Session["G2GID"] != null)
                    {
                        ID = HttpContext.Current.Session["G2GID"].ToString();
                    }
                    else if (HttpContext.Current.Session["KioskID"] != null)
                    {
                        ID = HttpContext.Current.Session["KioskID"].ToString();
                    }

                    nvc.Add(new Tuple<string, string>("G2GID", ID));
                    nvc.Add(new Tuple<string, string>("KioskID", ID));
                    nvc.Add(new Tuple<string, string>("CurrentCulture", culture));

                    MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.GetCitizenProfileData("", Data);

                }
            }

            return text;
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public static string GetDeclaration(string prefix, string UID)
        {
            //IAddressService _proxy = GetProxy();
            //string text = _proxy.GetVillage("", SubDistrictCode);
            //return text;
            string URL = "";

            //if (HttpContext.Current.Request.Url.AbsoluteUri.Contains("localhost"))
            //    URL = "http://localhost:52349/AddressService.svc";
            //else
            //    URL = "http://citizenportalservice.azurewebsites.net/AddressService.svc";

            URL = m_ServiceURL;

            HttpContext.Current.Session["DatabaseName"] = "MasterDB";

            string text;
            //using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new WSHttpBinding(SecurityMode.None, false)))
            using (ChannelFactory<IService1Channel> factory = new ChannelFactory<IService1Channel>(new BasicHttpBinding()))
            {
                IService1Channel proxy = factory.CreateChannel(new EndpointAddress(URL));
                using (OperationContextScope scope = new OperationContextScope(proxy))
                {
                    List<Tuple<string, string>> nvc = new List<Tuple<string, string>>();

                    string dbCon = HttpContext.Current.Session["DatabaseName"].ToString();
                    string culture = HttpContext.Current.Session["CurrentCulture"].ToString();

                    string ID = "";

                    if (HttpContext.Current.Session["G2GID"] != null)
                    {
                        ID = HttpContext.Current.Session["G2GID"].ToString();
                    }
                    else if (HttpContext.Current.Session["KioskID"] != null)
                    {
                        ID = HttpContext.Current.Session["KioskID"].ToString();
                    }

                    nvc.Add(new Tuple<string, string>("G2GID", ID));
                    nvc.Add(new Tuple<string, string>("KioskID", ID));
                    nvc.Add(new Tuple<string, string>("CurrentCulture", culture));

                    MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.GetDeclaration("", UID);

                }
            }

            return text;
        }

        [WebMethod]
        public static string GetEducationBoard(string prefix, string StateCode)
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
                    List<Tuple<string, string>> nvc = GetSessionValues();

                    MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.GetEducationBoard("", StateCode);

                }
            }

            return text;

        }

        [WebMethod]
        public static string EPassLog(string prefix, string RollNo, string AppID)
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

                    text = proxy.InsertEPassLog(RollNo, AppID);

                }
            }

            return text;

        }

        [WebMethod]
        public static string GetExamCenter(string prefix)
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
                    List<Tuple<string, string>> nvc = GetSessionValues();

                    MessageHeader<List<Tuple<string, string>>> mhg = new MessageHeader<List<Tuple<string, string>>>(nvc);
                    System.ServiceModel.Channels.MessageHeader untyped = mhg.GetUntypedHeader("Session", "SessionTuple");
                    OperationContext.Current.OutgoingMessageHeaders.Add(untyped);

                    text = proxy.GetExamCenter("");
                }
            }

            return text;
        }

    }
}