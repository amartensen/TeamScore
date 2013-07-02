using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Collections;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// Summary description for EvtTeamsWS
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.ComponentModel.ToolboxItem(false)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class EvtTeamsWS : System.Web.Services.WebService {

    public class evtTeams
    {
        public string id { get; set; }
        public string Name { get; set; }
        public string state { get; set; }
        public string city { get; set; }
    }

    private List<evtTeams> _teams = new List<evtTeams>();

    public EvtTeamsWS () {
        
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT eventTeamID, teamName, city, state FROM eventTeams WHERE eventID = 1001";

            connection.Open();
            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataReader reader = command.ExecuteReader();

            while (reader.Read())
            {
                _teams.Add(new evtTeams()
                {
                    Name = reader["teamName"].ToString(),
                    city = reader["city"].ToString(),
                    state = reader["state"].ToString(),
                    id = reader["eventTeamID"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();
        }
    }

    [WebMethod]
    public List<evtTeams> GetEvtTeams()
    {
        return _teams;
    }
}
