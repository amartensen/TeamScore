<%@ Page Title="" Language="C#" MasterPageFile="~/master/main_master.master" AutoEventWireup="true" CodeFile="tmStatbook.aspx.cs" Inherits="team_tmStatbook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <article class="pageHead">
        <div class="headWrap">
            <h3 id="team" class="floatLT"></h3>
            <input id="backBu" class="floatLT" type="button" value="back" />
        </div>
                                
                            
    </article>
    <div class="scroll">
        <div class="pageWrap">
            
            <div class="content">
                <div id="tabs">
                    <div id="tab-1" class="center">
                        hey
                    </div>

                    <!-- event tab -->
                    <div id="tab-2" class="center">
                       <article class="sbpg_adminPanel">
                           <input id="newEventBu" type="button" value="New Event" />
                            
                       </article>
                        <aside>
                            <table class="mainTable">
                                <tbody id="tmEventContainer">
                                    <!--jtemplate for the athlete list-->
                                    <script id="tmEventTemp" type="text/x-jquery-tmpl">
                                        <tr>
                                            <td>${date}</td>
                                            
                                            <td>${eventName}<a href="${eventID}"></a> <br /> ${city}, ${state}</td>
                                            <td>${styleID}<br /> ${levelID}</td>
                                            <td>${startTime}</td>
                                        </tr>
                                    </script>
                                </tbody>
                            </table>
                        </aside>
                        
                    </div>

                    <!-- member tab -->
                    <div id="tab-3" class="center">
                        <article id="tsb_mem_topNav">
                            <ul>
                                <li><a href="#mem_athlete"><h2>Athetes</h2></a></li>
                                <li><a href="#mem_admin"><h2>Admin Panel</h2></a></li>
                            </ul>
                            <input id="newMemberBu" class="floatRt button" type="button" value="New Member" />
                        </article>
                        
                        <article id="tsb_mem_container"></article>

                    <script id="tsb_mem_athleteViewTmpl" type="text/x-jquery-tmpl">
                            <div id="memAthleteView">
                                <div><a href="${tmMemberID}"></a><img src="" alt="" /><h4>${fName} ${lName}</h4><br />' + linked + "</div>
                            </div>
                        </script>
                        

                        <script id="tsb_mem_athleteTmpl" type="text/x-jquery-tmpl">
                            <article  class="tsb_mem_toolbar">
                                <input id="memBackBu" class="button" type="button" value="Back" />
                                
                            </article>
                            <div class="mem_topContent">
                                <img src="#" alt="" />
                                <div>
                                    <h2>${fName} ${lName}</h2>
                                    <label>${isAthlete}</label><label> ${isCoachCB}</label>
                                </div>
                            </div>
                            <div class="mem_mainContent">
                                    Matches
                            </div>
                        </script>


                        <script id="tsb_mem_adminTmpl" type="text/x-jquery-tmpl">
                            <article  class="tsb_mem_toolbar">
                                <input id="memAdminBack" class="button" type="button" value="Back" />
                                
                            </article>
                            <div class="mem_topContent">
                                <img src="#" alt="" />
                                <div id="basicInfo">
                                    <h2 id="notNewName" class="editableTB">${fName} ${lName}</h2>
                                    <input id="newMemName" type="text" />
                                    <input id="isAthleteCB" type="checkbox" title="athlete" /><label for="isAthleteCB">Athlete</label><input id="isCoachCB" type="checkbox" /><label for="isCoachCB">Coach</label>
                                </div>
                                
                            </div>

                            <!--team member admin content-->
                            <div class="mem_mainContent">
                                <div class="area">
                                    <h4>Connection</h4>
                                    <div id="tsb_mem_linkCont" class="fieldCont"></div>
                                </div>

                                <div class="area">
                                    <h4>Contact</h4>
                                    <table>
                                        <tr>
                                            <td>Phone:</td>
                                            <td>
                                                <input id="tmMemPhone" type="text" value="mem.tmb_phone" /></td>
                                        </tr>
                                    </table>
                                </div> <br />

                                <div class="area">
                                    <h4>Notes</h4>
                                    <input id="Text2" type="text" />
                                </div>
                            </div>


                        </script>


                        

                        <script id="tsb_mem_adminViewTmpl" type="text/x-jquery-tmpl">
                            <div id="memAdminView">
                                <div> <a href="${tmMemberID}"></a><img src="" alt="" /><h4>${fName} ${lName}</h4><span id="athlete"></span> <span id="coach"></span><span id="admin"></span><span id="linkStatus"></span> </div>
                                
                            </div>
                        </script>
                              
                        
                        
                        <ul id="memDetCont"></ul>
                        <aside >
                            <!--jtemplate for tmMember list-->
                            
                            <script id="tmMemberTemp" type="text/x-jquery-tmpl">
                                
                                    ${fName} ${lName} ${grade}
                                
                            </script>
                        </aside>
                    </div>
                    
                    <!--4 tab-->
                    <div id="tab-4" class="center">
                    </div>
                </div>

            
            </div> <!-- end content div -->

            <div id="tabNav" class="left">
                <nav>
                    
                    <ul>
                        <li><a href="#tab-1">Dashboard</a></li>
                        <li><a href="#tab-2">Events</a></li>
                        <li><a href="#tab-3">Members</a></li>
                        <li><a href="#tab-4">Archives</a></li>
                    </ul>
                    
                </nav>
            </div>
        </div>
    </div>    
    <div id="dialog-overlay"></div>
    <div id="dialog-box">
<%--        <div class="dialog-content">
            <div id="dialog-title"></div>
            <div id="dialog-message"></div>
            
            <script id="newMemTemp" type="text/x-jquery-tmpl">
                <br />
                <fieldset><legend>General Info</legend>

                <h4>What is the new team member's name?</h4>
                <input id="fnameTB" type="text" /> <input id="lnameTB" type="text" /><br />
                <br />
                <h4>Will this member participate as an athlete on your team?</h4>
                <input id="ath_yes" name="athRole" type="radio" value="ath_yes"/><label for="ath_yes">Yes</label>
                <input id="ath_no" name="athRole" type="radio" value="ath_no"/><label for="ath_no">No</label>
                <br /><br />
                </fieldset>
                <br />
                <fieldset><legend>Connection & Role</legend>
                <h4>Invite someone to join your team and link to this member.</h4>
                    <div id="getPerForm">
                    Search for a site member: or Send an EMail.<br /> 
                    <input id="memSearch" type="text" /><input id="findPerson" type="button" value="Find It" /><br />
                
                <div id="pickMember">
                    <br />
                    <label for="selPerson">Please select a member from the drop-down below. </label>
                    <br />
                    <select id="selPerson"></select>
                    <input id="selPerAccept" type="button" value="Accept" />
                    <br />
                                        
                </div>
                </div>
                    <div id="acceptPerCont"></div>
                <br />
                <h4>Will this member have the ability to edit your team's scorebook? </h4>
                    <input id="ar_none" name="adminRole" type="radio" value="ar_none"/><label for="ar_none">Not an Admin</label>
                    <input id="ar_admin" name="adminRole" type="radio" value="ar_admin" /><label for="ar_admin">Team Administrator</label>
                    <input id="ar_manager" name="adminRole" type="radio" value="ar_manager" /><label for="ar_manager">Scorebook Manager</label>
                <br />

                </fieldset>
                <div class="dialog_bottomNav">
                    <input id="addMember" class="button floatRT" type="button" value="Add Member" /><input id="Checkbox1" type="checkbox" />
                </div>
            </script>

            <script id="newEvtTemp" type="text/x-jquery-tmpl">

                <div id="newEvtStep1">
                    <br />
                    <table>
                        <tr>
                            <td>Event Name:</td>
                            <td>
                                <input id="evtName_TB" type="text" /></td>
                        </tr>
                    </table>
                    <br />
                    <h2>Location</h2>
                    <hr />
                    <div id="locSchool">
                        <table>
                            <tr>
                                <td>
                                    <label for="schoolName">School Name: </label>
                                </td>
                                <td>
                                    <input id="schoolName" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="selState">State:</label></td>
                                <td>
                                    <select id="selState">
                                        <option />
                                        <option value="AL">Alabama</option>
                                        <option value="AK">Alaska</option>
                                        <option value="AS">American Samoa</option>
                                        <option value="AZ">Arizona</option>
                                        <option value="AR">Arkansas</option>
                                        <option value="AE">Armed Forces</option>
                                        <option value="AA">Armed Forces Americas</option>
                                        <option value="AP">Armed Forces Pacific</option>
                                        <option value="CA">California</option>
                                        <option value="CZ">Canal Zone</option>
                                        <option value="CO">Colorado</option>
                                        <option value="CT">Connecticut</option>
                                        <option value="DE">Delaware</option>
                                        <option value="DC">District Of Columbia</option>
                                        <option value="FM">Federated States of Micronesia</option>
                                        <option value="FL">Florida</option>
                                        <option value="GA">Georgia</option>
                                        <option value="GU">Guam</option>
                                        <option value="HI">Hawaii</option>
                                        <option value="ID">Idaho</option>
                                        <option value="IL">Illinois</option>
                                        <option value="IN">Indiana</option>
                                        <option value="IA">Iowa</option>
                                        <option value="KS">Kansas</option>
                                        <option value="KY">Kentucky</option>
                                        <option value="LA">Louisiana</option>
                                        <option value="ME">Maine</option>
                                        <option value="MH">Marshall Islands</option>
                                        <option value="MD">Maryland</option>
                                        <option value="MA">Massachusetts</option>
                                        <option value="MI">Michigan</option>
                                        <option value="MN">Minnesota</option>
                                        <option value="MS">Mississippi</option>
                                        <option value="MO">Missouri</option>
                                        <option value="MT">Montana</option>
                                        <option value="NE">Nebraska</option>
                                        <option value="NV">Nevada</option>
                                        <option value="NH">New Hampshire</option>
                                        <option value="NJ">New Jersey</option>
                                        <option value="NM">New Mexico</option>
                                        <option value="NY">New York</option>
                                        <option value="NC">North Carolina</option>
                                        <option value="ND">North Dakota</option>
                                        <option value="MP">Northern Mariana Islands</option>
                                        <option value="OH">Ohio</option>
                                        <option value="OK">Oklahoma</option>
                                        <option value="OR">Oregon</option>
                                        <option value="PW">Palau</option>
                                        <option value="PA">Pennsylvania</option>
                                        <option value="QC">Province of Quebec</option>
                                        <option value="PR">Puerto Rico</option>
                                        <option value="RI">Rhode Island</option>
                                        <option value="SC">South Carolina</option>
                                        <option value="SD">South Dakota</option>
                                        <option value="TN">Tennessee</option>
                                        <option value="TX">Texas</option>
                                        <option value="UT">Utah</option>
                                        <option value="VT">Vermont</option>
                                        <option value="VI">Virgin Islands</option>
                                        <option value="VA">Virginia</option>
                                        <option value="WA">Washington</option>
                                        <option value="WV">West Virginia</option>
                                        <option value="WI">Wisconsin</option>
                                        <option value="WY">Wyoming</option>

                                    </select> </td>
                            </tr>
                            <tr>
                                <td>
                                    <input id="findSchool" type="button" value="Find It" /></td>
                                <td>
                                    <input id="noSchoolCB" type="checkbox" /><label for="noSchoolCB">Create a custom location.</label>
                                </td>
                            </tr>

                        </table>

                        <div id="pickSchool">
                            <br />
                            <label for="selSchool">Please select a school from the drop-down below. </label>
                            <br />
                            <select id="selSchool"></select> <input id="selAccept" type="button" value="Accept" />
                            <div id="schAddressCont"></div>

                        </div>

                        <div id="custVenue">
                            <br />
                            <h3>Custom Location</h3>
                            <table>
                                <tr>
                                    <td>
                                        <label for="venName">Venue Name:</label></td>
                                    <td>
                                        <input id="venName" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="venAddress">Address:</label></td>
                                    <td>
                                        <input id="venAddress" type="text" /></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="venCity">City:</label></td>
                                    <td>
                                        <input id="venCity" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="venState">State:</label></td>
                                    <td>
                                        <input id="venState" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="venZip">Zip:</label></td>
                                    <td>
                                        <input id="venZip" type="text" /></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <br />
                    <h2>Date and Time</h2>
                    <hr />
                    <div id="dateTime">
                        <label for="evtDay">Day:</label><input id="evtDay" type="text" /><br />
                        <label>Session 1:</label><input id="ses1Start_tm" type="text" />
                        To
                        <input id="ses1End_tm" type="text" /><br />
                        <input id="AddDate" type="button" value="Add Date" /><br />
                    </div>

                    <input id="ToStep2" type="button" value="Continue" />


                </div>

                <div id="newEvtStep2">
                    <label for="selCompLvl">Competition Level:</label>
                    <select id="selCompLvl">
                        <option>Select One</option>
                        <option value="hs">High School</option>
                        <option value="col">College</option>
                        <option value="open">Youth/Open</option>
                    </select><br />

                    <label for="selStyle">Wrestling Style:</label>
                    <select id="selStyle">
                        <option>Select One</option>
                        <option value="folk">Folstyle</option>
                        <option value="free">Freestyle</option>
                        <option value="greco">Greco</option>
                    </select><br />

                    <label for="selType">Event Type:</label>
                    <select id="selType">
                        <option>Select One</option>
                        <option>Individual Tournament</option>
                        <option>Dual Meet</option>
                        <option>Dual Tournament</option>
                    </select><br />
     
                    <input id="BackStep1" type="button" value="Back" />
                    <input id="ToStep3" type="button" value="Continue" />
                </div>
                <div id="newEvtStep3">
                    <input id="BackStep2" type="button" value="Back" />
                    <input id="addEvent" type="button" value="Create Event" />
                </div>
            </script>

            <script id="schAddressTemp" type="text/x-jquery-tmpl">
                <p>
                    Event Location:
                    ${venName}<br />
                    ${venAddr}<br />
                    ${venCity}, ${venState} ${venZip}
                </p>
            </script>
            <input id="closeBu"  type="button" value="Close" />
        </div>--%>
    </div>
  
 
    
    <!-- Scripts -->
    <script type="text/javascript">
        $(document).ready(function () {
            
            $(window).load(function () {  });

            $("#backBu").click(function () {
                window.location.replace("../user/tmFanPage.aspx")
            });

            var tmMemberID = ""
            var teamID = "{'teamID':'" + localStorage.team_id + "'}"


            // Load team
            $.ajax({
                type: "POST",
                url: "tmStatbook.aspx/getTeam",
                data: teamID,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $(data.d).each(function (i, item) {
                        $('#team').text(item.tm_name)
                    });

                }
            });


            //Tab Navigation
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




            function showModal() {
                $('#newTeamModal').fadeIn(slow);
            }


            //Declare Global Page Variables
            var mem_container = $('#tsb_mem_container')
            
            
            //Load team members
            function getAthletes() {
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamAthletes",
                    data: teamID,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        mem_container.empty();
                        $("#tsb_mem_athleteViewTmpl").tmpl(data.d).appendTo(mem_container);
                        
                        $(data.d).each(function (i, item) {

                            var linked
                            if (item.personID != "") {
                                linked = "Linked"
                            }
                            else {
                                linked = "Not Linked"
                            }
                        });


                        var div = $('#memAthleteView div');
                            //highlight row on hover
                            div.bind('mouseover', function (event) {
                                div.removeClass('row-highlight');
                                $(this).addClass('row-highlight');
                            });
                            div.bind('mouseout', function (event) {
                                div.removeClass('row-highlight');
                            });

                            div.click(function () {
                                mem_container.empty();
                                tmMemberID = $(this).find('a').attr('href');

                                //ORIGINAL
                                var teamMember = "{'tmMemberID':'" + tmMemberID + "', 'teamID':'" + localStorage.team_id + "'}"
                                $.ajax({
                                    type: "POST",
                                    url: "tmStatbook.aspx/getTeamMember",
                                    data: teamMember,
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {

                                        $("#tsb_mem_athleteTmpl").tmpl(data.d).appendTo(mem_container);
                                        $(data.d).each(function (i, mem) {
                                            //alert(currentTab);
                                            //alert(item.fName + " " + item.lName);
                                            var athlete
                                            if (mem.tmb_isAthlete != "") {
                                                athlete = "Athlete"
                                            }
                                            else {
                                                athlete = ""
                                            }

                                            var coach
                                            if (mem.tmb_isCoach != "") {
                                                coach = "Coach"
                                            }
                                            else {
                                                coach = ""
                                            }
                                        //    memDetCont.append(
                                        //        '<li><article class="sbpg_adminPanel"><input id="memDetBack" class="button" type="button" value="Back" /></article>' +
                                        //        ' <div class="member"><div class="sbpg_memDetTop"><img src="#" alt="" />' +
                                        //        '<div><h2>' + mem.fName + " " + mem.lName + "</h2>" + athlete + ' ' + coach + "</div></div>" +
                                        //        ' <div class="sbpg_memDetCenter">Matches' +
                                        //        '</div></div></li>')

                                        });

                                        $('#memBackBu').click(function () {
                                            mem_container.empty();
                                            getAthletes();
                                        });

                                        $('memDetCont').find('#memName').editInPlace({
                                            callback: function (unused, enteredText) { return enteredText; },
                                            //url: "tmStatbook.aspx/getTeamMember",
                                            //params: "name=david"
                                            bg_over: "#080808"
                                        });
                                    }
                                });


                            });


                    }
                });
            };
            getAthletes(); 

                       


            //Load the Admin team members page
            function getAdminMembers() {
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamMembers",
                    data: teamID,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        $(data.d).each(function (i, item) {
                            mem_container.empty();
                            $("#tsb_mem_adminViewTmpl").tmpl(data.d).appendTo(mem_container);

                            var athlete = $('#athlete')
                            if (item.tmb_isAthlete != "") {
                                athlete.append( "Athlete")
                            }
                            else {
                                athlete.append( "")
                            }

                            var coach = $('#coach')
                            if (item.tmb_isCoach != "") {
                                coach.append("Coach")
                            }
                            else {
                                coach.append("")
                            }

                            var admin = $('#admin')
                            if (item.tmb_adminRole == "A") {
                                admin.append("Team Admin")
                            }
                            else if (item.tmb_adminRole == "M") {
                                admin.append("Scorebook Manager")
                            }
                            else {
                                admin.append("")
                            }

                            var linkStatus = $('#linkStatus')
                            if (item.tmb_link_status == "A") {
                                linkStatus.append("Linked")
                            }
                            else if (item.tmb_link_status == "P") {
                                linkStatus.append("Pending...")
                            }
                            else if (item.tmb_link_status == "D") {
                                linkStatus.append("Declined")
                            }
                            else {
                                linkStatus.append("")
                            }

                           });

                           var div = $('#memAdminView div');
                           div.click(function () {
                               tmMemberID = $(this).find('a').attr('href');
                               loadAdminView(tmMemberID);
                           }); //memAdminView click - end tag

                           
                        
                    }
                });
            }

            function loadAdminView(_tmbid) {
                if (_tmbid == 'new') {
                    $("#tsb_mem_adminTmpl").tmpl().appendTo(mem_container);
                    loadTmbNameForm('new');
                    loadPerLinkForm('new');

                } else {
                    tmMemberID = _tmbid
                    var teamMember = "{'tmMemberID':'" + tmMemberID + "', 'teamID':'" + localStorage.team_id + "'}"
                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getTeamMember",
                        data: teamMember,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            mem_container.empty();
                            $("#tsb_mem_adminTmpl").tmpl(data.d).appendTo(mem_container);



                            $('#memAdminBack').click(function () {
                                mem_container.empty();
                                getAdminMembers();
                            });


                            $(data.d).each(function (i, mem) {
                                //alert(item.fName + " " + item.lName);

                                loadTmbNameForm(tmMemberID);
                                
                                
                                var athlete
                                if (mem.tmb_isAthlete != "") {
                                    $("#isAthleteCB").prop('checked', true);
                                }

                                var coach
                                if (mem.tmb_isCoach != "") {
                                    $("#isCoachCB").prop('checked', true);
                                }

                                loadTmbRoleForm(tmMemberID);
                                loadPerLinkForm(tmMemberID);
                            });

                        }
                    });

                }

            

            function loadTmbNameForm(_tmbid) {
                if (_tmbid == "new") {
                    $('#notNewName').hide();
                    $('#newMemName').show();
                    $('#newMemName').focus();
                    $('#newMemName').blur(function () {

                        var value = $('#newMemName').val();
                        var name = value.split(' ')
                
                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/newTeamMember",
                            data: "{'teamID':'" + localStorage.team_id + "', 'tmm_fName':'" + name[0] + "', 'tmm_lName':'" + name[1] + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {

                                tmMemberID = data.d;
                                    
                                $('#newMemName').hide();
                                $('#notNewName').text(value);
                                $('#notNewName').show();
                                loadTmbNameForm(tmMemberID);
                            }
                        });
                    });
                } else {

                    
                    tmMemberID = _tmbid 
                    //Edit team member name in place
                    $('.editableTB').editable(function (value, settings) {
                        console.log(this);
                        var name = value.split(' ')
                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/saveTMBName",
                            data: "{'tmMemberID':'" + tmMemberID + "', 'tmm_fName':'" + name[0] + "', 'tmm_lName':'" + name[1] + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) { }
                        });
                        return (value);
                    }, {
                        onblur: 'submit',
                        type: 'text',
                    });
                            
                    loadTmbRoleForm(tmMemberID);
           
                }
            }
            function loadTmbRoleForm(_tmbid) {
                    
                    //update change in team member role
                    $("#isAthleteCB").change(saveTMBrole);
                    $("#isCoachCB").change(saveTMBrole);

                    function saveTMBrole() {
                        //alert('hi');
                        var isAthlete
                        if ($("#isAthleteCB").is(':checked')) {
                            isAthlete = "Y"
                        } else {
                            isAthlete = ""
                        }

                        var isCoach
                        if ($("#isCoachCB").is(':checked')) {
                            isCoach = "Y"
                        } else {
                            isCoach = ""
                        }

                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/saveTMBRole",
                            data: "{'tmMemberID':'" + tmMemberID + "', 'isAthlete':'" + isAthlete + "', 'isCoach':'" + isCoach + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) { }
                        });
                    }

                }

                function loadPerLinkForm(_tmbid) {
                    var linkCont = $("#tsb_mem_linkCont")
                    linkCont.empty();

                    if (_tmbid == 'new') {
                        linkCont.append('<p class="sect">Give people access to view your statbook by connecting them to a team member. [Learn More] </p><div class="sect" ><input id="invMember" class="perLinkAdd" type="button" value="+ Add Connection" />' +
                                        ' </div>');
                    } else {
                        var teamMember = "{'tmMemberID':'" + tmMemberID + "', 'teamID':'" + localStorage.team_id + "'}"
                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/getTMConnection",
                            data: teamMember,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                $(data.d).each(function (i, mem) {


                                    if (mem.tmb_link_status == "A") {
                                        linkCont.append('<p class="sect">Give people access to view your statbook by connecting them to a team member. [Learn More] </p><div class="sect" ><div class="perLinkBox"><img src="" alt="" />' + mem.per_fname + ' ' + mem.per_lname + '<br />' + mem.per_state +
                                        '<span id="linkRemove" class="floatRT">(Remove)</span></div> </div>')
                                    }
                                    else if (mem.tmb_link_status == "P") {
                                        linkCont.append('<p class="sect">Give people access to view your statbook by connecting them to a team member. [Learn More] </p><div class="sect" ><div class="perLinkBox"><img src="" alt="" />' + mem.per_fname + ' ' + mem.per_lname + '<br /><a href="' + mem.personID + '"/>' +
                                        '<span class="floatRT">Pending...</span> <br /><span id="linkCancel" class="floatRT">(Cancel)</span></div> </div>')

                                    }
                                    else if (mem.tmb_link_status == "D") {
                                        linkCont.append(mem.personID + '<h4> has declined your invite.</h4>')
                                    }
                                    else {
                                        linkCont.append('<p class="sect">Give people access to view your statbook by connecting them to a team member. [Learn More] </p><input id="Button1" type="button" value="button" /><div class="sect" ><input id="invMember" class="perLinkAdd" type="button" value="+ Add Connection" />' +
                                            ' </div>');
                                    }

                                });
                    $('Button1').click(function () {
                        alert('hi');
                    });
                            } //getTMConnection - end tag
                        });
                    }
                
                    $('#invMember').click(function () {
                        emailLookup();
                        function emailLookup() {
                            linkCont.empty();
                            linkCont.append('<div>' +
                                                '<p>What is the email of the person you want to connect with?</p>' +
                                                '<label>Email:</label><input id="memSearch" type="text" />' +
                                                '<input id="findPerson" class="floatRT" type="button" value="Submit" />' +
                                            '</div>')


                            $('#findPerson').click(function () {

                                var serPerEmail = $('#memSearch').val();

                                var findPersons = "{'per_email':'" + $('#memSearch').val() + "'}"//, 'per_lname':'" + $('#memberSearch').val()+"'
                                $.ajax({
                                    type: "POST",
                                    url: "tmStatbook.aspx/getPersons",
                                    data: findPersons,
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {

                                        if (data.d == '') {
                                            linkCont.empty();
                                            linkCont.append('<p>We couldnt find ' + serPerEmail + ' in our system. Would you like to invite this person by email?<br /><span id="changeEmail" class="spanLink">Change Email?</span></p><input id="perEmailInv" class="button" value="Invite By Email" />');
                                        } else {
                                            $(data.d).each(function (i, item) {
                                                linkCont.empty();
                                                linkCont.append('<div><p class="floatLT">Choose to invite the person below or <span id="changeEmail" class="spanLink">try a different email</span>. </p></div><br />' +
                                                    '<div class="perLinkBox"><img src="" alt="" /><h3>' + item.fname + " " + item.lname + '</h3><a href="' + item.userID + '"/>' +
                                                    '<input id="linkButton" class="button" type="button" value="Invite" /></div>');


                                                $('#linkButton').click(function () {

                                                    var invite = "{'personID':'" + $(this).parent().find('a').attr('href') + "', 'tmMemberID':'" + tmMemberID + "'}"
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "tmStatbook.aspx/invitePerson",
                                                        data: invite,
                                                        contentType: "application/json; charset=utf-8",
                                                        dataType: "json",
                                                        success: function (data) {
                                                            alert('linked');
                                                            loadPerLinkForm(tmMemberID);
                                                        }
                                                    });

                                                });
                                            });

                                        }
                                        $('#changeEmail').click(function () {
                                            emailLookup();
                                        });
                                        $('#perEmailInv').click(function () {
                                            alert('Email sent');
                                        });
                                    }
                                });
                            }); //findPerson click - end tag
                        }//changeEmail function - end tag
                    });

                    $('#linkRemove').click(function () {
                        alert('Are you sure you want to remove this link?');
                    });
                    $('#linkCancel').click(function () {
                        alert(tmMemberID);
                        var invite = "{'tmMemberID':'" + tmMemberID + "'}"
                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/cancelPerInvite",
                            data: invite,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                loadPerLinkForm(tmMemberID);
                            }
                        });
                    });


                                    
                }//loadPerLinkForm - Ending Tag
            
}//loadAdminView - ending tag

            $('#newMemberBu').click(function () {
                loadAdminView('new');
                
            });
            


            $('#tsb_mem_topNav ul li').click(function () {
                memView = $(this).find('a').attr('href');

                if (memView == "#mem_athlete") {
                    mem_container.empty();
                    getAthletes();

                } else if (memView == "#mem_admin") {
                    mem_container.empty();
                    getAdminMembers();
                }
            });
            
           
            
            $('#adminView').click(function () {
                $('.member').hide();
                $('.admin').show();
            });

            
            
            //Load team events
            $.ajax({
                type: "POST",
                url: "tmStatbook.aspx/getTeamEvents",
                data: teamID,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: evtSuccess
            });

            function evtSuccess(data, status) {
                //alert(data.d);
                $("#tmEventTemp").tmpl(data.d).appendTo("#tmEventContainer");
                
                //Get the selected event
                $(function () {
                    var div = $('#tmEventContainer').find('tr');
                    div.bind('mouseover', function (event) {
                        div.removeClass('row-highlight');
                        $(this).addClass('row-highlight');
                    });

                    div.bind('click', function () {
                        var id = $(this).find('a').attr('href');
                        window.localStorage.setItem('event_id', id)
                        //alert(localStorage.event_id);
                        window.location = "./statEventView.aspx"

                    });

                });
            }

            
            

            //Handles the new member button
            //$("#newMemberBu").click(function(e) {
                
               
            //    // display the message
            //    $('#dialog-title').html('<h2>Create A New Member</h2>');
            //    $('#dialog-message').empty();
            //    var dlgMessage = $('#dialog-message')
            //    $('#newMemTemp').tmpl().appendTo("#dialog-message")

                //declare variables that configures the inital add team popup
                //var pickMember = dlgMessage.find('#pickMember')
                //pickMember.hide();
                //var getPerForm = dlgMessage.find('#getPerForm')
                //var acceptPerCont = dlgMessage.find('#acceptPerCont')
                //acceptPerCont.hide();
                

                //popup();

                ////Member Connection
                //var findPerson = dlgMessage.find('#findPerson')
                //findPerson.bind('click', function () {
                //    var findPersons = "{'per_name':'" + $('#memSearch').val() + "'}"//, 'per_lname':'" + $('#memberSearch').val()+"'
                //    $.ajax({
                //        type: "POST",
                //        url: "tmStatbook.aspx/getPersons",
                //        data: findPersons,
                //        contentType: "application/json; charset=utf-8",
                //        dataType: "json",
                //        success: function (data) {
                //            $('#selPerson').empty();
                //            $(data.d).each(function (i, item) {
                //                $('#selPerson').append(

                //                    $('<option/>', {
                //                        value: item.userID,
                //                        text: item.fname + " " + item.lname
                //                    })
                //                    );


                //            });
                //        }
                //    });

                //    pickMember.show();
                //});


                //var acceptPerson = dlgMessage.find('#selPerAccept')
                //acceptPerson.bind('click', function () {
                //    getPerForm.hide();
                    
                                
                //    var perQuery = "{'userID':'" + dlgMessage.find('#selPerson option:selected').val() + "'}"
                //    $.ajax({
                //        type: "POST",
                //        url: "tmStatbook.aspx/getPerson",
                //        data: perQuery,
                //        contentType: "application/json; charset=utf-8",
                //        dataType: "json",
                //        success: function (data) {

                //            $(data.d).each(function (i, per) {
                //                acceptPerCont.html(
                //                    '<p>A invite was sent to' + per.fname + ' ' + per.lname + '</p><br />' +
                //                    '<label id="perUserID">' + per.userID + '</label>'
                //               );
                //    acceptPerCont.show();

                                

                //            });
                //       }
                //    });
                //});
//                var athleteRole
//                    dlgMessage.find('input[name=athRole]').change(function () {
                        
//                    if ($(this).val() == "ath_yes") {
//                            athleteRole = "Y"
//                        }
//                        else {
//                            athleteRole = ""
//                        }
//                    });
//var adminRole
//                    dlgMessage.find('input[name=adminRole]').change(function () {
                        
//                        if ($(this).val() == "ar_admin") {
//                            adminRole = "A"
//                        }
//                        else if ($(this).val() == "ar_manager") {
//                            adminRole = "M"
//                        }
//                        else {
//                            adminRole =""
//                        }
//                    });
//                //Save new team member
//                var add = $('#dialog-message').find('#addMember')
//                add.bind('click', function () {
                                  

//                    var newMember = "{'fName':'" + $('#fnameTB').val() + "', 'lName':'" + $('#lnameTB').val() + "', 'teamID':'" + localStorage.team_id + "', "+
//                        "'isAthlete':'" + athleteRole + "', 'adminRole':'" + adminRole + "', 'userID':'" + $('#selPerson option:selected').val() + "'}"
//                $.ajax({
//                    type: "POST",
//                    url: "tmStatbook.aspx/newTeamMembers",
//                    data: newMember,
//                    contentType: "application/json; charset=utf-8",
//                    dataType: "json",
//                    success: function (data) {
//                        //alert(data.d);
//                        alert("added!")
                        
                        
                        
//                    }
//                });
//getMember();
//                $("#dialog-overlay, #dialog-box").hide();
//            });
            
//            });
            

            $("#newEventBu").click(function (e) {
                
                // display the message
                $('#dialog-title').html('<h2>Create An Event</h2>');
                $('#dialog-message').empty();
                //load template
                $('#newEvtTemp').tmpl().appendTo("#dialog-message");
                //declare variables that configures the inital new event popup
                var newEvtStep1 = $('#dialog-message').find('#newEvtStep1')
                var newEvtStep2 = $('#dialog-message').find('#newEvtStep2')
                    newEvtStep2.hide();
                var newEvtStep3 = $('#dialog-message').find('#newEvtStep3')
                    newEvtStep3.hide();
                var pickSchool = $('#dialog-message').find('#pickSchool')
                    pickSchool.hide();
                var custVenue = $('#dialog-message').find('#custVenue')
                    custVenue.hide();
                var evtDay = $('#dialog-message').find('#evtDay')
                    evtDay.datepicker();
                popup();

                //Save new team event
                $('#dialog-message').find('#addEvent').bind('click', function () {

                    var newEvent = "{'teamID':'" + localStorage.team_id + "', 'eventName':'" + $('#evtName_TB').val() + "', 'startDate':'" + $('#evtStDate_TB').val() + "', 'startTime':'" + $('#evtStTime_TB').val() + "', 'eventType':'1'," +
                                     "'address':'" + $('#evtAddr_TB').val() + "', 'city':'" + $('#evtCity_TB').val() + "', 'state':'" + $('#evtState_TB').val() + "', 'styleID':'folk', 'levelID':'hs'}"
                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/newTeamMembers",
                        data: newEvent,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            //alert(data.d);
                            alert("added!")

                            getMembers();
                            $("#dialog-overlay, #dialog-box").hide();
                        }
                    });
                });
                
                
                var findSchool = $('#dialog-message').find('#findSchool')
                findSchool.bind('click', function () {

                    var findSchool = "{'sch_name':'" + $('#schoolName').val() + "', 'sch_loc_state':'" + $('#selState option:selected').val()+ "'}"
                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getSchools",
                        data: findSchool,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            $('#selSchool').empty();
                            $(data.d).each(function (i, item) {
                                $('#selSchool').append(
                                    
                                    $('<option/>', {
                                        value: item.schoolID,
                                        text: item.sch_name + " ("+ item.sch_loc_city + ")"
                                    })
                                    );
                                $("#tmMemberContainer").empty().append().html(
                                    item.sch_loc_addr
                               );

                                //var tmpIdx = $("#selSchool").selectedIndex;
                                //$('#dialog-message').find('#seloption').append(data.d).selectedIndex = tmpIdx;
                            
                            });
                        }
                });

                    pickSchool.show();
                });

                //handles the custom location checkbox click
                var noSchoolCB = $('#dialog-message').find('#noSchoolCB')
                noSchoolCB.bind('click', function () {
                    if (noSchoolCB.is(':checked')) {
                        $('#dialog-message').find('#selSchool').empty();
                        pickSchool.hide();
                        findSchool.prop('disabled', true);
                        custVenue.show();
                    } else {
                        findSchool.prop('disabled', false);
                        custVenue.hide();
                        //$(custVenue).find('#venAddress').empty();
                    }
                });

                $('#dialog-message').find('#ToStep2').bind('click', function () {
                    newEvtStep1.hide();
                    newEvtStep2.show();
                });
                $('#dialog-message').find('#ToStep3').bind('click', function () {
                    newEvtStep2.hide();
                    newEvtStep3.show();
                });
                $('#dialog-message').find('#BackStep1').bind('click', function () {
                    newEvtStep2.hide();
                    newEvtStep1.show();
                });
                $('#dialog-message').find('#BackStep2').bind('click', function () {
                    newEvtStep3.hide();
                    newEvtStep2.show();
                });


            });




            // if user clicked on button, the overlay layer or the dialogbox, close the dialog  
            $('#closeBu').click(function() {
                $('#dialog-overlay, #dialog-box').hide();
                
            });

            // if user resize the window, call the same function again
            // to make sure the overlay fills the screen and dialogbox aligned to center    
            $(window).resize(function() {

                //only do it if the dialog box is not hidden
                if (!$('#dialog-box').is(':hidden')) popup();
            });
        

        //Center the Popup dialog and display message
        function popup(message) {

            // get the screen height and width  
            var maskHeight = $(window).height();
            var maskWidth = $(window).width();

            // calculate the values for center alignment
            var dialogTop = -($('#dialog-box').height() / 2);
            var dialogLeft = -($('#dialog-box').width() / 2);

            // assign values to the overlay and dialog box
            $('#dialog-overlay').css({height:maskHeight, width:maskWidth}).show();
            $('#dialog-box').css({ "margin-top": dialogTop, "margin-left": dialogLeft }).show();
        }
        });// Document closing tag
    </script>   
</asp:Content>

