<%@ Page Title="" Language="C#" MasterPageFile="~/master/main_master.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="account_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    login
    <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/user/userProfile.aspx">
        
    </asp:Login>

</asp:Content>

