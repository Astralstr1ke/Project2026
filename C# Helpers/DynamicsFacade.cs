using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Net.Http;
using System.Web;
using Newtonsoft.Json.Linq;
using System.Text;
using System.Web.Configuration;
using WebApplication1WebHook.Controllers;
using Newtonsoft.Json;
using System.Threading.Tasks;


namespace WebApplication1WebHook
{
    public class DynamicsFacade
    {

        public async Task CreateCustomer(String name, String email)
        {
            var _token = $"admin:Password";
            var _tokenBase64 = System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(_token));

            HttpClient client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", _tokenBase64);

      

            parameter p = new parameter { name = name, email = email };
            String jsonData = JsonConvert.SerializeObject(p);

            var content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            HttpResponseMessage response = await client.PostAsync("http://test:7048/BC/ODataV4/wordpress_createcustomerws?company=CRONUS%20Danmark%20A%2FS", content);



            string data = "";

            if (response.IsSuccessStatusCode)
            {
                data = await response.Content.ReadAsStringAsync();
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Error");
            }

            System.Diagnostics.Debug.WriteLine("Result: " + data);
        }


        public async Task InsertData(String productId, String CustomerId)
        {
            //l/p
            var _token = $"admin:Password";
            var _tokenBase64 = System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(_token));

            HttpClient client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", _tokenBase64);

            var parameter = new OrderSimple { ProductId = productId, CustomerID = CustomerId };
            String jsonData = JsonConvert.SerializeObject(parameter);

            var inputData = new StringContent(jsonData, Encoding.Unicode, "application/json");

            System.Diagnostics.Debug.WriteLine("json: " + await inputData.ReadAsStringAsync());

            HttpResponseMessage response = await client.PostAsync("http://bc-container:7048/BC/ODataV4/OrderHook_ReceiveWebhook?company=CRONUS%20Danmark%20A%2FS", inputData);

            string data = "";

            if (response.IsSuccessStatusCode)
            {
                data = await response.Content.ReadAsStringAsync();

                System.Diagnostics.Debug.WriteLine("Result: " + data);
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Error: " + response.ReasonPhrase);
            }
        }

    }

    class parameter
    {

        public string name { get; set; }
        public string email { get; set; }

    }
}

    
