using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;

public partial class eyoung_admin_seo_add : AdminPageBase
{
    private string id = null;
    private BSEO bll = new BSEO();
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
            MSEO model = bll.getModel(id);
            if (model == null)
            {
                MessageBox.Show("该对象不存在");
            }
            But_Save.Enabled = base.CheckPopedomInfo(1002, 4);
            this.Title = this.Lit_Title.Text = "页面关键词修改";
            txt_LookExpression.Text = model.LookExpression.Trim();
            txt_Title.Text = model.PageTitle.Trim();
            txt_Keyword.Text = model.MetaKeywords;
            txt_Description.Text = model.MetaDescription;
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
    /// 另存为
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void but_assave_Click(object sender, EventArgs e)
    {
        id = null;
        save();
    }

    /// <summary>
    /// 保存
    /// </summary>
    private void save()
    {
        MSEO model = myValidate();
        if (model == null)
        {
            return;
        }

        if (!string.IsNullOrEmpty(id))
        {
            model.GID = id;
            bll.Update(model);
            base.AddLog(2, "SEO修改，ID：" + id);
        }
        else
        {
            model.GID = Guid.NewGuid().ToString();
            bll.Add(model);
            base.AddLog(1, "SEO添加，ID：" + model.GID);
        }

        Response.Redirect("seo_list.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private MSEO myValidate()
    {
        string LookExpression = txt_LookExpression.Text.Trim();
        string Title = txt_Title.Text.Trim();
        string Keyword = txt_Keyword.Text.Trim();
        string Description = txt_Description.Text.Trim();
        int Ordinal = int.Parse(txt_Ordinal.Text.Trim());
        bool Enabled = true;

        MSEO model = new MSEO();
        model.LookExpression = LookExpression;
        model.MetaKeywords = Keyword;
        model.PageTitle = Title;
        model.MetaDescription = Description;
        model.Ordinal = Ordinal;
        model.Enabled = Enabled;

        return model;
    }
}