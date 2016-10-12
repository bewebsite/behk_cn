$(function () {
    $(".slideBanner").swBanner();

//    $("#slide-1-1").kxbdSuperMarquee({
//        isAuto: false,
//        distance: 261,
//        time: 5,
//        direction: 'left',
//        btnGo: { right: '#btnLeft1', left: '#btnRight1' }
//    });
//    $("#slide-1-2").kxbdSuperMarquee({
//        isAuto: false,
//        distance: 261,
//        time: 5,
//        direction: 'left',
//        btnGo: { right: '#btnLeft1-2', left: '#btnRight1-2' }
//    });
//    $("#slide-1-3").kxbdSuperMarquee({
//        isAuto: false,
//        distance: 261,
//        time: 5,
//        direction: 'left',
//        btnGo: { right: '#btnLeft1-3', left: '#btnRight1-3' }
//    });
//    $("#slide-2-1").kxbdSuperMarquee({
//        isAuto: false,
//        distance: 261,
//        time: 5,
//        direction: 'left',
//        btnGo: { right: '#btnLeft2', left: '#btnRight2' }
//    });
//    $("#slide-2-2").kxbdSuperMarquee({
//        isAuto: false,
//        distance: 261,
//        time: 5,
//        direction: 'left',
//        btnGo: { right: '#btnLeft2-2', left: '#btnRight2-2' }
//    });
//    $("#slide-2-3").kxbdSuperMarquee({
//        isAuto: false,
//        distance: 261,
//        time: 5,
//        direction: 'left',
//        btnGo: { right: '#btnLeft2-3', left: '#btnRight2-3' }
//    });
//    $("#slide-3-1").kxbdSuperMarquee({
//        isAuto: false,
//        distance: 261,
//        time: 5,
//        direction: 'left',
//        btnGo: { right: '#btnLeft3', left: '#btnRight3' }
//    });
//    $("#slide-3-2").kxbdSuperMarquee({
//        isAuto: false,
//        distance: 261,
//        time: 5,
//        direction: 'left',
//        btnGo: { right: '#btnLeft3-2', left: '#btnRight3-2' }
//    });
//    $("#slide-3-3").kxbdSuperMarquee({
//        isAuto: false,
//        distance: 261,
//        time: 5,
//        direction: 'left',
//        btnGo: { right: '#btnLeft3-3', left: '#btnRight3-3' }
//    });
    $("#videolist").kxbdSuperMarquee({
        isAuto: false,
        distance: 293,
        time: 5,
        direction: 'left',
        btnGo: { right: '#vleft1', left: '#vright1' }
    });

    
    $(".mql-wrap .item").each(function () {
        $(this).find(".right-con").eq(0).show();
        $(this).find(".left a").eq(0).addClass("cur");
    })

    $(".mql-wrap .item .left a").hover(function () {
        $(this).siblings("a").removeClass().end().addClass("cur");
        $(this).parents(".item").find(".right-con").hide();
        $(this).parents(".item").find(".right-con").eq($(this).index()).show();
    })
    $(".mql-wrap .bar .nav span").hover(function () {
        $(this).siblings("span").removeClass().end().addClass("cur");
        $(".mql-wrap .con .item").hide();
        $(".mql-wrap .con .item").eq($(this).index()).show();
    })
    $(".mql,.video-index").hover(function () {
        var vl = $(this).find("li").length;
        if (vl > 4) {
            $(this).find(".btn").stop(true,true).fadeIn();
        }
    }, function () {
        $(".mql .btn,.video-index .btn").stop(true, true).fadeOut();
    })
})