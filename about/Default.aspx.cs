using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
public partial class about_Default : PublicPage
{
    public Model.Single s = new Model.Single();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            s = new BLL.Single().GetModelBystrWhere("Kind=1");
        }
    }
    public string GetBanner()
    {
        Model.Banner b = new BLL.Banner().GetModelBystrWhere("Kind=11");
        if (!string.IsNullOrWhiteSpace(b.GetUrl))
        {
            return "<a href=" + b.GetUrl + " target=\"_blank\"><img src=" + b.Image + " width=\"1180\" /></a>";
        }
        return "<img src=" + b.Image + " width=\"1180\" />";
    }
}