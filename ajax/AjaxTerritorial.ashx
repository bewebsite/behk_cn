<%@ WebHandler Language="C#" Class="AjaxTerritorial" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;

public class AjaxTerritorial : IHttpHandler
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
            case "getOne": result = getOne(); break;
            case "getTwo": result = getTwo(); break;
            case "getThree": result = getThree(); break;
        }

        if (string.IsNullOrEmpty(result))
        {
            result = "";
        }

        response.Write(result);
    }

    public string getOne()
    {
        List<Model.V_TerritorialOne> list = new BLL.V_TerritorialOne().GetList(0, "ID,Name", "", "");
        return JavaScriptConvert.SerializeObject(list); 
    }

    public string getTwo()
    {
        string ParentID = request.Form["ParentID"];
        if (string.IsNullOrEmpty(ParentID))
        {
            return null;
        }
        List<Model.V_TerritorialTwo> list = new BLL.V_TerritorialTwo().GetList(0, "ID,Name", "ParentID=" + ParentID + "", "");
        return JavaScriptConvert.SerializeObject(list);
    }

    public string getThree()
    {
        string ParentID = request.Form["ParentID"];
        if (string.IsNullOrEmpty(ParentID))
        {
            return null;
        }
        List<Model.V_TerritorialThree> list = new BLL.V_TerritorialThree().GetList(0, "ID,Name", "ParentID=" + ParentID + "", "");
        return JavaScriptConvert.SerializeObject(list);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}