/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-30 16:50:42 */
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


public partial class _eyoung_News_News_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.News bll = new BLL.News();
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
            drpCountry.DataSource = new BLL.Country().GetAllList();
            drpCountry.DataBind();
            drpCountry.Items.Insert(0, new ListItem("--相关国家--", ""));

            drpSchool.DataSource = new BLL.Schools().GetList(0, "ID,CNName", "", "CNName");
            drpSchool.DataBind();
            drpSchool.Items.Insert(0, new ListItem("--相关学校--", ""));

            drpKind.DataSource = new BLL.NewsType().GetAllList();
            drpKind.DataBind();
            drpKind.Items.Insert(0, new ListItem("--文章类别--", ""));
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
        string Kind = base.QueryString("drpKind");
        if (!string.IsNullOrWhiteSpace(Kind))
        {
            strWhere += " and Kind=" + Kind + "";
            drpKind.SelectedValue = Kind;
        }
        string value = base.QueryString("searchValue");
        if (!string.IsNullOrWhiteSpace(value))
        {
            strWhere += " and (Title like '%" + value + "%' or SourceName like '%" + value + "%')";
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
        string sort = "AddTime desc";
        string txtsort = base.QueryString("drpSort");
        if (!string.IsNullOrEmpty(txtsort))
        {
            if (txtsort == "1")
            {
                sort = "AddTime";
            }
            else if (txtsort == "2")
            {
                sort = "AddTime desc";
            }
            else if (txtsort == "3")
            {
                sort = "Sort,AddTime desc";
            }
            else if (txtsort == "4")
            {
                sort = "Sort desc,AddTime desc";
            }
            else if (txtsort == "5")
            {
                sort = "Click,AddTime desc";
            }
            else if (txtsort == "6")
            {
                sort = "Click desc,AddTime desc";
            }
            drpSort.SelectedValue = base.QueryString("drpSort");
        }

        return sort;
    }

    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        Model.PageData<Model.News> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        List<Model.News> list2 = new BLL.News().GetList(0, "ID in (" + ids + ")", "");

        for (int i = 0; i < list2.Count; i++)
        {
            string url = "/news/" + list2[i].HtmlName + ".html";
            new BLL.Urls().DeleteList("HtmlUrl='" + url + "'");
        }

        bll.DeleteList("ID in (" + ids + ")");
        new BLL.NewsIntor().DeleteList("NewsId in (" + ids + ")");
        base.AddLog(3, "新闻管理ID：" + ids);
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

        Model.News model = new Model.News();
        model.IsPass = true;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "显示通过新闻ID：" + ids);
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

        Model.News model = new Model.News();
        model.IsPass = false;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "取消显示新闻ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "HtmlName", "PageTitle", "PageKey", "PageDes", "Title", "Image", "Kind", "RelevantSchool", "Lead", "SourceName", "SourePosition", "SourePhone", "SoureIntor", "SoureLink", "IsPass", "Sort", "Click", "AddTime" };
        string[] title = { "编号", "伪静态名称", "页面标题", "页面关键词", "页面描述", "新闻标题", "新闻图片", "所属类型", "相关学校", "新闻导语", "来源名称", "来源职位", "来源照片", "来源简介", "来源连接", "显示", "排序", "预览数", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_News", "新闻列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
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
                    sql += "UPDATE TB_News SET Sort =" + Comm.Help.GetInt(Request.Form[_id]) + " WHERE  ID=" + arr[1] + " ;";

                }
            }
            SqlHelper.ExecuteNonQuery(PubConstant.ConnectionString, CommandType.Text, sql.ToString(), null);
            base.AddLog(2, "新闻重新排序");
            Response.Redirect(Request.RawUrl, true);
        }
    }
    public string GetName(object b)
    {
        Model.NewsType t = new BLL.NewsType().GetModelBystrWhere("ID=" + b + "");
        if (t != null)
        {
            return t.Name;
        }
        return "未知";
    }
}
