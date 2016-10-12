using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
public partial class school_Default : PublicPage
{
    public string MoreVoide = "";
    public string MoreBanner = "";
    public string HaveBanner = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            repActivity.DataSource = new BLL.SchoolPageListActivity().GetList(4, "", "iSpASS=1", "Sort desc,AddTime desc");
            repActivity.DataBind();

            repNews.DataSource = new BLL.SchoolPageListNews().GetList(6, "", "IsPass=1", "Sort desc,AddTime desc");
            repNews.DataBind();

            repVoide.DataSource = new BLL.SchoolPageListVoide().GetList(0, "", "IsPass=1", "Sort desc,AddTime desc");
            repVoide.DataBind();
            if (repVoide.Items.Count > 4)
            {
                MoreVoide = "<a href=\"javascript:void(0);\" class=\"btn btnLeft\" id=\"vleft1\"></a><a href=\"javascript:void(0);\" class=\"btn btnRight\" id=\"vright1\"></a>";
            }
            List<Model.Banner> list = new BLL.Banner().GetList(0, "", "Ispass=1 and Kind=1", "Sort desc,AddTime desc");
            repBanner.DataSource = list;
            repBanner.DataBind();
            if (list.Count > 1)
            {
                MoreBanner = "<a href=\"javascript:void(0);\" class=\"btn btn-left\"></a><a href=\"javascript:void(0);\" class=\"btn btn-right\"></a>";
            }
            GetBanner(list);
            if (list.Count == 0)
            {
                HaveBanner = " style=\"display:none\"";
            }

            repCountry11.DataSource = new BLL.SchoolPageListSchool().GetList(8, "", "CountryId=1 and TypeId=1", "Sort desc,AddTime desc");
            repCountry11.DataBind();
            repCountry12.DataSource = new BLL.SchoolPageListSchool().GetList(8, "", "CountryId=1 and TypeId=2", "Sort desc,AddTime desc");
            repCountry12.DataBind();
            repCountry13.DataSource = new BLL.SchoolPageListSchool().GetList(8, "", "CountryId=1 and TypeId=3", "Sort desc,AddTime desc");
            repCountry13.DataBind();

            repCountry21.DataSource = new BLL.SchoolPageListSchool().GetList(8, "", "CountryId=2 and TypeId=1", "Sort desc,AddTime desc");
            repCountry21.DataBind();
            repCountry22.DataSource = new BLL.SchoolPageListSchool().GetList(8, "", "CountryId=2 and TypeId=2", "Sort desc,AddTime desc");
            repCountry22.DataBind();
            repCountry23.DataSource = new BLL.SchoolPageListSchool().GetList(8, "", "CountryId=2 and TypeId=3", "Sort desc,AddTime desc");
            repCountry23.DataBind();

            repCountry31.DataSource = new BLL.SchoolPageListSchool().GetList(8, "", "CountryId=3 and TypeId=1", "Sort desc,AddTime desc");
            repCountry31.DataBind();
            repCountry32.DataSource = new BLL.SchoolPageListSchool().GetList(8, "", "CountryId=3 and TypeId=2", "Sort desc,AddTime desc");
            repCountry32.DataBind();
            repCountry33.DataSource = new BLL.SchoolPageListSchool().GetList(8, "", "CountryId=3 and TypeId=3", "Sort desc,AddTime desc");
            repCountry33.DataBind();
        }
    }
    public string GetInfo(object b)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        return "-" + b.ToString();
    }
    public void GetBanner(List<Model.Banner> list)
    {
        StringBuilder sb = new StringBuilder();
        foreach (Model.Banner l in list)
        {
            if (!string.IsNullOrWhiteSpace(l.GetUrl))
            {
                sb.Append("<li><a href=" + l.GetUrl + " target=\"_blank\">");
                sb.Append("<img src=" + l.Image + " alt=\"" + l.Name + "\" /></a></li>");
            }
            else
            {
                sb.Append("<li><img src=" + l.Image + " alt=\"" + l.Name + "\" /></li>");
            }
        }
        Lit_Banner.Text = sb.ToString();
    }
    public string GetSmallBanner()
    {
        StringBuilder sb = new StringBuilder();
        List<Model.Banner> list = new BLL.Banner().GetList(3, "", "Ispass=1 and Kind=2", "Sort desc,AddTime desc");
        foreach (Model.Banner l in list)
        {
            sb.Append("<div class=\"ad2\">");
            if (!string.IsNullOrWhiteSpace(l.GetUrl))
            {
                sb.Append("<li><a href=" + l.GetUrl + " target=\"_blank\">");
                sb.Append("<img src=" + l.Image + " alt=\"" + l.Name + "\" /></a></li>");
            }
            else
            {
                sb.Append("<li><img src=" + l.Image + " alt=\"" + l.Name + "\" /></li>");
            }
            sb.Append("</div>");
        }
        return sb.ToString();
    }

    public string GetInfo2(object b)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        return "-" + DateTime.Parse(b.ToString()).ToString("M月d日");
    }
}