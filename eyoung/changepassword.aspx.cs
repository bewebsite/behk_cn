using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class changepassword : AdminPageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void But_Save_Click(object sender, EventArgs e)
    {
        string oldpassword = txt_OldPassWord.Text;
        string newpassword = txt_NewPassWord.Text;
        Model.Admin admin = Session["eyoung"] as Model.Admin;
        if (admin.Password != oldpassword)
        {
            MessageBox.Show("旧密码不正确，请重新输入");
        }
        Model.Admin model = new Model.Admin();
        model.Password = newpassword;
        int x = new BLL.Admin().Update(model, "ID=" + admin.ID);
        if (x > 0)
        {
            Session.Clear();
            MessageBox.ShowRedirect("密码修改成功，请重新登录", "loginout.aspx");
        }
        else
        {
            MessageBox.Show("系统繁忙，请稍后再试");
        }
    }
}