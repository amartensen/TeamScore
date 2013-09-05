using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
   


//<<<<<<<<<< Person registration >>>>>>>>>>
    
    public class person
    {
        public string fname { get; set; }
        public string lname { get; set; }
        public string userID { get; set; }
        public string state { get; set; }
        public string dob { get; set; }
        public string sex { get; set; }
    }


    [WebMethod]
    public static void newPerson(string userID, string per_fname, DateTime per_dob, string per_lname, string per_sex)
    {
        
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO person (userID, per_fname, per_lname, per_dob, per_sex) VALUES (@userID, @per_fname, @per_lname, @per_dob, @per_sex); Select SCOPE_IDENTITY();";

            connection.Open();

            SqlCommand Command = new SqlCommand(sql, connection);
            Command.Parameters.AddWithValue("@userID", userID);
            Command.Parameters.AddWithValue("@per_fname", per_fname);
            Command.Parameters.AddWithValue("@per_lname", per_lname);
            Command.Parameters.AddWithValue("@per_dob", per_dob);
            Command.Parameters.AddWithValue("@per_sex", per_sex);

            Command.ExecuteNonQuery();
        }
    }
}