//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-31 16:42:27

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
using System.IO;

public partial class _eyoung_Schools_Schools_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.Schools bll = new BLL.Schools();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        chk_IsPass.Visible = base.CheckPopedomInfo(1006, 16);//审核
        if (!IsPostBack)
        {
            drpCountry.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=1", "Name");
            drpCountry.DataBind();
            drpCountry.Items.Insert(0, new ListItem("--相关国家--", ""));
            loadData();
        }
    }

    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        if (ID > 0)
        {
            Model.Schools model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1006, 4);
            this.Title = Lit_Title.Text = "院校修改";
            txt_HtmlName.Text = model.HtmlName;
            txt_PageTitle.Text = model.PageTitle;
            txt_PageKey.Text = model.PageKey;
            txt_PageDes.Text = model.PageDes;
            txt_CNName.Text = model.CNName;
            txt_ENName.Text = model.ENName;
            if (!string.IsNullOrWhiteSpace(model.LOGO))
            {
                Lit_LOGO.Text = "<img src=" + model.LOGO + " style=\"width:200px; height:200px\" />";
            }
            if (!string.IsNullOrWhiteSpace(model.GuideImage))
            {
                Lit_LOGO22.Text = "<img src=" + model.GuideImage + " style=\"width:185px; height:373px\" />";
                Hid_LOGO22.Value = model.GuideImage;
            }
            txt_FoundingTime.Text = model.FoundingTime;
            drpCountry.SelectedValue = model.CountryId.Value.ToString();
            RadioButtonList1.SelectedValue = model.SchoolType;
            txt_AreaSize.Text = model.AreaSize.ToString();
            txt_AgeStart.Text = model.AgeStart.ToString();
            txt_AgeEnd.Text = model.AgeEnd.ToString();
            txt_Website.Text = model.Website;
            txt_Followers.Text = model.Followers.ToString();
            txt_OfficerCNName.Text = model.OfficerCNName;
            txt_OfficerENName.Text = model.OfficerENName;
            txt_OfficerTitle.Text = model.OfficerTitle;
            if (!string.IsNullOrWhiteSpace(model.OfficerPhone))
            {
                Lit_OfficerPhone.Text = "<img src=" + model.OfficerPhone + "  style=\"width:122px; height:129px\" />";
            }
            txt_OfficerProfile.Text = model.OfficerProfile;
            txt_RecommendedReason.Text = model.RecommendedReason;
            txt_ApplicationAdvice.Text = model.ApplicationAdvice;
            txt_SchoolIntroduction.Text = model.SchoolIntroduction;
            txt_SchoolTravel.Text = model.SchoolTravel;
            txt_SchoolEnvironment.Text = model.SchoolEnvironment;
            txt_SouthLatitude.Text = model.SouthLatitude;
            txt_NorthLatitude.Text = model.NorthLatitude;
            txt_Location_X.Text = model.Location_X;
            txt_Location_Y.Text = model.Location_Y;
            txt_ZipCode.Text = model.ZipCode;
            txt_StudentNumber.Text = model.StudentNumber.ToString();
            txt_PeopleRatio.Text = model.PeopleRatio;
            txt_BoardingStudent.Text = model.BoardingStudent;
            txt_BoardingProportion.Text = model.BoardingProportion.ToString();
            txt_InternationalStudent.Text = model.InternationalStudent.ToString();
            txt_InternationalProportion.Text = model.InternationalProportion.ToString();
            txt_ChineseStudent.Text = model.ChineseStudent.ToString();
            txt_SchoolSettings.Text = model.SchoolSettings;
            txt_ClassSize.Text = model.ClassSize;
            txt_MeanScore.Text = model.MeanScore;
            txt_AdmissionRate.Text = model.AdmissionRate.ToString();
            txt_AnnualCost.Text = model.AnnualCost.ToString();
            txt_Highlights.Text = model.Highlights;
            txt_SchoolMotto.Text = model.SchoolMotto;
            txt_EntranceRequirements.Text = model.EntranceRequirements;
            txt_TeacherStrength.Text = model.TeacherStrength;
            txt_StudentCaring.Text = model.StudentCaring;
            txt_AcademicUnits.Text = model.AcademicUnits;
            txt_AcademicCourses.Text = model.AcademicCourses;
            txt_SpecialCourses.Text = model.SpecialCourses;
            txt_SchoolSports.Text = model.SchoolSports;
            txt_SchoolIT.Text = model.SchoolIT;
            txt_SchoolArts.Text = model.SchoolArts;
            txt_Extracurriculum.Text = model.Extracurriculum;
            txt_LanguageCourses.Text = model.LanguageCourses;
            txt_GraduateAchievement.Text = model.GraduateAchievement;
            txt_GraduateDestination.Text = model.GraduateDestination;
            txt_AcademicFacility.Text = model.AcademicFacility;
            txt_SportsFacility.Text = model.SportsFacility;
            txt_ITFacility.Text = model.ITFacility;
            txt_ArtFacility.Text = model.ArtFacility;
            txt_Accommodation.Text = model.Accommodation;
            txt_Catering.Text = model.Catering;
            txt_Library.Text = model.Library;
            txt_RepresentativeCNName.Text = model.RepresentativeCNName;
            txt_RepresentativeENName.Text = model.RepresentativeENName;
            if (!string.IsNullOrWhiteSpace(model.RepresentativePhone))
            {
                Lit_RepresentativePhone.Text = "<img src=" + model.RepresentativePhone + " style=\"width:98px; height:110px\" />";
            }
            txt_RepresentativeAchievement.Text = model.RepresentativeAchievement;
            txt_RepresentativeOther.Text = model.RepresentativeOther;
            txt_Sort.Text = model.Sort.ToString();
            chk_IsPass.Checked = model.IsPass.Value;
            txt_Click.Text = model.Click.ToString();
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
            t_HtmlName.Value = model.HtmlName;
            Hid_LOGO.Value = model.LOGO;
            hid_OfficerPhone.Value = model.OfficerPhone;
            hid_RepresentativePhone.Value = model.RepresentativePhone;
            txt_GuideSort.Text = model.GuideSort.Value.ToString();
            chk_IsGuide.Checked = model.IsGuide.Value;

            BindImage();
            ConsultantInfo();
            VoideInfo();
            VoidOtherPeople();


            /*相关城市*/
            if (!string.IsNullOrWhiteSpace(model.RelevantCity))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=2", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.RelevantCity.IndexOf("," + l.ID + ",") >= 0)
                    {
                        this.Lit_CityList.Text += "<a href='javascript:void(0)' v=" + l.ID + " t=" + l.Name + " onclick='removeCityId(this)' title='点击可移除'>" + l.Name + " X</a>";
                    }
                    else
                    {
                        alist.Add(l);
                    }
                }
                drpCity.DataSource = alist;
                drpCity.DataBind();
                drpCity.Items.Insert(0, new ListItem("--相关国家--", ""));
            }
            else
            {
                drpCity.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=2", "");
                drpCity.DataBind();
                drpCity.Items.Insert(0, new ListItem("--相关城市--", ""));
            }
            Hid_City.Value = model.RelevantCity;

            /*必益相关业务*/
            if (!string.IsNullOrWhiteSpace(model.RelevantBusiness))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=3", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.RelevantBusiness.IndexOf("," + l.ID + ",") >= 0)
                    {
                        this.Lit_BusinessList.Text += "<a href='javascript:void(0)' v=" + l.ID + " t=" + l.Name + " onclick='removeBusiness(this)' title='点击可移除'>" + l.Name + " X</a>";
                    }
                    else
                    {
                        alist.Add(l);
                    }
                }
                this.drpBusiness.DataSource = alist;
                drpBusiness.DataBind();
                drpBusiness.Items.Insert(0, new ListItem("--必益相关业务--", ""));
            }
            else
            {
                drpBusiness.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=3", "");
                drpBusiness.DataBind();
                drpBusiness.Items.Insert(0, new ListItem("--必益相关业务--", ""));
            }
            this.Hid_Business.Value = model.RelevantBusiness;

            /*适用学习阶段*/
            if (!string.IsNullOrWhiteSpace(model.RelevantLevels))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=4", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.RelevantLevels.IndexOf("," + l.ID + ",") >= 0)
                    {
                        this.Lit_LevelsList.Text += "<a href='javascript:void(0)' v=" + l.ID + " t=" + l.Name + " onclick='removeLevels(this)' title='点击可移除'>" + l.Name + " X</a>";
                    }
                    else
                    {
                        alist.Add(l);
                    }
                }
                this.drpLevels.DataSource = alist;
                drpLevels.DataBind();
                drpLevels.Items.Insert(0, new ListItem("--适用学习阶段--", ""));
            }
            else
            {
                drpLevels.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=4", "");
                drpLevels.DataBind();
                drpLevels.Items.Insert(0, new ListItem("--适用学习阶段--", ""));
            }
            this.Hid_Levels.Value = model.RelevantLevels;

            /*适用人群类别*/
            if (!string.IsNullOrWhiteSpace(model.RelevantCategories))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=5", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.RelevantCategories.IndexOf("," + l.ID + ",") >= 0)
                    {
                        this.Lit_CategoriesList.Text += "<a href='javascript:void(0)' v=" + l.ID + " t=" + l.Name + " onclick='removeCategories(this)' title='点击可移除'>" + l.Name + " X</a>";
                    }
                    else
                    {
                        alist.Add(l);
                    }
                }
                this.drpCategories.DataSource = alist;
                drpCategories.DataBind();
                drpCategories.Items.Insert(0, new ListItem("--适用人群类别--", ""));
            }
            else
            {
                drpCategories.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=5", "");
                drpCategories.DataBind();
                drpCategories.Items.Insert(0, new ListItem("--适用人群类别--", ""));
            }
            this.Hid_Categories.Value = model.RelevantCategories;

        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1006, 2);
            txt_AddTime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            drpCity.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=2", "");
            drpCity.DataBind();
            drpCity.Items.Insert(0, new ListItem("--相关城市--", ""));

            drpBusiness.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=3", "");
            drpBusiness.DataBind();
            drpBusiness.Items.Insert(0, new ListItem("--必益相关业务--", ""));

            drpLevels.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=4", "");
            drpLevels.DataBind();
            drpLevels.Items.Insert(0, new ListItem("--适用学习阶段--", ""));

            drpCategories.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=5", "");
            drpCategories.DataBind();
            drpCategories.Items.Insert(0, new ListItem("--适用人群类别--", ""));

        }
    }

    /// <summary>
    /// 顾问列表
    /// </summary>
    private void ConsultantInfo()
    {
        List<Model.SchoolsConsultant> list = new BLL.SchoolsConsultant().GetList(0, "", "SchoolId=" + ID + "", "Sort desc");
        StringBuilder sb = new StringBuilder();
        foreach (Model.SchoolsConsultant l in list)
        {
            sb.AppendFormat("<dl class=\"addDl4 clearfix\"><dt><input name=\"Consultant_HidId\" value=" + l.ID.Value + " type=\"hidden\" />");
            sb.AppendFormat("<a href=\"{0}\" title=\"点击查看大图\" id=\"example\"><img src=\"{0}\" width=\"80\" ></a></dt>", l.Phone);
            sb.AppendFormat("<dd>");
            sb.AppendFormat("<p>中文姓名：<input name=\"txt_ConsultantCNName{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.CNName);
            sb.AppendFormat("<p>英文姓名：<input name=\"txt_ConsultantENName{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.ENName);
            sb.AppendFormat("<p>顾问职衔：<input name=\"txt_Position{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.Title);
            sb.AppendFormat("<p>顾问排序：<input name=\"txt_ConsultantSort{0}\" style=\"width: 50px;\" class=\"text\" type=\"text\" value=\"{1}\" onblur=\"checkproductnum(this);\" /></p>", l.ID, l.Sort);
            sb.AppendFormat("<p>点评内容：<textarea name=\"txt_Info{0}\" cols=\"20\" rows=\"2\" class=\"text\" style=\"width: 300px;height: 80px\">{1}</textarea></p>", l.ID, l.Comment);
            sb.Append("<p><a href=\"javascript:void();\" onclick=\"deleteUpload(this);\">[删除]</a></p>");
            sb.Append("</dd></dl>");
        }
        Lit_ConsultantInfo.Text = sb.ToString();
    }

    /// <summary>
    /// 照片
    /// </summary>
    public void BindImage()
    {
        BLL.SchoolsImage productimg_bll = new BLL.SchoolsImage();
        List<Model.SchoolsImage> list = productimg_bll.GetList(0, "SchoolId=" + ID + "", "Sort desc");

        StringBuilder sb = new StringBuilder();
        foreach (Model.SchoolsImage item in list)
        {
            sb.AppendFormat("<dl class=\"addDl2 clearfix\"><dt><input name=\"hid_image_id\" value=" + item.ID.Value + " type=\"hidden\" />");
            sb.AppendFormat("<a href=\"{0}\" title=\"点击查看大图\" id=\"example\"><img src=\"{0}\" width=\"80\" ></a></dt>", item.Image);
            sb.AppendFormat("<dd>");
            sb.AppendFormat("<p>图片排序：<input name=\"txtImgOrdinal_{0}\" style=\"width: 50px;\" class=\"text\" type=\"text\" value=\"{1}\" onblur=\"checkproductnum(this);\" /></p>", item.ID.Value, item.Sort.Value.ToString());
            sb.Append("<p><a href=\"javascript:void();\" onclick=\"deleteUpload(this);\">[删除]</a></p>");
            sb.Append("</dd></dl>");
        }

        lit_Image_List.Text = sb.ToString();
    }

    /// <summary>
    /// 视频
    /// </summary>
    private void VoideInfo()
    {
        List<Model.SchoolsVoide> list = new BLL.SchoolsVoide().GetList(0, "", "SchoolId=" + ID + "", "Sort desc");
        StringBuilder sb = new StringBuilder();
        foreach (Model.SchoolsVoide l in list)
        {
            sb.AppendFormat("<dl class=\"addDl3 clearfix\"><dt><input name=\"Voide_HidId\" value=" + l.ID.Value + " type=\"hidden\" />");
            sb.AppendFormat("<a href=\"{0}\" title=\"点击查看大图\" id=\"example\"><img src=\"{0}\" width=\"80\" ></a></dt>", l.Image);
            sb.AppendFormat("<dd>");
            sb.AppendFormat("<p>视频名称：<input name=\"txt_voide{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.Title);
            sb.AppendFormat("<p>连接地址：<input name=\"txt_link{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.VoideUrl);
            sb.AppendFormat("<p>视频排序：<input name=\"txt_voidesort{0}\" class=\"text\" style=\"width: 50px\" value=\"{1}\" /></p>", l.ID, l.Sort);
            sb.Append("<p><a href=\"javascript:void();\" onclick=\"deleteUpload(this);\">[删除]</a></p>");
            sb.Append("</dd></dl>");
        }
        Lit_VoideList.Text = sb.ToString();
    }


    /// <summary>
    /// 其他校友
    /// </summary>
    private void VoidOtherPeople()
    {
        List<Model.SchoolsOtherAlumnus> list = new BLL.SchoolsOtherAlumnus().GetList(0, "", "SchoolsId=" + ID + "", "");
        StringBuilder sb = new StringBuilder();
        foreach (Model.SchoolsOtherAlumnus l in list)
        {
            sb.AppendFormat("<div>校友类型：<input type=\"text\" name=\"Others_Title{0}\" class=\"text\" value=\"{1}\" style=\"width: 150px\" /><input name=\"other_id\" value=\"{0}\" type=\"hidden\" />", l.ID, l.Title);
            sb.AppendFormat("&nbsp;&nbsp;&nbsp;&nbsp;相关人员：<input type=\"text\" name=\"Others_Info{0}\" class=\"text\" style=\"width: 450px\" value=\"{1}\" />&nbsp;", l.ID, l.Info);
            sb.AppendFormat("<a href=\"javascript:void(0)\" onclick=\"deleteAlumnus(this)\">[删除这个]</a></div>");
        }
        Lit_OtherPer.Text = sb.ToString();
    }

    /// <summary>
    /// 保存
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Save_Click(object sender, EventArgs e)
    {
        save();
    }

    /// <summary>
    /// 另存为
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_AsSave_Click(object sender, EventArgs e)
    {
        ID = 0;
        save();
    }

    /// <summary>
    /// 保存
    /// </summary>
    private void save()
    {
        Model.Schools model = myValidate();
        if (model == null)
        {
            return;
        }

        if (ID > 0)
        {
            string oldHtmlUrl = "/schools/" + t_HtmlName.Value + ".html";
            string newHtmlUrl = "/schools/" + model.HtmlName + ".html";
            string url = "/schools/detail.aspx?ID=" + ID;
            string back = Help.UpdateUrl(oldHtmlUrl, newHtmlUrl, url, "/schools/");
            if (back == oldHtmlUrl)
            {
                txt_HtmlName.Text = t_HtmlName.Value;
            }
            else
            {
                txt_HtmlName.Text = back;
            }

            if (bll.Update(model, "ID=" + ID) < 1)
            {
                MessageBox.Show("修改失败");
            }
            base.AddLog(2, "院校修改，ID为：" + ID);


            /*****************************产品图片***********************************/

            List<Model.SchoolsImage> product_img_list = myPicValidate(ID);
            List<Model.SchoolsImage> oproductimg_list = new BLL.SchoolsImage().GetList(0, "SchoolId=" + ID + "", "Sort desc");


            //添加、修改图片
            foreach (Model.SchoolsImage item in product_img_list)
            {
                if (item.ID.HasValue && item.ID > 0)
                {
                    int productimg_id = item.ID.Value;
                    item.ID = null;
                    new BLL.SchoolsImage().Update(item, "ID=" + productimg_id);
                    Model.SchoolsImage removemodel = oproductimg_list.Find(delegate(Model.SchoolsImage m) { return m.ID.Value == productimg_id; });
                    if (removemodel != null)
                    {
                        oproductimg_list.Remove(removemodel);
                    }
                }
                else
                {
                    new BLL.SchoolsImage().Add(item);
                }
            }

            //删除商品图片
            string img_deleteid = "";
            if (oproductimg_list.Count > 0)
            {
                foreach (Model.SchoolsImage item in oproductimg_list)
                {
                    img_deleteid += item.ID + ",";
                }
            }
            img_deleteid = System.Text.RegularExpressions.Regex.Replace(img_deleteid, ",$", "");
            if (!string.IsNullOrEmpty(img_deleteid))
            {
                new BLL.SchoolsImage().DeleteList("ID in (" + img_deleteid + ")");
            }


            List<Model.SchoolsImage> imagelist = new BLL.SchoolsImage().GetList(0, "", "SchoolId=" + ID + "", "Sort desc");
            if (imagelist.Count > 0)
            {
                Model.Schools pp = new Model.Schools();
                pp.Image = imagelist[0].Image;
                new BLL.Schools().Update(pp, "ID=" + ID + "");
            }
            else
            {
                Model.Schools pp = new Model.Schools();
                pp.Image = "";
                new BLL.Schools().Update(pp, "ID=" + ID + "");
            }


            /*******************顾问点评*****************************/
            ChangeConsultant();

            /*********************视频*******************************/
            ChangeVoide();

            /*********************其他校友*******************************/
            ChangeOtherPeople();
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "院校添加，ID为：" + i);

            string htmlurl = "/schools/" + model.HtmlName + ".html";
            string url = "/schools/detail.aspx?ID=" + i;
            string back = Help.AddUrl(htmlurl, url, "/schools/");
            if (back != "")
            {
                Model.Schools mm = new Model.Schools();
                mm.HtmlName = back;
                int y = bll.Update(mm, "ID=" + i);
            }


            List<Model.SchoolsImage> product_img_list = myPicValidate(i);
            int xxx = 0;
            foreach (Model.SchoolsImage item in product_img_list)
            {
                if (xxx == 0)
                {
                    Model.Schools pp = new Model.Schools();
                    pp.Image = item.Image;
                    new BLL.Schools().Update(pp, "ID=" + i + "");
                }
                new BLL.SchoolsImage().Add(item);
            }

            List<Model.SchoolsConsultant> ConsultantList = myConsultant(i);
            foreach (Model.SchoolsConsultant l in ConsultantList)
            {
                new BLL.SchoolsConsultant().Add(l);
            }

            List<Model.SchoolsVoide> VoideList = myVoide(i);
            foreach (Model.SchoolsVoide l in VoideList)
            {
                new BLL.SchoolsVoide().Add(l);
            }


            List<Model.SchoolsOtherAlumnus> otherlist = OtherPeople(i);
            foreach (Model.SchoolsOtherAlumnus l in otherlist)
            {
                new BLL.SchoolsOtherAlumnus().Add(l);
            }
        }

        Response.Redirect("Schools_List.aspx");
    }

    public void ChangeConsultant()
    {
        List<Model.SchoolsConsultant> product_img_list = myConsultant(ID);
        List<Model.SchoolsConsultant> oproductimg_list = new BLL.SchoolsConsultant().GetList(0, "SchoolId=" + ID + "", "Sort desc");


        //添加、修改图片
        foreach (Model.SchoolsConsultant item in product_img_list)
        {
            if (item.ID.HasValue && item.ID > 0)
            {
                int productimg_id = item.ID.Value;
                item.ID = null;
                new BLL.SchoolsConsultant().Update(item, "ID=" + productimg_id);
                Model.SchoolsConsultant removemodel = oproductimg_list.Find(delegate(Model.SchoolsConsultant m) { return m.ID.Value == productimg_id; });
                if (removemodel != null)
                {
                    oproductimg_list.Remove(removemodel);
                }
            }
            else
            {
                new BLL.SchoolsConsultant().Add(item);
            }
        }

        //删除商品图片
        string img_deleteid = "";
        if (oproductimg_list.Count > 0)
        {
            foreach (Model.SchoolsConsultant item in oproductimg_list)
            {
                img_deleteid += item.ID + ",";
            }
        }
        img_deleteid = System.Text.RegularExpressions.Regex.Replace(img_deleteid, ",$", "");
        if (!string.IsNullOrEmpty(img_deleteid))
        {
            new BLL.SchoolsConsultant().DeleteList("ID in (" + img_deleteid + ")");
        }

    }

    public void ChangeVoide()
    {
        List<Model.SchoolsVoide> product_img_list = myVoide(ID);
        List<Model.SchoolsVoide> oproductimg_list = new BLL.SchoolsVoide().GetList(0, "SchoolId=" + ID + "", "Sort desc");


        //添加、修改图片
        foreach (Model.SchoolsVoide item in product_img_list)
        {
            if (item.ID.HasValue && item.ID > 0)
            {
                int productimg_id = item.ID.Value;
                item.ID = null;
                new BLL.SchoolsVoide().Update(item, "ID=" + productimg_id);
                Model.SchoolsVoide removemodel = oproductimg_list.Find(delegate(Model.SchoolsVoide m) { return m.ID.Value == productimg_id; });
                if (removemodel != null)
                {
                    oproductimg_list.Remove(removemodel);
                }
            }
            else
            {
                new BLL.SchoolsVoide().Add(item);
            }
        }

        //删除商品图片
        string img_deleteid = "";
        if (oproductimg_list.Count > 0)
        {
            foreach (Model.SchoolsVoide item in oproductimg_list)
            {
                img_deleteid += item.ID + ",";
            }
        }
        img_deleteid = System.Text.RegularExpressions.Regex.Replace(img_deleteid, ",$", "");
        if (!string.IsNullOrEmpty(img_deleteid))
        {
            new BLL.SchoolsVoide().DeleteList("ID in (" + img_deleteid + ")");
        }

    }


    public void ChangeOtherPeople()
    {
        List<Model.SchoolsOtherAlumnus> product_img_list = OtherPeople(ID);
        List<Model.SchoolsOtherAlumnus> oproductimg_list = new BLL.SchoolsOtherAlumnus().GetList(0, "SchoolsId=" + ID + "", "");


        //添加、修改图片
        foreach (Model.SchoolsOtherAlumnus item in product_img_list)
        {
            if (item.ID.HasValue && item.ID > 0)
            {
                int productimg_id = item.ID.Value;
                item.ID = null;
                new BLL.SchoolsOtherAlumnus().Update(item, "ID=" + productimg_id);
                Model.SchoolsOtherAlumnus removemodel = oproductimg_list.Find(delegate(Model.SchoolsOtherAlumnus m) { return m.ID.Value == productimg_id; });
                if (removemodel != null)
                {
                    oproductimg_list.Remove(removemodel);
                }
            }
            else
            {
                new BLL.SchoolsOtherAlumnus().Add(item);
            }
        }

        //删除商品图片
        string img_deleteid = "";
        if (oproductimg_list.Count > 0)
        {
            foreach (Model.SchoolsOtherAlumnus item in oproductimg_list)
            {
                img_deleteid += item.ID + ",";
            }
        }
        img_deleteid = System.Text.RegularExpressions.Regex.Replace(img_deleteid, ",$", "");
        if (!string.IsNullOrEmpty(img_deleteid))
        {
            new BLL.SchoolsOtherAlumnus().DeleteList("ID in (" + img_deleteid + ")");
        }

    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Schools myValidate()
    {
        string HtmlName = txt_HtmlName.Text.Trim();
        string PageTitle = txt_PageTitle.Text.Trim();
        string PageKey = txt_PageKey.Text.Trim();
        string PageDes = txt_PageDes.Text.Trim();
        string CNName = txt_CNName.Text.Trim();
        string ENName = txt_ENName.Text.Trim();
        string LOGO = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/School/");
        if (string.IsNullOrWhiteSpace(LOGO))
        {
            LOGO = Hid_LOGO.Value;
        }
        string LOGO2 = (new Dispose_Image()).upLoadImage(FileUpload22, "/UploadImage/School/");
        if (string.IsNullOrWhiteSpace(LOGO2))
        {
            LOGO2 = Hid_LOGO22.Value;
        }
        string FoundingTime = txt_FoundingTime.Text.Trim();
        string CountryId = drpCountry.SelectedValue;
        string CountryName = drpCountry.SelectedItem.Text;
        string SchoolType = RadioButtonList1.SelectedValue;
        string AreaSize = txt_AreaSize.Text.Trim();
        string AgeStart = txt_AgeStart.Text.Trim();
        string AgeEnd = txt_AgeEnd.Text.Trim();
        string Website = txt_Website.Text.Trim();
        string Followers = txt_Followers.Text.Trim();
        string OfficerCNName = txt_OfficerCNName.Text.Trim();
        string OfficerENName = txt_OfficerENName.Text.Trim();
        string OfficerTitle = txt_OfficerTitle.Text.Trim();
        string OfficerPhone = (new Dispose_Image()).upLoadImage(FileUpload2, "/UploadImage/OfficerPhone/");
        if (string.IsNullOrWhiteSpace(OfficerPhone))
        {
            OfficerPhone = this.hid_OfficerPhone.Value;
        }
        string OfficerProfile = txt_OfficerProfile.Text.Trim();
        string RecommendedReason = txt_RecommendedReason.Text.Trim();
        string ApplicationAdvice = txt_ApplicationAdvice.Text.Trim();
        string SchoolIntroduction = txt_SchoolIntroduction.Text.Trim();
        string SchoolTravel = txt_SchoolTravel.Text.Trim();
        string SchoolEnvironment = txt_SchoolEnvironment.Text.Trim();
        string SouthLatitude = txt_SouthLatitude.Text.Trim();
        string NorthLatitude = txt_NorthLatitude.Text.Trim();
        string Location_X = txt_Location_X.Text.Trim();
        string Location_Y = txt_Location_Y.Text.Trim();
        string ZipCode = txt_ZipCode.Text.Trim();
        string StudentNumber = txt_StudentNumber.Text.Trim();
        string PeopleRatio = txt_PeopleRatio.Text.Trim();
        string BoardingStudent = txt_BoardingStudent.Text.Trim();
        string BoardingProportion = txt_BoardingProportion.Text.Trim();
        string InternationalStudent = txt_InternationalStudent.Text.Trim();
        string InternationalProportion = txt_InternationalProportion.Text.Trim();
        string ChineseStudent = txt_ChineseStudent.Text.Trim();
        string SchoolSettings = txt_SchoolSettings.Text.Trim();
        string ClassSize = txt_ClassSize.Text.Trim();
        string MeanScore = txt_MeanScore.Text.Trim();
        string AdmissionRate = txt_AdmissionRate.Text.Trim();
        string AnnualCost = txt_AnnualCost.Text.Trim();
        string Highlights = txt_Highlights.Text.Trim();
        string SchoolMotto = txt_SchoolMotto.Text.Trim();
        string EntranceRequirements = txt_EntranceRequirements.Text.Trim();
        string TeacherStrength = txt_TeacherStrength.Text.Trim();
        string StudentCaring = txt_StudentCaring.Text.Trim();
        string AcademicUnits = txt_AcademicUnits.Text.Trim();
        string AcademicCourses = txt_AcademicCourses.Text.Trim();
        string SpecialCourses = txt_SpecialCourses.Text.Trim();
        string SchoolSports = txt_SchoolSports.Text.Trim();
        string SchoolIT = txt_SchoolIT.Text.Trim();
        string SchoolArts = txt_SchoolArts.Text.Trim();
        string Extracurriculum = txt_Extracurriculum.Text.Trim();
        string LanguageCourses = txt_LanguageCourses.Text.Trim();
        string GraduateAchievement = txt_GraduateAchievement.Text.Trim();
        string GraduateDestination = txt_GraduateDestination.Text.Trim();
        string AcademicFacility = txt_AcademicFacility.Text.Trim();
        string SportsFacility = txt_SportsFacility.Text.Trim();
        string ITFacility = txt_ITFacility.Text.Trim();
        string ArtFacility = txt_ArtFacility.Text.Trim();
        string Accommodation = txt_Accommodation.Text.Trim();
        string Catering = txt_Catering.Text.Trim();
        string Library = txt_Library.Text.Trim();
        string RepresentativeCNName = txt_RepresentativeCNName.Text.Trim();
        string RepresentativeENName = txt_RepresentativeENName.Text.Trim();
        string RepresentativePhone = (new Dispose_Image()).upLoadImage(FileUpload3, "/UploadImage/RepresentativePhone/");
        if (string.IsNullOrWhiteSpace(RepresentativePhone))
        {
            RepresentativePhone = this.hid_RepresentativePhone.Value;
        }
        string RepresentativeAchievement = txt_RepresentativeAchievement.Text.Trim();
        string RepresentativeOther = txt_RepresentativeOther.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        bool IsPass = chk_IsPass.Checked;

        Model.Schools model = new Model.Schools();
        model.HtmlName = HtmlName;
        model.PageTitle = PageTitle;
        model.PageKey = PageKey;
        model.PageDes = PageDes;
        model.CNName = CNName;
        model.ENName = ENName;
        model.LOGO = LOGO;
        model.FoundingTime = FoundingTime;
        model.CountryId = int.Parse(CountryId);
        model.CountryName = CountryName;
        model.SchoolType = SchoolType;
        model.AreaSize = int.Parse(AreaSize);
        model.AgeStart = int.Parse(AgeStart);
        model.AgeEnd = int.Parse(AgeEnd);
        model.Website = Website;
        model.Followers = int.Parse(Followers);
        model.OfficerCNName = OfficerCNName;
        model.OfficerENName = OfficerENName;
        model.OfficerTitle = OfficerTitle;
        model.OfficerPhone = OfficerPhone;
        model.OfficerProfile = OfficerProfile;
        model.RecommendedReason = RecommendedReason;
        model.ApplicationAdvice = ApplicationAdvice;
        model.SchoolIntroduction = SchoolIntroduction;
        model.SchoolTravel = SchoolTravel;
        model.SchoolEnvironment = SchoolEnvironment;
        model.SouthLatitude = SouthLatitude;
        model.NorthLatitude = NorthLatitude;
        model.Location_X = Location_X;
        model.Location_Y = Location_Y;
        model.ZipCode = ZipCode;
        model.StudentNumber = int.Parse(StudentNumber);
        model.PeopleRatio = PeopleRatio;
        model.BoardingStudent = BoardingStudent;
        model.BoardingProportion = int.Parse(BoardingProportion);
        model.InternationalStudent = int.Parse(InternationalStudent);
        model.InternationalProportion = int.Parse(InternationalProportion);
        model.ChineseStudent = int.Parse(ChineseStudent);
        model.SchoolSettings = SchoolSettings;
        model.ClassSize = ClassSize;
        model.MeanScore = MeanScore;
        model.AdmissionRate = int.Parse(AdmissionRate);
        model.AnnualCost = decimal.Parse(AnnualCost);
        model.Highlights = Highlights;
        model.SchoolMotto = SchoolMotto;
        model.EntranceRequirements = EntranceRequirements;
        model.TeacherStrength = TeacherStrength;
        model.StudentCaring = StudentCaring;
        model.AcademicUnits = AcademicUnits;
        model.AcademicCourses = AcademicCourses;
        model.SpecialCourses = SpecialCourses;
        model.SchoolSports = SchoolSports;
        model.SchoolIT = SchoolIT;
        model.SchoolArts = SchoolArts;
        model.Extracurriculum = Extracurriculum;
        model.LanguageCourses = LanguageCourses;
        model.GraduateAchievement = GraduateAchievement;
        model.GraduateDestination = GraduateDestination;
        model.AcademicFacility = AcademicFacility;
        model.SportsFacility = SportsFacility;
        model.ITFacility = ITFacility;
        model.ArtFacility = ArtFacility;
        model.Accommodation = Accommodation;
        model.Catering = Catering;
        model.Library = Library;
        model.RepresentativeCNName = RepresentativeCNName;
        model.RepresentativeENName = RepresentativeENName;
        model.RepresentativePhone = RepresentativePhone;
        model.RepresentativeAchievement = RepresentativeAchievement;
        model.RepresentativeOther = RepresentativeOther;
        model.Sort = int.Parse(Sort);
        model.IsPass = IsPass;
        model.GuideSort = int.Parse(txt_GuideSort.Text);
        model.IsGuide = chk_IsGuide.Checked;
        model.GuideImage = LOGO2;
        model.RelevantBusiness = Hid_Business.Value;
        model.RelevantCategories = Hid_Categories.Value;
        model.RelevantCity = Hid_City.Value;
        model.RelevantLevels = Hid_Levels.Value;

        return model;
    }

    /// <summary>
    /// 验证上传图片
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.SchoolsImage> myPicValidate(int Pid)
    {
        List<Model.SchoolsImage> nlist = new List<Model.SchoolsImage>();

        string image_id = Request.Form["hid_image_id"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    Model.SchoolsImage model = new Model.SchoolsImage();
                    if (ID > 0)
                    {
                        model.ID = int.Parse(ids);
                    }
                    model.Sort = string.IsNullOrEmpty(Request.Form["txtImgOrdinal_" + ids]) ? 0 : int.Parse(Request.Form["txtImgOrdinal_" + ids].ToString());
                    nlist.Add(model);
                }
            }
        }

        int uploadfile_count = int.Parse(hid_uploadfile_count.Value);
        string filename = DateTime.Now.ToString("yyyyMMddHHmmss");
        for (int i = 1; i <= uploadfile_count; i++)
        {
            string imageurl = upLoadImage("file_uploadimage_" + i, filename + "_" + i);
            if (!string.IsNullOrEmpty(imageurl))
            {
                Model.SchoolsImage model = new Model.SchoolsImage();
                model.SchoolId = Pid;
                model.Image = imageurl;
                model.Sort = string.IsNullOrEmpty(Request.Form["txt_ImgOrdinal_" + i]) ? 0 : int.Parse(Request.Form["txt_ImgOrdinal_" + i].ToString());
                nlist.Add(model);
            }
        }

        return nlist;
    }

    /// <summary>
    /// 上传图片
    /// </summary>
    /// <param name="name"></param>
    /// <returns></returns>
    private string upLoadImage(string name, string filename)
    {
        if (Request.Files[name] == null || string.IsNullOrEmpty(Request.Files[name].FileName))
        {
            return "";
        }

        string imageurl = "/UploadImage/SchoolImage/" + filename + Path.GetExtension(Request.Files[name].FileName).ToLower();
        try
        {
            Request.Files[name].SaveAs(Server.MapPath(imageurl));
        }
        catch
        {
            return "";
        }

        return imageurl;
    }


    /// <summary>
    /// 顾问点评
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.SchoolsConsultant> myConsultant(int Pid)
    {
        List<Model.SchoolsConsultant> nlist = new List<Model.SchoolsConsultant>();

        string image_id = Request.Form["Consultant_HidId"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    Model.SchoolsConsultant model = new Model.SchoolsConsultant();
                    if (ID > 0)
                    {
                        model.ID = int.Parse(ids);
                    }
                    model.CNName = string.IsNullOrEmpty(Request.Form["txt_ConsultantCNName" + ids]) ? "" : Request.Form["txt_ConsultantCNName" + ids].ToString();
                    model.Comment = string.IsNullOrEmpty(Request.Form["txt_Info" + ids]) ? "" : Request.Form["txt_Info" + ids].ToString();
                    model.ENName = string.IsNullOrEmpty(Request.Form["txt_ConsultantENName" + ids]) ? "" : Request.Form["txt_ConsultantENName" + ids].ToString();
                    model.Title = string.IsNullOrEmpty(Request.Form["txt_Position" + ids]) ? "" : Request.Form["txt_Position" + ids].ToString();
                    model.Sort = string.IsNullOrEmpty(Request.Form["txt_ConsultantSort" + ids]) ? 0 : int.Parse(Request.Form["txt_ConsultantSort" + ids].ToString());
                    nlist.Add(model);
                }
            }
        }

        int uploadfile_count = int.Parse(hid_Consultant_Count.Value);
        string filename = DateTime.Now.ToString("yyyyMMddHHmmss");
        for (int i = 1; i <= uploadfile_count; i++)
        {
            string imageurl = upLoadImage2("file_Consultant_" + i, filename + "_" + i);
            string name = string.IsNullOrEmpty(Request.Form["ConsultantCNName_" + i]) ? "" : Request.Form["ConsultantCNName_" + i].ToString();
            if (!string.IsNullOrEmpty(imageurl) && !string.IsNullOrWhiteSpace(name))
            {
                Model.SchoolsConsultant model = new Model.SchoolsConsultant();
                model.SchoolId = Pid;
                model.Phone = imageurl;
                model.CNName = name;
                model.Comment = string.IsNullOrEmpty(Request.Form["Info_" + i]) ? "" : Request.Form["Info_" + i].ToString();
                model.ENName = string.IsNullOrEmpty(Request.Form["ConsultantENName_" + i]) ? "" : Request.Form["ConsultantENName_" + i].ToString();
                model.Title = string.IsNullOrEmpty(Request.Form["Position_" + i]) ? "" : Request.Form["Position_" + i].ToString();
                model.Sort = string.IsNullOrEmpty(Request.Form["ConsultantSort_" + i]) ? 0 : int.Parse(Request.Form["ConsultantSort_" + i].ToString());
                nlist.Add(model);
            }
        }

        return nlist;
    }


    /// <summary>
    /// 顾问点评
    /// </summary>
    /// <param name="name"></param>
    /// <returns></returns>
    private string upLoadImage2(string name, string filename)
    {
        if (Request.Files[name] == null || string.IsNullOrEmpty(Request.Files[name].FileName))
        {
            return "";
        }

        string imageurl = "/UploadImage/SchoolConsultant/" + filename + Path.GetExtension(Request.Files[name].FileName).ToLower();
        try
        {
            Request.Files[name].SaveAs(Server.MapPath(imageurl));
        }
        catch
        {
            return "";
        }

        return imageurl;
    }



    /// <summary>
    /// 院校视频
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.SchoolsVoide> myVoide(int Pid)
    {
        List<Model.SchoolsVoide> nlist = new List<Model.SchoolsVoide>();

        string image_id = Request.Form["Voide_HidId"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    Model.SchoolsVoide model = new Model.SchoolsVoide();
                    if (ID > 0)
                    {
                        model.ID = int.Parse(ids);
                    }
                    model.Title = string.IsNullOrEmpty(Request.Form["txt_voide" + ids]) ? "" : Request.Form["txt_voide" + ids].ToString();
                    model.VoideUrl = string.IsNullOrEmpty(Request.Form["txt_link" + ids]) ? "" : Request.Form["txt_link" + ids].ToString();
                    model.Sort = string.IsNullOrEmpty(Request.Form["txt_voidesort" + ids]) ? 0 : int.Parse(Request.Form["txt_voidesort" + ids].ToString());
                    nlist.Add(model);
                }
            }
        }

        int uploadfile_count = int.Parse(hid_uploadfile_count.Value);
        string filename = DateTime.Now.ToString("yyyyMMddHHmmss");
        for (int i = 1; i <= uploadfile_count; i++)
        {
            string imageurl = upLoadImage3("file_voide_" + i, filename + "_" + i);
            string Name = string.IsNullOrEmpty(Request.Form["voide_" + i]) ? "" : Request.Form["voide_" + i].ToString();
            if (!string.IsNullOrEmpty(imageurl) && !string.IsNullOrWhiteSpace(Name))
            {
                Model.SchoolsVoide model = new Model.SchoolsVoide();
                model.SchoolId = Pid;
                model.Image = imageurl;
                model.Title = Name;
                model.VoideUrl = string.IsNullOrEmpty(Request.Form["link_" + i]) ? "" : Request.Form["link_" + i].ToString();
                model.Sort = string.IsNullOrEmpty(Request.Form["voide_sort" + i]) ? 0 : int.Parse(Request.Form["voide_sort" + i].ToString());
                nlist.Add(model);
            }
        }

        return nlist;
    }


    /// <summary>
    /// 院校视频
    /// </summary>
    /// <param name="name"></param>
    /// <returns></returns>
    private string upLoadImage3(string name, string filename)
    {
        if (Request.Files[name] == null || string.IsNullOrEmpty(Request.Files[name].FileName))
        {
            return "";
        }

        string imageurl = "/UploadImage/SchoolVoide/" + filename + Path.GetExtension(Request.Files[name].FileName).ToLower();
        try
        {
            Request.Files[name].SaveAs(Server.MapPath(imageurl));
        }
        catch
        {
            return "";
        }

        return imageurl;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.SchoolsOtherAlumnus> OtherPeople(int Pid)
    {
        List<Model.SchoolsOtherAlumnus> nlist = new List<Model.SchoolsOtherAlumnus>();

        string image_id = Request.Form["other_id"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    string Title = string.IsNullOrEmpty(Request.Form["Others_Title" + ids]) ? "" : Request.Form["Others_Title" + ids].ToString();
                    string Info = string.IsNullOrEmpty(Request.Form["Others_Info" + ids]) ? "" : Request.Form["Others_Info" + ids].ToString();
                    if (!string.IsNullOrEmpty(Title) && !string.IsNullOrWhiteSpace(Info))
                    {
                        Model.SchoolsOtherAlumnus model = new Model.SchoolsOtherAlumnus();
                        if (ID > 0)
                        {
                            model.ID = int.Parse(ids);
                        }
                        model.Info = Info;
                        model.Title = Title;
                        nlist.Add(model);
                    }
                }
            }
        }

        int uploadfile_count = int.Parse(other_count.Value);
        for (int i = 1; i <= uploadfile_count; i++)
        {
            string Title = string.IsNullOrEmpty(Request.Form["Other_Title" + i]) ? "" : Request.Form["Other_Title" + i].ToString();
            string Info = string.IsNullOrEmpty(Request.Form["Other_Info" + i]) ? "" : Request.Form["Other_Info" + i].ToString();
            if (!string.IsNullOrEmpty(Title) && !string.IsNullOrWhiteSpace(Info))
            {
                Model.SchoolsOtherAlumnus model = new Model.SchoolsOtherAlumnus();
                model.Info = Info;
                model.SchoolsId = Pid;
                model.Title = Title;
                nlist.Add(model);
            }
        }

        return nlist;
    }

}
