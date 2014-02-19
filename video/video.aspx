<%@ Page Title="" Language="C#" MasterPageFile="~/master/main_master.master" AutoEventWireup="true" CodeFile="video.aspx.cs" Inherits="video_video" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <ul id="teamlist" style="float:left; width:200px;">
        <li id="schott">TJ Schott</li>
        <li id="aries">Adam Ries</li>
        <li id="sullivan">Daniel Sullivan</li>
        <li id="schropp">Abe Schropp</li>
        <li id="bracken">Eric Bracken</li>
        <li id="schnoeb">Nick Schnoebelen</li>
        <li id="mcferren">Eric Mcferren</li>
        <li id="beaver">Casey Beaver</li>
        <li id="galindo">Zach Galindo</li>
        <li id="simpson">Mason Simpson</li>
        <li id="hunter">Justin Hunter</li>
        <li id="lynch">Cam Lynch</li>
        <li id="binkman">Jarrod Brinkman</li>
        <li id="maske">Payton Maske</li>
    </ul>
    <ol id="videoList" style="float:left; width:400px;"></ol>

    <script id="vid_listTemp" type="text/x-jquery-tmpl">
        <li class="sect" id="${videoID}">${vid_title} (${vid_school}) ${vid_tourny}</li>
    </script>

    <div id="dialog-overlay"></div>
    
    <div id="dialog-box">
        <div class="dialog-content"><input id="closeBu" type="button" value="Close" />
            <!--<div id="dialog-title"></div>-->
            <div id="dialog-message">
                

            </div>
        </div>
    </div>
    
    <script id="vid_temp" type="text/x-jquery-tmpl" >
        <video id="video1" height="450" width="550" controls>
            <source src="http://reginawrestling.com/video/vids/${vid_location}" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"' />
            <source src="http://reginawrestling.com/video/vids/DemorySol.webm" type='video/webm; codecs="vp8, vorbis"' />
        
            <source src="http://www.html5rocks.com/en/tutorials/video/basics/Chrome_ImF.ogv" type='video/ogg; codecs="theora, vorbis"' />
        </video>
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            
            

            $(window).load(function () { });

            var vid_cont = $('#videoList')
            var myVideo = document.getElementById("video1");

            $('#teamlist li').click(function(){
                                
                var tmMemberID = this.id

                $.ajax({
                    type: "POST",
                    url: "video.aspx/getMemberVideo",
                    data: "{'tmMemberID':'" + tmMemberID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        vid_cont.empty();
                        $(data.d).each(function (i, item) {});
                            $("#vid_listTemp").tmpl(data.d).appendTo(vid_cont);
                            $('#videoList li').click(function () {
                                var videoID = this.id
                                $.ajax({
                                    type: "POST",
                                    url: "video.aspx/getVideo",
                                    data: "{'videoID':'" + videoID + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {
                                        popup();
                                        var vid_mb = $('#dialog-message')
                                        var vid_title = $('#dialog-title')
                                        vid_mb.empty();
                                        $("#vid_temp").tmpl(data.d).appendTo(vid_mb);
                                    }
                                })
                                
                            })
                        

                    }
                });
                
            })

            // if user clicked on button, the overlay layer or the dialogbox, close the dialog  
            $('#closeBu').click(function () {
               
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
            

        })
    </script>

</asp:Content>

