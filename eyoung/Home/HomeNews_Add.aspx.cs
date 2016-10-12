//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-04 15:02:20

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_Home_HomeNews_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.HomeNews bll = new BLL.HomeNews();
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
            Model.HomeNews model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1012, 4);
            this.Title = Lit_Title.Text = "新闻修改";
            txt_Title.Text = model.Title;
            if (!string.IsNullOrEmpty(model.Image))
            {
                txt_Pic.Text = model.Image;
                lit_img_Pic.Text = "<img src=\"" + model.Image + "\" width=\"275\" />";
            }
            drpKind.SelectedValue = model.Kind.ToString();
            txt_Intor.Text = model.Intor;
            txt_GetUrl.Text = model.GetUrl;
            txt_Sort.Text = model.Sort.ToString();
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1012, 2);
            txt_AddTime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
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
        Model.HomeNews model = myValidate();
        if (model == null)
        {
            return;
        }

        if (ID > 0)
        {
            if (bll.Update(model, "ID=" + ID) < 1)
            {
                MessageBox.Show("修改失败");
            }
            base.AddLog(2, "新闻修改，ID为：" + ID);
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
        }

        Response.Redirect("HomeNews_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.HomeNews myValidate()
    {
        string Title = txt_Title.Text.Trim();
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string Kind = drpKind.SelectedValue;
        string Intor = txt_Intor.Text.Trim();
        string GetUrl = txt_GetUrl.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        string AddTime = txt_AddTime.Text.Trim();

        Model.HomeNews model = new Model.HomeNews();
        model.Title = Title;
        model.Image = Pic;
        model.Kind = int.Parse(Kind);
        model.Intor = Intor;
        model.GetUrl = GetUrl;
        model.Sort = int.Parse(Sort);
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}
