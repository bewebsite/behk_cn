using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
///AjaxResult 的摘要说明
/// </summary>
public class AjaxResult
{
	public AjaxResult()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    private bool _state;
    private string _value;

    /// <summary>
    /// 状态
    /// </summary>
    public bool State
    {
        set { _state = value; }
        get { return _state; }
    }

    /// <summary>
    /// 内容
    /// </summary>
    public string Value
    {
        set { _value = value; }
        get { return _value; }
    }
}