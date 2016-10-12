//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 11:59:22

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class eyoung_Schools_ListBanner_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.Banner bll = new BLL.Banner();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
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
            Model.Banner model = bll.GetModelBystrWhere("ID=" + ID + "");
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1013, 4);
            this.Title = Lit_Title.Text = "广告位修改";
            txt_Name.Text = model.Name;
            txt_GetUrl.Text = model.GetUrl;
            if (!string.IsNullOrEmpty(model.Image))
            {
                txt_Pic.Text = model.Image;
                lit_img_Pic.Text = "<img src=\"" + model.Image + "\" width=\"600\" />";
            }

            txt_GetUrl2.Text = model.ENUrl;
            if (!string.IsNullOrEmpty(model.ENImage))
            {
                txt_Pic2.Text = model.ENImage;
                lit_img_Pic2.Text = "<img src=\"" + model.ENImage + "\" width=\"600\" />";
            }
        }
        else
        {
            Response.Redirect("ListBanner_List.aspx");
        }
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
        Model.Banner model = myValidate();
        if (model == null)
        {
            return;
        }


        if (bll.Update(model, "ID=" + ID) < 1)
        {
            MessageBox.Show("修改失败");
        }
        base.AddLog(2, "广告位修改，ID为：" + ID);

        Response.Redirect("ListBanner_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Banner myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string GetUrl = txt_GetUrl.Text.Trim();
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }

        string GetUrl2 = txt_GetUrl2.Text.Trim();
        string Pic2 = (new Dispose_Image()).upLoadImage(FileUpload2, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic2))
        {
            Pic2 = txt_Pic2.Text.Trim();
        }

        Model.Banner model = new Model.Banner();
        model.Name = Name;
        model.GetUrl = GetUrl;
        model.Image = Pic;
        model.ENImage = Pic2;
        model.ENUrl = GetUrl2;

        return model;
    }
}
