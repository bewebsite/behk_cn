using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
public partial class eyoung_seo_systemkeyword_add : AdminPageBase
{
    private string id = null;
    private BSystemKeyword bll = new BSystemKeyword();
    protected void Page_Load(object sender, EventArgs e)
    {
        id = base.QueryString("id");
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
        if (!string.IsNullOrEmpty(id))
        {
            MSystemKeyword model = bll.getModel(id);
            if (model == null)
            {
                MessageBox.Show("该对象不存在");
            }

            But_Save.Enabled = base.CheckPopedomInfo(1002, 4);
            this.Title = this.Lit_Title.Text = "全文关键词修改";
            txt_LookExpression.Text = model.LookExpression;
            txt_Title.Text = model.Title;
            txt_Link.Text = model.Link;
            txt_Ordinal.Text = model.Ordinal.ToString();
        }
        else
        {
            But_Save.Enabled = base.CheckPopedomInfo(1002, 2);
        }
    }

    /// <summary>
    /// 保存
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void but_save_Click(object sender, EventArgs e)
    {
        save();
    }

    /// <summary>
    /// 保存
    /// </summary>
    private void save()
    {
        MSystemKeyword model = myValidate();
        if (model == null)
        {
            return;
        }

        if (!string.IsNullOrEmpty(id))
        {
            model.GID = id;
            bll.Update(model);
            base.AddLog(2, "全文关键词修改，ID：" + id);
        }
        else
        {
            model.GID = Guid.NewGuid().ToString();
            bll.Add(model);
            base.AddLog(1, "全文关键词添加，ID：" + model.GID);
        }

        Response.Redirect("systemkeyword_list.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private MSystemKeyword myValidate()
    {
        string lookexpression = txt_LookExpression.Text.Trim();
        string title = txt_Title.Text.Trim();
        string link = txt_Link.Text.Trim();
        int ordinal = int.Parse(txt_Ordinal.Text.Trim());
        bool newwindow = true;
        bool enable = true;

        MSystemKeyword model = new MSystemKeyword();
        model.LookExpression = lookexpression;
        model.Title = title;
        model.Alt = "";
        model.Link = link;
        model.Ordinal = ordinal;
        model.NewWindow = newwindow;
        model.Enabled = enable;

        return model;
    }
}
