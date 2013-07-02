using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for teamMemberWS
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class teamMemberWS : System.Web.Services.WebService {

    public class tmMember
    {
        public string tmMemberID { get; set; }
        public string fName { get; set; }
        public string lName { get; set; }
        public string grade { get; set; }
        public string teamID { get; set; }
        public string userID { get; set; }
    }

        
    [WebMethod]
    public List<tmMember> getTeamMembers () {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT tmMemberID, fName, lName, grade, teamID, userID FROM tmMembers WHERE teamID = 1";

            connection.Open();
                
            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataReader reader = command.ExecuteReader();
                
            List<tmMember> _members = new List<tmMember>();
            while (reader.Read())
            {
                _members.Add(new tmMember()
                {
                    tmMemberID = reader["tmMemberID"].ToString(),
                    fName = reader["fName"].ToString(),
                    lName = reader["lName"].ToString(),
                    grade = reader["grade"].ToString(),
                    teamID = reader["teamID"].ToString(),
                    userID = reader["userID"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();
                
            return _members;
        }
    }


    [WebMethod]
    public List<tmMember> newTeamMember()
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO tmMembers (fName, lName, grade, teamID, userID) VALUES (@fName, @lName, @grade, @teamID, @userID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataReader reader = command.ExecuteReader();

            List<tmMember> _members = new List<tmMember>();
            while (reader.Read())
            {
                _members.Add(new tmMember()
                {
                    tmMemberID = reader["tmMemberID"].ToString(),
                    fName = reader["fName"].ToString(),
                    lName = reader["lName"].ToString(),
                    grade = reader["grade"].ToString(),
                    teamID = reader["teamID"].ToString(),
                    userID = reader["userID"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _members;
        }
    }
}
    

