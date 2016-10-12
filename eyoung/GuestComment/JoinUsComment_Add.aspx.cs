//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-06 16:14:21

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_GuestComment_JoinUsComment_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.JoinUsComment bll = new BLL.JoinUsComment();
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
            Model.JoinUsComment model = bll.GetModelBystrWhere("ID="+ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1008, 4);
            this.Title = Lit_Title.Text = "加入我们申请修改";
            txt_Name.Text = model.Name;
            txt_CommpanyName.Text = model.CommpanyName;
            txt_Mobile.Text = model.Mobile;
            txt_Email.Text = model.Email;
            txt_Intor.Text = model.Intor;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1008, 2);
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
        Model.JoinUsComment model = myValidate();
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
            base.AddLog(2, "加入我们申请修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model,out i);
            
            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "加入我们申请添加，ID为：" + i);
        }

        Response.Redirect("JoinUsComment_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.JoinUsComment myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string CommpanyName = txt_CommpanyName.Text.Trim();
        string Mobile = txt_Mobile.Text.Trim();
        string Email = txt_Email.Text.Trim();
        string Intor = txt_Intor.Text.Trim();
        string AddTime = txt_AddTime.Text.Trim();

        Model.JoinUsComment model = new Model.JoinUsComment();
        model.Name = Name;
        model.CommpanyName = CommpanyName;
        model.Mobile = Mobile;
        model.Email = Email;
        model.Intor = Intor;
        model.AddTime = DateTime.Parse(AddTime);
        
        return model;
    }
}
