//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 17:34:44

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
using System.IO;

public partial class _eyoung_Events_Events_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.Events bll = new BLL.Events();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        chk_IsPass.Visible = base.CheckPopedomInfo(1010, 16);//审核
        if (!IsPostBack)
        {
            drpType.DataSource = new BLL.EventsType().GetAllList();
            drpType.DataBind();
            drpType.Items.Insert(0, new ListItem("--请选择--", ""));
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
            Model.Events model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1010, 4);
            this.Title = Lit_Title.Text = "精彩活动修改";
            txt_HtmlName.Text = model.HtmlName;
            txt_PageTitle.Text = model.PageTitle;
            txt_PaegKey.Text = model.PaegKey;
            txt_PageDes.Text = model.PageDes;
            txt_CNTitle.Text = model.CNTitle;
            txt_ENTitle.Text = model.ENTitle;
            txt_StarAge.Text = model.StarAge.ToString();
            txt_EndAge.Text = model.EndAge.ToString();
            txt_StarDay.Text = model.StarDay;
            txt_EndDay.Text = model.EndDay;
            string[] str = model.StarTimer.Split(':');
            txt_StarTimer.Text = str[0];
            txt_StarTimer2.Text = str[1];
            if (!string.IsNullOrWhiteSpace(model.EndTimer))
            {
                string[] str2 = model.EndTimer.Split(':');
                txt_EndTimer.Text = str2[0];
                txt_EndTimer2.Text = str2[1];
            }
            txt_AllNum.Text = model.AllNum.ToString();
            txt_RegistrationNumber.Text = model.RegistrationNumber.ToString();
            txt_EnrollStar.Text = model.EnrollStar.Value.ToString("yyyy-MM-dd");
            txt_EnrollEnd.Text = model.EnrollEnd.Value.ToString("yyyy-MM-dd");
            txt_EnrollInfo.Text = model.EnrollInfo;
            txt_Address.Text = model.Address;
            txt_Location_X.Text = model.Location_X;
            txt_Location_Y.Text = model.Location_Y;
            txt_Latitude.Text = model.Latitude;
            txt_ContactName.Text = model.ContactName;
            txt_ContactEmail.Text = model.ContactEmail;
            txt_ContactMobile.Text = model.ContactMobile;
            txt_Highlights.Text = model.Highlights;
            txt_CrowdCategory.Text = model.CrowdCategory;
            txt_CategoriesIntroduction.Text = model.CategoriesIntroduction;
            txt_Intor.Text = model.Intor;
            txt_VIPCNName.Text = model.VIPCNName;
            txt_VIPENName.Text = model.VIPENName;
            if (!string.IsNullOrWhiteSpace(model.VIPPhone))
            {
                Lit_OfficerPhone.Text = "<img src=" + model.VIPPhone + "  style=\"width:122px; height:129px\" />";
                hid_OfficerPhone.Value = model.VIPPhone;
            }
            txt_VIPTitle.Text = model.VIPTitle;
            txt_VIPIntor.Text = model.VIPIntor;
            txt_VIPCNTopic.Text = model.VIPCNTopic;
            txt_VIPENTopic.Text = model.VIPENTopic;
            txt_Content.Text = model.Content;
            chk_IsPass.Checked = model.IsPass.Value;
            txt_Sort.Text = model.Sort.ToString();
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
            drpType.SelectedValue = model.TypeId.ToString();
            chk_IsHot.Checked = model.IsHot.Value;
            t_HtmlName.Value = model.HtmlName;

            BindImage();
            VoideInfo();

            /*相关学校*/
            if (!string.IsNullOrWhiteSpace(model.RelevantSchool))
            {
                List<Model.Schools> list = new BLL.Schools().GetList(0, "CNName,ID", "", "CNName");
                List<Model.Schools> alist = new List<Model.Schools>();
                foreach (Model.Schools l in list)
                {
                    if (model.RelevantSchool.IndexOf("," + l.ID + ",") >= 0)
                    {
                        Lit_Area.Text += "<a href='javascript:void(0)' v=" + l.ID + " t=" + l.CNName + " onclick='removeAreaId(this)' title='点击可移除'>" + l.CNName + " X</a>";
                    }
                    else
                    {
                        alist.Add(l);
                    }
                }
                drpSchool.DataSource = alist;
                drpSchool.DataBind();
                drpSchool.Items.Insert(0, new ListItem("--学校列表--", ""));
            }
            else
            {
                drpSchool.DataSource = new BLL.Schools().GetList(0, "CNName,ID", "", "CNName");
                drpSchool.DataBind();
                drpSchool.Items.Insert(0, new ListItem("--学校列表--", ""));
            }
            Hid_Area.Value = model.RelevantSchool;

            /*相关国家*/
            if (!string.IsNullOrWhiteSpace(model.RelevantCountry))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=1", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.RelevantCountry.IndexOf("," + l.ID + ",") >= 0)
                    {
                        this.Lit_CountryList.Text += "<a href='javascript:void(0)' v=" + l.ID + " t=" + l.Name + " onclick='removeCountryId(this)' title='点击可移除'>" + l.Name + " X</a>";
                    }
                    else
                    {
                        alist.Add(l);
                    }
                }
                drpCountry.DataSource = alist;
                drpCountry.DataBind();
                drpCountry.Items.Insert(0, new ListItem("--相关国家--", ""));
            }
            else
            {
                drpCountry.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=1", "");
                drpCountry.DataBind();
                drpCountry.Items.Insert(0, new ListItem("--相关国家--", ""));
            }
            Hid_Country.Value = model.RelevantCountry;

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
                drpCity.Items.Insert(0, new ListItem("--相关城市--", ""));
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
                drpCategories.Items.Insert(0, new ListItem("--适用人群类型--", ""));
            }
            else
            {
                drpCategories.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=5", "");
                drpCategories.DataBind();
                drpCategories.Items.Insert(0, new ListItem("--适用人群类型--", ""));
            }
            this.Hid_Categories.Value = model.RelevantCategories;
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1010, 2);
            txt_AddTime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            drpSchool.DataSource = new BLL.Schools().GetList(0, "CNName,ID", "", "CNName");
            drpSchool.DataBind();
            drpSchool.Items.Insert(0, new ListItem("--学校列表--", ""));

            drpCountry.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=1", "");
            drpCountry.DataBind();
            drpCountry.Items.Insert(0, new ListItem("--相关国家--", ""));

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
            drpCategories.Items.Insert(0, new ListItem("--适用人群类型--", ""));
        }
    }

    /// <summary>
    /// 照片
    /// </summary>
    public void BindImage()
    {
        BLL.EventImage productimg_bll = new BLL.EventImage();
        List<Model.EventImage> list = productimg_bll.GetList(0, "EventId=" + ID + "", "Sort desc");

        StringBuilder sb = new StringBuilder();
        foreach (Model.EventImage item in list)
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
        List<Model.EventVoide> list = new BLL.EventVoide().GetList(0, "", "EventId=" + ID + "", "Sort desc");
        StringBuilder sb = new StringBuilder();
        foreach (Model.EventVoide l in list)
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
        Model.Events model = myValidate();
        if (model == null)
        {
            return;
        }

        if (ID > 0)
        {
            string oldHtmlUrl = "/events/" + t_HtmlName.Value + ".html";
            string newHtmlUrl = "/events/" + model.HtmlName + ".html";
            string url = "/events/detail.aspx?ID=" + ID;
            string back = Help.UpdateUrl(oldHtmlUrl, newHtmlUrl, url, "/events/");
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
            base.AddLog(2, "精彩活动修改，ID为：" + ID);

            List<Model.EventImage> product_img_list = myPicValidate(ID);
            List<Model.EventImage> oproductimg_list = new BLL.EventImage().GetList(0, "EventId=" + ID + "", "Sort desc");


            //添加、修改图片
            foreach (Model.EventImage item in product_img_list)
            {
                if (item.ID.HasValue && item.ID > 0)
                {
                    int productimg_id = item.ID.Value;
                    item.ID = null;
                    new BLL.EventImage().Update(item, "ID=" + productimg_id);
                    Model.EventImage removemodel = oproductimg_list.Find(delegate(Model.EventImage m) { return m.ID.Value == productimg_id; });
                    if (removemodel != null)
                    {
                        oproductimg_list.Remove(removemodel);
                    }
                }
                else
                {
                    new BLL.EventImage().Add(item);
                }
            }

            //删除商品图片
            string img_deleteid = "";
            if (oproductimg_list.Count > 0)
            {
                foreach (Model.EventImage item in oproductimg_list)
                {
                    img_deleteid += item.ID + ",";
                }
            }
            img_deleteid = System.Text.RegularExpressions.Regex.Replace(img_deleteid, ",$", "");
            if (!string.IsNullOrEmpty(img_deleteid))
            {
                new BLL.EventImage().DeleteList("ID in (" + img_deleteid + ")");
            }


            List<Model.EventImage> imagelist = new BLL.EventImage().GetList(0, "", "EventId=" + ID + "", "Sort desc");
            if (imagelist.Count > 0)
            {
                Model.Events pp = new Model.Events();
                pp.Image = imagelist[0].Image;
                new BLL.Events().Update(pp, "ID=" + ID + "");
            }
            else
            {
                Model.Events pp = new Model.Events();
                pp.Image = "";
                new BLL.Events().Update(pp, "ID=" + ID + "");
            }

            ChangeVoide();
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "精彩活动添加，ID为：" + i);

            string htmlurl = "/events/" + model.HtmlName + ".html";
            string url = "/events/detail.aspx?ID=" + i;
            string back = Help.AddUrl(htmlurl, url, "/events/");
            if (back != "")
            {
                Model.Events mm = new Model.Events();
                mm.HtmlName = back;
                int y = bll.Update(mm, "ID=" + i);
            }

            List<Model.EventVoide> list = myVoide(i);
            foreach (Model.EventVoide l in list)
            {
                new BLL.EventVoide().Add(l);
            }

            List<Model.EventImage> alist = myPicValidate(i);
            foreach (Model.EventImage l in alist)
            {
                new BLL.EventImage().Add(l);
            }
        }

        Response.Redirect("Events_List.aspx");
    }

    public void ChangeVoide()
    {
        List<Model.EventVoide> product_img_list = myVoide(ID);
        List<Model.EventVoide> oproductimg_list = new BLL.EventVoide().GetList(0, "EventId=" + ID + "", "Sort desc");


        //添加、修改图片
        foreach (Model.EventVoide item in product_img_list)
        {
            if (item.ID.HasValue && item.ID > 0)
            {
                int productimg_id = item.ID.Value;
                item.ID = null;
                new BLL.EventVoide().Update(item, "ID=" + productimg_id);
                Model.EventVoide removemodel = oproductimg_list.Find(delegate(Model.EventVoide m) { return m.ID.Value == productimg_id; });
                if (removemodel != null)
                {
                    oproductimg_list.Remove(removemodel);
                }
            }
            else
            {
                new BLL.EventVoide().Add(item);
            }
        }

        //删除商品图片
        string img_deleteid = "";
        if (oproductimg_list.Count > 0)
        {
            foreach (Model.EventVoide item in oproductimg_list)
            {
                img_deleteid += item.ID + ",";
            }
        }
        img_deleteid = System.Text.RegularExpressions.Regex.Replace(img_deleteid, ",$", "");
        if (!string.IsNullOrEmpty(img_deleteid))
        {
            new BLL.EventVoide().DeleteList("ID in (" + img_deleteid + ")");
        }

    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Events myValidate()
    {
        string HtmlName = txt_HtmlName.Text.Trim();
        string PageTitle = txt_PageTitle.Text.Trim();
        string PaegKey = txt_PaegKey.Text.Trim();
        string PageDes = txt_PageDes.Text.Trim();
        string CNTitle = txt_CNTitle.Text.Trim();
        string ENTitle = txt_ENTitle.Text.Trim();
        string StarAge = txt_StarAge.Text.Trim();
        string EndAge = txt_EndAge.Text.Trim();
        string StarDay = txt_StarDay.Text.Trim();
        string EndDay = txt_EndDay.Text.Trim();
        string StarTimer = txt_StarTimer.Text.Trim();
        string StarTimer2 = txt_StarTimer2.Text.Trim();
        if (StarTimer2 == "")
        {
            StarTimer2 = "00";
        }
        else if (int.Parse(StarTimer2) < 10)
        {
            StarTimer2 = "0" + int.Parse(StarTimer2).ToString();
        }
        else
        {
            StarTimer2 = int.Parse(StarTimer2).ToString();
        }

        string EndTimer = txt_EndTimer.Text.Trim();
        string EndTimer2 = txt_EndTimer2.Text.Trim();
        if (EndTimer2 == "")
        {
            EndTimer2 = "00";
        }
        else if (int.Parse(EndTimer2) < 10)
        {
            EndTimer2 = "0" + int.Parse(EndTimer2).ToString();
        }
        else
        {
            EndTimer2 = int.Parse(EndTimer2).ToString();
        }
        string AllNum = txt_AllNum.Text.Trim();
        string RegistrationNumber = txt_RegistrationNumber.Text.Trim();
        string EnrollStar = txt_EnrollStar.Text.Trim();
        string EnrollEnd = txt_EnrollEnd.Text.Trim();
        string EnrollInfo = txt_EnrollInfo.Text.Trim();
        string Address = txt_Address.Text.Trim();
        string Location_X = txt_Location_X.Text.Trim();
        string Location_Y = txt_Location_Y.Text.Trim();
        string Latitude = txt_Latitude.Text.Trim();
        string ContactName = txt_ContactName.Text.Trim();
        string ContactEmail = txt_ContactEmail.Text.Trim();
        string ContactMobile = txt_ContactMobile.Text.Trim();
        string Highlights = txt_Highlights.Text.Trim();
        string CategoriesIntroduction = txt_CategoriesIntroduction.Text.Trim();
        string Intor = txt_Intor.Text.Trim();
        string VIPCNName = txt_VIPCNName.Text.Trim();
        string VIPENName = txt_VIPENName.Text.Trim();
        string OfficerPhone = (new Dispose_Image()).upLoadImage(FileUpload2, "/UploadImage/OfficerPhone/");
        if (string.IsNullOrWhiteSpace(OfficerPhone))
        {
            OfficerPhone = this.hid_OfficerPhone.Value;
        }
        string VIPTitle = txt_VIPTitle.Text.Trim();
        string VIPIntor = txt_VIPIntor.Text.Trim();
        string VIPCNTopic = txt_VIPCNTopic.Text.Trim();
        string VIPENTopic = txt_VIPENTopic.Text.Trim();
        string Content = txt_Content.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string Sort = txt_Sort.Text.Trim();
        string AddTime = txt_AddTime.Text.Trim();
        string TypeId = drpType.SelectedValue;
        string TypeName = drpType.SelectedItem.Text;

        Model.Events model = new Model.Events();
        model.HtmlName = HtmlName;
        model.PageTitle = PageTitle;
        model.PaegKey = PaegKey;
        model.PageDes = PageDes;
        model.CNTitle = CNTitle;
        model.ENTitle = ENTitle;
        model.StarAge = int.Parse(StarAge);
        model.EndAge = int.Parse(EndAge);
        model.StarDay = StarDay;
        model.EndDay = EndDay;
        model.StarTimer = StarTimer + ":" + StarTimer2;
        if (EndTimer != "")
        {
            model.EndTimer = EndTimer + ":" + EndTimer2;
        }
        else
        {
            model.EndTimer = "";
        }
        model.AllNum = int.Parse(AllNum);
        model.RegistrationNumber = int.Parse(RegistrationNumber);
        model.EnrollStar = DateTime.Parse(EnrollStar);
        model.EnrollEnd = DateTime.Parse(EnrollEnd);
        model.EnrollInfo = EnrollInfo;
        model.Address = Address;
        model.Location_X = Location_X;
        model.Location_Y = Location_Y;
        model.Latitude = Latitude;
        model.ContactName = ContactName;
        model.ContactEmail = ContactEmail;
        model.ContactMobile = ContactMobile;
        model.Highlights = Highlights;

        model.CategoriesIntroduction = CategoriesIntroduction;
        model.Intor = Intor;
        model.VIPCNName = VIPCNName;
        model.VIPENName = VIPENName;
        model.VIPPhone = OfficerPhone;
        model.VIPTitle = VIPTitle;
        model.VIPIntor = VIPIntor;
        model.VIPCNTopic = VIPCNTopic;
        model.VIPENTopic = VIPENTopic;
        model.Content = Content;
        model.IsPass = IsPass;
        model.Sort = int.Parse(Sort);
        model.AddTime = DateTime.Parse(AddTime);
        model.TypeId = int.Parse(TypeId);
        model.TypeName = TypeName;

        model.RelevantBusiness = Hid_Business.Value;
        model.RelevantCategories = Hid_Categories.Value;
        model.RelevantCity = Hid_City.Value;
        model.RelevantCountry = Hid_Country.Value;
        model.RelevantLevels = Hid_Levels.Value;
        model.RelevantSchool = Hid_Area.Value;
        model.CrowdCategory = txt_CrowdCategory.Text;
        model.IsHot = chk_IsHot.Checked;

        return model;
    }

    /// <summary>
    /// 验证上传图片
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.EventImage> myPicValidate(int Pid)
    {
        List<Model.EventImage> nlist = new List<Model.EventImage>();

        string image_id = Request.Form["hid_image_id"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    Model.EventImage model = new Model.EventImage();
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
                Model.EventImage model = new Model.EventImage();
                model.EventId = Pid;
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
    /// 院校视频
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.EventVoide> myVoide(int Pid)
    {
        List<Model.EventVoide> nlist = new List<Model.EventVoide>();

        string image_id = Request.Form["Voide_HidId"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    Model.EventVoide model = new Model.EventVoide();
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
                Model.EventVoide model = new Model.EventVoide();
                model.EventId = Pid;
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

}
