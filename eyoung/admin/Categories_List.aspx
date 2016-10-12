<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Categories_List.aspx.cs"
    Inherits="eyoung_admin_Categories_List" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>适用人群类型列表</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/default.js" type="text/javascript"></script>
</head>
<body>
    <form runat="server" id="from1">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">适用人群类型列表<em>(共<%=AllCount %>条记录)</em></span>
        </div>
        <div class="mainContent">
            <!--内容部分 S-->
            <div class="bar clearfix">
                <a class="iconButton" href="Categories_Add.aspx" id="info_add" runat="server"><span
                    class="addIcon">&nbsp;</span>添加 </a>
                <div class="buttonWrap">
                    <!-- 搜索条件 -->
                    <asp:DropDownList ID="drpIsPass" runat="server">
                        <asp:ListItem Text="--显示--" Value=""></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox runat="server" ID="searchValue" CssClass="text" placeholder="根据适用人群类型搜索"
                        Width="200"></asp:TextBox>
                    <input type="button" value="搜索" class="button" onclick="search();">
                    <input type="button" value="清除条件" class="button" onclick="search_rest();" />
                </div>
            </div>
            <div>
                <table class="list" id="listTable">
                    <tbody>
                        <tr>
                            <th class="check">
                                <input type="checkbox" id="selectAll" onclick="select_all(this);" />
                            </th>
                            <th>
                                <span>适用人群类型</span>
                            </th>
                            <th>
                                <span>排序</span>
                            </th>
                            <th>
                                <span>显示</span>
                            </th>
                            <th>
                                <span>添加时间</span>
                            </th>
                            <th>
                                <span>操作</span>
                            </th>
                        </tr>
                        <asp:Repeater ID="rpList" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <input name="ids" type="checkbox" value="<%# Eval("ID") %>" />
                                    </td>
                                    <td>
                                        <%# Eval("Name") %>
                                    </td>
                                    <td>
                                        <input id="sort_<%#Eval("ID") %>" name="txtsort_<%#Eval("ID") %>" type="text" value="<%#Eval("Sort") %>"
                                            class="text" style="width: 50px; text-align: center" onkeyup="checkproductnum(this)" />
                                    </td>
                                    <td>
                                        <%# getStateImage(Eval("IsPass")) %>
                                    </td>
                                    <td>
                                        <%# Eval("AddTime","{0:yyyy-MM-dd}") %>
                                    </td>
                                    <td>
                                        <a href="Categories_Add.aspx?id=<%# Eval("ID") %>">编辑</a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
            <div class="bar footer-bar clearfix">
                <div class="fl">
                    <asp:Button ID="But_Delete" runat="server" Text="删除" CssClass="button" OnClientClick="return check_post('确定要删除吗？');"
                        OnClick="But_Delete_Click" />
                    <asp:Button ID="Button1" runat="server" Text="修改排序" CssClass="button" OnClick="Button1_Click" />
                    <asp:Button ID="But_IsPass" runat="server" Text="显示" CssClass="button" OnClientClick="return check_post();"
                        OnClick="But_IsPass_Click" />
                    <asp:Button ID="But_CancelIsPass" runat="server" Text="不显示" CssClass="button" OnClientClick="return check_post();"
                        OnClick="But_CancelIsPass_Click" />
                    <asp:Button ID="But_Excel" runat="server" Text="导出Excel" CssClass="button" OnClick="But_Excel_Click" />
                </div>
                <div class="fr">
                    <asp:DropDownList runat="server" ID="drpPage" onchange="search()">
                        <asp:ListItem Value="">每页显示</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                        <asp:ListItem Value="150">150</asp:ListItem>
                        <asp:ListItem Value="200">200</asp:ListItem>
                    </asp:DropDownList>
                    <My:AspNetPager class="pages" PageSize="20" UrlPaging="true" runat="server" ID="pgServer"
                        FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页">
                    </My:AspNetPager>
                </div>
            </div>
            <!--内容部分 E-->
        </div>
    </div>
    <script type="text/javascript">
        function checkproductnum(i) {
            var reg1 = /^\d+$/;
            var value = $(i).val().trim();
            if (isNaN(value) || reg1.test(value) == false) {
                $(i).val("1");
            }
        }
    </script>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-05 09:50:55 -->
