using System;
using Owin;
using WeatherLookupServiceAPI.Middleware;

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
				app.Map("/api/weatherstatusforeurope",
					x => x.Use<WeatherMiddleware>(new WeatherClient(new Uri("http://weather-lookup-service/"))));
				app.Map("/api/weatherstatusforasia", x => 
						x.Use<WeatherMiddleware>(new WeatherClient(new Uri("http://weather-lookup-service/"))));
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
}


