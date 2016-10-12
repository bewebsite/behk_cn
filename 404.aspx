<%@ Page Language="C#" AutoEventWireup="true" CodeFile="404.aspx.cs" Inherits="_404" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<HTML>
<head>  
    <title>对不起，您访问的页面不存在 请转到首页进入</title>  
<META http-equiv=Content-Type content="text/html; charset=GB2312">
<STYLE type=text/css></STYLE>
<LINK type=text/css rel=stylesheet>
<STYLE type=text/css>BODY {
        FONT-SIZE: 9pt; COLOR: #1984e6; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: none
}
TABLE {
        FONT-SIZE: 9pt; COLOR: #1984e6; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: none
}
TD {
        FONT-SIZE: 9pt; COLOR: #1984e6; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: none
}
BODY {
        SCROLLBAR-HIGHLIGHT-COLOR: buttonface; SCROLLBAR-SHADOW-COLOR: buttonface; SCROLLBAR-3DLIGHT-COLOR: buttonhighlight; SCROLLBAR-TRACK-COLOR: #eeeeee; BACKGROUND-COLOR: #ffffff
}
A {
        FONT-SIZE: 9pt; COLOR: #1984e6; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: none
}
A:hover {
        FONT-SIZE: 9pt; COLOR: #ff0000; LINE-HEIGHT: 16pt; FONT-FAMILY: "Tahoma", "宋体"; TEXT-DECORATION: underline
}
H1 {
        FONT-SIZE: 9pt; FONT-FAMILY: "Tahoma", "宋体"
}
</STYLE>
<META content="MSHTML 6.00.2800.1458" name=GENERATOR></HEAD>
<BODY topMargin=20>
<TABLE cellSpacing=0 width=600 align=center border=0 cepadding="0">
  <TBODY>
  <TR colspan="2">
    <TD><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><p><strong><font color=#ba1c1c size=15px>HTTP404错误</font></strong></p>
            <p>没有找到您要访问的页面，请检查您是否输入正确URL。</p></td>
          <td><p><a href="http://www.behk.org" ><img height=150 src="images/belogo.jpg" 
      width=100 border=0></a></p>            </td>
        </tr>
      </table>
      <HR noShade SIZE=0>
       请尝试以下操作：
      <P>·如果您已经在地址栏中输入该网页的地址，请确认其拼写正确。<br />  
           ·打开该站点主页，然后查找指向您感兴趣信息的链接。<br />  
           ·单击<a href="javascript:history.back(1)"><font color="#BA1C1C">后退</font></a>链接，尝试其他链接。<br />  
           ·单击单击<a href="javascript:doSearch()"><font color="#BA1C1C">首页</font></a>链接，回到必益教育官网</p>
      
      <HR noShade SIZE=0>
      <form name=loading>
<P align=center>
<FONT face=Arial color=#0066ff size=2>正在为你自动跳转到BE必益教育首页</FONT>
<INPUT style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-WEIGHT: bolder; PADDING-BOTTOM: 0px; COLOR: #0066ff; BORDER-TOP-style: none; PADDING-TOP: 0px; FONT-FAMILY: Arial; BORDER-RIGHT-style: none; BORDER-LEFT-style: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-style: none" size=46 name=chart>
<BR>
<INPUT style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; COLOR: #0066ff; BORDER-BOTTOM: medium none; TEXT-ALIGN: center" size=47 name=percent>
<SCRIPT>
    var bar = 0
    var line = "││"
    var amount = "││"
    count()
    function count() {
        bar = bar + 2
        amount = amount + line
        document.loading.chart.value = amount
        document.loading.percent.value = bar + "%"
        if (bar < 100)
        { setTimeout("count()", 50); }
        else
        { window.location = "http://www.behk.org"; }
    }
</SCRIPT>
</P>
</form><BR>
      &nbsp;&nbsp;&nbsp;<BR>
      </P><!------------End this!---------------></TD></TR></TBODY></TABLE>
</BODY></HTML> 