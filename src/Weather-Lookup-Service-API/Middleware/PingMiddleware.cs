using Microsoft.Owin;
using System.Threading.Tasks;

namespace WeatherLookupServiceAPI.Middleware
{
	public class PingMiddleware : OwinMiddleware
	{
		public PingMiddleware(OwinMiddleware next)
			: base(next)
		{
			
		}

		public override async Task Invoke(IOwinContext context)
		{
			await context.Response.WriteAsync("pong");
		}
	}
}

