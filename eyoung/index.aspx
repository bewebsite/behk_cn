<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="_index" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>后台管理</title>
    <script src="js/jquery.js" type="text/javascript"></script>
    <link rel="stylesheet" href="css/reset.css" type="text/css">
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <script type="text/javascript">
        var username_reg = /[a-zA-Z0-9]{1,}/;
        //验证
        function myvalidate() {
            var username = $.trim($("#txt_UserName").val());
            var password = $.trim($("#txt_Password").val());
            var code = $.trim($("#txt_Code").val());

            var message = "";
            if (username == "") {
                message += "- 用户名不能为空\n";
            }
            else if (!username_reg.test(username)) {
                message += "- 用户名必须为A-Z0-9的字符\n";
            }
            if (password == "") {
                message += "- 密码不能为空\n";
            }
            else if (!username_reg.test(password)) {
                message += "- 密码必须为A-Z0-9的字符\n";
            }
            if (code == "") {
                message += "- 验证码不能为空";
            }
            else if (code.length != 4) {
                message += "- 验证码为4位数";
            }


            if (message != "") {
                alert(message);
                return false;
            }

            return true;
        }

        //设置密码
        function writepassword() {
            var username = $.trim($("#txt_UserName").val());
            if (pwd != "" && pwd.split('+')[0] == username) {
                $("#txt_Password").val(pwd.split('+')[1]);
            }
        }

        var chk_login_reg = /index.aspx$/;
        //判断登录地址
        function loadurl() {
            if (window.parent != null && !chk_login_reg.test(window.parent.location.href)) {
                window.parent.location.href = 'index.aspx';
            }
        }
        loadurl();
    </script>
</head>
<body class="login">
    <form runat="server" id="form1">
    <div class="bgRpt">
    </div>
    <div class="loginWrap">
        <p class="tit-1">
            后台管理系统</p>
        <p class="tit-2">
            Management System</p>
        <div class="itemLst">
            <span>用户名</span><asp:TextBox ID="txt_UserName" onblur="writepassword();" runat="server"
                CssClass="text"></asp:TextBox>
        </div>
        <div class="itemLst">
            <span>密 码</span><asp:TextBox ID="txt_Password" TextMode="Password" runat="server"
                CssClass="text"></asp:TextBox>
        </div>
        <div class="itemLst">
            <span>验证码</span><asp:TextBox ID="txt_Code" runat="server" CssClass="text" Width="80"
                MaxLength="4"></asp:TextBox>
            <asp:Image ID="ImgCode" runat="server" ImageUrl="code.aspx" onclick="this.src=this.src+'?'" />
        </div>
        <p class="fgtPs">
            <label>
                <asp:CheckBox ID="chk_Remember" runat="server" />
                记住密码</label></p>
        <div class="btn-log">
            <asp:Button ID="but_login" CssClass="log" runat="server" Text="登录" OnClientClick="return myvalidate();"
                OnClick="but_login_Click" />
            <input type="reset" value="重置" class="rst" />
        </div>
    </div>
    </form>
</body>
</html>
