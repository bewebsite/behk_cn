﻿//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-10-19 09:52:38

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
using System.IO;

public partial class _eyoung_Temp_Temps_Add : AdminPageBase
{
    public int ID = 0;
    private BLL.Temps bll = new BLL.Temps();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        if (ID < 1)
        {
            ID = 0;
        }
        if (!IsPostBack)
        {
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
            Model.Temps model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1011, 4);
            this.Title = Lit_Title.Text = "产品模版修改";
            txt_HtmlName.Text = model.HtmlName;
            txt_PageTitle.Text = model.PageTitle;
            txt_PageKey.Text = model.PageKey;
            txt_PageDes.Text = model.PageDes;
            txt_CNName.Text = model.CNName;
            txt_ENName.Text = model.ENName;

            txt_StarYear.Text = model.StarYear.ToString();
            txt_EndYear.Text = model.EndYear.ToString();
            txt_CategoriesInfo.Text = model.CategoriesInfo;
            txt_Intor.Text = model.Intor;
            txt_RegistrationInfo.Text = model.RegistrationInfo;
            t_HtmlName.Value = model.HtmlName;
            drpLan.SelectedValue = model.Lan.Value.ToString();


            /*相关国家*/
            if (!string.IsNullOrWhiteSpace(model.CountryId))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=1", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.CountryId.IndexOf("," + l.ID + ",") >= 0)
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
            Hid_Country.Value = model.CountryId;


            /*必益相关业务*/
            if (!string.IsNullOrWhiteSpace(model.BusinessId))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=3", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.BusinessId.IndexOf("," + l.ID + ",") >= 0)
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
            this.Hid_Business.Value = model.BusinessId;


            /*相关城市*/
            if (!string.IsNullOrWhiteSpace(model.CityId))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=2", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.CityId.IndexOf("," + l.ID + ",") >= 0)
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
            Hid_City.Value = model.CityId;

            /*适用学习阶段*/
            if (!string.IsNullOrWhiteSpace(model.LevelsId))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=4", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.LevelsId.IndexOf("," + l.ID + ",") >= 0)
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
            this.Hid_Levels.Value = model.LevelsId;

            /*适用人群类别*/
            if (!string.IsNullOrWhiteSpace(model.CategoriesId))
            {
                List<Model.Country> list = new BLL.Country().GetList(0, "Name,ID", "Kind=5", "");
                List<Model.Country> alist = new List<Model.Country>();
                foreach (Model.Country l in list)
                {
                    if (model.CategoriesId.IndexOf("," + l.ID + ",") >= 0)
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
            this.Hid_Categories.Value = model.CategoriesId;


            //BindBanner();//广告图
            BindImage();//产品图
            BindProduct();//产品模块
            BindSchool();//院校信息
            BindCase();//案例
            BindVoide(); //视频
            BindOtherList();//其他
        }
        else
        {
            drpCountry.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=1", "");
            drpCountry.DataBind();
            drpCountry.Items.Insert(0, new ListItem("--相关国家--", ""));

            drpBusiness.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=3", "");
            drpBusiness.DataBind();
            drpBusiness.Items.Insert(0, new ListItem("--必益相关业务--", ""));

            drpCity.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=2", "");
            drpCity.DataBind();
            drpCity.Items.Insert(0, new ListItem("--相关城市--", ""));

            drpLevels.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=4", "");
            drpLevels.DataBind();
            drpLevels.Items.Insert(0, new ListItem("--适用学习阶段--", ""));

            drpCategories.DataSource = new BLL.Country().GetList(0, "Name,ID", "Kind=5", "");
            drpCategories.DataBind();
            drpCategories.Items.Insert(0, new ListItem("--适用人群类型--", ""));


            But_Save.Visible = base.CheckPopedomInfo(1011, 2);
        }
    }

    //private void BindBanner()
    //{
    //    List<Model.TempsBanner> list = new BLL.TempsBanner().GetList(0, "", "TempId=" + ID + "", "Sort desc");
    //    StringBuilder sb = new StringBuilder();
    //    foreach (Model.TempsBanner l in list)
    //    {
    //        sb.AppendFormat("<dl class=\"addDl5 clearfix\"><dt><input name=\"Banner_HidId\" value=" + l.ID.Value + " type=\"hidden\" />");
    //        sb.AppendFormat("<a href=\"{0}\" title=\"点击查看大图\" id=\"example\"><img src=\"{0}\" width=\"80\" ></a></dt>", l.Image);
    //        sb.AppendFormat("<dd>");
    //        sb.AppendFormat("<p>广告说明：<input name=\"Banner_IAlt{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.IAlt);
    //        sb.AppendFormat("<p>连接地址：<input name=\"Banner_Link{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.GetUrl);
    //        sb.AppendFormat("<p>广告排序：<input name=\"Banner_Sort{0}\" class=\"text\" style=\"width: 50px\" value=\"{1}\" /></p>", l.ID, l.Sort);
    //        sb.Append("<p><a href=\"javascript:void(0);\" onclick=\"deleteUpload(this);\">[删除]</a></p>");
    //        sb.Append("</dd></dl>");
    //    }
    //    Lit_BannerList.Text = sb.ToString();
    //}

    private void BindImage()
    {
        List<Model.TempsImages> list = new BLL.TempsImages().GetList(0, "", "TempId=" + ID + "", "Sort desc");
        StringBuilder sb = new StringBuilder();
        foreach (Model.TempsImages l in list)
        {
            sb.AppendFormat("<dl class=\"addDl2 clearfix\"><dt><input name=\"Image_HidId\" value=" + l.ID.Value + " type=\"hidden\" />");
            sb.AppendFormat("<a href=\"{0}\" title=\"点击查看大图\" id=\"example\"><img src=\"{0}\" width=\"80\" ></a></dt>", l.Image);
            sb.AppendFormat("<dd>");
            sb.AppendFormat("<p>图片排序：<input name=\"Image_Sort{0}\" class=\"text\" style=\"width: 50px\" value=\"{1}\" /></p>", l.ID, l.Sort);
            sb.Append("<p><a href=\"javascript:void(0);\" onclick=\"deleteUpload(this);\">[删除]</a></p>");
            sb.Append("</dd></dl>");
        }
        lit_Image_List.Text = sb.ToString();
    }

    private void BindProduct()
    {
        List<Model.TempsProduct> list = new BLL.TempsProduct().GetList(0, "", "TempId=" + ID + "", "Sort desc");
        StringBuilder sb = new StringBuilder();
        int count = 0;
        foreach (Model.TempsProduct l in list)
        {
            count += 1;
            sb.AppendFormat("<table style=\"display: table;\" class=\"input tabContent\" id=\"one_{0}\"><tbody>", count);
            sb.AppendFormat("<tr><th>模块信息：</th>");
            sb.AppendFormat("<td>排序：<input type=\"text\" class=\"text\" style=\"width: 50px\" name=\"firstsort{0}\" value=\"{1}\">", count, l.Sort);
            sb.AppendFormat("<br/>中文名称：<input type=\"text\" name=\"onename{0}\" class=\"text\" value=\"{1}\" >&nbsp;&nbsp;&nbsp;&nbsp;", count, l.Name);
            sb.AppendFormat("<a v=\"{0}\" onclick=\"AddTwo(this)\" href=\"javascript:void(0)\">添加一个产品内容</a>&nbsp;&nbsp;&nbsp;&nbsp;", count);
            sb.AppendFormat("<a onclick=\"DeleteOne(this)\" href=\"javascript:void(0)\">[ 删除此模块 ]</a>");
            List<Model.TempsProductInfo> alist = new BLL.TempsProductInfo().GetList(0, "", "Pid=" + l.ID + "", "Sort desc");
            sb.AppendFormat("<input type=\"hidden\" name=\"hidone{0}\" value=\"{1}\" id=\"hidone{0}\">", count, alist.Count);
            sb.AppendFormat("<br/>英文名称：<input type=\"text\" class=\"text\" name=\"oneenname{0}\" value=\"{1}\" />", count, l.ENName);
            sb.Append("</td></tr>");
            int x = 0;
            foreach (Model.TempsProductInfo m in alist)
            {
                x += 1;
                sb.AppendFormat("<tr><th></th><td>排序：<input type=\"text\" class=\"text\" style=\"width: 50px\" name=\"twosort{0}{1}\" value=\"{2}\">", count, x, m.Sort);
                sb.AppendFormat("<span style=\"padding-left: 5px; color: Blue\">排序越大越靠前</span>&nbsp;&nbsp;");
                sb.AppendFormat("<a onclick=\"DeleteTwo(this)\" href=\"javascript:void(0)\">删除本条明细</a><br/>");
                sb.AppendFormat("标题：<input type=\"text\" class=\"text\" name=\"twotitle{0}{1}\" value=\"{2}\"><br/>", count, x, m.Name);
                sb.AppendFormat("明细：<textarea class=\"text\" name=\"twointor{0}{1}\" style=\"height: 40px\">{2}</textarea></td></tr>", count, x, m.Intor);
            }
            sb.Append("</tbody></table>");
        }
        Lit_ProductList.Text = sb.ToString();
        Hid_ProductCount.Value = count.ToString();
    }

    private void BindSchool()
    {
        List<Model.TempsSchool> list = new BLL.TempsSchool().GetList(0, "", "TempId=" + ID + "", "Sort desc");
        StringBuilder sb = new StringBuilder();
        foreach (Model.TempsSchool l in list)
        {
            sb.AppendFormat("<dl class=\"addDl6 clearfix\"><dt><input name=\"School_HidId\" value=" + l.ID.Value + " type=\"hidden\" />");
            sb.AppendFormat("<a href=\"{0}\" title=\"点击查看大图\" id=\"example\"><img src=\"{0}\" width=\"80\" ></a></dt>", l.Logo);
            sb.AppendFormat("<dd>");
            sb.AppendFormat("<p>中文名称：<input name=\"school_name{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.CNName);
            sb.AppendFormat("<p>英文名称：<input name=\"school_enname{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.ENName);
            sb.AppendFormat("<p>连接地址：<input name=\"school_link{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.GetUrl);
            sb.AppendFormat("<p>院校说明：<textarea style=\"height: 30px; width: 300px\" name=\"school_intor{0}\" class=\"text\">{1}</textarea></p>", l.ID, l.Intor);
            sb.AppendFormat("<p>院校排序：<input name=\"school_sort{0}\" class=\"text\" style=\"width: 50px\" value=\"{1}\" /></p>", l.ID, l.Sort);
            sb.Append("<p><a href=\"javascript:void(0);\" onclick=\"deleteUpload(this);\">[删除]</a></p>");
            sb.Append("</dd></dl>");
        }
        Lit_SchoolList.Text = sb.ToString();
    }

    private void BindCase()
    {
        List<Model.TempsCase> list = new BLL.TempsCase().GetList(0, "", "TempId=" + ID + "", "Sort desc");
        StringBuilder sb = new StringBuilder();
        foreach (Model.TempsCase l in list)
        {
            sb.AppendFormat("<dl class=\"addDl6 clearfix\"><dt><input name=\"Case_HidId\" value=" + l.ID.Value + " type=\"hidden\" />");
            if (!string.IsNullOrEmpty(l.Image))
            {
                sb.AppendFormat("<a href=\"{0}\" title=\"点击查看大图\" id=\"example\"><img src=\"{0}\" width=\"80\" ></a></dt>", l.Image);
            }
            sb.AppendFormat("<dd>");
            sb.AppendFormat("<p>姓名：<input name=\"case_name{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.Name);
            /*sb.AppendFormat("<p>录取学校：<select name=\"case_type{0}\"><option {1}>成功案例</option><option {2}>课程感言</option><option {3}>Success Story</option><option {4}>其他</option></select></p>", l.ID, l.CaseType == "成功案例" ? " selected=\"selected\"" : "", l.CaseType == "课程感言" ? " selected=\"selected\"" : "", l.CaseType == "Success Story" ? " selected=\"selected\"" : "", l.CaseType == "其他" ? " selected=\"selected\"" : "");*/
            sb.AppendFormat("<p>录取学校：<input name=\"case_School{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.School);
            sb.AppendFormat("<p>详情页地址：<input name=\"case_URL{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.URL);
            sb.AppendFormat("<p>内容：<textarea style=\"height: 60px; width: 300px\" name=\"case_intor{0}\" class=\"text\">{1}</textarea></p>", l.ID, l.Intor);
            sb.AppendFormat("<p>排序：<input name=\"case_Sort{0}\" class=\"text\" style=\"width: 50px\" value=\"{1}\" /></p>", l.ID, l.Sort);
            sb.Append("<p><a href=\"javascript:void(0);\" onclick=\"deleteUpload(this);\">[删除]</a></p>");
            sb.Append("</dd></dl>");
        }
        Lit_CaseList.Text = sb.ToString();
    }

    private void BindVoide()
    {
        List<Model.TempsVoide> list = new BLL.TempsVoide().GetList(0, "", "TempId=" + ID + "", "Sort desc");
        StringBuilder sb = new StringBuilder();
        foreach (Model.TempsVoide l in list)
        {
            sb.AppendFormat("<dl class=\"addDl3 clearfix\"><dt><input name=\"Voide_HidId\" value=" + l.ID.Value + " type=\"hidden\" />");
            sb.AppendFormat("<a href=\"{0}\" title=\"点击查看大图\" id=\"example\"><img src=\"{0}\" width=\"80\" ></a></dt>", l.Image);
            sb.AppendFormat("<dd>");
            sb.AppendFormat("<p>视频名称：<input name=\"voide_name{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.Name);
            sb.AppendFormat("<p>连接地址：<input name=\"voide_url{0}\" class=\"text\" style=\"width: 300px\" value=\"{1}\" /></p>", l.ID, l.GetUrl);
            sb.AppendFormat("<p>视频排序：<input name=\"voide_Sorts{0}\" class=\"text\" style=\"width: 50px\" value=\"{1}\" /></p>", l.ID, l.Sort);
            sb.Append("<p><a href=\"javascript:void(0);\" onclick=\"deleteUpload(this);\">[删除]</a></p>");
            sb.Append("</dd></dl>");
        }
        Lit_VoideList.Text = sb.ToString();
    }

    private void BindOtherList()
    {
        List<Model.TempsOthers> list = new BLL.TempsOthers().GetList(0, "", "TempId=" + ID + "", "Sort desc");
        StringBuilder sb = new StringBuilder();
        int count = 0;
        foreach (Model.TempsOthers l in list)
        {
            count += 1;
            sb.AppendFormat("<tr><th>&nbsp;</th><td>模块名称：<input type=\"text\" name=\"otherName{0}\" class=\"text\" value=\"{1}\">&nbsp;&nbsp;&nbsp;&nbsp;", count, l.Name);
            sb.AppendFormat("<a href=\"javascript:void(0)\" onclick=\"DeleteOther(this)\">删除此模块</a><br/><p style=\"height: 8px;\">&nbsp;</p>");
            sb.AppendFormat("英文名称：<input type=\"text\" name=\"otherENName{0}\" class=\"text\" value=\"{1}\"><br/><p style=\"height: 8px;\">&nbsp;</p>", count, l.ENName);
            sb.AppendFormat("模块排序：<input type=\"text\" name=\"otherSort{0}\"  onblur=\"checkproductnum(this);\" value=\"{1}\" class=\"text\" style=\"width:50px\"><br/>", count, l.Sort);
            sb.AppendFormat("<p style=\"height: 8px;\">&nbsp;</p><textarea id=\"otherinfo{0}\" name=\"otherinfo{0}\">{1}</textarea></td></tr>", count, l.Intor);
        }
        Lit_OtherList.Text = sb.ToString();
        Hid_OtherCount.Value = count.ToString();
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
    /// 保存
    /// </summary>
    private void save()
    {
        Model.Temps model = myValidate();
        if (model == null)
        {
            return;
        }

        if (ID > 0)
        {
            string oldHtmlUrl = "/" + t_HtmlName.Value + ".html";
            string newHtmlUrl = "/" + model.HtmlName + ".html";
            string url = "/temp/?ID=" + ID;
            string back = Help.UpdateUrl(oldHtmlUrl, newHtmlUrl, url, "/");
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

            ///***********广告图*************/
            //List<Model.TempsBanner> product_img_list = myBannerValidate(ID);
            //List<Model.TempsBanner> oproductimg_list = new BLL.TempsBanner().GetList(0, "TempId=" + ID + "", "Sort desc");

            ////添加、修改图片
            //foreach (Model.TempsBanner item in product_img_list)
            //{
            //    if (item.ID.HasValue && item.ID > 0)
            //    {
            //        int productimg_id = item.ID.Value;
            //        item.ID = null;
            //        new BLL.TempsBanner().Update(item, "ID=" + productimg_id);
            //        Model.TempsBanner removemodel = oproductimg_list.Find(delegate(Model.TempsBanner m) { return m.ID.Value == productimg_id; });
            //        if (removemodel != null)
            //        {
            //            oproductimg_list.Remove(removemodel);
            //        }
            //    }
            //    else
            //    {
            //        new BLL.TempsBanner().Add(item);
            //    }
            //}

            ////删除商品图片
            //string img_deleteid = "";
            //if (oproductimg_list.Count > 0)
            //{
            //    foreach (Model.TempsBanner item in oproductimg_list)
            //    {
            //        img_deleteid += item.ID + ",";
            //    }
            //}
            //img_deleteid = System.Text.RegularExpressions.Regex.Replace(img_deleteid, ",$", "");
            //if (!string.IsNullOrEmpty(img_deleteid))
            //{
            //    new BLL.TempsBanner().DeleteList("ID in (" + img_deleteid + ")");
            //}




            /************产品图***********/
            List<Model.TempsImages> product_img_list2 = myImageValidate(ID);
            List<Model.TempsImages> oproductimg_list2 = new BLL.TempsImages().GetList(0, "TempId=" + ID + "", "Sort desc");

            //添加、修改图片
            foreach (Model.TempsImages item in product_img_list2)
            {
                if (item.ID.HasValue && item.ID > 0)
                {
                    int productimg_id = item.ID.Value;
                    item.ID = null;
                    new BLL.TempsImages().Update(item, "ID=" + productimg_id);
                    Model.TempsImages removemodel = oproductimg_list2.Find(delegate(Model.TempsImages m) { return m.ID.Value == productimg_id; });
                    if (removemodel != null)
                    {
                        oproductimg_list2.Remove(removemodel);
                    }
                }
                else
                {
                    new BLL.TempsImages().Add(item);
                }
            }

            //删除商品图片
            string img_deleteid2 = "";
            if (oproductimg_list2.Count > 0)
            {
                foreach (Model.TempsImages item in oproductimg_list2)
                {
                    img_deleteid2 += item.ID + ",";
                }
            }
            img_deleteid2 = System.Text.RegularExpressions.Regex.Replace(img_deleteid2, ",$", "");
            if (!string.IsNullOrEmpty(img_deleteid2))
            {
                new BLL.TempsImages().DeleteList("ID in (" + img_deleteid2 + ")");
            }



            //产品模块修改
            myProductValidate(ID);



            /***********院校信息*************/
            List<Model.TempsSchool> product_img_list3 = mySchoolValidate(ID);
            List<Model.TempsSchool> oproductimg_list3 = new BLL.TempsSchool().GetList(0, "TempId=" + ID + "", "Sort desc");

            //添加、修改图片
            foreach (Model.TempsSchool item in product_img_list3)
            {
                if (item.ID.HasValue && item.ID > 0)
                {
                    int productimg_id = item.ID.Value;
                    item.ID = null;
                    new BLL.TempsSchool().Update(item, "ID=" + productimg_id);
                    Model.TempsSchool removemodel = oproductimg_list3.Find(delegate(Model.TempsSchool m) { return m.ID.Value == productimg_id; });
                    if (removemodel != null)
                    {
                        oproductimg_list3.Remove(removemodel);
                    }
                }
                else
                {
                    new BLL.TempsSchool().Add(item);
                }
            }

            //删除商品图片
            string img_deleteid3 = "";
            if (oproductimg_list3.Count > 0)
            {
                foreach (Model.TempsSchool item in oproductimg_list3)
                {
                    img_deleteid3 += item.ID + ",";
                }
            }
            img_deleteid3 = System.Text.RegularExpressions.Regex.Replace(img_deleteid3, ",$", "");
            if (!string.IsNullOrEmpty(img_deleteid3))
            {
                new BLL.TempsSchool().DeleteList("ID in (" + img_deleteid3 + ")");
            }


            /***********案例*************/
            List<Model.TempsCase> product_img_list4 = myCaseValidate(ID);
            List<Model.TempsCase> oproductimg_list4 = new BLL.TempsCase().GetList(0, "TempId=" + ID + "", "Sort desc");

            //添加、修改图片
            foreach (Model.TempsCase item in product_img_list4)
            {
                if (item.ID.HasValue && item.ID > 0)
                {
                    int productimg_id = item.ID.Value;
                    item.ID = null;
                    new BLL.TempsCase().Update(item, "ID=" + productimg_id);
                    Model.TempsCase removemodel = oproductimg_list4.Find(delegate(Model.TempsCase m) { return m.ID.Value == productimg_id; });
                    if (removemodel != null)
                    {
                        oproductimg_list4.Remove(removemodel);
                    }
                }
                else
                {
                    new BLL.TempsCase().Add(item);
                }
            }

            //删除商品图片
            string img_deleteid4 = "";
            if (oproductimg_list4.Count > 0)
            {
                foreach (Model.TempsCase item in oproductimg_list4)
                {
                    img_deleteid4 += item.ID + ",";
                }
            }
            img_deleteid4 = System.Text.RegularExpressions.Regex.Replace(img_deleteid4, ",$", "");
            if (!string.IsNullOrEmpty(img_deleteid4))
            {
                new BLL.TempsCase().DeleteList("ID in (" + img_deleteid4 + ")");
            }


            /***********视频*************/
            List<Model.TempsVoide> product_img_list5 = myVoideValidate(ID);
            List<Model.TempsVoide> oproductimg_list5 = new BLL.TempsVoide().GetList(0, "TempId=" + ID + "", "Sort desc");

            //添加、修改图片
            foreach (Model.TempsVoide item in product_img_list5)
            {
                if (item.ID.HasValue && item.ID > 0)
                {
                    int productimg_id = item.ID.Value;
                    item.ID = null;
                    new BLL.TempsVoide().Update(item, "ID=" + productimg_id);
                    Model.TempsVoide removemodel = oproductimg_list5.Find(delegate(Model.TempsVoide m) { return m.ID.Value == productimg_id; });
                    if (removemodel != null)
                    {
                        oproductimg_list5.Remove(removemodel);
                    }
                }
                else
                {
                    new BLL.TempsVoide().Add(item);
                }
            }

            //删除商品图片
            string img_deleteid5 = "";
            if (oproductimg_list5.Count > 0)
            {
                foreach (Model.TempsVoide item in oproductimg_list5)
                {
                    img_deleteid5 += item.ID + ",";
                }
            }
            img_deleteid5 = System.Text.RegularExpressions.Regex.Replace(img_deleteid5, ",$", "");
            if (!string.IsNullOrEmpty(img_deleteid5))
            {
                new BLL.TempsVoide().DeleteList("ID in (" + img_deleteid5 + ")");
            }


            /*其他模块*/
            BindOther(ID);

            base.AddLog(2, "产品模版修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "产品模版添加，ID为：" + i);


            string htmlurl = "/" + model.HtmlName + ".html";
            string url = "/temp/?ID=" + i;
            string back = Help.AddUrl(htmlurl, url, "/");
            if (back != "")
            {
                Model.Temps mm = new Model.Temps();
                mm.HtmlName = back;
                int y = bll.Update(mm, "ID=" + i);
            }

            ///**广告图*/
            //List<Model.TempsBanner> list = myBannerValidate(i);
            //foreach (Model.TempsBanner l in list)
            //{
            //    new BLL.TempsBanner().Add(l);
            //}

            /*产品图*/
            List<Model.TempsImages> alist = myImageValidate(i);
            foreach (Model.TempsImages l in alist)
            {
                new BLL.TempsImages().Add(l);
            }

            /*产品模块*/
            myProductValidate(i);

            /*院校*/
            List<Model.TempsSchool> slist = mySchoolValidate(i);
            foreach (Model.TempsSchool l in slist)
            {
                new BLL.TempsSchool().Add(l);
            }

            /*案例*/
            List<Model.TempsCase> clist = myCaseValidate(i);
            foreach (Model.TempsCase l in clist)
            {
                new BLL.TempsCase().Add(l);
            }

            /*产品视频*/
            List<Model.TempsVoide> vlist = myVoideValidate(i);
            foreach (Model.TempsVoide l in vlist)
            {
                new BLL.TempsVoide().Add(l);
            }

            /*其他模块*/
            BindOther(i);
        }

        Response.Redirect("Temps_List.aspx");
    }


    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Temps myValidate()
    {
        string HtmlName = txt_HtmlName.Text.Trim();
        string PageTitle = txt_PageTitle.Text.Trim();
        string PageKey = txt_PageKey.Text.Trim();
        string PageDes = txt_PageDes.Text.Trim();
        string CNName = txt_CNName.Text.Trim();
        string ENName = txt_ENName.Text.Trim();
        string StarYear = txt_StarYear.Text.Trim();
        string EndYear = txt_EndYear.Text.Trim();
        string CategoriesInfo = txt_CategoriesInfo.Text.Trim();
        string Intor = txt_Intor.Text.Trim();
        string RegistrationInfo = txt_RegistrationInfo.Text.Trim();

        Model.Temps model = new Model.Temps();
        model.HtmlName = HtmlName;
        model.PageTitle = PageTitle;
        model.PageKey = PageKey;
        model.PageDes = PageDes;
        model.CNName = CNName;
        model.ENName = ENName;
        model.CountryId = Hid_Country.Value;
        model.BusinessId = Hid_Business.Value;
        model.CityId = Hid_City.Value;
        model.LevelsId = Hid_Levels.Value;
        model.StarYear = int.Parse(StarYear);
        model.EndYear = int.Parse(EndYear);
        model.CategoriesId = Hid_Categories.Value;
        model.CategoriesInfo = CategoriesInfo;
        model.Intor = Intor;
        model.RegistrationInfo = RegistrationInfo;
        model.AddTime = DateTime.Now;
        model.Lan = int.Parse(drpLan.SelectedValue);

        return model;
    }

    ///// <summary>
    ///// 广告图
    ///// </summary>
    ///// <param name="ProductNo"></param>
    ///// <returns></returns>
    //private List<Model.TempsBanner> myBannerValidate(int Pid)
    //{
    //    List<Model.TempsBanner> nlist = new List<Model.TempsBanner>();

    //    string image_id = Request.Form["Banner_HidId"];
    //    if (!string.IsNullOrEmpty(image_id))
    //    {
    //        foreach (string ids in image_id.Split(','))
    //        {
    //            if (!string.IsNullOrEmpty(ids))
    //            {
    //                Model.TempsBanner model = new Model.TempsBanner();
    //                if (ID > 0)
    //                {
    //                    model.ID = int.Parse(ids);
    //                }
    //                model.Sort = string.IsNullOrEmpty(Request.Form["Banner_Sort" + ids]) ? 0 : int.Parse(Request.Form["Banner_Sort" + ids].ToString());
    //                model.IAlt = string.IsNullOrEmpty(Request.Form["Banner_IAlt" + ids]) ? "" : Request.Form["Banner_IAlt" + ids].ToString();
    //                model.GetUrl = string.IsNullOrEmpty(Request.Form["Banner_Link" + ids]) ? "" : Request.Form["Banner_Link" + ids].ToString();
    //                nlist.Add(model);
    //            }
    //        }
    //    }

    //    int uploadfile_count = int.Parse(hid_Banner_count.Value);
    //    string filename = DateTime.Now.ToString("yyyyMMddHHmmss");
    //    for (int i = 1; i <= uploadfile_count; i++)
    //    {
    //        string imageurl = upLoadImage("file_Banner" + i, filename + "_" + i);
    //        if (!string.IsNullOrEmpty(imageurl))
    //        {
    //            Model.TempsBanner model = new Model.TempsBanner();
    //            model.TempId = Pid;
    //            model.Image = imageurl;
    //            model.GetUrl = string.IsNullOrEmpty(Request.Form["link_Banner" + i]) ? "" : Request.Form["link_Banner" + i].ToString();
    //            model.Sort = string.IsNullOrEmpty(Request.Form["sort_Banner" + i]) ? 0 : int.Parse(Request.Form["sort_Banner" + i].ToString());
    //            model.IAlt = string.IsNullOrEmpty(Request.Form["ialt_Banner" + i]) ? "" : Request.Form["ialt_Banner" + i].ToString();
    //            nlist.Add(model);
    //        }
    //    }

    //    return nlist;
    //}


    /// <summary>
    /// 产品图
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.TempsImages> myImageValidate(int Pid)
    {
        List<Model.TempsImages> nlist = new List<Model.TempsImages>();

        string image_id = Request.Form["Image_HidId"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    Model.TempsImages model = new Model.TempsImages();
                    if (ID > 0)
                    {
                        model.ID = int.Parse(ids);
                    }
                    model.Sort = string.IsNullOrEmpty(Request.Form["Image_Sort" + ids]) ? 0 : int.Parse(Request.Form["Image_Sort" + ids].ToString());
                    nlist.Add(model);
                }
            }
        }

        int uploadfile_count = int.Parse(hid_uploadfile_count.Value);
        string filename = DateTime.Now.ToString("yyyyMMddHHmmss");
        for (int i = 1; i <= uploadfile_count; i++)
        {
            string imageurl = upLoadImage("file_uploadimage_" + i, filename + "_" + i + "x");
            if (!string.IsNullOrEmpty(imageurl))
            {
                Model.TempsImages model = new Model.TempsImages();
                model.TempId = Pid;
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

        string imageurl = "/UploadImage/Temp/" + filename + Path.GetExtension(Request.Files[name].FileName).ToLower();
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
    /// 产品模块
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private void myProductValidate(int Pid)
    {
        new BLL.TempsProduct().DeleteList("TempId=" + Pid + "");
        new BLL.TempsProductInfo().DeleteList("TempId=" + Pid + "");
        List<Model.TempsProduct> list = new List<Model.TempsProduct>();
        int count = int.Parse(Hid_ProductCount.Value);
        for (int i = 1; i <= count; i++)
        {

            string name = string.IsNullOrEmpty(Request.Form["onename" + i]) ? "" : Request.Form["onename" + i].ToString();
            if (!string.IsNullOrWhiteSpace(name))
            {
                Model.TempsProduct l = new Model.TempsProduct();
                l.Name = name;
                l.ENName = string.IsNullOrEmpty(Request.Form["oneenname" + i]) ? "" : Request.Form["oneenname" + i].ToString();
                //l.Sort = i;
                l.Sort = string.IsNullOrEmpty(Request.Form["firstsort" + i]) ? 0 : int.Parse(Request.Form["firstsort" + i].ToString());
                l.TempId = Pid;
                list.Add(l);
            }
        }

        int onecount = 0;
        foreach (Model.TempsProduct l in list)
        {
            int id = 0;
            new BLL.TempsProduct().Add(l, out id);
            onecount += 1;
            int c = string.IsNullOrEmpty(Request.Form["hidone" + onecount]) ? 0 : int.Parse(Request.Form["hidone" + onecount].ToString());

            if (c > 0)
            {
                for (int i = 1; i <= c; i++)
                {
                    string title = string.IsNullOrEmpty(Request.Form["twotitle" + onecount + i]) ? "" : Request.Form["twotitle" + onecount + i].ToString();
                    if (!string.IsNullOrWhiteSpace(title))
                    {
                        Model.TempsProductInfo model = new Model.TempsProductInfo();
                        model.Name = title;
                        model.Sort = string.IsNullOrEmpty(Request.Form["twosort" + onecount + i]) ? 0 : int.Parse(Request.Form["twosort" + onecount + i].ToString());
                        model.TempId = Pid;
                        model.Intor = string.IsNullOrEmpty(Request.Form["twointor" + onecount + i]) ? "" : Request.Form["twointor" + onecount + i].ToString();
                        model.Pid = id;
                        new BLL.TempsProductInfo().Add(model);
                    }
                }
            }
        }
    }

    /// <summary>
    /// 产品图
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.TempsSchool> mySchoolValidate(int Pid)
    {
        List<Model.TempsSchool> nlist = new List<Model.TempsSchool>();

        string image_id = Request.Form["School_HidId"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    Model.TempsSchool model = new Model.TempsSchool();
                    if (ID > 0)
                    {
                        model.ID = int.Parse(ids);
                    }
                    model.Sort = string.IsNullOrEmpty(Request.Form["school_sort" + ids]) ? 0 : int.Parse(Request.Form["school_sort" + ids].ToString());

                    model.CNName = string.IsNullOrEmpty(Request.Form["school_name" + ids]) ? "" : Request.Form["school_name" + ids].ToString();
                    model.ENName = string.IsNullOrEmpty(Request.Form["school_enname" + ids]) ? "" : Request.Form["school_enname" + ids].ToString();
                    model.GetUrl = string.IsNullOrEmpty(Request.Form["school_link" + ids]) ? "" : Request.Form["school_link" + ids].ToString();
                    model.Intor = string.IsNullOrEmpty(Request.Form["school_intor" + ids]) ? "" : Request.Form["school_intor" + ids].ToString();
                    model.TempId = Pid;

                    nlist.Add(model);
                }
            }
        }

        int uploadfile_count = int.Parse(Hid_SchoolCount.Value);
        string filename = DateTime.Now.ToString("yyyyMMddHHmmss");
        for (int i = 1; i <= uploadfile_count; i++)
        {
            string imageurl = upLoadImage("file_school" + i, filename + "_" + i + "y");
            if (!string.IsNullOrEmpty(imageurl))
            {
                Model.TempsSchool model = new Model.TempsSchool();
                model.TempId = Pid;
                model.Logo = imageurl;
                model.CNName = string.IsNullOrEmpty(Request.Form["name_school" + i]) ? "" : Request.Form["name_school" + i].ToString();
                model.ENName = string.IsNullOrEmpty(Request.Form["enname_school" + i]) ? "" : Request.Form["enname_school" + i].ToString();
                model.GetUrl = string.IsNullOrEmpty(Request.Form["link_school" + i]) ? "" : Request.Form["link_school" + i].ToString();
                model.Intor = string.IsNullOrEmpty(Request.Form["intor_school" + i]) ? "" : Request.Form["intor_school" + i].ToString();
                model.Sort = string.IsNullOrEmpty(Request.Form["sort_school" + i]) ? 0 : int.Parse(Request.Form["sort_school" + i].ToString());
                nlist.Add(model);
            }
        }

        return nlist;
    }


    /// <summary>
    /// 案例
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.TempsCase> myCaseValidate(int Pid)
    {
        List<Model.TempsCase> nlist = new List<Model.TempsCase>();

        string image_id = Request.Form["Case_HidId"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    Model.TempsCase model = new Model.TempsCase();
                    if (ID > 0)
                    {
                        model.ID = int.Parse(ids);
                    }
                    model.CaseType = string.IsNullOrEmpty(Request.Form["case_type" + ids]) ? "" : Request.Form["case_type" + ids].ToString();
                    model.Intor = string.IsNullOrEmpty(Request.Form["case_intor" + ids]) ? "" : Request.Form["case_intor" + ids].ToString();
                    model.Name = string.IsNullOrEmpty(Request.Form["case_name" + ids]) ? "" : Request.Form["case_name" + ids].ToString();
                    model.TempId = Pid;
                    model.Sort = string.IsNullOrEmpty(Request.Form["case_Sort" + ids]) ? 0 : int.Parse(Request.Form["case_Sort" + ids].ToString());
                    model.School = string.IsNullOrEmpty(Request.Form["case_School" + ids]) ? "" : Request.Form["case_School" + ids].ToString();
                    model.URL = string.IsNullOrEmpty(Request.Form["case_URL" + ids]) ? "" : Request.Form["case_URL" + ids].ToString();
                    nlist.Add(model);
                }
            }
        }

        int uploadfile_count = int.Parse(Hid_CaseCount.Value);
        string filename = DateTime.Now.ToString("yyyyMMddHHmmss");
        for (int i = 1; i <= uploadfile_count; i++)
        {
            string imageurl = upLoadImage("file_case" + i, filename + "_" + i + "z");
            string name = string.IsNullOrEmpty(Request.Form["name_case" + i]) ? "" : Request.Form["name_case" + i].ToString();
            if (!string.IsNullOrEmpty(name))
            {
                Model.TempsCase model = new Model.TempsCase();
                model.TempId = Pid;
                model.Image = imageurl;
                model.CaseType = string.IsNullOrEmpty(Request.Form["type_case" + i]) ? "" : Request.Form["type_case" + i].ToString();
                model.Name = name;
                model.Intor = string.IsNullOrEmpty(Request.Form["intor_case" + i]) ? "" : Request.Form["intor_case" + i].ToString();
                model.Sort = string.IsNullOrEmpty(Request.Form["sort_case" + i]) ? 0 : int.Parse(Request.Form["sort_case" + i].ToString());
                model.School = string.IsNullOrEmpty(Request.Form["school_case" + i]) ? "" : Request.Form["school_case" + i].ToString();
                model.CaseType = string.IsNullOrEmpty(Request.Form["url_case" + i]) ? "" : Request.Form["url_case" + i].ToString();
                nlist.Add(model);
            }
        }

        return nlist;
    }


    /// <summary>
    /// 视频
    /// </summary>
    /// <param name="ProductNo"></param>
    /// <returns></returns>
    private List<Model.TempsVoide> myVoideValidate(int Pid)
    {
        List<Model.TempsVoide> nlist = new List<Model.TempsVoide>();

        string image_id = Request.Form["Voide_HidId"];
        if (!string.IsNullOrEmpty(image_id))
        {
            foreach (string ids in image_id.Split(','))
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    Model.TempsVoide model = new Model.TempsVoide();
                    if (ID > 0)
                    {
                        model.ID = int.Parse(ids);
                    }
                    model.TempId = Pid;
                    model.Name = string.IsNullOrEmpty(Request.Form["voide_name" + ids]) ? "" : Request.Form["voide_name" + ids].ToString();
                    model.GetUrl = string.IsNullOrEmpty(Request.Form["voide_url" + ids]) ? "" : Request.Form["voide_url" + ids].ToString();
                    model.Sort = string.IsNullOrEmpty(Request.Form["voide_Sorts" + ids]) ? 0 : int.Parse(Request.Form["voide_Sorts" + ids].ToString());
                    nlist.Add(model);
                }
            }
        }

        int uploadfile_count = int.Parse(Hid_CaseCount.Value);
        string filename = DateTime.Now.ToString("yyyyMMddHHmmss");
        for (int i = 1; i <= uploadfile_count; i++)
        {
            string imageurl = upLoadImage("file_voide_" + i, filename + "_" + i + "q");
            if (!string.IsNullOrEmpty(imageurl))
            {
                Model.TempsVoide model = new Model.TempsVoide();
                model.TempId = Pid;
                model.Image = imageurl;
                model.Name = string.IsNullOrEmpty(Request.Form["voide_" + i]) ? "" : Request.Form["voide_" + i].ToString();
                model.GetUrl = string.IsNullOrEmpty(Request.Form["link_" + i]) ? "" : Request.Form["link_" + i].ToString();
                model.Sort = string.IsNullOrEmpty(Request.Form["voide_sort" + i]) ? 0 : int.Parse(Request.Form["voide_sort" + i].ToString());
                nlist.Add(model);
            }
        }

        return nlist;
    }


    public void BindOther(int Pid)
    {
        new BLL.TempsOthers().DeleteList("TempId=" + Pid + "");
        int uploadfile_count = int.Parse(Hid_OtherCount.Value);
        for (int i = 1; i <= uploadfile_count; i++)
        {
            string name = string.IsNullOrEmpty(Request.Form["otherName" + i]) ? "" : Request.Form["otherName" + i].ToString();
            if (!string.IsNullOrWhiteSpace(name))
            {
                Model.TempsOthers m = new Model.TempsOthers();
                m.Intor = string.IsNullOrEmpty(Request.Form["otherinfo" + i]) ? "" : Request.Form["otherinfo" + i].ToString();
                m.Name = name;
                m.ENName = string.IsNullOrEmpty(Request.Form["otherENName" + i]) ? "" : Request.Form["otherENName" + i].ToString();
                m.Sort = string.IsNullOrEmpty(Request.Form["otherSort" + i]) ? 0 : int.Parse(Request.Form["otherSort" + i].ToString());
                m.TempId = Pid;
                new BLL.TempsOthers().Add(m);
            }
        }
    }
}
