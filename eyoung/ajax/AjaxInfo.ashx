<%@ WebHandler Language="C#" Class="AjaxInfo" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;

public class AjaxInfo : IHttpHandler
{

    private HttpRequest request = null;
    private HttpResponse response = null;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        request = context.Request;
        response = context.Response;

        string result = null;
        string action = request.Form["action"];
        switch (action)
        {
            case "CheckProductHtml": result = CheckProductHtml(); break;
        }

        if (string.IsNullOrEmpty(result))
        {
            result = "";
        }

        response.Write(result);
    }
    public string CheckProductHtml()
    {
        string HtmlName = request.Form["Name"];
        if (string.IsNullOrEmpty(HtmlName))
        {
            return "";
        }
        Model.Urls m = new BLL.Urls().GetModelBystrWhere("HtmlUrl='" + HtmlName + ".html'");
        if (m == null)
        {
            return "1";
        }
        return "0";
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}