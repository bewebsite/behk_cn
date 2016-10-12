using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;


public partial class eyoung_admin_admin_add : AdminPageBase
{
    private int ID = 0;
    private BLL.Admin bll = new BLL.Admin();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        if (!IsPostBack)
        {
            drpKind.DataSource = new BLL.Stores().GetAllList();
            drpKind.DataBind();
            drpKind.Items.Insert(0, new ListItem("--请选择--", ""));
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
            Model.Admin model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该对象不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1001, 4);
            this.Title = Lit_Title.Text = "管理员编辑";
            drpKind.SelectedValue = model.RoleID.ToString();
            txt_Username.Text = model.Username;
            txt_Password.Text = model.Password;
            txt_Realname.Text = model.Realname;
            txt_Email.Text = model.Email;
            chk_IsPass.Checked = model.IsPass.Value;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1001, 2);
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
        Model.Admin model = myValidate();
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
            base.AddLog(2, "管理员修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "管理员添加，ID为：" + i);
        }

        Response.Redirect("Admin_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Admin myValidate()
    {
        string RoleID = drpKind.SelectedValue;
        string Username = txt_Username.Text.Trim();
        string Password = txt_Password.Text.Trim();
        string Realname = txt_Realname.Text.Trim();
        string Email = txt_Email.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string AddTime = txt_AddTime.Text.Trim();

        Model.Admin model = new Model.Admin();
        model.RoleID = int.Parse(RoleID);
        model.Username = Username;
        model.Password = Password;
        model.Realname = Realname;
        model.Email = Email;
        model.IsPass = IsPass;
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }

}