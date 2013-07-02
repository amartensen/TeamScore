<%@ Page Title="" Language="C#" MasterPageFile="~/master/main_master.master" AutoEventWireup="true" CodeFile="tmFanPage.aspx.cs" Inherits="user_tmFanPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="pageHeader">
        <div class="pageHeadLeft">
            <asp:FormView ID="FormView1" runat="server" DataSourceID="tmheaderSqlDataSource" >
                <ItemTemplate>
                    <asp:Label ID="teamNameLabel" runat="server" Text='<%# Bind("teamName") %>' />
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="tmheaderSqlDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:statbookConnectionString %>" 
                SelectCommand="SELECT teamName FROM teams WHERE (teamID = @teamID);">
                <SelectParameters>
                    <asp:SessionParameter Name="teamID" SessionField="TeamID" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
        <div class="pageHeadRight">
            <asp:LinkButton ID="scorebook_LB" runat="server" PostBackUrl="~/team/tmStatbook.aspx" >Scorebook</asp:LinkButton>
        </div>

    </div>
    <article>

    </article>
    <aside>

    </aside>
</asp:Content>

