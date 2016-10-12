using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            List<Model.News> list = new BLL.News().GetList(0, "ID", "", "");
            foreach (Model.News l in list)
            {
                string html = "";
                List<Model.NewsIntor> alist = new BLL.NewsIntor().GetList(0, "", "NewsId=" + l.ID + "", "Sort desc");
                for (int i = 0; i < alist.Count; i++)
                {

                    html += "<h5 class=\"title\">" + alist[i].Title + "</h5>";
                    if (i == 0 && !string.IsNullOrWhiteSpace(alist[i].Image))
                    {
                        html += "<div style=\"text-align:center\" class=\"img\"><img src=\"" + alist[i].Image + "\"><p class=\"name\">" + alist[i].ImageAlt + "</p></div>";
                    }
                    else
                    {
                        html += "<br/>";
                    }
                    if (!string.IsNullOrWhiteSpace(alist[i].Link))
                    {
                        html += "<div class=\"url\">参考链接：" + alist[i].Link + "</div>";
                    }
                    if (!string.IsNullOrWhiteSpace(alist[i].Intor))
                    {
                        html += "<div class=\"artical-test\"><p>" + alist[i].Intor.Replace("\r\n", "<br/>") + "</p></div>";
                    }
                    html += "<br/>";
                }
                Model.News n = new Model.News();
                n.Content = html;
                new BLL.News().Update(n, "ID=" + l.ID + "");
            }
        }
    }
}