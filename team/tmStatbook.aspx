<%@ Page Title="" Language="C#" MasterPageFile="~/master/main_master.master" AutoEventWireup="true" CodeFile="tmStatbook.aspx.cs" Inherits="team_tmStatbook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- Statbook Header -->
    <article class="pageHead">
        <div class="headWrap">
            <h3 id="team" class="floatLT"></h3>
            <%--<input id="backBu" class="floatLT" type="button" value="back" />--%>
            <section id ="tsb_tool_container"></section>
            <script id="tsb_tool_mem" type="text/x-jquery-tmpl">
                <input id="memBackBu" class="button ndisplay" type="button" value="Back" />
                <input id="athSetBu" class="button ndisplay" type="button" value="Settings" />
                <input id="athDisplayBu" class="button ndisplay" type="button" value="Matches" />
                <input id="newMemberBu" class="button" type="button" value="New Member" />
            </script>

            <script id="tsb_tool_event" type="text/x-jquery-tmpl">
                <input id="evtBackBu" class="button ndisplay" type="button" value="Back" />
                <input id="evt_settingsBu" class="button ndisplay" type="button" value="Settings" />
                <input id="newEventBu" class="button ndisplay" type="button" value="New Event" /> 
            </script>

            
        </div>
    </article>

    

    <div class="scroll">
        <div class="pageWrap">
            
            <div class="content">
                <div id="tabs">

                    <!--<<< DASHBOARD TAB >>>

                    <div id="tab-1" class="center">
                        hey
                    </div>-->

                    <!--<<< EVENT TAB >>>-->
                    <div id="tab-2" class="center">
                        <article class="sbpg_adminPanel">
                            
                            
                        </article>
                        
                        <!--Event Tab Main Content Container-->
                        <article id="tmb_evt_container"> 
                            

                        </article>
                        
                        <!--jtemplate for the event list-->
                        <script id="tsb_evt_listViewTmpl" type="text/x-jquery-tmpl">
                            <div id="evt_list_container">
                                <ul id="tsb_event_list"></ul>
                            </div>
                            
                        </script>

                        <!-- Event detailed -->
                        <script id="tsb_evt_detailTmpl" type="text/x-jquery-tmpl">
                            <article class="tsb_mem_toolbar">
                                
                            </article>
                            <article id="evt_topContent">
                                <section id="dateBar">
                                    <span id="evt_date">${startDate}</span>
                                    <span id="evt_time"></span>
                                </section>
                                <section>
                                    <h3>${evt_name}</h3><br />
                                    <p><span id="evt_style">${styleID}</span><span id="evt_level"></span>${levelID}</p>
                                    
                                </section>

                                <section>
                                    <span>Location:</span><br />
                                    <p>${evt_ven_name}</p>
                                    <p>${evt_addr}</p>
                                    <p>${evt_city}, ${evt_state}</p>
                                </section>
                                

                                
                            </article>
                            

                            <article id="evt_contentNav">
                                <select id="evt_navDDL" class="button">
                                    <option value="#evt_matches">Matches</option>
                                    <option value="#evt_teams">Teams</option>
                                    <option value="#evt_athletes">Athletes</option>
                                </select>
                               <%-- <ul>
                                    <li><a href="#evt_matches"/><h2>Matches</h2></li>
                                    <li><a href="#evt_teams"/><h2>Teams</h2></li>
                                    <li><a href="#evt_athletes"/><h2>Athletes</h2></li>
                                </ul>--%>
                                <div id="evt_contentToolbar">
                                    <select id="evt_division" class="button"></select>
                                    
                                    <input id="evt_bkt_addBU" class="button" type="button" value="Add Bracket" />
                                    <input id="bracketSeedsBU" class="button" type="button" value="Seeds" />
                                    <input id="bracketSetupBU" class="button" type="button" value="Edit Bracket" />
                                    <select id="evt_bkt_moreDDL" class="button">
                                        <option>More</option>
                                        <option value ="options">Bracket Options</option>
                                        <option value="delete">Delete Bracket</option>                                        
                                    </select>
                                    <input id="evt_newTeamBU" class="button" type="button" value="Add Team" />
                                    <input id="evt_newAthleteBU" class="button" type="button" value="Add Athlete" />
                                </div>
                            </article>

                            
                                <div id="evt_matches_tmpl">
                                    <article class="evt_mainContent">
                                        <div id="bkt_messege"></div>
                                        <div id="bkt_container">
                                            <div id="matchTools" >
                                                <label for="evt_brackets">Bracket:</label><select id="evt_brackets" class="button"></select>
                                                <input id="evt_newMatchBU" class="button" type="button" value="Add Match" />
                                            
                                            </div>
                                            <div id="match_container">
                                                <ul id="match_content"></ul>
                                            </div>
                                        </div>
                                    </article>
                                </div>
                                <div id="evt_teams_tmpl">
                                    <article class="evt_mainContent">
                                        <ul id="team_content"></ul>
                                    </article>
                                </div>
                                <div id="evt_athletes_tmpl">
                                    <article class="evt_mainContent">
                                        <ul id="athlete_content"></ul>
                                    </article>
                                </div>

                            
                        </script>

                        <script id="evt_matchTmpl" type="text/x-jquery-tmpl">
                            <li class="match">
                                <div class="check"><input class="Checkbox2" type="checkbox" /></div>
                                <div class="seeds"><h3>${hfname} ${hlname}</h3>,<span id="mth_grade"></span>(${hgrade})<br />${afname} ${alname} (${agrade})</div>
                                <div class="score"><span id="mth_winner"></span> ${hwinner} ${hwintype} ${htotal}<br />${awinner} ${awintype} ${atotal}</div>
                            </li>
                        </script>
                        
                    </div>

                    <!--New Event Tmpl------------------------------------------->
                    <script id="tsb_new_eventTmpl" type="text/x-jquery-tmpl">
                        <article id="evt_new_tmpl">
                        <ul>
                                <!-- New Event Tmpl - Name -->
                                <li id="evt_new_name" class="area">
                                    <h4 class="areaTitle">General</h4>
                                    <div class="hide">
                                        <p>Give this event a name that athletes and fans can see. </p>
                                        <label>Event Name:</label><input id="nevt_nameTB" type="text"/><br />
                                        
                                        <label for="nevt_styleTB">Wrestling Style:</label>
                                        <select id="nevt_styleTB">
                                            <option>Select One</option>
                                            <option value="folk">Folkstyle</option>
                                            <option value="free">Freestyle</option>
                                            <option value="greco">Greco</option>
                                        </select><br />

                                        <label for="nevt_typeTB">Event Type:</label>
                                        <select id="nevt_typeTB">
                                            <option>Select One</option>
                                            <option value="1">Individual Tournament</option>
                                            <option value="2">Dual Meet</option>
                                        </select><br />

                                        <label for="nevt_levelTB">Competition Level:</label>
                                        <select id="nevt_levelTB">
                                            <option>Select One</option>
                                            <option value="hs">High School</option>
                                            <option value="col">College</option>
                                        </select>

                                    </div>
                                </li>

                                <!-- New Event Tmpl - Location -->
                                <li id="evt_new_loc" class="area">

                                    <h4 class="areaTitle">Location</h4>
                                    
                                    <div class="hide">
                                        <div id="lkup_school">

                                            <div class="ls">
                                                <label for="nevt_lu_schName">School Name: </label>
                                            </div>
                                            <div class="rs">
                                                <input id="nevt_lu_schName" type="text"/>
                                            </div>

                                            <div class="ls">
                                                <label for="nevt_lu_state">State:</label>
                                            </div>
                                            <div class="rs">
                                                <select id="nevt_lu_state">
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
                                            </div>
                                            <div class="ls">
                                                <input id="nevt_lu_findBU" type="button" value="Find It" />
                                            </div>

                                            <div id="lkup_pick_school">
                                                <div class="mi">
                                                    <label for="nevt_lu_selSchool">Please select a school from the drop-down below. </label>
                                                </div>
                                                <br />
                                                <div class="ls">
                                                    <select id="nevt_lu_selSchool"></select>
                                                </div>
                                                <div class="rs">
                                                    <input id="nevt_lu_accept" type="button" value="Accept" />
                                                </div>
                                                <div id="Div3"></div>

                                            </div>
                                        </div>

                                        
                                        <div id="nevt_venue">
                                            <p>Enter the Venue name and address where this event will take place or <span id="lkup_schoolBU" class="spanLink">Lookup a School?</span></p>

                                            <div class="item">
                                                <label for="nevt_venNameTB">Venue Name:</label><br />
                                                <input id="nevt_venNameTB" class="addr" type="text"/>
                                            </div>

                                            <div class="item">
                                                <label for="nevt_venAddrTB">Address:</label><br />
                                                <input id="nevt_venAddrTB" class="addr" type="text"/>
                                            </div>


                                            <div>
                                                <div class="floatLT">
                                                    <label for="nevt_venCityTB">City:</label><br />
                                                    <input id="nevt_venCityTB" class="input" type="text"/>
                                                </div>
                                                <div class="floatLT">
                                                    <label for="nevt_venStateTB">State:</label><br />
                                                    <select id="nevt_venStateTB" class="select">
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
                                                </div>
                                                <div class="floatLT">
                                                    <label for="nevt_venZipTB">Zip:</label><br />
                                                    <input id="nevt_venZipTB" class="zip" type="text"/>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </li>
                                

                                <!-- New Event Tmpl - Sessions -->
                                <li id="evt_new_sessions" class="area">
                                    <h4 class="areaTitle">Schedule</h4>
                                    <div class="hide">
                                        <p>What date and time will this event start?</p>
                                        <label>Start Date:</label><input id="nevt_startDate" class="dateTime" type="text"/><label>Start Time:</label><input id="nevt_startTime" class="dateTime" type="text"/>
                                        <br /><br />
                                        <p>List the other sessions that will take place at the event.</p>
                                        <label>Type:</label><label>Date:</label><label>Time:</label><label>Title:</label>
                                        <ul id="nevt_ses_list">
                                            
                                        </ul>
                                        <span id="nevt_ses_addBU" class="spanLink">Add Session?</span>
                                  </div>          
                                </li>

                                <!-- New Event Tmpl - Division & Weights -->
                                <li id="evt_new_divisions" class="area">
                                    <h4 class="areaTitle">Divisions & Weights</h4>
                                    <div class="hide">
                                        <p>Use league sponsored divisons and weights or <span id="nevt_custDivisionsBU" class="spanLink">create your own</span>.</p>
                                        <label>Division Name:</label><input id="Text1" type="text"/>
                                        <ul id="nevt_div_hold"></ul>
                                        <p>Divisions & Weights used:</p>
                                        <ul id="nevt_div_cont"></ul>
                                    </div>
                                </li>
                            </ul>

                            <input id="addEvent" type="button" value="Create Event" />
                        </article>
                    </script>

                    <!--Event Settings---------------------------------------------->
                    <script id="tsb_evt_settingsTmpl" type="text/x-jquery-tmpl">
                        <article id="evt_settings">
                            <h3>General Event Settings</h3>
                            <ul>
                                <!-- Event Settings Tmpl - Name -->
                                <li id="evt_set_name" class="area">
                                    <h4 class="areaTitle">Event Name</h4>
                                    <div class="content">${evt_name}</div>
                                    <div class="editBu">(Edit)</div>
                                    <div class="hide">
                                        <p>Give this event a name that athletes and fans can see. </p>
                                        <label>Event Name:</label><input id="evtName_TB" type="text" value="${evt_name}" />
                                        <hr />
                                        <input id="saveNameBu" class="button" type="button" value="Save" /> or
                                            <span class="cancel spanLink">Cancel</span>
                                    </div>
                                </li>

                                <!-- Event Settings Tmpl - Location -->
                                <li id="evt_set_loc" class="area">

                                    <h4 class="areaTitle">Location</h4>
                                    <p class="content">
                                        ${evt_ven_name}, ${evt_addr} ${evt_city}, ${evt_state} ${evt_zip}
                                            
                                    </p>
                                    <div class="editBu">(Edit)</div>
                                    <div class="hide">
                                        <div id="locSchool">

                                            <div class="ls">
                                                <label for="schoolName">School Name: </label>
                                            </div>
                                            <div class="rs">
                                                <input id="schoolName" type="text"/>
                                            </div>

                                            <div class="ls">
                                                <label for="selState">State:</label>
                                            </div>
                                            <div class="rs">
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
                                            </div>
                                            <div class="ls">
                                                <input id="findSchool" type="button" value="Find It" />
                                            </div>

                                            <div id="pickSchool">
                                                <div class="mi">
                                                    <label for="selSchool">Please select a school from the drop-down below. </label>
                                                </div>
                                                <br />
                                                <div class="ls">
                                                    <select id="selSchool"></select>
                                                </div>
                                                <div class="rs">
                                                    <input id="acceptSchool" type="button" value="Accept" />
                                                </div>
                                                <div id="schAddressCont"></div>

                                            </div>
                                        </div>
                                        <div id="evtVenue">
                                            <p>Enter the Venue name and address where this event will take place or <span id="schLookupBu" class="spanLink">Lookup a School?</span></p>

                                            <div class="item">
                                                <label for="venName">Venue Name:</label><br />
                                                <input id="venName" class="addr" type="text" value="${evt_ven_name}" />
                                            </div>

                                            <div class="item">
                                                <label for="venAddress">Address:</label><br />
                                                <input id="venAddress" class="addr" type="text" value="${evt_addr}" />
                                            </div>


                                            <div>
                                                <div class="floatLT">
                                                    <label for="venCity">City:</label><br />
                                                    <input id="venCity" class="input" type="text" value="${evt_city}" />
                                                </div>
                                                <div class="floatLT">
                                                    <label for="venState">State:</label><br />
                                                    <select id="venState" class="select">
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
                                                </div>
                                                <div class="floatLT">
                                                    <label for="venZip">Zip:</label><br />
                                                    <input id="venZip" class="zip" type="text" value="${evt_zip}" />
                                                </div>
                                            </div>

                                            <div class="footer">
                                                <hr />
                                                <input id="saveVenueBu" class="button" type="button" value="Save" /> or
                                            <span class="cancel spanLink">Cancel</span>
                                            </div>

                                        </div>
                                    </div>
                                </li>

                                <!--Event Settings Tmpl - Date and Time Section -->
                                <li id="evt_set_sessions" class="area">
                                    <h4 class="areaTitle">Sessions</h4>
                                    <div class="content"></div>
                                    <div class="editBu">(Edit)</div>
                                    <div class="hide">
                                        <p>Sessions are used to indicate significant time points throughout the event.</p>
                                        <label>Start Date:</label><input id="evt_startDate" class="date" type="text" /><label>Start Time:</label><input id="evt_startTime" class="time" type="text" /><br />
                                        <label>Type:</label><label>Date:</label><label>Time:</label><label>Title:</label><br />
                                        <ul id="evtSessions">

                                        </ul>
                                        <span id="addSession" class="spanLink">Add Session?</span>
                                        <div id="newSession">
                                            
                                            <div class="floatLT">
                                                <select id="sessType" class="type">
                                                    <option>Session</option>
                                                    <option>Weigh-In</option>
                                                </select>

                                            </div>
                                            <div class="floatLT">

                                                <input id="sessDate" class="date" type="text" />
                                            </div>
                                            <div class="floatLT">
                                                <input id="sessTime" class="time" type="text" />
                                            </div>
                                            <div class="floatLT">
                                                <input id="sessTitle" class="title" type="text" />
                                            </div>
                                            <div class="floatLT">
                                                <span id="sessDelete" class="delete">X</span>

                                            </div>

                                        </div>



                                        <div class="footer">
                                            <hr />
                                            <input id="saveSessionBu" class="button" type="button" value="Save" />
                                            or
                                            <span class="cancel spanLink">Cancel</span>
                                        </div>
                                    </div>
                                </li>

                                <!-- Event Settings Tmpl - Division -->
                                <li id="evt_set_division" class="area">
                                    <h4 class="areaTitle">Divisions & Weights</h4>
                                    <div class="content"></div>
                                    <div class="editBu">(Edit)</div>
                                    <div class="hide">
                                        <p><span id="customGroups" class="spanLink">Use Custom Divisions & Weights?</span></p><br />
                                        <div id="evt_league" class="lt">
                                                                                        
                                        </div>
                                        <div id="evt_daw_container" class="floatLT">
                                            
                                        </div>
                                        

                                        <div class="footer">
                                            <hr />
                                            <input id="Button1" class="button" type="button" value="Save" /> or
                                            <span class="cancel spanLink">Cancel</span>
                                        </div>
                                    </div>
                                </li>

                                <!-- Event Settings Tmpl - Level -->
                                <li id="evt_set_clevel" class="area">
                                    <h4 class="areaTitle">Competition Level</h4>

                                    <div class="content">${levelID}</div>
                                    <div class="editBu">(Edit)</div>
                                    <div class="hide">
                                        <label for="selCompLvl">Competition Level:</label>
                                        <select id="selCompLvl">
                                            <option>Select One</option>
                                            <option value="hs">High School</option>
                                            <option value="col">College</option>
                                            <option value="open">Youth/Open</option>
                                        </select>

                                    
                                    <div class="item">
                                        <hr />
                                        <input id="Button3" class="button" type="button" value="Save" /> or
                                            <span class="cancel spanLink">Cancel</span>
                                    </div>

                                    </div>
                                </li>

                                <!-- Event Settings Tmpl - Style -->
                                <li id="evt_set_style" class="area">
                                    <h4 class="areaTitle">Wrestling Style</h4>

                                    <div class="content">${styleID}</div>
                                    <div class="editBu">(Edit)</div>
                                    <div class="hide">
                                        <label for="selStyle">Wrestling Style:</label>
                                        <select id="selStyle">
                                            <option>Select One</option>
                                            <option value="folk">Folstyle</option>
                                            <option value="free">Freestyle</option>
                                            <option value="greco">Greco</option>
                                        </select>
                                    
                                    <div class="footer">
                                        <hr />
                                        <input id="Button4" class="button" type="button" value="Save" /> or
                                            <span class="cancel spanLink">Cancel</span>
                                    </div>

                                    </div>
                                </li>

                                <!-- Event Settings Tmpl - Event Type -->
                                <li id="evt_set_type" class="area">
                                    <h4 class="areaTitle">Event Type</h4>

                                    <div class="content">${evt_type}</div>
                                    <div class="editBu">(Edit)</div>
                                    <div class="hide">
                                        <label for="selType">Event Type:</label>
                                        <select id="selType">
                                            <option>Select One</option>
                                            <option>Individual Tournament</option>
                                            <option>Dual Meet</option>
                                            <option>Dual Tournament</option>
                                        </select>
                                        <input id="BackStep1" type="button" value="Back" />
                                        <input id="ToStep3" type="button" value="Continue" />
                                    
                                    <div class="footer">
                                        <hr />
                                        <input id="Button5" class="button" type="button" value="Save" /> or
                                            <span class="cancel spanLink">Cancel</span>
                                    </div></div>
                                </li>

                            </ul>
                            <div id="newEvtStep3">
                                <input id="BackStep2" type="button" value="Back" />
                                
                            </div>
                        </article>
                    </script>
                    <script id="Script1" type="text/x-jquery-tmpl">
                        <p>
                            Event Location:
                    ${venName}<br />
                            ${venAddr}<br />
                            ${venCity}, ${venState} ${venZip}
                        </p>
                    </script>
        
                    <%--<script id="tsb_evt_settingsTmpl" type="text/x-jquery-tmpl">
                        <article id="evt_settings">
                            <div class="floatLT"><h4>New Event</h4>

                            </div>
                            <div id="newEvtStep1">
                                <br />
                                <div class="area">
                                    <div class="ls">Event Name:</div>
                                    <div class="rs">
                                        <input id="evtName_TB" type="text" />${eventName}</div>
                                </div>            
                                
                                <br />
                                <div class="area">
                                    
                                    <div id="evt_loc_rest">
                                        <h4>Location</h4>
                                        <p>
                                            ${evt_ven_name}<br />
                                            ${evt_addr}<br />
                                            ${evt_city}, ${evt_state} ${evt_zip}

                                        </p>

                                    </div>

                                    <div id="locSchool">

                                        <br />
                                        <div class="ls">
                                            <label for="schoolName">School Name: </label>
                                        </div>
                                        <div class="rs">
                                            <input id="schoolName" type="text" /></div>

                                        <div class="ls">
                                            <label for="selState">State:</label></div>
                                        <div class="rs">
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
                                        </div>
                                        <div class="ls">
                                            <input id="findSchool" type="button" value="Find It" /></div>




                                        <div id="pickSchool">
                                            <div class="mi">
                                                <label for="selSchool">Please select a school from the drop-down below. </label>
                                            </div>
                                            <br />
                                            <div class="ls">
                                                <select id="selSchool"></select></div>
                                            <div class="rs">
                                                <input id="acceptSchool" type="button" value="Accept" /></div>
                                            <div id="schAddressCont"></div>

                                        </div>
                                    </div>
                                    <div id="evtVenue">
                                        <div id="schLookupBu">Lookup a School?</div>
                                        <br />
                                        <div class="mi">
                                            <label for="venName">Venue Name:</label><br />
                                            <input id="venName" class="addr" type="text" /></div>

                                        <div class="mi">
                                            <label for="venAddress">Address:</label><br />
                                            <input id="venAddress" class="addr" type="text" /></div>


                                        <div class="mi">
                                            <div class="lt">
                                                <label for="venCity">City:</label><br />
                                                <input id="venCity" class="input" type="text" /></div>
                                            <div class="lt">
                                                <label for="venState">State:</label><br />
                                                <select id="venState" class="select">
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
                                            </div>
                                            <div class="lt">
                                                <label for="venZip">Zip:</label><br />
                                                <input id="venZip" class="input" type="text" /></div>
                                        </div>

                                    </div>
                                    <input id="venueSaveBu" class="button" type="button" value="Save" />or
                                    <span id="cancel" class="spanLink">Cancel</span>
                                </div>
                                <br />
                                <h4>Date and Time</h4>
                                <hr />
                                <ul id="dateTime">
                                    <li class="mi">
                                        <div class="lt">
                                            <label>Type:</label><br />
                                            <select id="Select1" class="select">
                                                <option>Session</option>
                                                <option>Weigh-In</option>
                                            </select>

                                        </div>
                                        <div class="lt"><label>Date:</label><br /><input class="dateTime" type="text" /></div>
                                        <div class="lt"><label>Time:</label><br /><input class="dateTime" type="text" /></div>
                                        <div class="lt"><label>Title:</label><br /><input class="input" type="text" /></div>
                                        <div class="lt"><br />X</div>
                                    </li>

                                </ul>
                                <div id="addDate" class="mi">Add Session?</div>
                                

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
                        </article>
                    </script>
                    <script id="Script1" type="text/x-jquery-tmpl">
                        <p>
                            Event Location:
                    ${venName}<br />
                            ${venAddr}<br />
                            ${venCity}, ${venState} ${venZip}
                        </p>
                    </script>--%>    

                    <!--<<< MEMBER TAB >>> -->
                    <div id="tab-3" class="center">


                        <!--Member/Admin View Toggle
                        <article id="tsb_mem_topNav">
                            <ul>
                                <li><a href="#mem_athlete">
                                    <h2>Athetes</h2>
                                </a></li>
                                <li><a href="#mem_admin">
                                    <h2>Admin Panel</h2>
                                </a></li>
                            </ul>
                        </article>-->

                        <!--Member Tab Main Content Container-->
                        <article id="tsb_mem_container"></article>

                        <!--Athlete List-->
                        <script id="tsb_mem_athleteViewTmpl" type="text/x-jquery-tmpl">
                                <div class="member">
                                    <a href="${tmMemberID}"></a>
                                    <img src="" alt="" /><h4>${fName} ${lName}</h4>
                                    <br />
                                </div>
                        </script>

                        <!--Athlete Detailed-->
                        <script id="tsb_mem_athleteTmpl" type="text/x-jquery-tmpl">
                            <article class="tsb_mem_toolbar">
                                
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

                        <!--Non-Athlete Members Detailed-->
                        <script id="tsb_mem_adminTmpl" type="text/x-jquery-tmpl">
                            <%--<article class="tsb_mem_toolbar">

                            </article>
                            <div class="mem_topContent">
                                <img src="#" alt="" />
                                

                            </div>--%>

                            <!--Admin content-->
                            <div class="mem_mainContent">
                                <div class="area">
                                <div id="basicInfo">
                                    <h2 id="notNewName" class="editableTB">${fName} ${lName}</h2>
                                    <input id="newMemName" type="text" />
                                    <input id="isAthleteCB" type="checkbox" title="athlete" /><label for="isAthleteCB">Athlete</label><input id="isCoachCB" type="checkbox" /><label for="isCoachCB">Coach</label>
                                </div>
                                    </div>
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
                                </div>
                                <br />

                                <div class="area">
                                    <h4>Notes</h4>
                                    <input id="Text2" type="text" />
                                </div>
                            </div>


                        </script>

                        <!--Admin List-->
                        <script id="tsb_mem_adminViewTmpl" type="text/x-jquery-tmpl">
                            <div class="memAdminView">
                                <div>
                                    <a href="${tmMemberID}"></a>
                                    <img src="" alt="" /><h4>${fName} ${lName}</h4>
                                    <span id="athlete"></span><span id="coach"></span><span id="admin"></span><span id="linkStatus"></span>
                                </div>

                            </div>
                        </script>
                    </div>

                    <!--<<< ARCHIVES TAB >>>
                    <div id="tab-4" class="center">
                        hi
                        <article id="tsb_arch_top">
                            <select id="arch_season">

                            </select>
                        </article>
                        
                    </div>-->
                
                </div> <!--tabs - ending tag-->
            </div> <!-- content div - ending tag-->

            <!-- Statbook Left Navigation-->
            <div id="tabNav" class="left">
                <nav>
                    <ul>
                        <!--<li><a href="#tab-1">Dashboard</a></li>-->
                        <li><a href="#tab-2">Events</a></li>
                        <li><a href="#tab-3">Members</a></li>
                        <!--<li><a href="#tab-4">Archives</a></li>-->
                    </ul>
                </nav>
            </div>

        </div><!-- pageWrap - ending tag -->
    </div> <!-- scroll - ending tag -->
      
    <div id="dialog-overlay"></div>
    <div id="dialog-box">
        <div class="dialog-content">
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

    <script id="addTeamTemp" type="text/x-jquery-tmpl">
        <p>Add a new team to this event.</p><span id="ntm_alert"></span>
        <label for="ntm_name">Team Name:</label><input id="ntm_name" type="text" /><br />
        <label for="ntm_abrv">Team Abriviation:</label><input id="ntm_abrv" type="text" /><br />
        <label for="ntm_city">Team City:</label><input id="ntm_city" type="text" /><br />
        <label for="ntm_state">Team State:</label><select id="ntm_state">
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

                                                </select><br />
        <input id="ntm_addTeamBU" class="button" type="button" value="Add Team" />
        <ul id="ntm_addCont"></ul>
    </script>
    
    <script id="addAthleteTemp" type="text/x-jquery-tmpl">
        <p>Add a new team to this event.</p><span id="nath_alert"></span>
        <label for="nath_fname">First Name:</label><input id="nath_fname" type="text" /><br />
        <label for="nath_lname">Last Name:</label><input id="nath_lname" type="text" /><br />
        <label for="nath_grade">Grade:</label><select id="nath_grade">
                <option value="0">Select One</option>
                <option value="9">FR</option>
                <option value="10">SO</option>
                <option value="11">JR</option>
                <option value="12">SR</option>
            </select><br />
        <label for="nath_team">Team (optional):</label><select id="nath_team"><option value="0">Unattached</option></select><br />
        <input id="nath_addAthleteBU" class="button" type="button" value="Add Athlete" />
        <ul id="nath_addCont"></ul>
    </script>
    
        <script id="NewBracketTemp" type="text/x-jquery-tmpl">
            <div id="Div1">
            
            <div id="Div2">
                <label for="bkts_title">Bracket Title:</label><input id="Text3" type="text" /><br />
                <label for="bkts_styleDD">Bracket Style:</label><select id="Select1">
                        <option>Select One</option>
                        <option value="TMT">Tournament</option>
                        <option value="RR">Round Robin</option>
                        <option value="MO">Matches Only</option>
                </select><br />
                
                <label for="bkts_divisionDD">Division:</label><select id="Select2"></select><br />
                <label for="bkts_classDD">Weight Class:</label><select id="Select3"></select><br />
                
                <div id="Div4">
                    <label for="bkts_sizeDD">Number of Participants:</label><select id="Select4">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                        </select><br />
                
                    <label for="bkts_placesDD">Number of Placewinners:</label><select id="Select5">
                            <option>Select One</option>
                    </select><br />
                    
                </div>
                <label for="bkts_typeDD">Bracket Type:</label><select id="Select6"></select>
            </div>
            
        </div>

        </script>

    <script id="bracketSetupTemp" type="text/x-jquery-tmpl">
        <div id="bkts_content">
            
            <div id="bkts_bracketForm">
                <h4>Bracket Title</h4><input id="bkts_titleTB" type="text" /><br />
                <br />
                <h4>Bracket Details</h4>
                <div id="bkts_detailBox">
                    <label for="bkts_styleDD">Bracket Style:</label><span id="bkt_styleTXT"></span><br />
                    <label for="bkts_divisionDD">Division:</label><span id="bkts_divisionTXT"></span><br />
                    <label for="bkts_classDD">Weight Class:</label><span id="bkts_classTXT"></span><br />
                    <label for="bkts_typeDD">Bracket Type:</label><span id="bkts_typeTXT"></span>
                    <input id="editBktDetailsBu" type="button" value="Change" />
                </div>

                <div id="bkts_editDetails">
                    <label for="bkts_styleDD">Bracket Style:</label><select id="bkts_styleDD">
                        <option>Select One</option>
                        <option value="TMT">Tournament</option>
                        <option value="RR">Round Robin</option>
                        <option value="MO">Matches Only</option>
                    </select><br />
                    
                    <label for="bkts_divisionDD">Division:</label><select id="bkts_divisionDD"></select><br />
                    <span class="disable"><label id="bkts_classLBL" for="bkts_classDD">Weight Class:</label><select id="bkts_classDD"></select></span><br />

                    <div id="bkts_typeOptions">
                        <label for="bkts_sizeDD">Number of Participants:</label><select id="bkts_sizeDD">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                        </select><br />
                
                        <label for="bkts_placesDD">Number of Placewinners:</label><select id="bkts_placesDD">
                                <option>Select One</option>
                        </select><br />
                        <label for="bkts_typeDD">Bracket Type:</label><select id="bkts_typeDD"></select><br />
                        
                    </div>
                    
                    <input id="editBktSaveBu" type="button" value="Save" />
                </div>
            </div>
            <div id="bkts_athleteSeeds">
                <h3>Wrestlers:</h3><br />
                <ul id="bkts_athletes"></ul><br />
                <input id="bkts_addAthleteBU" type="button" value="Add Wrestler" /><br />
                

            </div>
        </div>
    </script>

        <%--     <script id="newEvtTemp" type="text/x-jquery-tmpl">

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
            </script>--%>

            <script id="schAddressTemp" type="text/x-jquery-tmpl">
                <p>
                    Event Location:
                    ${venName}<br />
                    ${venAddr}<br />
                    ${venCity}, ${venState} ${venZip}
                </p>
            </script>
            <input id="closeBu"  type="button" value="Close" />
        </div>
    </div>
  
 
    
    <!---------------<<< Scripts >>>----------------->
    <script type="text/javascript">
        $(document).ready(function () {
            
            $(window).load(function () {  });

            $("#backBu").click(function () {
                window.location.replace("../user/tmFanPage.aspx")
            });

            var tmMemberID = ""
            var teamID = localStorage.team_id
            var tm_seasonID =""
            var adm_status = ""

            // Load team
            $.ajax({
                type: "POST",
                url: "tmStatbook.aspx/getTeam",
                data: "{'teamID':'" + localStorage.team_id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $(data.d).each(function (i, item) {
                        $('#team').text(item.tm_name)
                        tm_seasonID = item.tm_cur_season
                    });
                }
            });

            $.ajax({
                type: "POST",
                url: "tmStatbook.aspx/getAdminStatus",
                data: "{'teamID':'" + teamID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $(data.d).each(function (i, item) {
                        adm_status = item.adm_status
                    });

                }
            });

            //Tab Navigation
            $('#tabs div').hide();
            $('#tab-2').show();
            $('#tabNav ul li:first').addClass('active');
           
            $('#tabNav ul li a').click(function () {
                $('#tabNav ul li').removeClass('active');
                $(this).parent().addClass('active');
                var currentTab = $(this).attr('href');
                if (currentTab == "#tab-1") {
                } else if (currentTab == "#tab-2") {
                    getTeamEvents()
                } else if (currentTab == "#tab-3") {
                    loadMembersTab()

                } else if (currentTab == "#tab-4") {
                    getSeasons()
                }
                $('#tabs div').hide();
                $(currentTab).show();
                
                
                return false;
            });


            function showModal() {
                $('#newTeamModal').fadeIn(slow);
            }



            //-----------------------------------------------------------------------------------
            //<<<<< EVENTS Tab Functions >>>>>
            //-----------------------------------------------------------------------------------
            //Declare Global Variables
            var eventID = ""
            var evt_container = $('#tmb_evt_container')
            var evt_mainContent
            var dialogMsg = $('#dialog-message')
            
            function getTeamEvents() {

                //ToolBar-----------------------------
                //Reset Toolbar and append event buttons
                tool_container.empty()          
                $("#tsb_tool_event").tmpl().appendTo(tool_container);

                //Check Admin Status of Member
                if (adm_status == "A") {
                   $('#newEventBu').show();
                   $('#newEventBu').click(function () {
                       evt_container.empty();
                       getEventSettings('new')
                   });

                }
                //------------------------------------


                //Load the teams current season events
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamEvents",
                    data: "{'teamSeasonID':'" + tm_seasonID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data, status) {
                        //alert(data.d);
                        evt_container.empty();
                        $("#tsb_evt_listViewTmpl").tmpl().appendTo(evt_container);


                        
                        var event_content = $('#tsb_event_list')
                        event_content.empty()
                        $(data.d).each(function (i, item) {
                            var location = ""
                            if (item.evt_city != "" && item.evt_state != "") {
                                location = item.evt_city + ", " + item.evt_state
                            }
                            /*format event level status*/
                            var level = ""
                            if (item.levelID == "hs") {
                                level = "High School"
                            }
                            /*format event style status*/
                            var style = ""
                            if (item.styleID == "folk") {
                                style = "Folkstyle"
                            } else if (item.styleID == "free") {
                                style = "Freestyle"
                            }

                            event_content.append(
                                '<li class="evt_listItem">' +
                                    '<div class="check"><input type="checkbox" /></div>' +
                                    
                                    '<div class="title"><h4>'+item.evt_name+'<a href="'+item.eventID+'" /></h4><br />'+location+'</div>' +
                                    '<div class="details">' + style + '<br /> ' + level + '</div>' +
                                    '<div class="startDT">' + item.startDate + '</div>' +
                                '</li>'
                            )

                        });

                        //Get the selected event
                        var div = evt_container.find('.evt_listItem');
                        div.bind('mouseover', function (event) {
                            div.removeClass('row-highlight');
                            $(this).addClass('row-highlight');
                        });

                        div.bind('click', function () {
                            eventID = $(this).find('a').attr('href');
                            window.localStorage.setItem('event_id', eventID)
                            evt_container.empty();
                            //alert(eventID);
                            loadEventDetails(eventID)

                        });


                    }
                });

                var match_tmpl = ""
                var team_tmpl = ""
                var athlete_tmpl = ""
            }
            var x_evt_type = ""

            //Load all events for the Event Detail page
            function loadEventDetails(_eventid) {

                //ToolBar-----------------------------
                //Reset Toolbar and append event buttons
                tool_container.empty()
                $("#tsb_tool_event").tmpl().appendTo(tool_container);

                $('#newEventBu').hide();
                
                $("#evtBackBu").show();
                $('#evtBackBu').click(function () {
                    evt_container.empty();
                    getTeamEvents();
                });

                //Check Admin Status of Member
                if (adm_status == "A") {
                    $('#evt_settingsBu').show();
                    $('#evt_settingsBu').click(function () {
                        evt_container.empty();
                        getEventSettings(_eventid)
                    });
                }
                //------------------------------------

                

                //Load the event details
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getEventDetails",
                    data: "{'eventID':'" + _eventid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        
                        
                        $("#tsb_evt_detailTmpl").tmpl(data.d).appendTo(evt_container);
                        
                        //Set tmpl variables
                        match_tmpl = $('#evt_matches_tmpl')
                        team_tmpl = $('#evt_teams_tmpl')
                        team_tmpl.hide();
                        athlete_tmpl = $('#evt_athletes_tmpl')
                        athlete_tmpl.hide();

                        $(data.d).each(function (i, mem) {
                            $('#eventName').val(mem.evt_name)
                            x_evt_type = mem.evt_type
                        });


                        

                        $(data.d).each(function (i, item) {
                            //$('#evt_date').text(Date.parse(item.startDate).toString("dddd, MMMM dd, yyyy"))
                            //$('#evt_stTime').text(Date.parse(item.startTime).toString("h:mm"))
                        });

                        //Initial State of Event Content Nav
                        setupMatchTab(eventID);
                        
                        //Event Details SubNav Tab
                        $('#evt_navDDL').change(function () {
                            
                            var activeEvtNav = $('#evt_navDDL option:selected').val()

                            if (activeEvtNav == "#evt_teams") {
                                getEventTeams(eventID);
                            } else if (activeEvtNav == "#evt_athletes") {
                                getEventAthletes(eventID);
                            } else if (activeEvtNav == "#evt_matches") {
                                setupMatchTab(eventID)
                            }
                        })

                        //$('#evt_contentNav ul li').click(function () {
                        //    var activeEvtNav = $(this).find('a').attr('href');

                        //    if (activeEvtNav == "#evt_teams") {
                        //        getEventTeams(eventID);
                        //    } else if (activeEvtNav == "#evt_athletes") {
                        //        getEventAthletes(eventID);
                        //    } else if (activeEvtNav == "#evt_matches") {
                        //        setupMatchTab(eventID)
                        //    }

                        //});
                    }
                });

                
            }//loadEventDetails - end tag

            var x_evt_class = ""
            
            //Event Details - Event Match tab               
            function setupMatchTab(_eventID) {
                //load the divisions of an event
                var evt_divisions = $('#evt_division')
                
                evt_divisions.empty();
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getEventDivisions",
                    data: "{'eventID':'" + eventID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data, status) {
                        $(data.d).each(function (i, item) {
                            
                            evt_divisions.append(

                                $('<option/>', {
                                    value: item.divisionsID,
                                    text: item.div_name
                                })
                                );

                        });
                            
                        getEventBrackets(_eventID)
                    }
                })
                
                //load the event brackets for a division
                function getEventBrackets(eventID) {
                                
                    var evt_brackets = $('#evt_brackets')
                    evt_brackets.empty();
                             
                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getEventBrackets",
                        data: "{'eventID':'" + eventID + "', 'divisionID':'" + $('#evt_division  option:selected').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data, status) {
                            
                            if (data.d == "") {
                                $('#bkt_container').hide();
                                $('#bkt_messege').empty();
                                $('#bkt_messege').show();
                                $('#bkt_messege').append("<p>There are currently no brackets for this division.</p>")

                            } else {
                                $('#bkt_messege').hide();
                                $('#bkt_container').show();
                                $(data.d).each(function (i, item) {
                                    evt_brackets.append(
                                        $('<option/>', {
                                            value: item.bracketID,
                                            text: item.bkt_title
                                        })
                                    );
                                });
                                if (x_evt_type == "1") { 
                                    getEventMatches() 
                                } else { 
                                    getDualMatches()
                                
                                }
                            }
                            

                            

                            

                        }
                    })

                }
                //load the matches of a bracket
                function getEventMatches() {
                    $('#evt_newTeamBU').hide();
                    $('#evt_newAthleteBU').hide();
                    $('#evt_bkt_addBU').show();
                    
                    $('#bracketSeedsBU').show();
                    $('#evt_division').show();
                    $('#bracketSetupBU').show();
                    $('#evt_bkt_moreDDL').show();
                    bracketSetupBU
                    team_tmpl.hide()
                    athlete_tmpl.hide()
                    match_tmpl.show()

                    //Load all matches for the selected event
                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getEventMatches",
                        data: "{'bracketID':'" + $('#evt_brackets option:selected').val() + "', 'eventID':'" + eventID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data, status) {
                            
                            var match_content = $('#match_content')
                            match_content.empty()
                            $(data.d).each(function (i, item) {

                                //Format athlete grade
                                var hgrade = fmtGrade(item.hgrade)
                                var agrade = fmtGrade(item.agrade)
                                function fmtGrade(grade) {
                                    if (grade == 9) {
                                        result = "Freshman"
                                    } else if (grade == 10) {
                                        result = "Sophomore"
                                    }
                                    else if (grade == 11) {
                                        result = "Junior"
                                    }
                                    else if (grade == 12) {
                                        result = "Senior"
                                    }
                                    return result;
                                }
                                //Format athlete score
                                var hscore = fmtScore(item.htotal)
                                var ascore = fmtScore(item.atotal)
                                function fmtScore(score) {
                                    if (score == 0) {
                                        result = "0"
                                    } else if (score == "") {
                                        result = 0
                                    }
                                    else {
                                        result = score
                                    }
                                    return result;
                                }

                                var hfallTime = fmtFallTime(item.hfallTime)
                                var afallTime = fmtFallTime(item.afallTime)
                                function fmtFallTime(time) {
                                    if (time == "") {
                                        result = ""
                                    } else {
                                        result = time
                                    }
                                    return result;
                                }

                                //Identify the match winner
                                var hwinText = ""
                                var awinText = ""
                                if (item.hwinner == "Y") {
                                    if (item.hwintype == "DEC") { hwinText = "Win By Decision" }
                                    else if (item.hwintype == "MAJ") { hwinText = "Win By Major" }
                                    else if (item.hwintype == "TEC") { hwinText = "Win By Tech. Fall" }
                                    else if (item.hwintype == "WBF") { hwinText = "Win By Fall" }
                                    else if (item.hwintype == "FF") { hwinText = "Win By Forfeit" }
                                    else if (item.hwintype == "DEF") { hwinText = "Win By Default" }
                                    else if (item.hwintype == "DQ") { hwinText = "Win By DQ" }
                                }

                                if (item.awinner == "Y") {
                                    if (item.awintype == "DEC") { awinText = "Win By Decision" }
                                    else if (item.awintype == "MAJ") { awinText = "Win By Major" }
                                    else if (item.awintype == "TEC") { awinText = "Win By Tech. Fall" }
                                    else if (item.awintype == "WBF") { awinText = "Win By Fall" }
                                    else if (item.awintype == "FF") { awinText = "Win By Forfeit" }
                                    else if (item.awintype == "DEF") { awinText = "Win By Default" }
                                    else if (item.awintype == "DQ") { awinText = "Win By DQ" }
                                }



                                match_content.append(
                                    '<li class="match">'+
                                        '<div class="check"><input class="Checkbox2" type="checkbox" /></div>'+
                                        '<div class="seeds"><h3>' + item.hfname + " " + item.hlname + '</h3><span id="hgrade">, ' + hgrade + '</span><br /><h3>' + item.afname + " " + item.alname + '</h3>, ' + agrade + '</div>' +
                                        '<div class="winText"><span id="hwinner">' + hwinText + '</span><br /><span id="awinner">' + awinText + '</span></div>' +
                                        '<div class="time"><h3>' + hfallTime + '</h3><h3>' + afallTime + '</h3></div>' +
                                        '<div class="score"><h3>' + hscore + '</h3><br /><h3>' + ascore + '</h3></div>' +
                                    '</li>'
                                )

                            });
                            //$("#evt_matchTmpl").tmpl(data.d).appendTo(match_content);
                            
                        }
                    });
                }

                function getDualMatches() {
                    $('#evt_newTeamBU').hide();
                    $('#evt_newAthleteBU').hide();
                    $('#evt_bkt_addBU').show();

                    $('#bracketSeedsBU').hide();
                    $('#evt_division').show();
                    $('#bracketSetupBU').show();
                    $('#evt_bkt_moreDDL').show();
                    bracketSetupBU
                    team_tmpl.hide()
                    athlete_tmpl.hide()
                    match_tmpl.show()

                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getEventMatches",
                        data: "{'bracketID':'" + $('#evt_brackets option:selected').val() + "', 'eventID':'" + eventID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data, status) {
                            
                            var match_content = $('#match_content')
                            match_content.empty()

                            var homeTeamScore = 0;
                            var awayTeamScore = 0;

                            $(data.d).each(function (i, item) {

                                //Format athlete grade
                                var hgrade = fmtGrade(item.hgrade)
                                var agrade = fmtGrade(item.agrade)
                                function fmtGrade(grade) {
                                    if (grade == 9) {
                                        result = "Freshman"
                                    } else if (grade == 10) {
                                        result = "Sophomore"
                                    }
                                    else if (grade == 11) {
                                        result = "Junior"
                                    }
                                    else if (grade == 12) {
                                        result = "Senior"
                                    } else { result = "NA" }
                                    return result;
                                }
                                //Format athlete score
                                var hscore = fmtScore(item.htotal)
                                var ascore = fmtScore(item.atotal)
                                function fmtScore(score) {
                                    if (score == 0) {
                                        result = 0
                                    } else if (score == "") {
                                        result = 0
                                    }
                                    else {
                                        result = parseInt(score, 10)
                                    }
                                    return result;
                                }

                                var hfallTime = fmtFallTime(item.hfallTime)
                                var afallTime = fmtFallTime(item.afallTime)
                                function fmtFallTime(time) {
                                    if (time == "") {
                                        result = ""
                                    } else {
                                        result = time
                                    }
                                    return result;
                                }

                                //Identify the match winner
                                var hwinText = ""
                                var awinText = ""
                                if (item.hwinner == "Y") {
                                    if (item.hwintype == "DEC") { hwinText = "Win By Decision" }
                                    else if (item.hwintype == "MAJ") { hwinText = "Win By Major" }
                                    else if (item.hwintype == "TEC") { hwinText = "Win By Tech. Fall" }
                                    else if (item.hwintype == "WBF") { hwinText = "Win By Fall" }
                                    else if (item.hwintype == "FF") { hwinText = "Win By Forfeit" }
                                    else if (item.hwintype == "DEF") { hwinText = "Win By Default" }
                                    else if (item.hwintype == "DQ") { hwinText = "Win By DQ" }
                                }

                                if (item.awinner == "Y") {
                                    if (item.awintype == "DEC") { awinText = "Win By Decision" }
                                    else if (item.awintype == "MAJ") { awinText = "Win By Major" }
                                    else if (item.awintype == "TEC") { awinText = "Win By Tech. Fall" }
                                    else if (item.awintype == "WBF") { awinText = "Win By Fall" }
                                    else if (item.awintype == "FF") { awinText = "Win By Forfeit" }
                                    else if (item.awintype == "DEF") { awinText = "Win By Default" }
                                    else if (item.awintype == "DQ") { awinText = "Win By DQ" }
                                }

                                //Format Names and Identify Open Weights
                                var hname = ""
                                if (item.hfname == "" && item.hlname == "") {
                                    hname = "Open"
                                } else {
                                    hname =  item.hfname + " " + item.hlname
                                }

                                var aname = ""
                                if (item.afname == "" && item.alname=="") {
                                    aname = "Open"
                                } else {
                                    aname = item.afname + " " + item.alname
                                }

                                //Calculate team score
                                var hTmPtValue = fmtTmPoints(item.htmPoints)
                                var aTmPtValue = fmtTmPoints(item.atmPoints)

                                function fmtTmPoints(score) {
                                    if (score == 0) {
                                        result = 0
                                    } else if (score == "") {
                                        result = 0
                                    }
                                    else {
                                        result = parseInt(score, 10)
                                    }
                                    return result;
                                }

                                homeTeamScore += hTmPtValue
                                awayTeamScore += aTmPtValue




                                match_content.append(
                                    '<li class="match">'+
                                        '<div class="check"><input class="Checkbox2" type="checkbox" /></div><div class="weight"><h3>'+item.bout_className+'</h3></div>'+
                                        '<div class="seeds"><h3>' + hname + '</h3><span id="hgrade">, ' + hgrade + '</span><span id="hteam">, ' + item.hteam + '</span><br /><h3>' + aname + '</h3><span id="agrade">, ' + agrade + '</span><span id="ateam">, ' + item.ateam + '</span></div>' +
                                        '<div class="winText"><span id="hwinner">' + hwinText + '</span><br /><span id="awinner">' + awinText + '</span></div>' +
                                        '<div class="time"><h3>' + hfallTime + '</h3><h3>' + afallTime + '</h3></div>' +
                                        '<div class="score"><h3>' + hscore + '</h3><br /><h3>' + ascore + '</h3></div>' +
                                        '<div class="tmPoints"><h3>' + hTmPtValue + '</h3><br /><h3>' + aTmPtValue + '</h3></div><div><h3>' + homeTeamScore + '</h3><br /><h3>' + awayTeamScore + '</h3></div>' +
                                    '</li>'
                                )

                            });
                            //$("#evt_matchTmpl").tmpl(data.d).appendTo(match_content);
                            
                        }
                    });
                }
                


                $('#evt_division').change(function () {
                    getEventBrackets(eventID)
                });
                $('#evt_brackets').change(function () {
                    getEventMatches()
                });

                            
                //Popup setting for an event bracket
                $('#bracketSetupBU').click(function () {
                    var curDivision = $('#evt_division  option:selected').val();
                    var _bracketID = $('#evt_brackets option:selected').val();

                    
                    var bkt_styleTXT = ""

                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getBracketInfo",
                        data: "{'bracketID':'" + _bracketID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data, status) {
                            //Show text only
                            $(data.d).each(function (i, item) {

                                $('#bkts_titleTB').val(item.bkt_title)

                                if (item.evtd_classOpt == 'N') {
                                    $('#bkts_classLBL').css("background-color", "grey")
                                    $('#bkts_classDD').css("disabled","disabled")
                                }

                                $('#bkts_classTXT').text(item.bkt_className)
                                $('#bkts_divisionTXT').text(item.bkt_divisionName)

                                if (item.bkt_styleID == 'TMT') {
                                    bkt_styleTXT = "Tournament"
                                } else if (item.bkt_styleID == 'RR') {
                                    bkt_styleTXT = "Round Robin"
                                } else {
                                    bkt_styleTXT = "Matches Only"
                                }
                                $('#bkt_styleTXT').text(bkt_styleTXT)

                                $('#bkts_typeTXT').text(item.btp_title)

                                //Edit Bracket Details
                                //bkts_classDD.val(item.bkt_classID).attr('selected', 'selected');
                                //bkts_divisionDD.val(item.bkt_divisionID).attr('selected', 'selected');

                                


                            })

                        }
                    })
                            
                    dialogMsg.empty();
                    $("#bracketSetupTemp").tmpl().appendTo(dialogMsg);

                    $('#editBktDetailsBu').click(function () {
                        var bkts_divisionDD = $('#bkts_divisionDD')
                        var bkts_classDD = $('#bkts_classDD')

                        $('#bkts_detailBox').hide();
                        $('#bkts_editDetails').show();
                        $(function bktClassAndDivision() {
                            $.ajax({
                                type: "POST",
                                url: "tmStatbook.aspx/getEventDivisions",
                                data: "{'eventID':'" + eventID + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data, status) {
                                    $(data.d).each(function (i, item) {
                                        bkts_divisionDD.empty();
                                        bkts_divisionDD.append(

                                            $('<option/>', {
                                                value: item.divisionsID,
                                                text: item.div_name
                                            })
                                        );
                                        bkts_divisionDD.val(curDivision).attr('selected', 'selected');

                                    });

                                    //load the event brackets for a division
                                    $.ajax({
                                        type: "POST",
                                        url: "tmStatbook.aspx/getEventBrackets",
                                        data: "{'eventID':'" + eventID + "', 'divisionID':'" + $('#bkts_divisionDD  option:selected').val() + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (data, status) {

                                            $(data.d).each(function (i, item) {
                                                bkts_classDD.append(
                                                    $('<option/>', {
                                                        value: item.bracketID,
                                                        text: item.bkt_title
                                                    })
                                                );
                                            });
                                            alert(curBracket)
                                            bkts_classDD.val(curBracket).attr('selected', 'selected');
                                        }
                                    })


                                    //$.ajax({
                                    //    type: "POST",
                                    //    url: "tmStatbook.aspx/getEventClasses",
                                    //    data: "{'divisionID':'" +  + "'}",
                                    //    contentType: "application/json; charset=utf-8",
                                    //    dataType: "json",
                                    //    success: function (data, status) {
                                    //        $(data.d).each(function (i, item) {
                                    //            bkts_classDD.append(
                                    //                $('<option/>', {
                                    //                    value: item.eventClassID,
                                    //                    text: item.evtc_name
                                    //                })
                                    //            );
                                    //        });
                                        

                                    //    }
                                    //})
                                
                                }
                            })

                        })
                        $('#bkts_styleDD').change(function () {
                            var bktStyleDD = $('#bkts_styleDD option:selected').val()
                            if (bktStyleDD == 'TMT') {
                                $("#bkts_typeOptions").show();
                            } else if (bktStyleDD == 'RR') {
                                $("#bkts_typeOptions").show();
                            } else {
                                $("#bkts_typeOptions").hide();
                            }
                        });
                    })
                    $('#editBktSaveBu').click(function () {
                        $('#bkts_detailBox').show();
                        $('#bkts_editDetails').hide();
                    })
                    
                    

 

                    var bkts_athletes = $("#bkts_athletes")

                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getBracketAthletes",
                        data: "{'bracketID':'" + _bracketID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data, status) {
                            bkts_athletes.empty()

                            $(data.d).each(function (i, item) {
                                if (item.eventAthleteID == "") {
                                    bkts_athletes.append('<li>' + item.bkts_seednumber + " BYE" + '</li>')
                                } else {
                                    bkts_athletes.append(
                                        '<li>' + item.bkts_seednumber + " " + item.evta_fname + ' ' + item.evta_lname + " (" + item.evta_grade + ") " + item.evta_team + '</li>')
                                }
                            });

                        }
                    })


                    popup();
                })

                $('#evt_newMatchBU').click(function () {
                    alert('match')
                })

                $('#evt_bkt_addBU').click(function () {
                    $("#NewBracketTemp").tmpl().appendTo(dialogMsg);
                    popup()
                })
                            
   
                        
            }

            //Event Details - Event Teams tab 
            function getEventTeams(eventID) {

                    $('#evt_newAthleteBU').hide();
                    $('#evt_bkt_addBU').hide();
                    $('#evt_division').hide();
                    $('#bracketSetupBU').hide();
                    $('#evt_bkt_moreDDL').hide();
                    $('#evt_newTeamBU').show();
                    

                    athlete_tmpl.hide()
                    match_tmpl.hide()
                    team_tmpl.show()

                    //Load all the Teams participating in the selected event
                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getEventTeams",
                        data: "{'eventID':'" + eventID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            $(data.d).each(function (i, item) {

                                var team_content = $('#team_content')
                                team_content.empty()
                                $(data.d).each(function (i, item) {
                                    team_content.append(
                                            '<li class="team">' +
                                                '<span class="check"><input type="checkbox" /></span>' +
                                                '<span><h4>' + item.tm_name + '</h4>, ' + item.tm_name_abrv + '</span>' +
                                                '<span>' + item.tm_city + ' ' + item.tm_state + '</span>' +
                                                '<span>' + item.eventTeamID + '</span>' +
                                            '</li>'
                                            )
                                });
                            });
                        }
                    });

                    $('#evt_newTeamBU').click(function () {
                        dialogMsg.empty();
                        $("#addTeamTemp").tmpl().appendTo(dialogMsg);
                        popup();
                        var ntm_name = $('#ntm_name')
                        var ntm_abrv = $('#ntm_abrv')
                        var ntm_city = $('#ntm_city')
                        var ntm_state = $('#ntm_state')

                        $('#ntm_addTeamBU').click(function () {
                            var addteam = "{'eventID':'" + eventID + "', 'etm_state':'" + $('#ntm_state option:selected').val() + "', 'etm_name':'" + ntm_name.val() + "', 'etm_city':'" + ntm_city.val() + "', 'etm_abrv':'" + ntm_abrv.val() + "'}"

                            $.ajax({
                                type: "POST",
                                url: "tmStatbook.aspx/addNewEvtTeam",
                                data: addteam,
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (ses, status) {
                                    $('#ntm_alert').html('Team was added.')
                                    $('#ntm_addCont').append("<li>" + ntm_name.val() + "(" + ntm_abrv.val() + ") " + ntm_city.val() + ", " + $('#ntm_state option:selected').val() + "</li>")
                                    ntm_name.val("")
                                    ntm_abrv.val("")
                                    ntm_city.val("")
                                }
                            })
                        })

                    })

                        
            }

            

            //Event Details - Event Athlete tab 
            function getEventAthletes(eventID) {

                $('#evt_newTeamBU').hide();
                $('#evt_bkt_addBU').hide();
                $('#evt_division').hide();
                $('#bracketSetupBU').hide();
                $('#evt_bkt_moreDDL').hide();
                $('#evt_newAthleteBU').show();
                    

                match_tmpl.hide()
                team_tmpl.hide()

                athlete_tmpl.show()

                //Load all the Teams participating in the selected event into the drop down box
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getEventAthletes",
                    data: "{'eventID':'" + eventID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        var athlete_content = $('#athlete_content')
                        athlete_content.empty()

                        $(data.d).each(function (i, mem) {
                            athlete_content.append(
                                '<li class="athlete"><span class="check"><input type="checkbox" /></span>'+
                                    '<span><h4>' + mem.evta_fname + ' ' + mem.evta_lname + '</h4>, '+mem.evta_grade+' </span>'+
                                    '<span>'+ mem.evta_team + '</span></li>')
                        });
                    }
                });

                //New athlete button click
                $('#evt_newAthleteBU').click(function () {
                    dialogMsg.empty();
                    $("#addAthleteTemp").tmpl().appendTo(dialogMsg);

                    var nath_team = $('#nath_team')
                    var nath_fname = $('#nath_fname')
                    var nath_lname = $('#nath_lname')

                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getEventTeams",
                        data: "{'eventID':'" + eventID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            $(data.d).each(function (i, item) {
                                nath_team.append(
                                    $('<option/>', {
                                        value: item.eventTeamID,
                                        text: item.tm_name
                                    })
                                    )
                            })
                        }
                    })
                    popup();

                    //Save new athlete button
                    $('#nath_addAthleteBU').click(function () {
                        //var grade;
                        //if ($('#nath_grade option:selected').val() == "") {
                        //    grade = 0;
                        //} else { grade =  }

                        var athlete = {};
                        athlete.evta_fname = nath_fname.val()
                        athlete.evta_lname = nath_lname.val()
                        athlete.evta_grade = $('#nath_grade option:selected').val()
                        athlete.evta_team = $('#nath_team option:selected').val()
                        athlete.eventID = eventID

                        
                        alert(JSON.stringify(athlete))

                        //var addAthlete = "{'eventID':'" + eventID + "', "'evta_grade':'" + $('#nath_grade option:selected').val() + "', 'evta_fname':'" + nath_fname.val() + "', 'evta_lname':'" + nath_lname.val() + "', 'evta_team':'" + $('#nath_team option:selected').val() + "'}"

                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/addNewEvtAthlete",
                            data: JSON.stringify(athlete),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (ses, status) {
                                $('#nath_alert').html(nath_fname.val() + ' ' + nath_lname.val() + ' was added.')
                                $('#ntm_addCont').append("<li>" + nath_fname.val() + " " + nath_lname.val() + " (" + $('#nath_grade option:selected').text() + ") " + $('#nath_team option:selected').val() + "</li>")
                                nath_fname.val("")
                                nath_lname.val("")
                            }
                        })
                    })
                })
            }

            




            //Event Settings - Button Click
                function getEventSettings(_eventid) {

                    //ToolBar-----------------------------
                    //Reset Toolbar and append event buttons
                    tool_container.empty()
                    $("#tsb_tool_event").tmpl().appendTo(tool_container);

                    $('#newEventBu').hide();
                    $('#evt_settingsBu').hide();

                    $("#evtBackBu").show();
                    $('#evtBackBu').click(function () {
                        evt_container.empty();
                        loadEventDetails(_eventid);
                    });

                    //------------------------------------


                    if (_eventid == 'new') {

                        $("#tsb_new_eventTmpl").tmpl().appendTo(evt_container);
                        
                        //New Event - Location-----------------------------------
                        //Set Location Variables
                        var pickSchool = $('#lkup_pick_school')
                        pickSchool.hide();
                        var evtVenue = $('#nevt_venue')
                        evtVenue.show();
                        var schLookupForm = $('#lkup_school')
                        schLookupForm.hide()
                        var findSchool = evt_container.find('#nevt_lu_findBU')


                        //Location - Lookup School
                        $('#lkup_schoolBU').bind('click', function () {
                            schLookupForm.toggle();
                            evtVenue.toggle();
                        });

                        
                        findSchool.bind('click', function () {

                            var findSchool = "{'sch_name':'" + $('#nevt_lu_schName').val() + "', 'sch_loc_state':'" + $('#nevt_lu_state option:selected').val() + "'}"
                            $.ajax({
                                type: "POST",
                                url: "tmStatbook.aspx/getSchools",
                                data: findSchool,
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    $('#nevt_lu_selSchool').empty();
                                    $(data.d).each(function (i, item) {
                                        $('#nevt_lu_selSchool').append(

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

                        var acceptSchool = $('#nevt_lu_accept')
                        acceptSchool.bind('click', function () {

                            var acceptSchool = "{'schoolID':'" + $('#nevt_lu_selSchool option:selected').val() + "'}"
                            $.ajax({
                                type: "POST",
                                url: "tmStatbook.aspx/getSchool",
                                data: acceptSchool,
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {

                                    $(data.d).each(function (i, item) {

                                        evtVenue.find('#nevt_venNameTB').val(item.sch_name);
                                        evtVenue.find('#nevt_venAddrTB').val(item.sch_loc_addr);
                                        evtVenue.find('#nevt_venCityTB').val(item.sch_loc_city);
                                        evtVenue.find('#nevt_venStateTB').val(item.sch_loc_state).attr('selected', 'selected');
                                        evtVenue.find('#nevt_venZipTB').val(item.sch_loc_zip);

                                        schLookupForm.hide()
                                        evtVenue.show();
                                    });
                                }
                            });
                        }); //acceptSchool click - end tag


                        //New Event - Sessions-----------------------------------
                        var nevt_ses_list = $('#nevt_ses_list')
                        var session = [];

                        addSessionTmpl();

                        $('#nevt_ses_addBU').click(function () {
                           addSessionTmpl();
                        })
                        
                        function addSessionTmpl() {
                            nevt_ses_list.append(
                                '<li class="nevt_ses_item floatLT">' +
                                        '<select class="type" >' +
                                            '<option value="SE">Session</option>' +
                                            '<option value="WI">Weigh-In</option>' +
                                        '</select>' +
                                        '<input id="datePicker" class="date dateTime"  type="text" />' +
                                        
                                        '<input class="time dateTime"  type="text" />' +
                                        
                                        '<input class="title" type="text" />' +
                                        
                                        '<span class="delete">X</span>' +
                                '</li>'
                            )
                        }

                        //New Event - Divisions and Weights-------------------------
                        var divInfo = new Array();
                        var divisionIDs = [];
                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/getTeamDivisions",
                            data: "{'teamID':'" + teamID + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data, status) {
                                    
                                $.when($(data.d).each(function (i, item) {
                                    divisionIDs.push(item.divisionsID);
                                    var groupDivs = item.div_name + " - " + item.div_owner
                                    
                                    $.ajax({
                                        type: "POST",
                                        url: "tmStatbook.aspx/getEventClasses",
                                        data: "{'divisionID':'" + item.divisionsID + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (grp, status) {

                                            var groupNames = '';
                                            var groupContent = '';
                                            $(grp.d).each(function (i, grps) {
                                                groupNames += grps.evtc_name + ', '

                                            })
                                            groupContent = "<li id='" + item.divisionsID + "'><span id='id' class='ndisplay'>" + item.divisionsID + "</span><span class='div'>" + groupDivs + "</span><span class='class'>" + groupNames + "</span><span class='spanLink'>+ADD</span></li>"
                                            
                                            $('#nevt_div_hold').append(groupContent)
                                        }
                                    })

                                })).then(
                                $('#nevt_div_hold').delegate(">li .spanLink", "click", function () {
                                    
                                    var addLi = $(this).parent()
                                    divInfo.push("{'divisionsID':'" + addLi.attr('id') + "'}")
                                                                        
                                    addLi.appendTo('#nevt_div_cont')

                                }))
                            }
                        })
                        
                        
                        
                        //Save new team event  
                        evt_container.find('#addEvent').bind('click', function () {

                            //Event start date and time
                            session.push("{'edt_type':'ST', 'edt_date':'" + $("#nevt_startDate").val() +"', 'edt_time':'" + $("#nevt_startTime").val() +"', 'edt_title':'Start'}");

                            //Event sessions
                            $("#nevt_ses_list li").each(function (index) {
                                
                                var type = $(this).find('.type option:selected').val()
                                var date = $(this).find('.date').val()
                                var time = $(this).find('.time').val()
                                var title = $(this).find('.title').val()

                                session.push("{'edt_type':'" + type +"', 'edt_date':'" + date +"', 'edt_time':'" + time +"', 'edt_title':'" + title + "'}");
                               
                            })
                            //alert("'sessions':" + JSON.stringify(session) )                     
                            var newEvent = "{'teamID':'" + teamID + "', 'teamSeasonID':'" + tm_seasonID + "', 'evt_name':'" + $('#nevt_nameTB').val() + "', 'evt_type':'" + $('#nevt_typeTB option:selected').val() + "'," + "'levelID':'" + $('#nevt_levelTB option:selected').val() + "', " +
                                             "'styleID':'" + $('#nevt_styleTB option:selected').val() + "', " + "'evt_ven_name':'" + $('#nevt_venNameTB').val() + "', 'evt_addr':'" + $('#nevt_venAddrTB').val() + "', 'evt_city':'" + $('#nevt_venCityTB').val() + "', "+
                                             "'evt_state':'" + $('#nevt_venStateTB option:selected').val() + "', " + "'evt_zip':'" + $('#nevt_venZipTB').val() + "', 'divisionIDS':" + JSON.stringify(divInfo) + ", 'sessions':" + JSON.stringify(session) + " }"
                            
                            $.ajax({
                                type: "POST",
                                url: "tmStatbook.aspx/newTeamEvents",
                                data: newEvent,
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    //alert(data.d);
                                    alert("added!")

                                    getTeamEvents();
                                    $("#dialog-overlay, #dialog-box").hide();
                                }
                            });
                        });

                    } else {

                    
                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getEventDetails",
                        data: "{'eventID':'" + _eventid + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {

                            $("#tsb_evt_settingsTmpl").tmpl(data.d).appendTo(evt_container);
                        
                            evtSettingsForm()

                    }
                    });
                    
                }

                    //Edit and Cancel buttons of an event settings sections
                    function evtSettingsForm() {
                        var all_li = ""
                        var li_area =""

                        $('#evt_settings li .editBu').click(function () {
                            
                            all_li = $('#evt_settings li')
                            li_area = $(this).parent('li')
                            alert(li_area)
                            //Hide an area that is already in edit mode
                            if (all_li.hasClass("areaEdit")) {
                                $('#evt_settings').find('li.areaEdit').attr('class', 'area');
                                $('.show', all_li.hasClass('areaEdit')).attr('class', 'hide');
                            }

                            //show edit screen and hide display screen
                            $('.hide', li_area).attr('class', 'show');
                            li_area.attr('class', 'areaEdit');

                            li_area.find('.cancel').click(function () {
                                $('.show', li_area).attr('class', 'hide');
                                li_area.attr('class', 'area');

                            });
                        });

                        //Setting - Edit Section - Save Buttons
                        //Event Name-------------------------
                        $('#saveNameBu').click(function () {
                            $.ajax({
                                type: "POST",
                                url: "tmStatbook.aspx/saveEventName",
                                data: "{'eventID':'" + _eventid + "', 'evt_name':'" + $('#evtName_TB').val() + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    $('.content', li_area).html($('#evtName_TB').val());
                                    $('.show', li_area).attr('class', 'hide');
                                    li_area.attr('class', 'area');
                                }
                            });
                        });
                                
                            

                                //Location---------------------------
                                //Set Location Variables
                                var pickSchool = $('#pickSchool')
                                pickSchool.hide();
                                var evtVenue = $('#evtVenue')
                                evtVenue.show();
                                var schLookupForm = $('#locSchool')
                                schLookupForm.hide()
                                
                                //Location - Lookup School
                                $('#schLookupBu').bind('click', function () {
                                    schLookupForm.toggle();
                                    evtVenue.toggle();
                                });

                                var findSchool = evt_container.find('#findSchool')
                                findSchool.bind('click', function () {

                                    var findSchool = "{'sch_name':'" + $('#schoolName').val() + "', 'sch_loc_state':'" + $('#selState option:selected').val() + "'}"
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
                                                        text: item.sch_name + " (" + item.sch_loc_city + ")"
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

                                var acceptSchool = $('#acceptSchool')
                                acceptSchool.bind('click', function () {

                                    var acceptSchool = "{'schoolID':'" + $('#selSchool option:selected').val() + "'}"
                                    $.ajax({
                                        type: "POST",
                                        url: "tmStatbook.aspx/getSchool",
                                        data: acceptSchool,
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (data) {

                                            $(data.d).each(function (i, item) {

                                                // tmAddrCont.html(
                                                //     '<label id="schname">' + item.sch_name + '</label><br />' +
                                                //     '<label id="tmlocaddr">' + item.sch_loc_addr + '</label><br />' +
                                                //     '<label id="tmloccity">' + item.sch_loc_city + '</label>' + ", " + '<label id="tmlocstate">' + item.sch_loc_state + '</label><br />' +
                                                //     '<label id="tmloczip">' + item.sch_loc_zip + '</label><br /><br /> ' +

                                                //     '<h3>Team Name and League Association</h3>' +
                                                //     'Team Name: <label id="tmname">' + item.sch_tm_name + '</label> <label> (' + item.sch_tm_abrv + ') </label><br />' +
                                                //     'League: <label id="tmLeague">' + item.sch_lge_name + '</label> ' +
                                                //     '<a id="selSchoolID" href="' + item.schoolID + '"></a>'
                                                //);
                                                evtVenue.find('#venName').val(item.sch_name);
                                                evtVenue.find('#venAddress').val(item.sch_loc_addr);
                                                evtVenue.find('#venCity').val(item.sch_loc_city);
                                                evtVenue.find('#venState').val(item.sch_loc_state).attr('selected', 'selected');
                                                evtVenue.find('#venZip').val(item.sch_loc_zip);

                                                //newTmStep3.find('#ovtmname').text(item.sch_tm_name);
                                                //newTmStep3.find('#ovtmabrv').text(item.sch_tm_abrv);
                                                //newTmStep3.find('#ovlocname').text(item.sch_name);
                                                //newTmStep3.find('#ovlocaddr').text(item.sch_loc_addr);
                                                //newTmStep3.find('#ovloccity').text(item.sch_loc_city);
                                                //newTmStep3.find('#ovlocstate').text(" " + item.sch_loc_state);
                                                //newTmStep3.find('#ovloczip').text(item.sch_loc_zip);
                                                //newTmStep3.find('#ovschoolID').text(item.schoolID);
                                                //newTmStep3.find('#ovlgename').text(item.sch_lge_name);
                                                //newTmStep3.find('#ovlgeorg').text(item.sch_lge_org);
                                                schLookupForm.hide()
                                                evtVenue.show();
                                            });
                                        }
                                    });
                                }); //acceptSchool click - end tag


                                $('#saveVenueBu').click(function () {
                                    $.ajax({
                                        type: "POST",
                                        url: "tmStatbook.aspx/saveEventVenue",
                                        data: "{'eventID':'" + _eventid + "', 'evt_ven_name':'" + $('#venName').val() + "', 'evt_addr':'" + $('#venAddress').val() + "', " +
                                        "'evt_city':'" + $('#venCity').val() + "', 'evt_state':'" + $('#venState option:selected').val() + "', 'evt_zip':'" + $('#venZip').val() + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (data) {
                                            $('.content', li_area).html($('#venName').val(), $('#venAddress').val(), $('#venCity').val(), $('#venState option:selected').val(), $('#venZip').val());
                                            $('.show', li_area).attr('class', 'hide');
                                            li_area.attr('class', 'area');
                                        }
                                    });
                                });


                                //Sessions-------------------------------
                                getSessions(_eventid)

                            
                        
                    }
                        
                    var evtDay = $('#evtDay')
                    evtDay.datepicker();




                    //Event Settings - Get Event Divisions
                    getDivisions();
                    function getDivisions() {
                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/getEventDivisions",
                            data: "{'eventID':'" + eventID + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data, status) {
                                var divisionIDs = [];
                                $(data.d).each(function (i, item) {
                                    divisionIDs.push(item.divisionsID);



                                    $.ajax({
                                        type: "POST",
                                        url: "tmStatbook.aspx/getEventClasses",
                                        data: "{'divisionID':'" + item.divisionsID + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (grp, status) {

                                            var groupNames = '';
                                            var groupContent = '';
                                            $(grp.d).each(function (i, grps) {
                                                groupNames += '<div class="group">' + grps.evtc_name + '<div class="delete">X</div></div>'
                                                groupContent += grps.evtc_name + '|'
                                            })
                                            $('#evt_set_division .content').append('<div class="evtDivision">' + item.div_name + '</div><span>' + groupContent + '</span><br />')
                                            $('#evt_daw_container').append(
                                                '<div class="edw">' +
                                                    '<div class="evtDivision"><h4 class="edit_dname">' + item.div_name + '</h4></div>' +
                                                    '<div class="evtGroups"><input type="hidden" id="divID" value="' + item.divisionsID + '" />' +
                                                        groupNames + '<input class="grpAddTB" type="text" /><div class="grpAddBu">+</div></div>' +
                                                '</div><br />')

                                            $('.edit_dname').editable(function (value, settings) {
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


                                        }
                                    });
                                    $('.grpAddBu').click(function () {
                                        alert($(this).parent().find($('input#divID').val()))
                                    })



                                })

                            }

                        });
                    }

                    

                } //geteventSettings - end tag



                

                //Event Settings- Main Functions

                //Event Settings - Get Event Sessions
                function getSessions(eventid) {
                    var evtSessions = $('#evtSessions')
                           

                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getEventSessions",
                        data: "{'eventID':'" + eventid + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (ses, status) {
                            $('#newSession').hide()

                            evtSessions.empty();
                            $('#evt_set_sessions .content').empty();

                            $(ses.d).each(function (i, sess) {

                                //alert($(ses.d).length)
                                var date = ""
                                if (sess.edt_date == "") {
                                    date = ""
                                } else {
                                    date = Date.parse(sess.edt_date).toString("MM/dd/yy")
                                }

                                

                                $('#evt_set_sessions .content').append('<div class="">' + sess.edt_type + ' ' + date + ' ' + sess.edt_time + ' ' + sess.edt_title + '</div>')

                                //$('#evt_stTime').text(Date.parse(item.startTime).toString("h:mm"))
                                var type = ""
                                if(sess.edt_type == "ST"){
                                    $("#evt_startDate").val(date);
                                    $("#evt_startTime").val(sess.edt_time);
                                } else if (sess.edt_type == "SE") {
                                    type = '<option value="SE" selected="selected">Session</option> <option value="WI">Weigh-In</option>'
                                    appendSession();
                                } else if (sess.edt_type == "WI") {
                                    type = '<option value="SE">Session</option> <option value="WI" selected="selected">Weigh-In</option>'
                                    appendSession();
                                }

                                function appendSession() {
                                    evtSessions.append(

                                    '<li class="es">' +
                                    '<input class="id" value="' + sess.eventDateID + '" type="hidden" />' +
                                    '<div class="floatLT">' +
                                        '<select class="type">' +
                                            type +
                                        '</select>' +

                                    '</div>' +
                                    '<div class="floatLT">' +
                                        '<input class="date" type="text" value="' + date + '"/>' +
                                    '</div>' +
                                    '<div class="floatLT">' +
                                        '<input class="time" type="text" value="' + sess.edt_time + '"/>' +
                                    '</div>' +
                                    '<div class="floatLT">' +
                                        '<input class="title" type="text" value="' + sess.edt_title + '"/>' +
                                    '</div>' +
                                    '<div class="floatLT">' +
                                        '<span class="delete">X</span>' +
                                    '</div></li>'
                                    )
                                }
                                //$('.type option[value="'+sess.edt_type+'"]').attr("selected", "selected");

                            })

                            $('#evt_set_sessions ul li .delete').click(function () {

                                $(this).closest('li').hide()
                            })
                        }
                    });

                    $('#addSession').click(function () {

                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/addNewSession",
                            data: "{'eventID':'" + eventID + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data, status) {
                                
                                getSessions(eventid)
                            }
                        })
                    })

                    $('#saveSessionBu').click(function () {
                        $("#evtSessions li").each(function () {
                            var li = $(this)
                            var sessionID = li.find('.id').val()
                            if ($(this).css('display') == 'none') {
                                alert('no')

                            } else {
                                $.ajax({
                                    type: "POST",
                                    url: "tmStatbook.aspx/saveEventSession",
                                    data: "{'eventDateID':'" + sessionID + "', 'edt_type':'" + li.find('.type option:selected').val() + "', 'edt_date':'" + li.find('.date').val() + "', " +
                                    "'edt_time':'" + li.find('.time').val() + "', 'edt_title':'" + li.find('.title').val() + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {


                                    }
                                });
                            }


                        })
                        getSessions(eventid)
                        var li_area = $(this).parents('li')
                        $('.show', li_area).attr('class', 'hide');
                        li_area.attr('class', 'area');

                    });

                }

                
                
                
            

            //-----------------------------------------------------------------------------------
            //<<<<< Member Tab Functions >>>>>
            //-----------------------------------------------------------------------------------
            //Declare Global Page Variables
            var mem_container = $('#tsb_mem_container')
            var tool_container = $('#tsb_tool_container')

            //Loads the inital view for the members tab
            function loadMembersTab() {
                mem_container.empty();
                getAthletes()
                if (adm_status == "A") {
                    getNonAthMembers();
                }
            
            }

            //Gets the team athletes and appends them to the container. Every member gets
            //to see this section.
            function getAthletes() {
                
                //ToolBar-----------------------------
                //Reset toolbar and append the member buttons
                tool_container.empty()
                $("#tsb_tool_mem").tmpl().appendTo(tool_container);

                //Make toolbar adjustments for admin status
                if (adm_status == "A") {
                    
                    $('#newMemberBu').show();
                    $('#newMemberBu').click(function () {
                        mem_container.empty();
                        loadTmbSettingView('new');
                    });

                }
                //------------------------------------

                //Load the team athletes
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamAthletes",
                    data: "{'teamID':'" + teamID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        $(mem_container).append('<h2 class="memViewTitle">Athletes<h2>')
                        $("#tsb_mem_athleteViewTmpl").tmpl(data.d).appendTo(mem_container);

                        //$(data.d).each(function (i, item) {

                        //    var linked
                        //    if (item.personID != "") {
                        //        linked = "Linked"
                        //    }
                        //    else {
                        //        linked = "Not Linked"
                        //    }
                        //});

                        var div = $('#tsb_mem_container .member') 
                        //highlight row on hover
                        div.bind('mouseover', function (event) {
                            div.removeClass('row-highlight');
                            $(this).addClass('row-highlight');
                        });
                        div.bind('mouseout', function (event) {
                            div.removeClass('row-highlight');
                        });

                        div.click(function () {
                            //Set team member id variable
                            tmMemberID = $(this).find('a').attr('href');
                            athleteDisplay(tmMemberID)
                        });

                        

                    }

                });
                        
            };

            //Gets the non athlete team members and appends them to the container. Only the
            //admins can view these members.
            function getNonAthMembers() {
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getNonAthletes",
                    data: "{'teamID':'" + teamID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $(mem_container).append('<h2 class="memViewTitle">Other Members<h2>')
                        $("#tsb_mem_adminViewTmpl").tmpl(data.d).appendTo(mem_container);

                        $(data.d).each(function (i, item) {
                            //mem_container.empty();


                            //var athlete = $('#athlete')
                            //if (item.tmb_isAthlete != "") {
                            //    athlete.append("Athlete")
                            //}
                            //else {
                            //    athlete.append("")
                            //}

                            //var coach = $('#coach')
                            //if (item.tmb_isCoach != "") {
                            //    coach.append("Coach")
                            //}
                            //else {
                            //    coach.append("")
                            //}

                            //var admin = $('#admin')
                            //if (item.tmb_adminRole == "A") {
                            //    admin.append("Team Admin")
                            //}
                            //else if (item.tmb_adminRole == "M") {
                            //    admin.append("Scorebook Manager")
                            //}
                            //else {
                            //    admin.append("")
                            //}

                            //var linkStatus = $('#linkStatus')
                            //if (item.tmb_link_status == "A") {
                            //    linkStatus.append("Linked")
                            //}
                            //else if (item.tmb_link_status == "P") {
                            //    linkStatus.append("Pending...")
                            //}
                            //else if (item.tmb_link_status == "D") {
                            //    linkStatus.append("Declined")
                            //}
                            //else {
                            //    linkStatus.append("")
                            //}

                        });

                        var div = $('.memAdminView div');

                        div.click(function () {

                            $('#memBackBu').show();
                            tmMemberID = $(this).find('a').attr('href');
                            loadTmbSettingView(tmMemberID);
                        }); //memAdminView click - end tag



                    }
                });
            }


            function athleteDisplay(_tmMemberID) {
                //Clear member container
                mem_container.empty();

                //Adjust Toolbar
                $('#newMemberBu').hide();
                $('#athDisplayBu').hide()


                //ToolBar-----------------------------
                //Reset toolbar and append the member buttons
                tool_container.empty()
                $("#tsb_tool_mem").tmpl().appendTo(tool_container);

                $("#memBackBu").show();
                $('#memBackBu').click(function () {
                    loadMembersTab();
                });

                //Make toolbar adjustments for admin status
               if (adm_status == "A") {
                    $("#athSetBu").show();
                    $('#athSetBu').click(function () {
                        loadTmbSettingView(_tmMemberID)
                    });
                }
                //------------------------------------


                //Get selected team member info and display athlete page
                var teamMember = "{'tmMemberID':'" + _tmMemberID + "', 'teamID':'" + teamID + "'}"
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamMember",
                    data: teamMember,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        //Load athlete view and matches
                        $("#tsb_mem_athleteTmpl").tmpl(data.d).appendTo(mem_container);

                        //$(data.d).each(function (i, mem) {
                        //    //alert(currentTab);
                        //    //alert(item.fName + " " + item.lName);
                        //    var athlete
                        //    if (mem.tmb_isAthlete != "") {
                        //        athlete = "Athlete"
                        //    }
                        //    else {
                        //        athlete = ""
                        //    }

                        //    var coach
                        //    if (mem.tmb_isCoach != "") {
                        //        coach = "Coach"
                        //    }
                        //    else {
                        //        coach = ""
                        //    }

                        //});


                        

                        $('memDetCont').find('#memName').editInPlace({
                            callback: function (unused, enteredText) { return enteredText; },
                            //url: "tmStatbook.aspx/getTeamMember",
                            //params: "name=david"
                            bg_over: "#080808"
                        });
                    }



                });

                
            }

            

            //Load team member settings view
            function loadTmbSettingView(_tmbid) {
                mem_container.empty();

                //ToolBar-----------------------------
                //Reset toolbar and append the member buttons
                tool_container.empty()
                $("#tsb_tool_mem").tmpl().appendTo(tool_container);

                $("#athSetBu").hide();
                $('#newMemberBu').hide();

                $('#memBackBu').show();
                $('#memBackBu').click(function () {
                    loadMembersTab();
                });

                $('#athDisplayBu').click(function () {
                    athleteDisplay(_tmbid)
                });

                //Make toolbar adjustments for admin status
                if (adm_status == "A") {
                    $('#newMemberBu').show();
                    $('#newMemberBu').click(function () {
                        mem_container.empty();
                        loadTmbSettingView('new');
                    });

                }
                //------------------------------------
                

                if (_tmbid == 'new') {
                    $("#tsb_mem_adminTmpl").tmpl().appendTo(mem_container);
                    loadTmbNameForm('new');
                    loadPerLinkForm('new');

                } else {
                    
                    var teamMember = "{'tmMemberID':'" + _tmbid + "', 'teamID':'" + teamID + "'}"
                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getTeamMember",
                        data: teamMember,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            mem_container.empty();
                            $("#tsb_mem_adminTmpl").tmpl(data.d).appendTo(mem_container);

                            //$('#memAdminBack').click(function () {
                            //    mem_container.empty();
                            //    getNonAthMembers();
                            //});
                            loadTmbNameForm(_tmbid);
                            loadPerLinkForm(_tmbid);
                            loadTmbRoleForm(_tmbid);

                            $(data.d).each(function (i, mem) {
                                //alert(item.fName + " " + item.lName);

                                var athlete
                                if (mem.tmb_isAthlete != "") {
                                    $("#isAthleteCB").prop('checked', true);
                                    $('#athDisplayBu').show();
                                }

                                var coach
                                if (mem.tmb_isCoach != "") {
                                    $("#isCoachCB").prop('checked', true);
                                }

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
                                data: "{'teamID':'" + teamID + "', 'tmm_fName':'" + name[0] + "', 'tmm_lName':'" + name[1] + "'}",
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
                            $('#athDisplayBu').show();
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
                        memLinkFunct()
                    } else {
                        var teamMember = "{'tmMemberID':'" + tmMemberID + "', 'teamID':'" + teamID + "'}"
                        $.ajax({
                            type: "POST",
                            url: "tmStatbook.aspx/getTMConnection",
                            data: teamMember,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {

                                $(data.d).each(function (i, mem) {
                                    var roleOption = 'selected'
                                    if (mem.tmb_adminRole == "A") {
                                        roleOption
                                    } else if (mem.tmb_adminRole == "SM") {
                                        roleOption
                                    } else if (mem.tmb_adminRole == "" | "N") { roleOption }


                                    if (mem.tmb_link_status == "A") {
                                        linkCont.append('<p class="sect">Give people access to view your statbook by connecting them to a team member. [Learn More] </p><div class="sect" ><div class="perLinkBox"><img src="" alt="" />' + mem.per_fname + ' ' + mem.per_lname + '<br />' + mem.per_state +
                                        '<span id="linkRemove" class="floatRT">(Remove)</span></div> </div>')
                                    }
                                    else if (mem.tmb_link_status == "P") {
                                        linkCont.append('<p class="sect">Give people access to view your statbook by connecting them to a team member. [Learn More] </p><div class="sect" ><div class="perLinkBox"><img src="" alt="" />' + mem.per_fname + ' ' + mem.per_lname + '<br /><a href="' + mem.personID + '"/>' +
                                        '<span class="floatRT">Pending...</span> <br /><span id="linkCancel" class="floatRT">(Cancel)</span></div> </div>' +
                                        '<div class="sect"><p>What admin access will this person have? [Learn More]</p>' +
                                        '<div class="adminRoleBox"><select id="perIsAdmin"><option value="N" ' + roleOption + '>Not an Admin</option><option value="A" ' + roleOption + '>Team Admin</option><option value="SM" ' + roleOption + '>Statbook Manager</option></select></div></div>')

                                    }
                                    else if (mem.tmb_link_status == "D") {
                                        linkCont.append(mem.personID + '<h4> has declined your invite.</h4>')
                                    }
                                    else {
                                        linkCont.append('<p class="sect">Give people access to view your statbook by connecting them to a team member. [Learn More] </p><div class="sect" ><input id="invMember" class="perLinkAdd" type="button" value="+ Add Connection" />' +
                                            ' </div>');
                                    }

                                });
                                memLinkFunct()
                            } //getTMConnection - end tag
                        });


                    }


                    function memLinkFunct() {
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
                        $('#perIsAdmin').change(function () {
                            //alert(tmMemberID);
                            var isAdmin = "{'tmMemberID':'" + tmMemberID + "', 'roleID':'" + $('#perIsAdmin option:selected').val() + "'}"
                            $.ajax({
                                type: "POST",
                                url: "tmStatbook.aspx/addTmbAdminRole",
                                data: isAdmin,
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                }
                            });
                        });

                    }


                }//loadPerLinkForm - Ending Tag

            }//loadTmbSettingView - ending tag
                      
            //-----------------------------------------------------------------------------------
            //<<<<<<< Archive Tab >>>>>>>>>>>
            //-----------------------------------------------------------------------------------
            //Load team seasons
            function getSeasons() {
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamSeasons",
                    data: "{'teamID':'" + teamID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data, status) {
                        $('#arch_season').empty();
                        $(data.d).each(function (i, item) {
                            
                            $('#arch_season').append(

                                $('<option/>', {
                                    value: item.teamSeasonID,
                                    text: item.tms_name
                                })
                                );

                        });
                    }
                })
            };
            



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

