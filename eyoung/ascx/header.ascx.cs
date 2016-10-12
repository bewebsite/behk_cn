using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Text;
using Model.RolePopedom;
using System.Reflection;

public partial class eyoung_ascx_WebUserControl : System.Web.UI.UserControl
{
    //模块属性集合
    private FieldInfo[] fields = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            Model.Admin admin = Session["eyoung"] as Model.Admin;
            this.Lit_UserName.Text = admin.Username;
            loadMenu();
        }
    }
    /// <summary>
    /// 绑定菜单
    /// </summary>
    private void loadMenu()
    {
        fields = typeof(ModulePermission).GetFields();
        StringBuilder sb = new StringBuilder();
        StringBuilder sb2 = new StringBuilder();
        SiteMapNodeCollection list = Comm.CMSiteMapProvider.SiteMapProvider.RootNode.ChildNodes;
        for (int i = 0; i < list.Count; i++)
        {
            string child = getMenuChild(list[i].ChildNodes, list[i].Url, list[i].Title);
            if (!string.IsNullOrEmpty(child))
            {
                string str = "";
                string url = Request.Url.ToString().ToLower();
                if (url.IndexOf(list[i].Url.ToLower()) > 0)
                {
                    str = "class=\"cur\"";
                }
                sb.AppendFormat("<li><a href=\"javascript:void(0)\" {0} data-navjs=\"nav_{1}\">{2}</a> </li>", str, list[i].Url.ToString().Replace("/", ""), list[i].Title);
                sb2.AppendFormat("{0}", child);
            }
        }

        Lit_One.Text = sb.ToString();
        Lit_Two.Text = sb2.ToString();
    }
    /// <summary>
    /// 根据key获取子菜单
    /// </summary>
    /// <returns></returns>
    private string getMenuChild(SiteMapNodeCollection nodes, string url, string title)
    {
        if (nodes == null || nodes.Count < 1)
        {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        ModulePermission model = new ModulePermission();
        for (int i = 0; i < nodes.Count; i++)
        {
            int id = 0;
            foreach (FieldInfo filed in fields)
            {
                if (filed.Name == nodes[i]["menuKey"])
                {
                    id = Convert.ToInt32(filed.GetValue(model));
                    break;
                }
            }

            if (CheckPopedomInfo(id, (int)PermissionEnum.Select))
            {
                string str = "";
                string allurl = Request.Url.ToString().ToLower();
                if (allurl.IndexOf(nodes[i].Description.ToString().ToLower()) > 0)
                {
                    str = "class=\"cur\"";
                }
                sb.AppendFormat("<p><a {2} href=\"{0}\">{1}</a></p></p>", nodes[i].Url, nodes[i].Title, str);
            }
        }

        if (!string.IsNullOrEmpty(sb.ToString()))
        {
            sb.Insert(0, "<dl class=\"nav-list\" id=\"nav_" + url.Replace("/", "") + "\"><dt>" + title + "</dt><dd>");
            sb.Append(" </dd></dl>");
            //string str = "";
            //string allurl = Request.Url.ToString().ToLower();
            //if (allurl.IndexOf(url.ToLower()) > 0)
            //{
            //    str = "style=\"display: block\"";
            //}

            //sb.Insert(0, "<ul class=\"ulDown\" " + str + ">");
            //sb.Append("</ul>");
        }

        return sb.ToString();
    }
    /// <summary>
    /// 检查是否有该权限
    /// </summary>
    protected bool CheckPopedomInfo(int ModuleID, long Role)
    {
        BLL.TPermission bll = new BLL.TPermission();
        Model.TPermission model = bll.GetModelBystrWhere("RoleID=" + (Session["eyoung"] as Model.Admin).RoleID.Value + " and FormID=" + ModuleID);
        if (model == null || (model.Permission.Value & Role) != Role)
        {
            return false;
        }

        return true;
    }
}