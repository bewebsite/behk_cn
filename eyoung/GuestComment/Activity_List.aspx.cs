/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-11 16:45:44 */
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


public partial class eyoung_GuestComment_Activity_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.GuestComment bll = new BLL.GuestComment();
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1008, 1);
        info_add.Visible = base.CheckPopedomInfo(1008, 2);
        But_Delete.Visible = base.CheckPopedomInfo(1008, 8);



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
        string strWhere = "Kind=2";
        string IsReached = base.QueryString("drpIsReached");
        if (!string.IsNullOrEmpty(IsReached))
        {
            strWhere += " and IsReached=" + IsReached + "";
            drpIsReached.SelectedValue = base.QueryString("drpIsReached");
        }
        string IsExistingCustomer = base.QueryString("drpIsExistingCustomer");
        if (!string.IsNullOrEmpty(IsExistingCustomer))
        {
            strWhere += " and IsExistingCustomer=" + IsExistingCustomer + "";
            drpIsExistingCustomer.SelectedValue = base.QueryString("drpIsExistingCustomer");
        }
        string value = base.QueryString("searchValue");
        if (!string.IsNullOrWhiteSpace(value))
        {
            strWhere += " and (Name like '%" + value + "%' or Title like '%" + value + "%' or Email like '%" + value + "%' or Mobile like '%" + value + "%' or City like '%" + value + "%')";
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

        return sort;
    }

    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        Model.PageData<Model.GuestComment> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        //List<Model.GuestComment> list2 = new BLL.GuestComment ().GetList(0, "ID in (" + ids + ")", "");

        //for (int i = 0; i < list2.Count; i++)
        //{
        //    string url = "/products/"+list2[i].HtmlName+".shtml";
        //    new BLL.Urls().DeleteList("HtmlUrl='" + url + "'");
        //}

        bll.DeleteList("ID in (" + ids + ")");
        base.AddLog(3, "在线留言管理ID：" + ids);
        loadData();
    }


    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "Name", "Mobile", "Email", "City", "Age", "Grade", "AbroadTime", "GuestNum", "Comment", "StudentName", "StudentSex", "StudentBirthday", "FollowUp", "IsReached", "IsExistingCustomer", "AddTime" };
        string[] title = { "姓名", "联络手机", "邮箱", "所在城市", "学生年龄", "所在年级", "意向出国时间", "当天来宾人数", "留言", "学生姓名", "学生性别", "出生日期", "业务跟进情况", "已回访", "现有客户", "提交时间" };
        DataToExcel.Export(fileName, title, "TB_GuestComment", "在线留言列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
    }

}
