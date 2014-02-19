using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
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
        public string tm_abrv { get; set; }
        public string tm_cur_season { get; set; }
    }

    public class admin
    {
        public string adm_status { get; set; }
        public string teamID { get; set; }
        public string personID { get; set; }
    }

    [WebMethod]
    public static admin[] getAdminStatus(int teamID)
    {
        MembershipUser user = Membership.GetUser();
        string user_ID = user.ProviderUserKey.ToString();

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {


            string sql = "SELECT tmb_adminRole, teamID FROM teamMembers WHERE (personID = @personID) AND (teamID = @teamID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);

            command.Parameters.AddWithValue("@teamID", teamID);
            command.Parameters.AddWithValue("@personID", user_ID);
            SqlDataReader reader = command.ExecuteReader();

            var _admin = new List<admin>();
            while (reader.Read())
            {
                var tm = new admin();
                tm.teamID = reader["teamID"].ToString();
                tm.adm_status = reader["tmb_adminRole"].ToString();    
                _admin.Add(tm);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _admin.ToArray();
        }
    }

    [WebMethod]
    public static team[] getTeam(int teamID)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {


            string sql = "SELECT teams.tm_name, teams.teamID, teams.tm_city, teams.tm_state, teams.tm_con_name, teams.tm_abrv, teamSeasons.teamSeasonID " +
                         "FROM teams LEFT OUTER JOIN teamSeasons ON teams.teamID = teamSeasons.teamID " +
                         "WHERE (teams.teamID = @teamID) AND (teamSeasons.tms_current = 'Y')";

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
                tm.tm_abrv = reader["tm_abrv"].ToString();
                tm.tm_cur_season = reader["teamSeasonID"].ToString();
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

    //Gets the members on the team that are not athletes
    [WebMethod]
    public static List<tmMember> getNonAthletes(int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT tmMem.teamMemberID, tmMem.fName, tmMem.lName, tmMem.personID, tmMem.tmb_adminRole, tmMem.tmb_isAthlete, tmMem.tmb_isCoach, " +
                                "tmMem.tmb_link_status, tmMem.grade, tmSeas.teamID " +
                         "FROM teamMembers AS tmMem INNER JOIN " +
                                "tmMemSeasons AS tmMemSea ON tmMem.teamMemberID = tmMemSea.teamMemberID INNER JOIN " +
                                "teamSeasons AS tmSeas ON tmMemSea.teamSeasonID = tmSeas.teamSeasonID " +
                         "WHERE (tmSeas.tms_name = 'CUR') AND (tmSeas.teamID = @teamID) AND (tmMem.tmb_isAthlete != 'Y')";

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
                         "WHERE (tmSeas.tms_name = 'CUR') AND (tmSeas.teamID = @teamID) AND (tmMem.tmb_isAthlete = 'Y');";

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
            string sql = "Insert INTO teamMembers (fName, lName, teamID, tmb_adminRole, tmb_isAthlete, personID) VALUES (@fName, @lName, @teamID, @adminRole, @athlete, @userID); Select SCOPE_IDENTITY();";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@fName", fName);
            command.Parameters.AddWithValue("@lName", lName);
            command.Parameters.AddWithValue("@teamID", teamID);
            command.Parameters.AddWithValue("@athlete", isAthlete);
            command.Parameters.AddWithValue("@adminRole", adminRole);
            command.Parameters.AddWithValue("@userID", userID);
            string teamMemberID = command.ExecuteScalar().ToString();
            
            
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
            

            string season = "1";

            string sqlseason = "Insert INTO tmMemSeasons (teamMemberID, teamSeasonID) VALUES (@tmMemberID, @season);";



            SqlCommand cmd = new SqlCommand(sqlseason, connection);
            cmd.Parameters.AddWithValue("@tmMemberID", teamMemberID);
            cmd.Parameters.AddWithValue("@season", season);
            cmd.ExecuteNonQuery();


            connection.Close();
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
        public string div_owner { get; set; }
    }
 
    //Event Divisions
    [WebMethod]
    public static divisions[] getEventDivisions(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT div.evtd_name, div.divisionsID FROM eventDivisions AS evtd INNER JOIN "+
                    "divisions AS div ON div.divisionsID = evtd.divisionsID WHERE evtd.eventID = @eventID;";
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

    //Event Divisions
    [WebMethod]
    public static divisions[] getTeamDivisions(int teamID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT div.evtd_name, div.evtd_owner, div.divisionsID FROM leagueSeasons INNER JOIN " +
                         "teamLeagues ON leagueSeasons.leagueSeasonID = teamLeagues.leagueSeasonID RIGHT OUTER JOIN " +
                         "leagueDivisions ON leagueSeasons.leagueSeasonID = leagueDivisions.leagueSeasonID RIGHT OUTER JOIN " +
                         "divisions AS div ON leagueDivisions.divisionID = div.divisionsID WHERE (teamLeagues.teamID = @teamID)";
            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamID", teamID);
            SqlDataReader reader = command.ExecuteReader();

            var _divisions = new List<divisions>();
            while (reader.Read())
            {
                var div = new divisions();
                div.div_name = reader["evtd_name"].ToString();
                div.div_owner = reader["evtd_owner"].ToString();
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
        public string eventClassID { get; set; }
        public string evtc_name { get; set; }
    }

    //Event Classes
    [WebMethod]
    public static divisionClasses[] getEventClasses(int divisionID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT evtc_name, eventClassID FROM divisionClasses WHERE divisionID = @divisionID;";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@divisionID", divisionID);
            SqlDataReader reader = command.ExecuteReader();

            var _groups = new List<divisionClasses>();
            while (reader.Read())
            {
                var div = new divisionClasses();
                div.evtc_name = reader["evtc_name"].ToString();
                div.eventClassID = reader["eventClassID"].ToString();
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
        public string bkt_title { get; set; }
    }

    //Event brackets
    [WebMethod]
    public static brackets[] getEventBrackets(int eventID, int divisionID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT brackets.bkt_title, brackets.bracketID "+
                         "FROM brackets INNER JOIN "+
                         "divisions ON brackets.divisionID = divisions.divisionsID " +
                         "WHERE (brackets.eventID = @eventID) AND (divisions.divisionsID = @divisionID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            command.Parameters.AddWithValue("@divisionID", divisionID);
            SqlDataReader reader = command.ExecuteReader();

            var _brackets = new List<brackets>();
            while (reader.Read())
            {
                var bkt = new brackets();
                bkt.bkt_title = reader["bkt_title"].ToString();
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
    public static List<events> getTeamEvents(int teamSeasonID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT CONVERT (varchar(10), startDate, 101) AS date, evt_name, CONVERT (varchar(10), startTime, 108) AS startTime, evt_ven_name, evt_addr, evt_city, evt_state, evt_zip, evt_type, levelID, styleID, eventID FROM events " +
                        "WHERE (eventID IN (SELECT eventID FROM eventTeams WHERE (teamSeasonID = @teamSeasonID))) ORDER BY date" ;

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamSeasonID", teamSeasonID);
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
    public static void newTeamEvents(int teamID, int teamSeasonID, string evt_name, int evt_type, string evt_ven_name, string evt_addr, string evt_city,
        string evt_state, string evt_zip, string styleID, string levelID, List<string> divisionIDS, List<string> sessions)
    {

        //Establish a connection with the sql connection string declared in the web.config file.
        //Insert new data on a team member
        string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);

        //Create SQL paragraph and parameters
        //Insert info into events table
        string commandInsert = "Insert INTO events (evt_name, evt_type, evt_ven_name, evt_addr, evt_city, evt_state, evt_zip, styleID, levelID) "+
                                "VALUES (@eventName, @eventType, @evt_ven_name, @address, @city, @state, @zip, @styleID, @levelID); Select SCOPE_IDENTITY();";
        SqlCommand myCommand = new SqlCommand(commandInsert, sqlConn);
        myCommand.Parameters.AddWithValue("@eventName", evt_name);
        myCommand.Parameters.AddWithValue("@eventType", evt_type);
        myCommand.Parameters.AddWithValue("@evt_ven_name", evt_ven_name);
        myCommand.Parameters.AddWithValue("@address", evt_addr);
        myCommand.Parameters.AddWithValue("@city", evt_city);
        myCommand.Parameters.AddWithValue("@state", evt_state);
        myCommand.Parameters.AddWithValue("@zip", evt_zip);
        myCommand.Parameters.AddWithValue("@styleID", styleID);
        myCommand.Parameters.AddWithValue("@levelID", levelID);

        sqlConn.Open();

        string eventID = myCommand.ExecuteScalar().ToString();
        
        //Add team to new events eventTeams table
        team[] evt_team = getTeam(teamID);
        team teamAddr = evt_team[0];

        string addtoevtTeams = "Insert INTO eventTeams (teamSeasonID, teamName, city, state, nameAbrv, eventID) VALUES (@teamSeasonID, @teamName, @city, @state, @nameAbrv, @eventID);";
        SqlCommand myComd = new SqlCommand(addtoevtTeams, sqlConn);
        myComd.Parameters.AddWithValue("@teamSeasonID", teamSeasonID);
        myComd.Parameters.AddWithValue("@teamName", teamAddr.tm_name);
        myComd.Parameters.AddWithValue("@city", teamAddr.tm_city);
        myComd.Parameters.AddWithValue("@state", teamAddr.tm_state);
        myComd.Parameters.AddWithValue("@nameAbrv", teamAddr.tm_abrv);
        myComd.Parameters.AddWithValue("@eventID", eventID);
        myComd.ExecuteNonQuery();
        
        
        //Add divisions to eventDivisions table
        foreach (var item in divisionIDS)
        {
            JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
            divisions div = jsonSerializer.Deserialize<divisions>(item);
            
            string addtoevtDivs = "Insert INTO eventDivisions (eventID, divisionsID) VALUES (@eventID, @divisionsID);";
            SqlCommand mySql = new SqlCommand(addtoevtDivs, sqlConn);
            mySql.Parameters.AddWithValue("@eventID", eventID);
            mySql.Parameters.AddWithValue("@divisionsID", div.divisionsID);
            mySql.ExecuteNonQuery();
        }       
        
        //Add sessions to the eventDates table
        foreach (var item in sessions)
        {
            JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
            session ses = jsonSerializer.Deserialize<session>(item);
                    
            string addtoevtDates = "Insert INTO eventDates (eventID, edt_type, edt_date, edt_time, edt_title) VALUES (@eventID, @type, @date, @time, @title);";
            SqlCommand Sql = new SqlCommand(addtoevtDates, sqlConn);
            Sql.Parameters.AddWithValue("@eventID", eventID);
            Sql.Parameters.AddWithValue("@type", ses.edt_type);
            Sql.Parameters.AddWithValue("@date", ses.edt_date);
            Sql.Parameters.AddWithValue("@time", ses.edt_time);
            Sql.Parameters.AddWithValue("@title", ses.edt_title);
            Sql.ExecuteNonQuery();
       }

    }



    //<<<<<<<< Event Content >>>>>>>>>
    
    

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

    [WebMethod]
    public static void addNewEvtTeam(string etm_name, string etm_city, string etm_state, string etm_abrv, int eventID)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO eventTeams (teamName, city, state, nameAbrv, eventID) "+
                         "VALUES (@teamName, @city, @state, @nameAbrv, @eventID); Select SCOPE_IDENTITY();";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamName", etm_name);
            command.Parameters.AddWithValue("@city", etm_city);
            command.Parameters.AddWithValue("@state", etm_state);
            command.Parameters.AddWithValue("@nameAbrv", etm_abrv);
            command.Parameters.AddWithValue("@eventID", eventID);
            command.ExecuteScalar();


        }
    }

    //Event Athletes
    public class athlete
    {
        public string eventAthleteID { get; set; }
        public string evta_fname { get; set; }
        public string evta_lname { get; set; }
        public string evta_grade { get; set; }
        public string evta_class { get; set; }
        public string evta_team { get; set; }
    }

    [WebMethod]
    public static List<athlete> getEventAthletes(int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT eventAthletes.eventAthleteID, eventAthletes.evta_fname, eventAthletes.evta_lname, eventAthletes.evta_grade, eventTeams.teamName "+
                         "FROM eventAthletes LEFT OUTER JOIN eventTeams ON eventAthletes.eventTeamID = eventTeams.eventTeamID "+
                         "WHERE (eventAthletes.eventID = @eventID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();

            List<athlete> _athletes = new List<athlete>();
            while (reader.Read())
            {
                _athletes.Add(new athlete()
                {   
                    eventAthleteID = reader["eventAthleteID"].ToString(),
                    evta_team = reader["teamName"].ToString(),
                    evta_lname = reader["evta_lname"].ToString(),
                    evta_fname = reader["evta_fname"].ToString(),
                    evta_grade = reader["evta_grade"].ToString(),
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _athletes;
        }
    }

    [WebMethod]
    public static void addNewEvtAthlete(string evta_fname, string evta_lname, Nullable<int> evta_grade, Nullable<int> evta_team, int eventID)
    {
        
        //var grade.ValueType;
        
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO eventAthletes (evta_fname, evta_lname, evta_grade, eventTeamID, eventID) " +
                         "VALUES (@evta_fname, @evta_lname, @evta_grade, @evta_team, @eventID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);

            DbParameter grade = command.CreateParameter();
            DbParameter team = command.CreateParameter();
            grade = command.CreateParameter();
            team = command.CreateParameter();
            grade.ParameterName = "@evta_grade";
            if (evta_grade == 0)
            {
                grade.Value = DBNull.Value;
            }
            else { grade.Value = evta_grade; }

            team.ParameterName = "@evta_team";
            if (evta_team == 0)
            {
                team.Value = DBNull.Value;
            }
            else { team.Value = evta_team; }

            command.Parameters.AddWithValue("@evta_fname", evta_fname);
            command.Parameters.AddWithValue("@evta_lname", evta_lname);
            command.Parameters.Add(grade);
            command.Parameters.Add(team);
            command.Parameters.AddWithValue("@eventID", eventID);
            command.ExecuteScalar();

            connection.Close();
        }
    }

    //Event Brackets
    public class bracket
    {
        public string bracketID { get; set; }
        public string bkt_typeID { get; set; }
        public string btp_title { get; set; }
        public string bkt_styleID { get; set; }
        public string bkt_title { get; set; }
        public string bkt_classID { get; set; }
        public string bkt_className { get; set; }
        public string bkt_divisionID { get; set; }
        public string bkt_divisionName { get; set; }
        public string evtd_classOpt { get; set; }
    }

    [WebMethod]
    public static List<bracket> getBracketInfo(int bracketID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT brackets.bkt_title, brackets.divisionID, brackets.evtc_classID, bracketTypes.btp_style, bracketTypes.btp_title, brackets.bracketID, bracketTypes.bracketTypeID, " +
                         "divisions.evtd_name, divisions.evtd_classOpt, divisionClasses.evtc_name " +
                         "FROM brackets INNER JOIN "+
                         "bracketTypes ON brackets.btp_typeID = bracketTypes.bracketTypeID INNER JOIN "+
                         "divisionClasses ON brackets.evtc_classID = divisionClasses.eventClassID INNER JOIN "+
                         "divisions ON brackets.divisionID = divisions.divisionsID AND divisionClasses.divisionID = divisions.divisionsID "+
                         "WHERE (brackets.bracketID = @bracketID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@bracketID", bracketID);
            SqlDataReader reader = command.ExecuteReader();

            List<bracket> _brackets = new List<bracket>();
            while (reader.Read())
            {
                _brackets.Add(new bracket()
                {
                    bracketID = reader["bracketID"].ToString(),
                    bkt_typeID = reader["bracketTypeID"].ToString(),
                    bkt_styleID = reader["btp_style"].ToString(),
                    btp_title = reader["btp_title"].ToString(),
                    bkt_title = reader["bkt_title"].ToString(),
                    bkt_classID = reader["evtc_classID"].ToString(),
                    bkt_divisionID = reader["divisionID"].ToString(),
                    bkt_className = reader["evtc_name"].ToString(),
                    bkt_divisionName = reader["evtd_name"].ToString(),
                    evtd_classOpt = reader["evtd_classOpt"].ToString(),
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _brackets;
        }
    }

    public class bktAthlete
    {
        public string eventAthleteID { get; set; }
        public string evta_fname { get; set; }
        public string evta_lname { get; set; }
        public string evta_grade { get; set; }
        public string bkts_seednumber { get; set; }
        public string evta_team { get; set; }
    }

    [WebMethod]
    public static List<bktAthlete> getBracketAthletes(int bracketID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT eventAthletes.eventAthleteID, eventAthletes.evta_fname, eventAthletes.evta_lname, eventAthletes.evta_grade, eventTeams.teamName, seeds.seed_number "+
                         "FROM eventTeams INNER JOIN eventAthletes ON eventTeams.eventTeamID = eventAthletes.eventTeamID RIGHT OUTER JOIN brackets INNER JOIN "+
                         "seeds ON brackets.bracketID = seeds.bracketID ON eventAthletes.eventAthleteID = seeds.eventAthleteID "+
                         "WHERE (brackets.bracketID = @bracketID) "+
                         "ORDER BY seeds.seed_number";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@bracketID", bracketID);
            SqlDataReader reader = command.ExecuteReader();

            List<bktAthlete> _athletes = new List<bktAthlete>();
            while (reader.Read())
            {
                _athletes.Add(new bktAthlete()
                {
                    eventAthleteID = reader["eventAthleteID"].ToString(),
                    evta_team = reader["teamName"].ToString(),
                    evta_lname = reader["evta_lname"].ToString(),
                    evta_fname = reader["evta_fname"].ToString(),
                    evta_grade = reader["evta_grade"].ToString(),
                    bkts_seednumber = reader["seed_number"].ToString(),
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
        public string hwinner { get; set; }
        public string hwintype { get; set; }
        public string htmPoints { get; set; }
        public string htotal { get; set; }
        public string hfallTime { get; set; }
        public string hteam { get; set; }

        public string afname { get; set; }
        public string alname { get; set; }
        public string agrade { get; set; }
        public string awinner { get; set; }
        public string awintype { get; set; }
        public string atmPoints { get; set; }
        public string atotal { get; set; }
        public string afallTime { get; set; }
        public string ateam { get; set; }

        public string boutID { get; set; }
        public string bout_className { get; set; }
        public string classID { get; set; }
        public string bracketID { get; set; }
    }

    [WebMethod]
    public static List<match> getEventMatches(int bracketID, int eventID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT awayBout.boutID, awayBout.evta_fname AS a_fname, awayBout.evta_lname AS a_lname, awayBout.evta_grade AS a_grade, awayBout.teamName AS a_team, " + 
                         "awayBout.btr_winner AS a_winner, awayBout.Total AS a_total, homeBouts.btr_winType AS a_wintype, awayBout.teamPoints AS a_tmPoints, " + 
                         "awayBout.btr_fallTime AS a_fallTime, homeBouts.evta_fname AS h_fname, homeBouts.evta_lname AS h_lname, homeBouts.evta_grade AS h_grade, " +
                         "homeBouts.teamName AS h_team, homeBouts.btr_winner AS h_winner, homeBouts.Total AS h_total, awayBout.btr_winType AS h_wintype, " +
                         "homeBouts.teamPoints AS h_tmPoints, homeBouts.btr_fallTime AS h_fallTime, brackets.evtc_classID AS classID, divisionClasses.evtc_name " +
                         "FROM bouts INNER JOIN " +
                         "brackets ON bouts.bracketID = brackets.bracketID INNER JOIN " +
                         "awayBout INNER JOIN " +
                         "homeBouts ON awayBout.boutID = homeBouts.boutID ON bouts.boutID = awayBout.boutID AND bouts.boutID = homeBouts.boutID LEFT OUTER JOIN " +
                         "divisionClasses ON bouts.bout_classID = divisionClasses.eventClassID " +
                         "WHERE (brackets.bracketID = @bracketID) AND (brackets.eventID = @eventID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@bracketID", bracketID);
            command.Parameters.AddWithValue("@eventID", eventID);
            SqlDataReader reader = command.ExecuteReader();


            var _matches = new List<match>();
            while (reader.Read())
            {
                var mat = new match();
                mat.afname = reader["a_fname"].ToString();
                mat.alname = reader["a_lname"].ToString();
                mat.agrade = reader["a_grade"].ToString();
                mat.awinner = reader["a_winner"].ToString();
                mat.awintype = reader["a_wintype"].ToString();
                mat.atmPoints = reader["a_tmPoints"].ToString();
                mat.atotal = reader["a_total"].ToString();
                mat.afallTime = reader["a_fallTime"].ToString();
                mat.ateam = reader["a_team"].ToString();

                mat.hfname = reader["h_fname"].ToString();
                mat.hlname = reader["h_lname"].ToString();
                mat.hgrade = reader["h_grade"].ToString();
                mat.hwinner = reader["h_winner"].ToString();
                mat.hwintype = reader["h_wintype"].ToString();
                mat.htmPoints = reader["h_tmPoints"].ToString();
                mat.htotal = reader["h_total"].ToString();
                mat.hfallTime = reader["h_fallTime"].ToString();
                mat.hteam = reader["h_team"].ToString();

                mat.boutID = reader["boutID"].ToString();
                mat.classID = reader["classID"].ToString();
                mat.bout_className = reader["evtc_name"].ToString();
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
                         "schools.sch_tm_abrv, teamContracts.tmc_status, contracts.con_name, contracts.con_length, contracts.con_cost, leagues.lge_name, leagues.lge_organization, "+
                         "leagues.lge_level "+
                         "FROM contracts INNER JOIN "+
                         "teamContracts ON contracts.contractID = teamContracts.contractID RIGHT OUTER JOIN "+
                         "schoolLeagues INNER JOIN "+
                         "leagueSeasons ON schoolLeagues.leagueSeasonID = leagueSeasons.leagueSeasonID INNER JOIN "+
                         "leagues ON leagueSeasons.leagueID = leagues.leagueID RIGHT OUTER JOIN "+
                         "schools ON schoolLeagues.schoolID = schools.schoolID ON teamContracts.schoolID = schools.schoolID "+
                         "WHERE (schools.schoolID = @schoolID)";

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