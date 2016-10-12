/* 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-31 16:42:46 */
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


public partial class _eyoung_Schools_Schools_List : AdminPageBase
{
    public int AllCount = 0;
    public int PageSize = 0;
    private BLL.Schools bll = new BLL.Schools();
    protected void Page_Load(object sender, EventArgs e)
    {
        base.CheckPopedomInfoRedirect(1006, 1);
        info_add.Visible = base.CheckPopedomInfo(1006, 2);
        But_IsPass.Visible = base.CheckPopedomInfo(1006, 16);
        But_CancelIsPass.Visible = base.CheckPopedomInfo(1006, 16);
        But_Delete.Visible = base.CheckPopedomInfo(1006, 8);



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
        string IsGuide = base.QueryString("drpIsGuide");
        if (!string.IsNullOrEmpty(IsGuide))
        {
            strWhere += " and IsGuide=" + IsGuide + "";
            this.drpIsGuide.SelectedValue = IsGuide;
        }
        string Types = base.QueryString("drpType");
        if (!string.IsNullOrWhiteSpace(Types))
        {
            strWhere += " and SchoolType='" + Types + "'";
            drpType.SelectedValue = Types;
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
        Model.PageData<Model.Schools> data = bll.GetList(PageSize, base.PageIndex, getStrWhere(), getSort());
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
        List<Model.Schools> list2 = new BLL.Schools().GetList(0, "ID in (" + ids + ")", "");

        for (int i = 0; i < list2.Count; i++)
        {
            string url = "/schools/" + list2[i].HtmlName + ".html";
            new BLL.Urls().DeleteList("HtmlUrl='" + url + "'");
        }

        bll.DeleteList("ID in (" + ids + ")");
        new BLL.SchoolsConsultant().DeleteList("SchoolId in (" + ids + ")");
        new BLL.SchoolsImage().DeleteList("SchoolId in (" + ids + ")");
        new BLL.SchoolsOtherAlumnus().DeleteList("SchoolsId in (" + ids + ")");
        new BLL.SchoolsVoide().DeleteList("SchoolId in (" + ids + ")");
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

        Model.Schools model = new Model.Schools();
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

        Model.Schools model = new Model.Schools();
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
        string[] fileName = { "ID", "HtmlName", "PageTitle", "PageKey", "PageDes", "CNName", "ENName", "LOGO", "Image", "FoundingTime", "CountryName", "SchoolType", "AreaSize", "AgeStart", "AgeEnd", "Website", "Followers", "OfficerCNName", "OfficerENName", "OfficerTitle", "OfficerPhone", "OfficerProfile", "RecommendedReason", "ApplicationAdvice", "SchoolIntroduction", "SchoolTravel", "SchoolEnvironment", "SouthLatitude", "NorthLatitude", "Location_X", "Location_Y", "ZipCode", "StudentNumber", "PeopleRatio", "BoardingStudent", "BoardingProportion", "InternationalStudent", "InternationalProportion", "ChineseStudent", "SchoolSettings", "ClassSize", "MeanScore", "AdmissionRate", "AnnualCost", "Highlights", "SchoolMotto", "EntranceRequirements", "TeacherStrength", "StudentCaring", "AcademicUnits", "AcademicCourses", "SpecialCourses", "SchoolSports", "SchoolIT", "SchoolArts", "Extracurriculum", "LanguageCourses", "GraduateAchievement", "GraduateDestination", "AcademicFacility", "SportsFacility", "ITFacility", "ArtFacility", "Accommodation", "Catering", "Library", "RepresentativeCNName", "RepresentativeENName", "RepresentativePhone", "RepresentativeAchievement", "RepresentativeOther", "Sort", "IsPass", "Click", "AddTime" };
        string[] title = { "编号", "伪静态名称", "页面标题", "页面关键词", "页面描述", "院校中文名", "院校英文名", "院校LOGO", "院校默认图", "成立年份", "所在国家", "学校类型", "学校规模(英亩）", "入学起始年龄", "入学截至年龄", "学校网址", "关注人数", "学校官员中文译名", "学校官员英文名称", "学校官员职衔", "学校官员照片", "学校官员简介", "推荐理由", "申请准备及建议", "学校简介", "交通距离", "地理环境", "南坐标", "北坐标", "横坐标", "纵坐标", "邮政编码", "学生人数", "师生配比", "寄宿学生人数", "寄宿生比例", "国际学生人数", "国际学生比例", "中国学生人数", "学院设置", "课堂规模", "入学平均成绩", "录取率", "每年学费及寄宿费", "学校特色", "教学理念", "入学标准", "师资力量", "学生关怀", "学院设置", "专业课程", "特色课程", "体育课程", "科技课程", "艺术课程", "课外活动", "外语辅导课程", "毕业生学术成就", "升学院校", "教学设施", "运动设施", "科技设施", "艺术设施", "宿舍", "餐厅", "图书馆", "代表校友中文姓名", "代表校友英文姓名", "代表校友照片", "代表校友成就", "其他知名校友", "排序", "显示", "预览数", "添加时间" };
        DataToExcel.Export(fileName, title, "TB_Schools", "院校列表_" + DateTime.Now.ToString("yyy-MM-dd"), getStrWhere(), getSort());
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
                    sql += "UPDATE TB_Schools SET Sort =" + Comm.Help.GetInt(Request.Form[_id]) + " WHERE  ID=" + arr[1] + " ;";

                }
            }
            SqlHelper.ExecuteNonQuery(PubConstant.ConnectionString, CommandType.Text, sql.ToString(), null);
            base.AddLog(2, "院校重新排序");
            Response.Redirect(Request.RawUrl, true);
        }
    }

}
