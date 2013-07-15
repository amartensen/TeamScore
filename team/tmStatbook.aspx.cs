using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class team_tmStatbook : System.Web.UI.Page
{

    public class person
    {
        public string fname { get; set; }
        public string lname { get; set; }
        public string userID { get; set; }
        public string email { get; set; }
    }

    [WebMethod]
    public static List<person> getPersons(string per_email)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT per_fname, per_lname, per_email, userID FROM person WHERE (per_email = @per_email);";

            connection.Open();

            SqlCommand sqlcomd = new SqlCommand(sql, connection);
            sqlcomd.Parameters.AddWithValue("@per_email", per_email);
            SqlDataReader reader = sqlcomd.ExecuteReader();

            List<person> _persons = new List<person>();
            while (reader.Read())
            {
                _persons.Add(new person()
                {
                    userID = reader["userID"].ToString(),
                    fname = reader["per_fname"].ToString(),
                    lname = reader["per_lname"].ToString(),
                    email = reader["per_email"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _persons;
        }
    }

    [WebMethod]
    public static List<person> getPerson(string userID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT per_fname, per_lname, userID FROM person WHERE (userID = @userID);";

            connection.Open();

            SqlCommand sqlcomd = new SqlCommand(sql, connection);
            sqlcomd.Parameters.AddWithValue("@userID", userID);
            SqlDataReader reader = sqlcomd.ExecuteReader();

            List<person> _person = new List<person>();
            while (reader.Read())
            {
                _person.Add(new person()
                {
                    userID = reader["userID"].ToString(),
                    fname = reader["per_fname"].ToString(),
                    lname = reader["per_lname"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _person;
        }
    }

    //<<<<<<<<<GET TEAM>>>>>>>>>>>>>>>
    public class team
    {
        public string tm_name { get; set; }
        public string teamID { get; set; }
        public string tm_city { get; set; }
        public string tm_state { get; set; }
        public string con_name { get; set; }
    }

    [WebMethod]
    public static team[] getTeam(int teamID)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {


            string sql = "SELECT tm_name, teamID, tm_city, tm_state, tm_con_name FROM teams WHERE (teamID = @teamID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamID", teamID);
            SqlDataReader reader = command.ExecuteReader();

            var _team = new List<team>();
            while (reader.Read())
            {
                var tm = new team();
                tm.teamID = reader["teamID"].ToString();
                tm.tm_name = reader["tm_name"].ToString();
                tm.con_name = reader["tm_con_name"].ToString();
                tm.tm_state = reader["tm_state"].ToString();
                tm.tm_city = reader["tm_city"].ToString();
                _team.Add(tm);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _team.ToArray();
        }
    }

    //<<<<<<<< Team Members >>>>>>>>>
    public class tmMember
    {
        public string tmMemberID { get; set; }
        public string fName { get; set; }
        public string lName { get; set; }
        public string grade { get; set; }
        public string teamID { get; set; }
        public string personID { get; set; }
        public string tmb_isAthlete { get; set; }
        public string tmb_isCoach { get; set; }
        public string tmb_adminRole { get; set; }
        public string tmb_phone { get; set; }
        public string tmb_link_status { get; set; }
        public string em_name { get; set; }
        public string em_phone { get; set; }
        public string per_fname { get; set; }
        public string per_lname { get; set; }
        public string per_state { get; set; }
    }

    [WebMethod]
    public static List<tmMember> getTeamMembers(int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT teamMemberID, fName, lName, grade, teamID, personID, tmb_isAthlete, tmb_isCoach, tmb_adminRole, tmb_link_status FROM teamMembers WHERE teamID = @teamID";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamID", teamID);
            SqlDataReader reader = command.ExecuteReader();

            List<tmMember> _members = new List<tmMember>();
            while (reader.Read())
            {
                _members.Add(new tmMember()
                {
                    tmMemberID = reader["teamMemberID"].ToString(),
                    fName = reader["fName"].ToString(),
                    lName = reader["lName"].ToString(),
                    grade = reader["grade"].ToString(),
                    teamID = reader["teamID"].ToString(),
                    personID = reader["personID"].ToString(),
                    tmb_isAthlete = reader["tmb_isAthlete"].ToString(),
                    tmb_isCoach = reader["tmb_isCoach"].ToString(),
                    tmb_adminRole = reader["tmb_adminRole"].ToString(),
                    tmb_link_status = reader["tmb_link_status"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _members;
        }
    }

    [WebMethod]
    public static List<tmMember> getTeamAthletes(int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT teamMemberID, fName, lName, grade, teamID, personID FROM teamMembers WHERE teamID = @teamID AND tmb_isAthlete = 'Y'";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamID", teamID);
            SqlDataReader reader = command.ExecuteReader();

            List<tmMember> _members = new List<tmMember>();
            while (reader.Read())
            {
                _members.Add(new tmMember()
                {
                    tmMemberID = reader["teamMemberID"].ToString(),
                    fName = reader["fName"].ToString(),
                    lName = reader["lName"].ToString(),
                    grade = reader["grade"].ToString(),
                    teamID = reader["teamID"].ToString(),
                    personID = reader["personID"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _members;
        }
    }

    [WebMethod]
    public static List<tmMember> getTeamMember(int tmMemberID, int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT teamMembers.teamMemberID, teamMembers.fName, teamMembers.lName, teamMembers.grade, teamMembers.teamID, teamMembers.personID, " +
                            "teamMembers.tmb_isAthlete, teamMembers.tmb_isCoach, teamMembers.tmb_adminRole, teamMembers.tmb_link_status, teamMembers.tmb_phone, " +
                            "teamMembers.tmb_em_name, teamMembers.tmb_em_phone, person.per_fname, person.per_lname, person.per_state " +
                        "FROM teamMembers LEFT OUTER JOIN person ON teamMembers.personID = person.userID " +
                        "WHERE (teamMembers.teamMemberID = @tmMemberID) AND (teamMembers.teamID = @teamID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@tmMemberID", tmMemberID);
            command.Parameters.AddWithValue("@teamID", teamID);
            SqlDataReader reader = command.ExecuteReader();

            List<tmMember> _member = new List<tmMember>();
            while (reader.Read())
            {
                _member.Add(new tmMember()
                {
                    tmMemberID = reader["teamMemberID"].ToString(),
                    fName = reader["fName"].ToString(),
                    lName = reader["lName"].ToString(),
                    grade = reader["grade"].ToString(),
                    teamID = reader["teamID"].ToString(),
                    personID = reader["personID"].ToString(),
                    tmb_isAthlete = reader["tmb_isAthlete"].ToString(),
                    tmb_isCoach = reader["tmb_isCoach"].ToString(),
                    tmb_adminRole = reader["tmb_adminRole"].ToString(),
                    tmb_phone = reader["tmb_phone"].ToString(),
                    em_name = reader["tmb_em_name"].ToString(),
                    em_phone = reader["tmb_em_phone"].ToString(),
                    tmb_link_status = reader["tmb_link_status"].ToString(),
                    per_fname = reader["per_fname"].ToString(),
                    per_lname = reader["per_lname"].ToString(),
                    per_state = reader["per_state"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _member;
        }
    }

    [WebMethod]
    public static List<tmMember> getTMConnection(int tmMemberID, int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT person.per_fname, person.per_lname, person.per_state, person.per_email, teamMembers.tmb_link_status, teamMembers.tmb_adminRole, teamMembers.teamMemberID, teamMembers.personID " +
                         "FROM teamMembers LEFT OUTER JOIN person ON teamMembers.personID = person.userID "+
                         "WHERE (teamMembers.teamMemberID = @tmMemberID) AND (teamMembers.teamID = @teamID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@tmMemberID", tmMemberID);
            command.Parameters.AddWithValue("@teamID", teamID);
            SqlDataReader reader = command.ExecuteReader();

            List<tmMember> _member = new List<tmMember>();
            while (reader.Read())
            {
                _member.Add(new tmMember()
                {
                    tmMemberID = reader["teamMemberID"].ToString(),
                    personID = reader["personID"].ToString(),
                    tmb_link_status = reader["tmb_link_status"].ToString(),
                    tmb_adminRole = reader["tmb_adminRole"].ToString(),
                    per_fname = reader["per_fname"].ToString(),
                    per_lname = reader["per_lname"].ToString(),
                    per_state = reader["per_state"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _member;
        }
    }

    [WebMethod]
    public static void invitePerson (string personID, string tmMemberID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "UPDATE teamMembers SET tmb_link_status = @status, personID = @userID WHERE (teamMemberID = @teamMemberID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamMemberID", tmMemberID);
            command.Parameters.AddWithValue("@userID", personID);
            command.Parameters.AddWithValue("@status", 'P');
            command.ExecuteNonQuery();
        }
    }

    [WebMethod]
    public static void cancelPerInvite(int tmMemberID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "UPDATE teamMembers SET tmb_link_status = NULL, personID = NULL WHERE (teamMemberID = @teamMemberID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamMemberID", tmMemberID);
            command.ExecuteNonQuery();
        }
    }

    [WebMethod]
    public static void newTeamMembers(string fName, string lName, int teamID, string userID, string isAthlete, string adminRole)
    {
        
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "INTO teamMembers (fName, lName, teamID, tmb_adminRole, tmb_isAthlete, personID) VALUES (@fName, @lName, @teamID, @adminRole, @athlete, @userID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@fName", fName);
            command.Parameters.AddWithValue("@lName", lName);
            command.Parameters.AddWithValue("@teamID", teamID);
            command.Parameters.AddWithValue("@athlete", isAthlete);
            command.Parameters.AddWithValue("@adminRole", adminRole);
            command.Parameters.AddWithValue("@userID", userID);

            command.ExecuteNonQuery();
        }
    }
    
    [WebMethod]
    public static void addTmbAdminRole(int tmMemberID, string roleID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "UPDATE teamMembers SET tmb_adminRole = @roleID WHERE (teamMemberID = @teamMemberID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@roleID", roleID);
            command.Parameters.AddWithValue("@teamMemberID", tmMemberID);
            command.ExecuteNonQuery();
        }
    }


    //Update Team Members

    [WebMethod]
    public static void saveTMBName(string tmm_fName, string tmm_lName, int tmMemberID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "UPDATE teamMembers SET fName = @fName, lName = @lName WHERE (teamMemberID = @teamMemberID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@fName", tmm_fName);
            command.Parameters.AddWithValue("@lName", tmm_lName);
            command.Parameters.AddWithValue("@teamMemberID", tmMemberID);

            command.ExecuteNonQuery();
        }
    }

    [WebMethod]
    public static string newTeamMember(string tmm_fName, string tmm_lName, int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO teamMembers (fName, lName, teamID) VALUES (@fName, @lName, @teamID) Select SCOPE_IDENTITY();";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@fName", tmm_fName);
            command.Parameters.AddWithValue("@lName", tmm_lName);
            command.Parameters.AddWithValue("@teamID", teamID);

            string teamMemberID = command.ExecuteScalar().ToString();
            return teamMemberID;
        }
    }

    [WebMethod]
    public static void saveTMBRole(string isAthlete, string isCoach, int tmMemberID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "UPDATE teamMembers SET tmb_isAthlete = @athlete, tmb_isCoach = @coach WHERE (teamMemberID = @teamMemberID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@athlete", isAthlete);
            command.Parameters.AddWithValue("@coach", isCoach);
            command.Parameters.AddWithValue("@teamMemberID", tmMemberID);

            command.ExecuteNonQuery();
        }
    }


//<<<<<<<<<< Team Events >>>>>>>>>>
    
    public class tmEvent
    {
        public string date { get; set; }
        public string eventName { get; set; }
        public string startTime { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string eventID { get; set; }
        public string styleID { get; set; }
        public string levelID { get; set; }
    }
    
    [WebMethod]
    public static List<tmEvent> getTeamEvents(int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT CONVERT (varchar(10), startDate, 101) AS date, eventName, CONVERT (varchar(10), startTime, 108) AS startTime, city, state, levelID, styleID, eventID FROM events " +
                        "WHERE (eventID IN (SELECT eventID FROM tmEvents WHERE (teamID = @teamID))) ORDER BY date" ;

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamID", teamID);
            SqlDataReader reader = command.ExecuteReader();

            List<tmEvent> _events = new List<tmEvent>();
            while (reader.Read())
            {
                _events.Add(new tmEvent()
                {
                    date = reader["date"].ToString(),
                    eventName = reader["eventName"].ToString(),
                    startTime = reader["startTime"].ToString(),
                    city = reader["city"].ToString(),
                    state = reader["state"].ToString(),
                    eventID = reader["eventID"].ToString(),
                    styleID = reader["styleID"].ToString(),
                    levelID = reader["levelID"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _events;
        }
    }

    [WebMethod]
    public static void newTeamEvents(int teamID, string eventName, DateTime startDate, DateTime startTime, int eventType, string address, string city, string state, string styleID, string levelID)
    {

        //Establish a connection with the sql connection string declared in the web.config file.
        //Insert new data on a team member
        string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);

        //Create SQL paragraph and parameters
        //Insert info into events table
        string commandInsert = "Insert INTO events (eventName, startDate, startTime, eventType, address, city, state, styleID, levelID) VALUES (@eventName, @startDate, @startTime, @eventType, @address, @city, @state, @styleID, @levelID); Select SCOPE_IDENTITY();";
        SqlCommand myCommand = new SqlCommand(commandInsert, sqlConn);
        myCommand.Parameters.AddWithValue("@eventName", eventName);
        myCommand.Parameters.AddWithValue("@startDate", startDate);
        myCommand.Parameters.AddWithValue("@startTime", startTime);
        myCommand.Parameters.AddWithValue("@eventType", eventType);
        myCommand.Parameters.AddWithValue("@address", address);
        myCommand.Parameters.AddWithValue("@city", city);
        myCommand.Parameters.AddWithValue("@state", state);
        myCommand.Parameters.AddWithValue("@styleID", styleID);
        myCommand.Parameters.AddWithValue("@levelID", levelID);

        sqlConn.Open();

        string eventID = myCommand.ExecuteScalar().ToString();
        
        //Add new event to the tmEvent table
        string addtotmEvents = "Insert INTO tmEvents (eventID, teamID) VALUES (@eventID, @teamID);";
        SqlCommand sqlCom = new SqlCommand(commandInsert, sqlConn);
        sqlCom = new SqlCommand(addtotmEvents, sqlConn);
        sqlCom.Parameters.AddWithValue("@eventID", eventID);
        sqlCom.Parameters.AddWithValue("@teamID", teamID);

        //Add team to new events eventTeams table
        string addtoevtTeams = "Insert INTO eventTeams (teamID, city, state, eventID) VALUES (@teamID, @city, @state, @eventID);";
        SqlCommand myComd = new SqlCommand(addtoevtTeams, sqlConn);
        myComd.Parameters.AddWithValue("@teamID", teamID);
        myComd.Parameters.AddWithValue("@city", city);
        myComd.Parameters.AddWithValue("@state", state);
        myComd.Parameters.AddWithValue("@eventID", eventID);

        sqlCom.ExecuteNonQuery();
        myComd.ExecuteNonQuery();
    }

    //<<<<<<<<<< Team Dates >>>>>>>>>>

    public class eventDate
    {
        public string edt_date { get; set; }
        public string edt_type { get; set; }
        public string eventDatesID { get; set; }
        public string edt_time { get; set; }
        public string edt_title { get; set; }
        public string eventID { get; set; }
    }

    [WebMethod]
    public static eventDate[] getEventDates(int eventID)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT edt_date, edt_type, edt_time, eventDatesID, edt_title eventID FROM dbo.events WHERE eventID = @eventID;";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();

            var _events = new List<eventDate>();
            while (reader.Read())
            {
                var evt = new eventDate();
                evt.edt_date = reader["edt_date"].ToString();
                evt.edt_type = reader["edt_type"].ToString();
                evt.edt_time = reader["edt_time"].ToString();
                evt.eventDatesID = reader["eventDatesID"].ToString();
                evt.edt_title = reader["edt_title"].ToString();
                _events.Add(evt);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _events.ToArray();
        }
    }



    //<<<<<<<< Event Athletes >>>>>>>>>
    
    //Event Details
    public class events
    {

        public string eventName { get; set; }
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
    public static events[] getEventDetails(int eventID)
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

    //Event Teams
    public class eventTeam
    {
        public string tm_name { get; set; }
        public string tm_name_abrv { get; set; }
        public string tm_city { get; set; }
        public string tm_state { get; set; }
        public string eventTeamID { get; set; }
    }

    [WebMethod]
    public static List<eventTeam> getEventTeams(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT eventTeamID, teamName, city, state, nameAbrv FROM eventTeams WHERE (eventID = @eventID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();

            List<eventTeam> _teams = new List<eventTeam>();
            while (reader.Read())
            {
                _teams.Add(new eventTeam()
                {
                    tm_name = reader["teamName"].ToString(),
                    tm_name_abrv = reader["nameAbrv"].ToString(),
                    tm_city = reader["city"].ToString(),
                    tm_state = reader["state"].ToString(),
                    eventTeamID = reader["eventTeamID"].ToString(),

                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _teams;
        }
    }

    //Event Athletes
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

    //Event Matches
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


    //<<<<<<<<<< Get Schools >>>>>>>>>>

    public class school
    {
        public string schoolID { get; set; }
        public string sch_name { get; set; }
        public string sch_loc_addr { get; set; }
        public string sch_loc_city { get; set; }
        public string sch_loc_state { get; set; }
        public string sch_loc_zip { get; set; }
        public string sch_tm_name { get; set; }
        public string sch_tm_abrv { get; set; }
        public string sch_lge_name { get; set; }
        public string sch_lge_org { get; set; }
        public string sch_con_length { get; set; }
        public string sch_con_name { get; set; }
        public string sch_con_cost { get; set; }
        public string sch_con_status { get; set; }
    }

    [WebMethod]
    public static List<school> getSchools(string sch_name, string sch_loc_state)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT schoolID, sch_name, sch_loc_addr, sch_loc_city, sch_loc_zip, sch_loc_state, sch_tm_name FROM schools WHERE (sch_loc_state = @schlocstate AND sch_name LIKE @schname)";

            connection.Open();

            SqlCommand sqlcomd = new SqlCommand(sql, connection);
            sqlcomd.Parameters.AddWithValue("@schlocstate", sch_loc_state);
            sqlcomd.Parameters.AddWithValue("@schname","%"+sch_name+"%");
            SqlDataReader reader = sqlcomd.ExecuteReader();

            List<school> _schools = new List<school>();
            while (reader.Read())
            {
                _schools.Add(new school()
                {
                    schoolID = reader["schoolID"].ToString(),
                    sch_name = reader["sch_name"].ToString(),
                    sch_loc_addr = reader["sch_loc_addr"].ToString(),
                    sch_loc_city = reader["sch_loc_city"].ToString(),
                    sch_loc_state = reader["sch_loc_state"].ToString(),
                    sch_loc_zip = reader["sch_loc_zip"].ToString(),
                    sch_tm_name = reader["sch_tm_name"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _schools;
        }
    }
    


    //<<<<<<<<<< Get a School >>>>>>>>>>

    [WebMethod]
    public static List<school> getSchool(string schoolID)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
         
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT schools.schoolID, schools.sch_name, schools.sch_loc_addr, schools.sch_loc_city, schools.sch_loc_zip, schools.sch_loc_state, schools.sch_tm_name, " +
                        "schools.sch_tm_abrv, leagues.lge_name, leagues.lge_organization, teamContracts.tmc_status, contracts.con_name, contracts.con_length, contracts.con_cost " +
                        "FROM teamContracts RIGHT OUTER JOIN schools ON teamContracts.schoolID = schools.schoolID LEFT OUTER JOIN leagues INNER JOIN schoolLeagues ON " +
                        "leagues.leagueID = schoolLeagues.leagueID ON schools.schoolID = schoolLeagues.schoolID LEFT OUTER JOIN " +
                        "contracts ON teamContracts.contractID = contracts.contractID WHERE (schools.schoolID = @schoolID);";

            connection.Open();

            SqlCommand sqlcomd = new SqlCommand(sql, connection);
            sqlcomd.Parameters.AddWithValue("@schoolID", schoolID);
            SqlDataReader reader = sqlcomd.ExecuteReader();

            List<school> _school = new List<school>();
            while (reader.Read())
            {
                _school.Add(new school()
                {
                    schoolID = reader["schoolID"].ToString(),
                    sch_name = reader["sch_name"].ToString(),
                    sch_loc_addr = reader["sch_loc_addr"].ToString(),
                    sch_loc_city = reader["sch_loc_city"].ToString(),
                    sch_loc_state = reader["sch_loc_state"].ToString(),
                    sch_loc_zip = reader["sch_loc_zip"].ToString(),
                    sch_tm_name = reader["sch_tm_name"].ToString(),
                    sch_tm_abrv = reader["sch_tm_abrv"].ToString(),
                    sch_lge_name = reader["lge_name"].ToString(),
                    sch_lge_org = reader["lge_organization"].ToString(),
                    sch_con_name = reader["con_name"].ToString(),
                    sch_con_length = reader["con_length"].ToString(),
                    sch_con_cost = reader["con_cost"].ToString(),
                    sch_con_status = reader["tmc_status"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _school;
        }
    }
}