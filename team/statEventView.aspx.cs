using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class team_statEventView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //<<<<<<<< Event Athletes >>>>>>>>>
    public class events
    {
        
        public string eventName{ get; set; }
        public string address { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string startDate { get; set; }
        public string startTime { get; set; }
        public string eventID { get; set; }
        public string styleID { get; set; }
        public string levelID { get; set; }
    }

    [WebMethod]
    public static events[] getEvtDetails(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT eventName, startDate, startTime, eventType, address, city, state, levelID, styleID, eventID FROM dbo.events WHERE eventID = @eventID;";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();

            var _events = new List<events>();
            while (reader.Read())
                {
                    var evt = new events();
                    evt.startDate = reader["startDate"].ToString();
                    evt.eventName = reader["eventName"].ToString();
                    evt.address = reader["address"].ToString();
                    evt.city = reader["city"].ToString();
                    evt.state = reader["state"].ToString();
                    evt.startTime = reader["startTime"].ToString();
                    evt.eventID = reader["eventID"].ToString();
                    evt.styleID = reader["styleID"].ToString();
                    evt.levelID = reader["levelID"].ToString();
                    _events.Add(evt);
                }
                         

            //Close connections
            reader.Close();
            connection.Close();

            return _events.ToArray();
        }
    }
    //<<<<<<<< Event Matches >>>>>>>>>
    public class match
    {
        public string weight { get; set; }
        public string hfName { get; set; }
        public string hlName { get; set; }
        public string hgrade { get; set; }
        public string hwinner { get; set; }
        public string hwinType { get; set; }
        public string hfallTime { get; set; }

        public string afName { get; set; }
        public string alName { get; set; }
        public string agrade { get; set; }
        public string awinner { get; set; }
        public string awinType { get; set; }
        public string afallTime { get; set; }
    }

    [WebMethod]
    public static List<match> getEventMatches(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT matchHome.amount AS weight, matchHome.fName AS hfName, matchHome.lName AS hlName, matchHome.grade AS hgrade, matchHome.winner AS hwinner, matchHome.winType AS hwinType, matchHome.fallTime AS hfallTime, matchAway.fName AS afName, matchAway.lName AS alName, matchAway.grade AS agrade, matchAway.winner AS awinner, matchAway.winType AS awinType, matchAway.fallTime AS afallTime FROM matchHome INNER JOIN matchAway ON matchHome.boutID = matchAway.boutID WHERE (matchHome.boutID IN (SELECT bout.boutID FROM bouts AS bout INNER JOIN brackets AS brkt ON bout.bracketID = brkt.bracketID WHERE (brkt.eventID = @eventID)));";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();
            
       
            var _matches = new List<match>();
            while (reader.Read())
            {   
                    var mat = new match();
                    mat.weight = reader["weight"].ToString();
                    mat.hfName = reader["hfName"].ToString();
                    mat.hlName = reader["hlName"].ToString();
                    mat.hgrade = reader["hgrade"].ToString();
                    mat.hwinner = reader["hwinner"].ToString();
                    mat.hwinType = reader["hwinType"].ToString();
                    mat.hfallTime = reader["hfallTime"].ToString();
                    mat.afName = reader["afName"].ToString();
                    mat.alName = reader["alName"].ToString();
                    mat.agrade = reader["agrade"].ToString();
                    mat.awinner = reader["awinner"].ToString();
                    mat.awinType = reader["awinType"].ToString();
                    mat.afallTime = reader["afallTime"].ToString();
                    _matches.Add(mat);
            }
            
            //Close connections
            reader.Close();
            connection.Close();

            return _matches;
        }
    }

    //<<<<<<<< Event Teams >>>>>>>>>
    public class team
    {
        public string teamName { get; set; }
        public string nameAbrv { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string eventTeamID { get; set; }
    }

    [WebMethod]
    public static List<team> getEventTeams(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT eventTeamID, teamName, city, state, nameAbrv FROM eventTeams WHERE (eventID = @eventID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();

            List<team> _teams = new List<team>();
            while (reader.Read())
            {
                _teams.Add(new team()
                {
                    teamName = reader["teamName"].ToString(),
                    nameAbrv = reader["nameAbrv"].ToString(),
                    city = reader["city"].ToString(),
                    state = reader["state"].ToString(),
                    eventTeamID = reader["eventTeamID"].ToString(),

                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _teams;
        }
    }

    //<<<<<<<< Event Athletes >>>>>>>>>
    public class athlete
    {
        public string fName { get; set; }
        public string lName { get; set; }
        public string grade { get; set; }
        public string amount { get; set; }
        public string teamName { get; set; }
    }

    [WebMethod]
    public static List<athlete> getEventAthletes(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT eventMembers.fName, eventMembers.lName, eventMembers.grade, eventTeams.teamName, eventGroups.amount, eventMembers.memberID FROM eventGroups INNER JOIN eventMembers ON eventGroups.eventGroupID = eventMembers.eventGroupID LEFT OUTER JOIN eventTeams ON eventMembers.eventTeamID = eventTeams.eventTeamID WHERE (eventGroups.eventID = @eventID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();

            List<athlete> _athletes = new List<athlete>();
            while (reader.Read())
            {
                _athletes.Add(new athlete()
                {
                    teamName = reader["teamName"].ToString(),
                    lName = reader["lName"].ToString(),
                    fName = reader["fName"].ToString(),
                    grade = reader["grade"].ToString(),
                    amount = reader["amount"].ToString(),
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _athletes;
        }
    }
}