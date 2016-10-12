using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ascx_footer : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            repList.DataSource = new BLL.Temps().GetList(0, "top 5 ID,HtmlName,CNName", "lan=1", "AddTime desc");
            repList.DataBind();
        }
    }
}