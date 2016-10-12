using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class ascx_header : BaseControl
{
    int _Kind = 0;

    public int Kind
    {
        get { return _Kind; }
        set { _Kind = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            string url = Request.Url.ToString().ToLower();
            if (url.IndexOf("/events/") >= 0)
            {
                base.Index = 2;
            }
            else if (url.IndexOf("/temp/") >= 0)
            {
                if (Kind <= 2)
                {
                    base.Index = 5;
                }
            }
            else if (url.IndexOf("/news/") >= 0)
            {
                base.Index = 3;
            }
            else if (url.IndexOf("/schools/") >= 0)
            {
                base.Index = 4;
            }
            else
            {
                base.Index = 1;
            }

            repTwo.DataSource = new BLL.Temps().GetList(0, "ID,HtmlName,CNName", "ID<3 or ID=9 or ID=15 or id=16 or id=17 or id=18 " , "AddTime desc");
            repTwo.DataBind();

            repNews.DataSource = new BLL.NewsType().GetList(0, "ID,Name", "IsPass=1", "Sort desc,AddTime desc");
            repNews.DataBind();
        }
    }
    public string GetList()
    {
        List<Model.Temps> list = new BLL.Temps().GetList(4, "ID,HtmlName,CNName", "ID>2 and Lan=1 and ID<>9 and ID<>15 and ID<>16 and ID<>17 and ID<>18 and ID<>4 and ID<>5", "AddTime desc");
        string html = "";
        foreach (Model.Temps l in list)
        {
            string css = "";
            if (l.ID.Value == Kind)
            {
                css = "cur";
            }
            html += "<li><a href=\"/" + l.HtmlName + ".html\"  class=\"oa " + css + "\" >" + l.CNName + "</a></li>";
        }
        return html;
    }
}