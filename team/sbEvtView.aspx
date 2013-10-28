<%@ Page Title="" Language="C#" MasterPageFile="~/master/main_master.master" AutoEventWireup="true" CodeFile="sbEvtView.aspx.cs" Inherits="team_sbEventView" EnableEventValidation="false" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

       

       // Get the remote template
       $.get("../JTemplates/evtTeams-temp.htm", null, function (evtTeamTemp) {

           // Compile and cache the template
           $.template("evtTeamTemp", evtTeamTemp);

           //render the teams
           GetEvtTeams();
       });

       function GetEvtTeams() {
           //
           
           $.ajax({
               type: "POST",
               url: "../EvtTeamsWS.asmx/GetEvtTeams",
               data: "{}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: Success,
               error: Error
           });
       }

       function Success(data, status) {
           $.tmpl("evtTeamTemp", data.d).appendTo("#evtTeamsContainer");

       }

       function Error(request, status, error) {alert("hi");
           $("#evtTeamsContainer").html(request.statusText);
       }

       $(function NewTeam() {
           newTeam_UPnl.Update();
           newTeamAlert_Lbl.Text = "";
           GetEvtTeams();
           $("#teamMPE").dialog(
               {
                   autoOpen: false,
                   height: 140,
                   modal: true
               });

           $("#opener").click(function () {
               $("#dialog").dialog("open");
           });
       });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="pageHeader">
        <div class="pageHeadLeft">
            <asp:FormView ID="FormView1" runat="server" DataSourceID="tmheaderSqlDataSource" >
                <ItemTemplate>
                    <asp:Label ID="teamNameLabel" runat="server" Text='<%# Bind("teamName") %>' />
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="tmheaderSqlDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                SelectCommand="SELECT teamName FROM teams WHERE (teamID = @teamID);">
                <SelectParameters>
                    <asp:SessionParameter Name="teamID" SessionField="TeamID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="pageHeadLeft">
            <asp:Button ID="back_Bu" runat="server" Text="<---" OnClick="back_Bu_Click" />
        </div>

        
    </div>
    <div id="wrap">
        <div class="fullPage">
            <asp:UpdatePanel ID="evtInfo_UPnl" runat="server">
                <ContentTemplate>

                
                    <asp:FormView ID="evtInfo_FV" runat="server" DataSourceID="evtHeadSqlSource">
                        <ItemTemplate>
                            eventName:
                            <asp:Label ID="eventNameLabel" runat="server" Text='<%# Bind("eventName") %>' />
                            <br />
                            startDate:
                            <asp:Label ID="startDateLabel" runat="server" Text='<%# Bind("startDate") %>' />
                            <br />
                            startTime:
                            <asp:Label ID="startTimeLabel" runat="server" Text='<%# Bind("startTime") %>' />
                            <br />
                            address:
                            <asp:Label ID="addressLabel" runat="server" Text='<%# Bind("address") %>' />
                            <br />
                            city:
                            <asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>' />
                            <br />
                            state:
                            <asp:Label ID="stateLabel" runat="server" Text='<%# Bind("state") %>' />
                            <br />

                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="evtHeadSqlSource" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                        SelectCommand="SELECT eventName, startDate, startTime, address, city, state FROM events WHERE (eventID = @EventID)">
                        <SelectParameters>
                            <asp:SessionParameter Name="EventID" SessionField="EventID" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="done_Lb" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:LinkButton ID="settings_LB" runat="server">Settings</asp:LinkButton>
        </div> <!-- FullPage closing tag-->
            
         <!--Contains jQuery tabs-->
        <div id="tabs">
            
            <ul>
                <li><a href="#tabs-1">Matches</a></li>
                <li><a href="#tabs-2">Team List</a></li>
                <li><a href="#tabs-3">Athlete List</a></li>
            </ul>

            <!-- MATCHES TAB-->
            <div id="tabs-1">
               
            
                        <div class="articleHead">
                            <div class="pageHeadLeft">
                                <h3>Event Matches</h3>
                            </div>
                            <div class="pageHeadRight">
                                <asp:Button ID="newMatch_Bu" runat="server" Text="New Match" />
                            </div>
                        </div>
                        <asp:Repeater ID="evtMatches_REP" runat="server" DataSourceID="evtMatchesSource" >
                            <HeaderTemplate>
                                <table>
                                    
                            </HeaderTemplate>
                            <ItemTemplate>
                                    <tr>
                                        <td><%# DataBinder.Eval(Container.DataItem, "weight")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "hfName")%> <%# DataBinder.Eval(Container.DataItem, "hlName")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "hgrade")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "hwinner")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "hwinType")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "hfallTime")%></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "afName")%> <%# DataBinder.Eval(Container.DataItem, "alName")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "agrade")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "awinner")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "awinType")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "afallTime")%></td>
                                    </tr>
                                                        
                    
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="evtMatchesSource" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                            SelectCommand="SELECT matchHome.amount AS weight, matchHome.fName AS hfName, matchHome.lName AS hlName, matchHome.grade AS hgrade, matchHome.winner AS hwinner, matchHome.winType AS hwinType, matchHome.fallTime AS hfallTime, matchAway.fName AS afName, matchAway.lName AS alName, matchAway.grade AS agrade, matchAway.winner AS awinner, matchAway.winType AS awinType, matchAway.fallTime AS afallTime FROM matchHome INNER JOIN matchAway ON matchHome.boutID = matchAway.boutID WHERE (matchHome.boutID IN (SELECT bout.boutID FROM bouts AS bout INNER JOIN brackets AS brkt ON bout.bracketID = brkt.bracketID WHERE (brkt.eventID = @EventID)))">
                            <SelectParameters>
                                <asp:SessionParameter Name="EventID" SessionField="EventID" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <!-- Controls the NEW MATCH popup panel -->
                        <asp:Panel ID="newMatch_Pnl" runat="server" CssClass="newMatch_Pnl">
                                <div>
                                    <table>
                                        <tr>
                                            <td><asp:Label ID="fName_Lbl" runat="server" Text="First Name:"></asp:Label></td>
                                            <td><asp:TextBox ID="fName_TB" runat="server"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td><asp:Label ID="lName_Lbl" runat="server" Text="Last Name:"></asp:Label></td>
                                            <td><asp:TextBox ID="lName_TB" runat="server"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td><asp:Label ID="grade_Lbl" runat="server" Text="Grade:"></asp:Label></td>
                                            <td><asp:TextBox ID="grade_TB" runat="server"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                <div>
                                    <asp:LinkButton ID="cancelMatch_LB" runat="server">Cancel</asp:LinkButton>
                                    <asp:LinkButton ID="addMatch_LB" runat="server" OnClick="addMatch_LB_Click">Add Match</asp:LinkButton>
                                </div>
                                </div>
               
                            </asp:Panel>
                            <ajaxtoolkit:modalpopupextender ID="matchMPE" runat="server"
                                TargetControlID="newMatch_Bu"
                                PopupControlID="newMatch_Pnl"
                                BackgroundCssClass="modalBackground" 
                                DropShadow="true" CancelControlID="cancelMatch_LB">
                            </ajaxtoolkit:modalpopupextender>   
            

                </div> <!--matches closing tag-->
            

            <!--TEAM TAB -->
            <div id="tabs-2">
                <article>
                    <div class="articleHead">
                            <div class="pageHeadLeft">
                                <h3>Event Teams</h3>
                            </div>
                            <div class="pageHeadRight">
                                <asp:Button ID="newTeam_Bu" runat="server" Text="New Team" />
                                <button id="opener">Open Dialog</button>
                            </div>
                        </div>
                        <div id ="evtTeamsContainer"></div>
                        <%--<asp:UpdatePanel id="teamList_UPnl" runat="server">
                            <ContentTemplate>

                            
                        <asp:Repeater ID="teamList_Rep" runat="server" DataSourceID="eventTeams_SQLSource" 
                                    OnItemCommand="teamList_Rep_ItemCommand" >
                            <HeaderTemplate>
                                <table >
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tbody>
                                    <tr>
                                        <td><%# DataBinder.Eval(Container.DataItem, "teamName")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "city")%>, <%# DataBinder.Eval(Container.DataItem, "state")%></td>
                                        <td><asp:LinkButton ID="selectTeam_LB" runat="server" CommandName="selectTeam" CommandArgument='<%# Bind("eventTeamID") %>'>Select</asp:LinkButton></td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="eventTeams_SqlSource" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                            SelectCommand="SELECT eventTeamID, teamName, city, state FROM eventTeams WHERE (eventID = @EventID)" >
                            <SelectParameters>
                                <asp:SessionParameter Name="EventID" SessionField="EventID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="tmDone_LB" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="selTmDone_Bu" EventName="Click" />
                            </Triggers>
                    </asp:UpdatePanel>--%>
                </article>
                
                <!--NEW TEAM popup panel-->
                
                <asp:Panel ID="newTeam_Pnl" runat="server" CssClass="defaultModal">
                    <asp:UpdatePanel ID="newTeam_UPnl" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Label ID="newTeamAlert_Lbl" runat="server" Text=""></asp:Label>
                    <table>
                        <tbody>
                            <tr>
                                <td>Team Name</td>
                                <td><asp:TextBox ID="teamName_TB" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>City</td>
                                <td><asp:TextBox ID="tmCity_TB" runat="server"></asp:TextBox></td>
                        
                            </tr>
                            <tr>
                                <td>State</td>
                                <td><asp:TextBox ID="tmState_TB" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>Team Name Abreviation</td>
                                <td><asp:TextBox ID="tmNameAbrv_TB" runat="server"></asp:TextBox></td>
                            </tr>
                        </tbody>
                    </table>
                    <asp:LinkButton ID="addTeam_LB" runat="server" OnClick="addTeam_LB_Click">Add Team</asp:LinkButton>
                </ContentTemplate>
                </asp:UpdatePanel>
                    <input type="button" value="Done" onclick="NewTeam();" />
                </asp:Panel>
<div id="teamMPE">TEST
    <input type="button" value="Done" onclick=";" />
</div>

 <input type="button" value="New Teams" onclick="NewTeam();" />
                <%--<ajaxtoolkit:modalpopupextender ID="teamMPE" runat="server"
                    TargetControlID="newTeam_Bu"
                    PopupControlID="newTeam_Pnl"
                    BackgroundCssClass="modalBackground">
                </ajaxtoolkit:modalpopupextender>    --%>
                
                <!-- SELECT TEAM popup modal-->
                <asp:Panel ID="selTeam_Pnl" runat="server" CssClass="defaultModal">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:FormView ID="editTeam_FV" runat="server" DataSourceID="editTeamSource">

                                <EditItemTemplate>
                                    teamName:
                                    <asp:TextBox ID="teamNameTextBox" runat="server" 
                                        Text='<%# Bind("teamName") %>' />
                                    <br />
                                    nameAbrv:
                                    <asp:TextBox ID="nameAbrvTextBox" runat="server" 
                                        Text='<%# Bind("nameAbrv") %>' />
                                    <br />
                                    city:
                                    <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' />
                                    <br />
                                    state:
                                    <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' />
                                    <br />
                                    
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                        CommandName="Update" Text="Update" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                                        CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    teamName:
                                    <asp:Label ID="teamNameLabel" runat="server" Text='<%# Bind("teamName") %>' />
                                    <br />
                                    nameAbrv:
                                    <asp:Label ID="nameAbrvLabel" runat="server" Text='<%# Bind("nameAbrv") %>' />
                                    <br />
                                    city:
                                    <asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>' />
                                    <br />
                                    state:
                                    <asp:Label ID="stateLabel" runat="server" Text='<%# Bind("state") %>' />
                                    <br />
                                    
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                                        CommandName="Edit" Text="Edit" />
                                </ItemTemplate>

                            </asp:FormView>
                            <asp:SqlDataSource ID="editTeamSource" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                SelectCommand="SELECT city, state, teamName, nameAbrv FROM eventTeams WHERE (eventTeamID = @eventTeamID)" 
                                UpdateCommand="UPDATE eventTeams SET city = @city, state = @state, teamName = @teamName, nameAbrv = @nameAbrv WHERE (eventTeamID = @eventTeamID)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="eventTeamID" SessionField="EventTeamID" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="city" />
                                    <asp:Parameter Name="state" />
                                    <asp:Parameter Name="teamName" />
                                    <asp:Parameter Name="nameAbrv" />
                                    <asp:SessionParameter Name="eventTeamID" SessionField="EventTeamID"/>
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="selTmDone_Bu" runat="server" Text="Done" OnClick="selTmDone_Bu_Click" />
                </asp:Panel>
                <asp:Button ID="selTeam_HBu" runat="server" style="display:none;" />
                <ajaxtoolkit:modalpopupextender ID="selTmMPE" runat="server"
                    TargetControlID="selTeam_Hbu"
                    PopupControlID="selTeam_Pnl"
                    BackgroundCssClass="modalBackground">
                </ajaxtoolkit:modalpopupextender>   
            
            </div><!--team tab closing tag-->




            <!-- ATHLETES TAB-->
            <div id="tabs-3">
                <article>
                    <div class="articleHead">
                        <div class="pageHeadLeft">
                            <h3>Event Athletes</h3>
                        </div>
                        <div class="pageHeadLeft">
                            <asp:Button ID="newAthlete_Bu" runat="server" Text="New Athlete" />
                        </div>
                        <div class="pageHeadRight">
                            
                        </div>
                    </div>
                      
                                  
                    <asp:UpdatePanel ID="athleteList_UPnl" runat="server" ChildrenAsTriggers="True" UpdateMode="Conditional">
                        <ContentTemplate>
                            <section>
                                <asp:Repeater ID="athleteList_Rep" runat="server" 
                                    DataSourceID="athletesList_SQLSource" 
                                    OnItemCommand="athleteList_Rep_ItemCommand">
                                    <HeaderTemplate>
                                        

                                        <table>
                                            <tr><th></th><th>Name</th><th>Grade</th><th>Weight</th><th>Team</th><th></th></tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tbody>
                                            <tr>
                                                <td><asp:CheckBox ID="athlete_CB" runat="server" /></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "fname")%> <%# DataBinder.Eval(Container.DataItem, "lname")%></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "grade")%></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "amount")%></td>
                                                <td><%# DataBinder.Eval(Container.DataItem, "teamName")%></td>
                                                <td><asp:LinkButton ID="selectAth_LB" runat="server" CommandArgument='<%#Eval("memberID")%>'  commandName="athSelect" >Select</asp:LinkButton></td>
                                                <td><Button type="Button" onclick="SelectAthlete()" value='<%#Eval("memberID")%>' name="selAthlete_Bu">sel</Button></td>
                                            </tr>
                                        </tbody>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                                <asp:SqlDataSource ID="athletesList_SqlSource" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                    SelectCommand="SELECT eventMembers.fName, eventMembers.lName, eventMembers.grade, eventTeams.teamName, eventGroups.amount, eventMembers.memberID FROM eventGroups INNER JOIN eventMembers ON eventGroups.eventGroupID = eventMembers.eventGroupID LEFT OUTER JOIN eventTeams ON eventMembers.eventTeamID = eventTeams.eventTeamID WHERE (eventGroups.eventID = @EventID)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="EventID" SessionField="EventID" />
                    
                                    </SelectParameters>
                                </asp:SqlDataSource>
                        
                            </section>
                        </ContentTemplate>
                        <Triggers>
                     
                            <asp:AsyncPostBackTrigger ControlID="athDone_LB" EventName="Click" />
                     
                            <asp:AsyncPostBackTrigger ControlID="athSelDone_LB" EventName="Click" />
                     
                        </Triggers>
                    </asp:UpdatePanel>
                </article>

                <!--NEW ATHLETE popup panel-->
                <asp:Panel ID="newAthlete_Pnl" runat="server" CssClass="defaultModal">
                    
                    <asp:UpdatePanel ID="newAthlete_UPnl" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="alertLabel" runat="server" Text=""></asp:Label>
                            <table>
                                <tr>
                                    <td>Name</td><td><asp:TextBox ID="afname_TB" runat="server" Text='<%# Bind("fName") %>'> First</asp:TextBox> <asp:TextBox ID="alname_TB" runat="server" Text='<%# Bind("lName") %>' > Last</asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Grade</td><td>
                                    <asp:DropDownList ID="agrade_DDL" runat="server">
                                        <asp:ListItem Selected="True" Value="9">9th</asp:ListItem>
                                        <asp:ListItem Value="10">10th</asp:ListItem>
                                        <asp:ListItem Value="11">11th</asp:ListItem>
                                        <asp:ListItem Value="12">12th</asp:ListItem>
                                    </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Team</td><td><asp:DropDownList ID="athTeam_DDL" runat="server" 
                                        DataSourceID="athTeamSource" DataTextField="teamName" 
                                        DataValueField="eventTeamID"></asp:DropDownList>
                                    <asp:SqlDataSource ID="athTeamSource" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                        SelectCommand="SELECT eventTeamID, teamName FROM eventTeams WHERE (eventID = @EventID);">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="EventID" SessionField="EventID" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Record</td><td><asp:TextBox ID="seaWins_TB" runat="server" Text='<%# Bind("seaWins") %>'>W</asp:TextBox> - <asp:TextBox ID="seaLosses_TB" runat="server" Text='<%# Bind("seaLosses") %>' >L</asp:TextBox></td>
                                </tr>
                         
                                <tr>
                                    <td>Division</td><td><asp:DropDownList ID="division_DDL" runat="server"></asp:DropDownList>
                                        <ajaxToolkit:CascadingDropDown ID="CCD1" runat="server" ServicePath="~/weightGroup.asmx" 
                                            ServiceMethod="getDivisions" TargetControlID="division_DDL" 
                                            Category="Division" SelectedValue="divisionName"/></td>
                                </tr>                       
                                <tr>
                                    <td>
                                
                                    Weight</td><td><asp:DropDownList ID="weight_DDL" runat="server"></asp:DropDownList>
                                        <ajaxToolkit:CascadingDropDown ID="CDD2" runat="server" TargetControlID="weight_DDL"
                                            Category="Weight" ServicePath="~/weightGroup.asmx" ServiceMethod="getWeights"
                                            ParentControlID="division_DDL"/>
                                    
                                        </td>
                                </tr>
                              
                            </table>
                        

                    <asp:LinkButton ID="addAth_LB" runat="server" OnClick="addAth_LB_Click">Add Athlete</asp:LinkButton>
                    

                        </ContentTemplate>
                        
                    </asp:UpdatePanel> 
                       
                    <asp:LinkButton ID="athDone_LB" runat="server" OnClick="athDone_LB_Click">Done</asp:LinkButton>
                </asp:Panel>
                <ajaxtoolkit:modalpopupextender ID="athMPE" runat="server"
                    TargetControlID="newAthlete_Bu"
                    PopupControlID="newAthlete_Pnl"
                    BackgroundCssClass="modalBackground">
                </ajaxtoolkit:modalpopupextender>
                
                <!--SELECT ATHLETE popup panel-->
                <asp:Panel ID="selectAth_Pnl" runat="server" CssClass="defaultModal">
                    <asp:UpdatePanel ID="selAthlete_UPnl" runat="server">
                        <ContentTemplate>
                            <asp:FormView ID="editAthlete_FV" runat="server" DataSourceID="selectAthSource">
                                <EditItemTemplate>
                                    <asp:Label ID="selAthAlert_Lbl" runat="server" Text=""></asp:Label>
                                    <table>
                                        <tr>
                                            <td>Name</td><td><asp:TextBox ID="saFname_TB" runat="server" Text='<%# Bind("fName") %>'> First</asp:TextBox> <asp:TextBox ID="saLname_TB" runat="server" Text='<%# Bind("lName") %>' > Last</asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td>Grade</td><td>
                                            <asp:DropDownList ID="saGrade_DDL" runat="server">
                                                <asp:ListItem Selected="True" Value="9">9th</asp:ListItem>
                                                <asp:ListItem Value="10">10th</asp:ListItem>
                                                <asp:ListItem Value="11">11th</asp:ListItem>
                                                <asp:ListItem Value="12">12th</asp:ListItem>
                                            </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Team</td><td><asp:DropDownList ID="saTeam_DDL" runat="server" 
                                                DataSourceID="athTeamNameSource" DataTextField="teamName" 
                                                DataValueField="eventTeamID"></asp:DropDownList>
                                            <asp:SqlDataSource ID="athTeamNameSource" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                                SelectCommand="SELECT eventTeamID, teamName FROM eventTeams WHERE (eventID = @EventID);">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="EventID" SessionField="EventID" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Record</td><td><asp:TextBox ID="saSeaWins_TB" runat="server" Text='<%# Bind("seaWins") %>'>W</asp:TextBox> - <asp:TextBox ID="saSeaLosses_TB" runat="server" Text='<%# Bind("seaLosses") %>' >L</asp:TextBox></td>
                                        </tr>
                         
                                        <tr>
                                            <td>Division</td><td><asp:DropDownList ID="saDivision_DDL" runat="server"></asp:DropDownList>
                                                <ajaxToolkit:CascadingDropDown ID="divCCD1" runat="server" ServicePath="~/weightGroup.asmx" 
                                                    ServiceMethod="getDivisions" TargetControlID="division_DDL" 
                                                    Category="Division" SelectedValue="divisionName"/></td>
                                        </tr>                       
                                        <tr>
                                            <td>Weight</td><td><asp:DropDownList ID="saWeight_DDL" runat="server"></asp:DropDownList>
                                                <ajaxToolkit:CascadingDropDown ID="divCDD2" runat="server" TargetControlID="weight_DDL"
                                                    Category="Weight" ServicePath="~/weightGroup.asmx" ServiceMethod="getWeights"
                                                    ParentControlID="division_DDL"/></td>
                                        </tr>
                                    </table>
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                           CommandName="Update" Text="Update" />
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" 
                                        CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                        
                                <ItemTemplate>
                                    fName:
                                    <asp:Label ID="fNameLabel" runat="server" Text='<%# Bind("fName") %>' />
                                    <br />
                                    lName:
                                    <asp:Label ID="lNameLabel" runat="server" Text='<%# Bind("lName") %>' />
                                    <br />
                                    grade:
                                    <asp:Label ID="gradeLabel" runat="server" Text='<%# Bind("grade") %>' />
                                    <br />
                                    teamName:
                                    <asp:Label ID="teamNameLabel" runat="server" Text='<%# Bind("teamName") %>' />
                                    <br />
                                    amount:
                                    <asp:Label ID="amountLabel" runat="server" Text='<%# Bind("amount") %>' />
                                    <br />
                                    seaWins:
                                    <asp:Label ID="seaWinsLabel" runat="server" Text='<%# Bind("seaWins") %>' />
                                    <br />
                                    seaLosses:
                                    <asp:Label ID="seaLossesLabel" runat="server" Text='<%# Bind("seaLosses") %>' />
                                    <br />
                                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource ID="selectAthSource" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                SelectCommand="SELECT eventMembers.fName, eventMembers.lName, eventMembers.grade, eventTeams.teamName, eventGroups.amount, eventMembers.seaWins, eventMembers.seaLosses FROM eventMembers LEFT OUTER JOIN eventTeams ON eventMembers.eventTeamID = eventTeams.eventTeamID LEFT OUTER JOIN eventGroups ON eventMembers.eventGroupID = eventGroups.eventGroupID WHERE (eventMembers.memberID = @MemberID);"
                                UpdateCommand="UPDATE eventMembers SET fName = @fName, lName = @lName, grade = @grade, eventGroupID = @evtGroupID, eventTeamID = @evtTeamID, seaWins = @seaWins, seaLosses = @seaLosses WHERE (memberID = @memberID);">
                        
                                <SelectParameters>
                                    <asp:SessionParameter Name="MemberID" SessionField="MemberID" />
                                </SelectParameters>
                                
                                <UpdateParameters>
                                    <asp:Parameter Name="fName" />
                                    <asp:Parameter Name="lName" />
                                    <asp:Parameter Name="grade" />
                                    <asp:Parameter Name="evtGroupID" />
                                    <asp:Parameter Name="evtTeamID" />
                                    <asp:Parameter Name="seaWins" />
                                    <asp:Parameter Name="seaLosses" />
                                    <asp:Parameter Name="memberID" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                          </ContentTemplate>
                    </asp:UpdatePanel>

                    
                    <asp:LinkButton ID="athSelDone_LB" runat="server" OnClick="athSelDone_LB_Click">Done</asp:LinkButton>
                </asp:Panel>
                <ajaxtoolkit:modalpopupextender ID="selAthMPE" runat="server"
                    PopupControlID="selectAth_Pnl"
                    BackgroundCssClass="modalBackground" 
                    TargetControlID="hButton">
                </ajaxtoolkit:modalpopupextender>
                <asp:button id="hButton" runat="server" style="display:none;" />
            
            </div> <!-- athlete tab closing tag-->
            
        </div> <!-- tabs closing tag-->
    </div> <!-- wrap closing tag-->
       



    <!-- Event SETINGS popup panel -->
    <asp:Panel ID="settings_Pnl" runat="server" CssClass="defaultModal">
        <asp:UpdatePanel ID="setings_UPnl" runat="server">
            <ContentTemplate>
                <asp:FormView ID="generalFormView" runat="server" DataSourceID="evtInfo_SqlSource">
                    <EditItemTemplate>
                        <table>
                            <tr>
                                <td>Event Name:</td><td><asp:TextBox ID="eventNameTextBox" runat="server" Text='<%# Bind("eventName") %>' /></td>
                            </tr>
                            <tr>
                                <td>Address:</td><td><asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' /></td>
                            </tr>
                            <tr>
                                <td>City:</td><td><asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' /></td>
                            </tr>
                            <tr>
                                <td>State:</td><td><asp:textbox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' /></td>
                            </tr>
                            <tr>
                                <td>Start Date:</td><td><asp:TextBox ID="startDateTextBox" runat="server" Text='<%# Bind("startDate") %>' /></td>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="startDateTextBox" Format="MMM d, yyyy"/> 
                            </tr>
                            <tr>
                                <td>Start Time:</td><td><asp:TextBox ID="startTimeTextBox" runat="server" Text='<%# Bind("startTime") %>' /></td>
                            </tr>
                            <tr>
                                <td>Competition Level:</td><td><asp:DropDownList ID="levelID_DDL" runat="server" 
                                                                    DataSourceID="levelID_SqlSource" DataTextField="levelName" 
                                                                    DataValueField="levelID" SelectedValue ='<%# Bind("levelID")%>'>
                                                                </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="levelID_SqlSource" runat="server" 
                                                                        ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                                                        SelectCommand="SELECT [levelID], [levelName] FROM [levels]">
                                                                    </asp:SqlDataSource></td>
                            </tr>
                            <tr>
                                <td>Wrestling Style</td><td><asp:DropDownList ID="styleID_DDL" runat="server" 
                                                                DataSourceID="styleIDSqlSource" DataTextField="styleName" 
                                                                DataValueField="styleID" SelectedValue ='<%# Bind("styleID") %>'>
                                                            </asp:DropDownList>
                                                                <asp:SqlDataSource ID="styleIDSqlSource" runat="server" 
                                                                    ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                                                    SelectCommand="SELECT [styleID], [styleName] FROM [wrestlingStyle]">
                                                                </asp:SqlDataSource></td>
                            </tr>
                            <tr>
                                <td>Event Type:</td><td><asp:DropDownList ID="evtType_DDL" runat="server" 
                                                                                
                                    DataSourceID="evtTypeSqlSource"                                                                 
                                    DataValueField="eventTypeID" SelectedValue ='<%# Bind("eventType")%>' 
                                    DataTextField="typeName">
                                                                </asp:DropDownList>
                                <asp:SqlDataSource ID="evtTypeSqlSource" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                    SelectCommand="SELECT [typeName], [eventTypeID] FROM [eventTypes]">
                                </asp:SqlDataSource>
                                </td>
                            </tr>
                                       
                        </table>
                        <br />

                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                                
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td>Event Name:</td><td><asp:Label ID="eventNameLabel" runat="server" Text='<%# Bind("eventName") %>' /></td>
                            </tr>
                            <tr>
                                <td>Address:</td><td><asp:Label ID="addressLabel" runat="server" Text='<%# Bind("address") %>' /></td>
                            </tr>
                            <tr>
                                <td>City:</td><td><asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>' /></td>
                            </tr>
                            <tr>
                                <td>State:</td><td><asp:Label ID="stateLabel" runat="server" Text='<%# Bind("state") %>' /></td>
                            </tr>
                            <tr>
                                <td>Start Date:</td><td><asp:Label ID="startDateLabel" runat="server" Text='<%# Bind("startDate") %>' /></td>
                            </tr>
                            <tr>
                                <td>Start Time:</td><td><asp:Label ID="startTimeLabel" runat="server" Text='<%# Bind("startTime") %>' /></td>
                            </tr>
                            <tr>
                                <td>Competition Level:</td><td><asp:Label ID="levelNameLabel" runat="server" Text='<%# Bind("levelName")%>' /></td>
                            </tr>
                            <tr>
                                <td>Wrestling Style:</td><td><asp:Label ID="styleNameLabel" runat="server" Text='<%# Bind("styleName")%>' /></td>
                            </tr>
                            <tr>
                                <td>Event Type:</td><td><asp:Label ID="eventTypeLabel" runat="server" Text='<%# Bind("typeName")%>' /></td>
                            </tr>
                        </table>
                                                                        
                        <br />

                        <asp:linkbutton id="EditButton" text="Edit" commandname="Edit" runat="server"/> 
                    </ItemTemplate>
                </asp:FormView>

                <asp:SqlDataSource ID="evtInfo_SqlSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                    SelectCommand="SELECT events.eventName, CONVERT(VARCHAR(12), events.startDate, 107) AS startDate, CONVERT(VARCHAR(8), events.startTime, 108) AS startTime, events.state, events.city, events.eventType, events.address, events.levelID, wrestlingStyle.styleName, levels.levelName, events.styleID, eventTypes.typeName FROM events INNER JOIN levels ON events.levelID = levels.levelID INNER JOIN wrestlingStyle ON events.styleID = wrestlingStyle.styleID INNER JOIN eventTypes ON events.eventType = eventTypes.eventTypeID WHERE (events.eventID = @eventID)" 
                    UpdateCommand="UPDATE events SET eventName = @eventName, startDate = @startDate, startTime = @startTime, eventType = @eventType, city = @city, state = @state, styleID = @styleID, levelID = @levelID, address = @address WHERE (eventID = @eventID)">
                <SelectParameters>
                        <asp:SessionParameter Name="eventID" SessionField="EventID" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="eventname" />
                        <asp:Parameter Name="startdate" />
                        <asp:Parameter Name="starttime" />
                        <asp:Parameter Name="eventType" />
                        <asp:Parameter Name="city" />
                        <asp:Parameter Name="state" />
                        <asp:Parameter Name="styleID" />
                        <asp:Parameter Name="levelID" />
                        <asp:Parameter Name="address" />
                        <asp:SessionParameter Name="eventID" SessionField="EventID" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
        
        <!-- Contains the Data for the tournament settings Section including Division and Group sections -->
            
                <h3>Event Settings</h3>
                    Divisions: 
                <br />
                
                <asp:UpdatePanel ID="mainDivision_UpdatePanel" runat="server">
                    <ContentTemplate>
                        <asp:Repeater ID="evtDivision_Rep" runat="server" DataSourceID="divisionSqlDSource">
                            <HeaderTemplate>
                                     
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "DivisionName")%> 
                                                 
                            </ItemTemplate>
                            <FooterTemplate>

                            </FooterTemplate>
                        </asp:Repeater>
                            <asp:SqlDataSource ID="divisionSqlDSource" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                 
                                    SelectCommand="SELECT divisionName FROM eventDivisions WHERE (eventID = @eventDetailsID);">
                                <SelectParameters>
                                    <asp:SessionParameter Name="eventDetailsID" SessionField="EventID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                    </ContentTemplate> 
                                        
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="divOk_Bu" EventName="Click" />
                    </Triggers>
                
                </asp:UpdatePanel> 

                <asp:LinkButton ID="editDiv_LBu" runat="server">Edit</asp:LinkButton>

                <!--Controls the DivisionEdit popup panel -->
                <asp:Panel ID="Division_Pan" runat="server" CssClass="defaultModal">
                    <asp:UpdatePanel ID="editDivision_UpdatePanel" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div>
                            Current Divisions:
                                
                                <br />
                             
                                <asp:Repeater ID="division_Rep" runat="server" DataSourceID="divisionSqlSource" 
                                    OnItemCommand="division_Rep_ItemCommand">
                                    <HeaderTemplate>
                                     
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# DataBinder.Eval(Container.DataItem, "DivisionName")%> 
                                        <asp:LinkButton ID="delete_Bu" runat="server" CommandArgument='<%# Eval("eventDivisionID")%>' CommandName="deleteDivCmd">X</asp:LinkButton>
                                    </ItemTemplate>
                                    <FooterTemplate>

                                    </FooterTemplate>
                                </asp:Repeater>
                                <asp:SqlDataSource ID="divisionSqlSource" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                        SelectCommand="SELECT divisionName, eventDivisionID FROM eventDivisions WHERE (eventID = @eventDetailsID)">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="eventDetailsID" SessionField="EventID" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                             
                                    </div>
                                </ContentTemplate>
                                 <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="divAdd_Bu" EventName="Click" />
                                     <asp:AsyncPostBackTrigger ControlID="editDiv_LBu" EventName="Click" />
                                 </Triggers>
                             </asp:UpdatePanel>

                             <br />
                            <div>
                                Custom Division:
                                <br />
                                <asp:Label ID="divName_Lbl" runat="server" Text="Division Name:"></asp:Label>
                                <asp:TextBox ID="divisionName_TB" runat="server"></asp:TextBox>
                                <asp:Button ID="divAdd_Bu" runat="server" Text="Add" OnClick="divAdd_Bu_Click" />
                            </div>
                            <div>
                                <asp:Button ID="divOK_Bu" runat="server" Text="Done"  OnClick="divOK_Bu_Click" />
                            </div>
                         </asp:Panel>
                            
                             <ajaxToolkit:ModalPopupExtender ID="divMPE" runat="server"
                                TargetControlID="editDiv_LBu"
                                PopupControlID="Division_Pan"
                                BackgroundCssClass="modalBackground" 
                                DropShadow="true">
                             </ajaxToolkit:ModalPopupExtender>
            <br />     
                <br />

            <!-- Controls the Bracket group section and Edit Popup Modul-->
            
                Bracket Groups:
                     
            <asp:UpdatePanel ID="mainBktGroup_UpdatePanel" runat="server">
                <ContentTemplate>

                    <asp:Repeater ID="bktGroup_Rep" runat="server" DataSourceID="bktGroupSqlSource">
                        <HeaderTemplate>
                                     
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "divisionName")%>
                            <%# DataBinder.Eval(Container.DataItem, "amount")%> 
                                                 
                        </ItemTemplate>
                        <FooterTemplate>

                        </FooterTemplate>
                    </asp:Repeater>
                        <asp:SqlDataSource ID="bktGroupSqlSource" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                SelectCommand="SELECT eventGroups.amount, eventDivisions.divisionName FROM eventGroups INNER JOIN eventDivisions ON eventGroups.eventDivisionID = eventDivisions.eventDivisionID WHERE (eventGroups.eventID = @eventDetailsID) GROUP BY eventDivisions.divisionName, eventGroups.amount">
                                <SelectParameters>
                                    <asp:SessionParameter Name="eventDetailsID" SessionField="EventID" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                </ContentTemplate> 
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="groupDone_Bu" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel> 
            
            <asp:LinkButton ID="groupEdit_LBu" runat="server" OnClick="groupEdit_LBu_Click">Edit</asp:LinkButton>

            <asp:Panel ID="groupEdit_Panel" runat="server" CssClass="defaultModal">
                Current Bracket Groups:
                
                <br />

                Division: <asp:DropDownList ID="setDiv_DDL" runat="server" 
                    DataSourceID="divisionDDLSqlSource" DataTextField="divisionName" 
                            DataValueField="eventDivisionID" AutoPostBack="True"></asp:DropDownList>
                                <asp:SqlDataSource ID="divisionDDLSqlSource" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                SelectCommand="SELECT eventDivisionID, divisionName FROM eventDivisions WHERE (eventID = @eventDetailsID)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="eventDetailsID" SessionField="EventID" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                <br />

                <asp:UpdatePanel ID="editGroup_UpdatePanel" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Repeater ID="editGroup_Rep" runat="server" DataSourceID="groupsSqlSource" >
                            <HeaderTemplate>
                                     
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "amount")%> 
                                
                            </ItemTemplate>
                            <FooterTemplate>

                            </FooterTemplate>
                        </asp:Repeater>
                            <asp:SqlDataSource ID="groupsSqlSource" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                    SelectCommand="SELECT eventGroupID, amount FROM eventGroups WHERE (eventID = @eventDetailsID) AND (eventDivisionID = @divisionID)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="eventDetailsID" SessionField="EventID" />
                                        <asp:SessionParameter Name="divisionID" SessionField="divisionDDLID" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Division_DDL" />
                    <asp:AsyncPostBackTrigger ControlID="addGroup_Bu" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="groupEdit_LBu" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>

            <br />
            <div>
                Custom Bracket Group:
                <br />
                <asp:Label ID="amount_Lbl" runat="server" Text="Group Amount:"></asp:Label>
                <asp:TextBox ID="amount_TB" runat="server"></asp:TextBox>
                <asp:Button ID="addGroup_Bu" runat="server" Text="Add" OnClick="addGroup_Bu_Click" />
            </div>
            <div>
                <asp:Button ID="groupDone_Bu" runat="server" Text="Done" OnClick="groupDone_Bu_Click" />
            </div>
        </asp:Panel>
                            
        <ajaxToolkit:ModalPopupExtender ID="groupMPE" runat="server"
        TargetControlID="groupEdit_LBu"
        PopupControlID="groupEdit_Panel"
        BackgroundCssClass="modalBackground" 
        DropShadow="true">
        </ajaxToolkit:ModalPopupExtender>
                
        <asp:LinkButton ID="done_Lb" runat="server" OnClick="done_Lb_Click">Done</asp:LinkButton>
    </asp:Panel>
    <ajaxtoolkit:modalpopupextender ID="MPE" runat="server"
        TargetControlID="settings_LB"
        PopupControlID="settings_Pnl"
        BackgroundCssClass="modalBackground">
    </ajaxtoolkit:modalpopupextender>

    
</asp:Content>

