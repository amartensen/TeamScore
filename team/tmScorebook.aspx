<%@ Page Title="" Language="C#" MasterPageFile="~/master/main_master.master" AutoEventWireup="true" CodeFile="tmScorebook.aspx.cs" Inherits="team_tmDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
                <asp:Button ID="fanPage_Bu" runat="server" Text="<---" 
                    OnClick="fanPage_Bu_Click" />
                <input id="Button1" type="button" value="<---" />
            </div>
        
    </div>



    <div id="wrap">
        <aside>
            <asp:UpdatePanel ID="tmMemRep_UPnl" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                <ContentTemplate>
                    <div>
                        <asp:Repeater ID="tmMember_REP" runat="server" DataSourceID="tmMemberSource" OnItemCommand="tmMember_REP_ItemCommand">
                            <HeaderTemplate>
                                <table>
                                    <tr>
                                        <th>Name</th>
                                        <th>Grade</th>
                                        <th></th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                    <tr>
                                        <td><%# DataBinder.Eval(Container.DataItem, "fName")%> <%# DataBinder.Eval(Container.DataItem, "lName")%></td>
                                        <td><%# DataBinder.Eval(Container.DataItem, "grade")%></td>
                                        <td><asp:LinkButton ID="select_LB" runat="server" CommandArgument='<%#Eval("tmMemberID") %>' 
                                            commandName="selectCommand">View</asp:LinkButton></td>                 
                    
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>

                        </asp:Repeater>
                        <asp:SqlDataSource ID="tmMemberSource" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                            SelectCommand="SELECT grade, lName, fName, tmMemberID FROM tmMembers WHERE (teamID = @teamID);">
                            <SelectParameters>
                                <asp:SessionParameter Name="teamID" SessionField="TeamID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="addMem_LB" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:Button ID="newMember_Bu" runat="server" Text="New Member" />
            <button id="newMemBu" class="newMemBu" type="button">JQuery Popup</button>
        </aside>


            <div id="dialog-overlay"></div>
            <div id="dialog-box">
                <div class="dialog-content">
                    <div id="dialog-title"></div>
                    <div id="dialog-message"></div>
                    <input id="closeMemBu" type="button" value="Close" />
                </div>
            </div>
            
        

             <script type="text/javascript">
                 $(document).ready(function () {
                     $("#content").addClass("dialogBox");
                 });
            </script>

              <!--Script that displays the dialog popup boxes --> 
            <script type="text/javascript">
                $(document).ready(function() {

                    $(".newMemBu").click(function(e) {
                        $("#dialog-overlay, #dialog-box").show();

                        popup();

                        // display the message

                        $('#dialog-title').html('<h2>New Member</h2>');
                        $('#dialog-message').html(' <p>First Name:</p>' + 
                            '<input id="fname" type="text" /><br />' +
                            '<p>Last Name:</p>' +
                            '<input id="lname" type="text" /><br />' +
                            '<p>City:</p>' +
                            '<input id="city" type="text" />' +
                            '<input id="addMember" type="submit" value="Add Team" />');

                    });

                    $("#testBu").click(function () {
                        $.ajax({
                            type: "POST",
                            url: "tmScorebook.aspx/GetTeamMembers",
                            data: {}, //"{'fname':'dave','lname':'ward'}"
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: alert(data.d),
                            error: alert("shit")
                        });
                    });

                    $(".newTmBu").click(function(e) {
                        $("#dialog-overlay, #dialog-box").show();

                        popup();

                        // display the message
                        $('#dialog-message').html(
                            'hello2'
                            );
                    });

                    // if user clicked on button, the overlay layer or the dialogbox, close the dialog  
                    $('#closeMemBu').click(function() {
                        $('#dialog-overlay, #dialog-box').hide();
                        $.ajax({
                            type: "POST",
                            url: "../teamMembersWS.asmx/GetTeamMembers",
                            data: {}, //"{'fname':'dave','lname':'ward'}"
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: alert(data.d),
                            error: alert("shit")
                        });
                        return false;
                    });

                    // if user resize the window, call the same function again
                    // to make sure the overlay fills the screen and dialogbox aligned to center    
                    $(window).resize(function() {

                        //only do it if the dialog box is not hidden
                        if (!$('#dialog-box').is(':hidden')) popup();
                    });
                });

                //Center the Popup dialog and display message
                function popup(message) {

                    // get the screen height and width  
                    var maskHeight = $(document).height();
                    var maskWidth = $(window).width();

                    // calculate the values for center alignment
                    var dialogTop = -($('#dialog-box').height() / 2);
                    var dialogLeft = -($('#dialog-box').width() / 2);

                    // assign values to the overlay and dialog box
                    //$('#dialog-overlay').css({height:maskHeight, width:maskWidth}).show();
                    $('#dialog-box').css({ "margin-top": dialogTop, "margin-left": dialogLeft }).show();


                }
                </script>

        

        <article>
            <asp:Repeater ID="events_Rep" runat="server"  DataSourceID="events_SQLSource" OnItemCommand="tmEvents_REP_ItemCommand">
                    <HeaderTemplate>
                        <table>
                            <thead>
                                <th>Date</th>
                                <th>Name</th>
                                <th>Start Time</th>
                                <th>City</th>
                                <th>State</th>
                                <th></th>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr>
                                <td><%# DataBinder.Eval(Container.DataItem, "date")%></td>
                                <td><%# DataBinder.Eval(Container.DataItem, "eventName")%></td>
                                <td><%# DataBinder.Eval(Container.DataItem, "startTime")%></td>
                            
                                <td><%# DataBinder.Eval(Container.DataItem, "city")%></td>
                                <td><%# DataBinder.Eval(Container.DataItem, "state")%></td>
                                <td><asp:LinkButton ID="evtView_LB" runat="server" CommandArgument='<%#Eval("eventID") %>' CommandName="selectCommand">View</asp:LinkButton></td>
                            </tr>
                        </tbody>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:SqlDataSource ID="events_SqlSource" runat="server" ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                    SelectCommand="SELECT CONVERT (varchar(10), startDate, 101) AS date, eventName, startTime, city, state, eventID FROM events 
                        WHERE (eventID IN (SELECT eventID FROM tmEvents WHERE (teamID = @teamID))) ORDER BY date" >
                    <SelectParameters>
                        <asp:SessionParameter Name="teamID" SessionField="TeamID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            <asp:Button ID="newEvent_Bu" runat="server" Text="New Event" />
            <button id="Button2" class="newTmBu" type="button">New TeamJS</button>
            <button id="testBu" type="button">Test</button>
        </article>
    </div>
        
        <asp:Panel ID="tmMemDetail_Pnl" runat="server" CssClass="tmMember_Pnl">
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
                <asp:LinkButton ID="cancelMem_LB" runat="server">Cancel</asp:LinkButton>
                <asp:LinkButton ID="addMem_LB" runat="server" OnClick="addMem_LB_Click">Add Member</asp:LinkButton>
            </div>
            </div>
               
        </asp:Panel>
        <ajaxtoolkit:modalpopupextender ID="MPE" runat="server"
            TargetControlID="newMember_Bu"
            PopupControlID="tmMemDetail_Pnl"
            BackgroundCssClass="modalBackground" 
            DropShadow="true" CancelControlID="cancelMem_LB">
        </ajaxtoolkit:modalpopupextender>
    
        <asp:Panel ID="tmEvent_Pnl" runat="server" CssClass="tmEvent_Pnl">
            <table>
                                        <tr>
                                            <td>Event Name:</td><td><asp:TextBox ID="evtName_TB" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td>Address:</td><td><asp:TextBox ID="addr_TB" runat="server"/></td>
                                        </tr>
                                        <tr>
                                            <td>City:</td><td><asp:TextBox ID="city_TB" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td>State:</td><td><asp:textbox ID="state_TB" runat="server"/></td>
                                        </tr>
                                        <tr>
                                            <td>Start Date:</td><td><asp:TextBox ID="startDate_TB" runat="server" /></td>
                                               <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="startDate_TB" Format="MMM d, yyyy"/> 
                                        </tr>
                                        <tr>
                                            <td>Start Time:</td><td><asp:TextBox ID="startTime_TB" runat="server"/></td>
                                        </tr>
                                        <tr>
                                            <td>Competition Level:</td><td><asp:DropDownList ID="levelID_DDL" runat="server" 
                                                                                DataSourceID="levelID_SqlSource" DataTextField="levelName" 
                                                                                DataValueField="levelID">
                                                                            </asp:DropDownList>
                                                                                <asp:SqlDataSource ID="levelID_SqlSource" runat="server" 
                                                                                    ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                                                                    SelectCommand="SELECT [levelID], [levelName] FROM [levels]">
                                                                                </asp:SqlDataSource></td>
                                        </tr>
                                        <tr>
                                            <td>Wrestling Style</td><td><asp:DropDownList ID="styleID_DDL" runat="server" 
                                                                            DataSourceID="styleIDSqlSource" DataTextField="styleName" 
                                                                            DataValueField="styleID">
                                                                        </asp:DropDownList>
                                                                            <asp:SqlDataSource ID="styleIDSqlSource" runat="server" 
                                                                                ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                                                                SelectCommand="SELECT [styleID], [styleName] FROM [wrestlingStyle]">
                                                                            </asp:SqlDataSource></td>
                                        </tr>
                                        <tr>
                                            <td>Event Type:</td><td><asp:DropDownList ID="evtType_DDL" runat="server" 
                                                                                
                                                DataSourceID="evtTypeSqlSource"                                                                 
                                                DataValueField="eventTypeID"
                                                DataTextField="typeName">
                                                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="evtTypeSqlSource" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                                                SelectCommand="SELECT [typeName], [eventTypeID] FROM [eventTypes]">
                                            </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                       
                                    </table>
                
            
        <div>
            <asp:LinkButton ID="cancelEvt_LB" runat="server">Cancel</asp:LinkButton>
            <asp:LinkButton ID="addEvt_LB" runat="server" CommandName="Insert" OnClick="addEvt_LB_Click">Add Event</asp:LinkButton>
        </div>
        
               
    </asp:Panel>
    <ajaxtoolkit:modalpopupextender ID="MPE2" runat="server"
        TargetControlID="newEvent_Bu"
        PopupControlID="tmEvent_Pnl"
        BackgroundCssClass="modalBackground" 
        DropShadow="true" CancelControlID="cancelEvt_LB">
    </ajaxtoolkit:modalpopupextender>
    </asp:Content>

