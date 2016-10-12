using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class eyoung_admin_adminlog : AdminPageBase
{
    private BLL.AdminLog bll = new BLL.AdminLog();
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
        if (!IsPostBack)
        {
            lit_day.Text = AppClass.AdminLogDay.ToString();
            loadData();
        }
    }

    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        bll.DeleteList("AddTime<'" + DateTime.Now.AddDays(-AppClass.AdminLogDay).ToString("yyyy-MM-dd") + "'");
        Model.PageData<Model.AdminLog> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
        rpList.DataSource = data.DataSoure;
        rpList.DataBind();
        pgServer.PageSize = PageSize;
        pgServer.RecordCount = data.Count;
        pgServer.DataBind();
        AllCount = data.Count;
    }

    /// <summary>
    /// 获取条件
    /// </summary>
    /// <returns></returns>
    private string getStrWhere()
    {
        string strWhere = "";
        string title = base.QueryString("searchValue");
        if (!string.IsNullOrEmpty(title))
        {
            strWhere += " UserName like '%" + title + "%'";
            searchValue.Text = base.PrototypeQuery("searchValue");
        }
        string type = base.QueryString("drpClass");
        if (!string.IsNullOrEmpty(type))
        {
            strWhere += " and OperationTypes=" + type;
            drpClass.SelectedValue = type;
        }

        strWhere = System.Text.RegularExpressions.Regex.Replace(strWhere, "^ and", "");
        return strWhere;
    }

    /// <summary>
    /// 获取排序
    /// </summary>
    /// <returns></returns>
    private string getSort()
    {
        string sort = "AddTime desc";
        string sortid = base.QueryString("drpSort");
        if (string.IsNullOrEmpty(sortid))
        {
            return sort;
        }

        switch (sortid)
        {
            case "1": sort = "AddTime asc"; break;
        }
        drpSort.SelectedValue = sortid;

        return sort;
    }

    /// <summary>
    /// 获取类型名称
    /// </summary>
    /// <param name="obj"></param>
    /// <returns></returns>
    protected string getTypeName(object obj)
    {
        if (obj == null)
        {
            return "";
        }

        switch (Convert.ToInt32(obj))
        {
            case 0: return "登录";
            case 1: return "添加";
            case 2: return "编辑";
            case 3: return "删除";
        }

        return "";
    }

    /// <summary>
    /// 导出Excel
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void but_excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "OperationTypesName", "ODescription", "UserName", "IP", "AddTime" };
        string[] title = { "ID", "类型", "操作描述", "用户名", "IP地址", "添加时间" };
        DataToExcel.Export(fileName, title, "V_AdminLog", "日志列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
    }
}