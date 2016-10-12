using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/// <summary>
///BaseControl 的摘要说明
/// </summary>
public class BaseControl : System.Web.UI.UserControl
{

    private long _index = 0;
    private long _menu = 0;
    public long Index
    {
        set { this._index = value; }
        get { return this._index; }
    }
    public long Menu
    {
        set { this._menu = value; }
        get { return this._menu; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindData();
        }
    }
    public virtual void BindData()
    {

    }
    public string GetCurr(object i)
    {
        long id = 0;
        if (i != null) long.TryParse(i.ToString(), out id);
        if (id == _index)
            return " class=\"current\" ";
        else
            return "";
    }
    public string GetCurr2(object i)
    {
        long id = 0;
        if (i != null) long.TryParse(i.ToString(), out id);
        if (id == _index)
            return " class=\"cur\" ";
        else
            return "";
    }

    public string GetCurr3(object i)
    {
        long id = 0;
        if (i != null) long.TryParse(i.ToString(), out id);
        if (id == _index)
            return " cur";
        else
            return "";
    }
    public string GetCurr(object i, object j)
    {
        long id = 0;
        if (i != null) long.TryParse(i.ToString(), out id);
        long id2 = 0;
        if (j != null) long.TryParse(j.ToString(), out id2);
        if (id == _index && id2 == _menu)
            return " class=\"default\" ";
        else
            return "";
    }
 
    public string GetDisplay(object o)
    {
        int i = 0;
        if (o != null) int.TryParse(o.ToString(), out i);
        if (i == this._index) return " style='display:block;'";
        else return " style='display:none;'";
    }


}
