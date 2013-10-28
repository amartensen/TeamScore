<%@ Page Title="" Language="C#" MasterPageFile="~/master/main_master.master" AutoEventWireup="true" CodeFile="userProfile.aspx.cs" Inherits="userProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="ppg_scroll">
        <div class="pageWrap">
            <div class="content">
                <article class="ppg_center">
                    <article id="ppg_nav">
                        <ul>
                            <li><a href="#per_feed"><h2>Feed</h2></a></li>
                            <li><a href="#per_team"><h2>Teams</h2></a></li>
                            <li><a href="#per_event"><h2>Events</h2></a></li>
                        </ul>
                    </article>
                    <div id="feedContent"></div>
                    <div id="teamContent">   
                        <article class="floatLT">
                            <section >
                                <h3 class="floatLT">My Teams</h3>
                                <input id="editMyTeams" class="floatRT button" type="button" value=" + Edit " />
                                <br />
                                <div id="editMyTeamsCont">
                                    <input id="findTeam" class="floatLT button" type="button" value="Find A Team" />
                                    <input id="addTeam" class="floatLT button" type="button" value="Create Team" />
                                    <br />
                                    <div id="ftm_cont"></div>
                                </div><br />
                            </section>
                            
                            <section id="perTeamMesCont" ></section>
                            

                            <section>
                                <h3 class="floatLT">Favorite Teams</h3>
                                <input id="Button1" class="floatRT button" type="button" value=" + Edit " />
                            </section>
                        </article>

                    </div> 
                    
                    <div id="eventContent">
                        <input id="searchterm" type="text" />
                        <button id="search">search</button><br />
                        <div id="results"></div>
                    </div>
                </article>
              </div>          
                
           
            <article class="ppg_left">
                <section id="ppg_sideBox">
                    <section class="personPic">
                        
                            <img alt="" src="" />
                            
                        
                    </section>
                    <section class="sect">
                        <script id="perDetailsTemp" type="text/x-jquery-tmpl">
                        <h1>${per_fName} ${lName}</h1>
                            ${per_state}
                            ${DOB}

                        </script>
                    </section>
                    <section class="sect">
                        <h4>Teams</h4>
                        <div class="sect_expand">
                            <section id="perTeamsCont">
                            </section>
                            <script id="perTeamsTemp" type="text/x-jquery-tmpl">
                                <div class="personTeams">
                                    <div>
                                        <img alt="" src="#" />
                                        <h4>${tm_name}</h4>
                                        <h5>${tm_city}, ${tm_state}</h5>
                                        <a href="${teamID}"></a>
                                    </div>
                                </div>
                            </script>
                        </div>
                    </section>
                </section>
            </article>
        
        </div>
    </div>
        <div id="fulldialog-overlay"></div>
            <div id="fulldialog-box">
                
                <div class="fulldialog-content">
                    <input id="fulldialog-close" type="button" value="Close" />
                    <div id="fulldialog-title"></div><br />
                    
                    <div id="fulldialog-message"></div>

                             <%--<<<<<<<<<<<<< Add New Team Form >>>>>>>>>>>--%>
                    <script id="addTeamTemp" type="text/x-jquery-tmpl">
                        <div id="newTmStep1">
                            <fieldset id="createNewTeam">
                                
                                <legend>Team Information</legend>
                                
                                <h3>Is this a school or club team?</h3>
                                <input id="schoolRadio" type="radio" name="teamType" value="school"/><label for="schoolRadio">school</label>
                                <input id="clubRadio" type="radio" name="teamType" value="club"/><label for="schoolRadio">club</label>
                                
                                <div id="acadLevel"><br />
                                    <h3>What is your school's academic level?</h3>
                                    <input id="colRadio" type="radio" name="schLvl" value="col" /><label for="colRadio">College/University</label>
                                    <input id="hsRadio" type="radio" name="schLvl" value="hs" checked="checked"/><label for="hsRadio">High School</label>
                                    <input id="msRadio" type="radio" name="schLvl" value="ms"/><label for="msRadio">Middle School</label>
                                </div>
                                
                                <div id="newClub">
                                    <label for="clubName">Club Name:</label>
                                    <input id="clubName" type="text" /><br />
                                    <label>Participation Levels: (Select all that apply)</label><br />
                                    <input id="col_CB" type="checkbox" /><label for="col_CB">College</label>
                                    <input id="hs_CB" type="checkbox" /><label for="hs_CB">High School</label><br />
                                    <input id="ms_CB" type="checkbox" /><label for="ms_CB">Middle School</label>
                                    <input id="youth_CB" type="checkbox" /><label for="youth_CB">Youth</label><br />
                                    <input id="open_CB" type="checkbox" /><label for="open_CB">Open</label><br />
                                    <br />
                                    <h3>School Affiliation</h3>
                                    <input id="clubSchAff" type="checkbox" /><label for="clubSchAff">Affiliate my club with
                                        a high school, college or middle school.</label>
                                    <div class="schAffApp"></div>
                                </div>

                                <div id="tmLocation">
                                    <br />
                                    <h3>Where is your team located?</h3>
                                    <div id="schAffCont"></div>
                                    <div id="tmVenueCont"></div>
                                    <div id="tmAddrCont" class="noMarPad"></div><br />
                                    <a id="schChange" href="#">(change)</a><a id="schSearch" href="#">Look-up a School</a>
                                    
                                </div>
                                <br />

                                <div id="schoolForm">
                                    <a id="noSchool" href="#">Can't Find School?</a><br />
                                    <table>
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

                                                </select>
                                            </td>
                                        </tr>
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
                                                <input id="findSchool" type="button" value="Find It" /></td>
                                        </tr>

                                    </table>

                                    <div id="pickSchool">
                                        <br />
                                        <label for="selSchool">Please select a school from the drop-down below. </label>
                                        <br />
                                        <select id="selSchool"></select>
                                        <input id="selSchAccept" type="button" value="Accept" />
                                        <br />
                                        
                                    </div>

                            </div>
                            </fieldset>
                            <br />
                            <div class="addTeamFormNav">
                                <input id="ToStep2" type="button" value="Continue" />
                            </div>
                        </div>

                        <div id="newTmStep2">
                                                       
                            <fieldset id="ntmContact">
                                <legend>Team Contact Infomation</legend>
                                <label>Contact Name:</label><input id="conFname" type="text" /><input id="conLname" type="text" /><br />
                                <label>Email:</label><input id="conEmail" type="text" /><br />
                                <label>Phone:</label><input id="conPhone" type="text" /><br />
                            </fieldset>
                            <br />
                            <fieldset id="tmContract">
                                <legend>Team Package</legend>
                                <h3>Choose the package that best suits your team's needs:</h3>
                                <div id="package">
                                    <select id="packageSelect">
                                        <option />
                                        <option value="schl.beta">School Team (Beta) - $0.00</option>
                                        <option value="schl.trial">School Team (30 Day Trial) - $0.00</option>
                                        <option value="schl.365">School Team (Premium) - $200.00</option>
                                    </select>
                                    <br />

                                </div>
                            </fieldset>
                            <br />
                            <fieldset id="billingInfo">
                                <legend>Billing Information</legend>
                                <p>Attach an bank account to your team for registration.</p>
                                <label title="state">Account Number:</label><input id="acctNumber" type="text" /><br />
                                <label>Routing Number:</label><input id="routNumber" type="text" /><br />
                            </fieldset>
                            <div class="addTeamFormNav">
                                <input id="BackStep1" type="button" value="Back" />
                                <input id="ToStep3" type="button" value="Continue" />
                            </div>
                        </div>

                        <div id="newTmStep3">
                            <div id="overview">
                            <h2>Overview</h2>
                                <table>
                                    <tr>
                                        <td><h3>Team Name</h3></td>
                                        <td><label id="ovtmname"></label><label id="ovtmabrv"></label></td>
                                    </tr>
                                    <tr>
                                        <td><h3>Location</h3></td>
                                        <td>
                                            <label id="ovlocname" ></label> 
                                            <label id="ovschoolID"></label> <br />
                                            <label id="ovlocaddr"></label><br />
                                            <label id="ovloccity"></label>, <label id="ovlocstate"></label><br />
                                            <label id="ovloczip"></label><br /><br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><h3>Associated Leagues</h3></td>
                                        <td><label id="ovlgename"></label> <br />
                                            <label id="ovlgeorg"></label> <br /></td>
                                    </tr>
                                    <tr>
                                        <td><h3>Team Contact</h3></td>
                                        <td><label id="ovconname"></label> <br />
                                            <label id="ovconemail"></label> <br />
                                            <label id="ovconphone"></label> <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><h3>Package</h3></td>
                                        <td><label id="ovpackname"></label> <br />
                                            <label id="ovpackid"></label> <br />
                                        </td>
                                    </tr>
                                </table>


                            </div>
                            <div class="addTeamFormNav">
                                <input id="BackStep2" type="button" value="Back" />
                                <input id="createTeam" type="button" value="Create Team" />
                            </div>
                        </div>
                        
                        <div id="teamVenue">
                            <table>
                                <tr>
                                    <td>
                                        <label for="venName">School Name:</label></td>
                                    <td>
                                        <input id="venName" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="venAddr">Address:</label></td>
                                    <td>
                                        <input id="venAddr" type="text" /></td>
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
                                        <label for="venState" >State:</label></td>
                                    <td>
                                        <input id="venState" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="venZip">Zip:</label></td>
                                    <td>
                                        <input id="venZip" type="text" /></td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                            </table>
                        </div>
                    
                    </script>


                    
                    </div>
            </div>

        <div id="dialog-overlay"></div>
            <div id="dialog-box">
                <div class="dialog-content">
                    <div id="dialog-title"></div>
                    <div id="dialog-message"></div>
                    </div>
                </div>

    
    <script type="text/javascript">
        $(document).ready(function () {

            // Add the page method call as a load handler for the window.
            $(window).load(function () { });

            // Load the general person details
            $.ajax({
                type: "POST",
                url: "userProfile.aspx/getPersonDetails",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $("#perDetailsTemp").tmpl(data.d).appendTo("#perDetailsCont");
                }
            });

            // Load the person teams
            $.ajax({
                type: "POST",
                url: "userProfile.aspx/getPersonTeams",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $("#perTeamsTemp").tmpl(data.d).appendTo("#perTeamsCont");

                    var div = $('#perTeamsCont').find('div');
                    div.bind('click', function () {
                        var teamid = $(this).find('a').attr('href');
                        window.localStorage.setItem('team_id', teamid)
                        //alert(localStorage.event_id);
                        window.location = "../team/tmStatbook.aspx"

                    });
                }
            });

            $(".sect").click(function () {
                $(this).find('.sect_expand').toggle("slow");

            });


            // Load person team notifications
            $.ajax({
                type: "POST",
                url: "userProfile.aspx/getPendTeams",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $(data.d).each(function (i, item) {
                        $('#perTeamMesCont').append('<div><img src="" alt="" /><p>'+item.tm_name+' has invited you to join the team</p><a href="'+item.teamID+'" /><span class="accept">Accept</span> / <span class="decline">Decline</span></div>')
                    });

                    var div = $('#perTeamMesCont').find('div');
                    div.bind('click', function () {
                        var teamid = $(this).find('a').attr('href');
                    
                        $(this).find('.decline').bind('click', function () {
                        alert('NO' + teamid);
                        });
                        $(this).find('.accept').bind('click', function () {
                            alert('yes' + teamid);
                        });

                        //window.localStorage.setItem('team_id', teamid)
                        //alert(localStorage.event_id);
                       // window.location = "../team/tmStatbook.aspx"

                    });
                }
            });


            var feedCont = $('#feedContent')
            feedCont.show();
            var teamCont = $('#teamContent')
            teamCont.hide();
            var eventCont = $('#eventContent')
            eventCont.hide();
            var editMyTeamsCont = $('#editMyTeamsCont')
            editMyTeamsCont.hide();
            var ftm_cont = $('#ftm_cont')
            ftm_cont.hide();


            $('#ppg_nav ul li').click(function () {
                per_nav = $(this).find('a').attr('href');

                if (per_nav == "#per_feed") {
                    teamCont.hide();
                    eventCont.hide();
                    feedCont.show();
                } else if (per_nav == "#per_team") {
                    feedCont.hide();
                    eventCont.hide();
                    teamCont.show();
                    getAllMembers();
                } else if (per_nav == "#per_event") {
                    feedCont.hide();                    
                    teamCont.hide();
                    eventCont.show();
                }
            });

            $('#editMyTeams').click(function () {
                editMyTeamsCont.show();
            });

            $('#findTeam').click(function () {
                ftm_cont.empty();
                ftm_cont.append(
                    '<br /><input id="tm_lookup" type="text" /><input id="tm_lookup_bu" class="button" type="button" value="Search" /> <br />' +
                    '<div id="teamListCont"></div>');
                ftm_cont.show();

                $('#tm_lookup_bu').bind('click', function () {
                    var teamList = $('#teamListCont')
                    var findTeams = "{'tm_lookup':'" + $('#tm_lookup').val() + "'}"
                    $.ajax({
                        type: "POST",
                        url: "userProfile.aspx/findTeams",
                        data: findTeams,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            teamList.empty();
                            $(data.d).each(function (i, item) {
                                
                                teamList.append(
                                    '<div class="teamSmDisplay">' +
                                        '<img class="floatLT" alt="" src="#" />' +
                                        '<div class="floatLT">' +
                                            '<h4>'+item.tm_name+'</h4>' +
                                            '<h5>' + item.tm_city + ', ' + item.tm_state + '</h5>' +
                                            '</div>' +
                                            '<input id="tmRequest" class="floatRT button" type="button" value="Ask to Join" />'+
                                            '<div id="teamCodeCont" class="floatRT"><p>A password is required for this team.</p>' +
                                            '<input id="teamCode" type="text" /><input id="teamSend" type="button" value="Send Request" /></div>' +
                                            '<a href="' + item.teamID + '"></a><input type="hidden" value="'+item.tm_join_code+'" id="teamReqCode">' +
                                            
                                    '</div>'
                                    );
                                

                            });
                            $('#teamCodeCont').hide();
                            $('#tmRequest').bind('click', function () {
                                $('#tmRequest').hide();
                                $('#teamCodeCont').show();
                            });
                            $('#teamSend').bind('click', function () {
                                if ($('teamCode').val() == $('teamReqCode').val()) {
                                    alert('yes');
                                }
                            });
                        }
                    });
                    
                   
                });
            });

            //<<<<<<<<<<<<Handles the ADD TEAM button click >>>>>>>>>>>>
            $("#addTeam").click(function (e) {
                // display the message
                $('#fulldialog-title').html('<h2>Add A New Team</h2>');
                var dlgMessage = $('#fulldialog-message')
                dlgMessage.empty();

                $('#addTeamTemp').tmpl().appendTo("#fulldialog-message")
                //$('#addTeamTemp').tmpl().appendTo("#teamContent")

                //declare variables that configures the inital add team popup
                var newTmStep1 = dlgMessage.find('#newTmStep1')
                var newTmStep2 = dlgMessage.find('#newTmStep2')
                newTmStep2.hide();
                var newTmStep3 = dlgMessage.find('#newTmStep3')
                newTmStep3.hide();
                var tmLocation = dlgMessage.find('#tmLocation')
                tmLocation.hide();
                var acadLevel = dlgMessage.find('#acadLevel')
                acadLevel.hide();
                var clubType = dlgMessage.find('#newClub')
                clubType.hide();
                var pickSchool = dlgMessage.find('#pickSchool')
                pickSchool.hide();
                var tmVenueCont = dlgMessage.find('#tmVenueCont')
                tmVenueCont.hide();
                var schoolForm = dlgMessage.find('#schoolForm')
                schoolForm.hide();
                var teamVenue = dlgMessage.find('#teamVenue')
                teamVenue.hide();
                var schLookup = dlgMessage.find('#schSearch')
                schLookup.hide();
                var schChange = dlgMessage.find('#schChange')
                schChange.hide();
                var tmAddrCont = dlgMessage.find('#tmAddrCont')
                tmAddrCont.hide();
                var noSchool = dlgMessage.find('#noSchool')
                var schLevel = "HS";
                fulldialogpopup();



                dlgMessage.find('#ToStep2').bind('click', function () {
                    newTmStep1.hide();
                    newTmStep2.show();
                });
                dlgMessage.find('#ToStep3').bind('click', function () {
                    newTmStep2.hide();
                    newTmStep3.find("#ovconname").text(newTmStep2.find("#conFname").val() + " " + newTmStep2.find("#conLname").val());
                    newTmStep3.find("#ovconemail").text(newTmStep2.find("#conEmail").val());
                    newTmStep3.find("#ovconphone").text(newTmStep2.find("#conPhone").val());
                    newTmStep3.find("#ovpackname").text(newTmStep2.find("#packageSelect option:selected").text());
                    newTmStep3.find("#ovpackid").text(newTmStep2.find("#packageSelect").val());
                    newTmStep3.show();
                });
                dlgMessage.find('#BackStep1').bind('click', function () {
                    newTmStep2.hide();
                    newTmStep1.show();
                });
                dlgMessage.find('#BackStep2').bind('click', function () {
                    newTmStep3.hide();
                    newTmStep2.show();
                });

                dlgMessage.find('input[name=teamType]').change(function () {
                    if ($(this).val() == "school") {
                        clubType.hide();
                        acadLevel.show();
                        tmLocation.show();
                        dlgMessage.find('#schAffCont').append().html(schoolForm);
                        schoolForm.show();
                    }
                    else if ($(this).val() == "club") {
                        acadLevel.hide();
                        clubType.show();
                        dlgMessage.find('#schAffCont').append().html(schoolForm);

                    }
                });
                dlgMessage.find('input[name=schLvl]').change(function () {

                    schoolForm.show()

                    resetSchoolForm();
                    if ($(this).val() == "col") {

                        //resetTeamVenue();
                        schLevel = "COL";

                    }
                    else if ($(this).val() == "hs") {
                        resetTeamVenue();
                        schLevel = "HS";
                    }
                    else if ($(this).val() == "ms") {

                        resetTeamVenue();
                        schLevel = "MS";
                    }
                });




                //School Affiliation
                var findSchool = dlgMessage.find('#findSchool')
                findSchool.bind('click', function () {

                    var findSchools = "{'sch_name':'" + $('#schoolName').val() + "', 'sch_loc_state':'" + $('#selState option:selected').val() + "', 'sch_level':'" + schLevel + "'}"
                    $.ajax({
                        type: "POST",
                        url: "userProfile.aspx/getSchools",
                        data: findSchools,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            $('#selSchool').empty();
                            $(data.d).each(function (i, item) {
                                $('#selSchool').append(

                                    $('<option/>', {
                                        value: item.schoolID,
                                        text: item.sch_name + " (" + item.sch_loc_city + ")"
                                    })
                                    );


                            });
                        }
                    });

                    pickSchool.show();
                });

                //handles the club school affiliation checkbox click
                var clubSchAff = dlgMessage.find('#clubSchAff')
                clubSchAff.bind('click', function () {
                    if (clubSchAff.is(':checked')) {
                        //$('#locSchool').tmpl().appendTo($('#dialog-message').find('.schAffApp'));
                        dlgMessage.find('.schAffApp').append().html(schoolForm);
                        schoolForm.show();
                    } else {

                        dlgMessage.find('.schAffApp').empty();
                    }
                });

                //handles the new team can't find school click
                noSchool.bind('click', function () {
                    schoolForm.hide();
                    //dlgMessage.find('#schAffCont').empty();

                    schSearch.show();
                    tmVenueCont.append(dlgMessage.find('#teamVenue'));
                    teamVenue.show();
                    tmVenueCont.show();

                });

                //handles the school lookup click by showing the school form
                schLookup.bind('click', function () {
                    tmVenueCont.hide();
                    schoolForm.show();
                    //dlgMessage.find('#schAffCont').append().html(schoolForm);


                });

                ////handles the custom location checkbox click
                //var noSchool = $('#dialog-message').find('#noSchoolCB')
                //noSchool.bind('click', function () {
                //    //if (noSchoolCB.is(':checked')) {
                //        $('#dialog-message').find('#selSchool').empty();
                //        pickSchool.hide();
                //        findSchool.prop('disabled', true);
                //        custVenue.show();
                //    //} else {
                //        findSchool.prop('disabled', false);
                //        custVenue.hide();
                //   // }
                //});


                //handles the accept school button click
                var acceptSchool = dlgMessage.find('#selSchAccept')
                acceptSchool.bind('click', function () {

                    var acceptSchool = "{'schoolID':'" + $('#selSchool option:selected').val() + "'}"
                    $.ajax({
                        type: "POST",
                        url: "userProfile.aspx/getSchool",
                        data: acceptSchool,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {

                            $(data.d).each(function (i, item) {
                                schoolForm.hide();
                                if (item.sch_con_status == "D" || item.sch_con_status == "") {


                                    tmAddrCont.html(
                                        '<label id="schname">' + item.sch_name + '</label><br />' +
                                        '<label id="tmlocaddr">' + item.sch_loc_addr + '</label><br />' +
                                        '<label id="tmloccity">' + item.sch_loc_city + '</label>' + ", " + '<label id="tmlocstate">' + item.sch_loc_state + '</label><br />' +
                                        '<label id="tmloczip">' + item.sch_loc_zip + '</label><br /><br /> ' +

                                        '<h3>Team Name and League Association</h3>' +
                                        'Team Name: <label id="tmname">' + item.sch_tm_name + '</label> <label> (' + item.sch_tm_abrv + ') </label><br />' +
                                        'League: <label id="tmLeague">' + item.sch_lge_name + '</label> ' +
                                        '<a id="selSchoolID" href="' + item.schoolID + '"></a>'
                                   );
                                    tmAddrCont.show();
                                    noSchool.hide();
                                    schChange.show();
                                    teamVenue.find('#venName').val(item.sch_name);
                                    teamVenue.find('#venAddr').val(item.sch_loc_addr);
                                    teamVenue.find('#venCity').val(item.sch_loc_city);
                                    teamVenue.find('#venState').val(item.sch_loc_state);
                                    teamVenue.find('#venZip').val(item.sch_loc_zip);

                                    newTmStep3.find('#ovtmname').text(item.sch_tm_name);
                                    newTmStep3.find('#ovtmabrv').text(item.sch_tm_abrv);
                                    newTmStep3.find('#ovlocname').text(item.sch_name);
                                    newTmStep3.find('#ovlocaddr').text(item.sch_loc_addr);
                                    newTmStep3.find('#ovloccity').text(item.sch_loc_city);
                                    newTmStep3.find('#ovlocstate').text(" " + item.sch_loc_state);
                                    newTmStep3.find('#ovloczip').text(item.sch_loc_zip);
                                    newTmStep3.find('#ovschoolID').text(item.schoolID);
                                    newTmStep3.find('#ovlgename').text(item.sch_lge_name);
                                    newTmStep3.find('#ovlgeorg').text(item.sch_lge_org);
                                }
                                else if (item.sch_con_status == "A") {

                                    $.ajax({
                                        type: "POST",
                                        url: "userProfile.aspx/getSchlContract",
                                        data: acceptSchool,
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (data) {
                                            $(data.d).each(function (i, cnt) {

                                                tmAddrCont.html(
                                                    "<br /><p><h4>"+item.sch_name+"</h4> is already taken! <br /> <br />" +
                                                    "The school you selected is already being used by another team. Please " +
                                                    "contact <h4>" + cnt.tm_con_name + "</h4> for information regaurding " + cnt.tm_name + ".</p><br />"
                                               );
                                            });
                                            tmAddrCont.show();
                                            schChange.show();
                                        }
                                    });
                                }
                            });
                            pickSchool.show();

                        }
                    });

                    //handles the change school click after school was accepted
                    schChange.bind('click', function () {
                        resetSchoolForm();
                        resetTeamVenue();
                        tmAddrCont.hide();
                        schChange.hide();
                    });

                    function resetSchoolForm() {
                        tmAddrCont.empty();
                        schoolForm.find('#schoolName').val('');
                        schoolForm.find('#selState option:first').val();
                        pickSchool.hide();
                        $('#selSchool').empty();
                        noSchool.show();
                        schChange.hide();
                        schoolForm.show();
                    }

                    function resetTeamVenue() {
                        teamVenue.find('#venName').val('');
                        teamVenue.find('#venAddr').val('');
                        teamVenue.find('#venCity').val('');
                        teamVenue.find('#venState').val('');
                        teamVenue.find('#venZip').val('');
                    }

                    //Create a NEW TEAM
                    var addTeam = dlgMessage.find('#createTeam')
                    addTeam.bind('click', function () {
                        alert("hey");
                                                
                        var newTeam = "{'tmName':'" + newTmStep3.find('#ovtmname').text() + "', 'tmAbrv':'" + newTmStep3.find('#ovtmabrv').text() + "', 'tmCity':'" + newTmStep3.find('#ovloccity').text() + "', 'tmState':'" + newTmStep3.find('#ovlocstate').text() + "', " +
                        "'conName':'" + newTmStep3.find('#ovconname').text() + "', 'conEmail':'" + newTmStep3.find('#ovconemail').text() + "', 'conPhone':'" + newTmStep3.find('#ovconphone').text() + "', 'schoolID':'" + parseInt(newTmStep3.find('#ovschoolID').text()) + "', " +
                        "'packageID':'" + newTmStep3.find('#ovpackid').text() + "'}"

                        $.ajax({
                            type: "POST",
                            url: "userProfile.aspx/createTeam",
                            data: newTeam,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                //needs to collect teamid and go to team statbook page
                            }
                        });
                        window.location = "./userProfile.aspx"
                    });
                }); //acceptSchool end tag

                //TEST: Instant search bar+ $('#selState option:selected').val() + " + schLevel + "

                // <![CDATA[ 
                $("#searchterm").keyup(function () {
                    var q = "{'sch_name':'" + $('#searchterm').val() + "', 'sch_loc_state':'IA', 'sch_level':'HS'}"
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "userProfile.aspx/getSchools",
                        data: q,
                        success: function success(data) {
                            $("#results").empty();
                            $("#results").append(" Results for <b>" + q + "</b>");
                            $.each(data.query.search, function (i, item) {
                                $("#results").append("<div>" + item.sch_name + " (" + item.sch_loc_city + ")</div>");
                            });
                        }
                    });

                    //$.getJSON("userProfile.aspx/getSchools",
                    //{
                    //    srsearch: q,
                    //    action: "query",
                    //    list: "search",
                    //    format: "json"
                    //},

                });

                // ]]>


                //<<<<<<<<<<<<Pop up dialog message box>>>>>>>>>>>>>
                // if user clicked on button, the overlay layer or the dialogbox, close the dialog  
                $('#fulldialog-close').click(function () {
                    $('#fulldialog-overlay, #fulldialog-box').hide();

                });

                // if user resize the window, call the same function again
                // to make sure the overlay fills the screen and dialogbox aligned to center    
                $(window).resize(function () {

                    //only do it if the dialog box is not hidden
                    if (!$('#fulldialog-box').is(':hidden')) fulldialogpopup();
                });

                //Center the Popup dialog and display message
                function fulldialogpopup(message) {

                    // get the screen height and width  
                    var maskHeight = $(window).height();
                    var maskWidth = $(window).width();

                    // calculate the values for center alignment
                    var dialogTop = -($('#fulldialog-box').height() / 2);
                    var dialogLeft = -($('#fulldialog-box').width() / 2);

                    // assign values to the overlay and dialog box
                    $('#fulldialog-overlay').css({ height: maskHeight, width: maskWidth }).show();
                    $('#fulldialog-box').css({ "margin-top": dialogTop, "margin-left": dialogLeft }).show();
                }

                //<<<<<<<<<<<<Pop up dialog message box>>>>>>>>>>>>>
                // if user clicked on button, the overlay layer or the dialogbox, close the dialog  
                $('#closeDiaBu').click(function () {
                    $('#dialog-overlay, #dialog-box').hide();

                });

                // if user resize the window, call the same function again
                // to make sure the overlay fills the screen and dialogbox aligned to center    
                $(window).resize(function () {

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
                    $('#dialog-overlay').css({ height: maskHeight, width: maskWidth }).show();
                    $('#dialog-box').css({ "margin-top": dialogTop, "margin-left": dialogLeft }).show();
                }

            }); //addTeam closing tag
        });//Document ready closing tag
    </script> 
    
    
        


</asp:Content>

