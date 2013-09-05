<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="./css/mainStyle.css" />
</head>

<body>
    <form id="form1" runat="server">
    <article class="hpg_header">
        
    <div class="headWrap">
        <h1 class="floatLT">TeamScore</h1>
        <aside class="floatRT">
            <%--<table>
                <tr><td><label for="userName">Email:</label></td><td><label for="password">Password:</label></td></tr>
                <tr><td><input id="username" type="text" /></td><td><input id="password" type="text" /> <input id="login" type="button" value="Login" /></td></tr>
                <tr><td><input id="rememberme_CB" type="checkbox"/><label for="rememberme_CB">Remember Me</label></td><td><a href="#">Forget Password?</a></td></tr>
            </table>--%>
            <asp:Login ID="Login2" runat="server" DestinationPageUrl="~/user/userProfile.aspx" FailureAction="RedirectToLoginPage" UserNameLabelText="Email:">
                <LayoutTemplate>
                    <table>
                        <tr><td><asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label></td>
                            <td><asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label></td>
                        </tr>
                        <tr>
                            <td><asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                                    ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                                    ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator></td>
                    
                            <td><asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                                    ControlToValidate="Password" ErrorMessage="Password is required." 
                                                    ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator></td>
                            <td><asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" 
                                                    ValidationGroup="Login1" /></td>
                    
                        </tr>
                        <tr><td><asp:CheckBox ID="RememberMe" runat="server" Text="Remember Me" /></td><td><asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal></td></tr>
                    </table>
                </LayoutTemplate>
            </asp:Login>
        </aside>

    </div>
    </article>
        <div class="scroll">
            <article class="hpg_wrap">
                <article class="content">
                    <section class="floatLT">
                        <h1>Take Your Team To New Heights</h1>
                        <ul>
                            <li>Create and Mange your Team</li>
                            <li>Invited and Share your team info with anyone</li>
                            <li>Update stats during the match!</li>
                        </ul>
                    </section>
                    <span id="signinButton">
                        <span
                            class="g-signin"
                            data-callback="signinCallback"
                            data-clientid="163447922112.apps.googleusercontent.com"
                            data-cookiepolicy="single_host_origin"
                            data-requestvisibleactions="http://schemas.google.com/AddActivity"
                            data-scope="https://www.googleapis.com/auth/plus.login"></span>
                    </span>
                    <aside class="floatRT">
                        <h1>Sign Up</h1>
                        <h3>It's Free!</h3>

                        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server">
                            <WizardSteps>
                                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                                    <ContentTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <label for="regFName">First Name: </label>
                                                </td>
                                                <td>
                                                    <input id="regFName" type="text" /></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label for="regFLame">Last Name: </label>
                                                </td>
                                                <td>
                                                    <input id="regLName" type="text" /></td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="emailLabel" runat="server" AssociatedControlID="email">Email:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="emailRequired" runat="server"
                                                        ControlToValidate="UserName" ErrorMessage="Email is required."
                                                        ToolTip="Email is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="regPasswordRequired" runat="server"
                                                        ControlToValidate="Password" ErrorMessage="Password is required."
                                                        ToolTip="Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="ConfirmEmail" runat="server"
                                                        AssociatedControlID="ConfirmEmail">Confirm Email:</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="ConfirmEmailRequired" runat="server"
                                                        ControlToValidate="Email"
                                                        ErrorMessage="Confirm Email is required."
                                                        ToolTip="Confirm Email is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:CompareValidator ID="EmailCompare" runat="server"
                                                        ControlToCompare="UserName" ControlToValidate="Email"
                                                        Display="Dynamic"
                                                        ErrorMessage="The Email and Confirmation Email must match."
                                                        ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2" style="color: Red;">
                                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td>
                                                    <label for="regDOB">Birthday: </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <select id="birthMonth">
                                                        <option>Month:</option>

                                                    </select>
                                                    <select id="birthDay">
                                                        <option>Day:</option>

                                                    </select>
                                                    <select id="birthYear">
                                                        <option>Year:</option>

                                                    </select></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input id="gendMale" type="radio" value="m" /><label for="gendMale">Male</label>
                                                    <input id="gendFemale" type="radio" value="f" /><label for="gendFemale">Female</label>
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>By clicking Sign Up, you agree to our terms.</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input id="regSignUp" type="button" value="Sign Up" /></td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:CreateUserWizardStep>

                            </WizardSteps>
                        </asp:CreateUserWizard>


                    </aside>
                </article>
            </article>
            <footer>
                link
        link
        link
            </footer>

        </div>
    </form>

       <!-- Place this asynchronous JavaScript just before your </body> tag -->
    <script type="text/javascript">
        (function () {
            var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
            po.src = 'https://apis.google.com/js/client:plusone.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
        })();

        function signinCallback(authResult) {
            if (authResult['access_token']) {
                // Successfully authorized
                // Hide the sign-in button now that the user is authorized, for example:
                document.getElementById('signinButton').setAttribute('style', 'display: none');
            } else if (authResult['error']) {
                // There was an error.
                // Possible error codes:
                //   "access_denied" - User denied access to your app
                //   "immediate_failed" - Could not automatically log in the user
                // console.log('There was an error: ' + authResult['error']);
            }
        }
    </script>
</body>
</html>
