function closePop() {
    $(".popBg").fadeOut();
}

function Comment2() {
    var name = $.trim($("#txt_Name2").val());
    var Mobile = $.trim($("#txt_Mobile2").val());
    var City = $.trim($("#txt_City2").val());
    var Age = $.trim($("#txt_Age2").val());
    var Num = $.trim($("#txt_GuestNum2").val());
    var Grade = $.trim($("#txt_Grade2").val());
    var Comment = $.trim($("#txt_Comment2").val());
    var AbroadTime = $.trim($("#txt_AbroadTime2").val());
    var Email = $.trim($("#txt_Email2").val());

    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    var reg0 = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$/;
    var str = "";
    if (name == "") {
        str += "请输入您的姓名<br/>";
    }
    if (Mobile == "") {
        str += "请输入您的手机号<br/>";
    }
    else if (reg0.test(Mobile) == false) {
        str += "请输入正确的手机号<br/>";
    }
    if (Email != "" && filter.test(Email) == false) {
        str += "请输入正确的邮箱地址<br/>";
    }
    if (City == "") {
        str += "请输入您目前所在的城市<br/>";
    }
    if (Age == "") {
        str += "请输入学生年龄<br/>";
    }
    if (Grade == "") {
        str += "请输入学生所在班级<br/>";
    }
    if (AbroadTime == "") {
        str += "请输入意向出国时间<br/>";
    }
    if (Num == "") {
        str += "请输入当天来宾人数<br/>";
    }
    if (str != "") {
        layer.alert(str);
        return;
    }
    Comment = Comment.replace('""', '');
    var item = {
        Kind: 2,
        Name: name,
        Mobile: Mobile,
        Email: Email,
        City: City,
        Age: Age,
        Grade: Grade,
        WantTime: AbroadTime,
        Num: Num,
        Comment: Comment,
        Title: $.trim($("#Hid_Title").val()),
        Url: window.location.href
    };

    var json = shop.getjson(item);
    var lode = layer.msg("处理中...");
    var result = InsertComment(json);
    layer.close(lode);
    if (!result.State) {
        layer.alert(result.Value);
    }
    else {
        $(".popWrapLg").hide();
        $(".popBg").fadeIn();
        Clear();
    }
}

function Clear() {
    $("#txt_Name2").val("");
    $("#txt_Mobile2").val("");
    $("#txt_City2").val("");
    $("#txt_Age2").val("");
    $("#txt_GuestNum2").val("");
    $("#txt_Grade2").val("");
    $("#txt_Comment2").val("");
    $("#txt_AbroadTime2").val("");
    $("#txt_Email2").val("");
}

function InsertComment(item) {
    var result = null;
    $.ajax({
        type: "post",
        async: false,
        url: "/ajax/AjaxComment.ashx",
        data: { action: "InsertComment", item: item },
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