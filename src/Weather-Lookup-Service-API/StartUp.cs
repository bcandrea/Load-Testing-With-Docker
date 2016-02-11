using System;
using Owin;
using WeatherLookupServiceAPI.Middleware;
using Microsoft.Owin;

namespace WeatherLookupServiceAPI
{
	public class StartUp : IDisposable
	{
		private bool _disposed = false;

		public StartUp()
		{
			AppDomain.CurrentDomain.UnhandledException += UnhandledException;	
		}

		public void Configuration(IAppBuilder app)
		{
			app.Use(async (environment, next) => {
				Console.WriteLine("Requesting: " + environment.Request.Path);

				await next();	

				Console.WriteLine("Response: " + environment.Response.StatusCode);
			});

			try
			{
				app.Map("/api/ping", x => x.Use<PingMiddleware>());

				string[] urls = {"/api/weatherstatusforeurope","/api/weatherstatusforasia"};
				app.Map<WeatherMiddleware>(urls);
			}
			catch(Exception ex)
			{
				Console.WriteLine("Exception occurred at startup during configuration", ex);
			}
		}

		private void UnhandledException(object sender, UnhandledExceptionEventArgs e)
		{
			Console.WriteLine((e.ExceptionObject as Exception).Message);
		}

		public void Dispose()
		{
			if(!_disposed)
			{
				AppDomain.CurrentDomain.UnhandledException -= UnhandledException;
			}

			_disposed = true;
		}
	}

	public static class MapExtensions
	{
		public static void Map<T>(this IAppBuilder app, string[] urls)
		{
			foreach(var url in urls)
			{
				app.Map(url, x => x.Use<T>(new WeatherClient(new Uri("http://weather-lookup-service/"))));
			}
		}
	}
}


