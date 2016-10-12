// JavaScript Document

$(function () {

    //新闻下拉菜单
    $(".onav-l .news-oa").hover(function () {
        $(this).find(".inav-l").slideDown();

    }, function () {
        $(this).find(".inav-l").hide();

    });

    //新闻下拉二级菜单
    $(".inav-l .inli").hover(function () {
       
        $(this).find(".innav-l").fadeIn();

    }, function () {
        $(this).find(".innav-l").hide();

    });
    //回顶部
    $body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body');
    $(".goTop").click(function () {
        $body.stop().animate({ scrollTop: 0 }, "normal");
    });


    //分享到微信

})
function share_weixin() {
    var html='<div class="bd_weixin_popup" id="bdshare_weixin">\
                <div class="bd_weixin_popup_head">\
                    <span>分享到微信朋友圈</span>\
                    <a class="bd_weixin_popup_close" href="#">×</a>\
                </div>\
                <div class="rcode" id="rcode">123</div>\
             <div class="bd_weixin_popup_foot">打开微信，点击底部的“发现”，<br />\
             使用“扫一扫”即可将网页分享至朋友圈。</div></div>'

    $(html).appendTo("body");
    
}


$(document).ready(function(){
var str3 = '<div class="visible-desktop" style=" width: 100%; height: 85px; background-color:#004586; color:white; margin: 5px 0px 10px 0px; text-align: center; "> <p style="font-size: 26px; font-family: Microsoft Yahei;">Wycombe Abbey International Schools launched in China by BE Education and Wycombe Abbey</p> <p style=" font-family: Microsoft YaHei; font-size: 22px;margin-top: 15px;">英国精英私立寄宿学校Wycombe Abbey进入中国</p><p style=" float: right;margin-top: -15px; margin-right: 30px;"><a href="http://www.czoic.com/zh-hans/wycombeabbeyjinruzhongguo/" style="color:white;" target="_blank">查看更多</a> | <a href="http://www.czoic.com/beandwycombeabbey/" style="color:white;" target="_blank">More details...</a></p> </div>'
$(".navn").eq(0).after(str3);
});