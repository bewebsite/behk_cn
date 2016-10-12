using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using Comm;
using System.Text;

public partial class news_detail : PublicPage
{
    int ID = 0;
    Model.News n = new Model.News();

    public Model.News N
    {
        get { return n; }
        set { n = value; }
    }
    List<Model.NewsIntor> list = new List<Model.NewsIntor>();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        N = new BLL.News().GetModelBystrWhere("ID=" + ID + " and IsPass=1");
        if (N == null)
        {
            MessageBox.Show("新闻不存在");
        }
        list = new BLL.NewsIntor().GetList(0, "", "NewsId=" + ID + "", "Sort desc,ID desc");
        if (!this.IsPostBack)
        {
            if (!string.IsNullOrWhiteSpace(N.PageTitle))
            {
                this.Title = N.PageTitle;
            }
            if (!string.IsNullOrWhiteSpace(N.PageTitle))
            {
                this.Title = N.PageTitle;
            }
            if (!string.IsNullOrWhiteSpace(N.PageTitle))
            {
                this.Title = N.PageTitle;
            }

            repChapter.DataSource = list;
            repChapter.DataBind();
            repChapter2.DataSource = list;
            repChapter2.DataBind();

            Model.News model = new Model.News();
            model.Click = N.Click.Value + 1;
            new BLL.News().Update(model, "ID=" + ID + "");
        }
    }
    public string GetIntor()
    {
        if (list == null || list.Count == 0)
        {
            return "";
        }
        Model.NewsIntor l = list[0];
        StringBuilder sb = new StringBuilder();
        sb.AppendFormat("<h5 class=\"title\">{0}</h5>", l.Title);
        if (!string.IsNullOrWhiteSpace(l.Image))
        {
            System.Drawing.Image image = System.Drawing.Image.FromFile(Server.MapPath(l.Image));
            int width = image.Width;
            int height = image.Height;
            if (width > 640)
            {
                width = 640;
                height = width * image.Height / image.Width;
            }
            sb.AppendFormat("<div class=\"img\" style=\"text-align:center\"><img src=\"{0}\" style=\"width:" + width + "px;height:" + height + "px;\" alt=\"{1}\"><p class=\"name\">{1}</p></div>", l.Image, l.ImageAlt);
        }
        sb.AppendFormat("<div class=\"artical-test\"><p>{0}</p></div>", string.IsNullOrWhiteSpace(l.Intor) ? "" : l.Intor.Replace("\r\n", "<br/>"));
        if (!string.IsNullOrWhiteSpace(l.Link))
        {
            sb.AppendFormat("<div class=\"url\">参考链接：{0}</div>", l.Link);
        }
        if (!string.IsNullOrWhiteSpace(l.Remarks))
        {
            sb.AppendFormat("<div class=\"text\"><i class=\"i\"></i><p>{0}</p></div>", string.IsNullOrWhiteSpace(l.Remarks) ? "" : l.Remarks.Replace("\r\n", "<br/>"));
        }
        return sb.ToString();
    }

    public string GetZhange(object b)
    {
        string[] str = { "一", "二", "三", "四", "五", "六", "七", "八", "九", "十" };
        string[] str2 = { "十", "二十", "三十", "四十", "五十", "六十", "七十", "八十", "九十" };
        int x = int.Parse(b.ToString());
        if (x <= 10)
        {
            int v = x - 1;
            return str[v];
        }
        char[] c = b.ToString().ToCharArray();
        int a1 = int.Parse(c[0].ToString());
        int a2 = int.Parse(c[1].ToString());
        return str2[a1 - 1] + str[a2 - 1];
    }

    public string GetSoure()
    {
        if (!string.IsNullOrWhiteSpace(N.SourceName))
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("<div class=\"artical-b clearfix\"><img src=\"{0}\" />", N.SourePhone);
            sb.AppendFormat("<div class=\"r-intr\"><h4>{0}</h4>", N.SourceName);
            sb.AppendFormat("<h6>{0}</h6>", N.SourePosition);
            sb.AppendFormat("<p class=\"txt\">{0}</p>", string.IsNullOrWhiteSpace(N.SoureIntor) ? "" : N.SoureIntor.Replace("\r\n", "<br/>"));
            sb.AppendFormat("<p class=\"link\"><a>链接 : {0}</a></p></div></div>", N.SoureLink);
            return sb.ToString();
        }
        return "";
    }
}