using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class about_job_detail : PublicPage
{
    public Model.Job j = new Model.Job();
    protected void Page_Load(object sender, EventArgs e)
    {
        int ID = base.QueryInt("ID");
        j = new BLL.Job().GetModelBystrWhere("ID=" + ID + " and Lan=1");
        if (j == null)
        {
            Response.Redirect("job.aspx");
        }
        if (!this.IsPostBack)
        {

        }
    }
}