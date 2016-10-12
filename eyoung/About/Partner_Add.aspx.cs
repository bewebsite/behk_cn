//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-06 13:18:17

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_About_Partner_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.Partner bll = new BLL.Partner();
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
            Model.Partner model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1013, 4);
            this.Title = Lit_Title.Text = "合作伙伴修改";
            drpKind.SelectedValue = model.Kind.ToString();
            if (!string.IsNullOrEmpty(model.Logo))
            {
                txt_Pic.Text = model.Logo;
                lit_img_Pic.Text = "<img src=\"" + model.Logo + "\" />";
            }
            txt_CNName.Text = model.CNName;
            txt_ENName.Text = model.ENName;
            txt_Sort.Text = model.Sort.ToString();
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
            txt_GetUrl.Text = model.GetUrl;
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1013, 2);
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
        Model.Partner model = myValidate();
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
            base.AddLog(2, "合作伙伴修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "合作伙伴添加，ID为：" + i);
        }

        Response.Redirect("Partner_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Partner myValidate()
    {
        string Kind = drpKind.SelectedValue;
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string CNName = txt_CNName.Text.Trim();
        string ENName = txt_ENName.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        string AddTime = txt_AddTime.Text.Trim();

        Model.Partner model = new Model.Partner();
        model.Kind = int.Parse(Kind);
        model.Logo = Pic;
        model.CNName = CNName;
        model.ENName = ENName;
        model.Sort = int.Parse(Sort);
        model.AddTime = DateTime.Parse(AddTime);
        model.GetUrl = txt_GetUrl.Text;

        return model;
    }
}
