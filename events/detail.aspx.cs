using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class activity_detail : PublicPage
{
    int ID = 0;
    Model.Events l = new Model.Events();

    public Model.Events L
    {
        get { return l; }
        set { l = value; }
    }
    public string HaveVoide = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        L = new BLL.Events().GetModelBystrWhere("IsPass=1 and ID=" + ID + "");
        if (L == null)
        {
            Response.Redirect("/events/");
        }
        if (!this.IsPostBack)
        {
            if (!string.IsNullOrWhiteSpace(L.PageTitle))
            {
                this.Title = L.PageTitle;
            }
            if (!string.IsNullOrWhiteSpace(L.PageTitle))
            {
                this.Title = L.PageTitle;
            }
            if (!string.IsNullOrWhiteSpace(L.PageTitle))
            {
                this.Title = L.PageTitle;
            }
            L.StarDay = DateTime.Parse(l.StarDay).ToString("M月d日");
            if (!string.IsNullOrWhiteSpace(L.EndDay))
            {
                L.StarDay += "-" + DateTime.Parse(l.EndDay).ToString("M月d日");
            }
            if (!string.IsNullOrWhiteSpace(L.EndTimer))
            {
                L.StarTimer += "-" + L.EndTimer;
            }


            if (!string.IsNullOrWhiteSpace(L.Highlights))
            {
                string[] v = L.Highlights.Replace("\r\n", "ㄖ").Split('ㄖ');
                string value = "";
                for (int i = 0; i < v.Length; i++)
                {
                    int q = i + 1;
                    value += "<li><span>" + q + "</span> " + v[i] + "</li>";
                }
                L.Highlights = value;
            }

            if (!string.IsNullOrWhiteSpace(L.Intor))
            {
                L.Intor = L.Intor.Replace("\r\n", "<br/>");
            }
            if (!string.IsNullOrWhiteSpace(L.Content))
            {
                L.Content = L.Content.Replace("\r\n", "<br/>");
            }
            if (!string.IsNullOrWhiteSpace(L.EnrollInfo))
            {
                L.EnrollInfo = L.EnrollInfo.Replace("\r\n", "<br/>");
            }

            repVoide.DataSource = new BLL.EventVoide().GetList(0, "", "EventId=" + ID + "", "Sort desc");
            repVoide.DataBind();
            if (repVoide.Items.Count == 0)
            {
                HaveVoide = "style=\"display:none\"";
            }

            repImage.DataSource = new BLL.EventImage().GetList(0, "", "EventId=" + ID + "", "Sort desc");
            repImage.DataBind();
            navHotEvents.Ids = ID;

            repGuest.DataSource = new BLL.GuideGuest().GetList(0, "", "Event like '%，" + ID.ToString() + "，%'", "Sort desc");
            repGuest.DataBind();

        }
    }

    public string GetInfo(object b)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        string s = b.ToString().Remove(0, 1);
        s = s.Substring(0, s.Length - 1);
        List<Model.Country> list = new BLL.Country().GetList(3, "Name", "IsPass=1 and ID in (" + s + ")", "Sort desc,AddTime desc");
        string v = "";
        foreach (Model.Country l in list)
        {
            v += "、" + l.Name;
        }
        if (v != "")
        {
            v = v.Remove(0, 1);
        }
        return v;
    }
}