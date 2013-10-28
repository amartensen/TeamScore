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
            <div id="tsb_tool_mem">
                <input id="memBackBu" class="button ndisplay" type="button" value="Back" />
                <input id="athSetBu" class="button ndisplay" type="button" value="Settings" />
                <input id="memAthBu" class="button ndisplay" type="button" value="Matches" />
                <input id="newMemberBu" class="button" type="button" value="New Member" />
            </div>
            <div id="tsb_tool_event">
                <input id="evtBackBu" class="button ndisplay" type="button" value="Back" />
                <input id="newEventBu" class="button ndisplay" type="button" value="New Event" /> 
            </div>
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
                        <article id="tmb_evt_container"> </article>
                        
                        <!--jtemplate for the event list-->
                        <script id="tsb_evt_listViewTmpl" type="text/x-jquery-tmpl">
                            <div class="evt_listItem">
                                <span class="sect">${date}</span>
                                <div class="sect"><h4>${evt_name}<a href="${eventID}" /></h4>
                                    ${evt_city}, ${evt_state}</div>
                                <div class="sect">${styleID}
                                    ${levelID}
                                <span>${startTime}</span></div>
                            </div>
                        </script>

                        <!-- Event detailed -->
                        <script id="tsb_evt_detailTmpl" type="text/x-jquery-tmpl">
                            <article class="tsb_mem_toolbar">
                                
                                <input id="evt_settingsBu" class="button" type="button" value="Settings" />
                            </article>
                            <article id="evt_topContent">
                                <span id="evt_date"></span><br />
                                <section>
                                <h3>${evt_name}</h3>
                                <p>${evt_addr}, ${evt_city}, ${evt_state}</p>
                                
                                <div id="evt_details">
                                ${styleID}<br />
                                ${levelID}<br />
                                </div>
                                </section>

                                <section>
                                Start:<span id="evt_stTime"></span><br />
                                </section>
                                

                                
                            </article>
                            

                            <article id="evt_contentNav">
                                <ul>
                                    <li><a href="#evt_matches"/><h2>Matches</h2></li>
                                    <li><a href="#evt_teams"/><h2>Teams</h2></li>
                                    <li><a href="#evt_athletes"/><h2>Athletes</h2></li>
                                </ul>
                            </article>

                            
                                <div id="evt_matches_tmpl">
                                    <div class="matchTools" >
                                        <div class="flip"><</div>
                                        <div class="title">
                                            <select id="evt_brackets"></select></div>
                                        <div class="flip">></div>
                                        <select id="evt_division">

                                        </select>
                                    </div>
                                    <article class="evt_mainContent">
                                    <div id="match_content"></div>

                                    </article>
                                </div>
                                <div id="evt_teams_tmpl">
                                    <article class="evt_mainContent">
                                        <div id="team_content"></div>
                                    </article>
                                </div>
                                <div id="evt_athletes_tmpl">
                                    <article class="evt_mainContent">
                                        <div id="athlete_content"></div>
                                    </article>
                                </div>

                            
                        </script>

                        <script id="evt_matchTmpl" type="text/x-jquery-tmpl">
                            <div class="listItem">
                                <div class="sect">${eventGroupID}</div>
                                <div class="sect">${hfname} ${hlname}${hgrade}</div><br />
                                <div class="sect">${afname} ${alname} ${agrade}</div>
                            </div>
                        </script>
                        
                    </div>

                    <!--Event Settings -->
                    <script id="tsb_evt_settingsTmpl" type="text/x-jquery-tmpl">
                        <article id="evt_settings">
                            <h3>General Event Settings</h3>
                            <ul>
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

                                <!--Event Settings - Location Section -->
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

                                <!--Event Settings - Date and Time Section -->
                                <li id="evt_set_sessions" class="area">
                                    <h4 class="areaTitle">Sessions</h4>
                                    <div class="content"></div>
                                    <div class="editBu">(Edit)</div>
                                    <div class="hide">
                                        <p>Sessions are used to indicate significant time points throughout the event.</p>
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
                            <div class="memAthleteView">
                                <div>
                                    <a href="${tmMemberID}"></a>
                                    <img src="" alt="" /><h4>${fName} ${lName}</h4>
                                    <br />
                                </div>
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

                        <!--Admin Member Detailed-->
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
  
 
    
    <!--<<< Scripts >>>-->
    <script type="text/javascript">
        $(document).ready(function () {
            
            $(window).load(function () {  });

            $("#backBu").click(function () {
                window.location.replace("../user/tmFanPage.aspx")
            });

            var tmMemberID = ""
            var teamID = localStorage.team_id
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
            $('#tabs div:first').show();
            $('#tabNav ul li:first').addClass('active');

            $('#tabNav ul li a').click(function () {
                $('#tabNav ul li').removeClass('active');
                $(this).parent().addClass('active');
                var currentTab = $(this).attr('href');
                if (currentTab == "#tab-1") {
                } else if (currentTab == "#tab-2") {
                    getTeamEvents()
                } else if (currentTab == "#tab-3") {
                    getAthletes()

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


            //<<<<< Member Tab Functions >>>>>

            //Declare Global Page Variables
            var mem_container = $('#tsb_mem_container')
            var tool_container = $('#tsb_tool_container')

            //Member-Admin View Toggle 
            //$('#tsb_mem_topNav ul li').click(function () {
            //    var memView = $(this).find('a').attr('href');
                                
            //    if (memView == "#mem_athlete") {
            //        getAthletes
                
            //    } else if (memView == "#mem_admin") {
            //        getAdminMembers();
            //    }
            //});
            

            $('#newMemberBu').click(function () {
                mem_container.empty();
                loadAdminView('new');
            });

            //Load team members
            function getAthletes() {

                tool_container.empty()
                $("#tsb_tool_mem").tmpl().appendTo(tool_container);
                if (adm_status == "A") {
                        $('#newMemberBu').show();
                    }
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamAthletes",
                    data: "{'teamID':'" + teamID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        mem_container.empty();

                        $(mem_container).append('<h2 class="memViewTitle">Athletes<h2>')
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

                        var div = $('.memAthleteView div');
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

                        }
                        );
                        
                    }
                    
                });

                if (adm_status == "A") {
                    getAdminMembers();
                }
                
            };

            function athleteDisplay(_tmMemberID) {
                //Clear member container
                mem_container.empty();

                //Adjust Toolbar
                $('#newMemberBu').hide();
                $('#memAthBu').hide()

                //Get selected team member info and display athlete page
                var teamMember = "{'tmMemberID':'" + _tmMemberID + "', 'teamID':'" + teamID + "'}"
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamMember",
                    data: teamMember,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {


                        $("#memBackBu").show();

                        if (adm_status == "A") {
                            $("#athSetBu").show();
                        }
                        
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

            $('#athSetBu').click(function () {
                mem_container.empty();
                loadAdminView(tmMemberID)
            });
            }

            //Load the Admin team members page
            function getAdminMembers() {
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamMembers",
                    data: "{'teamID':'" + teamID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $(mem_container).append('<h2 class="memViewTitle">Other Members<h2>')
                        $("#tsb_mem_adminViewTmpl").tmpl(data.d).appendTo(mem_container);

                        $(data.d).each(function (i, item) {
                            //mem_container.empty();
                            

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

                           var div = $('.memAdminView div');
                           div.click(function () {
                               
                               $('#memBackBu').show();
                               tmMemberID = $(this).find('a').attr('href');
                               loadAdminView(tmMemberID);
                           }); //memAdminView click - end tag

                           
                        
                    }
                });
            }

            //Load member settings page
            function loadAdminView(_tmbid) {
                mem_container.empty();

                //Adjust Toolbar
                $('#newMemberBu').hide();
                $("#athSetBu").hide();


                if (_tmbid == 'new') {
                    $("#tsb_mem_adminTmpl").tmpl().appendTo(mem_container);
                    loadTmbNameForm('new');
                    loadPerLinkForm('new');

                } else {
                    tmMemberID = _tmbid
                    var teamMember = "{'tmMemberID':'" + tmMemberID + "', 'teamID':'" + teamID + "'}"
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
                            //    getAdminMembers();
                            //});
                            loadTmbNameForm(tmMemberID);
                            loadPerLinkForm(tmMemberID);
                            loadTmbRoleForm(tmMemberID);

                            $(data.d).each(function (i, mem) {
                                //alert(item.fName + " " + item.lName);

                                var athlete
                                if (mem.tmb_isAthlete != "") {
                                    $("#isAthleteCB").prop('checked', true);
                                    $('#memAthBu').show();
                                }

                                var coach
                                if (mem.tmb_isCoach != "") {
                                    $("#isCoachCB").prop('checked', true);
                                }

                            });

                            

                        }
                    });

                            $('#memBackBu').click(function () {
                                mem_container.empty();
                                getAthletes();
                            });

                            $('#memAthBu').click(function () {
                                mem_container.empty();
                                athleteDisplay(tmMemberID)
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
                                $('#memAthBu').show();
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
                                    } else if (mem.tmb_adminRole == ""|"N") { roleOption }


                                    if (mem.tmb_link_status == "A") {
                                        linkCont.append('<p class="sect">Give people access to view your statbook by connecting them to a team member. [Learn More] </p><div class="sect" ><div class="perLinkBox"><img src="" alt="" />' + mem.per_fname + ' ' + mem.per_lname + '<br />' + mem.per_state +
                                        '<span id="linkRemove" class="floatRT">(Remove)</span></div> </div>')
                                    }
                                    else if (mem.tmb_link_status == "P") {
                                        linkCont.append('<p class="sect">Give people access to view your statbook by connecting them to a team member. [Learn More] </p><div class="sect" ><div class="perLinkBox"><img src="" alt="" />' + mem.per_fname + ' ' + mem.per_lname + '<br /><a href="' + mem.personID + '"/>' +
                                        '<span class="floatRT">Pending...</span> <br /><span id="linkCancel" class="floatRT">(Cancel)</span></div> </div>'+
                                        '<div class="sect"><p>What admin access will this person have? [Learn More]</p>'+
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
                            var isAdmin = "{'tmMemberID':'"+tmMemberID+"', 'roleID':'" + $('#perIsAdmin option:selected').val() + "'}"
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
            
            }//loadAdminView - ending tag

            
            $('#adminView').click(function () {
                $('.member').hide();
                $('.admin').show();
            });

            
            //<<<<< EVENTS Tab Functions >>>>>
            
            //Declare Global Variables
            var eventID = ""
            var evt_container = $('#tmb_evt_container')
            var evt_mainContent

            
            $('#newEventBu').click(
                getEventSettings('new')
                );

            function getTeamEvents() {
                tool_container.empty()

                $("#tsb_tool_event").tmpl().appendTo(tool_container);
                if (adm_status == "A") {
                    $('#newEventBu').show();

                }

                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getTeamEvents",
                    data: "{'teamID':'" + teamID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data, status) {
                        //alert(data.d);
                        evt_container.empty();
                        $("#tsb_evt_listViewTmpl").tmpl(data.d).appendTo(evt_container);

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

                //Load all events for the Event Detail page
            function loadEventDetails(_eventid) {

                //Load the event details
                $.ajax({
                    type: "POST",
                    url: "tmStatbook.aspx/getEventDetails",
                    data: "{'eventID':'" + _eventid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $("#evtBackBu").show();

                        $("#tsb_evt_detailTmpl").tmpl(data.d).appendTo(evt_container);

                        //Set tmpl variables
                        match_tmpl = $('#evt_matches_tmpl')
                        team_tmpl = $('#evt_teams_tmpl')
                        team_tmpl.hide();
                        athlete_tmpl = $('#evt_athletes_tmpl')
                        athlete_tmpl.hide();


                        $(data.d).each(function (i, mem) {
                            $('#venState').val(mem.evt_state).attr('selected', 'selected')
                        });


                        

                        //Event Content Nav 
                        $('#evtBackBu').click(function () {
                            evt_container.empty();
                            getTeamEvents();
                        });


                        $(data.d).each(function (i, item) {
                            $('#evt_date').text(Date.parse(item.startDate).toString("dddd, MMMM dd, yyyy"))
                            $('#evt_stTime').text(Date.parse(item.startTime).toString("h:mm"))
                        });

                        //Initial State of Event Content Nav
                        setupMatchTab(eventID);

                        //Event Details SubNav Tab
                        $('#evt_contentNav ul li').click(function () {
                            var activeEvtNav = $(this).find('a').attr('href');

                            if (activeEvtNav == "#evt_teams") {
                                getEventTeams(eventID);
                            } else if (activeEvtNav == "#evt_athletes") {
                                getEventAthletes(eventID);
                            } else if (activeEvtNav == "#evt_matches") {
                                setupMatchTab(eventID)

                            }

                        });

                        //Event Settings Button Click
                        $('#evt_settingsBu').click(function () {
                            evt_container.empty();

                            $("#tsb_evt_settingsTmpl").tmpl(data.d).appendTo(evt_container);
                            getEventSettings(_eventid)

                            //Edit button of an event settings sections
                            $('#evt_settings li .editBu').click(function () {
                                var all_li = $('#evt_settings li')
                                var li_area = $(this).parents('li')
                                if (all_li.hasClass("areaEdit")) {

                                    $('#evt_settings').find('li.areaEdit').attr('class', 'area');
                                    $('.show', all_li.hasClass('areaEdit')).attr('class', 'hide');
                                }
                                $('.hide', li_area).attr('class', 'show');
                                li_area.attr('class', 'areaEdit');

                                li_area.find('.cancel').click(function () {
                                    $('.show', li_area).attr('class', 'hide');
                                    li_area.attr('class', 'area');

                                });

                                //Setting - Edit Section - Save Buttons
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
                                

                            });



                        }); //settingsBU click - end tag
                    }
                });

                //Event Details - Event Match tab               
                function setupMatchTab(_eventID) {

                    //load the divisions of an event
                    $.ajax({
                        type: "POST",
                        url: "tmStatbook.aspx/getEventDivisions",
                        data: "{'eventID':'" + eventID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data, status) {
                            $(data.d).each(function (i, item) {
                                $('#evt_division').append(

                                    $('<option/>', {
                                        value: item.divisionsID,
                                        text: item.div_name
                                    })
                                    );

                            });

                            //load the brackets of a division
                            getEventBrackets(_eventid)
                            function getEventBrackets(eventid) {
                                evt_brackets = $('#evt_brackets')
                                evt_brackets.empty();
                                $.ajax({
                                    type: "POST",
                                    url: "tmStatbook.aspx/getEventBrackets",
                                    data: "{'eventID':'" + eventid + "', 'divisionID':'" + $('#evt_division').val() + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data, status) {
                                        $(data.d).each(function (i, item) {
                                            evt_brackets.append(
                                                $('<option/>', {
                                                    value: item.bracketID,
                                                    text: item.bracketName
                                                })
                                            );
                                        });
                                        getEventMatches()

                                    }
                                })

                            }

                            //load the matches of a bracket
                            function getEventMatches() {

                                team_tmpl.hide()
                                athlete_tmpl.hide()
                                match_tmpl.show()

                                //Load all matches for the selected event
                                $.ajax({
                                    type: "POST",
                                    url: "tmStatbook.aspx/getEventMatches",
                                    data: "{'bracketID':'" + evt_brackets.val() + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data, status) {
                                        var match_content = $('#match_content')
                                        match_content.empty()
                                        $("#evt_matchTmpl").tmpl(data.d).appendTo(match_content);
                                        $(data.d).each(function (i, item) {
                                            //evt_mainContent.append(

                                            //        '<div class="listItem">'+
                                            //            '<div class="sect">'+ item.weight+'</div><div class="sect">'+ item.hfName+' '+ item.hlName+', '+ item.hgrade+'<br />'+ item.afName+' '+ item.alName+', '+ item.agrade+'</div>'+
                                            //                                                    '<div class="sect">'+ item.hwinner+' '+ item.hwinType+' '+ item.hfallTime+'<br />'+ item.awinner+ ' '+ item.awinType+' '+ item.afallTime+'</div>'+
                                            //        '</div>')
                                        });
                                    }
                                });
                            }

                            $('#evt_division').change(function () { getEventBrackets(_eventid) });
                            evt_brackets.change(function () { getEventMatches() });
   
                        }
                    })
                }

                //Event Details - Event Teams tab 
                function getEventTeams(eventID) {

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
                                        '<table id="evtTeamTemp">' +
                                            '<tr>' +
                                                '<td><input type="checkbox" /></td>' +
                                                '<td>' + item.tm_name + '</td>' +
                                                '<td>' + item.tm_name_abrv + '</td>' +
                                                '<td>' + item.tm_city + '</td>' +
                                                '<td>' + item.tm_state + '</td>' +
                                                '<td>' + item.eventTeamID + '</td>' +
                                            '</tr>' +
                                        '</table>')
                                });
                            });
                        }
                    });
                }

                //Event Details - Event Athlete tab 
                function getEventAthletes(eventID) {


                    match_tmpl.hide()
                    team_tmpl.hide()

                    athlete_tmpl.show()

                    //Load all the Teams participating in the selected event
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
                                    '<article><input type="checkbox" />' + mem.fName + ' ' + mem.lName + mem.grade + mem.amount + mem.teamName + '</article>')
                            });
                        }
                    });
                }

                //Event Settings - Button Click
                function getEventSettings(_eventid) {

                    if (_eventid == 'new') {
                    } else {

                    }

                    //Set Global Variables
                    var pickSchool = $('#pickSchool')
                    pickSchool.hide();
                    var evtVenue = $('#evtVenue')
                    evtVenue.show();
                    var schLookupForm = $('#locSchool')
                    schLookupForm.hide()
                    var evtDay = $('#evtDay')
                    evtDay.datepicker();


                    //Save new team event
                    evt_container.find('#addEvent').bind('click', function () {

                        var newEvent = "{'teamID':'" + teamID + "', 'eventName':'" + $('#evtName_TB').val() + "', 'startDate':'" + $('#evtStDate_TB').val() + "', 'startTime':'" + $('#evtStTime_TB').val() + "', 'eventType':'1'," +
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
                                        

                    //Event Settings - Location - Lookup School
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
                                    evtVenue.find('#venState').val(mem.sch_loc_state).attr('selected', 'selected');
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




                    
                    getSessions(_eventid)
                    

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
                                        data: "{'divisionID':'" + item.eventDivisionID + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (grp, status) {

                                            var groupNames = '';
                                            var groupContent = '';
                                            $(grp.d).each(function (i, grps) {
                                                groupNames += '<div class="group">' + grps.evtg_name + '<div class="delete">X</div></div>'
                                                groupContent += grps.evtg_name + '|'
                                            })
                                            $('#evt_set_division .content').append('<div class="evtDivision">' + item.evtd_name + '</div><span>' + groupContent + '</span><br />')
                                            $('#evt_daw_container').append(
                                                '<div class="edw">' +
                                                    '<div class="evtDivision"><h4 class="edit_dname">' + item.evtd_name + '</h4></div>' +
                                                    '<div class="evtGroups"><input type="hidden" id="divID" value="' + item.eventDivisionID + '" />' +
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
                                if (sess.edt_type == "session") {

                                    type = '<option value="session" selected="selected">Session</option> <option value="weighin">Weigh-In</option>'
                                } else if (sess.edt_type == "weighin") {

                                    type = '<option value="session">Session</option> <option value="weighin" selected="selected">Weigh-In</option>'
                                } else { type = '<option value="session">Session</option> <option value="weighin">Weigh-In</option>' }

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

                

                
            }//loadEventDetails - end tag


            //Loads all settings for an event
            

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
            

            
         
           <%-- //Handles the new member button
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
            
//            });--%>
            






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

