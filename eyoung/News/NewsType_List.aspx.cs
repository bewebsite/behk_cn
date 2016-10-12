/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-28 12:54:58 */
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


public partial class _eyoung_News_NewsType_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.NewsType bll = new BLL.NewsType();
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
        string sort = "Sort desc,AddTime desc";
        return sort;
    }

    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        Model.PageData<Model.NewsType> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        List<Model.NewsType> list2 = new BLL.NewsType().GetList(0, "ID in (" + ids + ")", "");

        for (int i = 0; i < list2.Count; i++)
        {
            string url = "/news/" + list2[i].HtmlName + ".html";
            new BLL.Urls().DeleteList("HtmlUrl='" + url + "'");
        }

        bll.DeleteList("ID in (" + ids + ")");
        base.AddLog(3, "新闻分类管理ID：" + ids);
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

        Model.NewsType model = new Model.NewsType();
        model.IsPass = true;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "审核通过新闻分类ID：" + ids);
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

        Model.NewsType model = new Model.NewsType();
        model.IsPass = false;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "取消审核新闻分类ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "PageTitle", "PageKey", "PageDes", "Name", "Sort", "IsPass", "AddTime" };
        string[] title = { "编号", "页面标题", "页面关键词", "页面描述", "分类名称", "排序", "审核", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_NewsType", "新闻分类列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
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
                    sql += "UPDATE TB_NewsType SET Sort =" + Comm.Help.GetInt(Request.Form[_id]) + " WHERE  ID=" + arr[1] + " ;";

                }
            }
            SqlHelper.ExecuteNonQuery(PubConstant.ConnectionString, CommandType.Text, sql.ToString(), null);
            base.AddLog(2, "新闻分类重新排序");
            Response.Redirect(Request.RawUrl, true);
        }
    }

}
