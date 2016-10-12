function JoinComment() {
    var name = $.trim($("#p_Name").val());
    var commpanyName = $.trim($("#p_CommpanyName").val());
    var mobile = $.trim($("#p_Mobile").val());
    var email = $.trim($("#p_Email").val());
    var str = "";
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
    var result = JoinGuide(name, commpanyName, mobile, email);
    if (!result.State) {
        layer.alert(result.Value);
    }
    else {
        layer.alert("申请成功，我们会尽快与您联系");
        $("#p_Name").val("");
        $("#p_CommpanyName").val("");
        $("#p_Mobile").val("");
        $("#p_Email").val("");
    }
}

//留言数据备份
function JoinGuide(name, commpanyName, mobile, email) {
    var result = null;
    $.ajax({
        type: "post",
        async: false,
        url: "/ajax/AjaxComment.ashx",
        data: { action: "JoinUs", Name: name, CommpanyName: commpanyName, Mobile: mobile, Email: email },
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