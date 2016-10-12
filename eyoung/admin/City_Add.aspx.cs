//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-05 09:50:49

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class eyoung_admin_City_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.Country bll = new BLL.Country();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        //But_AsSave.Visible = base.CheckPopedomInfo(1003, 2);
        chk_IsPass.Visible = base.CheckPopedomInfo(1007, 16);//审核
        //chk_IsTop.Visible = base.CheckPopedomInfo(1048, 32);//首页显示
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
            Model.Country model = bll.GetModelBystrWhere("ID=" + ID + " and Kind=2");
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1007, 4);
            this.Title = Lit_Title.Text = "相关城市修改";
            txt_Name.Text = model.Name;
            txt_Sort.Text = model.Sort.ToString();
            chk_IsPass.Checked = model.IsPass.Value;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1007, 2);
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
        Model.Country model = myValidate();
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
            base.AddLog(2, "相关城市修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "相关城市添加，ID为：" + i);
        }

        Response.Redirect("City_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Country myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string AddTime = txt_AddTime.Text.Trim();

        Model.Country model = new Model.Country();
        model.Name = Name;
        model.Sort = int.Parse(Sort);
        model.IsPass = IsPass;
        model.Kind = 2;
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}
