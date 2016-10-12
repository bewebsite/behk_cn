using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class aspx_loginout : Comm.PublicPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoginOut();
        }
    }

    /// <summary>
    /// 退出
    /// </summary>
    private void LoginOut()
    {
        Session.Clear();
        Response.Redirect("index.aspx");
    }
}