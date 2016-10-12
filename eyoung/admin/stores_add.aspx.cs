using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model.RolePopedom;
using Comm;
using System.Text;
using System.Collections;

public partial class eyoung_admin_stores_add : AdminPageBase
{
    private int ID = 0;
    private BLL.Stores sbll = new BLL.Stores();
    private List<MModulePermmission> modulelist = null;
    private List<Model.TPermission> tperlist = null;
    private BLL.TPermission perbll = new BLL.TPermission();
    private ModulePermmissionDispose bll = new ModulePermmissionDispose();
    protected void Page_Load(object sender, EventArgs e)
    {
        ID = base.QueryInt("ID");
        if (!IsPostBack)
        {
            loadData();

            modulelist = bll.getList();
            rpList.DataSource = modulelist;
            rpList.DataBind();
        }
    }
    /// <summary>
    /// 获取指定模块的权限
    /// </summary>
    /// <param name="FormID"></param>
    /// <returns></returns>
    protected string getRoleList(object PermmissionList, object moduleid)
    {
        StringBuilder sb = new StringBuilder();
        List<MPermmission> list = PermmissionList as List<MPermmission>;
        if (list != null)
        {
            sb.Append("<li class=\"name-c\"><label><input type=\"checkbox\" /> 全选</label></li><li class=\"name-l\">");
            foreach (MPermmission item in list)
            {
                string chk = "";
                if (tperlist != null)
                {
                    chk = tperlist.Exists(delegate(Model.TPermission model) { return (model.FormID == Convert.ToInt32(moduleid) && (long.Parse(model.Permission.ToString()) & item.ID) == item.ID); }) ? " checked=\"checked\"" : "";
                }
                sb.AppendFormat("<label><input id=\"checkboxs\" name=\"chk_ids\" type=\"checkbox\"{3} value=\"{1}_{2}\" /> {0}</label>", item.Name, moduleid, item.ID, chk);
            }
            sb.Append("</li>");
        }

        return sb.ToString();
    }


    /// <summary>
    /// 加载数据
    /// </summary>
    private void loadData()
    {
        if (ID > 0)
        {
            Model.Stores model = sbll.GetModelBystrWhere("ID=" + ID);
            if (model == null)
            {
                MessageBox.Show("该对象不存在");
            }


            this.Title = Lit_Title.Text = "职位编辑";
            txt_Name.Text = model.Name;
            txt_AddTime.Text = model.AddTime.Value.ToString("yyyy-MM-dd HH:mm:ss");


            tperlist = perbll.GetList(0, "RoleID=" + ID, "RoleID asc");

            But_Save.Visible = base.CheckPopedomInfo(1001, 4);
        }
        else
        {
            But_Save.Visible = base.CheckPopedomInfo(1001, 2);
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
        Model.Stores model = myValidate();
        if (model == null)
        {
            return;
        }
        string PermissionID = getPermission();
        if (ID > 0)
        {
            model.ID = ID;
            int i = sbll.Add(model, PermissionID);
            if (i < 1)
            {
                MessageBox.Show("修改失败");
            }
            base.AddLog(2, "职位修改，ID为：" + i);
        }
        else
        {
            int i = 0;
            sbll.Add(model, out i);
            model.ID = i;
            int x = sbll.Add(model, PermissionID);
            if (x < 1)
            {
                MessageBox.Show("添加失败");
            }
            base.AddLog(1, "职位添加，ID为：" + x);
        }

        Response.Redirect("Stores_List.aspx");
    }

    /// <summary>
    ///  获取选中权限
    /// </summary>
    /// <returns></returns>
    private string getPermission()
    {
        string PermissionID = "";
        string _PermissionID = Request.Form["chk_ids"];
        if (!string.IsNullOrEmpty(_PermissionID))
        {
            Hashtable para = new Hashtable();
            foreach (string item in _PermissionID.Split(','))
            {
                if (para.ContainsKey(item.Split('_')[0]))
                {
                    para[item.Split('_')[0]] = Convert.ToInt64(para[item.Split('_')[0]]) + int.Parse(item.Split('_')[1]);
                }
                else
                {
                    para[item.Split('_')[0]] = int.Parse(item.Split('_')[1]);
                }
            }

            foreach (string key in para.Keys)
            {
                PermissionID += key + "_" + para[key] + ",";
            }
            PermissionID = System.Text.RegularExpressions.Regex.Replace(PermissionID, ",$", "");
        }

        return PermissionID;
    }


    /// <summary>
    /// 验证
    /// </summary>
    /// <returns></returns>
    private Model.Stores myValidate()
    {
        string Name = txt_Name.Text.Trim();
        string AddTime = txt_AddTime.Text.Trim();

        Model.Stores model = new Model.Stores();
        model.Name = Name;
        model.AddTime = DateTime.Parse(AddTime);

        return model;
    }
}