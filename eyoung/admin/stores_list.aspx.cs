using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class eyoung_admin_stores_list : AdminPageBase
{
    private BLL.Stores bll = new BLL.Stores();
    public int AllCount = 0;
    public int PageSize = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        PageSize = base.QueryInt("pagesize");
        if (PageSize <= 0)
        {
            PageSize = AppClass.PageSize;
        }
        else
        {
            drpPage.SelectedValue = PageSize.ToString();
        }

        base.CheckPopedomInfoRedirect(1001, 1);
        info_add.Visible = base.CheckPopedomInfo(1001, 2);
        But_Delete.Visible = base.CheckPopedomInfo(1001, 8);
        if (!IsPostBack)
        {
            loadData();
        }
    }
    /// <summary>
    /// 获取条件
    /// </summary>
    /// <returns></returns>
    private string getStrWhere()
    {
        string strWhere = "";
        strWhere = System.Text.RegularExpressions.Regex.Replace(strWhere, "^ and", "");

        return strWhere;
    }

    /// <summary>
    /// 获取排序
    /// </summary>
    /// <returns></returns>
    private string getSort()
    {
        string sort = "";

        return sort;
    }

    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        Model.PageData<Model.Stores> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
        rpList.DataSource = data.DataSoure;
        rpList.DataBind();
        pgServer.RecordCount = data.Count;
        pgServer.PageSize = PageSize;
        pgServer.DataBind();
        AllCount = data.Count;
    }
    /// <summary>
    /// 删除
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Delete_Click(object sender, EventArgs e)
    {
        string ids = Request.Form["ids"];
        if (string.IsNullOrEmpty(ids))
        {
            return;
        }

        bll.DeleteList("ID in (" + ids + ")");
        base.AddLog(3, "职位管理ID：" + ids);
        loadData();
    }


    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "Name", "AddTime" };
        string[] title = { "序列号", "门店名称", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_Stores", "职位列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
    }
    public string GetDis(object b)
    {
        int s = int.Parse(b.ToString());
        if (s < 2)
        {
            return "disabled=\"disabled\"";
        }
        return "";
    }
}