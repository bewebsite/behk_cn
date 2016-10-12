(function ($) {
    $.fn.extend({
        swBanner: function (options) {

            var defaults = {
                w: 1180,
                time: 5000,
                animation: 800
            };

            var options = $.extend(defaults, options);

            return this.each(function () {

                var o = options;
                var obj = $(this);
                var objLi = obj.find("li");
                var objUl = obj.find("ul");
                var objA = obj.find(".small-d a");
                var curr = 0;
                var oPrev = obj.find(".leftB");
                var oNext = obj.find(".rightB");
                var oAlen = objLi.length;
                var objIndex = 1;

                obj.find(".imgtit").text(objLi.eq(0).find("img").attr("alt"));
                objUl.width(oAlen * o.w);
                objA.click(function () {

                    objA.removeClass("curr");
                    $(this).addClass("curr");
                    var _index = $(this).index();
                    objIndex = _index;
                    objUl.stop().animate({
                        left: -(o.w * objIndex) + "px"
                    })

                    obj.find(".imgtit").text(objLi.eq(_index).find("img").attr("alt"));


                });


                oPrev.click(function () {
                    objIndex = obj.find("a.curr").index();
                    objA.eq(objIndex - 1).click();
                });

                oNext.click(function () {
                    objIndex = obj.find("a.curr").index();
                    if (objIndex == (oAlen - 1)) {
                        objIndex = 0;
                        objA.eq(objIndex).click();
                    } else {
                        objA.eq(objIndex + 1).click();
                    }
                });

                objA.hover(function () {
                    clearInterval(sTime);
                }, function () {
                    objIndex = obj.find("a.curr").index() + 1;
                    if (objIndex == oAlen) {
                        objIndex = 0;
                    }
                    sTime = setInterval(function () {
                        objA.eq(objIndex).click();
                        objIndex++;
                        if (objIndex == oAlen) {
                            objIndex = 0;
                        }
                    }, o.time);
                });

                var sTime = setInterval(function () {
                    objA.eq(objIndex).click();
                    objIndex++;
                    if (objIndex == oAlen) {
                        objIndex = 0;
                    }
                }, o.time);

            });
        }
    });
})(jQuery);