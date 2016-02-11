using NUnit.Framework;
using Microsoft.Owin.Testing;
using System.Net.Http;

namespace WeatherLookupServiceAPI.Tests
{
	[TestFixture]
	public class PingMiddlewareTests
	{
		[Test]
		public async void ShoudReturnResponseWithPongMessage()
		{
			using (var server = TestServer.Create<StartUp>())
			{
				var request = new HttpRequestMessage (HttpMethod.Get, "api/ping");

				var response = await server.HttpClient.SendAsync(request);

				Assert.That(response, Is.Not.Null);

				var result = await response.Content.ReadAsStringAsync();
				Assert.That(result, Is.EqualTo("pong"));
			}
		}
	}
}
