//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-28 12:59:00

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_News_NewsType_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.NewsType bll = new BLL.NewsType();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        chk_IsPass.Visible = base.CheckPopedomInfo(1004, 16);//审核
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
            Model.NewsType model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1004, 4);
            this.Title = Lit_Title.Text = "新闻分类修改";
            txt_HtmlName.Text = model.HtmlName;
            txt_PageTitle.Text = model.PageTitle;
            txt_PageKey.Text = model.PageKey;
            txt_PageDes.Text = model.PageDes;
            txt_Name.Text = model.Name;
            txt_Sort.Text = model.Sort.ToString();
            chk_IsPass.Checked = model.IsPass.Value;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
            t_HtmlName.Value = model.HtmlName;
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1004, 2);
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
        Model.NewsType model = myValidate();
        if (model == null)
        {
            return;
        }

        if (ID > 0)
        {
            string oldHtmlUrl = "/news/" + t_HtmlName.Value + ".shtml";
            string newHtmlUrl = "/news/" + model.HtmlName + ".shtml";
            string url = "/news/default.aspx?ID=" + ID;
            string back = Help.UpdateUrl(oldHtmlUrl, newHtmlUrl, url, "/news/");
            if (back == oldHtmlUrl)
            {
                txt_HtmlName.Text = t_HtmlName.Value;
            }
            else
            {
                txt_HtmlName.Text = back;
            }


            if (bll.Update(model, "ID=" + ID) < 1)
            {
                MessageBox.Show("修改失败");
            }
            base.AddLog(2, "新闻分类修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "新闻分类添加，ID为：" + i);

            string htmlurl = "/news/" + model.HtmlName + ".html";
            string url = "/news/default.aspx?ID=" + i;
            string back = Help.AddUrl(htmlurl, url, "/news/");
            if (back != "")
            {
                Model.NewsType mm = new Model.NewsType();
                mm.HtmlName = back;
                int y = bll.Update(mm, "ID=" + i);
            }
        }

        Response.Redirect("NewsType_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.NewsType myValidate()
    {
        string HtmlName = txt_HtmlName.Text.Trim();
        string PageTitle = txt_PageTitle.Text.Trim();
        string PageKey = txt_PageKey.Text.Trim();
        string PageDes = txt_PageDes.Text.Trim();
        string Name = txt_Name.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string AddTime = txt_AddTime.Text.Trim();

        Model.NewsType model = new Model.NewsType();
        model.HtmlName = HtmlName;
        model.PageTitle = PageTitle;
        model.PageKey = PageKey;
        model.PageDes = PageDes;
        model.Name = Name;
        model.Sort = int.Parse(Sort);
        model.IsPass = IsPass;
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}
