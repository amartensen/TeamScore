<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="account_login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../css/mainStyle.css" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
</head>
<body>

    <form id="form1" runat="server">
        <header>
    <div class="headWrap">
            <h1 class="floatLT">Teamscore</h1>
            <%--<div id="account">
                <ul>
                    <li>
                        <span><img alt="" src="#" /></span>
                        <div id="accountList">
                            <ul>
                                <li><a href="~/user/userProfile.aspx">View Profile</a></li>
                                <li><a href="#">Edit Profile</a></li>
                                <li><span><asp:LinkButton ID="home_lb" runat="server" PostBackUrl="~/Default.aspx">Home</asp:LinkButton></span></li>
                                <li><span><asp:LoginView ID="LoginView1" runat="server">
                                        <LoggedInTemplate>
                                            <asp:LinkButton ID="profile_lb" runat="server" PostBackUrl="~/user/userProfile.aspx">Profile</asp:LinkButton>
                                        </LoggedInTemplate>
                                    </asp:LoginView></span></li>
                                <li>Notifications [0]</li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>--%>
         </div>  
    </header>
    <div class="login">
        <asp:Login ID="Login1" DestinationPageUrl="~/user/userProfile.aspx" runat="server"></asp:Login>
    
    </div>

        
    </form>
</body>
</html>
