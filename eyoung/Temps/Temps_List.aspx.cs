/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-10-19 09:52:45 */
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


public partial class _eyoung_Temp_Temps_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.Temps bll = new BLL.Temps();
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1011, 1);
        info_add.Visible = base.CheckPopedomInfo(1011, 2);
        But_Delete.Visible = base.CheckPopedomInfo(1011, 8);



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
        string sort = "AddTime desc";
        return sort;
    }

    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        Model.PageData<Model.Temps> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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

        List<Model.Temps> list2 = new BLL.Temps().GetList(0, "ID in (" + ids + ")", "");
        bll.DeleteList("ID in (" + ids + ")");
        for (int i = 0; i < list2.Count; i++)
        {
            string url = "/temp/" + list2[i].HtmlName + ".html";
            new BLL.Urls().DeleteList("HtmlUrl='" + url + "'");
        }
        new BLL.TempsBanner().DeleteList("TempId in (" + ids + ")");
        new BLL.TempsCase().DeleteList("TempId in (" + ids + ")");
        new BLL.TempsImages().DeleteList("TempId in (" + ids + ")");
        new BLL.TempsOthers().DeleteList("TempId in (" + ids + ")");
        new BLL.TempsProduct().DeleteList("TempId in (" + ids + ")");
        new BLL.TempsSchool().DeleteList("TempId in (" + ids + ")");
        new BLL.TempsVoide().DeleteList("TempId in (" + ids + ")");
        new BLL.TempsProductInfo().DeleteList("TempId in (" + ids + ")");

        base.AddLog(3, "产品模版管理ID：" + ids);
        loadData();
    }


    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "HtmlName", "PageTitle", "PageKey", "PageDes", "CNName", "ENName", "CountryId", "BusinessId", "CityId", "LevelsId", "StarYear", "EndYear", "CategoriesId", "CategoriesInfo", "Intor", "RegistrationInfo", "AddTime" };
        string[] title = { "编号", "伪静态名称", "页面标题", "页面关键词", "页面描述", "产品中文名", "产品英文名", "相关留学国家", "必益相关业务", "适用城市", "适用学习阶段", "适用人群年龄", "适用人群年龄", "适用人群", "适用人群介绍", "产品介绍", "预约方式介绍", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_Temps", "产品模版列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
    }

    public string GetName(object b, object kind)
    {
        if (b == null || b.ToString() == "")
        {
            return "";
        }
        string s = b.ToString().Remove(0, 1);
        s = s.Substring(0, s.Length - 1);
        List<Model.Country> list = new BLL.Country().GetList(0, "", "ID in (" + s + ") and Kind=" + kind + "", "");
        string value = "";
        foreach (Model.Country l in list)
        {
            value += l.Name + ",";
        }
        if (!string.IsNullOrWhiteSpace(value))
        {
            value = value.Substring(0, value.Length - 1);
        }
        return value;
    }
}
