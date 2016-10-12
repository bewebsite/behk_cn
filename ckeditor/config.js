/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function(config) {
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';
    skin: 'kama';
    config.filebrowserBrowseUrl = "/ckfinder/ckfinder.html";
    config.filebrowserImageBrowseUrl = "/ckfinder/ckfinder.html?Type=Images";
    config.filebrowserFlashBrowseUrl = "/ckfinder/ckfinder.html?Type=Flash";
    config.filebrowserUploadUrl = "/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Files";
    config.filebrowserImageUploadUrl = "/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Images";
    config.filebrowserFlashUploadUrl = "/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Flash";

    config.toolbar =
    [
        //源码      辙销    重做      打印 
         ['Source', 'Undo', 'Redo', 'Print'],

        //从word粘贴 
         ['PasteFromWord'],

        // 数字列表          实体列表          减小缩进      增大缩进
         ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent'],

        //超链接 取消超链接 锚点
         ['Link', 'Unlink', 'Anchor'],

        //图片 表格 水平线 特殊字符 分页符 文本颜色 背景颜色 全屏
          ['Image', 'Table', 'HorizontalRule', 'SpecialChar', 'PageBreak', '-', 'TextColor', 'BGColor', '-', 'Maximize'],

        //此处换行（为了让全屏时展开为一行，去掉'/'）

        //加粗 斜体， 下划线 穿过线 下标字 上标字
           ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'],

        //左对 齐 居中对齐 右对齐 两端对齐
            ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],

        // 样式 格式 字体 字体大小
            ['Styles', 'Format', 'Font', 'FontSize', 'lineheight']
    ];

 

    config.extraPlugins += (config.extraPlugins ? ',lineheight' : 'lineheight');

};
