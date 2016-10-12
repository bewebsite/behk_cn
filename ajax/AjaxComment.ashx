<%@ WebHandler Language="C#" Class="AjaxComment" %>

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

public class AjaxComment : IHttpHandler
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

/*       #region 防止钓鱼
        string host = request.UrlReferrer.Host;
        if (string.Compare(host, request.Url.Host) > 0)
        {
            return;
        }
        #endregion
*/
        AjaxResult model = null;
        string action = request.Form["action"];
        switch (action)
        {
            case "InsertComment": model = InsertComment(); break;  //预约
            case "InsertCommentPhone": model = InsertCommentPhone(); break;//手机预约
            case "JoinProduct": model = JoinProduct(); break;//产品留言
            case "JoinUs": model = JoinUs(); break;//加入我们
            case "CommentInfo": model = CommentInfo(); break;//联系我们留言
            case "JoinProduct_OtherSite": model = JoinProduct_OtherSite(); break; //OtherSite 产品留言
        }

        if (model != null)
        {
            response.Write(JavaScriptConvert.SerializeObject(model));
        }
    }

    private AjaxResult InsertComment()
    {
        AjaxResult result = new AjaxResult();
        result.State = false;
        string json = request.Form["item"];
        if (string.IsNullOrEmpty(json))
        {
            result.Value = "参数错误";
            return result;
        }
        JsonTextParser parser = new JsonTextParser();
        JsonObjectCollection obj = parser.Parse(json) as JsonObjectCollection;
        JsonUtility.GenerateIndentedJsonText = false;
        string Name = obj["Name"].GetValue().ToString();
        string Mobile = obj["Mobile"].GetValue().ToString();
        string Email = obj["Email"].GetValue().ToString();
        string Age = obj["Age"].GetValue().ToString();
        string City = obj["City"].GetValue().ToString();
        string Grade = obj["Grade"].GetValue().ToString();
        string WantTime = obj["WantTime"].GetValue().ToString();
        string Num = obj["Num"].GetValue().ToString();
        string Comment = obj["Comment"].GetValue().ToString();
        string Kind = obj["Kind"].GetValue().ToString();
        string Title = obj["Title"].GetValue().ToString();
        string Url = obj["Url"].GetValue().ToString();

        Model.GuestComment m = new Model.GuestComment();
        m.AbroadTime = WantTime;
        m.AddTime = DateTime.Now;
        m.Age = Age;
        m.City = City;
        m.Comment = Comment;
        m.Email = Email;
        m.FollowUp = "";
        m.Grade = Grade;
        m.GuestNum = Num;
        m.IsExistingCustomer = false;
        m.IsReached = false;
        m.Kind = int.Parse(Kind);
        m.Mobile = Mobile;
        m.Name = Name;
        m.StudentName = "";
        m.StudentSex = "";
        if (!string.IsNullOrWhiteSpace(Title))
        {
            m.Title = Title;
        }
        if (!string.IsNullOrWhiteSpace(Url))
        {
            m.NowPage = Url;
        }

        int id = 0;
        new BLL.GuestComment().Add(m, out id);
        if (id > 0)
        {
            result.State = true;
            return result;
        }
        result.Value = "系统繁忙，请稍后再试";
        return result;
    }


    private AjaxResult InsertCommentPhone()
    {
        AjaxResult result = new AjaxResult();
        result.State = false;
        string json = request.Form["item"];
        if (string.IsNullOrEmpty(json))
        {
            result.Value = "参数错误";
            return result;
        }
        JsonTextParser parser = new JsonTextParser();
        JsonObjectCollection obj = parser.Parse(json) as JsonObjectCollection;
        JsonUtility.GenerateIndentedJsonText = false;
        string Name = obj["Name"].GetValue().ToString();
        string Mobile = obj["Mobile"].GetValue().ToString();
        string Email = obj["Email"].GetValue().ToString();
        string Age = obj["Age"].GetValue().ToString();
        string City = obj["City"].GetValue().ToString();
        string Grade = obj["Grade"].GetValue().ToString();
        string WantTime = obj["WantTime"].GetValue().ToString();
        string Num = obj["Num"].GetValue().ToString();
        string Comment = obj["Comment"].GetValue().ToString();
        string Kind = obj["Kind"].GetValue().ToString();
        string Title = obj["Title"].GetValue().ToString();

        Model.GuestComment m = new Model.GuestComment();
        m.AbroadTime = WantTime;
        m.AddTime = DateTime.Now;
        m.Age = Age;
        m.City = City;
        m.Comment = Comment;
        m.Email = Email;
        m.FollowUp = "";
        m.Grade = Grade;
        m.GuestNum = Num;
        m.IsExistingCustomer = false;
        m.IsReached = false;
        m.Kind = int.Parse(Kind);
        m.Mobile = Mobile;
        m.Name = Name;
        m.StudentName = "";
        m.StudentSex = "";
        if (!string.IsNullOrWhiteSpace(Title))
        {
            m.Title = Title;
        }

        int id = 0;
        new BLL.GuestComment().Add(m, out id);
        if (id > 0)
        {
            result.State = true;
            return result;
        }
        result.Value = "系统繁忙，请稍后再试";
        return result;
    }

    private AjaxResult JoinProduct()
    {
        AjaxResult result = new AjaxResult();
        result.State = false;
        string json = request.Form["item"];
        if (string.IsNullOrEmpty(json))
        {
            result.Value = "参数错误";
            return result;
        }
        JsonTextParser parser = new JsonTextParser();
        JsonObjectCollection obj = parser.Parse(json) as JsonObjectCollection;
        JsonUtility.GenerateIndentedJsonText = false;
        string Name = obj["Name"].GetValue().ToString();
        string Mobile = obj["Mobile"].GetValue().ToString();
        string Age = obj["Age"].GetValue().ToString();
        string City = obj["City"].GetValue().ToString();
        string Grade = obj["Grand"].GetValue().ToString();
        string Intor = obj["Intor"].GetValue().ToString();
        string ID = obj["ID"].GetValue().ToString();

        Model.GuestComment g = new Model.GuestComment();
        g.IsExistingCustomer = false;
        g.IsReached = false;
        g.AddTime = DateTime.Now;
        g.Age = Age;
        g.City = City;
        g.Comment = Intor;
        g.Grade = Grade;
        g.Kind = 5;
        g.Mobile = Mobile;
        g.Name = "";
        g.NowPage = "";
        g.Title = "";
        if (!string.IsNullOrWhiteSpace(ID) && Verification.IsNum(ID))
        {
            Model.Temps t = new BLL.Temps().GetModelBystrWhere("CNName,HtmlName", "ID=" + ID + "");
            if (t != null)
            {
                g.NowPage = "http://go.behk.org/temp/" + t.HtmlName + ".html";
                g.Title = t.CNName;
            }
        }
        g.StudentName = Name;
        int id = 0;
        new BLL.GuestComment().Add(g, out id);
        if (id > 0)
        {
            result.State = true;
            return result;
        }
        result.Value = "系统繁忙，请稍后再试";
        return result;
    }


    private AjaxResult JoinProduct_OtherSite()
    {
        AjaxResult result = new AjaxResult();
        result.State = false;
        string json = request.Form["item"];
        if (string.IsNullOrEmpty(json))
        {
            result.Value = "Parameter error";
            return result;
        }
        JsonTextParser parser = new JsonTextParser();
        JsonObjectCollection obj = parser.Parse(json) as JsonObjectCollection;
        JsonUtility.GenerateIndentedJsonText = false;
        string Name = obj["Name"].GetValue().ToString();
        string Mobile = obj["Mobile"].GetValue().ToString();
        string Age = obj["Age"].GetValue().ToString();
        string City = obj["City"].GetValue().ToString();
        string Grade = obj["Grand"].GetValue().ToString();
        string Intor = obj["Intor"].GetValue().ToString();
        string ID = obj["ID"].GetValue().ToString();
        string product = obj["product"].GetValue().ToString();

        Model.GuestComment g = new Model.GuestComment();
        g.IsExistingCustomer = false;
        g.IsReached = false;
        g.AddTime = DateTime.Now;
        g.Age = Age;
        g.City = City;
        g.Comment = Intor;
        g.Grade = Grade;
        g.Kind = 5;
        g.Mobile = Mobile;
        g.Name = "";
        g.NowPage = "";
        g.Title = product;
        g.StudentName = Name;
        int id = 0;
        new BLL.GuestComment().Add(g, out id);
        if (id > 0)
        {
            result.State = true;
            return result;
        }
        result.Value = "Sorry, system is busy, please try again later";
        return result;
    }

    private AjaxResult JoinUs()
    {
        AjaxResult result = new AjaxResult();
        result.State = false;
        string Name = request.Form["Name"];
        string CommpanyName = request.Form["CommpanyName"];
        string Email = request.Form["Email"];
        string Mobile = request.Form["Mobile"];
        if (string.IsNullOrEmpty(Name) || string.IsNullOrWhiteSpace(Email))
        {
            result.Value = "参数错误";
            return result;
        }

        Model.JoinUsComment model = new Model.JoinUsComment();
        model.AddTime = DateTime.Now;
        model.CommpanyName = CommpanyName;
        model.Email = Email;
        model.Intor = "";
        model.Mobile = Mobile;
        model.Name = Name;
        new BLL.JoinUsComment().Add(model);
        result.State = true;
        return result;
    }

    private AjaxResult CommentInfo()
    {
        AjaxResult result = new AjaxResult();
        result.State = false;
        string Name = request.Form["Name"];
        string City = request.Form["City"];
        string Email = request.Form["Email"];
        string Mobile = request.Form["Mobile"];
        string Info = request.Form["Info"];
        string Intor = request.Form["Intor"];
        if (string.IsNullOrEmpty(Name) || string.IsNullOrWhiteSpace(Email))
        {
            result.Value = "参数错误";
            return result;
        }

        Model.ContantComment model = new Model.ContantComment();
        model.AddTime = DateTime.Now;
        model.City = City;
        model.Email = Email;
        model.Intor = Intor;
        model.Back = "";
        model.GetInfo = Info;
        model.Mobile = Mobile;
        model.Name = Name;
        new BLL.ContantComment().Add(model);
        result.State = true;
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