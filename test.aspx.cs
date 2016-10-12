using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comm;
using System.Net;
using System.IO;

public partial class test : PublicPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            try {
                HttpRequest request = HttpContext.Current.Request;
                string result = request.ServerVariables["HTTP_X_FORWARDED_FOR"];        
                if (string.IsNullOrEmpty(result)){            
                    result = request.ServerVariables["REMOTE_ADDR"];       
                }        
                if (string.IsNullOrEmpty(result)){            
                    result = request.UserHostAddress;        
                }        
                if (string.IsNullOrEmpty(result)){            
                    result = "0.0.0.0";        
                }  
        
                HttpWebRequest req = (HttpWebRequest)WebRequest.Create("http://ip.taobao.com/service/getIpInfo.php?ip=" + result);
                req.Method = "GET";
                req.ContentType = "application/x-www-form-urlencoded";
                HttpWebResponse response = (HttpWebResponse)req.GetResponse();
                Stream responseStream = response.GetResponseStream();
                StreamReader readStream = new StreamReader(responseStream, System.Text.Encoding.UTF8);
                string retext = readStream.ReadToEnd().ToString();
                readStream.Close();
                lblLocation.Text = retext;
                lblIPAddress.Text = result;
            }

            catch(Exception ex) {
                
            }
            
            
        }
    }
}