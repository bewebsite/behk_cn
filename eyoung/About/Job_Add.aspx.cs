//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-06 15:11:34

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_About_Job_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.Job bll = new BLL.Job();
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
            Model.Job model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1013, 4);
            this.Title = Lit_Title.Text = "招聘信息修改";
            repLan.SelectedValue = model.Lan.ToString();
            txt_Name.Text = model.Name;
            txt_Place.Text = model.Place;
            txt_Manager.Text = model.Manager;
            txt_Report.Text = model.Report;
            txt_Sort.Text = model.Sort.ToString();
            txt_Content.Text = model.Content;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
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
        Model.Job model = myValidate();
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
            base.AddLog(2, "招聘信息修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "招聘信息添加，ID为：" + i);
        }

        Response.Redirect("Job_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Job myValidate()
    {
        string Lan = repLan.SelectedValue;
        string Name = txt_Name.Text.Trim();
        string Place = txt_Place.Text.Trim();
        string Manager = txt_Manager.Text.Trim();
        string Report = txt_Report.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        string Content = txt_Content.Text.Trim();
        string AddTime = txt_AddTime.Text.Trim();

        Model.Job model = new Model.Job();
        model.Lan = int.Parse(Lan);
        model.Name = Name;
        model.Place = Place;
        model.Manager = Manager;
        model.Report = Report;
        model.Sort = int.Parse(Sort);
        model.Content = Content;
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}
