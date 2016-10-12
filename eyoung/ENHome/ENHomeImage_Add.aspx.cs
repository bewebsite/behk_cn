//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-09 11:08:36

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_ENHome_ENHomeImage_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.ENHomeImage bll = new BLL.ENHomeImage();
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
            Model.ENHomeImage model = bll.GetModelBystrWhere("ID="+ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1014, 4);
            this.Title = Lit_Title.Text = "照片修改";
            txt_Name.Text = model.Name;
            if (!string.IsNullOrEmpty(model.Image))
            {
                txt_Pic.Text = model.Image;
                lit_img_Pic.Text = "<img src=\"" + model.Image + "\" width=\"320\" />";
            }
            txt_Sort.Text = model.Sort.ToString();
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1014, 2);
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
        Model.ENHomeImage model = myValidate();
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
            base.AddLog(2, "照片修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model,out i);
            
            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "照片添加，ID为：" + i);
        }

        Response.Redirect("ENHomeImage_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.ENHomeImage myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/News/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string Sort = txt_Sort.Text.Trim();

        Model.ENHomeImage model = new Model.ENHomeImage();
        model.Name = Name;
        model.Image = Pic;
        model.Sort = int.Parse(Sort);
        
        return model;
    }
}
