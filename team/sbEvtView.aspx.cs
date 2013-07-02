using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class team_sbEventView : System.Web.UI.Page,
    System.Web.UI.ICallbackEventHandler
{
     
        //test
        protected System.Collections.Specialized.ListDictionary catalog;
        protected String returnValue;
       
        public void RaiseCallbackEvent(String eventArgument)
        {
            if (catalog[eventArgument] == null)
            {
                returnValue = "-1";
            }
            else
            {
                returnValue = eventArgument;
            }
        }
        public String GetCallbackResult()
        {
            return returnValue;
        }
    

    protected void Page_Load(object sender, EventArgs e)
    {
        Session["divisionDDLID"] = setDiv_DDL.SelectedValue;

        //Test: Handles the callback event when a button is selected within the athlete list
        String cbReference =
            Page.ClientScript.GetCallbackEventReference(this,
            "arg", "ReceiveServerData", "context");
        String callbackScript;
        callbackScript = "function CallServer(arg, context)" +
            "{ " + cbReference + ";}";
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(),
            "CallServer", callbackScript, true);

             
    }

    protected void back_Bu_Click(object sender, EventArgs e)
    {
        Response.Redirect("tmScorebook.aspx");
    }

    protected void done_Lb_Click(object sender, EventArgs e)
    {
        evtInfo_FV.DataBind();
        MPE.Hide();
    }
    
    protected void division_Rep_ItemCommand(object Source, RepeaterCommandEventArgs args)
    {
        int divisionID;

        if (args.CommandName == "deleteDivCmd")
        {

           int.TryParse(args.CommandArgument as string, out divisionID);
            
            //Establish a connection with the sql connection string declared in the web.config file.
            //Insert new data on a team member
            string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
            SqlConnection sqlConn = new SqlConnection(strConnection);
        
            //Create SQL paragraph and parameters
            string commandDelete = "DELETE FROM eventDivisions WHERE (eventDivisionID = @divisionID);";
            SqlCommand myCommand = new SqlCommand(commandDelete, sqlConn);
            myCommand.Parameters.AddWithValue("@divisionID", divisionID);


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

            //Reload data in the division_Rep
            division_Rep.DataBind();
            }
        }   
        protected void divOK_Bu_Click(object sender, EventArgs e)
            {
                evtDivision_Rep.DataBind();

                divMPE.Hide();
            }

        protected void divAdd_Bu_Click(object sender, EventArgs e)
        {
            //Establish a connection with the sql connection string declared in the web.config file.
            //Insert new data on a team member
            string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
            SqlConnection sqlConn = new SqlConnection(strConnection);

            //Create SQL paragraph and parameters
            string commandInsert = "Insert INTO eventDivisions (divisionName, eventID) Values (@DivisionName, @eventID);";
            SqlCommand myCommand = new SqlCommand(commandInsert, sqlConn);
            myCommand.Parameters.AddWithValue("@divisionName", divisionName_TB.Text.Trim());
            myCommand.Parameters.AddWithValue("@eventID", Session["EventID"]);

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
            division_Rep.DataBind();
        }

    protected void addGroup_Bu_Click(object sender, EventArgs e)
    {
        //Establish a connection with the sql connection string declared in the web.config file.
        //Insert new data on a team member
        string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);
        
        //Create SQL paragraph and parameters
        string commandInsert = "Insert INTO eventGroups (amount, eventID, eventDivisionID) Values (@amount, @eventID, @evtDivID);";
        SqlCommand myCommand = new SqlCommand(commandInsert, sqlConn);
        myCommand.Parameters.AddWithValue("@amount", amount_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@eventID", Session["EventID"]);
        myCommand.Parameters.AddWithValue("@evtDivID", Session["divisionDDLID"]);

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
        editGroup_Rep.DataBind();
    }


    protected void groupDone_Bu_Click(object sender, EventArgs e)
    {
        bktGroup_Rep.DataBind();
        groupMPE.Hide();
    }
    
    protected void groupEdit_LBu_Click(object sender, EventArgs e)
    {
        setDiv_DDL.DataBind();
        Session["divisionDDLID"] = setDiv_DDL.SelectedValue;
    }

    protected void addMatch_LB_Click(object sender, EventArgs e)
    {

    }

    protected void athleteList_Rep_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int memberID;

        if ((e.CommandName == "athSelect") && (!IsPostBack))
        {
            
            int.TryParse(e.CommandArgument as string, out memberID);
            Session["MemberID"] = memberID;
            selAthMPE.Show();
        }
    }

 

    protected void addAth_LB_Click(object sender, EventArgs e)
    {
        //Establish a connection with the sql connection string declared in the web.config file.
        //Insert new data on a team member
        string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);

        //Create SQL paragraph and parameters
        string commandInsert = "Insert INTO eventMembers (fName, lName, grade, eventTeamID, seaWins, seaLosses, eventGroupID) Values (@fName, @lName, @grade, @evtTeamID, @seaWins, @seaLosses, @weightID);";
        SqlCommand myCommand = new SqlCommand(commandInsert, sqlConn);
        myCommand.Parameters.AddWithValue("@fName", afname_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@lName", alname_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@grade", agrade_DDL.SelectedValue);
        myCommand.Parameters.AddWithValue("@evtTeamID", athTeam_DDL.SelectedValue);
        myCommand.Parameters.AddWithValue("@seaWins", seaWins_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@seaLosses", seaLosses_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@weightID", weight_DDL.SelectedValue);

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

        //Reset form and update alert label
        alertLabel.Text = afname_TB.Text.Trim()+" "+ alname_TB.Text.Trim()+" was added to Event.";
        alname_TB.Text = "";
        afname_TB.Text = "";
        seaLosses_TB.Text = "";
        seaWins_TB.Text = "";
    }
    protected void athDone_LB_Click(object sender, EventArgs e)
    {
        newAthlete_UPnl.Update();
        alertLabel.Text = "";
        athleteList_Rep.DataBind();
        athMPE.Hide();
    }
    protected void addTeam_LB_Click(object sender, EventArgs e)
    {
        //Establish a connection with the sql connection string declared in the web.config file.
        //Insert data on new event team
        string strConnection = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        SqlConnection sqlConn = new SqlConnection(strConnection);

        //Create SQL paragraph and parameters
        string tmMemberInsert = "Insert INTO eventTeams (teamName, city, state, nameAbrv, eventID) Values (@teamName, @city, @state, @nameAbrv, @eventID); Select SCOPE_IDENTITY()";
        SqlCommand myCommand = new SqlCommand(tmMemberInsert, sqlConn);
        myCommand.Parameters.AddWithValue("@teamName", teamName_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@city", tmCity_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@state", tmState_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@nameAbrv", tmNameAbrv_TB.Text.Trim());
        myCommand.Parameters.AddWithValue("@eventID", Session["EventID"]);

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

        //Update Alert Label
        newTeamAlert_Lbl.Text = teamName_TB.Text.Trim() + " from "+ tmCity_TB.Text.Trim() +", "+ tmState_TB.Text.Trim() +" was added to the Event.";
        teamName_TB.Text = "";
        tmState_TB.Text = "";
        tmNameAbrv_TB.Text = "";
    }
    protected void tmDone_LB_Click(object sender, EventArgs e)
    {
        newTeam_UPnl.Update();
        newTeamAlert_Lbl.Text = "";

        //teamMPE.Hide();
    }
    protected void teamList_Rep_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int eventTeamID;
        
        if (e.CommandName == "selectTeam")
        {
            int.TryParse(e.CommandArgument as string, out eventTeamID);
            Session["EventTeamID"] = eventTeamID;
            selTmMPE.Show();
        }
    }

    protected void teamList_Rep_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Button btn = e.Item.FindControl("btn") as Button;
            btn.OnClientClick = String.Format("showValue('{0}');", btn.CommandArgument);
        }
    } 

    protected void selTmDone_Bu_Click(object sender, EventArgs e)
    {
        //teamList_Rep.DataBind();
        editTeam_FV.ChangeMode(FormViewMode.ReadOnly);
        selTmMPE.Hide();
    }



    protected void athSelDone_LB_Click(object sender, EventArgs e)
    {
        athleteList_Rep.DataBind();
        
        editAthlete_FV.ChangeMode(FormViewMode.ReadOnly);
        selAthMPE.Hide();
    }

    
}

