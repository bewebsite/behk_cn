//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-30 16:50:48

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
using System.IO;

public partial class _eyoung_News_News_Add : AdminPageBase
{
    private int ID = 0;
    public int Count = 0;
    private BLL.News bll = new BLL.News();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        chk_IsPass.Visible = base.CheckPopedomInfo(1004, 16);//审核
        if (!IsPostBack)
        {
            drpKind.DataSource = new BLL.NewsType().GetAllList();
            drpKind.DataBind();
            drpKind.Items.Insert(0, new ListItem("--所属分类--", ""));



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
            Model.News model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1004, 4);
            this.Title = Lit_Title.Text = "新闻修改";
            txt_HtmlName.Text = model.HtmlName;
            txt_PageTitle.Text = model.PageTitle;
            txt_PageKey.Text = model.PageKey;
            txt_PageDes.Text = model.PageDes;
            txt_Title.Text = model.Title;
            if (!string.IsNullOrEmpty(model.Image))
            {
                txt_Pic.Text = model.Image;
                lit_img_Pic.Text = "<img src=\"" + model.Image + "\" style=\"width:300px;height:162px\" />";
            }
            drpKind.SelectedValue = model.Kind.ToString();
            txt_Lead.Text = model.Lead;
            txt_SourceName.Text = model.SourceName;
            txt_SourePosition.Text = model.SourePosition;
            if (!string.IsNullOrWhiteSpace(model.SourePhone))
            {
                txt_SourePhone.Text = model.SourePhone;
                txt_Pic2.Text = "<img src=\"" + model.SourePhone + "\" style=\"width:128px;height:176px\" />";
            }
            txt_SoureIntor.Text = model.SoureIntor;
            txt_SoureLink.Text = model.SoureLink;
            chk_IsPass.Checked = model.IsPass.Value;
            txt_Sort.Text = model.Sort.ToString();
            txt_Click.Text = model.Click.ToString();
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
            t_HtmlName.Value = model.HtmlName;
            txt_Content.Text = model.Content;
            //BindIntor();

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
            But_Save.Visible = base.CheckPopedomInfo(1004, 2);
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
            drpCategories.Items.Insert(0, new ListItem("--适用人群类别--", ""));


        }
    }

    //private void BindIntor()
    //{
    //    List<Model.NewsIntor> list = new BLL.NewsIntor().GetList(0, "", "NewsId=" + ID + "", "Sort desc");
    //    StringBuilder sb = new StringBuilder();
    //    int counts = 1;
    //    foreach (Model.NewsIntor l in list)
    //    {
    //        sb.AppendFormat("<div class=\"itemLabel\" id=\"id_{0}\"><input type=\"hidden\" name=\"hid_IntorId{0}\" value=\"{0}\" />", l.ID);
    //        sb.AppendFormat("<div class=\"num\" id=\"reorder_{0}\">{1}</div>", l.ID, counts);
    //        sb.AppendFormat("<a href=\"javascript:void(0);\" onclick=\"showOr(this);\" class=\"upHidden\" v=\"{0}\">展开</a>", l.ID);
    //        sb.AppendFormat("<a class=\"del\" href=\"javascript:void(0);\" onclick=\"Delete(this)\" v=\"{0}\">删除</a>", l.ID);
    //        sb.AppendFormat("<p class=\"tit\" id=\"name_{0}\">{1}</p>", l.ID, l.Title);
    //        sb.AppendFormat("<div class=\"con\" style=\"display:none\">");
    //        sb.AppendFormat("<div class=\"list\"><em>排序：</em><input type=\"text\" class=\"text\" style=\"width:50px\" name=\"sort_{0}\" value=\"{1}\" onblur=\"CheckSort(this)\" /><span style=\"color:Red;\"> 越大越靠前</span></div>", l.ID, l.Sort);
    //        sb.AppendFormat("<div class=\"list\"><em>章节标题：</em><input type=\"text\" class=\"text\" style=\"width:500px\" id=\"title_{0}\" name=\"title_{0}\" value=\"{1}\" /></div>", l.ID, l.Title);
    //        sb.AppendFormat("<div class=\"list\"><em>{1}：</em><input name=\"file_{0}\" onchange=\"CheckImage(this)\" class=\"text-h\" style=\"width: 200px;\" type=\"file\" /><span style=\"color:Red;padding-right:5px;\">最大宽度：640px</span>", l.ID, string.IsNullOrWhiteSpace(l.Image) ? "上传图片" : "重新上传");
    //        if (!string.IsNullOrWhiteSpace(l.Image))
    //        {
    //            sb.AppendFormat("<span><a href=\"{1}\" title=\"点击查看大图\" id=\"example\">点击查看图片</a></span><span style=\"padding-left:5px;\"><a href=\"javascript:void(0)\" onclick=\"DeleteImage(this)\">删除图片</a><input type=\"hidden\" name=\"hid_image{0}\" value=\"{1}\" /></span>", l.ID, l.Image);
    //        }
    //        sb.Append("</div>");
    //        sb.AppendFormat("<div class=\"list\"><em>图片说明：</em><input type=\"text\" class=\"text\" value=\"{1}\" style=\"width:500px\" name=\"image_{0}\" /></div>", l.ID, l.ImageAlt);
    //        sb.AppendFormat("<div class=\"list\"><em>参考连接：</em><input type=\"text\" class=\"text\" style=\"width:500px\" name=\"link_{0}\" value=\"{1}\" /></div>", l.ID, l.Link);
    //        sb.AppendFormat("<div class=\"list\"><em>详细内容：</em><textarea name=\"intor_{0}\" style=\"width:800px;height:100px;\" class=\"text\" cols=\"20\" rows=\"2\">{1}</textarea></div>", l.ID, l.Intor);
    //        sb.AppendFormat("<div class=\"list\"><em>备注信息：</em><textarea name=\"remarks_{0}\" style=\"width:800px; height:100px;\" class=\"text\" cols=\"20\" rows=\"2\">{1}</textarea></div>", l.ID, l.Remarks);
    //        sb.Append("</div></div>");
    //        Count += 1;
    //        counts += 1;
    //    }
    //    Lit_NewsInfo.Text = sb.ToString();
    //}

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
        Model.News model = myValidate();
        if (model == null)
        {
            return;
        }

        if (ID > 0)
        {
            string oldHtmlUrl = "/news/" + t_HtmlName.Value + ".html";
            string newHtmlUrl = "/news/" + model.HtmlName + ".html";
            string url = "/news/detail.aspx?ID=" + ID;
            string back = Help.UpdateUrl(oldHtmlUrl, newHtmlUrl, url, "/news/");
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
            base.AddLog(2, "新闻修改，ID为：" + ID);


            ///**之前的新闻章节*/
            //string filename = DateTime.Now.ToString("yyyyMMddHHmmss");

            //string okid = "";
            //List<Model.NewsIntor> alist = new BLL.NewsIntor().GetList(0, "", "NewsId=" + ID + "", "");
            //foreach (Model.NewsIntor lx in alist)
            //{
            //    int thisid = string.IsNullOrEmpty(Request.Form["hid_IntorId" + lx.ID]) ? 0 : int.Parse(Request.Form["hid_IntorId" + lx.ID].ToString());
            //    if (thisid > 0)
            //    {
            //        okid += thisid + ",";
            //        string title = string.IsNullOrWhiteSpace(Request.Form["title_" + lx.ID]) ? "" : Request.Form["title_" + lx.ID].ToString();
            //        Model.NewsIntor newsmodel = new Model.NewsIntor();
            //        newsmodel.Title = title;
            //        newsmodel.Image = upLoadImage("file_" + lx.ID, filename + "_" + lx.ID);
            //        if (string.IsNullOrWhiteSpace(newsmodel.Image))
            //        {
            //            newsmodel.Image = string.IsNullOrWhiteSpace(Request.Form["hid_image" + lx.ID]) ? "" : Request.Form["hid_image" + lx.ID].ToString();
            //        }
            //        newsmodel.ImageAlt = string.IsNullOrWhiteSpace(Request.Form["image_" + lx.ID]) ? "" : Request.Form["image_" + lx.ID].ToString();
            //        newsmodel.Intor = string.IsNullOrWhiteSpace(Request.Form["intor_" + lx.ID]) ? "" : Request.Form["intor_" + lx.ID].ToString();
            //        newsmodel.Link = string.IsNullOrWhiteSpace(Request.Form["link_" + lx.ID]) ? "" : Request.Form["link_" + lx.ID].ToString();
            //        newsmodel.Remarks = string.IsNullOrWhiteSpace(Request.Form["remarks_" + lx.ID]) ? "" : Request.Form["remarks_" + lx.ID].ToString();
            //        newsmodel.Sort = string.IsNullOrEmpty(Request.Form["sort_" + lx.ID]) ? 0 : int.Parse(Request.Form["sort_" + lx.ID].ToString());
            //        new BLL.NewsIntor().Update(newsmodel, "ID=" + lx.ID + "");
            //    }
            //}
            //if (okid == "")
            //{
            //    new BLL.NewsIntor().DeleteList("NewsId=" + ID + "");
            //}
            //else
            //{
            //    okid = okid.Substring(0, okid.Length - 1);
            //    new BLL.NewsIntor().DeleteList("NewsId=" + ID + " and ID not in (" + okid + ")");
            //}



            ///*新增的新闻章节*/
            //var count = int.Parse(hid_Count.Value);
            //List<Model.NewsIntor> list = new List<Model.NewsIntor>();


            //for (int x = 1; x <= count; x++)
            //{
            //    string title = string.IsNullOrWhiteSpace(Request.Form["title_" + x]) ? "" : Request.Form["title_" + x].ToString();
            //    if (!string.IsNullOrWhiteSpace(title))
            //    {
            //        Model.NewsIntor l = new Model.NewsIntor();
            //        l.Image = upLoadImage("file_" + x, filename + "_" + x);
            //        l.ImageAlt = string.IsNullOrWhiteSpace(Request.Form["image_" + x]) ? "" : Request.Form["image_" + x].ToString();
            //        l.Intor = string.IsNullOrWhiteSpace(Request.Form["intor_" + x]) ? "" : Request.Form["intor_" + x].ToString();
            //        l.Link = string.IsNullOrWhiteSpace(Request.Form["link_" + x]) ? "" : Request.Form["link_" + x].ToString();
            //        l.NewsId = ID;
            //        l.Remarks = string.IsNullOrWhiteSpace(Request.Form["remarks_" + x]) ? "" : Request.Form["remarks_" + x].ToString();
            //        l.Sort = string.IsNullOrEmpty(Request.Form["sort_" + x]) ? 0 : int.Parse(Request.Form["sort_" + x].ToString());
            //        l.Title = title;
            //        list.Add(l);
            //    }
            //}
            //foreach (Model.NewsIntor ll in list)
            //{
            //    new BLL.NewsIntor().Add(ll);
            //}





        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "新闻添加，ID为：" + i);

            string htmlurl = "/news/" + model.HtmlName + ".html";
            string url = "/news/detail.aspx?ID=" + i;
            string back = Help.AddUrl(htmlurl, url, "/news/");
            if (back != "")
            {
                Model.News mm = new Model.News();
                mm.HtmlName = back;
                int y = bll.Update(mm, "ID=" + i);
            }


            //var count = int.Parse(hid_Count.Value);
            //if (count == 0)
            //{
            //    Response.Redirect("News_List.aspx");
            //}

            //List<Model.NewsIntor> list = new List<Model.NewsIntor>();

            //string filename = DateTime.Now.ToString("yyyyMMddHHmmss");
            //for (int x = 1; x <= count; x++)
            //{
            //    string title = string.IsNullOrWhiteSpace(Request.Form["title_" + x]) ? "" : Request.Form["title_" + x].ToString();
            //    if (!string.IsNullOrWhiteSpace(title))
            //    {
            //        Model.NewsIntor l = new Model.NewsIntor();
            //        l.Image = upLoadImage("file_" + x, filename + "_" + x);
            //        l.ImageAlt = string.IsNullOrWhiteSpace(Request.Form["image_" + x]) ? "" : Request.Form["image_" + x].ToString();
            //        l.Intor = string.IsNullOrWhiteSpace(Request.Form["intor_" + x]) ? "" : Request.Form["intor_" + x].ToString();
            //        l.Link = string.IsNullOrWhiteSpace(Request.Form["link_" + x]) ? "" : Request.Form["link_" + x].ToString();
            //        l.NewsId = i;
            //        l.Remarks = string.IsNullOrWhiteSpace(Request.Form["remarks_" + x]) ? "" : Request.Form["remarks_" + x].ToString();
            //        l.Sort = string.IsNullOrEmpty(Request.Form["sort_" + x]) ? 0 : int.Parse(Request.Form["sort_" + x].ToString());
            //        l.Title = string.IsNullOrWhiteSpace(Request.Form["title_" + x]) ? "" : Request.Form["title_" + x].ToString();
            //        list.Add(l);
            //    }
            //}
            //foreach (Model.NewsIntor ll in list)
            //{
            //    new BLL.NewsIntor().Add(ll);
            //}

        }

        Response.Redirect("News_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.News myValidate()
    {
        string HtmlName = txt_HtmlName.Text.Trim();
        string PageTitle = txt_PageTitle.Text.Trim();
        string PageKey = txt_PageKey.Text.Trim();
        string PageDes = txt_PageDes.Text.Trim();
        string Title = txt_Title.Text.Trim();
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string Kind = drpKind.SelectedValue;
        string Lead = txt_Lead.Text.Trim();
        string SourceName = txt_SourceName.Text.Trim();
        string SourePosition = txt_SourePosition.Text.Trim();
        string SourePhone = (new Dispose_Image()).upLoadImage(FileUpload2, "/UploadImage/SourePhone/");
        if (string.IsNullOrEmpty(SourePhone))
        {
            SourePhone = txt_SourePhone.Text.Trim();
        }
        string SoureIntor = txt_SoureIntor.Text.Trim();
        string SoureLink = txt_SoureLink.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string Sort = txt_Sort.Text.Trim();
        string AddTime = txt_AddTime.Text.Trim();

        Model.News model = new Model.News();
        model.HtmlName = HtmlName;
        model.PageTitle = PageTitle;
        model.PageKey = PageKey;
        model.PageDes = PageDes;
        model.Title = Title;
        model.Image = Pic;
        model.Kind = int.Parse(Kind);
        model.Lead = Lead;
        model.SourceName = SourceName;
        model.SourePosition = SourePosition;
        model.SourePhone = SourePhone;
        model.SoureIntor = SoureIntor;
        model.SoureLink = SoureLink;
        model.IsPass = IsPass;
        model.Sort = int.Parse(Sort);
        model.RelevantSchool = Hid_Area.Value;
        model.AddTime = DateTime.Parse(AddTime);
        model.RelevantBusiness = Hid_Business.Value;
        model.RelevantCategories = Hid_Categories.Value;
        model.RelevantCity = Hid_City.Value;
        model.RelevantCountry = Hid_Country.Value;
        model.RelevantLevels = Hid_Levels.Value;
        model.Content = txt_Content.Text;

        return model;
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

        string imageurl = "/UploadImage/NewsInfo/" + filename + Path.GetExtension(Request.Files[name].FileName).ToLower();
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
