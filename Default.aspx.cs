using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _Default : PublicPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            repList.DataSource = new BLL.HomeNews().GetList(0, "", "Kind=1", "Sort desc,AddTime desc");
            repList.DataBind();
            repList2.DataSource = new BLL.HomeNews().GetList(0, "", "Kind=2", "Sort desc,AddTime desc");
            repList2.DataBind();
            repList3.DataSource = new BLL.HomeNews().GetList(0, "", "Kind=3", "Sort desc,AddTime desc");
            repList3.DataBind();
            repList4.DataSource = new BLL.HomeNews().GetList(0, "", "Kind=4", "Sort desc,AddTime desc");
            repList4.DataBind();
            repList5.DataSource = new BLL.HomeNews().GetList(0, "", "Kind=5", "Sort desc,AddTime desc");
            repList5.DataBind();

            repOne1.DataSource = new BLL.HomeSchool().GetList(0, "", "IsPass=1 and CountryId=1 and TypeId=1", "Sort desc,AddTime desc");
            repOne1.DataBind();
            repOne2.DataSource = new BLL.HomeSchool().GetList(0, "", "IsPass=1 and CountryId=1 and TypeId=2", "Sort desc,AddTime desc");
            repOne2.DataBind();
            repOne3.DataSource = new BLL.HomeSchool().GetList(0, "", "IsPass=1 and CountryId=1 and TypeId=3", "Sort desc,AddTime desc");
            repOne3.DataBind();

            repTwo1.DataSource = new BLL.HomeSchool().GetList(0, "", "IsPass=1 and CountryId=2 and TypeId=1", "Sort desc,AddTime desc");
            repTwo1.DataBind();
            repTwo2.DataSource = new BLL.HomeSchool().GetList(0, "", "IsPass=1 and CountryId=2 and TypeId=2", "Sort desc,AddTime desc");
            repTwo2.DataBind();
            repTwo3.DataSource = new BLL.HomeSchool().GetList(0, "", "IsPass=1 and CountryId=2 and TypeId=3", "Sort desc,AddTime desc");
            repTwo3.DataBind();

            repThree1.DataSource = new BLL.HomeSchool().GetList(0, "", "IsPass=1 and CountryId=3 and TypeId=1", "Sort desc,AddTime desc");
            repThree1.DataBind();
            repThree2.DataSource = new BLL.HomeSchool().GetList(0, "", "IsPass=1 and CountryId=3 and TypeId=2", "Sort desc,AddTime desc");
            repThree2.DataBind();
            repThree3.DataSource = new BLL.HomeSchool().GetList(0, "", "IsPass=1 and CountryId=3 and TypeId=3", "Sort desc,AddTime desc");
            repThree3.DataBind();

            
        }
    }
    public string GetBanner()
    {
        List<Model.Banner> list = new BLL.Banner().GetList(0, "", "IsPass=1 and Kind=10 and Sort<1000", "Sort desc,AddTime desc");
        if (list.Count == 0)
        {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        sb.AppendFormat("<div class=\"swBanner\"><div class=\"banContain\">");
        sb.AppendFormat("<ul class=\"banList clearfix\">");
        foreach (Model.Banner l in list)
        {
            if (!string.IsNullOrWhiteSpace(l.GetUrl))
            {
                sb.AppendFormat("<li><a href=\"{0}\" target=\"_blank\" title=\"{1}\"><img width=\"1180\" height=\"397\" src=\"{2}\" alt=\"{1}\"/></a></li>", l.GetUrl, l.Name, l.Image);
            }
            else
            {
                sb.AppendFormat("<li><img src=\"{0}\" width=\"1180\" height=\"397\" alt=\"{1}\"/></a></li>", l.Image, l.Name);
            }
        }
        sb.AppendFormat("</ul></div><div class=\"banBot\">");
        sb.AppendFormat("<h4 class=\"imgtit\">{0}</h4>", list[0].Name);
        sb.AppendFormat("<div class=\"small-d\">");
        for (int i = 0; i < list.Count; i++)
        {
            sb.AppendFormat("<a {0} href=\"javascript:void(0);\"></a>", i == 0 ? "class=\"curr\"" : "");
        }
        sb.AppendFormat(" </div></div>");
        if (list.Count > 1)
        {
            sb.AppendFormat("<a class=\"banB leftB\" href=\"javascript:void(0);\"></a><a class=\"banB rightB\" href=\"javascript:void(0);\"></a>");
        }
        sb.AppendFormat("</div>");
        return sb.ToString();
    }

}