using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class eyoung_admin_admin_list : AdminPageBase
{
    private BLL.Admin bll = new BLL.Admin();
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
            drpKind.DataSource = new BLL.Stores().GetAllList();
            drpKind.DataBind();
            drpKind.Items.Insert(0, new ListItem("--职位--", ""));
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
        string kind = base.QueryString("drpKind");
        if (!string.IsNullOrEmpty(kind))
        {
            strWhere += " and RoleID=" + kind + "";
            drpKind.SelectedValue = kind;
        }
        string Value = base.QueryString("searchValue");
        if (!string.IsNullOrEmpty(Value))
        {
            strWhere += " and (Username like '%" + Value + "%' or Email like '%" + Value + "%' or Realname like '%" + Value + "%')";
            searchValue.Text = Value;
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
        string sort = "";
        return sort;
    }
    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        Model.PageData<Model.Admin> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        base.AddLog(3, "管理员管理ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 审核
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_IsPass_Click(object sender, EventArgs e)
    {
        string ids = Request.Form["ids"];
        if (string.IsNullOrEmpty(ids))
        {
            return;
        }

        Model.Admin model = new Model.Admin();
        model.IsPass = true;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "审核通过管理员ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 取消审核
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_CancelIsPass_Click(object sender, EventArgs e)
    {
        string ids = Request.Form["ids"];
        if (string.IsNullOrEmpty(ids))
        {
            return;
        }

        Model.Admin model = new Model.Admin();
        model.IsPass = false;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "取消审核管理员ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "RoleID", "Username", "Password", "Lastloginip", "Lastlogintime", "Logincount", "Realname", "Email", "IsPass", "AddTime" };
        string[] title = { "编号", "职位", "用户名", "密码", "最后一次登录IP", "最后一次登录时间", "登录次数", "管理员姓名", "邮箱", "审核", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_Admin", "管理员列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
    }
    public string GetName(object b)
    {
        Model.Stores m = new BLL.Stores().GetModelBystrWhere("ID=" + b);
        if (m != null)
        {
            return m.Name;
        }
        return "";
    }
}