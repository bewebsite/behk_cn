//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-04 17:05:42

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_Home_HomeSchool_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.HomeSchool bll = new BLL.HomeSchool();
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
            Model.HomeSchool model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1012, 4);
            this.Title = Lit_Title.Text = "院校修改";
            txt_CNName.Text = model.CNName;
            txt_ENName.Text = model.ENName;
            drpCountryId.SelectedValue = model.CountryId.ToString();
            drpTypeId.SelectedValue = model.TypeId.ToString();
            if (!string.IsNullOrEmpty(model.Image))
            {
                txt_Pic.Text = model.Image;
                lit_img_Pic.Text = "<img src=\"" + model.Image + "\" width=\"100\" height=\"100\" />";
            }
            txt_GetUrl.Text = model.GetUrl;
            txt_Sort.Text = model.Sort.ToString();
            chk_IsPass.Checked = model.IsPass.Value;
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
        Model.HomeSchool model = myValidate();
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
            base.AddLog(2, "院校修改，ID为：" + ID);
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
        }

        Response.Redirect("HomeSchool_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.HomeSchool myValidate()
    {
        string CNName = txt_CNName.Text.Trim();
        string ENName = txt_ENName.Text.Trim();
        string CountryId = drpCountryId.SelectedValue;
        string TypeId = drpTypeId.SelectedValue;
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string GetUrl = txt_GetUrl.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string AddTime = txt_AddTime.Text.Trim();

        Model.HomeSchool model = new Model.HomeSchool();
        model.CNName = CNName;
        model.ENName = ENName;
        model.CountryId = int.Parse(CountryId);
        model.TypeId = int.Parse(TypeId);
        model.Image = Pic;
        model.GetUrl = GetUrl;
        model.Sort = int.Parse(Sort);
        model.IsPass = IsPass;
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}
