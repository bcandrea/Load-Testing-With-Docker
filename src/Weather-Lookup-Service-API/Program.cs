using System;
using Microsoft.Owin.Hosting;

namespace WeatherLookupServiceAPI
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			const string url = "http://*:9050";

			var consoleCanceler = new ConsoleCanceler();

			try
			{
				using(WebApp.Start<StartUp>(url))
				{
					Console.WriteLine("Weather Lookup Service - Started!!");

					consoleCanceler.WaitForCancel();

					Console.WriteLine("Weather Lookup Service - Stopped!!");
				}
			}
			catch(Exception ex)
			{
				Console.WriteLine(string.Format("Exception occurred on startup {0}", ex));
			}
			finally
			{
				Console.WriteLine("Weather Lookup Service has exited");
			}
		}
	}
}
