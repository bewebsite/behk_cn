/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-05 09:50:55 */
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


public partial class eyoung_admin_Levels_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.Country bll = new BLL.Country();
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1007, 1);
        info_add.Visible = base.CheckPopedomInfo(1007, 2);
        But_IsPass.Visible = base.CheckPopedomInfo(1007, 16);
        But_CancelIsPass.Visible = base.CheckPopedomInfo(1007, 16);
        But_Delete.Visible = base.CheckPopedomInfo(1007, 8);



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
        string strWhere = "Kind=4";
        string IsPass = base.QueryString("drpIsPass");
        if (!string.IsNullOrEmpty(IsPass))
        {
            strWhere += " and IsPass=" + IsPass + "";
            drpIsPass.SelectedValue = base.QueryString("drpIsPass");
        }
        string Name = base.QueryString("searchValue");
        if (!string.IsNullOrWhiteSpace(Name))
        {
            strWhere += " and Name like '%" + Name + "%'";
            searchValue.Text = Name;
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
        Model.PageData<Model.Country> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        base.AddLog(3, "相关城市管理ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 显示
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

        Model.Country model = new Model.Country();
        model.IsPass = true;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "显示通过相关城市ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 取消显示
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

        Model.Country model = new Model.Country();
        model.IsPass = false;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "取消显示相关城市ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "Name", "Sort", "IsPass", "AddTime" };
        string[] title = { "编号", "城市名称", "排序", "显示", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_Country", "相关城市列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
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
                    sql += "UPDATE TB_Country SET Sort =" + Comm.Help.GetInt(Request.Form[_id]) + " WHERE  ID=" + arr[1] + " ;";

                }
            }
            SqlHelper.ExecuteNonQuery(PubConstant.ConnectionString, CommandType.Text, sql.ToString(), null);
            base.AddLog(2, "相关城市重新排序");
            Response.Redirect(Request.RawUrl, true);
        }
    }

}
