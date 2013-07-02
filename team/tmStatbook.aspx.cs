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
    protected void Page_Load(object sender, EventArgs e)
    {

    }

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
            string sql = "SELECT person.per_fname, person.per_lname, person.per_state, person.per_email, teamMembers.tmb_link_status, teamMembers.teamMemberID, teamMembers.personID "+
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
    
}