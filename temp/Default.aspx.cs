using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
public partial class v_Default : PublicPage
{
    int ID = 0;
    public string HaveSchool = "";
    public string HaveImage = "";
    public string HaveProduct = "";
    public string HaveVoide = "";
    public Model.Temps t = new Model.Temps();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        t = new BLL.Temps().GetModelBystrWhere("ID=" + ID + "");
        if (t == null)
        {
            Response.Redirect("/");
        }
        if (!this.IsPostBack)
        {
            if (!string.IsNullOrWhiteSpace(t.PageTitle))
            {
                this.Title = t.PageTitle;
            }
            if (!string.IsNullOrWhiteSpace(t.PageKey))
            {
                this.Key.Content = t.PageKey;
            }
            if (!string.IsNullOrWhiteSpace(t.PageDes))
            {
                this.Des.Content = t.PageDes;
            }
            this.header1.Kind = t.ID.Value;
            repSchool.DataSource = new BLL.TempsSchool().GetList(0, "", "TempId=" + ID + "", "Sort desc");
            repSchool.DataBind();
            if (repSchool.Items.Count == 0)
            {
                HaveSchool = "style=\"display:none\"";
            }

            repCase.DataSource = new BLL.TempsCase().GetList(0, "", "TempId=" + ID + "", "Sort desc");
            repCase.DataBind();

            repImage.DataSource = repImage2.DataSource = new BLL.TempsImages().GetList(0, "", "TempId=" + ID + "", "Sort desc");
            repImage.DataBind();
            repImage2.DataBind();
            if (repImage2.Items.Count == 0)
            {
                HaveImage = "style=\"display:none\"";
            }

            repVoide.DataSource = new BLL.TempsVoide().GetList(0, "", "TempId=" + ID + "", "Sort desc");
            repVoide.DataBind();
            if (repVoide.Items.Count == 0)
            {
                HaveVoide = "style=\"display:none\"";
            }

            repProduct.DataSource = new BLL.TempsProduct().GetList(0, "", "TempId=" + ID + "", "Sort desc");
            repProduct.DataBind();
            if (repProduct.Items.Count == 0)
            {
                HaveProduct = "style=\"display:none\"";
            }

            repOther.DataSource = new BLL.TempsOthers().GetList(0, "", "TempId=" + ID + "", "Sort desc");
            repOther.DataBind();
        }
    }
    public string GetCountry()
    {
        if (!string.IsNullOrWhiteSpace(t.CountryId))
        {
            string ids = t.CountryId.Remove(0, 1);
            ids = ids.Substring(0, ids.Length - 1);
            List<Model.Country> list = new BLL.Country().GetList(0, "Name", "Kind=1 and ID in (" + ids + ")", "");
            string html = "";
            foreach (Model.Country l in list)
            {
                html += l.Name + "、";
            }
            if (!string.IsNullOrWhiteSpace(html))
            {
                return html.Substring(0, html.Length - 1);
            }
            return "";
        }
        return "";
    }
    public string GetBuessin()
    {
        if (!string.IsNullOrWhiteSpace(t.BusinessId))
        {
            string ids = t.BusinessId.Remove(0, 1);
            ids = ids.Substring(0, ids.Length - 1);
            List<Model.Country> list = new BLL.Country().GetList(0, "Name", "Kind=3 and ID in (" + ids + ")", "");
            string html = "";
            foreach (Model.Country l in list)
            {
                html += l.Name + "、";
            }
            if (!string.IsNullOrWhiteSpace(html))
            {
                return html.Substring(0, html.Length - 1);
            }
            return "";
        }
        return "";
    }
    public string GetCity()
    {
        if (!string.IsNullOrWhiteSpace(t.CityId))
        {
            string ids = t.CityId.Remove(0, 1);
            ids = ids.Substring(0, ids.Length - 1);
            List<Model.Country> list = new BLL.Country().GetList(0, "Name", "Kind=2 and ID in (" + ids + ")", "");
            string html = "";
            foreach (Model.Country l in list)
            {
                html += l.Name + "、";
            }
            if (!string.IsNullOrWhiteSpace(html))
            {
                return html.Substring(0, html.Length - 1);
            }
            return "";
        }
        return "";
    }

    public string GetLevels()
    {
        if (!string.IsNullOrWhiteSpace(t.LevelsId))
        {
            string ids = t.LevelsId.Remove(0, 1);
            ids = ids.Substring(0, ids.Length - 1);
            List<Model.Country> list = new BLL.Country().GetList(0, "Name", "Kind=4 and ID in (" + ids + ")", "");
            string html = "";
            foreach (Model.Country l in list)
            {
                html += l.Name + "、";
            }
            if (!string.IsNullOrWhiteSpace(html))
            {
                return html.Substring(0, html.Length - 1);
            }
            return "";
        }
        return "";
    }

    public string GetInfo(object b)
    {
        List<Model.TempsProductInfo> list = new BLL.TempsProductInfo().GetList(0, "", "Pid=" + b + "", "Sort desc");
        if (list.Count == 0)
        {
            return "";
        }
        int x = 0;
        StringBuilder sb = new StringBuilder();
        StringBuilder sb2 = new StringBuilder();
        foreach (Model.TempsProductInfo l in list)
        {
            if (x % 2 == 0)
            {
                sb.AppendFormat("<dl><dt>{0}<em></em></dt><dd>{1}</dd></dl>", l.Name, l.Intor.Replace("\r\n", "<br/>"));
            }
            else
            {
                sb2.AppendFormat("<dl><dt>{0}<em></em></dt><dd>{1}</dd></dl>", l.Name, l.Intor.Replace("\r\n", "<br/>"));
            }
            x += 1;
        }
        string html = "<div class=\"cons clearfix\">";
        html += "<div class=\"left\">" + sb.ToString() + "</div>";
        if (list.Count > 1)
        {
            html += "<div class=\"right\">" + sb2.ToString() + "</div>";
        }
        html += "</div>";
        return html;
    }
}