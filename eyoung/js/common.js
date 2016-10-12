$(function () {
    $(".nav-list").eq(0).show();


    $("#nav a").bind("click", function () {
        var _href = $(this).data("navjs");
        if (!_href) return;
        $(this).addClass("cur").parent("li").siblings("li").find("a").removeClass("cur");
        $(".nav-list").hide();
        $("#" + _href).show();
    })

    var _url = $("#nav a.cur").data("navjs");
    if (_url) {
        $(".nav-list").hide();
        $("#" + _url).show();
    }

    $(".menuWrap").hover(function () {
        $(this).find(".popupMenu").show();
    }, function () {

        $(this).find(".popupMenu").hide();
    })


    //产品编辑选项卡
    $(".itemWrap").eq(0).show();
    $("#tab li").bind("click", function () {
        var _index = $(this).index();
        $(this).siblings("li").removeClass().end().addClass("current");
        $(".itemWrap").hide();
        $(".itemWrap").eq(_index).show();
    })


})

function PrveSort(obj) {
    var li = $(obj).parent();
    var lihtml = $(obj).parent().html();
    var lilist = $("#proImg ul li");
    if (lilist.eq(0).html() == lihtml) {
        return;
    }


    var livalue = $(li).find(".urlInput input").val();

    var prve = $(li).prev("li");
    var prvehtml = $(li).prev("li").html();

    var prvevalue = $(prve).find(".urlInput input").val();

    $(prve).html(lihtml);
    $(li).html(prvehtml);

    $(prve).find(".urlInput input").val(livalue);
    $(li).find(".urlInput input").val(prvevalue);
}

function NextSort(obj) {
    var li = $(obj).parent();
    var lihtml = $(obj).parent().html();
    var lilist = $("#proImg ul li");
    if (lilist.eq(lilist.length - 1).html() == lihtml) {
        return;
    }

    var livalue = $(li).find(".urlInput input").val();

    var next = $(li).next("li");
    var nexthtml = $(li).next("li").html();

    var nextvalue = $(next).find(".urlInput input").val();


    $(next).html(lihtml);
    $(li).html(nexthtml);
    $(next).find(".urlInput input").val(livalue);
    $(li).find(".urlInput input").val(nextvalue);
}