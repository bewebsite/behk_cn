/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-09-01 11:28:51 */
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


public partial class _eyoung_Schools_SchoolPageListSchool_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.SchoolPageListSchool bll = new BLL.SchoolPageListSchool();
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
        string TypeId = base.QueryString("drpTypeId");
        if (!string.IsNullOrWhiteSpace(TypeId))
        {
            strWhere += " and TypeId=" + TypeId + "";
            drpTypeId.SelectedValue = TypeId;
        }
        string CountryId = base.QueryString("drpCountryId");
        if (!string.IsNullOrWhiteSpace(CountryId))
        {
            strWhere += " and CountryId=" + CountryId + "";
            drpCountryId.SelectedValue = TypeId;
        }
        string Name = base.QueryString("searchValue");
        if (!string.IsNullOrWhiteSpace(Name))
        {
            strWhere += " and (CNName like '%" + Name + "%' or ENName like '%" + Name + "%')";
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
        Model.PageData<Model.SchoolPageListSchool> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        //List<Model.SchoolPageListSchool> list2 = new BLL.SchoolPageListSchool ().GetList(0, "ID in (" + ids + ")", "");

        //for (int i = 0; i < list2.Count; i++)
        //{
        //    string url = "/products/"+list2[i].HtmlName+".shtml";
        //    new BLL.Urls().DeleteList("HtmlUrl='" + url + "'");
        //}

        bll.DeleteList("ID in (" + ids + ")");
        base.AddLog(3, "院校管理ID：" + ids);
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

        Model.SchoolPageListSchool model = new Model.SchoolPageListSchool();
        model.IsPass = true;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "显示通过院校ID：" + ids);
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

        Model.SchoolPageListSchool model = new Model.SchoolPageListSchool();
        model.IsPass = false;
        bll.Update(model, "ID in (" + ids + ")");
        base.AddLog(2, "取消显示院校ID：" + ids);
        loadData();
    }

    /// <summary>
    /// 导出
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Excel_Click(object sender, EventArgs e)
    {
        string[] fileName = { "ID", "CNName", "ENName", "CountryId", "TypeId", "Image", "GetUrl", "Sort", "IsPass", "AddTime" };
        string[] title = { "编号", "院校中文名", "院校英文名", "国家", "院校类型", "LOGO", "连接地址", "排序", "显示", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_SchoolPageListSchool", "院校列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
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
                    sql += "UPDATE TB_SchoolPageListSchool SET Sort =" + Comm.Help.GetInt(Request.Form[_id]) + " WHERE  ID=" + arr[1] + " ;";

                }
            }
            SqlHelper.ExecuteNonQuery(PubConstant.ConnectionString, CommandType.Text, sql.ToString(), null);
            base.AddLog(2, "院校重新排序");
            Response.Redirect(Request.RawUrl, true);
        }
    }
    public string GetName(object b)
    {
        string v = b.ToString();
        if (v == "1")
        {
            return "英国";
        }
        else if (v == "2")
        {
            return "美国";
        }
        return "瑞典";
    }
    public string GetName2(object b)
    {
        string v = b.ToString();
        if (v == "1")
        {
            return "男校";
        }
        else if (v == "2")
        {
            return "女校";
        }
        return "男女混校";
    }
}

