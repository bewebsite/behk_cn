//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 17:45:49

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_Events_EventsType_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.EventsType bll = new BLL.EventsType();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        chk_IsPass.Visible = base.CheckPopedomInfo(1010, 16);//审核
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
            Model.EventsType model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1010, 4);
            this.Title = Lit_Title.Text = "活动类型修改";
            txt_Name.Text = model.Name;
            chk_IsPass.Checked = model.IsPass.Value;
            txt_Sort.Text = model.Sort.ToString();
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1010, 2);
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
        Model.EventsType model = myValidate();
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
            base.AddLog(2, "活动类型修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "活动类型添加，ID为：" + i);
        }

        Response.Redirect("EventsType_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.EventsType myValidate()
    {
        string Name = txt_Name.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string Sort = txt_Sort.Text.Trim();
        string AddTime = txt_AddTime.Text.Trim();

        Model.EventsType model = new Model.EventsType();
        model.Name = Name;
        model.IsPass = IsPass;
        model.Sort = int.Parse(Sort);
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}
