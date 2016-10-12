/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 15:15:05 */
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


public partial class _eyoung_Events_Events_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.Events bll = new BLL.Events();
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1010, 1);
        info_add.Visible = base.CheckPopedomInfo(1010, 2);
        But_IsPass.Visible = base.CheckPopedomInfo(1010, 16);
        But_CancelIsPass.Visible = base.CheckPopedomInfo(1010, 16);
        But_Delete.Visible = base.CheckPopedomInfo(1010, 8);



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
        string IsHot = base.QueryString("drpIsHot");
        if (!string.IsNullOrEmpty(IsHot))
        {
            strWhere += " and IsHot=" + IsHot + "";
            drpIsHot.SelectedValue = base.QueryString("drpIsHot");
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
                sort = "Sort";
            }
            else if (txtsort == "4")
            {
                sort = "Sort desc";
            }
            else if (txtsort == "5")
            {
                sort = "Sort2";
            }
            else if (txtsort == "6")
            {
                sort = "Sort2 desc";
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
        Model.PageData<Model.Events> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
        rpList.DataSource = data.DataSoure;
        rpList.DataBind();
        pgServer.RecordCount = data.Count;
        pgServer.PageSize = PageSize;
        pgServer.DataBind();
        AllCount = data.Count;
    }
    /// <summary>
    /// 推荐
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_IsHot_Click(object sender, EventArgs e)
    {
        string ids = Request.Form["ids"];
        if (string.IsNullOrEmpty(ids))
        {
            return;
        }

        Model.Events model = new Model.Events();
        model.IsHot = true;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "推荐通过精彩活动ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 取消推荐
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_CancelIsHot_Click(object sender, EventArgs e)
    {
        string ids = Request.Form["ids"];
        if (string.IsNullOrEmpty(ids))
        {
            return;
        }

        Model.Events model = new Model.Events();
        model.IsHot = false;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "取消推荐精彩活动ID：" + ids);
        loadData();
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
        List<Model.Events> list2 = new BLL.Events().GetList(0, "ID in (" + ids + ")", "");

        for (int i = 0; i < list2.Count; i++)
        {
            string url = "/evetnts/" + list2[i].HtmlName + ".html";
            new BLL.Urls().DeleteList("HtmlUrl='" + url + "'");
        }
        new BLL.EventImage().DeleteList("EventId in (" + ids + ")");
        new BLL.EventVoide().DeleteList("EventId in (" + ids + ")");

        bll.DeleteList("ID in (" + ids + ")");
        base.AddLog(3, "精彩活动管理ID：" + ids);
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

        Model.Events model = new Model.Events();
        model.IsPass = true;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "显示通过精彩活动ID：" + ids);
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

        Model.Events model = new Model.Events();
        model.IsPass = false;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "取消显示精彩活动ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "HtmlName", "PageTitle", "PaegKey", "PageDes", "CNTitle", "ENTitle", "TypeId", "TypeName", "StarAge", "EndAge", "StarDay", "EndDay", "StarTimer", "EndTimer", "AllNum", "RegistrationNumber", "EnrollStar", "EnrollEnd", "EnrollInfo", "Address", "Location_X", "Location_Y", "Latitude", "ContactName", "ContactEmail", "ContactMobile", "Highlights", "RelevantCountry", "RelevantCity", "RelevantSchool", "RelevantBusiness", "RelevantLevels", "RelevantCategories", "CrowdCategory", "CategoriesIntroduction", "Intor", "VIPCNName", "VIPENName", "VIPPhone", "VIPTitle", "VIPIntor", "VIPCNTopic", "VIPENTopic", "Content", "IsPass", "Sort", "AddTime", "Image", "IsHot" };
        string[] title = { "编号", "伪静态名", "页面标题", "页面关键词", "页面描述", "中文标题", "英文标题", "活动类型", "活动类型", "适用人群起始年龄", "适用人群截至年龄", "活动开始日期", "活动结束日期", "活动开始时间", "活动结束时间", "活动最多报名人数", "活动当前报名人数", "报名开始日期", "报名结束日期", "活动报名说明", "活动地址", "X坐标", "Y坐标", "地址坐标", "活动联络人", "活动联络方电邮", "活动联络方电话", "特别亮点", "活动相关留学国家", "适用城市", "活动相关学校", "必益相关业务", "适用学习阶段", "适用人群类型", "适用人群类别", "适用人群描述", "活动简介", "嘉宾中文姓名", "嘉宾英文姓名", "嘉宾照片", "嘉宾中文职衔", "嘉宾简介", "嘉宾演讲题目中文", "嘉宾演讲题目英文", "活动详情", "显示", "排序", "添加时间", "", "推荐" };
        DataToExcel.Export(fileName, title, "TB_Events", "精彩活动列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
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
                    sql += "UPDATE TB_Events SET Sort =" + Comm.Help.GetInt(Request.Form[_id]) + " WHERE  ID=" + arr[1] + " ;";

                }
            }
            SqlHelper.ExecuteNonQuery(PubConstant.ConnectionString, CommandType.Text, sql.ToString(), null);
            base.AddLog(2, "精彩活动重新排序");
            Response.Redirect(Request.RawUrl, true);
        }
    }
    public string GetInfo2(object b)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        return "-" + DateTime.Parse(b.ToString()).ToString("M月d日");
    }
    public string GetInfo(object b)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        return "-" + b.ToString();
    }
}
