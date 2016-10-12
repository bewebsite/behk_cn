// JavaScript Document

$(function () {
    var vTop = $(".barNav").offset().top;

    var $body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body'); //operaFix

    $(window).bind("scroll", function () {
        var sTop = $(document).scrollTop();
        if (sTop > vTop) {
            $("body").addClass("scl");
        } else {

            $("body").removeClass("scl");
        }
    })

    $(".fxdNav a").bind("click", function () {
        var n = $(this).attr("v");

        var nTop = $("#" + n).offset().top-40;

        $body.stop().animate({ scrollTop: nTop }, "normal");



    })
})

function openPop() {
    $(".popBg").fadeIn();
    return;
}
function closePop() {
    $(".popBg").fadeOut();
    return;
}
