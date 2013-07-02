<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="account_register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" type="text/css" href="../css/mainStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <article class="hpg_header">
            <div class="headWrap">
                <h1>TeamScore</h1>
                <nav class="hpg_nav"></nav>
            </div>
        </article>
        <article class="hpg_wrap">
            <article class="content">
                <div id="regForm">
                    <h1>Register</h1>
                    <table>
                        <tr><td><label for="regFName">First Name: </label></td><td><input id="regFName" type="text" /></td></tr>
                        <tr><td><label for="regFLame">Last Name: </label></td><td><input id="regLName" type="text" /></td></tr>
                        <tr><td><label for="regDOB">Birthday: </label></td><td><input id="regDOB" type="text" /></td></tr>
                        <tr><td><label for="regEmail">Email: </label></td><td><input id="regEmail" type="text" /></td></tr>
                        <tr><td><label for="regPassword">Password: </label></td><td><input id="regPassword" type="text" /></td></tr>

                    </table>

                </div>
            </article>
        </article>
    </form>
</body>
</html>
