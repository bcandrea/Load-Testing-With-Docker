using System.Net.Http;
using System;
using System.Threading.Tasks;

namespace WeatherLookupServiceAPI
{
	public class WeatherClient
	{
		private readonly HttpClient _client;

		public WeatherClient(Uri endpoint)
		{
			_client = new HttpClient() {
				BaseAddress = endpoint
			};
		}

		public async Task<HttpResponseMessage> GetWeatherStatus(string uri)
		{
			try
			{
				var result = await _client.GetAsync(uri);

				return result;			
			}
			catch(Exception ex)
			{
				throw ex;
			}
		}
	}
}