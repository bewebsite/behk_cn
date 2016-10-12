<%@ Page Language="C#" AutoEventWireup="true" CodeFile="williambbc.aspx.cs" Inherits="williambbc" %>

<%@ Register Src="ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>


<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
<meta charset="UTF-8">
    <title>必益教育总裁畅谈中国教育国际化之路</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link href="../css/school.css" rel="stylesheet" type="text/css" />
    <link href="css/default-n.css" rel="stylesheet" type="text/css" />
    <link href="videojs/video-js.css" rel="stylesheet" type="text/css" />
    <script src="videojs/video.js" type="text/javascript"></script>
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="js/index-banner.js" type="text/javascript"></script>
    <script src="../js/common.js" type="text/javascript"></script>
    <script src="js/index.js" type="text/javascript"></script>
</head>
<body>
<div class="nheader">
    <div class="con">
        <div class="topbar">
            <a href="/about/">关于必益</a><em>|</em><a href="/about/adv.aspx">品牌优势</a><em>|</em><a href="/about/by-family.aspx">必益家庭</a><em>|</em><a href="/about/partner.aspx">合作伙伴</a><em>|</em><a href="/about/job.aspx">工作机会</a><em>|</em><a href="/team/">董事成员</a><em>|</em><a href="/team/counselor.aspx">顾问团队</a><em>|</em><a href="/team/manage.aspx">管理团队</a><em>|</em><a href="/team/t-creater.aspx">关于创始人</a><em>|</em><a href="/contact/">联系我们</a><span><a href="/">中文</a><em>|</em><a href="http://en.be.co">EN
                            </a></span>
        </div>
        <div class="clearfix cen">
            <a href="/" class="logo" title="必益教育">
                <img src="../images/logo.png" alt="必益教育"></a>
            <div class="searchb">
                <dl>
                    <dt><span id="headerKind">院校</span><em></em></dt>
                    <dd>
                        <a href="javascript:void(0)">院校</a> <a href="javascript:void(0)">新闻</a> <a href="javascript:void(0)">
                            活动</a>
                    </dd>
                </dl>
                <div class="put">
                    <input type="text" id="header_search">
                </div>
                <a class="b" href="javascript:void(0)" onclick="SearchHeader()"></a>
            </div>
            <div class="tels">
                <p>
                    免费咨询电话</p>
                <h2>
                    400-698-1577</h2>
            </div>
        </div>
    </div>
</div>

    <div class="navn wnav">
    <div class="con">
        <ul class="onav-l clearfix">
            <li><a class="oa  cur" href="/">首页</a></li>
            <li><a href="/sa-us.html" class="oa ">美国寄宿学校</a></li><li><a href="/UK-Boarding.html" class="oa ">英国寄宿中学</a></li><li><a href="/uk-pri.html" class="oa ">英国寄宿小学</a></li><li><a href="/beacademy.html" class="oa ">英美入学培训</a></li>
            <li class="news-oa"><a class="oa ">短期游学</a>
                <ul class="inav-l" style="width: 110%; display: none;">
                    
                    <li><a class="ia" href="/LLSC.html">加州大学夏令营</a></li>
                    
                    <li><a class="ia" href="/cylc.html">切特豪斯夏令营</a></li>
                    
                    <li><a class="ia" href="/dnzxsq.html">邓恩中学夏令营</a></li>
                    
                    <li><a class="ia" href="/ssca.html">澳洲夏令营</a></li>
                    
                    <li><a class="ia" href="/ssc.html">伊顿夏令营</a></li>
                    
                    <li><a class="ia" href="/aus.html">澳洲冬令营(截止)</a></li>
                    
                    <li><a class="ia" href="/swc.html">瑞士冬令营(截止)</a></li>
                    
                </ul>
            </li>
            <li class="news-oa"><a class="oa ">牛津国际公学</a>
                
                <ul class="inav-l" style="display: none;">
                    <li><a class="ia" href="http://www.czoic.com/zh-hans">常州牛津国际公学</a></li>
                    <li><a class="ia" href="http://www.chengduoic.com/zh-hans">成都牛津国际公学</a></li>
                </ul>
            </li>
            <li><a class="oa " href="/events/">精彩活动</a></li>
            <li class="news-oa"><a class="oa " href="/news/">新闻动态</a>
                <ul class="inav-l" style="display: none;">
                    
                    <li><a class="ia" href="/news/?NewsType=2#searchlist">服务产品</a></li>
                    
                    <li><a class="ia" href="/news/?NewsType=1#searchlist">公司新闻</a></li>
                    
                    <li><a class="ia" href="/news/?NewsType=3#searchlist">总监专栏</a></li>
                    
                   
                    
                </ul>
            </li>
            <li><a class="oa " href="/schools/">院校中心</a></li>
        </ul>
    </div>
</div>

    
    <form id="form1" runat="server">
    <div align="center">
    <video id="example_video_1" style="margin:0px auto" class="video-js vjs-default-skin" controls preload="none" width="1024" height="728"
      poster="http://video-js.zencoder.com/oceans-clip.png"
      data-setup="{}">
    <source src="images/williambbc.mp4" type='video/mp4' />
    <track kind="captions" src="demo.captions.vtt" srclang="en" label="English"></track><!-- Tracks need an ending tag thanks to IE9 -->
    <track kind="subtitles" src="demo.captions.vtt" srclang="en" label="English"></track><!-- Tracks need an ending tag thanks to IE9 -->
    </video>
    <script type="text/javascript">
        var myPlayer = videojs('example_video_1');
        videojs("example_video_1").ready(function () {
            var myPlayer = this;
            myPlayer.play();
        });
    </script>
    
    </div>
    </form>
</body>
</html>