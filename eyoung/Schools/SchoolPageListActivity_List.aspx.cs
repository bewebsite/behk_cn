/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 10:17:15 */
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Collections;
using Maticsoft.DBUtility;
using System.Data;
using System.Text;


public partial class _eyoung_Schools_SchoolPageListActivity_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.SchoolPageListActivity bll = new BLL.SchoolPageListActivity();
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1009, 1);
        info_add.Visible = base.CheckPopedomInfo(1009, 2);
        But_IsPass.Visible = base.CheckPopedomInfo(1009, 16);
        But_CancelIsPass.Visible = base.CheckPopedomInfo(1009, 16);
        But_Delete.Visible = base.CheckPopedomInfo(1009, 8);



        PageSize = base.QueryInt("pagesize");
        if (PageSize <= 0)
        {
            PageSize = AppClass.PageSize;
        }
        else
        {
            drpPage.SelectedValue = PageSize.ToString();
        }

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
        string IsPass = base.QueryString("drpIsPass");
        if (!string.IsNullOrEmpty(IsPass))
        {
            strWhere += " and IsPass=" + IsPass + "";
            drpIsPass.SelectedValue = base.QueryString("drpIsPass");
        }
        string value = base.QueryString("searchValue");
        if (!string.IsNullOrWhiteSpace(value))
        {
            strWhere += " and Title like '%" + value + "%'";
            searchValue.Text = value;
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
        string sort = "Sort desc,AddTime desc";
        return sort;
    }

    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        Model.PageData<Model.SchoolPageListActivity> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        base.AddLog(3, "院校最新活动管理ID：" + ids);
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

        Model.SchoolPageListActivity model = new Model.SchoolPageListActivity();
        model.IsPass = true;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "审核通过院校最新活动ID：" + ids);
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

        Model.SchoolPageListActivity model = new Model.SchoolPageListActivity();
        model.IsPass = false;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "取消审核院校最新活动ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "Title", "StarDay", "EndDay", "StarTimer", "EndTimer", "Address", "GetUrl", "Sort", "IsPass", "AddTime" };
        string[] title = { "编号", "活动标题", "开始日期", "结束日期", "开始时间", "结束时间", "活动地点", "连接地址", "排序", "审核", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_SchoolPageListActivity", "院校最新活动列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (rpList.Items.Count > 0)
        {
            string[] arrids = Request.Form.AllKeys;
            if (arrids == null) return;
            string reg = @"txtsort";
            string sql = string.Empty;
            foreach (string _id in arrids)
            {
                string[] arr = _id.Split('_');
                if (arr.Length == 2 && arr[0] == reg)
                {
                    sql += "UPDATE TB_SchoolPageListActivity SET Sort =" + Comm.Help.GetInt(Request.Form[_id]) + " WHERE  ID=" + arr[1] + " ;";

                }
            }
            SqlHelper.ExecuteNonQuery(PubConstant.ConnectionString, CommandType.Text, sql.ToString(), null);
            base.AddLog(2, "院校最新活动重新排序");
            Response.Redirect(Request.RawUrl, true);
        }
    }
    public string GetInfo(object b)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        return "&nbsp;&nbsp;至&nbsp;&nbsp;" + b.ToString();
    }
}
