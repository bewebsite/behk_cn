//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-09 10:19:30

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_GuestComment_ContantComment_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.ContantComment bll = new BLL.ContantComment();
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
            Model.ContantComment model = bll.GetModelBystrWhere("ID="+ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1008, 4);
            this.Title = Lit_Title.Text = "留言修改";
            txt_Name.Text = model.Name;
            txt_City.Text = model.City;
            txt_Mobile.Text = model.Mobile;
            txt_Email.Text = model.Email;
            txt_GetInfo.Text = model.GetInfo;
            txt_Intor.Text = model.Intor;
            txt_Back.Text = model.Back;
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
        Model.ContantComment model = myValidate();
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
            base.AddLog(2, "留言修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model,out i);
            
            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "留言添加，ID为：" + i);
        }

        Response.Redirect("ContantComment_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.ContantComment myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string City = txt_City.Text.Trim();
        string Mobile = txt_Mobile.Text.Trim();
        string Email = txt_Email.Text.Trim();
        string GetInfo = txt_GetInfo.Text.Trim();
        string Intor = txt_Intor.Text.Trim();
        string Back = txt_Back.Text.Trim();
        string AddTime = txt_AddTime.Text.Trim();

        Model.ContantComment model = new Model.ContantComment();
        model.Name = Name;
        model.City = City;
        model.Mobile = Mobile;
        model.Email = Email;
        model.GetInfo = GetInfo;
        model.Intor = Intor;
        model.Back = Back;
        model.AddTime = DateTime.Parse(AddTime);
        
        return model;
    }
}
