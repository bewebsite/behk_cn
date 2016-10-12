<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<!DOCTYPE html>
<html>
	<head runat="server">
		<meta http-equiv="Content-Type"content="text/html; charset=UTF-8"/>
	</head>
	<asp:Label ID="lblLocation" runat="server" style="display:none;"></asp:Label>
	<asp:Label ID="lblIPAddress" runat="server" style="display:none;"></asp:Label>
	<div id="location"></div>
</html>
<script src="http://www.behk.org/js/jquery.js" type="text/javascript"></script>
<script>
	$(document).ready(function() {
		var data = JSON.parse($("#lblLocation").text());
		var lan = navigator.language;
		var desc = "Using Taobao IP DB (http://ip.taobao.com/service/getIpInfo.php?ip=)." + "<br><br>";
		$("#location").html(desc + 'IP: ' + $("#lblIPAddress").text() + '<br>' + 'Location: ' + data.data.country + '<br>' + 'Language: ' + lan);
	});
	
</script>