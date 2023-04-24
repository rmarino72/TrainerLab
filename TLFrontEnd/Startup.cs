using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json.Serialization;
using Swashbuckle;

using TLServer;
using TLServer.DBManager;
using TLServer.Logging;

namespace TLFrontEnd
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
            Config.BaseDir = configuration.GetValue<string>(WebHostDefaults.ContentRootKey);
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            Config.Name = Configuration.GetValue<string>("Application:Name");
            Config.DisplayName = Configuration.GetValue<string>("Application:DisplayName");
            Config.Version = Configuration.GetValue<string>("Application:Version");
            Config.Session = Configuration.GetValue<int>("Application:Session");

            Config.LogName = Configuration.GetValue<string>("Log:LogName");
            Config.LogPath = Config.BaseDir + Configuration.GetValue<string>("Log:LogPath");
            Config.Debug = Configuration.GetValue<bool>("Log:Debug");
            Config.Verbose = Configuration.GetValue<bool>("Log:Verbose");
            
            Config.DbHost = Configuration.GetValue<string>("DevDatabase:DBHost");
            Config.DbName = Configuration.GetValue<string>("DevDatabase:DBName");
            Config.DbPort = Configuration.GetValue<int>("DevDatabase:DBPort");
            Config.DbUser = Configuration.GetValue<string>("DevDatabase:DBUser");
            Config.DbPassword = Configuration.GetValue<string>("DevDatabase:DBPassword");

            TlLogger.Instance.Info("Starting TrainerLab...");


            Config.DismissTolerance = BoDbInstance.Instance.GetConfig().DismissTolerance;

            services.AddSwaggerGen();

            services.AddControllersWithViews().AddNewtonsoftJson();
            services.AddControllersWithViews();
            services.AddRazorPages();

            services.AddControllers();
            services.AddAuthentication("BasicAuthentication")
                .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

            services
            .AddControllersWithViews()
            .SetCompatibilityVersion(CompatibilityVersion.Version_3_0)
                // Maintain property names during serialization. See:
                // https://github.com/aspnet/Announcements/issues/194
                .AddNewtonsoftJson(options => options.SerializerSettings.ContractResolver = new DefaultContractResolver());
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthentication();
            app.UseAuthorization();

            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
            });

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
                endpoints.MapRazorPages();
            });
        }
    }
}

