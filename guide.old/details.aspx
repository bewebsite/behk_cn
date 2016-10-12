<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="aspx_school_detail" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育-院校详情</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link href="../css/school.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/school-solid.js" type="text/javascript"></script>
    <script src="../js/common.js" type="text/javascript"></script>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="wrap">
        <div class="wrapMain">
            <div class="clear">
            </div>
            <div class="mbx">
                <a href="#">
                    <img src="../images/icon-home.png" /></a> <em></em><a href="#">院校中心</a> <em>
                </em>
                <label>
                    国王布鲁顿中学</label>
            </div>
            <div class="conLeft">
                <div class="block block1">
                    <dl class="clearfix">
                        <dt>
                            <img src="images/img1.jpg" /></dt>
                        <dd class="name">
                            <h1 class="h1">
                                国王布鲁顿中学</h1>
                            <p class="en">
                                King's School Bruton</p>
                            <p class="url">
                                <a href="#" target="_blank">[ 院校官方网址 www.king.com]</a></p>
                        </dd>
                        <dd class="concern">
                            <a href="#"><i>
                                <img src="images/icon-1.png" /></i>立刻关注</a>
                            <p>
                                关注人数：<em>5000人</em></p>
                        </dd>
                    </dl>
                    <div class="text">
                        首尔大学，又称首尔国立大学，成立于1946年，位于韩国首尔，是韩国10所国立旗帜大学中最早建立的一所，一直是韩国国立大学的典范。首尔大学在2011年QS世界大学排名中排名韩国第1位，亚洲第6位,世界第42位.首尔大学，又称首尔国立大学，成立于1946年，位于韩国首尔，是韩国10所国立旗帜大学中最早建立的一所
                    </div>
                    <div class="contact">
                        <span>已有 <em>4636</em> 人与招生官建立联系</span> <a href="#"><i>
                            <img src="images/icon-2.png" /></i>招生官期待与你联系</a>
                    </div>
                </div>
                <div class="block block2">
                    <div id="tFocus">
                        <div class="prev" id="prev">
                        </div>
                        <div class="next" id="next">
                        </div>
                        <ul id="tFocus-pic">
                            <li><a href="#">
                                <img src="images/list-1.jpg" width="840" height="360" alt="面和新功能可不少" /></a></li>
                            <li><a href="#">
                                <img src="images/list-1.jpg" width="840" height="360" alt="面和新功能可不少" /></a></li>
                            <li><a href="#">
                                <img src="images/list-1.jpg" width="840" height="360" alt="面和新功能可不少" /></a></li>
                            <li><a href="#">
                                <img src="images/list-1.jpg" width="840" height="360" alt="面和新功能可不少" /></a></li>
                            <li><a href="#">
                                <img src="images/list-1.jpg" width="840" height="360" alt="面和新功能可不少" /></a></li>
                            <li><a href="#">
                                <img src="images/list-1.jpg" width="840" height="360" alt="面和新功能可不少" /></a></li>
                            <li><a href="#">
                                <img src="images/list-1.jpg" width="840" height="360" alt="面和新功能可不少" /></a></li>
                        </ul>
                        <div id="tFocusBtn">
                            <a href="javascript:void(0);" id="tFocus-leftbtn">上一张</a>
                            <div id="tFocus-btn">
                                <ul>
                                    <li class="active">
                                        <img src="images/list-1.jpg" width="196" height="84" alt="面和新功能可不少" /></li>
                                    <li>
                                        <img src="images/list-1.jpg" width="196" height="84" alt="面和新功能可不少" /></li>
                                    <li>
                                        <img src="images/list-1.jpg" width="196" height="84" alt="面和新功能可不少" /></li>
                                    <li>
                                        <img src="images/list-1.jpg" width="196" height="84" alt="面和新功能可不少" /></li>
                                    <li>
                                        <img src="images/list-1.jpg" width="196" height="84" alt="面和新功能可不少" /></li>
                                    <li>
                                        <img src="images/list-1.jpg" width="196" height="84" alt="面和新功能可不少" /></li>
                                    <li>
                                        <img src="images/list-1.jpg" width="196" height="84" alt="面和新功能可不少" /></li>
                                </ul>
                            </div>
                            <a href="javascript:void(0);" id="tFocus-rightbtn">下一张</a>
                        </div>
                    </div>
                </div>
                <div class="block block3 clearfix">
                    <div class="left">
                        <img src="images/ilogo-1.png" />
                        <span class="bor"></span>
                        <p>
                            荐校理由与<br />
                            申请建议
                        </p>
                    </div>
                    <div class="right">
                        <h3>
                            荐校理由:</h3>
                        <p class="text text1">
                            该校为学生提供个性化的教育，以发掘每位学生的潜能。学校虽然具有悠久的历史，但是教学方针绝不故步自封，会因着现代的教学表凖而改变。该校亦为学生提供很多参加课外活动的机会，以帮助他们全面性的发展。</p>
                        <h3>
                            申请准备及建议:</h3>
                        <p class="text text2">
                            该校建议学生不单是着重于学业上的成就，而需要培养多方面的兴趣：这样才能让学生突围而出。<br />
                            <br />
                        </p>
                    </div>
                </div>
                <div class="block block4 clearfix">
                    <div class="tit">
                        <i>
                            <img src="images/icon-6.png" /></i>学校官员</div>
                    <div class="img">
                        <img src="images/img2.jpg" /></div>
                    <div class="top">
                        <h3>
                            伊恩威尔姆赫斯特</h3>
                        <p>
                            Ian Wilmshurst</p>
                    </div>
                    <div class="bom">
                        <div class="clearfix">
                            <span class="t">职衔 : </span>
                            <div class="text">
                                校长</div>
                        </div>
                        <div class="clearfix">
                            <span class="t">简介 : </span>
                            <div class="text">
                                Peter Roberts 大学毕业于牛津大学，并大学毕业于牛津大学在伦敦大学教育学院进修深造。</div>
                        </div>
                    </div>
                </div>
                <div class="block block5 clearfix">
                    <ul class="clearfix">
                        <li><span>
                            <img src="images/g1.png" /></span>
                            <div>
                                <p>
                                    所在国家</p>
                                <h3>
                                    英国</h3>
                            </div>
                        </li>
                        <li><span>
                            <img src="images/g2.png" /></span>
                            <div>
                                <p>
                                    成立年份</p>
                                <h3>
                                    1519<em>年</em></h3>
                            </div>
                        </li>
                        <li class="noma"><span>
                            <img src="images/g3.png" /></span>
                            <div>
                                <p>
                                    学校类型</p>
                                <h3>
                                    男女混校</h3>
                            </div>
                        </li>
                        <li><span>
                            <img src="images/g4.png" /></span>
                            <div>
                                <p>
                                    招生年龄</p>
                                <h3>
                                    13-18<em>岁</em></h3>
                            </div>
                        </li>
                        <li><span>
                            <img src="images/g5.png" /></span>
                            <div>
                                <p>
                                    学生人数</p>
                                <h3>
                                    118<em>岁</em></h3>
                            </div>
                        </li>
                        <li class="noma"><span>
                            <img src="images/g6.png" /></span>
                            <div>
                                <p>
                                    寄宿学生人数</p>
                                <h3>
                                    118<em>岁</em></h3>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="block block6 clearfix">
                    <table width="100%">
                        <tr class="tr">
                            <td class="td">
                                <table>
                                    <tr>
                                        <td>
                                            学院设置：<span>15个学院</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="tr">
                            <td class="td">
                                <table>
                                    <tr>
                                        <td>
                                            入学平均成绩：<span>（该校没公开）</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="tr">
                            <td class="td">
                                <table width="100%">
                                    <tr>
                                        <td width="25%">
                                            学校类型：<span>男女混校</span>
                                        </td>
                                        <td width="25%">
                                            师生配比：<span>1 : 7</span>
                                        </td>
                                        <td width="25%">
                                            国际学生人数：<span>86人</span>
                                        </td>
                                        <td>
                                            国际学生比例：<span>19%</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="tr">
                            <td class="td">
                                <table width="100%">
                                    <tr>
                                        <td width="25%">
                                            寄宿生比例：<span>59%</span>
                                        </td>
                                        <td width="25%">
                                            中国学生人数：<span>该校没公开</span>
                                        </td>
                                        <td width="25%">
                                            课堂规模：<span>以小班授课</span>
                                        </td>
                                        <td>
                                            每年学费及寄宿费：<span>£26,970</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="tr">
                            <td class="td">
                                <table width="100%">
                                    <tr>
                                        <td width="25%">
                                            学院设置：<span>7个学院</span>
                                        </td>
                                        <td width="25%">
                                            学校规模：<span>1000英亩</span>
                                        </td>
                                        <td width="25%">
                                            录取率：<span>该校没公开</span>
                                        </td>
                                        <td>
                                            入学平均成绩：<span>该校没公开</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="block block7">
                    <div class="title">
                        院校概况
                    </div>
                    <div class="con">
                        <dl class="odd clearfix">
                            <dt>学校简介</dt>
                            <dd>
                                首尔大学，又称首尔国立大学，成立于1946年，位于韩国首尔，是韩国10所国立旗帜大学中最早建立的一所，一直是韩国国立大学的典范。首尔大学在2011年QS世界大学排名中排名韩国第1位，亚洲第6位,世界第42位.首尔大学，又称首尔国立大学，成立于1946年，位于韩国首尔，是韩国10所国立旗帜大学中最早建立的一所，一直是韩国国立大学的典范。首尔大学在2011年QS世界大学排名中排名韩国第1位，亚洲第6位,世界第42位.
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>师资力量</dt>
                            <dd>
                                多于70位教师
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>教学理念</dt>
                            <dd>
                                学着做你自己，并尝试不断超越自己
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>学校特色</dt>
                            <dd>
                                赛德伯中学是一所具有包容性的学校，招收各类学生。学校成立了各种俱乐部和社团，从山地自行车到辩论等，还有各种科学、医学和音乐专家讲座。爱丁堡公爵奖项目特别受学生欢迎。
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>学生关怀</dt>
                            <dd>
                                赛德伯中学建立有效的宿舍管理体系，由管理能力强、受学生们喜爱并且关心爱护学生的舍监进行管理并与学生之间建立了良好的关系。学校制定公正严明的纪律规范，并制定奖励与惩处制度。学校对于欺凌弱小行为予以严肃处理。
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>入学标准</dt>
                            <dd>
                                学生可以考Common Entrance的全国入学试 、或该校设的普通入学试。
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="block block8">
                    <div class="title clearfix">
                        <span class="cur">课程设置</span> <span>学校设施</span>
                    </div>
                    <div class="con" style="display: block;">
                        <dl class="odd clearfix">
                            <dt>学校简介</dt>
                            <dd>
                                首尔大学，又称首尔国立大学，成立于1946年，位于韩国首尔，是韩国10所国立旗帜大学中最早建立的一所，一直是韩国国立大学的典范。首尔大学在2011年QS世界大学排名中排名韩国第1位，亚洲第6位,世界第42位.首尔大学，又称首尔国立大学，成立于1946年，位于韩国首尔，是韩国10所国立旗帜大学中最早建立的一所，一直是韩国国立大学的典范。首尔大学在2011年QS世界大学排名中排名韩国第1位，亚洲第6位,世界第42位.
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>师资力量</dt>
                            <dd>
                                多于70位教师
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>教学理念</dt>
                            <dd>
                                学着做你自己，并尝试不断超越自己
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>学校特色</dt>
                            <dd>
                                赛德伯中学是一所具有包容性的学校，招收各类学生。学校成立了各种俱乐部和社团，从山地自行车到辩论等，还有各种科学、医学和音乐专家讲座。爱丁堡公爵奖项目特别受学生欢迎。
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>学生关怀</dt>
                            <dd>
                                赛德伯中学建立有效的宿舍管理体系，由管理能力强、受学生们喜爱并且关心爱护学生的舍监进行管理并与学生之间建立了良好的关系。学校制定公正严明的纪律规范，并制定奖励与惩处制度。学校对于欺凌弱小行为予以严肃处理。
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>入学标准</dt>
                            <dd>
                                学生可以考Common Entrance的全国入学试 、或该校设的普通入学试。
                            </dd>
                        </dl>
                    </div>
                    <div class="con">
                        <dl class="odd clearfix">
                            <dt>学校简介2</dt>
                            <dd>
                                首尔大学，又称首尔国立大学，成立于1946年，位于韩国首尔，是韩国10所国立旗帜大学中最早建立的一所，一直是韩国国立大学的典范。首尔大学在2011年QS世界大学排名中排名韩国第1位，亚洲第6位,世界第42位.首尔大学，又称首尔国立大学，成立于1946年，位于韩国首尔，是韩国10所国立旗帜大学中最早建立的一所，一直是韩国国立大学的典范。首尔大学在2011年QS世界大学排名中排名韩国第1位，亚洲第6位,世界第42位.
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>师资力量</dt>
                            <dd>
                                多于70位教师
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>教学理念</dt>
                            <dd>
                                学着做你自己，并尝试不断超越自己
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>学校特色</dt>
                            <dd>
                                赛德伯中学是一所具有包容性的学校，招收各类学生。学校成立了各种俱乐部和社团，从山地自行车到辩论等，还有各种科学、医学和音乐专家讲座。爱丁堡公爵奖项目特别受学生欢迎。
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>学生关怀</dt>
                            <dd>
                                赛德伯中学建立有效的宿舍管理体系，由管理能力强、受学生们喜爱并且关心爱护学生的舍监进行管理并与学生之间建立了良好的关系。学校制定公正严明的纪律规范，并制定奖励与惩处制度。学校对于欺凌弱小行为予以严肃处理。
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>入学标准</dt>
                            <dd>
                                学生可以考Common Entrance的全国入学试 、或该校设的普通入学试。
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="block block9">
                    <div class="top">
                        <i>
                            <img src="images/hd1.png" /></i>正在进行的活动
                    </div>
                    <div class="bom clearfix">
                        <div class="img">
                            <a href="#">
                                <img src="images/img3.jpg" /></a>
                        </div>
                        <div class="right">
                            <h3>
                                <a href="#">Lower Sixth students enjoy Chalke Valley History Festival organised by OB
                                    James Holland</a></h3>
                            <div class="list1">
                                <span class="l"><i>
                                    <img src="images/hd2.png" /></i>日期：2015.06.12 — 2016.7.20</span> <span class="r"><i>
                                        <img src="images/hd3.png" /></i>时间：9：00 — 18：00</span>
                            </div>
                            <div class="list2">
                                <i>
                                    <img src="images/hd4.png" /></i>地点：希斯罗</div>
                            <div class="list3">
                                <span class="l-width"><i>
                                    <img src="images/hd5.png" /></i>简介</span><div class="txt">
                                        校举行了一个历史活动，邀请邀请了数位历史教授来为学生举办讲座邀请了数位历史教授来为学生举办讲座了数位历史教授来为学生举办讲座。</div>
                            </div>
                            <div class="list4">
                                <a href="javascript:;" onclick="openYue()">预约活动</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block10">
                    <div class="top">
                        <span>顾问点评</span>
                    </div>
                    <div class="item">
                        <dl>
                            <dt>
                                <img src="images/img4.jpg" /></dt>
                            <dd>
                                <h3>
                                    苏菲<em>|</em>高级教育咨询师</h3>
                                <p class="name">
                                    Sophie Smith</p>
                                <div class="text">
                                    <i class="l"></i><i class="r"></i>该校为学潜能。该校的设备齐全，为学生提供的课外活动也非常丰富。
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="item">
                        <dl>
                            <dt>
                                <img src="images/img4.jpg" /></dt>
                            <dd>
                                <h3>
                                    苏菲<em>|</em>高级教育咨询师</h3>
                                <p class="name">
                                    Sophie Smith</p>
                                <div class="text">
                                    <i class="l"></i><i class="r"></i>该校为学生提供全面性的支持：尤其是其为国际学生提供的英语辅导课程，往往使该学生的英语水平突飞猛进。该校亦非常适合一些在学业成绩未是名列前茅的学生；它会有耐性地培养着这些学生，透过传统的英式寄宿制教育，发掘该学生的潜能。该校的设备齐全，为学生提供的课外活动也非常丰富。
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="block block11">
                    <div class="top">
                        <span>知名校友</span>
                    </div>
                    <div class="tj">
                        <dl class="clearfix">
                            <dt>
                                <img src="images/img2.jpg" width="98" height="110" /></dt>
                            <dd>
                                <h3>
                                    史蒂芬巴洛</h3>
                                <p class="name">
                                    Stephen Barlow</p>
                                <p class="tit">
                                    成就</p>
                                <p class="txt">
                                    歌剧导演</p>
                            </dd>
                        </dl>
                    </div>
                    <p class="else">
                        其他知名校友</p>
                    <div class="con">
                        <dl>
                            <dt>贵族</dt>
                            <dd>
                                Charles Abbott（第一男爵）；Richard Boyle（第一伯爵）
                            </dd>
                        </dl>
                        <dl>
                            <dt>学术界</dt>
                            <dd>
                                Sir Tony Hoare（电脑科学家）；Jeremy Lawrance（语言学家，历史学家）
                            </dd>
                        </dl>
                        <dl>
                            <dt>音乐界</dt>
                            <dd>
                                Simon Carrington；Harry Christophers
                            </dd>
                        </dl>
                        <dl>
                            <dt>作家，诗人，剧作家和记者</dt>
                            <dd>
                                Sebastian Barker；Oz Clarke；Michael Cordy等。
                            </dd>
                        </dl>
                        <dl>
                            <dt>商业</dt>
                            <dd>
                                Ian Cheshire（翠峰集团Kingfisher首席执行官）
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="block block13">
                    <div class="top">
                        <span>学校视频</span>
                    </div>
                    <div class="list">
                        <ul class="clearfix">
                            <li><a href="#" target="_blank">
                                <div class="img">
                                    <p class="popVideo">
                                        <i class="i"></i>
                                    </p>
                                    <img src="images/img5.jpg" /></div>
                                <span>顶尖文理学院招生官见面会</span> </a></li>
                            <li><a href="#" target="_blank">
                                <div class="img">
                                    <p class="popVideo">
                                        <i class="i"></i>
                                    </p>
                                    <img src="images/img5.jpg" /></div>
                                <span>顶尖文理学院招生官见面会</span> </a></li>
                            <li><a href="#" target="_blank">
                                <div class="img">
                                    <p class="popVideo">
                                        <i class="i"></i>
                                    </p>
                                    <img src="images/img5.jpg" /></div>
                                <span>顶尖文理学院招生官见面会</span> </a></li>
                            <li><a href="#" target="_blank">
                                <div class="img">
                                    <p class="popVideo">
                                        <i class="i"></i>
                                    </p>
                                    <img src="images/img5.jpg" /></div>
                                <span>顶尖文理学院招生官见面会</span> </a></li>
                            <li><a href="#" target="_blank">
                                <div class="img">
                                    <p class="popVideo">
                                        <i class="i"></i>
                                    </p>
                                    <img src="images/img5.jpg" /></div>
                                <span>顶尖文理学院招生官见面会</span> </a></li>
                        </ul>
                    </div>
                </div>
                <div class="block block12">
                    <div class="top">
                        <span>必益教育免费选校评估服务预约</span>
                    </div>
                    <p class="tist">
                        对这所学校感兴趣？正确填写并提交下面的信息，预约属于您的专属免费学校评估服务。顾问老师将在您提交信息的48个小时内与您联络，为您完成到访预约。</p>
                    <div class="tips2">
                        必益教育是英国 170 余所学校在华的独家或指定考试中心，能够帮助您准确评估学校入学竞争力，并制定相应的学习计划。
                    </div>
                    <div class="elAud clearfix">
                        <div class="l">
                            <div class="item">
                                <span><em>*</em>您的姓名</span>
                                <div>
                                    <input type="text">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>联络手机</span>
                                <div>
                                    <input type="text">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>邮箱</span>
                                <div>
                                    <input type="text">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>所在城市</span>
                                <div>
                                    <input type="text">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>学生年龄</span>
                                <div>
                                    <input type="text" style="width: 80px;">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>所在年级</span>
                                <div>
                                    <input type="text" style="width: 80px;">
                                </div>
                            </div>
                        </div>
                        <div class="r">
                            <div class="item even">
                                <span><em>*</em>意向出国时间</span>
                                <div>
                                    <input type="text" style="width: 80px;">
                                </div>
                            </div>
                            <div class="item even">
                                <span><em>*</em>当天来宾人数</span>
                                <div>
                                    <input type="text" style="width: 80px;">
                                </div>
                            </div>
                            <div class="item even">
                                <span><em>*</em>留言</span>
                                <div class="textarea">
                                    <textarea></textarea>
                                </div>
                            </div>
                            <div class="btn">
                                <a href="javascript:openPop();">点击完成预约</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="conRight">
                <div class="ad">
                    <a href="#">
                        <img src="images/ad.jpg" /></a>
                </div>
                <div class="maps">
                    <h3 class="adds">
                        学校位置</h3>
                    <div class="con">
                        <img src="images/map1.jpg" width="260" height="140" />
                    </div>
                    <div class="list">
                        <dl class="clearfix">
                            <dt>
                                <img src="images/icon-3.png" /></dt>
                            <dd>
                                <p class="tit">
                                    地理坐标</p>
                                <div class="txt">
                                    51°53′34″N 2°6′18″W
                                </div>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>
                                <img src="images/icon-4.png" /></dt>
                            <dd>
                                <p class="tit">
                                    地理环境
                                </p>
                                <div class="txt">
                                    学校位于英格兰南部的历史名城布鲁顿，被宁静的Somerset山谷环绕。交通仍然十分便利，邻近巴斯，距伦敦也仅两小时车程。
                                </div>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>
                                <img src="images/icon-5.png" /></dt>
                            <dd>
                                <p class="tit">
                                    交通距离</p>
                                <div class="txt">
                                    距离希斯罗机场4小时40分钟车程
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="bom">
                        <p>
                            邮政编码：<span>LA10 5HG</span></p>
                        <p>
                            官方网址：<a href="#" target="_blank">www.sedberghschool.org</a></p>
                    </div>
                </div>
                <div class="news">
                    <h3 class="adds">
                        学校新闻</h3>
                    <div class="con">
                        <a href="#">
                            <img src="images/map1.jpg" width="260" height="140" /></a> <a href="#" class="tit">该校的室乐合唱团该校的室乐合唱团发布了新的唱片发布了新的唱片</a>
                        <p class="text">
                            该校的室乐合唱团发布了新的唱片该校的室乐合唱团片该校的... <a href="#">[ 详细 ]</a></p>
                    </div>
                    <ul class="list">
                        <li><a href="#">该校的室乐合唱团发布了新的唱片</a></li>
                        <li><a href="#">该校的室乐合唱团发布了新的唱片</a></li>
                        <li><a href="#">该校的室乐合唱团发布了新的唱片</a></li>
                    </ul>
                </div>
            </div>
            <div class="clear">
            </div>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
    <div class="popWrapLg">
        <div class="popBor">
            <div class="popWrap">
                <div class="top">
                    <span>预约活动</span>
                    <a href="javascript:;" onclick="openYueClose()" class="close"></a>
                </div>
                <p class="tist">
                    对这所学校感兴趣？正确填写并提交下面的信息，预约属于您的专属免费学校评估服务。顾问老师将在您提交信息的48个小时内与您联络，为您完成到访预约。</p>
                <div class="tips2">
                    必益教育是英国 170 余所学校在华的独家或指定考试中心，能够帮助您准确评估学校入学竞争力，并制定相应的学习计划。
                </div>
                <div class="elAud clearfix">
                    <div class="l">
                        <div class="item">
                            <span><em>*</em>您的姓名</span>
                            <div>
                                <input type="text">
                            </div>
                        </div>
                        <div class="item">
                            <span><em>*</em>联络手机</span>
                            <div>
                                <input type="text">
                            </div>
                        </div>
                        <div class="item">
                            <span><em>*</em>邮箱</span>
                            <div>
                                <input type="text">
                            </div>
                        </div>
                        <div class="item">
                            <span><em>*</em>所在城市</span>
                            <div>
                                <input type="text">
                            </div>
                        </div>
                        <div class="item">
                            <span><em>*</em>学生年龄</span>
                            <div>
                                <input type="text" style="width: 80px;">
                            </div>
                        </div>
                        <div class="item">
                            <span><em>*</em>所在年级</span>
                            <div>
                                <input type="text" style="width: 80px;">
                            </div>
                        </div>
                    </div>
                    <div class="r">
                        <div class="item even">
                            <span><em>*</em>意向出国时间</span>
                            <div>
                                <input type="text" style="width: 80px;">
                            </div>
                        </div>
                        <div class="item even">
                            <span><em>*</em>当天来宾人数</span>
                            <div>
                                <input type="text" style="width: 80px;">
                            </div>
                        </div>
                        <div class="item even">
                            <span><em>*</em>留言</span>
                            <div class="textarea">
                                <textarea></textarea>
                            </div>
                        </div>
                        <div class="btn">
                            <a href="javascript:openPop();">点击完成预约</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        addLoadEvent(Focus());

        $(function () {
            $(".block6 .tr:odd").css({
                background: "#eceff3"
            })

            $(".block8 .title span").bind("click", function () {
                var _index = $(this).index();

                $(this).siblings("span").removeClass("cur").end().addClass("cur");
                $(".block8 .con").hide().eq(_index).slideDown();
            })
        })

        function openYue() {

            $(".popWrapLg").fadeIn();
        }

        function openYueClose() {

            $(".popWrapLg").fadeOut();
        }
        
    </script>
</body>
</html>
