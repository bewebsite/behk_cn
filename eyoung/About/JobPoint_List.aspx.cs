﻿/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-06 15:57:39 */
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


public partial class _eyoung_About_JobPoint_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.JobPoint bll = new BLL.JobPoint();
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1013, 1);
        info_add.Visible = base.CheckPopedomInfo(1013, 2);
        But_Delete.Visible = base.CheckPopedomInfo(1013, 8);



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
        string lan = base.QueryString("repLan");
        if (!string.IsNullOrWhiteSpace(lan))
        {
            strWhere += " and Lan=" + lan + "";
            repLan.SelectedValue = lan;
        }
        string value = base.QueryString("searchValue");
        if (!string.IsNullOrWhiteSpace(value))
        {
            strWhere += " and (Name like '%" + value + "%' or Title like '%" + value + "%')";
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
        string sort = "Sort desc";

        return sort;
    }

    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        Model.PageData<Model.JobPoint> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        base.AddLog(3, "评价管理ID：" + ids);
        loadData();
    }


    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "Lan", "Title", "Name", "Intor", "Sort" };
        string[] title = { "编号", "版本", "标题", "评价人", "评价内容", "排序" };
        DataToExcel.Export(fileName, title, "TB_JobPoint", "评价列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
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
                    sql += "UPDATE TB_JobPoint SET Sort =" + Comm.Help.GetInt(Request.Form[_id]) + " WHERE  ID=" + arr[1] + " ;";

                }
            }
            SqlHelper.ExecuteNonQuery(PubConstant.ConnectionString, CommandType.Text, sql.ToString(), null);
            base.AddLog(2, "评价重新排序");
            Response.Redirect(Request.RawUrl, true);
        }
    }

}
