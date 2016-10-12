
$(function () {

    $(".swBanner").swBanner();

   
    $(".sort-hd li").hover(function () {
        $(this).children("a").addClass("cur");
        $(this).siblings().children("a").removeClass("cur");
        $(".sortBody .sort-it").hide();
        $(".sortBody .sort-it").eq($(this).index()).show();

    });
    $(".area-sort a").hover(function () {
        $(this).siblings("a").removeClass("cur").end().addClass("cur");
        $(".tj-main .t-Item").hide();
        $(".tj-main .t-Item").eq($(this).index()).show();
    });

    $(".t-Item").each(function () {
        $(this).find(".sexItem").eq(0).show();
        $(this).find(".sex-ul li").eq(0).addClass("cur");
    });
    $(".sex-ul li").hover(function () {
        $(this).siblings().removeClass("cur").end().addClass("cur");
        $(this).parents(".t-Item").find(".sexItem").hide();
        $(this).parents(".t-Item").find(".sexItem").eq($(this).index()).show();
    });
   
})