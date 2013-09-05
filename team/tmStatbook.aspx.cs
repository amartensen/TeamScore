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
            string sql = "SELECT tmMem.teamMemberID, tmMem.fName, tmMem.lName, tmMem.personID, tmMem.tmb_adminRole, tmMem.tmb_isAthlete, tmMem.tmb_isCoach, " +
                                "tmMem.tmb_link_status, tmMem.grade, tmSeas.teamID " +
                         "FROM teamMembers AS tmMem INNER JOIN " +
                                "tmMemSeasons AS tmMemSea ON tmMem.teamMemberID = tmMemSea.teamMemberID INNER JOIN " +
                                "teamSeasons AS tmSeas ON tmMemSea.teamSeasonID = tmSeas.teamSeasonID " +
                         "WHERE (tmSeas.tms_name = 'CUR') AND (tmSeas.teamID = 1);";

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
            string sql = "SELECT tmMem.teamMemberID, tmMem.fName, tmMem.lName, tmMem.personID, tmMem.tmb_adminRole, tmMem.tmb_isAthlete, tmMem.tmb_isCoach, " +
                                "tmMem.tmb_link_status, tmMem.grade, tmSeas.teamID " +
                         "FROM teamMembers AS tmMem INNER JOIN " +
                                "tmMemSeasons AS tmMemSea ON tmMem.teamMemberID = tmMemSea.teamMemberID INNER JOIN " +
                                "teamSeasons AS tmSeas ON tmMemSea.teamSeasonID = tmSeas.teamSeasonID " +
                         "WHERE (tmSeas.tms_name = 'CUR') AND (tmSeas.teamID = 1) AND (tmMem.tmb_isAthlete = 'Y');";

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
    
    public class events
    {
        public string eventID { get; set; }
        public string evt_name { get; set; }
        public string evt_ven_name { get; set; }
        public string evt_addr { get; set; }
        public string evt_city { get; set; }
        public string evt_state { get; set; }
        public string evt_zip { get; set; }
        public string startDate { get; set; }
        public string startTime { get; set; }
        public string evt_type { get; set; }
        public string styleID { get; set; }
        public string levelID { get; set; }
    }
    //Event Details
    [WebMethod]
    public static events[] getEventDetails(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT evt_name, startDate, startTime, evt_type, evt_ven_name, evt_addr, evt_city, evt_state, evt_zip, levelID, styleID, eventID FROM dbo.events WHERE eventID = @eventID;";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();

            var _events = new List<events>();
            while (reader.Read())
            {
                var evt = new events();
                evt.startDate = reader["startDate"].ToString();
                evt.evt_name = reader["evt_name"].ToString();
                evt.evt_ven_name = reader["evt_ven_name"].ToString();
                evt.evt_addr = reader["evt_addr"].ToString();
                evt.evt_city = reader["evt_city"].ToString();
                evt.evt_state = reader["evt_state"].ToString();
                evt.evt_zip = reader["evt_zip"].ToString();
                evt.startTime = reader["startTime"].ToString();
                evt.evt_type = reader["evt_type"].ToString();
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

   //Event Sessions
    public class session
    {
        public string eventDateID { get; set; }
        public string edt_type { get; set; }
        public string edt_date { get; set; }
        public string edt_time { get; set; }
        public string edt_title { get; set; }
        public string eventID { get; set; }
    }

 
    [WebMethod]
    public static session[] getEventSessions(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT eventDateID, edt_type, edt_date, edt_time, edt_title, eventID FROM eventDates WHERE eventID = @eventID;";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();

            var _session = new List<session>();
            while (reader.Read())
            {
                var div = new session();
                div.eventDateID = reader["eventDateID"].ToString();
                div.edt_type = reader["edt_type"].ToString();
                div.edt_date = reader["edt_date"].ToString();
                div.edt_time = reader["edt_time"].ToString();
                div.edt_title = reader["edt_title"].ToString();
                _session.Add(div);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _session.ToArray();
        }
    }

    [WebMethod]
    public static void addNewSession(string eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO eventDates (eventID) VALUES (@eventID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            command.ExecuteNonQuery();
        }
    }

    [WebMethod]
    public static void saveEventSession(string eventDateID, string edt_title, string edt_date, string edt_time, string edt_type)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "UPDATE eventDates SET edt_type = @edt_type, edt_time = @edt_time, edt_date = @edt_date, edt_title = @edt_title WHERE (eventDateID = @eventDateID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@edt_type", edt_type);
            command.Parameters.AddWithValue("@edt_time", edt_time);
            command.Parameters.AddWithValue("@edt_date", edt_date);
            command.Parameters.AddWithValue("@edt_title", edt_title);
            command.Parameters.AddWithValue("@eventDateID", eventDateID);

            command.ExecuteNonQuery();
        }
    }


    public class divisions
    {
        public string divisionsID { get; set; }
        public string div_name { get; set; }
    }

    //Event Divisions
    [WebMethod]
    public static divisions[] getEventDivisions(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT div.evtd_name, div.divisionsID FROM eventDivisions AS evtd INNER JOIN "+
			"divisions AS div ON div.divisionsID = evtd.divisionsID WHERE evtd.eventID = @eventID;"
			
            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();

            var _divisions = new List<divisions>();
            while (reader.Read())
            {
                var div = new divisions();
                div.div_name = reader["evtd_name"].ToString();
                div.divisionsID = reader["divisionsID"].ToString();
                _divisions.Add(div);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _divisions.ToArray();
        }
    }

    public class divisionClasses
    {
        public string eventGroupID { get; set; }
        public string evtg_name { get; set; }
    }

    //Event Groups
    [WebMethod]
    public static divisionClasses[] getEventClasses(int divisionID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT evtg_name, eventGroupID FROM divisionClasses WHERE eventDivisionID = @divisionID;";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@divisionID", divisionID);
            SqlDataReader reader = command.ExecuteReader();

            var _groups = new List<divisionClasses>();
            while (reader.Read())
            {
                var div = new divisionClasses();
                div.evtg_name = reader["evtg_name"].ToString();
                div.eventGroupID = reader["eventGroupID"].ToString();
                _groups.Add(div);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _groups.ToArray();
        }
    }

    public class brackets
    {
        public string bracketID { get; set; }
        public string bracketName { get; set; }
    }

    //Event brackets
    [WebMethod]
    public static brackets[] getEventBrackets(int eventID, int divisionID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT bracketName, bracketID FROM brackets WHERE (eventID = @eventID) AND (divisionID = @divisionID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            command.Parameters.AddWithValue("@divisionID", divisionID);
            SqlDataReader reader = command.ExecuteReader();

            var _brackets = new List<brackets>();
            while (reader.Read())
            {
                var bkt = new brackets();
                bkt.bracketName = reader["bracketName"].ToString();
                bkt.bracketID = reader["bracketID"].ToString();
                _brackets.Add(bkt);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _brackets.ToArray();
        }
    }

    [WebMethod]
    public static List<events> getTeamEvents(int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT CONVERT (varchar(10), startDate, 101) AS date, evt_name, CONVERT (varchar(10), startTime, 108) AS startTime, evt_ven_name, evt_addr, evt_city, evt_state, evt_zip, evt_type, levelID, styleID, eventID FROM events " +
                        "WHERE (eventID IN (SELECT eventID FROM tmEvents WHERE (teamID = @teamID))) ORDER BY date" ;

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamID", teamID);
            SqlDataReader reader = command.ExecuteReader();

            List<events> _events = new List<events>();
            while (reader.Read())
            {
                _events.Add(new events()
                {
                    startDate = reader["date"].ToString(),
                    evt_name = reader["evt_name"].ToString(),
                    startTime = reader["startTime"].ToString(),
                    evt_addr = reader["evt_addr"].ToString(),
                    evt_city = reader["evt_city"].ToString(),
                    evt_state = reader["evt_state"].ToString(),
                    evt_zip = reader["evt_zip"].ToString(),
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
    //<<<<<< EVENT SETTINGS >>>>>>>>>>
    [WebMethod]
    public static void saveEventName(string evt_name, string eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "UPDATE events SET evt_name = @name WHERE (eventID = @eventID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@name", evt_name);
            command.Parameters.AddWithValue("@eventID", eventID);

            command.ExecuteNonQuery();
        }
    }

    [WebMethod]
    public static void saveEventVenue(string evt_ven_name, string eventID, string evt_addr, string evt_city, string evt_state, string evt_zip)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "UPDATE events SET evt_ven_name = @ven_name, evt_addr = @evt_addr, evt_city = @evt_city, evt_state = @evt_state, evt_zip = @evt_zip WHERE (eventID = @eventID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@ven_name", evt_ven_name);
            command.Parameters.AddWithValue("@evt_addr", evt_addr);
            command.Parameters.AddWithValue("@evt_city", evt_city);
            command.Parameters.AddWithValue("@evt_state", evt_state);
            command.Parameters.AddWithValue("@evt_zip", evt_zip);
            command.Parameters.AddWithValue("@eventID", eventID);

            command.ExecuteNonQuery();
        }
    }

    [WebMethod]
    public static void newTeamEvents(int teamID, string eventName, DateTime startDate, DateTime startTime, int eventType, string address, string city, string state, string zip, string styleID, string levelID)
    {

        //Establish a connection with the sql connection string declared in the web.config file.
        //Insert new data on a team member
        string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);

        //Create SQL paragraph and parameters
        //Insert info into events table
        string commandInsert = "Insert INTO events (evt_name, startDate, startTime, evt_type, evt_addr, evt_city, evt_state, evt_zip, styleID, levelID) VALUES (@eventName, @startDate, @startTime, @eventType, @address, @city, @state, @zip, @styleID, @levelID); Select SCOPE_IDENTITY();";
        SqlCommand myCommand = new SqlCommand(commandInsert, sqlConn);
        myCommand.Parameters.AddWithValue("@eventName", eventName);
        myCommand.Parameters.AddWithValue("@startDate", startDate);
        myCommand.Parameters.AddWithValue("@startTime", startTime);
        myCommand.Parameters.AddWithValue("@eventType", eventType);
        myCommand.Parameters.AddWithValue("@address", address);
        myCommand.Parameters.AddWithValue("@city", city);
        myCommand.Parameters.AddWithValue("@state", state);
        myCommand.Parameters.AddWithValue("@zip", zip);
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



    //<<<<<<<< Event Athletes >>>>>>>>>
    
    

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
            string sql = "SELECT eventMembers.fName, eventMembers.lName, eventMembers.grade, eventTeams.teamName, divisionClasses.amount, eventMembers.memberID FROM divisionClasses INNER JOIN eventMembers ON divisionClasses.eventGroupID = eventMembers.eventGroupID LEFT OUTER JOIN eventTeams ON eventMembers.eventTeamID = eventTeams.eventTeamID WHERE (divisionClasses.eventID = @eventID)";

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
        public string hfname { get; set; }
        public string hlname { get; set; }
        public string hgrade { get; set; }
        public string afname { get; set; }
        public string alname { get; set; }
        public string agrade { get; set; }
    }

    [WebMethod]
    public static List<match> getEventMatches(int bracketID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT away.evta_fname AS afname, away.evta_lname AS alname, away.evta_grade AS agrade, home.evta_fname AS hfname, home.evta_lname AS hlname, " + 
                                "home.evta_grade AS hgrade "+
                            "FROM bouts INNER JOIN "+
                                "homeBouts AS home ON bouts.boutID = home.boutID INNER JOIN "+
                                "awayBouts AS away ON bouts.boutID = away.boutID "+
                            "WHERE (bouts.bracketID = @bracketID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@bracketID", bracketID);
            SqlDataReader reader = command.ExecuteReader();


            var _matches = new List<match>();
            while (reader.Read())
            {
                var mat = new match();
                mat.afname = reader["afname"].ToString();
                mat.alname = reader["alname"].ToString();
                mat.agrade = reader["agrade"].ToString();
                mat.hfname = reader["hfname"].ToString();
                mat.hlname = reader["hlname"].ToString();
                mat.hgrade = reader["hgrade"].ToString();
                _matches.Add(mat);
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _matches;
        }
    }
    //<<<<<<<<< Get Team Seasons >>>>>>>>>
    public class teamSeason
    {
        public string teamSeasonID { get; set; }
        public string teamID { get; set; }
        public string tms_name { get; set; }
    }

    //Event Divisions
    [WebMethod]
    public static teamSeason[] getTeamSeasons(int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT teamSeasonID, tms_name FROM teamSeasons WHERE teamID = @teamID;";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamID", teamID);
            SqlDataReader reader = command.ExecuteReader();

            var _seasons = new List<teamSeason>();
            while (reader.Read())
            {
                var div = new teamSeason();
                div.tms_name = reader["tms_name"].ToString();
                div.teamSeasonID = reader["teamSeasonID"].ToString();
                _seasons.Add(div);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _seasons.ToArray();
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