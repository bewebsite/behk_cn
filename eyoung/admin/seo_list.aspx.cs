using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class eyoung_admin_seo_list : AdminPageBase
{
    private BSEO bll = new BSEO();
    public int AllCount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1002, 1);
        info_add.Visible = base.CheckPopedomInfo(1002, 2);
        But_Delete.Visible = base.CheckPopedomInfo(1002, 8);
        if (!IsPostBack)
        {
            loadData();
        }
    }
    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        List<MSEO> list = bll.getList("");
        rpList.DataSource = list;
        rpList.DataBind();
        if (list != null)
        {
            AllCount = list.Count;
        }
    }

    /// <summary>
    /// 删除
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Delete_Click(object sender, EventArgs e)
    {
        string ids = Request.Form["ids"];
        if (ids == null || ids.Trim() == "")
        {
            return;
        }

        foreach (string id in ids.Split(','))
        {
            bll.Delete(id);
        }
        base.AddLog(3, "SEO管理ID：" + ids);
        loadData();
    }
}