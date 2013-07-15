<%@ Page Title="" Language="C#" MasterPageFile="~/master/main_master.master" AutoEventWireup="true" CodeFile="statEventView.aspx.cs" Inherits="team_statEventView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="pageHead">
        <article class="headWrap">
            <h3 class="floatLT">[Team Name]</h3>
            <input id="backBu" class="floatLT" type="button" value="back" />
        </article>
    </div>
    <div class="scroll">
    <div class="pageWrap">
    
    <article id="evtDetail">
        <div id="evtDetailCont"></div>
            <script id="evtDetailTemp" type="text/x-jquery-tmpl">
                
                ${eventName}<br />
                ${address}<br />
                ${city}, ${state}<br />
                ${startDate}<br />
                Start Time:${startTime}<br />
                ${eventID}<br />
                ${styleID}<br />
                ${levelID}<br />
        
            </script>
        
        <a href="#">Settings</a>
    </article>
    
        <div class="content" >
            <div id="tabs" >
            
                
                <div id="tab-1" class="center">
                    
                    <article class="tabHeader">
                        <h3 class="floatLT">Event Matches</h3>
                        <input id="newMatchBu" class="floatRT" type="button" value="New Match" />
                    </article>
                    
                    <p>Lorem ipsum dolor sit amet</p>
                    <aside>
                        <table>
                            <thead>
                                <tr>
                                    <th>Name</th><th>Grade</th><th>teamID</th><th>tmMemberID</th><th>userID</th>
                                </tr>
                            </thead>
                            <tbody id="evtMatchContainer">
                                <!--jtemplate for tmMember list-->
                                <script id="evtMatchTemp" type="text/x-jquery-tmpl">
                                    <tr>
                                        <td>${weight}</td>
                                        <td>${hfName} ${hlName}</td>
                                        <td>${hgrade}</td>
                                        <td>${hwinner}</td>
                                        <td>${hwinType}</td>
                                        <td>${hfallTime}</td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>${afName} ${alName}</td>
                                        <td>${agrade}</td>
                                        <td>${awinner}</td>
                                        <td>${awinType}</td>
                                        <td>${afallTime}</td>
                                    </tr>
                                </script>
                            </tbody>
                        </table>
                    </aside>
               </div>

               <div id="tab-2" class="center">
                   
                       <article class="tabHeader">
                            <h3 class="floatLT">Team List</h3>
                            <input id="newTeamBu" class="floatRT" type="button" value="New Team" />
                       </article>
                    

                   <p>Lorem ipsum dolor sit amet, conse</p><br/>
                   <aside >
                        <table class="mainTable">
                            <thead>
                                <tr>
                                    <th></th><th>Name</th><th>Abrv.</th><th>City</th><th>State</th><th>evtTeamid</th>
                                </tr>
                            </thead>
                            <tbody id="evtTeamContainer">
                                <!--jtemplate for the team list-->
                                <script id="evtTeamTemp" type="text/x-jquery-tmpl">
                                    <tr>
                                        <td><input type="checkbox" /></td>
                                        <td>${teamName}</td>
                                        <td>${teamAbrv}</td>
                                        <td>${city}</td>
                                        <td>${state}</td>
                                        <td>${eventTeamID}</td>
                                    </tr>
                                </script>
                            </tbody>
                        </table>
                    </aside>
               </div>

               <div id="tab-3" class="center">
                    
                        <article class="tabHeader">
                            <h3 class="floatLT">Athlete List</h3>
                            <input id="newAthleteBu" class="floatRT" type="button" value="New Athlete" />
                        </article>
                    
                    <p>Lorem ipsum dolor sit amet,asdfa</p>  <br/>
                    <aside>
                        <table class="mainTable">
                            <thead>
                                <tr>
                                    <th></th><th>Name</th><th>Grade</th><th>Weight</th><th>Team</th>
                                </tr>
                            </thead>
                            <tbody id="evtAthleteContainer">
                                <!--jtemplate for the athlete list-->
                                <script id="evtAthleteTemp" type="text/x-jquery-tmpl">
                                    <tr>
                                        <td><input type="checkbox" /></td>
                                        <td>${fName} ${lName}</td>
                                        <td>${grade}</td>
                                        <td>${amount}</td>
                                        <td>${teamName}</td>
                                    </tr>
                                </script>
                            </tbody>
                        </table>
                    </aside>
               </div>
            </div>
            

        </div>
        
            <div id="tabNav" class="left">
                <ul>
                    <li><a href="#tab-1">Matches</a></li>
                    <li><a href="#tab-2">Team List</a></li>
                    <li><a href="#tab-3">Athlete List</a></li>
                </ul>
            </div>
    </div>
 </div> 


<!-- Scripts -->            
<script type="text/javascript">
    $(document).ready(function () {

        // Add the page method call as a load handler for the window.
        $(window).load(function () {});

        $('#tabs div').hide();
        $('#tabs div:first').show();
        $('#tabNav ul li:first').addClass('active');
 
        $('#tabNav ul li a').click(function () {
            $('#tabNav ul li').removeClass('active');
            $(this).parent().addClass('active');
            var currentTab = $(this).attr('href');
            $('#tabs div').hide();
            $(currentTab).show();
            return false;
        });

        //Load the event details tells for the selected event
        var eventID = "{'eventID':'" + localStorage.event_id + "'}"
        $.ajax({
            type: "POST",
            url: "statEventView.aspx/getEventDetails",
            data: eventID,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //alert(localStorage.event_id);
                $("#evtDetailTemp").tmpl(data.d).appendTo("#evtDetailCont");
            }
        });
    
        //Load all matches for the selected event
        $.ajax({
            type: "POST",
            url: "statEventView.aspx/getEventMatches",
            data: eventID,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data, status) {
                //alert('event matches');
                $("#evtMatchTemp").tmpl(data.d).appendTo("#evtMatchContainer");
            }
        });

            $.ajax({
                type: "POST",
                url: "statEventView.aspx/getEventTeams",
                data: eventID,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: tmSuccess
            });

            $.ajax({
                type: "POST",
                url: "statEventView.aspx/getEventAthletes",
                data: eventID,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: athSuccess
            });

            
        

        
        function tmSuccess(data, status) {
            //alert(data.d);
            $("#evtTeamTemp").tmpl(data.d).appendTo("#evtTeamContainer");
        }
        function athSuccess(data, status) {
            //alert(data.d);
            $("#evtAthleteTemp").tmpl(data.d).appendTo("#evtAthleteContainer");
        }

        $("#backBu").click(function () {

            window.location.replace("./tmStatbook.aspx")

        });
    });
</script>


</asp:Content>

