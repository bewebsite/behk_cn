<%@ Page Language="C#" AutoEventWireup="true" CodeFile="multi-schools.aspx.cs" Inherits="alis_multi_schools" %>



<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>2016年9月多校联盟直招-全球精英寄宿学校联盟ALIS</title>
    <meta name="Keywords" content="必益教育全球精英寄宿学校联盟" />
    <meta name="Description" content="必益教育全球精英寄宿学校联盟" />
    <link type="text/css" rel="stylesheet" href="guide/css/reset.css" />
    <link type="text/css" rel="stylesheet" href="css/common.css" />
    
   <script type="text/javascript" src="guide/js/jquery.js"></script>
    
    <script type="text/javascript" src="guide/js/common.js"></script>
    <script src="js/layer/layer.js" type="text/javascript"></script>
    <script src="js/base.js" type="text/javascript"></script>
    <script src="guide/js/guide.js" type="text/javascript"></script>

    <!-- 跟踪代码 -->
    <script> 
    var _hmt = _hmt || []; 
    (function() { 
    var hm = document.createElement("script"); 
    hm.src = "//hm.baidu.com/hm.js?fc1ae77ade463aa799dd7a87e5192750"; 
    var s = document.getElementsByTagName("script")[0]; 
    s.parentNode.insertBefore(hm, s); 
    })(); 
    </script>

    <style>
        body,h1,h2,h3,h4,h5,h6,p,ul,li,dl,dt,dd{padding:0;margin:0;}
        li{list-style:none;}img{border:none;}em{font-style:normal;}
        
        
        body{font-size:12px;font-family:Arial,Verdana, Helvetica, sans-serif;word-break:break-all;word-wrap:break-word;}
        .clear{height:0;overflow:hidden;clear:both;}
        .UpLayer{display: table;height: 48px;width: 250px;font-family: Microsoft yahei;background-color:#DC2F33; }
        .UpLayer dl dt{width:150px;position:absolute; z-index:3;line-height:20px;}
        .UpLayer02{ background:#DC2F33;margin-right: 1px; }
        .UpLayer dl dd{ width: 250px;position: absolute;z-index: 2;line-height: 48px;background: #DC2F33;display: none;margin: 48px 0 0 0px;}
        .UpLayer dl dd a{ }
    </style>
    
    
</head>
<body>

<!-- GA代码 -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-78840611-1', 'auto');
  ga('send', 'pageview');

</script>
<!-- GA代码 -->

    <div class="nav-main clearfix">
        <div class="fl">
            <a href="" target="_blank">
                <img style="width: 200px;" src="guide/images/alis-logo.jpg" ></a></div>
            <div class="nav-tel">
                全国免费咨询热线：
            
                
                <h2>
                    400-850-4118</h2>
            </div>

        <div class="nav-menubox" style="margin-top: 40px;">
        	<div class="nav-menu">
                <a target="_blank" href="multi-schools.aspx" class="nav-linkbox" style="background: #00418F;color: white;">2016年9月多校联盟直招</a>
            </div>
            
           <!--  <div class="nav-menu" style="">
                <a target="_blank" href="eton.aspx" class="nav-linkbox">2016年7月伊顿公学专场</a>
            </div> -->
            
            <div class="nav-menu">
                <a target="_blank" href="about-alis.aspx" style="cursor: pointer" class="nav-linkbox">关于Alis-精英寄宿学校联盟</a>
            </div>
            
        </div>
    </div>
    <div class="vbanner">
        <img src="guide/images/multi-schools.jpg" class="img" />
        <div class="text" style="margin-left: 180px;margin-top: -80px;">
            <%--  <p>
                <img src="http://www.behk.org/guide/images/vTexxt.png" alt="2015 暨首届英国精英寄宿学校联盟中国招生峰会" /></p>--%>
            <p class="a">
                <a href="#book" class="a1">
                    <img src="http://www.behk.org/guide/images/v1.png" alt="我要预约" /></a> <a href="javascript:void(0)" onclick="openChat('g')"
                        class="a2">
                        <img src="/guide/images/v2.png" alt="在线咨询" /></a>
            </p>
        </div>
    </div>
    <div class="barNav">
        <div class="fxdNav">
        <div style="width: 50%;float:left; margin-left: 15%;">
            <a href="#about" v="about">活动简介</a>
            <em>|</em>
            <a href="#audience" v="audience">适用人群</a>
            <em>|</em>
            <a href="#highlights" v="highlights">活动亮点</a>
            <em>|</em>
            <a href="#schedule1" v="schedule1">活动行程</a>
            <em>|</em>
            <a href="#schools" v="schools">招生院校</a>
            <em>|</em>
            <a href="#schools" v="schools">主办方</a>
            <em>|</em>
            <a href="#be" v="be">承办方</a>
            <em>|</em>
            <!-- <a href="#book" v="book">报名方式</a>
            <em>|</em> -->
        </div>
        
        <div style="width: 10% ; float: left;">   
            <div class="UpLayer" style="width: 150px">
    <dl>
        <dt><a href="#book" style="line-height: 46px;
}">预约面试 </a></dt>
        <!-- <dd>
            <a target="_blank" href="eton.aspx">2016年7月伊顿公学专场</a> 
        </dd> -->
    </dl> 
</div><br><br>
         </div>
            <script type="text/javascript">
            $(document).ready(function(){
                var objStr = ".UpLayer";
                $(objStr).each(function(i){
                    $(this).click(function(){
                        $($(objStr+" dd")[i]).show();
                        $($(objStr+" dt")[i]).addClass("UpLayer02");
                    });
                    $(this).hover(function(){},function(){
                        $($(objStr+" dd")[i]).hide();
                        $($(objStr+" dt")[i]).removeClass("UpLayer02");
                    }); 
                });
            });
            </script>

        </div>
    </div>
    

    <div id="about" class="about">
     <div class="main">
        <P class="titImg"><IMG src="/guide/images/tit1.png" alt="活动简介" style="margin-top:-60px;"></P>
        
        <table>
            <tbody><tr>
                <td>
                    <img src="/guide/images/imgabout.jpg" alt="活动简介">
                </td>
                <td>
                    <div>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2016年9月11日和15日，全球精英寄宿学校联盟 (Association of Leading Independent Schools) 将携英国十余所知名寄宿中学的校长或招生长官分别在中国北京和上海两地举行招生联展。其中包括著名的英国九大公学之一拉格比中学；全英排名11，凯特王妃的母校唐屋女子中学；全英排名第10的切尔滕纳姆女子学院；英国最古老寄宿学校之一国王坎特伯雷学校； Virgin集团创始人的母校斯多中学等。本活动正在进行，有意参与的学生和家长需尽快预约测试时间，测试完成必益教育将为学生建立评估卷宗，并安排校方在招生活动当日进行面试机会。<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;测试预约截至9月7日，还没有报名的学生和家长请尽快报名，报名方式详见页面底部信息。
                        
                        
                    </div>
                </td>
            </tr>
        </tbody></table>
        
        <div style="clear:both"></div>
    </div>
    </div>

    <div class="audience" id="audience">
        <div class="main">
            <p class="titImg">
                <img src="/guide/images/tit2.png" alt="适用人群">
            </p>
            <div class="clearfix audDl">
                <dl>
                    <dt>01 </dt>
                    <dd>
                        <div>
                            <p class="p1">
                                任何年龄在11-16岁<br>
                                并计划申请英国精英中学的学生</p>
                            <p class="p2">
                                任何年龄在11-16岁<br>
                                并计划申请英国精英中学的学生</p>
                        </div>
                    </dd>
                </dl>
                <dl class="c">
                    <dt>02 </dt>
                    <dd>
                        <div>
                            <p class="p1">
                                任何计划安排子女留学英国<br>
                                并接受国际教育的中国高净值家庭</p>
                            <p class="p2">
                                任何计划安排子女留学英国<br>
                                并接受国际教育的中国高净值家庭</p>
                        </div>
                    </dd>
                </dl>
                <dl class="r">
                    <dt>03 </dt>
                    <dd>
                        <div>
                            <p class="p1">
                                任何计划入读或已经申请来访学校<br>
                                需要预约进行校方直接面试的学生</p>
                            <p class="p2">
                                任何计划入读或已经申请来访学校<br>
                                需要预约进行校方直接面试的学生</p>
                        </div>
                    </dd>
                </dl>
            </div>
            <div class="elAud">
                <span class="tps">您符合条件吗</span>
                <p class="tps2">
                    <img src="/guide/images/txt1.png" alt="填写下面的表单即可免费报名参加活动啦！"></p>
                <div class="clearfix">
                    <div class="item">
                        <span><em style="color:red">*</em>&nbsp;您的姓名</span>
                        <div>
                            <input type="text" id="txt_Name1" maxlength="10">
                        </div>
                    </div>
                    <div class="item even">
                        <span><em style="color:red">*</em>&nbsp;面试志愿学校一</span>
                        <div>
                            <select id="want11">
                                <option>唐屋女子中学</option>
                                    <option selected="selected">凯特汉姆学校</option>
                                    <option>拉格比中学</option>
                                    <option>国王坎特伯雷学校</option>
                                    <option>丁克洛斯中学</option>
                                    <option>伊斯堡学院</option>
                                    <option>斯多中学</option>
                                    <option>赛德伯中学</option>
                                    <option>国王布鲁顿中学</option>
                                    <option>米尔菲尔德学校</option>
                                    <option>哈利伯瑞中学</option>
                                    <option> 切尔滕纳姆女子学院</option>
                            </select>
                        </div>
                    </div>
                    <div class="item">
                        <span><em style="color:red">*</em>&nbsp;联络手机</span>
                        <div>
                            <input type="text" id="txt_Mobile1" maxlength="11">
                        </div>
                    </div>
                    <div class="item even">
                        <span><em style="color:red">*</em>&nbsp;面试志愿学校二</span>
                        <div>
                            <select id="want12">
                                <option>唐屋女子中学</option>
                                    <option selected="selected">凯特汉姆学校</option>
                                    <option>拉格比中学</option>
                                    <option>国王坎特伯雷学校</option>
                                    <option>丁克洛斯中学</option>
                                    <option>伊斯堡学院</option>
                                    <option>斯多中学</option>
                                    <option>赛德伯中学</option>
                                    <option>国王布鲁顿中学</option>
                                    <option>米尔菲尔德学校</option>
                                    <option>哈利伯瑞中学</option>
                                    <option> 切尔滕纳姆女子学院</option>
                            </select>
                        </div>
                    </div>
                    <div class="item">
                        <span>所在城市</span>
                        <div>
                            <input type="text" id="txt_City1" maxlength="15">
                        </div>
                    </div>
                    <div class="item even">
                        <span>面试地点</span>
                        <div>
                            <select id="place1">
                                <option>北京 9月11日</option>
                                    <option>上海 9月15日</option>
                            </select>
                        </div>
                    </div>
                    <div class="item">
                        <span>学生年龄</span>
                        <div>
                            <input type="text" id="txt_Age1" maxlength="10">
                        </div>
                    </div>
                    <div class="item even">
                        <span>当天来宾人数</span>
                        <div>
                            <input type="text" id="txt_Num1" maxlength="10">
                        </div>
                    </div>
                    <div class="item">
                        <span>所在年级</span>
                        <div>
                            <input type="text" id="txt_Grade1" maxlength="10">
                        </div>
                    </div>
                    <div class="item even">
                        <span>留言</span>
                        <div>
                            <input type="text" id="txt_Comment1" maxlength="50">
                        </div>
                    </div>
                    <div class="item">
                        <span>意向出国时间</span>
                        <div>
                            <input type="text" id="txt_WantTime1" maxlength="20">
                        </div>
                    </div>
                    <div class="btn">
                        <a href="javascript:void(0);" onclick="Join()" id="xxx2">点击完成预约</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="highlights" id="highlights" >
        <div class="main">
            <p class="titImg">
                <img src="/guide/images/tit3.png" alt="活动亮点" />
            </p>
            <ul class="clearfix" style="margin-left: 155px;">
            	<li class="s1"><span></span>
                    <h5>
                        精英名校荟萃</h5>
                    <p>
                        12所英国精英名学招生官齐聚北京上海</p>
                </li>

                <li class="s6"><span></span>
                    <h5>
                        现场直面招生</h5>
                    <p>
                        校方决策长官及招生人员亲临现场进行面试并录取</p>
                </li>

                <li class="s3"><span></span>
                    <h5>
                        政策解读</h5>
                    <p>
                        现场解读英国留学新政及申请秘诀</p>
                </li>

            </ul>
        </div>
    </div>
    
    
    
    

<div class="schedule1" id="schedule1" style="background-color:  #ebedf0;">
        <div class="main">
            <p class="titImg">
                <img src="/guide/images/tit4.png" alt="展会行程" />
            </p>
            <div class="left cons">
                <p class="ctit">
                    北京(BeiJing)</p>
                <div class="oTxt">
                    <p class="top">
                        时间：<span>2016.9.11 9:00 – 18:00</span><br />
                        地点：<span>北京雍和宫翰林书院（国子监）</span>
                    </p>
                    <p>
                        活动内容包括</p>
                    <div class="txt">
                        <ul>
                            <li><em>1</em>一对一现场招生面试</li>
                            <li><em>2</em>高端国际教育讲座</li>
                            <li><em>3</em>免费家庭教育规划专家咨询</li>
                        </ul>
                        <div class="btn">
                            <a href="#book">我要预约</a> <a href="javascript:void(0)" onclick="openChat('g')" class="v2">
                                在线咨询</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="right cons">
                <p class="ctit">
                    上海(SHANGHAI)</p>
                <div class="oTxt">
                    <p class="top">
                        时间：<span>2016.9.15 9:00 – 18:00</span><br />
                        地点：<span>上海市黄浦区河南中路88号（威斯汀大饭店）</span>
                    </p>
                    <p>
                        活动内容包括</p>
                    <div class="txt">
                        <ul>
                            <li><em>1</em>一对一现场招生面试</li>
                            <li><em>2</em>高端国际教育讲座</li>
                            <li><em>3</em>免费家庭教育规划专家咨询</li>
                        </ul>
                        <div class="btn">
                            <a href="#book">我要预约</a> <a href="javascript:void(0)" onclick="openChat('g')" class="v2">
                                在线咨询</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clear">
            </div>
        </div>
    </div>


 	<div class="schools" id="schools">
    <div class="main">
        <p class="titImg">
            <img src="../guide/images/tit6.png" alt="英国精英寄宿学校联盟参展招生院校" />
        </p>
        <div class="txt">
            <table width="100%">
                <th>
                    <img src="../guide/images/school2.jpg" width="142" height="88" />
                </th>
                <td>
                    <div class="con">
                        精英寄宿学校联盟 (Association of Leading Independent Schools) 是由来自英国、美国和瑞士等国家的精英寄宿学校组成的教育组织，每年通过在全球主要城市举办招生及教育推广活动，在院校行政长官和高级招生官员与学生家庭之间建立直接沟通的桥梁，同时为优秀中小学生提供直接进入世界精英寄宿学校学习的机遇和便利。<br/> 
                        2016 中国招生活动是精英寄宿学校联盟在华举办的第二届大型教育活动，汇聚来自英国的10余所知名寄宿学校，携手国际教育咨询机构必益教育，为优秀中国中小学生提供申请预评估及校方直接面试录取的捷径，也是有意赴英国入读精英寄宿学府的学生入读海外名校的好机会。
                        </div>
                </td>
            </table>
        </div>
        <div class="sclList clearfix">
        				<div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=49" title="唐屋女子中学" target="_blank">
                                        <img src="guide/images/downehouse.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=49" title="Wycombe Abbey School" target="_blank">
                                           唐屋女子中学</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=49" title="唐屋女子中学" target="_blank">
                                             Downe House </a></h4>
                                </div>
                                <div class="add">全英寄宿学校中排名第11<br/>英国凯特王妃的母校</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                Michelle Scott
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                副校长
                                            </td>
                                        </tr>
                                    </tbody>
                                    
                                    </table>
                                
                            </div>
                            
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=32" title="凯特汉姆学校" target="_blank">
                                        <img src="guide/images/Caterham School.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=32" title="Caterham School" target="_blank">
                                             凯特汉姆学校</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=32" title="凯特汉姆学校" target="_blank">
                                            Caterham School</a></h4>
                                </div>
                                <div class="add">全英寄宿学校中排名第19<br/>2015年，64.4%的学生A-level成绩达到A和A*</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                Matthew Godfrey
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                外事长官
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=124" title="拉格比中学" target="_blank">
                                        <img src="guide/images/Rugby School.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=124" title="拉格比中学" target="_blank">
                                            拉格比中学</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=124" title="Rugby School" target="_blank">
                                            Rugby School</a></h4>
                                </div>
                                <div class="add">英国九大公学之一<br/>英国橄榄球的发源地</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                Guy Steele-Bodger
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                招生官
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=168" title="国王坎特伯雷学校" target="_blank">
                                        <img src="guide/images/King's School Canterbury.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=168" title="国王坎特伯雷学校" target="_blank">
                                            国王坎特伯雷学校</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=168" title="King's School Canterbury" target="_blank">
                                            King's School Canterbury</a></h4>
                                </div>
                                <div class="add">全英寄宿学校排名第36<br/>最古老的寄宿制学校之一</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                Graham Sinclair
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                教务处主任
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=45" title="丁克洛斯中学" target="_blank">
                                        <img src="guide/images/Dean Close Senior School.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=45" title="丁克洛斯中学" target="_blank">
                                            丁克洛斯中学</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=45" title="Dean Close Senior School" target="_blank">
                                            Dean Close Senior School</a></h4>
                                </div>
                                <div class="add">2015年，98%的学生通过了A-level考试<br/>每年会举办超过50场音乐会</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                Mary-Ann Mcclaran
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                招生顾问
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=52" title="伊斯堡学院" target="_blank">
                                        <img src="guide/images/Eastbourne College.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=52" title="伊斯堡学院" target="_blank">
                                            伊斯堡学院 </a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=52" title="Eastbourne College中学" target="_blank">
                                            Eastbourne College</a></h4>
                                </div>
                                <div class="add">70%以上的学生进了他们的第一志愿大学<br/>其职业选择项目从10年级开始为学生规划前程</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                Oliver Marlow
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                外事长官
                                            </td>
                                        </tr>
                                    </tbody></table>
                                
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=161" title="斯多中学" target="_blank">
                                        <img src="guide/images/Stowe School.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=161" title="斯多中学" target="_blank">
                                            斯多中学 </a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=161" title="Stowe School" target="_blank">
                                            Stowe School</a></h4>
                                </div>
                                <div class="add">维珍集团创始人理查德·布兰森的母校<br/>拥有自己的马术中心</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                David Fletcher
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                招生官
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=129" title="赛德伯中学" target="_blank">
                                        <img src="guide/images/Sedbergh School.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=129" title="赛德伯中学" target="_blank">
                                            赛德伯中学</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=129" title="Sedbergh School" target="_blank">
                                            Sedbergh School</a></h4>
                                </div>
                                <div class="add">2015年，55.3%的学生GCSE成绩达到A和A*<br/>提供34种不同的体育活动，及音乐和戏剧的国内外演出机会</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                Jackie Walkom
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                国际生招生官
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=75" title="国王布鲁顿中学" target="_blank">
                                        <img src="guide/images/King's School Bruton.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=75" title="国王布鲁顿中学" target="_blank">
                                            国王布鲁顿中学</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=75" title="King's School Bruton" target="_blank">
                                            King's School Bruton</a></h4>
                                </div>
                                <div class="add">英格兰西南区最好的小型学校之一<br/>今年是该校的500周年纪念</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                Anton Kok
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                教学总监
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=94" title="切尔滕纳姆女子学院" target="_blank">
                                        <img src="guide/images/The Cheltenham Ladies’ College.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=34" title="切尔滕纳姆女子学院" target="_blank">
                                            切尔滕纳姆女子学院</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=34" title="Millfield School" target="_blank">
                                            The Cheltenham Ladies’ College</a></h4>
                                </div>
                                <div class="add">全英寄宿学校中排名第10<br/>该学校的IB课程被评为全英寄宿中学最佳课程之一</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td  style="font-size:12px">
                                                Charlotte Miranda Coull
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                招生顾问
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=94" title="哈利伯瑞中学" target="_blank">
                                        <img src="guide/images/Haileybury.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=62" title="哈利伯瑞中学" target="_blank">
                                            哈利伯瑞中学</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=62" title="Haileybury" target="_blank">
                                            Haileybury</a></h4>
                                </div>
                                <div class="add">全英IB课程表现最好的学校之一<br/>有众多TED演讲者都出自该校</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                Angus Head
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                副校长
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>

                        <div class="item ">
                            <div class="left">
                                <div class="top">
                                    <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=94" title="米尔菲尔德学校" target="_blank">
                                        <img src="guide/images/Millfield School.png" width="125" height="125" data-evernote-hover-show="true" style="margin-top: 20px;"></a></div>
                                
                            </div>
                            <div class="right">
                                <div class="top">
                                    <p class="tit1">
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=94" title="米尔菲尔德学校" target="_blank">
                                            米尔菲尔德学校</a></p>
                                    <h4>
                                        <a href="http://www.schoolsguide.com.cn/xinxuexiaoyemian/?id=94" title="Millfield School" target="_blank">
                                            Millfield School</a></h4>
                                </div>
                                <div class="add">被称为英国运动最棒的学校，拿过多种运动项目的全国冠军<br/>29%的学生毕业后入读罗素盟校大学（牛津、剑桥、曼彻斯特等20所顶级英校）</div>
                                <table width="100%">
                                        <tbody><tr>
                                            <td width="100">
                                                来访长官姓名：
                                            </td>
                                            <td>
                                                James Postle
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                来访长官职衔：
                                            </td>
                                            <td>
                                                教务处主任
                                            </td>
                                        </tr>
                                    </tbody></table>
                            </div>
                            <div class="aList">
                                        <a href="#book">预约面试</a> 
                                    </div>
                        </div>
        </div>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;（以上数据和描述皆来自学校官网）</p>
       </div>
       </div>

       <div class="be" id="be">
        <div class="main">
        <p class="titImg">
                <img src="http://www.behk.org/alis/guide/images/tit13.png" alt="承办方" data-evernote-hover-show="true">
            </p>
            
                <dl class="dl06">
                    <dt><img src="guide/images/logo.png" data-evernote-hover-show="true" style="margin-top: 0px;">
                        <img src="guide/images/huashenlogo.png" data-evernote-hover-show="true" style="margin-top: 60px;width: 80px">
                    </dt>
                    <dd>
                        <div class="box">
                            必益教育是英国40余所精英寄宿中学入学考试在中国的考点或指定考点<br>
                            必益教育是英国A-Level入学考试主办方的合作伙伴之一<br>
                            必益教育是英国私立中小学升学考试Common Entrance和UKiset考试在华考点<br>
                            必益教育已经连续七年蝉联胡润百富至尚优品“中国最受青睐高端国际教育咨询品牌”大奖<br>
                            <br>
                            上海华申国际教育交流有限公司，是上海华东师范大学所属的、是经教育部、公安部、国家工商总局特许的专门从事出国留学服务、出国前培训的机构，为上海市首批被批准有此专营特许的十四家机构之一。
                        </div>
                    </dd>
                </dl>
            
        </div>
        </div>
    
    <div class="book" id="book" style="background-color: #ebedf0;">
        <div class="main">
            <p class="titImg">
                <img src="/guide/images/tit9.png" alt="现在免费报名参加" />
            </p>
            <div class="bookClear clearfix">
                <div class="left">
                    <p>
                        如果您是目前居住在中国境内的学生或家长，对赴国外入读中学阶段课程感兴趣或已有相关计划，请即刻通过下述方式预约全球精英寄宿名校面试机会！</p>
                    <p>
                        &nbsp;</p>
                    <dl class="clearfix">
                        <dt>
                            <img src="/guide/images/ic1.png" /></dt>
                        <dd>
                            <p class="p1">
                                电话报名:
                            </p>
                            <p>
                                现在拨打活动预约专线 400 850 4118预约您和家人的席位
                            </p>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="/guide/images/ic2.png" /></dt>
                        <dd>
                            <p class="p1">
                                微信报名:
                            </p>
                            <p>
                                添加必益教育微信官号 BEeducation、发送信息 “您的姓名+手机号+名校招生”
                            </p>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="/guide/images/ic3.png" /></dt>
                        <dd>
                            <p class="p1">
                                联络顾问 :
                            </p>
                            <p>
                                联络您熟悉的必益教育顾问，预约您和家人的席位</p>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="/guide/images/ic4.png" /></dt>
                        <dd>
                            <p class="p1">
                                网站报名 :
                            </p>
                            <p>
                                正确填写右侧表单信息，预约您和家人的席位</p>
                        </dd>
                    </dl>
                    <p style="margin-left: 55px; color: #999999;">
                        注：请遵守国家法规，自觉使用文明用语。</p>
                </div>
                <div class="right">
                    <div class="clearfix">
                        <div class="item">
                            <span><em style="color:red">*</em>&nbsp;您的姓名</span>
                            <div>
                                <input type="text" id="txt_Name2" maxlength="10">
                            </div>
                        </div>
                        <div class="item">
                            <span><em style="color:red">*</em>&nbsp;联络手机</span>
                            <div>
                                <input type="text" id="txt_Mobile2" maxlength="11">
                            </div>
                        </div>
                        <div class="item">
                            <span>&nbsp;&nbsp;所在城市</span>
                            <div>
                                <input type="text" id="txt_City2" maxlength="15">
                            </div>
                        </div>
                        <div class="item">
                            <span>&nbsp;&nbsp;学生年龄</span>
                            <div>
                                <input type="text" id="txt_Age2" maxlength="10">
                            </div>
                        </div>
                        <div class="item">
                            <span>&nbsp;&nbsp;所在年级</span>
                            <div>
                                <input style="width: 100px;" type="text" id="txt_Grade2" maxlength="10">
                            </div>
                        </div>
                        <div class="item">
                            <span>&nbsp;&nbsp;意向出国时间</span>
                            <div>
                                <input style="width: 100px;" type="text" id="txt_WantTime2" maxlength="10">
                            </div>
                        </div>
                        <div class="item even">
                            <span><em style="color:red">*</em>&nbsp;面试志愿学校一</span>
                            <div>
                                <select id="want21">
                                   <option>唐屋女子中学</option>
                                    <option selected="selected">凯特汉姆学校</option>
                                    <option>拉格比中学</option>
                                    <option>国王坎特伯雷学校</option>
                                    <option>丁克洛斯中学</option>
                                    <option>伊斯堡学院</option>
                                    <option>斯多中学</option>
                                    <option>赛德伯中学</option>
                                    <option>国王布鲁顿中学</option>
                                    <option>米尔菲尔德学校</option>
                                    <option>哈利伯瑞中学</option>
                                    <option> 切尔滕纳姆女子学院</option>
                                </select>
                            </div>
                        </div>
                        <div class="item even">
                            <span><em style="color:red">*</em>&nbsp;面试志愿学校二</span>
                            <div>
                                <select id="want22">
                                    <option>唐屋女子中学</option>
                                    <option selected="selected">凯特汉姆学校</option>
                                    <option>拉格比中学</option>
                                    <option>国王坎特伯雷学校</option>
                                    <option>丁克洛斯中学</option>
                                    <option>伊斯堡学院</option>
                                    <option>斯多中学</option>
                                    <option>赛德伯中学</option>
                                    <option>国王布鲁顿中学</option>
                                    <option>米尔菲尔德学校</option>
                                    <option>哈利伯瑞中学</option>
                                    <option> 切尔滕纳姆女子学院</option>
                                </select>
                            </div>
                        </div>
                        <div class="item even">
                            <span>&nbsp;&nbsp;面试地点</span>
                            <div>
                                <select id="place2">
                                    <option>北京 9月11日</option>
                                    <option>上海 9月15日</option>
                                </select>
                            </div>
                        </div>
                        <div class="item even">
                            <span>&nbsp;&nbsp;当天来宾人数</span>
                            <div>
                                <input style="width: 100px;" type="text" id="txt_Num2" maxlength="10">
                            </div>
                        </div>
                        <!-- <div class="item even">
                            <span>留言</span>
                            <div>
                                <input type="text" id="txt_Comment2" maxlength="50">
                            </div>
                        </div> -->
                        <div class="btn">
                            <a href="javascript:void(0)" id="xxx" onclick="Join2()">点击完成预约</a>
                        </div>
                    </div>
                </div>
                <div class="clear">
                </div>
                <div class="tips2">
                    <h4>
                        本次活动参与流程如下：</h4>
                    1. 登录活动网站 (alis.behk.org/multi-schools.aspx, 移动设备登录 m.behk.org/multi-schools.aspx) 填写并提交活动注册信息<br/>
                    2. 必益教育老师将根据注册信息致电与您约定学生初试时间<br/>
                    3. 学生按照约定的时间参加初试（初试分为笔试、CAT4和面试三部分，总时长约4个小时，可申请分开进行）<br/>
                    4. 根据初试成绩及评估报告确定面试学校<br/>
                    5. 必益教育将汇总面试学生信息在9月初进行面试排期<br/>
                    6 . 必益教育将在9月10日以前将面试排期信息通知给学生和家长<br/>
                    7. 学生和家长按照面试的具体排期前来参加面试<br/>

                </div>
                <div class="tips2">
                    <h4>
                        常见问题：</h4>
                    
                    Q：现在报名还来得及吗？<br>
                    A：本次校方面试北京站及上海站的报名及初试截止日期为9月7日。<br><br>
                    Q：我一次可以选几所学校面试？学校是自己选吗？<br>
                    A：您好，您可以初步选择2所学校。最终面试院校的选择我们会根据孩子的初试报告以及学生和家长的意向来给出相应的建议。<br><br>
                    Q：为什么一定要初试？<br>
                    A：校方委托必益教育对学生进行一个初试，以了解孩子的学习情况，并生成详细的报告。该报告会给校方一个参考，这是申请英国中学的必备环节。<br><br>
                    Q：完成初试距离校方面试只有几天，这点时间准备够吗？我很想让我的孩子去面试，但是我不确定我孩子的能力是不是能够被录取。<br>
                    A：您好，每个学校的招生标准都是多方面的，看重的是学生的潜质。本次活动是一个可以全方位的了解孩子能力的机会。必益教育将会为学生建立评估卷宗，并根据测评结果为学生做出海外教育咨询指导。让学生及家长了解今后如何着手提升孩子能力，或是如何让孩子的闪光点更加闪亮。
                </div>
                
            </div>
        </div>
    </div>
    
    <!-- <div id="more" style="width: 1000px;height: auto;margin:10px 0 10px 0;background: #DC2F33;font-size: 16px;font-family: microsoft yahei;font-weight: bold;text-align: center;margin: 0 auto;">
        <a href="/eton.aspx">查看Alis 7月份伊顿公学专场活动</a>
    </div> -->
    <div class="footer" id="footer">
        <div class="tips">
            <span>温馨提示:</span>本次活动名额有限，报名请从速; 此活动由ALIS联合必益教育及华申留学举办
        </div>
        <div class="logoList" style="display: none">
            <img src="/guide/images/vl1.jpg" /><img src="/guide/images/vl2.jpg" /><img src="/guide/images/vl3.jpg" /><img
                src="/guide/images/vl4.jpg" /><img src="/guide/images/vl5.jpg" />
        </div>
        <div class="footerNav">
            <a href="javascript:void(0)">关于必益</a><em>|</em><a href="javascript:void(0)">联系我们</a>
            <p>
                Copyright © 2016 Alis全球精英寄宿学校联盟
            </p>
        </div>
    </div>
    <div class="popBg">
        <div class="popbor">
            <div class="popBox">
                <a href="javascript:closePop()" class="close"></a>
                <p class="p1">
                    <img src="guide/images/textpop1.png" alt="恭喜！您已成功完成面试的初步预约" /></p>
                <div class="txt">
                    必益教育客服人员将于48小时内与您联络，为学生安排初试，<br />
                    并确定具体面试时间。请保持手机畅通！在面试前，将为您和学生发送正式邀请函。<br />
                    如有任何疑问，欢迎致电 <strong>400 850 4118</strong>，或在必益教育官方微信留言。
                    <br />
                    感谢您关注本次活动！</div>
            </div>
        </div>
    </div>
    <div style="display: none">
        <!-- Added 9/28/2014: Baidu Code -->
        <script type="text/javascript">
            var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
            document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Ffa9613d962e9008094a7d8fa7c4a9f34' type='text/javascript'%3E%3C/script%3E"));


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
            var chatURL = "http://chat.looyuoms.com/chat/chat/p.do?c=20000409&#038;f=10046273&#038;g=10050876" + g;
            window.open(chatURL, '', wid);
        }
    </script>
    <div class="leftimg regform visible-desktop" style="position: fixed; float: left;
        left: 1px; top: 20%;">
        <div id="close" style="position: fixed; left: 120px; color: red; top: 19%;">
            <img src="http://www.behk.org/wp-content/uploads/2015/01/guanbi-1.png"></div>
        <a onclick="openChat('g')">
            <img src="http://www.behk.org/wp-content/uploads/2015/01/left.gif" style="width: 130px;
                height: 360px; margin-top: -10px; margin-left: 5px;"></a>
    </div>
    <div class="rightimg regform visible-desktop" style="position: fixed; float: right;
        right: 1px; top: 20%;">
        <div id="close2" style="position: fixed; right: 1px; color: red; top: 19%;">
            <img src="http://www.behk.org/wp-content/uploads/2015/01/guanbi-1.png"></div>
        <a onclick="openChat('g')">
            <img src="http://www.behk.org/wp-content/uploads/2015/01/right1.gif" style="width: 130px;
                height: 360px; margin-top: -10px; margin-left: 5px;"></a>
    </div>
    <script type="text/javascript">
        $(function () {
            $("#close").click(function () {
                $(".leftimg").remove();
                $("#close").remove();
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
            //            var hideregform = function () {
            //                $(".regform").fadeOut(300);
            //                $("#footer").css({ "margin-bottom": 0 });
            //            };

            //            var showregform = function () {
            //                $(".regform").fadeIn(300);
            //                $("#footer").css({ "margin-bottom": 100 });
            //            };

            //            var removeregform = function () {
            //                $(".regform").remove();
            //                $("#footer").css({ "margin-bottom": 0 });
            //            };

            //            $(".regform_close").click(function () {
            //                removeregform();
            //            });

            //            $(window).scroll(function () {
            //                if ($(".regform").length > 0) {
            //                    var sTop = $(document).scrollTop();
            //                    if (sTop > 300)
            //                        showregform();
            //                    else
            //                        hideregform();
            //                }
            //            });
        });
    </script>
    <!-- Google 再营销代码 -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 880621767;
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/880621767/?value=0&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
<!-- Google 再营销代码 -->
</body>
</html>

