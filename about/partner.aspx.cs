using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
public partial class about_partner : PublicPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string GetKind1()
    {
        StringBuilder sb = new StringBuilder();
        List<Model.Partner> list = new BLL.Partner().GetList(0, "", "Kind=1", "Sort desc,AddTime desc");
        foreach (Model.Partner l in list)
        {
            sb.AppendFormat("<div class=\"sch-item\">");
            if (!string.IsNullOrWhiteSpace(l.GetUrl))
            {
                sb.AppendFormat("<a href=" + l.GetUrl + " target=\"_blank\" title=\"{0}\">", l.CNName);
            }
            else
            {
                sb.AppendFormat("<a title=\"{0}\">", l.CNName);
            }
            sb.AppendFormat("<img src=" + l.Logo + " width=\"100\"  height=\"100\"/><h4>{0}</h4>", l.CNName);
            sb.Append("</a>");
            sb.Append("</div>");
        }
        return sb.ToString();
    }
    public string GetKind2()
    {
        StringBuilder sb = new StringBuilder();
        List<Model.Partner> list = new BLL.Partner().GetList(0, "", "Kind=2", "Sort desc,AddTime desc");
        foreach (Model.Partner l in list)
        {
            sb.AppendFormat("<div class=\"comp-item\">");
            if (!string.IsNullOrWhiteSpace(l.GetUrl))
            {
                sb.AppendFormat("<a href=" + l.GetUrl + " target=\"_blank\" title=\"{0}\" >", l.CNName);
            }
            else
            {
                sb.AppendFormat("<a title=\"{0}\">", l.CNName);
            }
            sb.AppendFormat("<img src=" + l.Logo + " /><h4>{0}</h4>", l.CNName);
            sb.Append("</a>");
            sb.Append("</div>");
        }
        return sb.ToString();
    }
}