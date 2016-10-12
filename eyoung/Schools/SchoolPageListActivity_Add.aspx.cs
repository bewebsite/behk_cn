//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 10:17:23

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_Schools_SchoolPageListActivity_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.SchoolPageListActivity bll = new BLL.SchoolPageListActivity();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        chk_IsPass.Visible = base.CheckPopedomInfo(1009, 16);//审核
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
            Model.SchoolPageListActivity model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1009, 4);
            this.Title = Lit_Title.Text = "院校最新活动修改";
            txt_Title.Text = model.Title;
            txt_StarDay.Text = DateTime.Parse(model.StarDay).ToString("yyyy-MM-dd");
            if (model.EndDay != null)
            {
                txt_EndDay.Text = DateTime.Parse(model.EndDay).ToString("yyyy-MM-dd");
            }
            string[] str = model.StarTimer.Split(':');
            txt_StarTimer.Text = str[0];
            txt_StarTimer2.Text = str[1];
            if (!string.IsNullOrWhiteSpace(model.EndTimer))
            {
                string[] str2 = model.EndTimer.Split(':');
                txt_EndTimer.Text = str2[0];
                txt_EndTimer2.Text = str2[1];
            }
            txt_Address.Text = model.Address;
            txt_GetUrl.Text = model.GetUrl;
            txt_Sort.Text = model.Sort.ToString();
            chk_IsPass.Checked = model.IsPass.Value;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1009, 2);
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
        Model.SchoolPageListActivity model = myValidate();
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
            base.AddLog(2, "院校最新活动修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "院校最新活动添加，ID为：" + i);
        }

        Response.Redirect("SchoolPageListActivity_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.SchoolPageListActivity myValidate()
    {
        string Title = txt_Title.Text.Trim();
        string StarDay = txt_StarDay.Text.Trim();
        string EndDay = txt_EndDay.Text.Trim();
        string StarTimer = txt_StarTimer.Text.Trim();
        string StarTimer2 = txt_StarTimer2.Text.Trim();
        if (StarTimer2 == "")
        {
            StarTimer2 = "00";
        }
        else if (int.Parse(StarTimer2) < 10)
        {
            StarTimer2 = "0" + int.Parse(StarTimer2).ToString();
        }
        else
        {
            StarTimer2 = int.Parse(StarTimer2).ToString();
        }
        string EndTimer = txt_EndTimer.Text.Trim();
        string EndTimer2 = txt_EndTimer2.Text.Trim();
        if (EndTimer2 == "")
        {
            EndTimer2 = "00";
        }
        else if (int.Parse(EndTimer2) < 10)
        {
            EndTimer2 = "0" + int.Parse(EndTimer2).ToString();
        }
        else
        {
            EndTimer2 = int.Parse(EndTimer2).ToString();
        }
        string Address = txt_Address.Text.Trim();
        string GetUrl = txt_GetUrl.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string AddTime = txt_AddTime.Text.Trim();

        Model.SchoolPageListActivity model = new Model.SchoolPageListActivity();
        model.Title = Title;
        model.StarDay = StarDay;
        model.EndDay = EndDay;
        model.StarTimer = StarTimer + ":" + StarTimer2;
        if (EndTimer != "")
        {
            model.EndTimer = EndTimer + ":" + EndTimer2;
        }
        else
        {
            model.EndTimer = "";
        }
        model.Address = Address;
        model.GetUrl = GetUrl;
        model.Sort = int.Parse(Sort);
        model.IsPass = IsPass;
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}
