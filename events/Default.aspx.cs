using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Comm;
public partial class news_Default : PublicPage
{
    public int CountryId = 0;
    public int TypeId = 0;
    public int CityId = 0;
    public int BusinessId = 0;
    public int LevelsId = 0;
    public int CategoriesId = 0;
    int StarAge = 0;
    int EndAge = 0;
    public string Name = "";
    public string Stars = "";
    public string Ends = "";
    public int OrderBy = 0;
    public int AllCount = 0;
    public string HavePage = "";
    public string MoreBanner = "";
    public string HaveBanner = "";
    public string HaveMorePage = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        CountryId = base.QueryInt("CountryId");
        TypeId = base.QueryInt("TypeId");
        CityId = base.QueryInt("CityId");
        BusinessId = base.QueryInt("BusinessId");
        LevelsId = base.QueryInt("LevelsId");
        CategoriesId = base.QueryInt("CategoriesId");
        StarAge = base.QueryInt("StarAge");
        EndAge = base.QueryInt("EndAge");
        Name = base.QueryString("Name");
        OrderBy = base.QueryInt("OrderBy");
        if (!this.IsPostBack)
        {
            if (StarAge > 0)
            {
                Stars = StarAge.ToString();
            }
            if (EndAge > 0)
            {
                Ends = EndAge.ToString();
            }
            if (string.IsNullOrWhiteSpace(Name))
            {
                Name = "请输入活动名称";
            }


            string where = "IsPass=1";
            if (TypeId > 0)
            {
                where += " and TypeId=" + TypeId + "";
            }
            if (CountryId > 0)
            {
                where += " and RelevantCountry like '%" + CountryId + "%'";
            }
            if (CityId > 0)
            {
                where += " and RelevantCity like '%," + CityId + ",%'";
            }

            if (BusinessId > 0)
            {
                where += " and RelevantBusiness like '%," + BusinessId + ",%'";
            }

            if (LevelsId > 0)
            {
                where += " and RelevantLevels like '%," + LevelsId + ",%'";
            }

            if (CategoriesId > 0)
            {
                where += " and RelevantCategories like '%," + CategoriesId + ",%'";
            }

            if (StarAge > 0)
            {
                where += " and StarAge>=" + StarAge + "";
            }
            if (EndAge > 0)
            {
                where += " and EndAge<=" + EndAge + "";
            }
            if (!string.IsNullOrWhiteSpace(Name) && Name != "请输入活动名称")
            {
                where += " and (CNTitle like '%" + Name + "%' or ENTitle like '%" + Name + "%')";
            }


            Model.PageData<Model.Events> data = new BLL.Events().GetList(10, base.PageIndex, "HtmlName,CNTitle,ENTitle,RelevantBusiness,RelevantCountry,StarDay,EndDay,StarTimer,EndTimer,Address,RelevantCategories", where, "Sort desc,AddTime desc");
            repList.DataSource = data.DataSoure;
            repList.DataBind();
            pgServer.RecordCount = data.Count;
            pgServer.PageSize = 10;
            pgServer.DataBind();
            lit_nodata.Visible = data.Count < 1 ? true : false;
            AllCount = data.Count;
            if (data.PageCount == 1)
            {
                HaveMorePage = "style=\"display:none\"";
            }


            List<Model.Banner> list = new BLL.Banner().GetList(0, "", "Ispass=1 and Kind=6", "Sort desc,AddTime desc");
            repBanner.DataSource = list;
            repBanner.DataBind();
            if (list.Count > 1)
            {
                MoreBanner = "<a href=\"javascript:void(0);\" class=\"btn btn-left\"></a><a href=\"javascript:void(0);\" class=\"btn btn-right\"></a>";
            }
            else if (list.Count == 0)
            {
                HaveBanner = "style=\"display:none\"";
            }
            GetBanner(list);

        }
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


    public string GetTyes()
    {
        StringBuilder sb = new StringBuilder();
        List<Model.EventsType> list = new BLL.EventsType().GetList(0, "ID,Name", "IsPass=1", "Sort desc,AddTime desc");
        if (list.Count > 0)
        {
            sb.Append("<dl class=\"clearfix\"><dt>活动类型</dt><dd>");
            sb.AppendFormat("<a {1} href=\"/events/{0}\">全部</a>", getUrl("TypeId", ""), TypeId <= 0 ? " class=\"cur\"" : "");
            foreach (Model.EventsType l in list)
            {
                string css = TypeId == l.ID.Value ? " class=\"cur\"" : "";
                sb.AppendFormat("<a href=\"/events/{0}\" {1}>{2}</a>", getUrl("TypeId", l.ID.Value.ToString()), css, l.Name);
            }
            sb.Append("</dd></dl>");
        }
        return sb.ToString();
    }
    //获取相关留学国家
    public string GetCounty()
    {
        StringBuilder sb = new StringBuilder();
        List<Model.Country> list = new BLL.Country().GetList(0, "ID,Name", "IsPass=1 and Kind=1", "Sort desc,AddTime desc");
        if (list.Count > 0)
        {
            sb.Append("<dl class=\"clearfix\"><dt>相关留学国家</dt><dd>");
            sb.AppendFormat("<a {1} href=\"/events/{0}\">全部</a>", getUrl("CountryId", ""), CountryId <= 0 ? " class=\"cur\"" : "");
            foreach (Model.Country l in list)
            {
                string css = CountryId == l.ID.Value ? " class=\"cur\"" : "";
                sb.AppendFormat("<a href=\"/events/{0}\" {1}>{2}</a>", getUrl("CountryId", l.ID.Value.ToString()), css, l.Name);
            }
            sb.Append("</dd></dl>");
        }
        return sb.ToString();
    }

    //获取适用城市
    public string GetCity()
    {
        StringBuilder sb = new StringBuilder();
        List<Model.Country> list = new BLL.Country().GetList(0, "ID,Name", "IsPass=1 and Kind=2", "Sort desc,AddTime desc");
        if (list.Count > 0)
        {
            sb.Append("<dl class=\"clearfix\"><dt>适用城市</dt><dd>");
            sb.AppendFormat("<a {1} href=\"/events/{0}\">全部</a>", getUrl("CityId", ""), CityId <= 0 ? " class=\"cur\"" : "");
            foreach (Model.Country l in list)
            {
                string css = CityId == l.ID.Value ? " class=\"cur\"" : "";
                sb.AppendFormat("<a href=\"/events/{0}\" {1}>{2}</a>", getUrl("CityId", l.ID.Value.ToString()), css, l.Name);
            }
            sb.Append("</dd></dl>");
        }
        return sb.ToString();
    }



    //必益相关业务
    public string GetBusiness()
    {
        StringBuilder sb = new StringBuilder();
        List<Model.Country> list = new BLL.Country().GetList(0, "ID,Name", "IsPass=1 and Kind=3", "Sort desc,AddTime desc");
        if (list.Count > 0)
        {
            sb.Append("<dl class=\"clearfix\"><dt>必益相关业务</dt><dd>");
            sb.AppendFormat("<a {1} href=\"/events/{0}\">全部</a>", getUrl("BusinessId", ""), BusinessId <= 0 ? " class=\"cur\"" : "");
            foreach (Model.Country l in list)
            {
                string css = BusinessId == l.ID.Value ? " class=\"cur\"" : "";
                sb.AppendFormat("<a href=\"/events/{0}\" {1}>{2}</a>", getUrl("BusinessId", l.ID.Value.ToString()), css, l.Name);
            }
            sb.Append("</dd></dl>");
        }
        return sb.ToString();
    }


    //适用学习阶段
    public string GetLevels()
    {
        StringBuilder sb = new StringBuilder();
        List<Model.Country> list = new BLL.Country().GetList(0, "ID,Name", "IsPass=1 and Kind=4", "Sort desc,AddTime desc");
        if (list.Count > 0)
        {
            sb.Append("<dl class=\"clearfix\"><dt>适用学习阶段</dt><dd>");
            sb.AppendFormat("<a {1} href=\"/events/{0}\">全部</a>", getUrl("LevelsId", ""), LevelsId <= 0 ? " class=\"cur\"" : "");
            foreach (Model.Country l in list)
            {
                string css = LevelsId == l.ID.Value ? " class=\"cur\"" : "";
                sb.AppendFormat("<a href=\"/events/{0}\" {1}>{2}</a>", getUrl("LevelsId", l.ID.Value.ToString()), css, l.Name);
            }
            sb.Append("</dd></dl>");
        }
        return sb.ToString();
    }


    //适用人群类型
    public string GetCategories()
    {
        StringBuilder sb = new StringBuilder();
        List<Model.Country> list = new BLL.Country().GetList(0, "ID,Name", "IsPass=1 and Kind=5", "Sort desc,AddTime desc");
        if (list.Count > 0)
        {
            sb.Append("<dl class=\"clearfix\"><dt>适用人群类型</dt><dd>");
            sb.AppendFormat("<a {1} href=\"/events/{0}\">全部</a>", getUrl("CategoriesId", ""), CategoriesId <= 0 ? " class=\"cur\"" : "");
            foreach (Model.Country l in list)
            {
                string css = CategoriesId == l.ID.Value ? " class=\"cur\"" : "";
                sb.AppendFormat("<a href=\"/events/{0}\" {1}>{2}</a>", getUrl("CategoriesId", l.ID.Value.ToString()), css, l.Name);
            }
            sb.Append("</dd></dl>");
        }
        return sb.ToString();
    }

    /// <summary>
    /// 获取Url
    /// </summary>
    /// <param name="name"></param>
    /// <param name="value"></param>
    /// <returns></returns>
    protected string getUrl(string name, string value)
    {
        string url = System.Text.RegularExpressions.Regex.Replace(Request.Url.Query.Trim(), @"^\?", "");
        url = System.Text.RegularExpressions.Regex.Replace(url, "^" + name + "=.*?&|" + name + "=.*?&", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        url = System.Text.RegularExpressions.Regex.Replace(url, "&{0,1}" + name + "=.*", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        url = System.Text.RegularExpressions.Regex.Replace(url, "^page=.*?&|page=.*?&", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        url = System.Text.RegularExpressions.Regex.Replace(url, "&{0,1}page=.*", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        if (url.Trim() == "")
        {
            return "?" + name + "=" + value + "#searchlist";
        }
        return getReplaceUrl("?" + name + "=" + value + "&" + url, "key");
    }

    /// <summary>
    /// 获取Url
    /// </summary>
    /// <param name="name"></param>
    /// <param name="value"></param>
    /// <returns></returns>
    protected string getReplaceUrl(string url, string name)
    {
        url = System.Text.RegularExpressions.Regex.Replace(url, "^" + name + "=.*?&|" + name + "=.*?&", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        url = System.Text.RegularExpressions.Regex.Replace(url, "&{0,1}" + name + "=.*", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        url = System.Text.RegularExpressions.Regex.Replace(url, "^page=.*?&|page=.*?&", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        url = System.Text.RegularExpressions.Regex.Replace(url, "&{0,1}page=.*", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);

        return url + "#searchlist";
    }

    public string GetInfo()
    {
        StringBuilder sb = new StringBuilder();
        if (TypeId > 0)
        {
            Model.EventsType c = new BLL.EventsType().GetModelBystrWhere("ID,Name", "ID=" + TypeId + "");
            if (c != null)
            {
                sb.AppendFormat("<span class=\"s\"><b>{0}</b><a href=\"{1}\"></a></span>", c.Name, getUrl("TypeId", ""));
            }
        }
        if (CountryId > 0)
        {
            Model.Country c = new BLL.Country().GetModelBystrWhere("ID,Name", "ID=" + CountryId + "");
            if (c != null)
            {
                sb.AppendFormat("<span class=\"s\"><b>{0}</b><a href=\"{1}\"></a></span>", c.Name, getUrl("CountryId", ""));
            }
        }
        if (CityId > 0)
        {
            Model.Country c = new BLL.Country().GetModelBystrWhere("ID,Name", "ID=" + CityId + "");
            if (c != null)
            {
                sb.AppendFormat("<span class=\"s\"><b>{0}</b><a href=\"{1}\"></a></span>", c.Name, getUrl("CityId", ""));
            }
        }
        if (BusinessId > 0)
        {
            Model.Country c = new BLL.Country().GetModelBystrWhere("ID,Name", "ID=" + BusinessId + "");
            if (c != null)
            {
                sb.AppendFormat("<span class=\"s\"><b>{0}</b><a href=\"{1}\"></a></span>", c.Name, getUrl("BusinessId", ""));
            }
        }
        if (LevelsId > 0)
        {
            Model.Country c = new BLL.Country().GetModelBystrWhere("ID,Name", "ID=" + LevelsId + "");
            if (c != null)
            {
                sb.AppendFormat("<span class=\"s\"><b>{0}</b><a href=\"{1}\"></a></span>", c.Name, getUrl("LevelsId", ""));
            }
        }
        if (CategoriesId > 0)
        {
            Model.Country c = new BLL.Country().GetModelBystrWhere("ID,Name", "ID=" + CategoriesId + "");
            if (c != null)
            {
                sb.AppendFormat("<span class=\"s\"><b>{0}</b><a href=\"{1}\"></a></span>", c.Name, getUrl("CategoriesId", ""));
            }
        }

        if (sb.ToString() != "")
        {
            sb.Insert(0, "<div class=\"top\"><span href=\"/events/\" class=\"all\">新闻中心</span><em></em>");
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

    public string GetInfo(object b)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        return "-" + b.ToString();
    }

    public string GetCountryName(object b)
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