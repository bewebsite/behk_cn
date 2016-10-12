using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Comm;
public partial class alis : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            repGuest.DataSource = new BLL.GuideGuest().GetList(0, "", "IsPass=1", "Sort desc,AddTime desc");
            repGuest.DataBind();

            repSchool.DataSource = new BLL.Schools().GetList(0, "", "", "Sort desc,AddTime desc");
            repSchool.DataBind();
        }
    }
    public string GetIntor(object b)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        string[] str = b.ToString().Replace("\r\n", "∑").Split('∑');
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < str.Length; i++)
        {
            int x = i + 1;
            sb.AppendFormat("<li><em>{0}</em>{1}</li>", x, str[i]);
        }
        return sb.ToString();
    }
    public string GetImage(object b)
    {
        if (b == null || b.ToString() == "")
        {
            return "/guide/images/img2.jpg";
        }
        return b.ToString();
    }
}
