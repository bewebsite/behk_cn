using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
public partial class aspx_school_detail : PublicPage
{
    int ID = 0;
    Model.Schools s = new Model.Schools();

    public Model.Schools S
    {
        get { return s; }
        set { s = value; }
    }
    public string HaveImage = "";
    public string HavePoint = "";
    public string HaveOtherPeople = "";
    public string HaveVoide = "";
    public string HaveNews = "";
    public string HaveOffice = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        S = new BLL.Schools().GetModelBystrWhere("ID=" + ID + " and IsPass=1");
        if (S == null)
        {
            Response.Redirect("/");
        }
        if (!this.IsPostBack)
        {
            Model.Schools model = new Model.Schools();
            model.Click = S.Click.Value + 1;
            new BLL.Schools().Update(model, "ID=" + ID + "");


            if (!string.IsNullOrWhiteSpace(S.PageTitle))
            {
                this.Title = S.PageTitle;
            }
            if (!string.IsNullOrWhiteSpace(S.PageKey))
            {
                this.Title = S.PageTitle;
            }
            if (!string.IsNullOrWhiteSpace(S.PageDes))
            {
                this.Title = S.PageTitle;
            }

            List<Model.SchoolsImage> imageList = new BLL.SchoolsImage().GetList(0, "Image", "SchoolId=" + ID + "", "Sort desc");
            repImage.DataSource = repImage2.DataSource = imageList;
            repImage.DataBind();
            repImage2.DataBind();
            if (imageList.Count == 0)
            {
                HaveImage = "style=\"display:none\"";
            }

            repPoint.DataSource = new BLL.SchoolsConsultant().GetList(0, "", "SchoolId=" + ID + "", "Sort desc");
            repPoint.DataBind();
            if (repPoint.Items.Count == 0)
            {
                HavePoint = "style=\"display:none\"";
            }

            repOtherPeople.DataSource = new BLL.SchoolsOtherAlumnus().GetList(0, "", "SchoolsId=" + ID + "", "");
            repOtherPeople.DataBind();
            if (repOtherPeople.Items.Count == 0)
            {
                HaveOtherPeople = "style=\"display:none\"";
            }

            repVoide.DataSource = new BLL.SchoolsVoide().GetList(0, "", "SchoolId=" + ID + "", "");
            repVoide.DataBind();
            if (repVoide.Items.Count == 0)
            {
                HaveVoide = "style=\"display:none\"";
            }

            if (string.IsNullOrWhiteSpace(S.OfficerCNName))
            {
                HaveOffice = "style=\"display:none\"";
            }

            BindIsNull();
            BinNews();
        }
    }

    public void BinNews()
    {
        List<Model.News> list = new BLL.News().GetList(1, "ID,HtmlName,Title,Lead,Image", "RelevantSchool like '%," + ID + ",%'", "AddTime desc");
        if (list.Count == 1)
        {
            Model.News n = list[0];
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("<a href=\"/news/{0}.html\" title=\"{1}\" target=\"_blank\">", n.HtmlName, n.Title);
            sb.AppendFormat("<img src=\"{0}\" width=\"260\" height=\"140\" alt=\"{1}\" /></a> ", n.Image, n.Title);
            sb.AppendFormat("<a href=\"/news/{0}.html\" title=\"{2}\" target=\"_blank\" class=\"tit\">{1}</a>", n.HtmlName, Help.Substring(n.Title, 30, ".."), n.Title);
            sb.AppendFormat("<p class=\"text\">{2}<a href=\"/news/{0}.html\" title=\"{1}\" target=\"_blank\">[ 详细 ]</a></p>", n.HtmlName, n.Lead, Help.Substring(n.Lead, 64, ".."));
            Lit_TopNews.Text = sb.ToString();

            repNews.DataSource = new BLL.News().GetList(5, "HtmlName,Title", "RelevantSchool like '%," + ID + ",%' and ID<>" + n.ID + "", "AddTime desc");
            repNews.DataBind();
        }
        else
        {
            HaveNews = "style=\"display:none\"";
        }
    }

    public int GetNum()
    {
        Random r = new Random();
        return r.Next(1111, 9999);
    }
    public void BindIsNull()
    {
        if (!string.IsNullOrWhiteSpace(S.LOGO))
        {
            S.LOGO = "<img src=" + S.LOGO + " style=\"width:100px;height:100px\" />";
        }
        if (!string.IsNullOrWhiteSpace(S.Website))
        {
            S.Website = S.Website.Replace("http://", "");
        }
        if (!string.IsNullOrWhiteSpace(S.SchoolIntroduction))
        {
            S.SchoolIntroduction = S.SchoolIntroduction.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.RecommendedReason))
        {
            S.RecommendedReason = S.RecommendedReason.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.ApplicationAdvice))
        {
            S.ApplicationAdvice = S.ApplicationAdvice.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.OfficerProfile))
        {
            S.OfficerProfile = S.OfficerProfile.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.SchoolSettings))
        {
            S.SchoolSettings = S.SchoolSettings.Replace("\r\n", "<br/>");
        }
        if (string.IsNullOrWhiteSpace(S.MeanScore))
        {
            S.MeanScore = "该校未公开";
        }
        if (!string.IsNullOrWhiteSpace(S.SchoolTravel))
        {
            S.SchoolTravel = S.SchoolTravel.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.SchoolEnvironment))
        {
            S.SchoolEnvironment = S.SchoolEnvironment.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.ClassSize))
        {
            S.ClassSize = S.ClassSize.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.Highlights))
        {
            S.Highlights = S.Highlights.Replace("\r\n", "<br/>");
        }

        if (!string.IsNullOrWhiteSpace(S.SchoolMotto))
        {
            S.SchoolMotto = S.SchoolMotto.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.EntranceRequirements))
        {
            S.EntranceRequirements = S.EntranceRequirements.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.TeacherStrength))
        {
            S.TeacherStrength = S.TeacherStrength.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.StudentCaring))
        {
            S.StudentCaring = S.StudentCaring.Replace("\r\n", "<br/>");
        }

        if (!string.IsNullOrWhiteSpace(S.AcademicUnits))
        {
            S.AcademicUnits = S.AcademicUnits.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.AcademicCourses))
        {
            S.AcademicCourses = S.AcademicCourses.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.SpecialCourses))
        {
            S.SpecialCourses = S.SpecialCourses.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.SchoolSports))
        {
            S.SchoolSports = S.SchoolSports.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.SchoolIT))
        {
            S.SchoolIT = S.SchoolIT.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.SchoolArts))
        {
            S.SchoolArts = S.SchoolArts.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.Extracurriculum))
        {
            S.Extracurriculum = S.Extracurriculum.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.LanguageCourses))
        {
            S.LanguageCourses = S.LanguageCourses.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.GraduateAchievement))
        {
            S.GraduateAchievement = S.GraduateAchievement.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.GraduateDestination))
        {
            S.GraduateDestination = S.GraduateDestination.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.Library))
        {
            S.Library = S.Library.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.Catering))
        {
            S.Catering = S.Catering.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.Accommodation))
        {
            S.Accommodation = S.Accommodation.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.ArtFacility))
        {
            S.ArtFacility = S.ArtFacility.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.ITFacility))
        {
            S.ITFacility = S.ITFacility.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.SportsFacility))
        {
            S.SportsFacility = S.SportsFacility.Replace("\r\n", "<br/>");
        }
        if (!string.IsNullOrWhiteSpace(S.AcademicFacility))
        {
            S.AcademicFacility = S.AcademicFacility.Replace("\r\n", "<br/>");
        }
    }

    public string GetEvent()
    {
        return "";
        List<Model.Events> list = new BLL.Events().GetList(1, "", "IsPass=1 and RelevantSchool like '%," + ID + ",%'", "Sort desc,AddTime desc");
        if (list.Count == 0)
        {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        Model.Events l = list[0];
        sb.AppendFormat("<div class=\"block block9\"><div class=\"top\">");
        sb.AppendFormat("<i><img src=\"images/hd1.png\" /></i>正在进行的活动</div>");
        sb.AppendFormat("<div class=\"bom clearfix\"><div class=\"img\"><a href=\"/events/{0}.html\"  target=\"_blank\"><img src=\"{1}\" width=\"219\" height=\"236\" /></a></div>", l.HtmlName, l.Image);
        sb.AppendFormat("<div class=\"right\"><h3><a href=\"/events/{0}.html\"  target=\"_blank\" title=\"{1}\">{1}</a></h3>", l.HtmlName, l.CNTitle);
        sb.AppendFormat("<p class=\"en\">{0}</p>", l.ENTitle);
        sb.AppendFormat("<div class=\"list1\"><span class=\"l\"><i>");
        string time = DateTime.Parse(l.StarDay).ToString("M月d日");
        if (!string.IsNullOrWhiteSpace(l.EndDay))
        {
            time += "-" + DateTime.Parse(l.EndDay).ToString("M月d日");
        }
        sb.AppendFormat("<img src=\"images/hd2.png\" /></i>日期：{0}</span><span class=\"r\" style=\"margin-right:30px;\"><i>", time);
        string time2 = l.StarTimer;
        if (!string.IsNullOrWhiteSpace(l.EndTimer))
        {
            time2 += "-" + l.EndTimer;
        }
        sb.AppendFormat("<img src=\"images/hd3.png\" /></i>时间：{0}</span></div>", time2);
        sb.AppendFormat("<div class=\"list1\"><i><img src=\"images/hd4.png\" /></i>地点：{0}</div>", l.Address);
        sb.AppendFormat("<div class=\"list2\"></div><div class=\"list3\"><span class=\"l-width\"><i>");
        sb.AppendFormat("<img src=\"images/hd5.png\" /></i>简介</span><div class=\"txt\">");
        sb.AppendFormat("{0}</div>", Comm.Help.Substring(l.Intor, 150, ".."));
        sb.AppendFormat("</div><div class=\"list4\">");
        sb.AppendFormat("<a href=\"javascript:void(0);\" onclick=\"openYue(this)\" v=\"" + l.CNTitle + "\">预约活动</a></div></div></div></div>");

        return sb.ToString();
    }
}