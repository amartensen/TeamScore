<%@ WebService Language="C#" Class="weightGroup" %>

using System.Web.Script.Services;
using AjaxControlToolkit;
using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data.SqlClient;
[ScriptService]
public class weightGroup : System.Web.Services.WebService
{
    [WebMethod (EnableSession=true)]
    public CascadingDropDownNameValue[] getDivisions(string knownCategoryValues, string category)
    {
        string strConnection = System.Configuration.ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);
        
        //Create SQL paragraph and parameters
        string divSelect = "Select divisionName, eventDivisionID FROM eventDivisions WHERE eventID = @eventDetailsID;";
        SqlCommand myCommand = new SqlCommand(divSelect, sqlConn);
        myCommand.Parameters.AddWithValue("@eventDetailsID", Session["EventID"]);
        
        //Test and Open Connection
        try
        {
            sqlConn.Open();
        }
        catch (Exception err)
        {
            Console.WriteLine(err.ToString());
        }
        
        //Run Sql Paragraph
        SqlDataReader dtrDiv = myCommand.ExecuteReader();
        List<CascadingDropDownNameValue> l = new List<CascadingDropDownNameValue>();
        
        while (dtrDiv.Read())
         {
             l.Add(new CascadingDropDownNameValue(dtrDiv["divisionName"].ToString(),
             dtrDiv["eventDivisionID"].ToString()));
         }
        //Test and Close Connection
        try
        {
            sqlConn.Close();
        }
        catch (Exception err)
        {
            Console.WriteLine(err.ToString());
        }
        
        return l.ToArray();
    }
    
    [WebMethod]
    public CascadingDropDownNameValue[] getWeights(string knownCategoryValues, string category)
    {
        int intDivId;
        StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        
        if (!kv.ContainsKey("Division") || !Int32.TryParse(kv["Division"],out intDivId)) 
         {
         throw new ArgumentException("Couldn't find vendor.");
         };
        
        string strConnection = System.Configuration.ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);
        
        //Create SQL paragraph and parameters
        string wgtSelect = "SELECT amount, eventGroupID FROM eventGroups WHERE eventDivisionID = @divisionid;";
        SqlCommand myCommand = new SqlCommand(wgtSelect, sqlConn);         
        myCommand.Parameters.AddWithValue("@divisionid", intDivId);
        
        //Test and Open Connection
        try
        {
            sqlConn.Open();
        }
        catch (Exception err)
        {
            Console.WriteLine(err.ToString());
        }
        
        //Run Sql Paragraph
        SqlDataReader dtrWeight = myCommand.ExecuteReader();
        List<CascadingDropDownNameValue> l = new List<CascadingDropDownNameValue>();
        while (dtrWeight.Read())
         {
         l.Add(new CascadingDropDownNameValue(
         dtrWeight["amount"].ToString(), dtrWeight["eventGroupID"].ToString()));
         }
        
        //Test and Close Connection
        try
        {
            sqlConn.Close();
        }
        catch (Exception err)
        {
            Console.WriteLine(err.ToString());
        }
        
        return l.ToArray();
    }
}

