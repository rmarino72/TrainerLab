using System.Web.Http;
using Swashbuckle.Application;

namespace TrainerLab;

public class SwaggerConfig
{
    public static void Register()
    {
        var thisAssembly = typeof(SwaggerConfig).Assembly;
        GlobalConfiguration.Configuration
            .EnableSwagger(c => c.SingleApiVersion("v1", "Trainer Lab API"))
            .EnableSwaggerUi();
    }
}