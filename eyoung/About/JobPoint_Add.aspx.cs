//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-06 15:57:46

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_About_JobPoint_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.JobPoint bll = new BLL.JobPoint();
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
            Model.JobPoint model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1013, 4);
            this.Title = Lit_Title.Text = "评价修改";
            repLan.DataSource = model.Lan.ToString();
            txt_Title.Text = model.Title;
            txt_Name.Text = model.Name;
            txt_Intor.Text = model.Intor;
            txt_Sort.Text = model.Sort.ToString();
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1013, 2);
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
        Model.JobPoint model = myValidate();
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
            base.AddLog(2, "评价修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "评价添加，ID为：" + i);
        }

        Response.Redirect("JobPoint_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.JobPoint myValidate()
    {
        string Lan = repLan.SelectedValue;
        string Title = txt_Title.Text.Trim();
        string Name = txt_Name.Text.Trim();
        string Intor = txt_Intor.Text.Trim();
        string Sort = txt_Sort.Text.Trim();

        Model.JobPoint model = new Model.JobPoint();
        model.Lan = int.Parse(Lan);
        model.Title = Title;
        model.Name = Name;
        model.Intor = Intor;
        model.Sort = int.Parse(Sort);

        return model;
    }
}
