<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <style>
        body {
            margin:0;
            padding:0;
            background-color: #012154;
        }
        #splashPage {
            
            
           
        }
        h1 {
            text-align: center;
            color: #fff;
            font-family: 'Tempus Sans ITC';
            font-size: 30px;
            margin: 0px; padding: 0px;
        }
        h2 {
            text-align: center;
            color: #fff;
            font-family: 'Tempus Sans ITC';
            font-size: 24px;
            
        }
        #crown {
            
        }
        #main {
            width: 300px;
            height: 300px;
            
            /*position: absolute;
            top:0;
            bottom: 0;
            left: 0;
            right: 0;*/

            margin: 10% auto;
        }
        .br {
            padding:0px;
            margin: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="splashPage">
        <div id="main">
            <h2>Future Home of the</h2>
            <img id="crown" src="pics/crown.png" />
            <h1>Iowa City</h1><h1>Regina Wrestling</h1><h1 id="login">Team</h1>
        </div>    
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        
        $("#login").click(function () {
            window.location.href = "./account/login.aspx";
            
        });

    });

</script>