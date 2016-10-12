//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-06 10:10:25

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_Home_HomeNewsUrl_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.HomeNewsUrl bll = new BLL.HomeNewsUrl();
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
            Model.HomeNewsUrl model = bll.GetModelBystrWhere("ID="+ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1012, 4);
            this.Title = Lit_Title.Text = "新闻连接修改";
            txt_Name.Text = model.Name;
            if (!string.IsNullOrEmpty(model.ICON))
            {
                txt_Pic.Text = model.ICON;
                lit_img_Pic.Text = "<img src=\"" + model.ICON + "\" />";
            }
            drpKind.SelectedValue = model.Kind.ToString();
            txt_GetUrl.Text = model.GetUrl;
            txt_Sort.Text = model.Sort.ToString();
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1012, 2);
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
        Model.HomeNewsUrl model = myValidate();
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
            base.AddLog(2, "新闻连接修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model,out i);
            
            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "新闻连接添加，ID为：" + i);
        }

        Response.Redirect("HomeNewsUrl_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.HomeNewsUrl myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string Kind = drpKind.SelectedValue;
        string Sort = txt_Sort.Text.Trim();

        Model.HomeNewsUrl model = new Model.HomeNewsUrl();
        model.Name = Name;
        model.ICON = Pic;
        model.Kind = int.Parse(Kind);
        model.Sort = int.Parse(Sort);
        model.GetUrl = txt_GetUrl.Text;
        
        return model;
    }
}
