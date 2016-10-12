<%@ Control Language="C#" AutoEventWireup="true" CodeFile="navHotEvents.ascx.cs"
    Inherits="ascx_navHotEvents" %>
<div class="huodonglist">
    <h3 class="top">
        精彩活动推荐 <a href="/events/" target="_blank">更多</a>
    </h3>
    <div class="list">
        <ul>
            <asp:Repeater runat="server" ID="repEvents">
                <ItemTemplate>
                    <li>
                        <h3>
                            <%#Eval("CNTitle") %></h3>
                        <p class="clearfix c1">
                            <span>地点：</span><em><%#Eval("Address") %></em></p>
                        <p class="clearfix c2">
                            <span>日期：</span><em><%#DateTime.Parse(Eval("StarDay").ToString()).ToString("M月d日") %><%#GetInfo(Eval("EndDay"),1)%></em></p>
                        <p class="clearfix c3">
                            <span>时间：</span><em><%#Eval("StarTimer") %><%#GetInfo(Eval("EndTimer"),1)%></em></p>
                        <div class="btn">
                            <a href="/events/<%#Eval("HtmlName") %>.html" target="_blank">现在预约</a>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
</div>
