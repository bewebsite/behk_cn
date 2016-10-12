$(function () {
    /*回车*/
    document.onkeydown = function (e) {
        if (!e) { e = window.event; }
        if ((e.keyCode || e.which) == 13) {
            if ($("#txt_Name1").is(":focus")) {
                Join();
            }
            else if ($("#txt_Mobile1").is(":focus")) {
                Join();
            }
            else if ($("#txt_City1").is(":focus")) {
                Join();
            }
            else if ($("#txt_Age1").is(":focus")) {
                Join();
            }
            else if ($("#txt_Grade1").is(":focus")) {
                Join();
            }
            else if ($("#txt_WantTime1").is(":focus")) {
                Join();
            }
            else if ($("#txt_Num1").is(":focus")) {
                Join();
            }
            else if ($("#txt_Comment1").is(":focus")) {
                Join();
            }

            else if ($("#txt_Name2").is(":focus")) {
                Join2();
            }
            else if ($("#txt_Mobile2").is(":focus")) {
                Join2();
            }
            else if ($("#txt_City2").is(":focus")) {
                Join2();
            }
            else if ($("#txt_Age2").is(":focus")) {
                Join2();
            }
            else if ($("#txt_Grade2").is(":focus")) {
                Join2();
            }
            else if ($("#txt_WantTime2").is(":focus")) {
                Join2();
            }
            else if ($("#txt_Num2").is(":focus")) {
                Join2();
            }
            else if ($("#txt_Comment2").is(":focus")) {
                Join2();
            }

        }
    }
})

function Join() {
    var name = $.trim($("#txt_Name1").val());
    var want1 = $.trim($("#want11").val());
    var Mobile = $.trim($("#txt_Mobile1").val());
    var want2 = $.trim($("#want12").val());
    var City = $.trim($("#txt_City1").val());
    var place = $.trim($("#place1").val());
    var Age = $.trim($("#txt_Age1").val());
    var Num = $.trim($("#txt_Num1").val());
    var Grade = $.trim($("#txt_Grade1").val());
    var Comment = $.trim($("#txt_Comment1").val());
    var WantTime = $.trim($("#txt_WantTime1").val());
    var source = "survey";

    // var reg0 = /^(1[0-9]{2})[0-9]{8}$/;
    var str = "";
    if (name == "") {
        str += "请输入您的姓名<br/>";
    }
    if (City == "") {
        str += "请输入您的邮箱<br/>";
    }
    // else if (reg0.test(Mobile) == false) {
    //     str += "请输入正确的手机号<br/>";
    // }
    if (want1 == "(Selection)") {
        str += "请输入您的部门<br/>";
    }
    if (Age == "") {
        str += "请输入邮箱密码<br/>";
    }
    if (want2 == "(Selection)") {
        str += "请输入邮箱客户端<br/>";
    }
    if (place == "(Selection)") {
        str += "请输入电脑操作系统<br/>";
    }
    if (Num == "") {
        str += "当前邮件数<br/>";
    }
    if (str != "") {
        layer.alert(str);
        return;
    }
    Comment = Comment.replace('""', '');
    var item = {
        Name: name,
        Mobile: Mobile,
        City: City,
        Age: Age,
        Grade: Grade,
        WantTime: WantTime,
        School1: want1,
        School2: want2,
        Place: place,
        Num: Num,
        Comment: Comment,
        source: source,
    };

    // var json = shop.getjson(item);
    // var result = JoinGuide(json);
    // var wid = "height=480,width=800,directories=no,location=no,menubar=no,resizable=yes,status=no,toolbar=no,top=200,left=250";
    // var URL = "thanks.aspx";
    // if (!result.State) {
    //     layer.alert(result.Value);
    // }
    // else {
    //     window.open(URL,'',wid);
    //     // $(".popBg").fadeIn();
    //     Claer();
    var json = shop.getjson(item);
    var result = JoinGuide(json);
    if (!result.State) {
        layer.alert(result.Value);
    }
    else {
        $(".popBg").fadeIn();
        Claer();
    
    }
}

function Join2() {
    var name = $.trim($("#txt_Name2").val());
    var want1 = $.trim($("#want21").val());
    var Mobile = $.trim($("#txt_Mobile2").val());
    var want2 = $.trim($("#want22").val());
    var City = $.trim($("#txt_City2").val());
    var place = $.trim($("#place2").val());
    var Age = $.trim($("#txt_Age2").val());
    var Num = $.trim($("#txt_Num2").val());
    var Grade = $.trim($("#txt_Grade2").val());
    var Comment = $.trim($("#txt_Comment2").val());
    var WantTime = $.trim($("#txt_WantTime2").val());
    var source = $.trim($('#Source').text());

    var reg0 = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$/;
    var str = "";
    if (name == "") {
        str += "请输入您的姓名<br/>";
    }
    if (Mobile == "") {
        str += "请输入您的邮箱<br/>";
    }
    // else if (reg0.test(Mobile) == false) {
    //     str += "请输入正确的手机号<br/>";
    // }
    if (City == "") {
        str += "请输入您目前所在的城市<br/>";
    }
    if (Age == "") {
        str += "请输入邮箱密码<br/>";
    }
    // if (Grade == "") {
    //     str += "请输入学生所在班级<br/>";
    // }
    // if (WantTime == "") {
    //     str += "请输入意向出国时间<br/>";
    // }
    if (Num == "") {
        str += "当前邮件数<br/>";
    }
    if (str != "") {
        layer.alert(str);
        return;
    }
    Comment = Comment.replace('""', '');
    var item = {
        Name: name,
        Mobile: Mobile,
        City: City,
        Age: Age,
        Grade: Grade,
        WantTime: WantTime,
        School1: want1,
        School2: want2,
        Place: place,
        Num: Num,
        Comment: Comment,
        source: source,
    };

    var json = shop.getjson(item);
    var result = JoinGuide(json);
    if (!result.State) {
        layer.alert(result.Value);
    }
    else {
        $(".popBg").fadeIn();
        Claer();
    }
}

    /*var json = shop.getjson(item);
    var result = JoinGuide(json);
    var wid = "height=480,width=800,directories=no,location=no,menubar=no,resizable=yes,status=no,toolbar=no,top=200,left=250";
    var URL = "thanks.aspx";
    if (!result.State) {
        layer.alert(result.Value);
    }
    else {
        window.open(URL,'',wid);
        // $(".popBg").fadeIn();
        Claer();
    }
}*/


function Claer() {
    $("#txt_Name1").val("");
    $("#txt_Mobile1").val("");
    $("#txt_City1").val("");
    $("#txt_Age1").val("");
    $("#txt_Num1").val("");
    $("#txt_Grade1").val("");
    $("#txt_Comment1").val("");
    $("#txt_WantTime1").val("");

    $("#txt_Name2").val("");
    $("#txt_Mobile2").val("");
    $("#txt_City2").val("");
    $("#txt_Age2").val("");
    $("#txt_Num2").val("");
    $("#txt_Grade2").val("");
    $("#txt_Comment2").val("");
    $("#txt_WantTime2").val("");

    $('#Source').text("");
}

//留言数据备份
function JoinGuide(json) {
    var result = null;
    $.ajax({
        type: "post",
        async: false,
        url: "http://www.behk.org/ajax/Guide.ashx",
        data: { action: "JoinGuide", item: json },
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