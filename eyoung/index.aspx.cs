using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class _index : PublicPage
{
    private BLL.Admin bll = new BLL.Admin();
    protected void Page_Load(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(this.GetType(), "set_pwd", "var pwd='" + CookiesHelper.GetCookieValue("companylogin") + "';", true);
    }
    /// <summary>
    /// 登录
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void but_login_Click(object sender, EventArgs e)
    {
        string username = txt_UserName.Text.Trim();
        string password = txt_Password.Text.Trim();
        string code = txt_Code.Text.Trim();

        if (code.ToLower() != Session["eyoung-code"].ToString().ToLower())
        {
            MessageBox.Show("验证码错误，请重新输入");
        }

        Model.Admin model = bll.GetModelBystrWhere("Username='" + username + "'");
        if (model == null)
        {
            MessageBox.Show("该用户不存在");
        }
        if (model.Password.ToLower().Trim() != password.ToLower().Trim())
        {
            MessageBox.Show("密码输入错误");
        }
        if (!model.IsPass.Value)
        {
            MessageBox.Show("该帐号已被禁用");
        }
        if (chk_Remember.Checked)
        {
            CookiesHelper.AddCookie("companylogin", model.Username + "+" + model.Password, DateTime.Now.AddDays(30));
        }

        model.Logincount = model.Logincount.Value + 1;
        Session["eyoung"] = model;
        AddLog(model);

        Model.Admin newmodel = new Model.Admin();
        newmodel.Lastloginip = GetIP(this.Context);
        newmodel.Logincount = model.Logincount.Value + 1;
        newmodel.Lastlogintime = DateTime.Now;
        bll.Update(newmodel, "ID=" + model.ID);


        Response.Redirect("default.aspx");
    }

    /// <summary>
    /// 添加登录日志
    /// </summary>
    /// <param name="myuser"></param>
    private void AddLog(Model.Admin myuser)
    {
        Model.AdminLog model = new Model.AdminLog();
        model.UserName = myuser.Username;
        model.OperationTypes = 0;
        model.ODescription = "登录成功";
        model.IP = Request.UserHostAddress.Trim();
        model.AddTime = DateTime.Now;

        new BLL.AdminLog().Add(model);
    }
    public string GetIP(HttpContext hc)
    {
        string ip = string.Empty;

        try
        {
            if (hc.Request.ServerVariables["HTTP_VIA"] != null)
            {
                ip = hc.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
            }
            else
            {

                ip = hc.Request.ServerVariables["REMOTE_ADDR"].ToString();
            }
            if (ip == string.Empty)
            {
                ip = hc.Request.UserHostAddress;
            }
            return ip;
        }
        catch
        {
            return "";
        }
    }
}