//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-28 10:03:21

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_Guide_AppointmentComment_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.AppointmentComment bll = new BLL.AppointmentComment();
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
            Model.AppointmentComment model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1003, 4);
            this.Title = Lit_Title.Text = "招生会报名修改";
            txt_Name.Text = model.Name;
            txt_Mobile.Text = model.Mobile;
            txt_City.Text = model.City;
            txt_Age.Text = model.Age;
            txt_Grade.Text = model.Grade;
            txt_AbroadTime.Text = model.AbroadTime;
            txt_DesireSchool1.Text = model.DesireSchool1;
            txt_DesireSchool2.Text = model.DesireSchool2;
            txt_InterviewPlace.Text = model.InterviewPlace;
            txt_GuestNum.Text = model.GuestNum;
            txt_Comment.Text = model.Comment;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
            chk_IsReached.Checked = model.IsReached.Value;
            chk_IsExistingCustomer.Checked = model.IsExistingCustomer.Value;
            if (model.StudentBirthday != null && model.StudentBirthday.Value != null)
            {
                txt_StudentBirthday.Text = model.StudentBirthday.Value.ToString("yyyy-MM-dd");
            }
            txt_StudentName.Text = model.StudentName;
            txt_StudentSex.Text = model.StudentSex;
            txt_FollowUp.Text = model.FollowUp;
	    txt_Channels.Text = model.Channels;
        }
        else
        {
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
        Model.AppointmentComment model = myValidate();
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
            base.AddLog(2, "招生会报名修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "招生会报名添加，ID为：" + i);
        }

        Response.Redirect("AppointmentComment_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.AppointmentComment myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string Mobile = txt_Mobile.Text.Trim();
        string City = txt_City.Text.Trim();
        string Age = txt_Age.Text.Trim();
        string Grade = txt_Grade.Text.Trim();
        string AbroadTime = txt_AbroadTime.Text.Trim();
        string DesireSchool1 = txt_DesireSchool1.Text.Trim();
        string DesireSchool2 = txt_DesireSchool2.Text.Trim();
        string InterviewPlace = txt_InterviewPlace.Text.Trim();
        string GuestNum = txt_GuestNum.Text.Trim();
        string Comment = txt_Comment.Text.Trim();
        bool IsReached = chk_IsReached.Checked;

        Model.AppointmentComment model = new Model.AppointmentComment();
        model.Name = Name;
        model.Mobile = Mobile;
        model.City = City;
        model.Age = Age;
        model.Grade = Grade;
        model.AbroadTime = AbroadTime;
        model.DesireSchool1 = DesireSchool1;
        model.DesireSchool2 = DesireSchool2;
        model.InterviewPlace = InterviewPlace;
        model.GuestNum = GuestNum;
        model.Comment = Comment;
        model.IsReached = IsReached;
        model.IsExistingCustomer = chk_IsExistingCustomer.Checked;
        if (!string.IsNullOrWhiteSpace(txt_StudentBirthday.Text))
        {
            model.StudentBirthday = DateTime.Parse(txt_StudentBirthday.Text);
        }
        else
        {
            model.StudentBirthday = null;
        }
        model.StudentName = txt_StudentName.Text;
        model.StudentSex = txt_StudentSex.Text;
        model.FollowUp = txt_FollowUp.Text;
	model.Channels = txt_Channels.Text;

        return model;
    }
}
