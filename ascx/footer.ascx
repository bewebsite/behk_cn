<%@ Control Language="C#" AutoEventWireup="true" CodeFile="footer.ascx.cs" Inherits="ascx_footer" %>

<div class="footer">
  <div class="footer-main">
     <div class="footer-nav clearfix">
        <dl class="f1-dl">
          <dt>关于必益</dt>
<!--
          <dd><a href="/about/">公司简介</a></dd>
            <dd><a href="/about/adv.aspx">品牌优势</a></dd>
-->
            <dd><a href="/about/by-family.aspx">必益家庭</a></dd>
            <dd><a href="/about/partner.aspx">合作伙伴 </a></dd>
            <dd><a href="/about/job.aspx">工作机会 </a></dd>
            <dd><a href="/team/">董事成员</a></dd>
            <dd><a href="/team/counselor.aspx">顾问团队</a></dd>
            <dd><a href="/team/manage.aspx">管理团队</a></dd>
 <!--           
<dd><a href="/team/t-creater.aspx">关于创始人</a></dd>
  -->          
<dd><a href="/contact/">联系我们</a></dd>
        </dl>
        <dl class="f2-dl">
            <dt>联系我们</dt>
            <dd><p>地址：长寿路1111号 </p></dd>
            <dd><p>电话：400-850-4118</p></dd>
            
            <dd><p>必益教育官方微信：BEeducation</p></dd>
            <dd><p>必益教育官方微博：必益教育</p></dd>
            <dd><p>必益小助手微信：behk889</p></dd>
        </dl>
<!--
        <dl class="f2-dl">
            <dt>热门专题</dt>
            <asp:Repeater runat="server" ID="repList">
            <ItemTemplate>
            <dd><a href="/<%#Eval("HtmlName") %>.html"><%#Eval("CNName")%></a></dd>
            </ItemTemplate>
            </asp:Repeater>
        </dl>
-->
     </div>
     <div class="attention"><h4>微信公众号</h4><img src="../images/weix.jpg" width="135" /><div class="goTop"><a href="javascript:void(0);">返回顶部</a></div></div>
  </div>
  <div class="copyR">
    <div class="footer-main clearfix">
        <a class="footer-logo" href="/"><img src="../images/f-logo.jpg" /></a>
        <div class="copyMeg">
           <p>上海必益教育信息咨询有限公司 <em>|</em>   长寿路1111号 悦达889中心 9楼02A-05室 <em>|</em>电话:400-850-4118</p>
           <p class="copyright"><span>© 2016 BE Education</span>保留所有权利&nbsp;&nbsp;沪ICP备12028009号</p>
        </div>
     </div>
  </div>
</div>



<!--<div class="footer">
   <div class="footerC clearfix">
       <div class="f-item fItem1">
          <h4>必益教育</h4>
          <p>必益教育旨在培养中国未来的领导者，使其在日益国际化的世界中取得成功。</p>
       </div>
       <div class="f-item fItem2">
          <h4>Contact us</h4>
          <p>If you have any questions about BE Education, please contact us:<br/>Phone: 4006981577<br/>Email: <a href="mailto:go@behk.org">go@behk.org</a></p>
       </div>
       <div class="f-item fItem3">
          <h4>Work with us</h4>
          <p>必益教育现面向社会诚聘英才，你将会得到良好的职业发展机会。现在就加入我们，共启成功旅程。<br/>请联系我们： <a href="mailto:jj@behk.org">jj@behk.org</a> | <a target="_blank" href="http://www.behk.org/?page_id=6414"><ins>职位发布</ins></a></p>
       </div>
   </div>
   <p class="copyright">&copy 2015 BE Education 保留所有权利.</p>
   <p class="footerM">上海必益教育信息咨询有限公司<em>|</em>长寿路1111号</p>
</div>-->

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
    <script type="text/javascript" src="http://www.behk.org/wp-includes/js/jquery/jquery.js?ver=1.10.2"></script>
    <script type="text/javascript">
        var wid = "height=450,width=650,directories=no,location=no,menubar=no,resizable=yes,status=no,toolbar=no,top=100,left=50";
        function openChat(g) {
            var chatURL = "http://chat.looyuoms.com/chat/chat/p.do?c=20000409#038;f=10046273#038;g=10050876";
            window.open(chatURL, '', wid);
        }
    </script>
<!--     <div class="rightimg regform visible-desktop" style="position: fixed; float: right;
        right: 1px; top: 20%; cursor: pointer;">
        <div id="close2" style="position: fixed; right: 1px; color: red; top: 19%;">
            <img src="http://www.behk.org/images/guanbi-1.png"></div>
        <a onclick="openChat('g')">
            <img src="http://en.behk.org/images/etonleft.jpg" style="width: 130px;
                 margin-top: -10px; margin-left: 5px;"></a>
    </div> -->

    
  
    <div class="leftimg regform visible-desktop" style="position: fixed; float: left;
        left: 1px; top: 20%; cursor: pointer;">
        <div id="close" style="position: fixed; color: red; top: 19%;">
            <img src="http://www.behk.org/images/guanbi-1.png"></div>
        <a onclick="openChat('g')">
            <img src="http://www.behk.org/images/meiguishandonglingying.jpg" style="width: 130px;
                 margin-top: -10px; margin-left: 5px;"></a>
    </div>


        <!--悬浮-->
    <div class="sy_share fix1">
        <div class="share_ico1" style="right: -260px;"><img src="/images/xf_03.png" width="52" height="52">400-850-4118</div>
        <div class="share_ico3">
            <img src="/images/xf_05.png">
            <div class="img_weixin" style="display: none;"><img src="/images/img_weixin.jpg"></div>
        </div>
        <div class="share_ico2" style="right: -140px;"><img src="/images/xf_07.png" width="52" height="52">
            <div>
            <a onclick="openChat('g')" style="font-size: 30px;">在线咨询</a></div>
        </div>
        <div class="share_ico5" style="right: -140px;"><img src="/images/在线预约.png" width="52" height="52">
            <div>
            <a href="/contact#jumphere" style="font-size: 30px;">在线预约</a></div>
        </div>
        
        <div class="share_ico4 "><a href="javascript:void(0)" onclick="javascript:$body.stop().animate({ scrollTop: 0 }, 'normal');"><img src="/images/xf_09.png" width="52" height="52"></a></div>

    </div>

<!--
<div class="midimg regform visible-desktop" style="position: fixed; float: left;
        left: 35%; top: 25%; cursor: pointer;">
        <div id="close1" style="position: fixed; color: red; top: 24%;">
            <img src="http://www.behk.org/images/guanbi-1.png"></div>
        <a onclick="openChat('g')">
            <img src="http://www.behk.org/images/leyuEton.jpg" style="width: 450px;
                 margin-top: -10px; margin-left: 5px;"></a>
    </div>
-->

    <script type="text/javascript">
        $(function () {
            $("#close").click(function () {
                $(".leftimg").remove();
                $("#close").remove();
            })
            $("#close1").click(function () {
                $(".midimg").remove();
                $("#close1").remove();
            })
            $("#close2").click(function () {
                $(".rightimg").remove();
                $("#close2").remove();
            })
        })
    </script>
    <!-- rolling -->
    <script type="text/javascript">

        $().ready(function () {
            $(".regform").hide();
            var hideregform = function () {
                $(".regform").fadeOut(300);
                $("#footer").css({ "margin-bottom": 0 });
            };

            var showregform = function () {
                $(".regform").fadeIn(300);
                $("#footer").css({ "margin-bottom": 100 });
            };

            var removeregform = function () {
                $(".regform").remove();
                $("#footer").css({ "margin-bottom": 0 });
            };

            $(".regform_close").click(function () {
                removeregform();
            });

            $(window).scroll(function () {
                if ($(".regform").length > 0) {
                    var sTop = $(document).scrollTop();
                    if (sTop > 300)
                        showregform();
                    else
                        hideregform();
                }
            });

            // float on the right
            $('.share_ico1').mouseenter(function(){
              $(this).stop(true,true).animate({'right':-5});
            });
            $('.share_ico1').mouseleave(function(){
              $(this).stop(true,true).animate({'right':-260});
            });
            $('.share_ico2').mouseenter(function(){
              $(this).stop(true,true).animate({'right':-5});
            });
            $('.share_ico2').mouseleave(function(){
              $(this).stop(true,true).animate({'right':-140});
            });
            $('.share_ico3 ').mouseenter(function(){
              $('.share_ico3 .img_weixin').stop(true,true).fadeIn(300);
            });
            $('.share_ico3').mouseleave(function(){
              $('.share_ico3 .img_weixin').stop(true,true).fadeOut(300);
            });
            $('.share_ico5 ').mouseenter(function(){
              $(this).stop(true,true).animate({'right':-5});
            });
            $('.share_ico5').mouseleave(function(){
              $(this).stop(true,true).animate({'right':-140});
            });
          });
    </script>