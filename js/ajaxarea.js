var areaid;
var AjaxTerritorialId;
var one;
var two;
var three;
var istrue;

function GetAjaxTerritorialById(_areaid, _AjaxTerritorialId, _one, _two, _three, _istrue) {
    areaid = _areaid;
    AjaxTerritorialId = _AjaxTerritorialId;
    one = _one;
    two = _two;
    three = _three;
    istrue = _istrue;

    $("#" + istrue + "").val("0");

    //////////////////省份
    var select = document.createElement("select");
    select.options[0] = new Option("省份", "");
    select.id = "TerritorialOne"; //设置省份Id
    select.name = "TerritorialOne";

    var onelist = GetOne(); //获取省份列表
    for (var i = 0; i < onelist.length; i++) {
        select.options[i + 1] = new Option(onelist[i].Name, onelist[i].ID);
        if (one != null && one != "" && one == onelist[i].ID) {
            $(select.options[i + 1]).attr("selected", "selected");
            $("#" + AjaxTerritorialId + "").val(onelist[i].ID + "|");
        }
    }

    $(select).appendTo("#" + areaid); //添加select控件
    //$(select).addClass("ad");   //给select 添加样式
    $(select).attr("onchange", "changepro(this)");



    /////////////////城市
    var selectTwo = document.createElement("select");
    selectTwo.id = "TerritorialTwo";
    selectTwo.name = "TerritorialTwo";
    selectTwo.options[0] = new Option("城市", "");

    if ($("#TerritorialOne").val() != "") {
        var twolistbyid = GetTwo($("#TerritorialOne").val());
        if (twolistbyid != null && twolistbyid.length > 0) {

            //追加城市select内容
            for (var i = 0; i < twolistbyid.length; i++) {
                selectTwo.options[i + 1] = new Option(twolistbyid[i].Name, twolistbyid[i].ID);
                if (two != null && two != "" && two == twolistbyid[i].ID) {
                    $(selectTwo.options[i + 1]).attr("selected", "selected");
                    $("#" + AjaxTerritorialId + "").val($("#TerritorialOne").val() + "|" + twolistbyid[i].ID);
                }
            }
        }
    }

    $(selectTwo).appendTo("#" + areaid);
    //$(selectTwo).addClass("ad");  //给select添加样式
    $(selectTwo).attr("onchange", "changecity(this)");


    ///////////区县
    if ($("#TerritorialTwo").val() != "") {
        $("#" + istrue + "").val("0");
        var threelistbyid = GetThree($("#TerritorialTwo").val());
        if (threelistbyid != null && threelistbyid.length > 0) {
            var selectThree = document.createElement("select");
            selectThree.id = "TerritorialThree";
            selectThree.name = "TerritorialThree";
            selectThree.options[0] = new Option("区县", "");

            for (var i = 0; i < threelistbyid.length; i++) {
                selectThree.options[i + 1] = new Option(threelistbyid[i].Name, threelistbyid[i].ID);
                if (three != null && three != "" && three == threelistbyid[i].ID) {
                    $(selectThree.options[i + 1]).attr("selected", "selected");
                    $("#" + istrue + "").val("1");
                    $("#" + AjaxTerritorialId + "").val($("#TerritorialOne").val() + "|" + $("#TerritorialTwo").val() + "|" + threelistbyid[i].ID);
                }
            }
            $(selectThree).appendTo("#" + areaid);
            // $(selectThree).addClass("ad"); //给select 添加样式
            $(selectThree).attr("onchange", "changeplace(this)");
        }
        else {
            $("#" + istrue + "").val("1");
        }
    }


}


function changepro(obj) {
    var value = $(obj).val();

    $("#chk_true").val("0");
    $("#TerritorialThree").remove(); //移除区县
    $("#TerritorialTwo").empty();
    $("#TerritorialTwo").append("<option value=\"\">城市</option>");

    if (value == "") {
        $("#" + AjaxTerritorialId + "").val("");
        return;
    }

    var twolistbyid = GetTwo(value);
    if (twolistbyid != null && twolistbyid.length > 0) {

        //追加城市select内容
        for (var i = 0; i < twolistbyid.length; i++) {
            $("#TerritorialTwo").append("<option value=\"" + twolistbyid[i].ID + "\">" + twolistbyid[i].Name + "</option>");
        }
    }
    $("#" + AjaxTerritorialId + "").val(value + "|");
}

function changecity(obj) {
    var value = $(obj).val();
    $("#TerritorialThree").remove(); //移除区县
    if (value == "") {
        $("#" + AjaxTerritorialId + "").val($("#TerritorialOne").val() + "|");
        $("#" + istrue + "").val("0");
        return;
    }
    $("#" + AjaxTerritorialId + "").val($("#TerritorialOne").val() + "|" + $("#TerritorialTwo").val());
    $("#" + istrue + "").val("1");
    var threelistbyid = GetThree($("#TerritorialTwo").val());
    if (threelistbyid == null || threelistbyid == "" || threelistbyid.length <= 0) {
        return;
    }

    $("#" + istrue + "").val("0");


    var selectThree = document.createElement("select");
    selectThree.id = "TerritorialThree";
    selectThree.name = "TerritorialThree";
    selectThree.options[0] = new Option("区县", "");

    for (var i = 0; i < threelistbyid.length; i++) {
        selectThree.options[i + 1] = new Option(threelistbyid[i].Name, threelistbyid[i].ID);
        if (three != null && three != "" && three == threelistbyid[i].ID) {
        }
    }
    $(selectThree).appendTo("#" + areaid);
    // $(selectThree).addClass("ad"); //给select 添加样式
    $(selectThree).attr("onchange", "changeplace(this)");

}


function changeplace(obj) {
    var value = $(obj).val();
    if (value == "") {
        $("#" + AjaxTerritorialId + "").val($("#TerritorialOne").val() + "|" + $("#TerritorialTwo").val());
        $("#" + istrue + "").val("0");
    }
    else {
        $("#chk_true").val("1");
        var oneselect = $("#TerritorialOne").val();
        var twoselect = $("#TerritorialTwo").val();
        $("#" + AjaxTerritorialId + "").val(oneselect + "|" + twoselect + "|" + value); //给隐藏控件赋值
    }
}


//加载省份
function GetOne() {
    var resut_value;
    $.ajax({
        type: "post",
        url: "/ajax/AjaxTerritorial.ashx",
        data: { action: "getOne" },
        cache: false,
        async: false,
        dataType: "json",
        success: function (data) {
            resut_value = data;
        }
    });
    return resut_value;
}

//加载城市
function GetTwo(parentId) {
    var resut_value;
    $.ajax({
        type: "post",
        url: "/ajax/AjaxTerritorial.ashx",
        data: { action: "getTwo", ParentID: parentId },
        cache: false,
        async: false,
        dataType: "json",
        success: function (data) {
            resut_value = data;
        }
    });
    return resut_value;
}

function GetThree(parentId) {
    var resut_value;
    $.ajax({
        type: "post",
        url: "/ajax/AjaxTerritorial.ashx",
        data: { action: "getThree", ParentID: parentId },
        cache: false,
        async: false,
        dataType: "json",
        success: function (data) {
            resut_value = data;
        }
    });
    return resut_value;
}