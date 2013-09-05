<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            margin:0;
            padding:0;
        }
        #splashPage {
            background-color: #012154;
            
           
        }
        h2 {
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

            margin: 50% auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="splashPage">
        <div id="main">
            <h2>Future Home of the Iowa City Regina Wrestling Team</h2>
            <img id="crown" src="pics/crown.png" />

        </div>    
    </div>
    </form>
</body>
</html>
