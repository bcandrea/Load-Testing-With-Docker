using System;
using Microsoft.Owin;
using System.Threading.Tasks;

namespace WeatherLookupServiceAPI.Middleware
{
	public class WeatherMiddleware : OwinMiddleware
	{
		readonly WeatherClient _client;

		public WeatherMiddleware(OwinMiddleware next, WeatherClient client)
			: base(next)
		{
			_client = client;
		}

		public override async Task Invoke(IOwinContext context)
		{
			var requestPathSegments = context.Request.Uri.Segments;
			var item = requestPathSegments.Length - 1;
			var uri = string.Format("/{0}" +
				"{1}", requestPathSegments[item-1], requestPathSegments[item]);

			var result = await _client.GetWeatherStatus(uri);

			var content = await result.Content.ReadAsStringAsync();

			await context.Response.WriteAsync(string.Format("Response: {0},\n{1}", result.StatusCode, content));
		}
	}
}