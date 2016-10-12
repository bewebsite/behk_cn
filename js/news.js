// JavaScript Document

$(function () {
    var i = 0;
    var catalog_a = $("#catalog");
    var obj_a = $("#left_list");
    var list_len = obj_a.find("li").length;
    var list_a_height = obj_a.find("a").height() + 1;

    var _urlHash = 1;

    var url = window.location.href.toLowerCase();
    var str = url.split('#');
    if (str.length == 2) {
        var reg = /^[1-9]\d*$/;
        if (reg.test(str[1]) && parseInt(reg) != 0) {
            _urlHash = str[1];
        }
    }
    if (parseInt(_urlHash) > 1) {
        scl_animTo(parseInt(_urlHash) - 1);
        ajax_html(parseInt(_urlHash) - 1);
    }
    else {
        //内容页面高度
        var allH = $(".all-Chapeter").height();
        $(".all-box").height(allH);
    }


    i = parseInt(_urlHash) - 1;


    $(".ar-menu").click(function () {
        $(this).toggleClass("current");
        catalog_a.toggle(300);
    });

    //章节导航点击
    obj_a.find("li").find("a").bind("click", function () {
        if ($(".all-Chapeter").is(":animated")) return;
        var _index = $(this).parent().index();

        if ($(this).hasClass("cur")) return;

        obj_a.find("li").find("a").removeClass("cur");
        $(this).addClass("cur");

        catalog_a.find("li").find("a").removeClass("cur");
        catalog_a.find("li").eq(_index).find("a").addClass("cur");

        animateBox(_index);
    })


    if (list_len < 5) {
        obj_a.height(list_a_height * list_len - 1);
    } else {

        obj_a.height(list_a_height * 5 - 1);
        $("#scl-prev").bind("click", function () {
            if ($(".all-Chapeter").is(":animated")) return;
            var _urlHash = parseInt(window.location.hash.substr(1));
            var _href = $(this).attr("href", "#" + (_urlHash - 1));

            if (_urlHash <= 1) {
                _urlHash = 1;
                return false;
            }


            i--;
            if (i < 0) {
                i = 0;
            }



            obj_a.find("li").find("a").removeClass("cur");
            obj_a.find("li").eq(_urlHash - 2).find("a").addClass("cur");
            catalog_a.find("li").find("a").removeClass("cur");
            catalog_a.find("li").eq(_urlHash - 2).find("a").addClass("cur");

            scl_anim(list_a_height, i);
            animateBox(_urlHash - 2);


        });

        $("#scl-next").bind("click", function () {
            if ($(".all-Chapeter").is(":animated")) return;
            var _urlHash = parseInt(window.location.hash.substr(1));
            var _href = $(this).attr("href", "#" + (_urlHash + 1));

            if (_urlHash >= list_len) {
                _urlHash = list_len;
                return false;
            }

            i++;


            obj_a.find("li").find("a").removeClass("cur");
            obj_a.find("li").eq(_urlHash).find("a").addClass("cur");
            catalog_a.find("li").find("a").removeClass("cur");
            catalog_a.find("li").eq(_urlHash).find("a").addClass("cur");

            if (i > list_len - 5) {
                i = list_len - 5;
            }

            scl_anim(list_a_height, i);
            animateBox(_urlHash);


        });

    }


    //隐藏章节目录点击
    catalog_a.find("a").bind("click", function () {
        if ($(".all-Chapeter").is(":animated")) return;
        var _index = $(this).parent().index();
        if ($(this).hasClass("cur")) return;

        if (_index >= 5) {
            i = _index - 4;
            scl_anim(list_a_height, i);

        } else {
            i = 0;
            scl_anim(list_a_height, i);
        }
        $(this).parent("li").siblings("li").find("a").removeClass("cur");
        $(this).addClass("cur");

        obj_a.find("li").find("a").removeClass("cur");
        obj_a.find("li").eq(_index).find("a").addClass("cur");

        catalog_a.hide(300);
        $(".ar-menu").removeClass("current");
        animateBox(_index);

    })


    //默认页面执行动作  页面载入自动滚动到目标 #1、2、3
    function scl_animTo(b) {
        if ($(".all-Chapeter").is(":animated")) return;

        obj_a.find("li").find("a").removeClass("cur");
        obj_a.find("li").eq(_urlHash - 1).find("a").addClass("cur");

        catalog_a.find("a").removeClass("cur");
        catalog_a.find("li").eq(_urlHash - 1).find("a").addClass("cur");


        if (list_len > 5 && _urlHash >= 5) {
            i = _urlHash - 5;
            scl_anim(list_a_height, b - 4);
        } else {
            i = 0;
        }
    }


    //滚动右侧章节
    function scl_anim(h, i) {

        obj_a.find("ul").stop().animate({
            top: -h * i + "px"
        })
    }


    //详细内容滚动动画
    var allW = $(".all-Chapeter").width();

    function animateBox(_index) {

        var _urlHash2 = parseInt(window.location.hash.substr(1));

        lr();
        function lr() {
            if (_urlHash2 > _index + 1) { //上一页
                if ($(".all-Chapeter").is(":animated")) return;
                $(".all-Chapeter").animate({
                    left: allW + "px",
                    opacity: 0
                }, function () {

                    $(".all-Chapeter").css({
                        left: 0
                    }).stop().animate({
                        opacity: 1
                    })
                    //AJAX内容调取
                    ajax_html(_index);
                })
            } else { //下一页
                if ($(".all-Chapeter").is(":animated")) return;
                $(".all-Chapeter").animate({
                    left: -allW + "px",
                    opacity: 0
                }, function () {
                    $(".all-Chapeter").css({
                        left: 0
                    }).stop().animate({
                        opacity: 1
                    })
                    //AJAX内容调取
                    ajax_html(_index);

                })

            }

        }

        //章节名称
    }



})

function ajax_html(c) {
    var _loading = layer.msg("内容加载中...");
    var result = NewsInfo(c);
    if (!result.State) {
        layer.close(_loading);
        alert(result.Value);
        return;
    }

    var html = result.Value;
    $(".all-Chapeter .artical-info").html(html);
    layer.close(_loading);

    //内容页面高度
    var allH = $(".all-Chapeter").height();
    $(".all-box").height(allH);
}

function NewsInfo(indexValue) {
    var id = $("#hid_Id").val();
    var result = null;
    $.ajax({
        type: "post",
        async: false,
        url: "/ajax/AjaxNews.ashx",
        data: { action: "GetNewsInfo", ID: id, IndexValue: indexValue },
        cache: false,
        dataType: "json",
        success: function (text) {
            result = text;
        },
        error: function (e) {
            result = { Value: "系统繁忙，请稍后再试", State: false };
        }
    });

    return result;
}


function Getqrcode() {

    share_weixin();
}

function share_weixin() {

    var html = '<div class="bd_weixin_popup" id="bdshare_weixin">\
                <div class="bd_weixin_popup_head">\
                    <span>分享到微信朋友圈</span>\
                    <a class="bd_weixin_popup_close" href="#">×</a>\
                </div>\
                <div class="rcode" id="rcode"></div>\
             <div class="bd_weixin_popup_foot">打开微信，点击底部的“发现”，<br />\
             使用“扫一扫”即可将网页分享至朋友圈。</div></div>'

    if ($("#bdshare_weixin").length == 0) {
        $(html).appendTo("body");
        $("#rcode").qrcode({ width: 220, height: 220, correctLevel: 0, text: window.location.href });

        $(".bd_weixin_popup_close").click(function () {
            $("#bdshare_weixin").remove();
            return false;
        })
    }


}