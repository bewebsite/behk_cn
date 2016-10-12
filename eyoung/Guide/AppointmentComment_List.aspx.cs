/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-28 10:03:16 */
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


public partial class _eyoung_Guide_AppointmentComment_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.AppointmentComment bll = new BLL.AppointmentComment();
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1003, 1);
        But_Delete.Visible = base.CheckPopedomInfo(1003, 8);



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
        string strWhere = "Channels <> 'survey'";
        string IsReached = base.QueryString("drpIsReached");
        if (!string.IsNullOrEmpty(IsReached))
        {
            strWhere += " and IsReached=" + IsReached + "";
            drpIsReached.SelectedValue = base.QueryString("drpIsReached");
        }
        string value = base.QueryString("searchValue");
        if (!string.IsNullOrWhiteSpace(value))
        {
            strWhere += " and (Name like '%" + value + "%' or Mobile like '%" + value + "%' or City like '%" + value + "%')";
            searchValue.Text = value;
        }

        string IsExistingCustomer = base.QueryString("drpIsExistingCustomer");
        if (!string.IsNullOrWhiteSpace(IsExistingCustomer))
        {
            strWhere += " and IsExistingCustomer=" + IsExistingCustomer + "";
            drpIsExistingCustomer.SelectedValue = IsExistingCustomer;
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
        Model.PageData<Model.AppointmentComment> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        base.AddLog(3, "招生会报名管理ID：" + ids);
        loadData();
    }


    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "Name", "Mobile", "City", "Age", "Grade", "AbroadTime", "DesireSchool1", "DesireSchool2", "InterviewPlace", "GuestNum", "Comment", "StudentName", "StudentSex", "StudentBirthday", "FollowUp", "AddTime", "IsReached", "IsExistingCustomer" };
        string[] title = { "编号", "姓名", "手机号", "所在城市", "学生年龄", "所在年级", "意向出国时间", "面试志愿学校一", "面试志愿学校二", "面试地点", "来宾人数", "留言", "学生姓名", "学生性别", "出生日期", "业务跟进情况", "提交时间", "已回访", "现有客户" };
        DataToExcel.Export(fileName, title, "TB_AppointmentComment", "招生会报名列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
    }
}
