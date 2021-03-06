﻿
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="uk.aspx.cs" Inherits="uk" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>英国寄宿学校申请</title>


	
    <link rel="stylesheet" href="css/uk.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="/css/headfoot.css" />
    <script type="text/javascript" src="js/uk-jquery.min.js"></script>
    <script src="js/kxbdSuperMarquee.js" type="text/javascript"></script>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="temp/js/temp.js" type="text/javascript"></script>
    <script src="js/layer/layer.js" type="text/javascript"></script>
    <script src="js/kxbdSuperMarquee.js" type="text/javascript"></script>

 <script src="js/base.js" type="text/javascript"></script>  



    <script type="text/javascript">
        var wid = "height=450,width=650,directories=no,location=no,menubar=no,resizable=yes,status=no,toolbar=no,top=100,left=50";
        function openChat(g) {
            var chatURL = "http://chat.looyuoms.com/chat/chat/p.do?c=20000409#038;f=10046273#038;g=10050876";
            window.open(chatURL, '', wid);
        }
    </script>
    
    

</head>


<body>

    <!--悬浮-->
    <div class="sy_share fix1" style="margin-top: 50px;">
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
            <a href="#item0" style="font-size: 30px;">在线预约</a></div>
        </div>
        
        <div class="share_ico4 "><a href="#item0" onclick="javascript:$body.stop().animate({ scrollTop: 0 }, 'normal');"><img src="/images/xf_09.png" width="52" height="52"></a></div>

    </div>
        
        <script type="text/javascript">

       


//变色效果
        $().ready(function () {
       
            var showinbanner = function () {
                
                $("#menu ul li a").css({'color':'white'});
                $("#menu ul li a:hover").css({'color':'#a40035'});
                $("#menu ul li a.cur").css({'color':'#a40035'});
            };

            var showinmain = function () {
                
                $("#menu ul li a").css({'color':'#002653'});
                $("#menu ul li a:hover").css({'color':'#a40035'});
                $("#menu ul li a.cur").css({'color':'#a40035'});
            };


            $(window).scroll(function () {
                if ($("#menu").length > 0) {
                    var sTop = $(document).scrollTop();
                    if (sTop > 300)
                       showinmain();
                    else
                    showinbanner();
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

  
   <div id="container">
    <div id="content">
    <div id="menu">

        

    <ul>
        <li><a href="#item0" class="cur">○&nbsp;英国名校申请</a></li>
        <li><a href="#item1" >○&nbsp;英国公学F4</a></li>
        <li><a href="#item2">○&nbsp;英国女校推荐</a></li>
        <li><a href="#item3">○&nbsp;学校荣誉榜</a></li>
        <li><a href="#item4">○&nbsp;2016名校Offer</a></li>
        <li><a href="#item5">○&nbsp;学员案例精选</a></li>
        <li><a href="#item6">○&nbsp;英国教育体系</a></li>
        <li><a href="#item7">○&nbsp;关于必益教育</a></li>
            </ul>
</div>
	<div id="item0">
	<div id="header">
		<div id="logo"><a href="http://www.behk.org"><img style="" alt="BE LOGO" src="images/belogo3.png"></a></div>
		<div id="contact"><img style="" alt="Telephone" src="images/contact.png"></div>
	</div>
	
	<div id="banner">
		<div id="leftpart" style="font-size:45px;color:white;font-weight: bold;font-family: microsoft yahei;letter-spacing: 3px;line-height: 300px;">
            <p>英国寄宿学校申请</p>
      <!-- <img style="" alt="英国寄宿中学" src="images/ukwenzi.png">  -->     
        </div>
		<div id="rightpart">
			<div id="baoming">
                    <h3 class="h3">
                        您的孩子符合国际名校申请条件吗？</h3>
                    <p class="p">
                        填写表单预约根据您孩子年龄定制的<br/>免费英语及学术能力测试！</p>
                    <div class="tb">
                        <table>
                            <tr>
                                <th>
                                    学生姓名
                                </th>
                                <td>
                                    <input type="text" id="txt_Name" name="zzjs.net" value="必填" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    联络手机
                                </th>
                                <td>
                                    <input type="text" id="txt_Mobile" name="zzjs.net" value="必填" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    所在城市
                                </th>
                                <td>
                                    <input type="text" id="txt_City" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    学生年龄
                                </th>
                                <td>
                                    <input type="text" id="txt_Age" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    电子邮箱
                                </th>
                                <td>
                                    <input type="text" id="txt_Grand" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    备注
                                </th>
                                <td>
                                    <textarea id="txt_Intor"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                </th>
                                <td>
                                    <a href="javascript:void(0)" onclick="AddComment()"><img src="images/zhuce.png"></a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
	
	<div id="main">
        <div  class="item" id="item1">
		<div class="schools">
			<div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;英国公学F4&nbsp;&nbsp;&nbsp;&nbsp;——</h6></div>
			<div class="four">
                
                <div class="fourtitle">
                    <img src="../images/locationicon.gif">
                    <h5>伊顿公学(Eton College)</h5>

                </div>
                <hr color=#777 size=1 width=480px >
                <div class="introduce">
                    <div class="pic"><img style="" alt="伊顿公学" src="../images/etonuk.jpg">
                    <p>★伊顿公学迄今在中国只招收了10名学生，其中7名接受了必益教育的规划和咨询服务。</p>
                    </div>
                    <div class="wenzi">
                            <p>伊顿公学位于温莎镇的泰晤士河边，由英国国王亨利六世创建于1440年，被公认为是英国最好的中学，享有“贵族的摇篮”之称，是英国皇室成员威廉王子和哈里王子的母校。伊顿曾经诞生过包括现任首相卡梅伦在内的20位英国首相、36位维多利亚十字勋章获得者，英国最高军事将领等多位英国政界翘楚和社会精英。伊顿公学每年250名左右的毕业生中，70%的学生能够进入世界名校，其中30%以上的学生能够进入牛津及剑桥继续深造。</p>
                    </div>
                </div>         
            
            </div>
			<div class="four"> 
                <div class="fourtitle">
                    <img src="../images/locationicon.gif">
                    <h5>拉德利公学(Radley College)</h5>

                </div>
                <hr color=#777 size=1 width=480px >
                <div class="introduce">
                    <div class="pic"><img style="" alt="拉德利公学" src="../images/radleyuk.jpg">
                    <p>★拉德利公学首次访华活动在2016年3月与必益教育的合作中展开</p>
                    </div>
                    <div class="wenzi">
                            <p>拉德利公学始建于1847年，是英国四所最优秀的男校中的唯一一所全寄宿制男校。学校非常传统，这一点在穿着方面体现地淋漓尽致，男孩们在每一个场合都需穿着黑色礼服，并且佩戴学校的领带。舍监在学校担任着极其重要的角色，他们要随时关注男孩们的表现，帮助他们培养良好的纪律和行为。教堂是学校生活的一个重要组成部分，每周有四个晚上全校会一起进行礼拜。学校严格对待欺凌行为，一旦有发生会迅速处理，严重的话会进行开除处分。</p>
                    </div>
                </div>     
            </div>
			
            <div class="four">
                <div class="fourtitle">
                    <img src="../images/locationicon.gif">
                    <h5>哈罗公学(Harrow School)</h5>

                </div>
                <hr color=#777 size=1 width=480px >
                <div class="introduce">
                    <div class="pic"><img style="" alt="哈罗公学" src="../images/harrowuk.jpg">
                    <p>★2016年截至3月底，必益教育学员已收到4份哈罗公学的录取offer，其中一人获得了美术奖学金。</p>
                    </div>
                    <div class="wenzi">
                            <p>哈罗公学是在1572年成立的，坐落于伦敦西部美丽的Harrow-on-the-Hill，占地400英亩，从学校可以将伦敦的景色尽收眼底。 学校有着悠久的历史和传统，学校的Old Schools里面有10年级的教室，这也是第一部哈利波特里面弗立维教授给学生上课场景的拍摄地。学校的图书馆也很宏伟，并且在考试期间会延长开放时间。哈罗公学的校歌也是其特征之一，这是为了纪念哈罗公学的校友Winston Churchill先生，所以这首歌被命名为Churchill之歌。
                            </p>
                    </div>
                </div>
            </div>
			<div class="four">
                <div class="fourtitle">
                    <img src="../images/locationicon.gif">
                    <h5>温切斯特公学(Winchester College)</h5>

                </div>
                <hr color=#777 size=1 width=480px >
                <div class="introduce">
                    <div class="pic"><img style="" alt="温彻斯特公学" src="../images/winchesteruk.jpg">
                    <p>★2016年截至3月底，必益教育学员已收到1名温彻斯特公学录取Offer</p>
                    </div>
                    <div class="wenzi">
                            <p>温切斯特公学是英国第一所免费接收穷苦学生的大学预备学校，开创了英国公学教育的历史。而今天的温切斯特公学虽然已经演变成为一所贵族寄宿制学校，但依然保持了自己悠久的传统与文化。温切斯特学校创建于14世纪，其传统和历史让学校深感自豪。学生在教室开始学习生活，然后晚间回到宿舍休息。宿舍由舍监看管，纪律严明，学生们都要在自己宿舍吃饭。该校的学术要求非常高，近年来为拓展课目，淡化应试教育，学校用剑桥预科Pre-U 考试代替了A-level考试。

 
                            </p>
                    </div>
                </div>

            </div>
		</div>
    </div>


<div  class="item" id="item2">
		<div class="schools" >
			<div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;英国女校推荐&nbsp;&nbsp;&nbsp;&nbsp;——</h6></div>
			<div class="four">
            <div class="fourtitle">
                    <img src="../images/locationicon.gif">
                    <h5>威雅学校(Wycombe Abbey)</h5>

                </div>
                <hr color=#777 size=1 width=480px >
                <div class="introduce">
                    <div class="pic"><img style="" alt="威克姆阿贝" src="../images/wycombe abbeyuk.jpg">
                    <p>★2016年1月，顶级女校威雅首次进入中国，与必益教育合作，联手在中国常州开设国际学校</p>
                    </div>
                    <div class="wenzi">
                            <p>威雅学校位于英格兰的白金汉郡，无可争议的被誉为全英学术最优秀的名校，也是（学术上）排名第一的女子寄宿中学。学校建于一座小山丘上，占地160英亩有余，学生招收11到18岁的女生，人数常年保持550人左右，寄宿比例95%以上。学校环境优雅，甚至有树林、花园和湖泊。虽然初看之下学校暗色调的古堡式建筑似乎有些压抑感，但是校园中热情洋溢、欢乐健谈的女生们给学校带来了无限生气。
                            </p>
                    </div>
                </div>

            </div>
			<div class="four">
                <div class="fourtitle">
                    <img src="../images/locationicon.gif">
                    <h5>唐屋中学(Downe House)</h5>

                </div>
                <hr color=#777 size=1 width=480px >
                <div class="introduce">
                    <div class="pic"><img style="" alt="唐屋中学" src="../images/downehouseuk.jpg">
                    <p>★2015年，唐屋中学与必益教育独家合作，首次来华招生；2016年截至3月底，必益教育学员已收到7份唐屋中学录取Offer</p>
                    </div>
                    <div class="wenzi">
                            <p>唐屋中学是英国顶级女校之一。它成立于1907年，是一所传统英式的全寄宿制学校。唐屋中学鼓励学生发展个人技能和社会技能。提供独特而全面的教育，通过优秀的教学、广泛的课程和丰富的课外活动，充分挖掘学生潜力，激励每一个学生自信成长，促进学术繁荣。该校更经常举行国外的旅行，扩宽学生的视野。学校重视以及尊重差异，使她们能够蓬勃发展，在适当的谦虚和价值观念的基础上，为他们的未来生活打下了坚实的基础。
                            </p>
                    </div>
                </div>         
            </div>
			<div class="four">
                <div class="fourtitle">
                    <img src="../images/locationicon.gif">
                    <h5>切尔滕纳姆学院(The Cheltenham Ladies’College)</h5>

                </div>
                <hr color=#777 size=1 width=480px >
                <div class="introduce">
                    <div class="pic"><img style="" alt="切尔滕纳姆学院" src="../images/cheltenhamuk.jpg">
                    <p>★2016年截至3月底，必益教育学员就收到了1份切尔滕纳姆学院的录取offer</p>
                    </div>
                    <div class="wenzi">
                            <p>切尔腾纳姆女子学院历史悠久，成立于1853年。女孩子们经常参加当地的社区活动，她们在做中学，在学中乐，充分实现了理论与实践的结合。该校以学术成绩显赫著称，小班化教学、专家教师组、先进的教学设施和丰富多彩的课外活动为孩子们的发展提供了坚实的保证。学校旨在学生的个性发展、技能技巧的获得和价值观的形成，同时培养有责任心、事业有成、遵守规范的公民。学校无可挑剔的学术成绩是中学教育成功的典范，单凭这一点学校就吸引了很多优秀的女孩子。
                            </p>
                    </div>
                </div>             
            </div>
			<div class="four">
                <div class="fourtitle">
                    <img src="../images/locationicon.gif">
                    <h5>博耐顿女校(Benenden School)</h5>

                </div>
                <hr color=#777 size=1 width=480px >
                <div class="introduce">
                    <div class="pic"><img style="" alt="博耐顿女校" src="../images/benendenuk.jpg">
                    <p>★博耐顿女校成立于1923年，是稳居英国前50的顶尖寄宿制名校</p>
                    </div>
                    <div class="wenzi">
                            <p>博耐顿女校位于肯特郡乡村地区的中心地带，距离博耐顿村庄仅几步之遥。学校占地240英亩，拥有大片森林，可以俯瞰绵延几英里的丘陵和林地。古墙围绕着的花园是学校的一大亮点，另外还有几个水上花园，经过最近挖掘和维护，已成为了宝贵的生态资源。学校已经建成新型可持续使用的碳中和生态教室。学校将教学楼建在校园中心，而且布局紧凑，紧密联系，宿舍分散于校园四周。
                            </p>
                    </div>
                </div>  
            </div>
		</div>
    </div>


    <div  class="item" id="item3">
        <div id="honerlist">
            <div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;英国学校荣誉榜&nbsp;&nbsp;&nbsp;&nbsp;——</h6></div>
                
                <div class="title1"><h4>英国初中和高中</h4></div>
                
                <div class="list2">
                
                    <ul style="margin:-20px 0px 20px 80px ; float:left;">
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Abingdon School 阿宾顿中学</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Badminton School 巴德明顿中学</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Brighton College布莱顿学院</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Bradfield College 布莱德菲尔德学院/li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Benenden School 博耐顿女校</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Cheltenham Ladies’ College 切尔滕纳女子学院</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Charterhouse 切特豪斯</li>

                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Caterham School 凯特汉姆学校</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Canford School 坎福德中学</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Dulwich College 德威学院</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Downe House School 唐屋中学/道恩豪斯学校</li>

                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Eton College 伊顿公学</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Harrow School 哈罗公学</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Headington School 海丁顿中学</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Lancing College 莱斯因中学</li>
                    </ul>
                
                
                    <ul style="margin:-20px 10px 20px -10px ; float:left;">
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Malvern St. James School 莫尔文圣詹姆斯学校</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Oakham School 奥克汉学校</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Rugby School 拉格比学校</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;St. Mary’s School Ascot 阿斯科特圣玛丽学校</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;St. Paul’s School 圣保罗学校</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;St. Mary’s Calne 圣玛丽卡恩女子学校</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;St. Swithun’s School 圣斯威辛学校</li>

                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Stowe School 斯多中学</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Tonbridge School 汤布里奇学校</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Uppingham School 阿嫔汉姆学校</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Winchester College 温彻斯特公学</li>

                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Wycombe Abbey School 威克姆阿贝女校</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Wellington College 威灵顿公学</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Westminster School 威斯敏斯特学校</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Woldingham School 沃丁翰学校</li>
                    </ul>
            
        </div>

    
    

        

        
        <div class="title1"><h4>英国大学</h4></div>
        <div class="list2">
            
            <ul style="margin:-10px 0px 20px 80px ; float:left;">
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;Central St Martin’s 中央圣马丁艺术与设计学院</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;Imperial College London 帝国理工大学</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;London School of Economics 伦敦政治经济学院</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;University of Oxford 牛津大学</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;University of Cambridge 剑桥大学</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;University of Durham 杜伦大学</li>
                    </ul>
            <ul style="margin:-10px 10px 20px -10px ; float:left;">
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;University College London 伦敦大学</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;University of Warwick 华威大学</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;University of Exeter 埃克塞特大学</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;University of Bath 巴斯大学</li>
                        <li class="lista">&nbsp;&nbsp;&nbsp;&nbsp;University of York 约克大学</li>
                        <li class="listb">&nbsp;&nbsp;&nbsp;&nbsp;University of Bristol 布里斯托大学</li>
                    </ul>

        </div>
        </div>
    </div>
    
	

    <div  class="item" id="item4">
    <div id="offer">
        <div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;必益教育2016名校录取Offer&nbsp;&nbsp;&nbsp;&nbsp;——</h6></div>
        <div class="luqu">

            <ul style="margin:30px 0px 20px 80px; float:left;">
            <li class="listc">学校</li>
            <li class="listb">Wycombe Abbey School 威克姆阿贝女校</li>
            <li class="lista">Charterhouse 切特豪斯公学</li>
            <li class="listb">Harrow 哈罗公学</li>
            <li class="lista">Downe  House 唐屋中学</li>
            <li class="listb">Radley 拉德利中学</li>
            <li class="lista">Cheltenham Ladies' College 切尔腾纳女子学院</li>
            <li class="listb">Sevenoaks School 七橡树中学</li>
            <li class="lista">Tonbridge School 汤布里奇中学</li>
            <li class="lista">Rugby School 拉格比学校</li>
            <li class="listb"> King`s School,Canterbury 国王坎特伯雷学院</li>
            <li class="lista">St Paul's School 圣保罗学校</li>
            <li class="listb">Westminster School 威斯敏斯特学校</li>
            <li class="lista">Winchester College 温彻斯特学院</li>
            <li class="listb">St Mary's Calne 圣玛丽卡恩女子中学</li>
            <li class="lista">St Swithun’s School 圣斯威辛学校</li>
            <li class="listb">Dulwich College 德威学院</li>
        </ul>
        <ul style="margin:30px 10px 20px -45px ; float:left;">
            <li class="listc">录取人数</li>
            <li class="listb">3</li>
            <li class="lista">4（包括1名音乐奖学金学生）</li>
            <li class="listb">4（包括1名音乐奖学金学生）</li>
            <li class="lista">7</li>
            <li class="listb">4</li>
            <li class="lista">1</li>
            <li class="listb">1</li>
            <li class="lista">4</li>
            <li class="lista">5</li>
            <li class="listb">8（包括1名美术奖学金学生）</li>
            <li class="lista">1</li>
            <li class="listb">1</li>
            <li class="lista">1</li>
            <li class="listb">2</li>
            <li class="lista">1</li>
            <li class="listb">1</li>
        </ul>
        </div>
    </div>
</div>


    <div  class="item" id="item5">
    <div id="case">
        <div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;必益教育成功申请案列精选&nbsp;&nbsp;&nbsp;&nbsp;——</h6></div>
        <div class="suscase">
            
            <img style="" alt="Jack Wang" src="../images/jackwang.jpg">
            
            <div>
            <h3>Jack Wang</h3>
            <p>Jack是个很聪明的孩子，他对很多课程都很有兴趣。他父母认为出国留学适合Jack的发展。因此，Jack在10岁的时候就踏上了赴英留学的旅程。他一开始来到必益教育的时候是希望我们帮他备考英国预备学校的入学考试。一开始的时候，他的英语相对比较差。在必益教育推荐的外教辅导下，他的英语水平提高了不少，并被英国的预备学校-逊宁戴尔学校录取。他的英语和其他科目在预备学校里面提高了不少，必益教育也密切关注着他在预备学校的进度，并在每次的假期和学校中假时间帮他安排了导师制学校课程补习。在2011年9月，Jack顺利进入哈罗公学就读九年级。他对新环境很喜欢，在学习课本知识的同时，对体育运动更是情有独钟，他还是橄榄球队和越野长跑队的队员。</p>
        </div>
    </div>
        <div class="suscase">
            <img style="" alt="Rebecca Ren" src="../images/rebeccaren.jpg">
            <div>
            <h3>Rebecca Ren</h3>
            <p>能在英国的顶尖学校读书，是Rebecca从小就一直有的梦想。她第一次接触必益教育是从参加英国切特豪斯学校的暑期研修班开始的。经过研修班三周的学习和生活，使她去英国读书的愿望更强烈了。课程结束后，Rebecca的妈妈便向必益教育咨询海外学校的事宜。当年Rebecca只有11岁，英语非常有限。为了对她做出最全面的方案，我们先为她进行了能力测试，并安排Rebecca进入Bishipstrow学校接受三个学期的英文及学科英语课程，在短短的时间里她的英文水平有了大幅度的提高。在此期间必益教育教育咨询部总监也与英国著名的女子预备学校Godstowe联系安排Rebecca进行该校8年级的入学面试。进入Godstowe之后，必益教育还安排她在牛津的学校进行一对一的科学课程辅导。必益教育教育咨询部总监亲自为Rebecca进行面试技巧训练，并帮助她提高自信心。最终，Rebecca获得了英国排名第二的女校Cheltenham Ladies’College 9年级的录取通知。</p>
        </div>
    </div>
</div>
</div>

<div  class="item" id="item6" style="margin-top:-30px;">
    <div id="sys">
        <div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;英国教育体系和入学要求&nbsp;&nbsp;&nbsp;&nbsp;——</h6></div>
        
        <div class="sys1">
        <div class="title1"><h4>英国教育体系</h4></div>
        <p>下图表形象而直观地介绍了英国学校的入学年龄、入学点和课程内容，学习内容由易到难，专业性逐步增强。中国学生的入学安排根据个人实际情况出发。此图表为概括介绍，仅供参考。请联系必益教育索取最新详细信息。</p>
        
        <div><img style="" alt="英国教育体系" src="images/uksystem.png"> </div>
        </div>


        <div class="title1"><h4>入学要求</h4>
            <p>英国的教育体系与其他国家的不同之处在于，要求严格遵守纪律和训导的同时，允许学生自由选择学习课程。区别于美国学校要求学生在进入大学前学习各种大量的课程，在英国学生往往会挑选几门自己感兴趣的课程并开始提前学习。在学生进入大学时，他们便能够对那些课程具有更深入的理解。学生被分成不同级别，确保优等生仍然会不断接受更高的挑战，同时也保证学习速度较慢的学生也能得到足够的关注和关心。</p>
        </div>
    
    </div>
</div>

<div  class="item" id="item7">
    <div id="about">
        <div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;关于必益教育&nbsp;&nbsp;&nbsp;&nbsp;——</h6></div>
        <p>必益教育来自英国，是由资深国际教育咨询专家组成的专业团队，我们旨在通过系统规划和专业指导，帮助孩子成功入读伊顿、哈罗等全球知名中小学府接受教育。我们开展全球合作，为想要入读全球顶尖名校的中小学生提供国际教育咨询及入学规划指导、全球短期课程研修、一对一专家辅导等多项优质服务。</p>
    </div>
</div>

<div  class="item" id="item8">
    <div id="advantage">
        <div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;必益教育优势&nbsp;&nbsp;&nbsp;&nbsp;——</h6></div>
        <h3>你知道吗？<br/>
        一些关于必益教育的趣味事实</h3>
                <ul>
                    <li><p>必益教育是英国170余所顶级寄宿中学入学考试在中国的考点或指定考点</p></li>
                    <li><p>必益教育是英国A-Level入学考试主办方的合作伙伴之一</p></li>
                    <li><p>必益教育已经连续七年蝉联胡润百富至尚优品“中国最受青睐高端国际教育咨询品牌”大奖</p></li>
                    <li><p>必益教育深受国外顶级学府信任，伊顿公学迄今在中国共招收了10名学生，其中有7名学生都接受了必益教育提供的规划和咨询服务 </p></li>
                    <li><p>2016年开年，必益教育旗下学员已成功接到英美多所名校的录取Offer</p></li>
                </ul>
    </div>
</div>


    <div class="copyR" style="background:#35373b;margin:0 20px 0px 20px;width: 1110px;margin: 0 auto;">
    <div class="footer-main clearfix" >
        <a class="footer-logo" href="/"><img src="../images/f-logo.jpg" /></a>
        <div class="copyMeg" style="font-family: microsoft yahei;letter;margin-right: 40px">
           <p>上海必益教育信息咨询有限公司 <em>|</em>   长寿路1111号 悦达889中心 9楼02A-05室 <em>|</em>&nbsp;电话:400-850-4118</p>
           <p class="copyright"><span>© 2015 BE Education</span>留所有权利&nbsp;&nbsp;沪ICP备12028009号</p>
        </div>
     </div>
  </div>

</div>
</div>
<script type="text/javascript" src="js/uk-menu.js"></script>
<DIV style="display: none;"><!-- Added 9/28/2014: Baidu Code -->
<SCRIPT type="text/javascript">var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
            document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Ffa9613d962e9008094a7d8fa7c4a9f34' type='text/javascript'%3E%3C/script%3E"));


        </SCRIPT>
<!-- Added 4/16/2014: Google analytics -->
<SCRIPT type="text/javascript">
            (function (i, s, o, g, r, a, m) {
                i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date(); a = s.createElement(o),
      m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
            })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

            ga('create', 'UA-10009127-1', 'behk.org');
            ga('send', 'pageview');
        </SCRIPT>
</DIV>
</body>
</html>
