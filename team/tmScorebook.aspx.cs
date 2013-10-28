using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

public partial class team_tmDashboard : System.Web.UI.Page
{
    //test
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
    public List<tmMember> getTeamMembers()
    {

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
   

    //This code handles the click event of a button in the tmMember repeater.
    //The if statement can be altered to account for multiple buttons.
    protected void tmMember_REP_ItemCommand(object source, RepeaterCommandEventArgs Args)
    {
        int tmMemberID;
        
        if (Args.CommandName == "selectCommand")
        {
            int.TryParse(Args.CommandArgument as string, out tmMemberID);
            Session["tmMemberID"] = tmMemberID;
            //Response.Redirect("#");
        }
    }
    

    protected void addMem_LB_Click(object sender, EventArgs e)
    {
        //Establish a connection with the sql connection string declared in the web.config file.
        //Insert new data on a team member
        string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);
        
        //Create SQL paragraph and parameters
        string commandInsert = "Insert INTO tmMembers (fName, lName, grade, teamID) VALUES (@fName, @lName, @grade, @teamID);";
        SqlCommand myCommand = new SqlCommand(commandInsert, sqlConn);
        myCommand.Parameters.AddWithValue("@fName",fName_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@lName", lName_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@grade", grade_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@teamID", Session["TeamID"]);

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
        myCommand.ExecuteNonQuery();

        //Test and Close Connection
        try
        {
            sqlConn.Close();
        }
        catch (Exception err)
        {
            Console.WriteLine(err.ToString());
        }

        //Reload data in the tmMember_Rep
        tmMember_REP.DataBind();
        MPE.Hide();
    }
    
//This code handles the click event of a button in the tmEvents repeater.
    //The if statement can be altered to account for multiple buttons.
    protected void tmEvents_REP_ItemCommand(object source, RepeaterCommandEventArgs Args)
    {
        int eventID;

        if (Args.CommandName == "selectCommand")
        {
            int.TryParse(Args.CommandArgument as string, out eventID);
            Session["EventID"] = eventID;
            Response.Redirect("sbEvtView.aspx");
        }
    }

    protected void addEvt_LB_Click(object sender, EventArgs e)
    {
        
        //Establish a connection with the sql connection string declared in the web.config file.
        //Insert new data on a team member
        string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);

        //Create SQL paragraph and parameters
        //Insert info into events table
        string commandInsert = "Insert INTO events (eventName, startDate, startTime, eventType, address, city, state, styleID, levelID) OUTPUT INSERTED.eventID VALUES (@evtName, @stDate, @stTime, @evtType, @addr, @city, @state, @styleID, @levelID); Select SCOPE_IDENTITY();";
        SqlCommand myCommand = new SqlCommand(commandInsert, sqlConn);
        myCommand.Parameters.AddWithValue("@evtName", evtName_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@stDate", startDate_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@stTime", startTime_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@evtType", evtType_DDL.SelectedValue);
        myCommand.Parameters.AddWithValue("@addr", addr_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@city", city_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@state", state_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@styleID", styleID_DDL.SelectedValue);
        myCommand.Parameters.AddWithValue("@levelID", levelID_DDL.SelectedValue);

        

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
        int eventID = (int)myCommand.ExecuteScalar();
        
        Session["EventID"] = eventID.ToString();
        
        //Add new event to the tmEvent table
        string addtotmEvents = "Insert INTO tmEvents (eventID, teamID) Values (@eventID, @teamID);";
        SqlCommand sqlCom = new SqlCommand(commandInsert, sqlConn);
        sqlCom = new SqlCommand(addtotmEvents, sqlConn);
        sqlCom.Parameters.AddWithValue("@eventID", Session["EventID"]);
        sqlCom.Parameters.AddWithValue("@teamID", Session["TeamID"]);

        //Add team to new events eventTeams table
        string addtoevtTeams = "Insert INTO eventTeams (teamID, city, state, eventID) VALUES (@teamID, @city, @state, @eventID);";
        SqlCommand myComd = new SqlCommand(addtoevtTeams, sqlConn);
        myComd.Parameters.AddWithValue("@teamID", Session["TeamID"]);
        myComd.Parameters.AddWithValue("@city", city_TB.Text.Trim());
        myComd.Parameters.AddWithValue("@state", state_TB.Text.Trim());
        myComd.Parameters.AddWithValue("@eventID", Session["EventID"]);

        sqlCom.ExecuteNonQuery();
        //myComd.ExecuteNonQuery();

        
        //Test and Close Connection
        try
        {
            sqlConn.Close();
        }
        catch (Exception err)
        {
            Console.WriteLine(err.ToString());
        }

        //Reload data in the events_Rep
        events_Rep.DataBind();
        MPE2.Hide();
    }
    protected void fanPage_Bu_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/user/tmFanPage.aspx");
    }
}