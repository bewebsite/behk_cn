using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class team_t_creater : PublicPage
{
    public Model.Single s = new Model.Single();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            s = new BLL.Single().GetModelBystrWhere("Kind=7");
        }
    }
}