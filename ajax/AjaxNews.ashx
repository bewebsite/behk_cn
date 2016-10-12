<%@ WebHandler Language="C#" Class="AjaxNews" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Newtonsoft.Json;
using Comm;
using System.Net.Json;
using System.Net;

public class AjaxNews : IHttpHandler
{

    private HttpRequest request = null;
    private HttpResponse response = null;
    private HttpSessionState session = null;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        request = context.Request;
        response = context.Response;
        session = context.Session;

        #region 防止钓鱼
        string host = request.UrlReferrer.Host;
        if (string.Compare(host, request.Url.Host) > 0)
        {
            return;
        }
        #endregion

        AjaxResult model = null;
        string action = request.Form["action"];
        switch (action)
        {
            case "GetNewsInfo": model = GetNewsInfo(); break;  //预约
        }

        if (model != null)
        {
            response.Write(JavaScriptConvert.SerializeObject(model));
        }
    }

    private AjaxResult GetNewsInfo()
    {
        AjaxResult result = new AjaxResult();
        result.State = false;
        string ID = request.Form["ID"];
        string IndexValue = request.Form["IndexValue"];

        if (string.IsNullOrWhiteSpace(ID) || !Verification.IsNum(ID) || string.IsNullOrWhiteSpace(IndexValue) || !Verification.IsNum(IndexValue))
        {
            result.Value = "参数错误";
            return result;
        }

        List<Model.NewsIntor> list = new BLL.NewsIntor().GetList(0, "", "NewsId=" + ID + "", "Sort desc,ID desc");
        if (list == null || list.Count == 0)
        {
            result.Value = "";
            result.State = true;
            return result;
        }
        int _index = int.Parse(IndexValue);

        if (list.Count - 1 < _index)
        {
            _index = 0;
        }
        Model.NewsIntor l = list[_index];
        StringBuilder sb = new StringBuilder();
        sb.AppendFormat("<h5 class=\"title\">{0}</h5>", l.Title);
        if (!string.IsNullOrWhiteSpace(l.Image))
        {

            System.Drawing.Image image = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath(l.Image));
            int width = image.Width;
            int height = image.Height;
            if (width > 640)
            {
                width = 640;
                height = width * image.Height / image.Width;
            }
            sb.AppendFormat("<div class=\"img\" style=\" text-align:center\"><img src=\"{0}\" style=\"width:" + width + "px;height:" + height + "px;\" alt=\"{1}\"><p class=\"name\">{1}</p></div>", l.Image, l.ImageAlt);
        }
        sb.AppendFormat("<div class=\"artical-test\"><p>{0}</p></div>", string.IsNullOrWhiteSpace(l.Intor) ? "" : l.Intor.Replace("\r\n", "<br/>"));
        if (!string.IsNullOrWhiteSpace(l.Link))
        {
            sb.AppendFormat("<div class=\"url\">参考链接：{0}</div>", l.Link);
        }
        if (!string.IsNullOrWhiteSpace(l.Remarks))
        {
            sb.AppendFormat("<div class=\"text\"><i class=\"i\"></i><p>{0}</p></div>", l.Remarks.Replace("\r\n", "<br/>"));
        }
        result.State = true;
        result.Value = sb.ToString();
        return result;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}