<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="about_Default" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育|必益介绍</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/about.css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="about-wrap">
        <div class="clear">
        </div>
        <div class="about-main">
            <div class="ab-crumbs">
                <a href="/">
                    <img src="../images/about/ic-home.png" /></a><em>></em><a href="/about/">关于必益</a><em>></em><span>简介</span>
            </div>
            <div class="ab-brief">
                <div class="ab-ban">
                    <%=GetBanner() %></div>
                <%--<div class="jy">
                    <p class="p1">
                        <span>使命：</span>
                        <%=s.Mission %></p>
                    <p class="p2">
                        <span>愿景：</span>
                        <%=s.Vision %></p>
                    <p class="p3">
                        <span>价值观：</span>
                        <%=s.Value %></p>
                </div>--%>
            </div>
            <%-- <div class="ab-education">
                <h3 class="hd">
                    关于必益教育</h3>
                <div class="edu-brief">
                   
                </div>
            </div>--%>
            <%=s.Content %>


            <!-- <DIV id="about" class="about" style="background:white;">
        
        <DIV style="float:left;width:520px;margin:120px 50px;color:#666" >
        <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;十多年前，我帮助一个朋友的孩子成功进入了斯多中学，这是我们事业的起点；多年后的今天，我们已经成为了一家在英国、上海、北京、天津、成都、深圳都有分支机构的全球化企业，在国际教育方面硕果累累。越来越多的中国家庭通过我们的帮助送孩子去英美读中学，而且瞄准的都是一些类似伊顿公学、哈罗公学、威科姆阿贝学校之类的顶尖学校。同时，我们还与英国最好的女子中学，威科姆阿贝学校合作成立国际学校，为未来的领导者提供国际化教育的温床。</p>

        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;教育是最好的投资，越来越多的高净值家庭开始认识到这一点。而随着亚洲的富裕家庭不断增多，家长们的家庭教育规划理念也在不断地发生积极的变化。而我们的使命，就是本着诚实正直的行为准则，为每一个学生，找到最适合他们的教育，成就人生和梦想。</p>

        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;多年如一日，我们始终全力以赴为学生实现最大利益，这是我们的立身之本，也是我们成为优质教育企业的基石。
        </P>
        </DIV> -->
        <!-- <DIV style="float:right;width:300px;margin-right: 200px;margin-top: 50px;">
            <video autoplay="autoplay" loop="true" controls="controls" width="450px" height="280px">
                <source src="/images/aboutbe.mp4" type="video/mp4">必益教育</source>
                您的浏览器不支持video标签 
            </video>
            <!-- <p style="margin:0.5em;padding:0;text-align:center">必益教育</p>
        </DIV>  -->
        <DIV style="clear:both"></DIV>
            



            <div class="ab-more">
                <h3>
                    了解更多<em></em></h3>
                <div class="abList clearfix">
                    <div class="panel-C">
                           <div class="panel-inner clearfix">
                            <div class="panle-visible">
                                <img src="../images/about/about4.jpg" width="285" height="340" />
                                <div class="panle-visible-txt">
                                    英美入学培训
                                </div>
                            </div>
                            <div class="panel-extra">
                                <h4>
                                    英美入学培训</h4>
                                <p>
                                    培训中心拥有雄厚的师资力量，校长卢敏军为硕士学历，具备副教授职称，具有二十年左右的教师经验，同时从事教育行业数十年。在其带领下，培训中心已经拥有多名骨干教师，每位教师均具有多年教学经验并具备较高教学水平。培训中心一直致力于为学生打造一个全英文授课环境以快速提高学生学习效率及实际运用能力，从而帮助学生实现梦想。</p>
                                    <a href="http://www.beacademy.org/2016/">
                                    <div style="background: red;width: 200px;height: 20px;text-align: center;" >上海静安区必益教育培训中心</div>
                                    </a>
                                <!--
                                <p class="panel-btn">
                                    <a href="http://www.be.co/zh-hans/guanyuwomen/" target="_blank">了解更多</a><a href="/team/t-creater.aspx">创始人简介</a></p>
                                    -->
                            </div>
                        </div>
                        <div class="panel-tit-c" style="">
                            <p class="panel-tit">
                                英美入学培训</p>
                        </div>
                    </div>
                    <div class="panel-C">
                        <div class="panel-inner clearfix">
                            <div class="panle-visible">
                                <img src="../images/about/about2.jpg" width="285" height="340" />
                                <div class="panle-visible-txt">
                                    海外教育咨询
                                </div>
                            </div>
                            <div class="panel-extra">
                                <h4>
                                    海外教育咨询</h4>
                                <p>
                                    必益是华申国际教育旗下高端留学品牌，专注国际教育咨询服务逾14年，本着诚信正直的行为准则，全力以赴为学生实现最大利益，为想要入读全球知名学府的学生提供高端国际教育咨询服务，从度身定制的留学计划、申请准备到留学后长期跟踪服务，坚持以学生为本，帮助他们入读梦想中的英美精英学府。</p>
                               <!--
                                <p class="panel-btn">
                                    <a href="http://www.be.co/zh-hans/chuguoliuxue/" target="_blank">了解更多</a></p>
                                    -->
                            </div>
                        </div>
                        <div class="panel-tit-c">
                            <p class="panel-tit">
                                海外教育咨询</p>
                        </div>
                    </div>
                    <div class="panel-C">
                        <div class="panel-inner clearfix">
                            <div class="panle-visible">
                                <img src="../images/about/about1.jpg" width="285" height="340" />
                                <div class="panle-visible-txt">
                                    假期研修班
                                </div>
                            </div>
                            <div class="panel-extra">
                                <h4>
                                    假期研修班</h4>
                                <p>
                                    你想在英国、美国或瑞士度过一个美好的假期吗？必益教育携手British Education Limited致力于为中国学生打造一段意义非凡的假期出国研修项目。许多参加过暑期研修班的学员都获得了继续在海外顶尖中学及大学深造的机会。假期研修班项目也为许多不能或不愿出国学习的同学提供了一个增补全英文环境下学习经验的机会。</p>
                               <!--
                                <p class="panel-btn">
                                    <a href="http://www.bestudyabroad.org/zh-hans/" target="_blank">了解更多</a></p>
                                    -->
                            </div>
                        </div>
                        <div class="panel-tit-c">
                            <p class="panel-tit">
                                假期研修班</p>
                        </div>
                    </div>
                    <div class="panel-C">
                        <div class="panel-inner clearfix">
                            <div class="panle-visible">
                                <img src="../images/about/about3.jpg" width="285" height="340" />
                                <div class="panle-visible-txt">
                                    牛津国际公学
                                </div>
                            </div>
                            <div class="panel-extra">
                                <h4>
                                    牛津国际公学</h4>
                                <p>
                                    秉承英格兰著名学府几百年的传统，牛津国际公学提供给未来中国领导者的是最好的英语教育。牛津国际公学提供不同于传统教育的、严谨的并且得到国际认可的英国A-Level和IGCSE课程。课程同时注重批判性思维和创意，这些对学生将来在世界顶级大学获得成功至关重要。至今牛津国际公学所有毕业生皆被世界排名前50位的大学所录取。</p>
                                <p class="panel-btn">
                                    <a href="http://www.czoic.com/zh-hans/" target="_blank">牛津国际公学常州学校 </a><a href="http://www.chengduoic.com/zh-hans/"
                                        target="_blank">牛津国际公学成都学校</a></p>
                            </div>
                        </div>
                        <div class="panel-tit-c">
                            <p class="panel-tit">
                                牛津国际公学</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
    <script type="text/javascript">
        $(function () {
            var ie = $.browser.msie;
            var ver = $.browser.version;
            var $panel = $(".abList .panel-C");
            var $panelTitC = $(".panel-tit-c");
            if (!ie && !(ver == "10.0")) {
                $panel.hover(function () {

                    $(this).not().siblings().each(function () {

                        $(this).stop().animate({ width: "5%" });
                        $(this).children('.panel-tit-c').show();
                        var $panelTitle = $(".panel-tit-c").children(".panel-tit");
                        $panelTitle.css({ "top": "143px", "left": "-143px" });

                    });
                    $(this).stop().animate({ width: "85%" }).children('.panel-tit-c').hide();

                }, function () {
                    $panel.stop().animate({ width: "25%" });
                    $panelTitC.hide();

                });
            } else {

                $panel.hover(function () {

                    $(this).not().siblings().each(function () {

                        $(this).stop().animate({ width: "5%" });
                        $(this).children('.panel-tit-c').show();
                        var $panelTitle = $(".panel-tit-c").children(".panel-tit");

                        $panelTitle.css({ "filter": "progid:DXImageTransform.Microsoft.BasicImage(rotation=1)" });


                    });
                    $(this).stop().animate({ width: "85%" }).children('.panel-tit-c').hide();

                }, function () {
                    $panel.stop().animate({ width: "25%" });
                    $panelTitC.hide();

                });

            }
        })
    </script>
</body>
</html>
