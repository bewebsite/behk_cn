<%@ Page Language="C#" AutoEventWireup="true" CodeFile="thanks.aspx.cs" Inherits="thanks" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>谢谢您提交的信息-必益教育</title> 
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
	<style type="text/css">
		#container{
			height:380px;
			width:800px;
			margin:20px auto;
		}
		#logo{
			height:100px;
			width: 800px;
		}

		#middle{
			
			height:200px;
			width:800px;
			margin:0 auto;

		}
		#wenzi{
			height:200px;
			width:500px;
			margin:25px 0 0 50px;
			float:left;
		}
		#code{
			height:200px;
			width:200px;			
			float:right;

		}
		#foot{
			height:100px;
			width:800px;
			background:#35373b;
			
		}
		 
		#rightpart p{
			font-size:12px;
			color:#d6d7d8;
			line-height:12px;
			margin-top: 5px;
			font-family:Arial;
		}	
	</style>	
</head>

<body>
	<div id="container">
		<div id="logo"><img style="height:63px;width:220px;" alt="必益教育LOGO" src="images/belogo2.png"></div>
		<div id="middle">
		<div id="wenzi" style="font-size: 15px"> <p>谢谢您提交的信息，我们的专业顾问会尽快与您联系！
您也可以关注右侧的必益教育微信公众号，了解我们的最新动态，
也可以拨打我们的热线电话400-850-4118，直接咨询您想要的信息。
</p>
		</div>
		<div id="code"><img style="height:150px;width:150px;" alt="必益教育code" src="images/weixin.jpg"></div>
		</div>
		<div id="foot">
			<div id="footer-logo"  style="width: 150px;height:100px;float:left;margin: 6px 500px 30px 10px"><img style="" src="images/f-logo.jpg"/></div>
			<div id="rightpart" style="width: 550px;height:100px;float:right;margin:-120px 0px 10px 40px">
           <p>上海必益教育信息咨询有限公司 | 长寿路1111号 悦达889中心 9楼02A-05室 | 电话:400-850-4118<p>
           <p style="margin:0 0 0 330px">© 2015 BE Education留所有权利</p>
        </div>

		</div>
		<div style="display: none">
        <!-- Added 9/28/2014: Baidu Code -->
        <script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?fc1ae77ade463aa799dd7a87e5192750";
  var s = document.getElementsByTagName("script")[0];
  s.parentNode.insertBefore(hm, s);
})();
</script>

        <!-- Added 4/16/2014: Google analytics -->
        <script type="text/javascript">
            (function (i, s, o, g, r, a, m) {
                i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date(); a = s.createElement(o),
      m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
            })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

            ga('create', 'UA-10009127-1', 'behk.org');
            ga('send', 'pageview');
        </script>
    </div>		
</body>
</html>
