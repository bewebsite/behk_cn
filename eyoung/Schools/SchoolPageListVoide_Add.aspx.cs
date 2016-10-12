﻿//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 10:17:23

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_Schools_SchoolPageListVoide_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.SchoolPageListVoide bll = new BLL.SchoolPageListVoide();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        //But_AsSave.Visible = base.CheckPopedomInfo(1003, 2);
        chk_IsPass.Visible = base.CheckPopedomInfo(1009, 16);//审核
        //chk_IsTop.Visible = base.CheckPopedomInfo(1048, 32);//首页显示
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
            Model.SchoolPageListVoide model = bll.GetModelBystrWhere("ID="+ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1009, 4);
            this.Title = Lit_Title.Text = "学校视频修改";
            txt_Title.Text = model.Title;
            if (!string.IsNullOrEmpty(model.Image))
            {
                txt_Pic.Text = model.Image;
                lit_img_Pic.Text = "<img src=\"" + model.Image + "\" />";
            }
            txt_SchoolName.Text = model.SchoolName;
            txt_GetUrl.Text = model.GetUrl;
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
        Model.SchoolPageListVoide model = myValidate();
        if (model == null)
        {
            return;
        }

        if (ID > 0)
        {
            if (bll.Update(model,"ID="+ID) < 1)
            {
                MessageBox.Show("修改失败");
            }
            base.AddLog(2, "学校视频修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model,out i);
            
            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "学校视频添加，ID为：" + i);
        }

        Response.Redirect("SchoolPageListVoide_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.SchoolPageListVoide myValidate()
    {
        string Title = txt_Title.Text.Trim();
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string SchoolName = txt_SchoolName.Text.Trim();
        string GetUrl = txt_GetUrl.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string AddTime = txt_AddTime.Text.Trim();

        Model.SchoolPageListVoide model = new Model.SchoolPageListVoide();
        model.Title = Title;
        model.Image = Pic;
        model.SchoolName = SchoolName;
        model.GetUrl = GetUrl;
        model.Sort = int.Parse(Sort);
        model.IsPass = IsPass;
        model.AddTime = DateTime.Parse(AddTime);
        
        return model;
    }
}
