<%@ Page Language="C#" AutoEventWireup="true" CodeFile="summer-courses.aspx.cs" Inherits="summer_courses" %>


<%@ Register Src="ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
<meta charset="UTF-8">
    <title>2016必益教育国际夏令营暨暑期研修班</title>
    <meta name="Keywords" content="" runat="server" id="Key" />
    <meta name="Description" content="" runat="server" id="Des" />
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link href="css/v.css" rel="stylesheet" type="text/css" />
       
    <link href="css/default-n.css" rel="stylesheet" type="text/css" />
	
	<link href="css/lanrenzhijia.css" type="text/css" rel="stylesheet" />
    <script src="js/lanrenzhijia.min.js"></script>
	

    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/index-banner.js" type="text/javascript"></script>
    <script src="js/common.js" type="text/javascript"></script>
    <script src="js/index.js" type="text/javascript"></script>
   	<script src="js/kxbdSuperMarquee.js" type="text/javascript"></script>
   	
   	<script src="js/layer/layer.js" type="text/javascript"></script>
   	<script src="js/base.js" type="text/javascript"></script>
    <script src="temp/js/temp.js" type="text/javascript"></script>
    <style>
    #frontpic{
    	width: 1180px;
		height:400px;
    	margin:0 auto;
    }

	#introduce{
		/* height: 130px; */
		background:#0B2150;


	}
	#introduce  h3{
		font-size: 25px;
		color:white;
		font-weight:bold;
		margin:3px 50px 0px 50px;
		padding-top:20px;
		
	}
	#introduce  p{
		font-size: 14px;
		color:white;
 		margin:3px 50px 0px 50px; 
		line-height:20px;
		padding-bottom:20px;
	}
	#main{
		width: 1180px;
		height:600px;
		background:#e2e2e2;
		margin:3px auto;
		
	}
	#aboutbe{
		background:#0B2150;
		height:240px;
		width:1180px;
		margin:0 auto;
	}
	#aboutbe h3{
		font-size: 25px;
		color:white;
		font-weight:bold;
		margin:20px 0px 0px -12px;
	}
	#aboutbe p{
		font-size: 14px;
		color:white;
		line-height:20px;
		
	}
	#aboutbe li{
		margin:6px 10px 0 0;
		list-style-type:square;
		color:#fff;

	}
	#leftpart{
		width: 295px;
		height:594px;
		background:#e2e2e2;
		float:left;
		margin-top: 4px 0 4px 0;
	}
	#rightpart{
		width: 295px;
		height:600px;
		background:#f0f2f5;
		float: right;
		
	}
	#rightpart .h3{font-size:20px; color:#a20032; text-align:center;font-weight: bold;}
	#rightpart .p{font-size:18px; margin-bottom:20px; color:#0a4d89; text-align:center;font-weight: bold;}
	#rightpart .tb{ padding:3px 20px;}
	#rightpart .tb table{ width:100%;}
	#rightpart .tb th{text-align:right; color:#888888; font-size:14px; width:65px;padding:5px 10px 0px 0px; vertical-align:top;}
	#rightpart .tb input{ margin-bottom:10px; height:25px; width:140px; background:#fff; border:1px solid #dadada; border-radius:2px; box-shadow:0 1px 2px rgba(0,0,0,.1) inset; padding:0 10px;}
	#rightpart .tb textarea{ height:55px; font-size:12px; width:140px; background:#fff; border:1px solid #dadada; border-radius:2px; box-shadow:0 1px 2px rgba(0,0,0,.1) inset; padding:10px;}
	#rightpart .tb a{ margin:20px 0; display:inline-block; padding:0 15px; height:32px; line-height:32px; background:#cf102d; color:#fff;}
	#rightpart .tb a:hover{ background:#bb0b26;}
	
	#middlepart{
		width: 590px;
		height:594px;
		background:#e2e2e2;
		float:left;
	}
	#middlepart .four{
		width:294px;
		height:299px;
		background:#e2e2e2;
		float:left;
		margin:-2px 0px 3px 1px;
	}
	
	
		
	</style>

</head>

    <body>
	<div id="container" style="background:#e2e2e2">
		<div id="frontpic" style="background:url(images/shouye.jpg);background-size: 1180px 400px">
		<script type="text/javascript" src="http://www.behk.org/wp-includes/js/jquery/jquery.js?ver=1.10.2"></script>
		<script type="text/javascript">
        var wid = "height=450,width=650,directories=no,location=no,menubar=no,resizable=yes,status=no,toolbar=no,top=100,left=50";
        function openChat(g) {
            var chatURL = "http://chat.looyuoms.com/chat/chat/p.do?c=20000409&#038;f=10046273&#038;g=10050876" + g;
            window.open(chatURL, '', wid);
        }
    	</script>
			
			<a onclick="openChat('g')" style="cursor:pointer;"><img style="margin:280px 0px 0px 200px" alt="我要报名" src="images/baoming.png">
			</a>
			
		</div>
		</div>
		
		<div id="introduce" style="margin-top:1px">
			<div style="width:1180px;margin:0px auto;" >
			<h3>必益教育夏令营简介</h3>
			<p style="text-indent:2em">必益教育面向中国学生开设各具特色的假期研修班课程，这些课程专门针对想要利用假期时间出国游学的中国学生，给学生提供一个体验海外学习、生活的契机。对于无法去海外读书的学生而言，必益教育的假期项目给学生提供了另外一种选择，使得他们可以在国内接受传统教育之余，还能在假期体验西方名校的学习和生活。很多去过假期研修班的学生之后均在国际学校就读，为升入海外名校继续深造做准备。</p>
		</div>
	</div>
		<div id="main" >
			<div id="leftpart">
				
				<div class="item2">
				<img style="width:295px;height:594px" alt="伊顿夏令营" src="images/etonsc.jpg">
				
      	<div class="caption">
            <h3>英国伊顿公学夏令营</h3>
            <h4>招生对象</h4>
			<p>招生年龄：13-17周岁的学生
			<br/>课程时间：2016年7月12日至8月2日</p>
			<h4>选择理由：</h4>
			<p>一、最知名的英国贵族学校
			<br/>二、体验传统英伦文化精髓
			<br/>三、纯正的英语强化课程，教师中不乏牛津、剑桥毕业的伊顿校友
			<br/>四、1:5的超高师生配比
			<br/>五、开拓眼界的英国揽胜
			<br/>六、女生入读伊顿的唯一机会
			</p>
      	</div>
    </div>
        	
        
			
		</div>
			<div id="middlepart" style="margin:-1px 0 2px 0">
				
				<div class="four">
					<div class="item4">
					<img style="width:294px;height:299px;" alt="切特豪斯夏令营" src="images/charterhousesc.jpg">
						<div class="caption">
            			<h3>英国切特豪斯夏令营</h3>
            			<h4>招生对象</h4>
						<p>招生年龄：8-12周岁的学生 
						<br/>课程时间：2016年7月15日至7月29日</p> 
						<h4>选择理由</h4>
						<p>一、最负盛名的英国九大公学之一
						<br/>二、专为低龄学生量身定制的教学体验
						<br/>三、原汁原味的英式课堂
						<br/>四、体验正宗英式全寄宿课程生活
						<br/>五、超高的师生配比
						<br/>六、开拓眼界的英国游览
						</p>
      					</div>
    				</div>	
				</div>
				
				<div class="four">
					<div class="item4">
					<img style="width:294px;height:299px;" alt="邓恩中学夏令营" src="images/dunnsc.jpg">
						<div class="caption">
            				<h3>美国邓恩中学夏令营</h3>
            			<h4>招生对象</h4>
						<p>招生年龄：14-17周岁的学生 
						<br/>课程时间：2016年7月17日至8月5日</p>
						<h4>选择理由</h4>
						<p>一、加州王牌预科学校
						<br/>二、体验美式精英文化精髓
						<br/>三、独一无二的小托福测试
						<br/>四、超高师生配比率
						<br/>五、拓宽视野的美国揽胜
						<br/>六、“留学生活”提前感受
						</p>
      					</div>
    				</div>	
				</div>
				
				<div class="four">
					<div class="item4">
					<img style="width:294px;height:299px;" alt="澳大利亚夏令营" src="images/austriliasc.jpg">
						<div class="caption">
            			<h3>澳洲夏令营</h3>
            				<h4>招生对象</h4>
							<p>招生年龄：12-18周岁的学生 
							<br/>课程时间：2016年7月24日至8月13日</p>
							<h4>选择理由</h4>
							<p>一、最具权威的学习保证
							<br/>二、360°浸入式全真体验澳洲公学
							<br/>三、综合能力全面发展
							<br/>四、精心挑选的寄宿家庭
							<br/>五、开拓眼界的澳洲游览
							<br/>六、体验澳洲风土人情
							</p>
      					</div>
    				</div>	
				</div>
				
				<div class="four">
					<div class="item4">
					<div class="four"><img style="width:294px;height:299px;" alt="加州大学夏令营" src="images/californiasc.jpg"></div>
						<div class="caption">
            			<h3>美国加州大学夏令营</h3>
            			<h4>招生对象</h4>
						<p>招生年龄：14-17周岁的学生 
						<br/>课程时间：2016年7月17日至8月5日</p>
						<h4>选择理由</h4>
						<p>一、美国顶级大学体验纯正美式教育
						<br/>二、多国籍学生共同体验多元文化
						<br/>三、独一无二超高师生配比
						<br/>四、资深美国顾问全程陪同
						<br/>五、拓宽视野的美国揽胜
						<br/>六、综合能力全面发展
						</p>

      					</div>
    				</div>	
				</div>
			
		</div>
			<div id="jump">
			<div id="rightpart">
				
				<div class="cons clearfix" style="margin-top: 40px">
         
                <div class="right">
                    <h3 class="h3">
                        免费注册</h3>
                    <p class="p">
                        抢占2016夏令营咨询名额！</p>
                    <div class="tb">
                        <table>
                            <tr>
                                <th>
                                    学生姓名
                                </th>
                                <td>
                                    <input type="text" id="txt_Name" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    联络手机
                                </th>
                                <td>
                                    <input type="text" id="txt_Mobile" />
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
                                    所在班级
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
                                    <a href="javascript:void(0)" onclick="AddComment()">提交注册信息</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            
        </div>
		</div>
			</div>
		</div>
	
		<div id="aboutbe" style="margin-top:3px;margin-bottom:3px" >
			
			<div style="width:500px;height:240px;float:left;margin-left:30px;" >
				<h3>关于必益教育</h3>
				<p style="margin:7px 0px 0px -7px;text-indent:2em">必益教育专注国际教育咨询及学习辅导服务逾13年。我们是来自英、美、欧洲及中国的资深国际教育咨询专家团队，为想要入读全球顶级学府的中小学生提供申请及入学咨询、学习规划指导、全球短期研修班、一对一学习辅导及入学考试辅导等一站式高端国际教育咨询服务。</p>
			</div>
			<div style="width:500px;height:240px;float:right;">
				<h3>我们的优势</h3>
				
				<ul>
					
					<li><p>必益教育是英国170余所顶级寄宿中学入学考试在中国的考点或指定考点</p></li>
					<li><p>必益教育是英国A-Level入学考试主办方的合作伙伴之一</p></li>
					<li><p>必益教育深受国外顶级学府信任，伊顿公学迄今在中国共招收了10名学生，其中有7名学生都接受了必益教育提供的规划和咨询服务</p></li>
					<li><p>必益教育已经连续七年蝉联胡润百富至尚优品“中国最受青睐高端国际教育咨询品牌”大奖</p></li>
				
				</ul>

			</div>
		
		</div>
		<div id="foot"></div>

    <uc2:footer ID="footer1" runat="server" />
    <script type="text/javascript">
        $(function () {


        })
    
    </script>



	</div>
</div>

<script src="js/lanrenzhijia.js"></script>    
</body>
</html>
