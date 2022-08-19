﻿using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CitizenPortalLib.DataStructs;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace CitizenPortalLib.DAL
{
    class FisheriesRegistrationDAL : DALBase
    {
        Database m_DataBase;

        //Insert Fisheries Registration In Table
        internal DataTable Insert(FisheriesRegistration_DT objCRAFT_DT, string[] aFields)
        {
            DbCommand cmdInsert;
            QueryBuilder qb = new QueryBuilder();
            m_DataBase = Factory.Create(this.ConnectionString);
            cmdInsert = qb.GetInsertCommandV3(objCRAFT_DT, "InsertFisheriesRegistrationSP", aFields);
            DataTable oDataTable = new DataTable();
            IDataReader Reader = null;
            Reader = m_DataBase.ExecuteReader(cmdInsert);
            if (Reader != null)
                oDataTable.Load(Reader);
            return oDataTable;
        }


        //Getting Fisheries Registration Data
        internal DataSet GetAppDetails(string ServiceID, string AppID)
        {
            DataSet oDataTable = new DataSet();
            IDataReader Reader = null;
            m_DataBase = Factory.Create(this.ConnectionString);
            try
            {
                DbCommand selectCommand;
                selectCommand = m_DataBase.GetStoredProcCommand("GetFisheriesRegistrationSP");
                m_DataBase.AddInParameter(selectCommand, "@ServiceID", DbType.AnsiString, ServiceID);
                m_DataBase.AddInParameter(selectCommand, "@AppID", DbType.AnsiString, AppID);
                Reader = m_DataBase.ExecuteReader(selectCommand);
                if (Reader != null)
                    oDataTable.Load(Reader, LoadOption.OverwriteChanges, new string[] { "AppDetails", "TransDetails" });
                return oDataTable;
            }
            finally
            {
                if (Reader != null)
                {
                    Reader.Close();
                }
            }
        }
    }
}