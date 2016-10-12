using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

public partial class Validate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.CacheControl = "no-cache";
        string checkCode = CreateRandomCode(4); //获取验证码
        Session["eyoung-code"] = checkCode;
        CreateImage(checkCode);  
    }

    /// <summary>
    /// 创建验证码图片
    /// </summary>
    /// <param name="checkCode"></param>
    private void CreateImage(string checkCode) {
        Response.ContentType = "image/gif";
        Bitmap bmp = new Bitmap(80,27);
        Graphics grap = Graphics.FromImage(bmp);
        grap.Clear(Color.FromArgb(252, 252, 252));
        SolidBrush drawBrush = new SolidBrush(Color.Black);
        Random random = new Random();
        for (int j = 0; j < 10; j++) {
            Color color = Color.FromArgb(255, 255, 255);
            Pen pen = new Pen(color);
            grap.DrawLine(pen,new Point(40,40),new Point(10,10));
        }
        for (int i = 0; i < checkCode.Length; i++) {
            //Color color = Color.FromArgb(random.Next(150), random.Next(150), random.Next(150));
            StringFormat drawFormat = new StringFormat();
            drawFormat.FormatFlags = StringFormatFlags.NoFontFallback;
            Font font = new Font("宋体", 20, FontStyle.Bold);
            grap.DrawString(checkCode[i] + "",font , drawBrush, i * 15+5, 0, drawFormat);
        }
       
        bmp.Save(Response.OutputStream, ImageFormat.Jpeg);
        grap.Dispose();
        bmp.Dispose();
        Response.End();
    }

    /// <summary>
    /// 生成验证码
    /// </summary>
    /// <param name="codeCount"></param>
    /// <returns></returns>
    private string CreateRandomCode(int codeCount) {
        string temp = "2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,U,V,W,X,Y,Z";
        string[] tempArrat = temp.Split(',');
        string randomCode = string.Empty;
        Random random = new Random();
        for (int i = 0; i < codeCount; i++) {
            randomCode += tempArrat[random.Next(tempArrat.Length)];    
        }
        return randomCode;
    }
}
