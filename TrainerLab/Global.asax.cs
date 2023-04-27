using System;
using System.Web;
using System.Web.Routing;
using System.Web.Http;
using System.Configuration;

using TLServer;

namespace TrainerLab
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Codice eseguito all'avvio dell'applicazione
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            Config.BaseDir = HttpRuntime.AppDomainAppPath; 
            Config.DisplayName = ConfigurationManager.AppSettings.Get("DisplayName");
            Config.LogName = ConfigurationManager.AppSettings.Get("LogName");
            Config.LogPath = ConfigurationManager.AppSettings.Get("LogPath");
            Config.Version = ConfigurationManager.AppSettings.Get("AppVersion");
            Config.Session = int.Parse(ConfigurationManager.AppSettings.Get("Session"));
            Config.Name = ConfigurationManager.AppSettings.Get("AppName");
            Config.Debug = bool.Parse(ConfigurationManager.AppSettings.Get("Debug"));
            Config.Verbose = bool.Parse(ConfigurationManager.AppSettings.Get("Verbose"));
            TLServer.Logging.TlLogger.Instance.Info("Trainer Lab Started!");
        }
        protected void Application_BeginRequest(object source, EventArgs e)
        {

            string host = HttpContext.Current.Request.Url.OriginalString;
            Config.Local = host.Contains("localhost");                        
            Config.DbHost = Config.Local
                ? ConfigurationManager.AppSettings.Get("DevDBHost")
                : ConfigurationManager.AppSettings.Get("ProdDBHost");
            Config.DbName = Config.Local
                ? ConfigurationManager.AppSettings.Get("DevDBName")
                : ConfigurationManager.AppSettings.Get("ProdDBName");
            Config.DbPassword = Config.Local
                ? ConfigurationManager.AppSettings.Get("DevDBPassword")
                : ConfigurationManager.AppSettings.Get("ProdDBPassword");
            Config.DbPort = int.Parse(Config.Local
                ? ConfigurationManager.AppSettings.Get("DevDBPort")
                : ConfigurationManager.AppSettings.Get("ProdDBPort"));
            Config.DbUser = Config.Local
                ? ConfigurationManager.AppSettings.Get("DevDBUser")
                : ConfigurationManager.AppSettings.Get("ProdDBUser");
            

        }
    }
}