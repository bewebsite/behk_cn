using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ascx_navHotEvents : System.Web.UI.UserControl
{
    int ids = 0;

    public int Ids
    {
        get { return ids; }
        set { ids = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            string where = "IsPass=1";
            if (Ids > 0)
            {
                where += " and ID<>" + Ids + "";
            }
            repEvents.DataSource = new BLL.Events().GetList(5, "HtmlName,CNTitle,StarDay,EndDay,StarTimer,EndTimer,Address", where, "IsHot desc,Sort desc,AddTime desc");
            repEvents.DataBind();
        }
    }
    public string GetInfo(object b, int k)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        if (k == 1)
        {
            return "-" + DateTime.Parse(b.ToString()).ToString("M月d日");
        }
        return "-" + b.ToString();
    }
}