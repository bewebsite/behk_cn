function AddComment() {
    var name = $.trim($("#txt_Name").val());
    var Mobile = $.trim($("#txt_Mobile").val());
    var City = $.trim($("#txt_City").val());
    var Age = $.trim($("#txt_Age").val());
    var Grand = $.trim($("#txt_Grand").val());
    var Intor = $.trim($("#txt_Intor").val());
    var reg0 = /^(1[0-9]{2})[0-9]{8}$/;
    var str = "";
    if (name == "姓名") {
        str += "请输入学生姓名<br/>";
    }
    if (Mobile == "手机") {
        str += "请输入联络手机号";
    }
    else if (reg0.test(Mobile) == false) {
        str += "请输入正确的手机号";
    }
    if (str != "") {
        layer.alert(str);
        return;
    }

    var id = $.trim($("#Hid_Id").val());
    var item = {
        Name: name,
        Mobile: Mobile,
        City: City,
        Age: Age,
        Grand: Grand,
        Intor: Intor,
        ID: id
    };

    var json = shop.getjson(item);
    var result = JoinGuide(json);
    var wid = "height=480,width=800,directories=no,location=no,menubar=no,resizable=yes,status=no,toolbar=no,top=200,left=250";
    var URL = "http://www.behk.org/thanks.aspx";
    if (!result.State) {
        layer.alert(result.Value);
    }
    else {
        
        // layer.alert("留言成功，我们会尽快与您联系");
        Claer();
        window.open(URL,'',wid);  
        
        
    }

}

function AddComment2() {
    var name = $.trim($("#txt_Name2").val());
    var Mobile = $.trim($("#txt_Mobile2").val());
    var City = $.trim($("#txt_City2").val());
    var Age = $.trim($("#txt_Age2").val());
    var Grand = $.trim($("#txt_Grand2").val());
    var Intor = $.trim($("#txt_Intor2").val());
    var reg0 = /^(1[0-9]{2})[0-9]{8}$/;
    var str = "";
    if (name == "") {
        str += "请输入学生姓名<br/>";
    }
    if (Mobile == "") {
        str += "请输入联络手机号";
    }
    else if (reg0.test(Mobile) == false) {
        str += "请输入正确的手机号";
    }
    if (str != "") {
        layer.alert(str);
        return;
    }

    var id = $.trim($("#Hid_Id").val());
    var item = {
        Name: name,
        Mobile: Mobile,
        City: City,
        Age: Age,
        Grand: Grand,
        Intor: Intor,
        ID: id
    };

    var json = shop.getjson(item);
    var result = JoinGuide(json);
    var wid = "height=480,width=800,directories=no,location=no,menubar=no,resizable=yes,status=no,toolbar=no,top=200,left=250";
    var URL = "http://www.behk.org/thanks.aspx";
    if (!result.State) {
        layer.alert(result.Value);
    }
    else {
        // layer.alert("留言成功，我们会尽快与您联系");
        Claer();
        window.open(URL,'',wid);
    }
}


function Claer() {
    $("#txt_Name").val("");
    $("#txt_Mobile").val("");
    $("#txt_City").val("");
    $("#txt_Age").val("");
    $("#txt_Grand").val("");
    $("#txt_Intor").val("");

    $("#txt_Name2").val("");
    $("#txt_Mobile2").val("");
    $("#txt_City2").val("");
    $("#txt_Age2").val("");
    $("#txt_Grand2").val("");
    $("#txt_Intor2").val("");
}

//留言数据备份
function JoinGuide(json) {
    var result = null;
    $.ajax({
        type: "post",
        async: false,
        url: "/ajax/AjaxComment.ashx",
        data: { action: "JoinProduct", item: json },
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