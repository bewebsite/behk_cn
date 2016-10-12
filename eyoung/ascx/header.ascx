<%@ Control Language="C#" AutoEventWireup="true" CodeFile="header.ascx.cs" Inherits="eyoung_ascx_WebUserControl" %>
<div class="topWrap">
    <a href="/eyoung/" class="logo">
        <img alt="eyoung网站建设" src="/eyoung/images/logo.png" /></a>
    <div class="nav" id="nav">
        <ul>
            <asp:Literal ID="Lit_One" runat="server"></asp:Literal>
            <%--     <li><a href="#" data-navjs="nav_product">商品</a> </li>
            <li><a href="#" data-navjs="nav_order">订单</a> </li>
            <li><a href="#" data-navjs="nav_member">会员</a> </li>
            <li><a href="#" data-navjs="nav_content">内容</a> </li>
            <li><a href="#" data-navjs="nav_marketing">营销</a> </li>
            <li><a href="#" data-navjs="nav_statistics">统计</a> </li>
            <li><a href="#" data-navjs="nav_system">系统</a> </li>--%>
            <li><a target="_blank" href="/">网站预览</a> </li>
        </ul>
    </div>
    <div class="link link1">
        <a target="_blank" href="http://www.eyoung.net">官方网站</a> <em>|</em> <a target="_blank"
            href="http://www.eyoung.net">联系我们</a><em>|</em><a href="http://www.firefox.com.cn/"
                target="_blank">推荐浏览器</a>
    </div>
    <div class="link link2">
        <strong>
            <asp:Literal ID="Lit_UserName" runat="server"></asp:Literal></strong> 您好! <a href="/eyoung/changepassword.aspx">
                [修改密码]</a> <a href="/eyoung/loginout.aspx">[退出]</a>
    </div>
</div>
<div class="leftWrap">
    <div class="nav-left">
        <asp:Literal ID="Lit_Two" runat="server"></asp:Literal>
        <%--<dl class="nav-list" id="nav_product">
                <dt>商品管理</dt>
                <dd>
                    <p>
                        <a href="products/default.html">商品列表</a></p>
                    <p>
                        <a href="#">商品列表</a></p>
                    <p>
                        <a href="#">商品列表</a></p>
                </dd>
            </dl>
            <dl class="nav-list" id="nav_order">
                <dt>订单管理</dt>
                <dd>
                    <p>
                        <a href="#">订单列表</a></p>
                    <p>
                        <a href="#">订单列表</a></p>
                    <p>
                        <a href="#">订单列表</a></p>
                </dd>
            </dl>--%>
    </div>
</div>
