function JoinComment() {
    var name = $.trim($("#p_Name").val());
    var intor = $.trim($("#p_Intor").val());
    var city = $.trim($("#p_City").val());
    var mobile = $.trim($("#p_Mobile").val());
    var email = $.trim($("#p_Email").val());
    var Info = "";
    var str = "";

    var list = $("#infolist li input");
    for (var i = 0; i < list.length; i++) {
        var item = $(list).eq(i);
        if (item.attr("checked") == "checked") {
            Info += item.val() + ",";
        }
    }

    var reg0 = /^0?(1[0-9]{2})[0-9]{8}$/;
    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if (name == "") {
        str += "请输入您的姓名<br/>";
    }
    if (mobile != "" && reg0.test(mobile) == false) {
        str += "请输入正确的手机号码<br/>";
    }
    if (email == "") {
        str += "请输入邮箱地址<br/>";
    }
    else if (filter.test(email) == false) {
        str += "邮箱地址不正确<br/>";
    }
    if (str != "") {
        layer.alert(str);
        return;
    }
    var result = JoinGuide(name, city, mobile, email, Info, intor);
    if (!result.State) {
        layer.alert(result.Value);
    }
    else {
        layer.alert("留言成功，我们会尽快与您联系");
        $("#p_Name").val("");
        $("#p_City").val("");
        $("#p_Mobile").val("");
        $("#p_Email").val("");
        $("#p_Intor").val("");
        for (var i = 0; i < list.length; i++) {
            var item = $(list).eq(i);
            item.attr("checked", false);
        }
    }
}

//留言数据备份
function JoinGuide(name, city, mobile, email, Info, intor) {
    var result = null;
    $.ajax({
        type: "post",
        async: false,
        url: "/ajax/AjaxComment.ashx",
        data: { action: "CommentInfo", Name: name, City: city, Mobile: mobile, Email: email, Info: Info, Intor: intor },
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
};