/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 11:59:14 */
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


public partial class eyoung_Schools_ListBanner_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.Banner bll = new BLL.Banner();
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1004, 1);
        info_add.Visible = base.CheckPopedomInfo(1004, 2);
        But_IsPass.Visible = base.CheckPopedomInfo(1004, 16);
        But_CancelIsPass.Visible = base.CheckPopedomInfo(1004, 16);
        But_Delete.Visible = base.CheckPopedomInfo(1004, 8);



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
        string strWhere = "Kind=5";

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
        Model.PageData<Model.Banner> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        base.AddLog(3, "广告位管理ID：" + ids);
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

        Model.Banner model = new Model.Banner();
        model.IsPass = true;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "显示通过广告位ID：" + ids);
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

        Model.Banner model = new Model.Banner();
        model.IsPass = false;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "取消显示广告位ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "Name", "Kind", "Info", "GetUrl", "Image", "Sort", "IsPass", "AddTime" };
        string[] title = { "编号", "标题", "类型", "类型", "连接地址", "图片", "排序", "显示", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_Banner", "广告位列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
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
                    sql += "UPDATE TB_Banner SET Sort =" + Comm.Help.GetInt(Request.Form[_id]) + " WHERE  ID=" + arr[1] + " ;";

                }
            }
            SqlHelper.ExecuteNonQuery(PubConstant.ConnectionString, CommandType.Text, sql.ToString(), null);
            base.AddLog(2, "广告位重新排序");
            Response.Redirect(Request.RawUrl, true);
        }
    }

}
