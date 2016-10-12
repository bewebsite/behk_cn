<%@ Page Language="C#" AutoEventWireup="true" CodeFile="biyipeixunzhongxin2016.aspx.cs" Inherits="biyipeixunzhongxin2016" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>2016必益培训中心</title>

    <link rel="stylesheet" href="css/biyipeixunzhongxin2016.css" />
    <link rel="stylesheet" type="text/css" href="css/default.css">
    <link rel="stylesheet" href="css/demo.css">
    <link rel="stylesheet" href="css/jquery.flipster.css">
    <link rel="stylesheet" href="css/flipsternavtabs.css">
    
	
  	<script type="text/javascript" src="js/jquery.js"></script>
  	<script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <script src="js/jquery.flipster.js"></script>
    <!--注册JS-->
    <script src="js/layer.js" type="text/javascript"></script>
    <script src="js/temp.js" type="text/javascript"></script>
    <script src="js/base.js" type="text/javascript"></script>
    <link rel="stylesheet" href="css/layer.css" />
  	
</head>
<body>
  <div id="header">
  	<div id="logoa"><a href="http://www.behk.org"><img style="" alt="BEbeixun LOGO" src="images/bepeixun-logo.png"></a></div>
  	<div class="tels">
                <p>
                    免费咨询电话</p>
                <h2>
                    400-696-4118</h2>
            </div>
  </div>
  
  <div id="banner">
  <div id="center">
  <div class="leftpart">
    <img style="" alt="" src="images/text1.png">
  </div>
    <div class="rightpart">
      <div class="baoming">
                    <h3 class="h3" style="float: left; margin-left: 50px;">
                        注册填表</h3>
                    <h3 class="h3" style="float: right;margin-right: 50px;">
                        免费测试</h3>
                    <hr color=#fff size=0.8 width=90% >
                    
                    <div class="tb">
                        <table>
                            <tr>
                              
                                <td>
                                    <input type="text" id="txt_Name" value="姓名" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei" />
                                </td>
                            </tr>
                            
                            <tr>
                                
                                <td style="width: 100px;float: left;display: inline;">
                                    <select type="text" id="txt_City" name="zzjs.net" value="城市"  style="color:#999999;font-family: microsoft yahei;width: 95px;" />

                                    <option selected="selected">上海</option>
                                    <option>北京</option>
                                    <option>成都</option>
                                    <option>深圳</option>
                                    <option>天津</option>
                                    <option>其他</option>                                 
                                </select>

                              </td>
                                <td style="width: 100px;float: right;margin-right: 2px;display: inline;">

                                    <select type="text" id="txt_Age" name="zzjs.net" value="年龄" style="color:#999999;font-family: microsoft yahei;width: 95px;" />
                                    <option selected="selected">7岁以下</option>
                                    <option>7—11岁</option>
                                    <option>12—15岁</option>
                                    <option>16—18岁</option>
                                    <option>18岁以上</option>                                 
                                </select>
                                </td>
                            </tr>

                            <tr>
                                
                                <td>
                                    <input type="text" id="txt_Mobile" value="手机" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei" />
                                </td>
                            </tr>
                            
                            <tr>
                                
                                <td>
                                    <input type="text" id="txt_Grand" name="zzjs.net" value="邮箱" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei"/>
                                </td>
                            </tr>
                            
                            <tr>
                                
                                
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

  
  <div class="barNav">
        <div class="fxdNav">
        
            <a href="#success" v="success">成功案例</a>
            
            <a href="#services" v="services">课程服务</a>
            
            <a href="#aboutbe" v="aboutbe">必益简介</a>
          
            <a href="#whybe" v="whybe">必益亮点</a>
           
            <a href="#belights" v="belights">精彩瞬间</a>
          
            <a href="#tips" v="tips">留学贴士</a>
        </div>
    </div>

    
    <div class="regform" style="position: fixed; float: right;right: 1px; top: 20%; cursor: pointer;">
        <div class="rightpart">
        <div class="baoming" style="background-color:rgba(11,34,80,0.9);">
                    <h3 class="h3" style="float: left; margin-left: 50px;">
                        注册填表</h3>
                    <h3 class="h3" style="float: right;margin-right: 50px;">
                        免费测试</h3>
                    <hr color=#fff size=0.8 width=90% >
                    
                    <div class="tb">
                        <table>
                            <tr>
                              
                                <td>
                                    <input type="text" id="txt_Name" name="zzjs.net" value="姓名" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei" />
                                </td>
                            </tr>
                            
                            <tr>
                                
                                <td style="width: 100px;float: left;display: inline;">
                                    <select type="text" id="txt_City" name="zzjs.net" value="城市" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei;width: 95px;" />

                                    <option selected="selected">上海</option>
                                    <option>北京</option>
                                    <option>成都</option>
                                    <option>深圳</option>
                                    <option>天津</option>
                                    <option>其他</option>                                 
                                </select>

                              </td>
                                <td style="width: 100px;float: right;margin-right: 2px;display: inline;">
                                    <select type="text" id="txt_Age" name="zzjs.net" value="年龄" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei;width: 95px;" />
                                    <option selected="selected">7岁以下</option>
                                    <option>7—11岁</option>
                                    <option>12—15岁</option>
                                    <option>16—18岁</option>
                                    <option>18岁以上</option>                                 
                                </select>
                                </td>
                            </tr>

                            <tr>
                                
                                <td>
                                    <input type="text" id="txt_Mobile" name="zzjs.net" value="手机" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei" />
                                </td>
                            </tr>
                            
                            <tr>
                                
                                <td>
                                    <input type="text" id="txt_Grand" name="zzjs.net" value="邮箱" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;font-family: microsoft yahei"/>
                                </td>
                            </tr>
                            
                            <tr>
                                
                                
                                <td>
                                    <a href="javascript:void(0)" onclick="AddComment()"><img src="images/zhuce.png"></a>
                                </td>
                                
                            </tr>
                        </table>
                    </div>
                </div>
                </div>
            
        
            
    </div>

    
    <!-- rolling -->
    <script type="text/javascript">

        $().ready(function () {
            $(".regform").hide();

          });
            
            var hideregform = function () {
                $(".regform").fadeOut(300);
                
            }


            var showregform = function () {
                $(".regform").fadeIn(300);
                
            };

            

            
            $(window).scroll(function () {
                if ($(".regform").length > 0) {
                    var sTop = $(document).scrollTop();
                    if (sTop > 300)
                        showregform();
                    else
                        hideregform();
                }
            });
    </script>   
 

 


  <div id="success">
  		<div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;学生成功案例&nbsp;&nbsp;&nbsp;&nbsp;——</h6>
  		</div>
  	<div class="main">
  		<div class="cases">
  			<div class="picsa"><img style="width:150px;height:170px;margin:20px auto;display: block;" alt="" src="images/zehua.png"></div>
  			<div class="wenzia">
  			<p><em>姓名：</em>王泽华&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>录取院校：</em>哈罗公学(Harrow College)</p>
  				<ul>
  					<li>学校介绍：A-level成绩排名全英TOP10的英国四大寄宿制公学之一</li>
  					<li>学员背景：王泽华一开始英语相对较差，但是兴趣广泛</li>
  					<li>申请之路：在必益教育推荐的外教辅导下，他的英语水平提高了不少，并被英国预备学校逊宁戴尔学校录取。他的英语和其他科目在预备学校里提高了不少，顾问老师也密切关注着他在预备学校的进度，并在每次的假期和学校放假时间帮他安排了导师制学校课程补习。最后，王泽华顺利进入哈罗公学就读九年级。</li>
  				</ul>
  			</div>
  		</div>

      <hr color=#777 size=0.8 width=100% >

  		<div class="cases">
      <div class="picsa"><img style="width:150px;height:170px;margin:20px auto;display: block;" alt="" src="images/williamyang.png"></div>
        <div class="wenzia">
        <p><em>姓名：</em>William Yang&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>录取院校：</em>美国比门特中学(The Bement School)</p>
          <ul>
            <li>学校介绍：极具学术多样性的美国中学</li>
            <li>学员背景：William是一个非常有个人魅力的孩子，在他就读的学校，每个家长都会知道他的存在，很多同学都以他为榜样</li>
            <li>申请之路：顾问老师从进一步提高他的英语能力和丰富他的课外活动这两方面帮助他。最终，他在必益教育老师的辅导下小托福得了875分（总分900分），另一方面，他积极参加我们组织的忧道志愿者活动，最终他实现了梦想。</li>
          </ul>
        </div>  
      </div>

      <hr color=#777 size=0.8 width=100% >

  		<div class="cases">
      <div class="picsa"><img style="width:150px;height:170px;margin:20px auto;display: block;" alt="" src="images/shirleyfu.png"></div>
        <div class="wenzia">
        <p><em>姓名：</em>Shirley Fu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>录取院校：</em>坎特伯雷国王学院(The King’s School, Canterbury)</p>
          <ul>
            <li>学校介绍：英国最古老的学院之一</li>
            <li>学员背景：Shirley的艺术非常有天分，在去英国之前就已经画了很多作品，但是局限在平面上，但是她的创造力极佳</li>
            <li>申请之路：2016年的每个假期，顾问老师都为Shirley定制了一些学习计划来准备她的英国学校考试。最后Shirley先拿到了爱普森学院的录取通知，接着等来了她心心念念的坎特伯雷国王学校，还成功拿到了艺术奖学金。</li>
          </ul>
        </div>  
      </div>

      <hr color=#777 size=0.8 width=100% >

  	</div>
  </div>
  
  <div id="services">
  		<div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;必益辅导服务&nbsp;&nbsp;&nbsp;&nbsp;——</h6>
  		</div>
  	<div class="main">
  		<div class="smalltitle"><h4>辅导服务</h4></div>
  		<div class="table">
  			<table width="100%" height=auto border="0" cellpadding="0" cellspacing="2px">
  <tr bgcolor="#0E4681">
    <td width="136" height="48"><div align="center">
      <h4>学生目的</h4>
    </div></td>
    <td width="250"><div align="center">
      <h4>服务名称</h4>
    </div></td>
    <td width="349"><div align="center">
      <h4>服务内容</h4>
    </div></td>
    <td width="155"><div align="center">
      <h4>班级规模</h4>
    </div></td>
  </tr>
  <tr>
    <td rowspan="2" bgcolor="#01669C"><div align="center">
      <h4>出国留学</h4>
    </div></td>
    <td height="150" bgcolor="#F2EEED"><div align="center">海外名校升学辅导服务</div></td>
    <td bgcolor="#F2EEED"><div align="center">•帮助学生全面提升英语综合能力<br />
      •提升专业课水平<br />
    •提升面试技巧和笔试技巧</div></td>
    <td bgcolor="#F2EEED"><div align="center">一对一</div></td>
  </tr>
  <tr>
    <td height="150" bgcolor="#D6E5EC"><div align="center">留学考试私教辅导服务</div></td>
    <td bgcolor="#D6E5EC"><div align="center">雅思、托福、小托福、SSAT、SAT<br/> IGCSE、AP、A-level、IB<br />
    详情可参照下方出国留学需要通过考试一览表</div></td>
    <td bgcolor="#D6E5EC"><div align="center">一对一、
      一对二<br />
    小班教学（最多4人）</div></td>
  </tr>
  <tr>
    <td rowspan="2" bgcolor="#01669C"><div align="center">
      <h4>入读国际学校</h4>
      <h4>提高成绩</h4>
    </div></td>
    <td height="150" bgcolor="#F2EEED" ><div align="center">国际学校升学辅导服务</div></td>
    <td bgcolor="#F2EEED"><div align="center">•结合入学面试和考试要求制定方案<br />
    •优化学生在面试和笔试中的表现</div></td>
    <td bgcolor="#F2EEED"><div align="center">一对一</div></td>
  </tr>
  <tr>
    <td height="150" bgcolor="#D6E5EC"><div align="center">国际学校在学辅导服务</div></td>
    <td bgcolor="#D6E5EC"><div align="center">考试类型：IGCSE，AP，A-level，IB<br />
    考试科目：数学、科学、英语、历史</div></td>
    <td bgcolor="#D6E5EC"><div align="center">一对一、
      一对二<br />
    小班教学（最多4人）</div></td>
  </tr>
  <tr>
    <td rowspan="2" bgcolor="#01669C"><div align="center">
      <h4>提高综合</h4>
      <h4>英语能力</h4>
    </div></td>
    <td bgcolor="#F2EEED" height="150"><div align="center">卓越名师精品体验服务</div></td>
    <td bgcolor="#F2EEED"><div align="center">•个性化辅导方案
      •名师讲座、沙龙<br />
      •定期学习报告
    •动态教学模式</div></td>
    <td bgcolor="#F2EEED"><div align="center">一对一</div></td>
  </tr>
  <tr>
    <td height="150" bgcolor="#D6E5EC"><div align="center">综合英语能力提升服务</div></td>
    <td bgcolor="#D6E5EC"><div align="center">•听力起步
      •阅读写作训练<br />
    •语法和词汇单项提升</div></td>
    <td bgcolor="#D6E5EC"><div align="center">一对一、
      一对二<br />
    小班教学（最多4人）</div></td>
  </tr>
</table>
  		</div>
  		<div class="smalltitle"><h4>服务流程详解</h4></div>
  		<div id="servicedetail">
  			<div class="steps">
  				<div class="picsb"><img style="width: 180px;height: 180px;margin:0 auto;display: block;" alt="" src="images/a.png"></div>
  				<div class="wenzib">
  					<h5>名师全面咨询</h5>
  					<ul>
  						<li>安排学生接受免费的初步咨询</li>
  						<li>了解学生个人学习的基本情况</li>
  						<li>为家长和学生提供初步的咨询指导意见</li>
  					</ul>
  					<h5>学习能力测评</h5>
  					<ul>
  						<li>安排学生接受专业考试系统评估测试</li>
  						<li>通过测试，迅速把握学生学习特点及优势，分析学生学习中存在的问题</li>
  					</ul>
  				</div>
  			</div>
  			<hr color=#777 size=1 width=100% >
  			
  			<div class="steps">
  				<div class="picsb"><img style="width: 180px;height: 180px;margin:0 auto;display: block;" alt="" src="images/b.png"></div>
  				<div class="wenzib">
  					<h5>制定学习规划</h5>
  					<ul>
  						<li>结合学生具体情况和辅导需求，及目标学校的授课特征，制定学习方案</li>
  						
  					</ul>
  					<h5>落实学习方案</h5>
  					<ul>
  						<li>量身定制专门的独立教案，帮助学生攻破薄弱环节</li>
  						<li>帮助学生全面提升英语综合能力、专业课水平、自信心以及面试和笔试技巧</li>
  					</ul>
  				</div>
  			</div>
  			
  			<hr color=#777 size=1 width=100% >
  			
  			<div class="steps">
  				<div class="picsb"><img style="width: 180px;height: 180px;margin:0 auto;display: block;" alt="" src="images/c.png"></div>
  				<div class="wenzib">
  					<h5>名定制个性化课程</h5>
  					<ul>
  						<li>课程涵盖国际教育主流课程体系</li>
  						<li>班级规模最多不超过4人</li>
  						<li>以孩子为中心，提供个性化学习方案</li>
  					</ul>
  					<h5>选择最佳教师</h5>
  					<ul>
  						<li>根据学生申请学校、学习科目及自身情况，选择最适合的教师</li>
  						<li>通教师选择范围不限于国内，也包括身处英美的海外顶尖教师</li>
  						<li>老师精力集中，每个孩子都会得到最全面的关注</li>
  					</ul>
  				</div>
  			</div>
  			
  			<hr color=#777 size=1 width=100% >
  			
  			<div class="steps">
  				<div class="picsb"><img style="width: 180px;height: 180px;margin:0 auto;display: block;" alt="" src="images/d.png"></div>
  				<div class="wenzib">
  					<h5>导师密切关注</h5>
  					<ul>
  						<li>双语教育管理人担任学习管家和导师</li>
  						<li>及时关注孩子的学习情况，保证既定学习目标的达成</li>
  						
  					</ul>
  					<h5>家校紧密结合</h5>
  					<ul>
  						<li>我们鼓励家长与导师保持密切联系，商讨学生的进步情况，及时调整教育方案</li>
  						<li>与学生家长定期沟通，确保学生为下一阶段的学习做好准备</li>
  					</ul>
  				</div>
  			</div>
  			
  			<hr color=#777 size=1 width=100% >
  			
  			<div class="steps">
  				<div class="picsb"><img style="width: 180px;height: 180px;margin:0 auto;display: block;" alt="" src="images/e.png"></div>
  				<div class="wenzib">
  					<h5>定期针对性测试及反馈</h5>
  					<ul>
  						<li>定期对孩子进行有针对性的测试，帮助老师及时调整学习方案</li>
  						<li>分析孩子测试数据，从不同纬度出具专业的评估报告</li>
  						
  					</ul>
  					<h5>资深名师推荐信</h5>
  					<ul>
  						<li>必益的很多老师是国际考试委员会和学校的面试官</li>
  						<li>他们的推荐能为学员申请学校锦上添花</li>
  					</ul>
  				</div>
  			</div>
  		</div>
  	</div>
  </div>

  <div id="aboutbe">
  	<div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;必益简历&nbsp;&nbsp;&nbsp;&nbsp;——</h6></div>
  	<div class="main">
  	<p>必益是中小学生个性化名师辅导高端教育品牌，以雄厚的教研实力和优良的教育品质闻名业内。</p>
		
	<p>必益以其优良的教育环境，专业的教学水平和教研实力，成为中小学生个性化教育的专家，旨在通过多种多样的辅导课程帮助即将出国就读的学生更好地适应国外生活；帮助打算进入国际学校的学生准备国际通用的入学考试（如雅思、托福）和学校面试。我们还会通过模拟面试等方法帮助学生适应国外多种教育体系下的授课方式。 </p>
	</div>
  </div>

  <div id="whybe">
    <div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;为何选择必益&nbsp;&nbsp;&nbsp;&nbsp;——</h6>
      </div>
      <div class="main" style="height:500px;">
        <div class="row1">
          <h3>优质课程专业服务</h3>
          <div class="reason">
            <div class="pica"><img style="width: 300;height:250px;display:block;" alt="" src="images/whybe1.png"></div>
            <div class="wenzic">
              <h5>全面兼顾 激发潜能</h5>
            <ul>
              <li>挖掘每个孩子的独特和内在潜能</li>
              <li>兼顾孩子的学习特点，帮助众多孩子梦圆海外</li>
              
            </ul>
            <h5>雄厚师资 因材施教</h5>
            <ul>
              <li>教师学术背景深厚</li>
              <li>多年丰富教学经验，通过考试淘汰制度培养出优秀的教师</li>
            </ul>
            <h5>国际教学 原汁原味</h5>
            <ul>
              <li>优质的教学课件体系及教学模式</li>
              <li>互动式教学，原汁原味的国际教学环境</li>
              <li>培养英语思维，加强逻辑思维能力</li>
            </ul>
            </div>
          </div>
        </div>

        <div class="row1">
          <h3>家长服务独具优势</h3>
          <div class="reason">
            <div class="pica"><img style="width: 300;height:250px;display:block;" alt="" src="images/whybe2.png"></div>
            <div class="wenzic">
              <h5>尊重家长 贴身服务</h5>
            <ul>
              <li>学习助理随时将学生情况反馈给家长</li>
              <li>为家长积累人脉，形成学习型家长圈</li>
              
            </ul>
            <h5>亲子学习 共系梦想</h5>
            <ul>
              <li>家庭教育在孩子成长过程中作用至关重要</li>
              <li>让家长有机会充分参加孩子的进步与成功</li>
            </ul>
            <h5>个性准备 整体规划</h5>
            <ul>
              <li>与家长一同思考孩子未来教育规划</li>
              <li>阶段性学习辅导与孩子长期目标契合</li>
              <li>从择校、申请等维度为孩子做好升学计划</li>
            </ul>
            </div>
          </div>
        </div>

        </div>
      
  </div>	

  <div id="belights">
    <div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;必益精彩瞬间&nbsp;&nbsp;&nbsp;&nbsp;——</h6>
      </div>
    <div class="main">

    <div class="zzsc-container">
  
  <div class="zzsc-content bgcolor-3">
    <div id="Main-Content">
    <div class="sliderTV__prev" id="arrowb" style="visibility: visible;">❰</div>
    <div class="sliderTV__next" id="arrowa" style="visibility: visible;">❱</div>

    

      <div class="Container">
    <!-- Flipster List -->  
        <div class="flipster">
         
          <ul>
          <li>
            <a href="#" class="Button Block" style="background:url(images/2.png);">
              <div class="intro">
              <p>
              中国国家主席习近平和必益教育董事长Simon Mackinnon先生</p>  
              </div>  
            </a>
          </li>
          <li>
            <a href="#" class="Button Block" style="background:url(images/1.png);">
              <div class="intro">
              <p>William和胡润百富创始人胡润先生</p> 
              </div>  
            </a>
          </li>
          <li>
            <a href="#" class="Button Block" style="background:url(images/3.png);">
              <div class="intro">
              <p>William和英国首相卡梅伦</p>  
              </div>  
            </a>
          </li>
          <li>
            <a href="#" class="Button Block" style="background:url(images/4.png);">
              <div class="intro">
              <p>William先生与Lord Wei韦鸣恩勋爵在牛津大学考察</p> 
              </div>  
            </a>
          </li>
          <li>
            <a href="#" class="Button Block" style="background:url(images/5.png);">
              <div class="intro">
              <p>William和潘石屹</p>  
              </div>  
            </a>
          </li>
          <li>
            <a href="#" class="Button Block" style="background:url(images/6.png);">
              <div class="intro">
              <p>William和英国教育大臣Michael Gove</p> 
              </div>  
            </a>
          </li>
          </ul>
        </div>
    <!-- End Flipster List -->

      </div>
    </div>
  </div>
</div>
<script>
       $('.sliderTV__next').click(function () {
        // slide to next item
        $('.flipster').trigger('flip-item flip-next');
      });
      $('.sliderTV__prev').click(function () {
          // slide to previous item
          $('.flipster').trigger('.flip-item flip-prev');
      });
    </script>
<script>$(function(){ $(".flipster").flipster({ style: 'carousel', start: 0 }); });</script>
      
    </div>
  </div>
  

 <div id="tips">
 	<div class="subtitle"><h6>——&nbsp;&nbsp;&nbsp;&nbsp;留学小贴士&nbsp;&nbsp;&nbsp;&nbsp;——</h6>
  		</div>
  	<div class="main">
  		<div class="smalltitle"><h4>出国留学需要通过考试一览表</h4></div>
  		<div class="table">
  			<table width="100%" height=auto border="0" cellpadding="0" cellspacing="2px">
  <tr>
    <th width="150" height="48" bgcolor="#0E4681" scope="col"><h4>目标学校</h4></th>
    <th width="260" bgcolor="#0E4681" scope="col"><h4>美国</h4></th>
    <th width="260" bgcolor="#0E4681" scope="col"><h4>英国</h4></th>
    <th width="216" bgcolor="#0E4681" scope="col"><h4>通用</h4></th>
  </tr>
  <tr>
    <th height="60" bgcolor="#01669C" scope="row"><h4>小学</h4></th>
    <td bgcolor="#F2EEED"><p align="center">ISEE</p></td>
    <td bgcolor="#F2EEED"><p align="center">学科测试（数学、英语）</p></td>
    <td rowspan="4" bgcolor="#01669C" style="color:white;"><p align="center" id="tongyong">面试 <br />
    （其中英国大学的面试仅限<br />指定专业或牛津剑桥） </p></td>
  </tr>
  <tr>
    <th height="150" bgcolor="#01669C" scope="row"><h4>中学</h4></th>
    <td bgcolor="#D6E5EC" height="150" ><p align="center">中学SSAT<br />
      (SSAT Middle)<br />
      小托福 <br />
     维立克留学面试</p></td>
    <td bgcolor="#D6E5EC"><p align="center">学科测试<br />
      （数学、英语、科学等） <br />
        UK ISET
    <br />Common  Entrance</p></td>
  </tr>
  <tr>
    <th height="150" bgcolor="#01669C" scope="row"><h4>高中</h4></th>
    <td bgcolor="#F2EEED"><p align="center">高中SSAT<br />
    (SSAT Upper)<br />
      托福 
    <br />维立克留学面试</p></td>
    <td bgcolor="#F2EEED"><p align="center">学科测试
      <br />（数学、科学、历史、英语等）
      <br />UK ISET<br />
    雅思 </p></td>
  </tr>
  <tr>
    <th height="150" bgcolor="#01669C" scope="row"><h4>大学</h4></th>
    <td bgcolor="#D6E5EC"><p align="center">托福、
      ACT<br />
      SAT、
      SAT II、
      AP<br />
    维立克留学面试</p></td>
    <td bgcolor="#D6E5EC"><p align="center">Foundation<br />
      A-Levels、
      IB
    <br />雅思</p></td>
  </tr>
</table>
  		</div>
		<div class="smalltitle"><h4>出国留学准备过程</h4></div>
		<div id="guocheng">
			<p class="process">打好英语基础</p>
			<p class="process" style="padding-top:20px">准备学科考试<br/>（数学，历史，<br/>科学等）</p>
			<p class="process" style="padding-top:20px">准备标化考试<br/>（托福、SAT、<br/>A-level等</p>
			<p class="process" style="padding-left:40px">准备面试</p>
		</div>

  	</div>
 </div>

 <div id="footer">
   <div id="logob"><img src="images/f-logo.jpg"/></div>
   <div id="address"> <p>上海市静安区长寿路1111号 悦达889中心 9楼02A-05室 <em>|</em>&nbsp;电话:400-850-4118</p>
           <p class="copyright"><span>© 2016 上海静安区必益教育培训中心保留所有权利</span>&nbsp;&nbsp;沪ICP备14003809号-1</p>
  </div>

  
</body>
</html>
