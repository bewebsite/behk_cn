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
        chk_IsPass.Visible = base.CheckPopedomInfo(1009, 16);//审核
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
            Model.Banner model = bll.GetModelBystrWhere("ID=" + ID + " and Kind=3");
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1009, 4);
            this.Title = Lit_Title.Text = "广告位修改";
            txt_Name.Text = model.Name;
            txt_GetUrl.Text = model.GetUrl;
            if (!string.IsNullOrEmpty(model.Image))
            {
                txt_Pic.Text = model.Image;
                lit_img_Pic.Text = "<img src=\"" + model.Image + "\" width=\"600\" />";
            }
            txt_Sort.Text = model.Sort.ToString();
            chk_IsPass.Checked = model.IsPass.Value;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1009, 2);
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
        Model.Banner model = myValidate();
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
            base.AddLog(2, "广告位修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "广告位添加，ID为：" + i);
        }

        Response.Redirect("ListBanner_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Banner myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string Kind = "3";
        string Info = "院校检索页广告图";
        string GetUrl = txt_GetUrl.Text.Trim();
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string Sort = txt_Sort.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string AddTime = txt_AddTime.Text.Trim();

        Model.Banner model = new Model.Banner();
        model.Name = Name;
        model.Kind = int.Parse(Kind);
        model.Info = Info;
        model.GetUrl = GetUrl;
        model.Image = Pic;
        model.Sort = int.Parse(Sort);
        model.IsPass = IsPass;
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}
