using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

using Swashbuckle;

using TLServer;
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
            
            Config.DBHost = Configuration.GetValue<string>("LocalDatabase:DBHost");
            Config.DBName = Configuration.GetValue<string>("LocalDatabase:DBName");
            Config.DBPort = Configuration.GetValue<int>("LocalDatabase:DBPort");
            Config.DBUser = Configuration.GetValue<string>("LocalDatabase:DBUser");
            Config.DBPassword = Configuration.GetValue<string>("LocalDatabase:DBPassword");

            TLLogger.Instance.Info("Starting TrainerLab...");

            services.AddSwaggerGen();

            services.AddControllersWithViews().AddNewtonsoftJson();
            services.AddControllersWithViews();
            services.AddRazorPages();

            services.AddControllers();
            services.AddAuthentication("BasicAuthentication")
                .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);
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

