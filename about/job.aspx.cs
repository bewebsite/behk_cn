using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class about_job :PublicPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            repList.DataSource = new BLL.Job().GetList(0, "", "Lan=1", "Sort desc,AddTime desc");
            repList.DataBind();
            repPing.DataSource = new BLL.JobPoint().GetList(0, "", "Lan=1", "Sort desc");
            repPing.DataBind();
        }
    }
}