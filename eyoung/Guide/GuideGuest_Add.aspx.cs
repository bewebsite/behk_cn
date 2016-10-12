//  上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-30 11:09:28

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;

public partial class _eyoung_Guide_GuideGuest_Add : AdminPageBase
{
    private int ID = 0;
    private BLL.GuideGuest bll = new BLL.GuideGuest();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        chk_IsPass.Visible = base.CheckPopedomInfo(1005, 16);//审核
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
            Model.GuideGuest model = bll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该信息不存在");
            }

            But_Save.Visible = base.CheckPopedomInfo(1005, 4);
            this.Title = Lit_Title.Text = "重磅嘉宾修改";
            txt_Name.Text = model.Name;
            if (!string.IsNullOrEmpty(model.Image))
            {
                txt_Pic.Text = model.Image;
                lit_img_Pic.Text = "<img src=\"" + model.Image + "\" />";
            }
            txt_Position.Text = model.Position;
            txt_Introduction.Text = model.Introduction;
            txt_Highlights.Text = model.Highlights;
            txt_Sort.Text = model.Sort.ToString();
            chk_IsPass.Checked = model.IsPass.Value;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
            txt_En_Name.Text = model.En_Name;
            txt_Cn_Topic.Text = model.Cn_Topic;
            txt_En_Topic.Text = model.En_Topic;

            /*活动*/
            if (!string.IsNullOrWhiteSpace(model.Event))
            {
                List<Model.Events> list = new BLL.Events().GetList(0, "PageTitle,ID", "", "");
                List<Model.Events> alist = new List<Model.Events>();
                foreach (Model.Events l in list)
                {
                    if (model.Event.IndexOf("," + l.ID + ",") >= 0)
                    {
                        this.Lit_EventsList.Text += "<a href='javascript:void(0)' v=" + l.ID + " t=" + l.PageTitle + " onclick='removeEvent(this)' title='点击可移除'>" + l.PageTitle + " X</a>";
                    }
                    else
                    {
                        alist.Add(l);
                    }
                }
                this.drpEvents.DataSource = alist;
                drpEvents.DataBind();
                drpEvents.Items.Insert(0, new ListItem("--活动--", ""));
            }
            else
            {
                drpEvents.DataSource = new BLL.Events().GetList(0, "PageTitle,ID", "", "");
                drpEvents.DataBind();
                drpEvents.Items.Insert(0, new ListItem("--活动--", ""));
            }
            this.Hid_Event.Value = model.Event;

        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1005, 2);
            txt_AddTime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            drpEvents.DataSource = new BLL.Events().GetList(0, "PageTitle,ID", "", "");
            drpEvents.DataBind();
            drpEvents.Items.Insert(0, new ListItem("--活动--", ""));
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
        Model.GuideGuest model = myValidate();
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
            base.AddLog(2, "重磅嘉宾修改，ID为：" + ID);
        }
        else
        {
            int i = 0;
            bll.Add(model, out i);

            if (i < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "重磅嘉宾添加，ID为：" + i);
        }

        Response.Redirect("GuideGuest_List.aspx");
    }

    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.GuideGuest myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string Pic = (new Dispose_Image()).upLoadImage(FileUpload1, "/UploadImage/GuideGuests/");
        if (string.IsNullOrEmpty(Pic))
        {
            Pic = txt_Pic.Text.Trim();
        }
        string Position = txt_Position.Text.Trim();
        string Introduction = txt_Introduction.Text.Trim();
        string Highlights = txt_Highlights.Text.Trim();
        string Sort = txt_Sort.Text.Trim();
        bool IsPass = chk_IsPass.Checked;
        string AddTime = txt_AddTime.Text.Trim();
        string En_Name = txt_En_Name.Text.Trim();
        string Cn_Topic = txt_Cn_Topic.Text.Trim();
        string En_Topic = txt_En_Topic.Text.Trim();

        Model.GuideGuest model = new Model.GuideGuest();
        model.Name = Name;
        model.Image = Pic;
        model.Position = Position;
        model.Introduction = Introduction;
        model.Highlights = Highlights;
        model.Sort = int.Parse(Sort);
        model.IsPass = IsPass;
        model.AddTime = DateTime.Parse(AddTime);
        model.Event = Hid_Event.Value;
        model.En_Name = En_Name;
        model.Cn_Topic = Cn_Topic;
        model.En_Topic = En_Topic;

        return model;
    }
}
