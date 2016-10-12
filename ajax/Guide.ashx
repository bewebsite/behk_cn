<%@ WebHandler Language="C#" Class="Guide" %>

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

public class Guide : IHttpHandler
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
            case "JoinGuide": model = JoinGuide(); break;  //预约
        }

        if (model != null)
        {
            response.Write(JavaScriptConvert.SerializeObject(model));
        }
    }


    /// <summary>
    /// 预约
    /// </summary>
    /// <returns></returns>
    private AjaxResult JoinGuide()
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
        string City = obj["City"].GetValue().ToString();
        string Age = obj["Age"].GetValue().ToString();
        string Grade = obj["Grade"].GetValue().ToString();
        string WantTime = obj["WantTime"].GetValue().ToString();
        string School1 = obj["School1"].GetValue().ToString();
        string School2 = obj["School2"].GetValue().ToString();
        string Place = obj["Place"].GetValue().ToString();
        string Comment = obj["Comment"].GetValue().ToString();
        string Num = obj["Num"].GetValue().ToString();
        string Source = obj["source"].GetValue().ToString();

 /*       if (string.IsNullOrWhiteSpace(Name))
        {
            result.Value = "姓名不能为空";
            return result;
        }
        if (string.IsNullOrWhiteSpace(Mobile))
        {
            result.Value = "手机号不能为空";
            return result;
        }
        else if (!Verification.IsMobile(Mobile))
        {
            result.Value = "手机号不正确";
            return result;
        }
        if (string.IsNullOrWhiteSpace(City))
        {
            result.Value = "所在城市不能为空";
            return result;
        }
        if (string.IsNullOrWhiteSpace(Age))
        {
            result.Value = "学生年龄不能为空";
            return result;
        }
        if (string.IsNullOrWhiteSpace(Grade))
        {
            result.Value = "学生所在班级不能为空";
            return result;
        }*/
        /*if (string.IsNullOrWhiteSpace(WantTime))
        {
            result.Value = "意向出国时间不能为空";
            return result;
        }
        if (string.IsNullOrWhiteSpace(School1))
        {
            result.Value = "面试志愿学校一不能为空";
            return result;
        }
        if (string.IsNullOrWhiteSpace(School2))
        {
            result.Value = "面试志愿学校二不能为空";
            return result;
        }
        if (string.IsNullOrWhiteSpace(Place))
        {
            result.Value = "面试地点不能为空";
            return result;
        }
        if (string.IsNullOrWhiteSpace(Num))
        {
            result.Value = "当天来宾人数不能为空";
            return result;
        }*/

        Model.AppointmentComment c = new Model.AppointmentComment();
        c.AbroadTime = WantTime;
        c.EntryPage = "/alis.html";
        c.AddTime = DateTime.Now;
        c.Age = Age;
        c.City = City;
        c.Comment = Comment.Replace("\n", "\r\n");
        c.DesireSchool1 = School1;
        c.DesireSchool2 = School2;
        c.Grade = Grade;
        c.GuestNum = Num;
        c.InterviewPlace = Place;
        c.IsReached = false;
        c.Mobile = Mobile;
        c.Name = Name;
        c.Channels = Source;
        c.EntryPage = "招生会推广页";
        int id = 0;
        new BLL.AppointmentComment().Add(c, out id);
        if (id > 0)
        {
            result.State = true;
            return result;
        }
        result.Value = "系统繁忙，请稍后再试";
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