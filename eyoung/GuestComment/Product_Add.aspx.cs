//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-11 16:45:50

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class eyoung_GuestComment_Product_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.GuestComment bll = new BLL.GuestComment();
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
            Model.GuestComment model = bll.GetModelBystrWhere("ID=" + ID + " and Kind=5");
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1008, 4);
            this.Title = Lit_Title.Text = "产品留言详情";
            txt_Name.Text = model.Name;
            txt_Mobile.Text = model.Mobile;
            txt_Email.Text = model.Email;
            txt_City.Text = model.City;
            txt_Age.Text = model.Age;
            txt_Grade.Text = model.Grade;
            txt_AbroadTime.Text = model.AbroadTime;
            txt_GuestNum.Text = model.GuestNum;
            txt_Comment.Text = model.Comment;
            txt_StudentName.Text = model.StudentName;
            txt_StudentSex.Text = model.StudentSex;
            txt_StudentBirthday.Text = model.StudentBirthday.Value.ToString("yyyy-MM-dd");
            txt_FollowUp.Text = model.FollowUp;
            chk_IsReached.Checked = model.IsReached.Value;
            chk_IsExistingCustomer.Checked = model.IsExistingCustomer.Value;
            txt_Title.Text = model.Title;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
            if (!string.IsNullOrWhiteSpace(model.NowPage))
            {
                Lit_Page.Text = "<a href=" + model.NowPage + "  target=\"_blank\">" + model.NowPage + "</a>";
            }
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1008, 2);
            txt_StudentBirthday.Text = DateTime.Now.ToString("yyyy-MM-dd");
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
        Model.GuestComment model = myValidate();
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
            base.AddLog(2, "在线留言修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "在线留言添加，ID为：" + i);
        }

        Response.Redirect("Product_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.GuestComment myValidate()
    {
        string Kind = "5";
        string Title = txt_Title.Text;
        string Name = txt_Name.Text.Trim();
        string Mobile = txt_Mobile.Text.Trim();
        string Email = txt_Email.Text.Trim();
        string City = txt_City.Text.Trim();
        string Age = txt_Age.Text.Trim();
        string Grade = txt_Grade.Text.Trim();
        string AbroadTime = txt_AbroadTime.Text.Trim();
        string GuestNum = txt_GuestNum.Text.Trim();
        string Comment = txt_Comment.Text.Trim();
        string StudentName = txt_StudentName.Text.Trim();
        string StudentSex = txt_StudentSex.Text.Trim();
        string StudentBirthday = txt_StudentBirthday.Text.Trim();
        string FollowUp = txt_FollowUp.Text.Trim();
        bool IsReached = chk_IsReached.Checked;
        bool IsExistingCustomer = chk_IsExistingCustomer.Checked;
        string AddTime = txt_AddTime.Text.Trim();

        Model.GuestComment model = new Model.GuestComment();
        model.Kind = int.Parse(Kind);
        model.Title = Title;
        model.Name = Name;
        model.Mobile = Mobile;
        model.Email = Email;
        model.City = City;
        model.Age = Age;
        model.Grade = Grade;
        model.AbroadTime = AbroadTime;
        model.GuestNum = GuestNum;
        model.Comment = Comment;
        model.StudentName = StudentName;
        model.StudentSex = StudentSex;
        model.StudentBirthday = DateTime.Parse(StudentBirthday);
        model.FollowUp = FollowUp;
        model.IsReached = IsReached;
        model.IsExistingCustomer = IsExistingCustomer;
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}
