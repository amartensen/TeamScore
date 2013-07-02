using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userProfile : System.Web.UI.Page
{
    
//<<<<<<<<<< Get Person >>>>>>>>>>>>>>>
    public class person
    {
        public string userID { get; set; }
        public string fName { get; set; }
        public string lName { get; set; }
        public string state { get; set; }
        public string DOB { get; set; }
    }

    [WebMethod]
    public static person[] getPersonDetails()
    {
        MembershipUser user = Membership.GetUser();
        string user_ID = user.ProviderUserKey.ToString();

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {

            string sql = "SELECT userID, per_fname, per_lname, per_state, per_dob FROM person WHERE (userID = @userID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@userID", user_ID);
            SqlDataReader reader = command.ExecuteReader();

            var _person = new List<person>();
            while (reader.Read())
            {
                var per = new person();
                per.userID = reader["userID"].ToString();
                per.fName = reader["per_fName"].ToString();
                per.lName = reader["per_lName"].ToString();
                per.state = reader["per_state"].ToString();
                per.DOB = reader["per_dob"].ToString();
                _person.Add(per);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _person.ToArray();
        }
    }
//<<<<<<<<<GET PERSON TEAMS>>>>>>>>>>>>>>>
    public class team
    {
        public string tm_name { get; set; }
        public string teamID { get; set; }
        public string tm_city { get; set; }
        public string tm_state { get; set; }
        public string con_name { get; set; }
        public string tm_join_code { get; set; }
    }

    [WebMethod]
    public static team[] getPersonTeams()
    {
        MembershipUser user = Membership.GetUser();
        string userID = user.ProviderUserKey.ToString();

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {


            string sql = "SELECT tm_name, teamID, tm_city, tm_state, tm_con_name FROM teams WHERE (teamID IN (SELECT teamID FROM teamMembers WHERE (personID = @personID)));";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@personID", userID);
            SqlDataReader reader = command.ExecuteReader();

            var _teams = new List<team>();
            while (reader.Read())
            {
                var tm = new team();
                tm.teamID = reader["teamID"].ToString();
                tm.tm_name = reader["tm_name"].ToString();
                tm.con_name = reader["tm_con_name"].ToString();
                tm.tm_state = reader["tm_state"].ToString();
                tm.tm_city = reader["tm_city"].ToString();
                _teams.Add(tm);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _teams.ToArray();
        }
    }

    //get pending teams
    [WebMethod]
    public static team[] getPendTeams()
    {
        MembershipUser user = Membership.GetUser();
        string userID = user.ProviderUserKey.ToString();

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {


            string sql = "SELECT teams.tm_name, teams.teamID, teams.tm_city, teams.tm_state "+
                         "FROM teams INNER JOIN teamMembers ON teams.teamID = teamMembers.teamID "+
                        "WHERE (teamMembers.tmb_link_status = 'P') AND (teamMembers.personID = @personID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@personID", userID);
            SqlDataReader reader = command.ExecuteReader();

            var _teams = new List<team>();
            while (reader.Read())
            {
                var tm = new team();
                tm.teamID = reader["teamID"].ToString();
                tm.tm_name = reader["tm_name"].ToString();
                tm.tm_state = reader["tm_state"].ToString();
                tm.tm_city = reader["tm_city"].ToString();
                _teams.Add(tm);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _teams.ToArray();
        }
    }

    [WebMethod]
    public static List<team> findTeams(string tm_lookup)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT tm_name, teamID, tm_city, tm_state, tm_con_name, tm_join_code FROM teams WHERE (tm_name LIKE @tm_lookup)";

            connection.Open();

            SqlCommand sqlcomd = new SqlCommand(sql, connection);
            sqlcomd.Parameters.AddWithValue("@tm_lookup", "%" + tm_lookup + "%");
            SqlDataReader reader = sqlcomd.ExecuteReader();

            var _teams = new List<team>();
            while (reader.Read())
            {
                var tm = new team();
                tm.teamID = reader["teamID"].ToString();
                tm.tm_name = reader["tm_name"].ToString();
                tm.con_name = reader["tm_con_name"].ToString();
                tm.tm_state = reader["tm_state"].ToString();
                tm.tm_city = reader["tm_city"].ToString();
                tm.tm_join_code = reader["tm_join_code"].ToString();
                _teams.Add(tm);
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _teams;
        }
    }
    
    //<<<<<<<<<< Create New Team >>>>>>>>>>
    [WebMethod]
    public static int createTeam(string tmName, string tmCity, string tmState, string tmAbrv, string conName, string conEmail, string conPhone, int schoolID, string packageID )
    {
        int teamID;
        int tmMemberID;
        DateTime today = DateTime.Now;
        
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO teams (tm_name, tm_abrv, tm_city, tm_state, tm_con_name, tm_con_email, tm_con_phone) VALUES (@tmName, @tmAbrv, @tmCity, @tmState, @conName, @conEmail, @conPhone); SELECT SCOPE_IDENTITY();";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@tmName", tmName);
            command.Parameters.AddWithValue("@tmAbrv", tmAbrv);
            command.Parameters.AddWithValue("@tmCity", tmCity);
            command.Parameters.AddWithValue("@tmState", tmState);
            command.Parameters.AddWithValue("@conName", conName);
            command.Parameters.AddWithValue("@conEmail", conEmail);
            command.Parameters.AddWithValue("@conPhone", conPhone);

            teamID = (int)(decimal)command.ExecuteScalar();
            connection.Close();
        }

        person[] perDetails = getPersonDetails();

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO teamMembers (personID, fName, lName, teamID, tmb_adminRole) VALUES (@personID, @fName, @lName, @teamID, @adminRole); SELECT SCOPE_IDENTITY();";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@personID", perDetails[0].userID);
            command.Parameters.AddWithValue("@fName", perDetails[0].fName);
            command.Parameters.AddWithValue("@lName", perDetails[0].lName);
            command.Parameters.AddWithValue("@teamID", teamID);
            command.Parameters.AddWithValue("@adminRole", 'A');

            tmMemberID = (int)(decimal)command.ExecuteScalar();
            connection.Close();
        }

        // Below is old way of storing roles
        //using (SqlConnection connection = new SqlConnection(connectionString))
        //{
        //    string sql = "Insert INTO teamMemberRoles (teamMemberID, teamRoleID) VALUES (@teamMemberID, @teamRoleID);";

        //    connection.Open();

        //    SqlCommand command = new SqlCommand(sql, connection);
        //    command.Parameters.AddWithValue("@teamMemberID", tmMemberID);
        //    command.Parameters.AddWithValue("@teamRoleID", "a");

        //    command.ExecuteNonQuery();
        //    connection.Close();

        // }
        
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO teamContracts (teamContractID, teamID, contractID, tmc_startdate, tmc_enddate, tmc_status, schoolID) "+
                "VALUES (@teamContractID, @teamID, @contractID, @tmc_startdate, @tmc_enddate, @tmc_status, @schoolID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@teamContractID", tmMemberID);
            command.Parameters.AddWithValue("@contractID", packageID);
            command.Parameters.AddWithValue("@tmc_startdate", today);
            command.Parameters.AddWithValue("@tmc_enddate", today.AddDays(365));
            command.Parameters.AddWithValue("@tmc_status", "A");
            command.Parameters.AddWithValue("@schoolID", schoolID);
            command.Parameters.AddWithValue("@teamID", teamID);

            command.ExecuteNonQuery();
            connection.Close();

        }

        return teamID;
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
    public static List<school> getSchools(string sch_name, string sch_loc_state, string sch_level)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT schoolID, sch_name, sch_loc_city, sch_loc_state FROM schools WHERE (sch_loc_state = @schlocstate AND sch_name LIKE @schname AND sch_level = @schlevel)";

            connection.Open();

            SqlCommand sqlcomd = new SqlCommand(sql, connection);
            sqlcomd.Parameters.AddWithValue("@schlocstate", sch_loc_state);
            sqlcomd.Parameters.AddWithValue("@schname", "%" + sch_name + "%");
            sqlcomd.Parameters.AddWithValue("@schlevel", sch_level);
            SqlDataReader reader = sqlcomd.ExecuteReader();

            List<school> _schools = new List<school>();
            while (reader.Read())
            {
                _schools.Add(new school()
                {
                    schoolID = reader["schoolID"].ToString(),
                    sch_name = reader["sch_name"].ToString(),
                    sch_loc_city = reader["sch_loc_city"].ToString(),
                    sch_loc_state = reader["sch_loc_state"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _schools;
        }
    }


    //<<<<<<<<<< Get a School's Team Contract >>>>>>>>>>
    public class contract
    {
        public string tm_name { get; set; }
        public string tm_con_name { get; set; }
    }

    [WebMethod]
    public static contract[] getSchlContract(string schoolID)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT teams.tm_con_name, teams.tm_name FROM teamContracts INNER JOIN teams ON teamContracts.teamID = teams.teamID WHERE (teamContracts.schoolID = @schoolID);";

            connection.Open();

            SqlCommand sqlcomd = new SqlCommand(sql, connection);
            sqlcomd.Parameters.AddWithValue("@schoolID", schoolID);
            SqlDataReader reader = sqlcomd.ExecuteReader();
            
            var _contract = new List<contract>();
            while (reader.Read())
            {
                var con = new contract();
                con.tm_con_name = reader["tm_con_name"].ToString();
                con.tm_name = reader["tm_name"].ToString();
                _contract.Add(con);
            }
      

            //Close connections
            reader.Close();
            connection.Close();
            
            return _contract.ToArray();
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
    //This code stores finds and stores the userID of the currently logged on user.
 

    //This code handles the click event of a button in the tmMember repeater.
    //The if statement can be altered to account for multiple buttons.
    protected void selectTeam_REP_ItemCommand(object source, RepeaterCommandEventArgs Args)
    {
        int teamID;
        int.TryParse(Args.CommandArgument as string, out teamID);
        if (Args.CommandName == "selectCommand")
        {
            Session["TeamID"] = teamID;
            Response.Redirect("~/team/tmStatbook.aspx");
        }
    }
}