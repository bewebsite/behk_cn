//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-09 10:40:42

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_ENHome_ENHomeBanner_Add : AdminPageBase
{
    private BLL.ENHomeBanner bll = new BLL.ENHomeBanner();
    protected void Page_Load(object sender, EventArgs e)
    {
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
        Model.ENHomeBanner model = bll.GetModelBystrWhere("ID=1");
        if (model == null)
        {
            MessageBox.Show("该信息不存在");
        }

        But_Save.Visible = base.CheckPopedomInfo(1014, 4);
        this.Title = Lit_Title.Text = "英文首页修改";
        if (!string.IsNullOrEmpty(model.HeaderImage))
        {
            txt_Pic.Text = model.HeaderImage;
            lit_img_Pic.Text = "<img src=\"" + model.HeaderImage + "\" width=\"500\" />";
        }
        txt_HeaderUrl.Text = model.HeaderUrl;
        if (!string.IsNullOrEmpty(model.PhotoImage))
        {
            txt_Pic2.Text = model.PhotoImage;
            lit_img_Pic2.Text = "<img src=\"" + model.PhotoImage + "\" width=\"500\" />";
        }
        if (!string.IsNullOrEmpty(model.FooterImage))
        {
            txt_Pic3.Text = model.FooterImage;
            lit_img_Pic3.Text = "<img src=\"" + model.FooterImage + "\" width=\"500\" />";
        }
        txt_FooterUrl.Text = model.FooterUrl;
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
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string HeaderUrl = txt_HeaderUrl.Text.Trim();

        string Pic2 = (new Dispose_Image()).upLoadImage(FileUpload2, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic2))
        {
            Pic2 = txt_Pic2.Text.Trim();
        }

        string Pic3 = (new Dispose_Image()).upLoadImage(FileUpload3, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic3))
        {
            Pic3 = txt_Pic3.Text.Trim();
        }
        string FooterUrl = txt_FooterUrl.Text.Trim();

        Model.ENHomeBanner model = new Model.ENHomeBanner();
        model.HeaderImage = Pic;
        model.HeaderUrl = HeaderUrl;
        model.PhotoImage = Pic2;
        model.FooterImage = Pic3;
        model.FooterUrl = FooterUrl;


        if (bll.Update(model, "ID=1") < 1)
        {
            MessageBox.Show("修改失败");
        }
        base.AddLog(2, "英文首页修改");

        Response.Redirect("ENHomeBanner_Add.aspx");
    }
}
