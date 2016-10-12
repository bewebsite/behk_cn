//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-06 10:55:02

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class eyoung_About_Single_Detail : AdminPageBase
{
    private int ID = 0;
    private BLL.Single bll = new BLL.Single();
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
            Model.Single model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1013, 4);
            this.Title = Lit_Title.Text = model.Name + "页面内容修改";
            txt_Name.Text = model.Name;
            txt_Content.Text = model.Content;
            txt_ENContent.Text = model.ENContent;
        }
        else
        {
            Response.Redirect("Single_List.aspx");
        }
    }

    /// <summary>
    /// 保存
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void But_Save_Click(object sender, EventArgs e)
    {
        Model.Single model = new Model.Single();
        string Content = txt_Content.Text.Trim();
        model.Content = Content;
        model.ENContent = txt_ENContent.Text;
        if (bll.Update(model, "ID=" + ID) < 1)
        {
            MessageBox.Show("修改失败");
        }
        base.AddLog(2, "关于我们单页修改，ID为：" + ID);
        Response.Redirect("Single_List.aspx");
    }

}
