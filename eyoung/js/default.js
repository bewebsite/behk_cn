//搜索重置
function search_rest() {
    $(".buttonWrap [type=text]").val("");
    $(".buttonWrap select").val("");
    $(".buttonWrap [type=checkbox]").attr("checked", "");
}

//搜索
function search() {
    var query = "";
    //文本
    var texts = $(".buttonWrap [type=text]");
    for (var i = 0; i < texts.length; i++) {
        var _id = $(texts[i]).attr("ID");
        var _text = $.trim($(texts[i]).val());
        if (_text != "") {
            if (query != "") {
                query += "&";
            }
            query += _id + "=" + escape(_text);
        }
    }
    //隐藏文本
    var hids = $(".buttonWrap [type=hidden]");
    for (var i = 0; i < hids.length; i++) {
        var _id = $(hids[i]).attr("ID");
        var _text = $.trim($(hids[i]).val());
        if (_text != "") {
            if (query != "") {
                query += "&";
            }
            query += _id + "=" + escape(_text);
        }
    }
    //下拉列表
    var selects = $(".buttonWrap select")
    for (var i = 0; i < selects.length; i++) {
        var _id = $(selects[i]).attr("ID");
        var _text = $.trim($(selects[i]).val());
        if (_text != "") {
            if (query != "") {
                query += "&";
            }
            query += _id + "=" + escape(_text);
        }
    }
    if (query != "") {
        query += "&";
    }
    query += "pagesize=" + $("#drpPage").val();
    window.location.href = "?" + query;
}



//检查是否选中
function check_post(message) {
    var chks = $("#listTable [name=ids]:checked");
    if (chks.length < 1) {
        alert("至少选中一项");
        return false;
    }
    if (message != null && message != "") {
        return window.confirm(message);
    }
    return true;
}

//全选
function select_all(obj) {
    var chk = $("#selectAll").attr("checked");
    if (chk == "checked") {
        $("#listTable [name=ids]").attr("checked", "checked");
    }
    else {
        $("#listTable [name=ids]").attr("checked", false);
    }
}