using Microsoft.AspNet.WebHooks;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;

namespace WebApplication1WebHook
{
    public class GenericJsonWebHookHandler : WebHookHandler
    {
        public GenericJsonWebHookHandler()
        {
            this.Receiver = "genericjson";
        }

        public override Task ExecuteAsync( string receiver, WebHookHandlerContext context)
        {
            //// Get JSON from WebHook
            JObject data = context.GetDataOrDefault<JObject>();

            try { 
                String topic = context.Request.Headers.GetValues("X-WC-Webhook-Topic").First();
                String eventType = context.Request.Headers.GetValues("x-wc-webhook-event").First();

                dynamic dData = data;
                string CustomerID = dData.CustomerID;
                string ProductId = dData.ProductId;


                if (topic.ToLower().Equals("customer.created"))
                {
                    DynamicsFacade dynamicsFacade = new DynamicsFacade();
                    dynamicsFacade.InsertData(ProductId, CustomerID);
                }

            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            }


            System.Diagnostics.Debug.WriteLine("Called1-----------------------");

            System.Diagnostics.Debug.WriteLine("test: " + data.ToString());

            System.Diagnostics.Debug.WriteLine("Time: " + DateTime.Now.TimeOfDay.ToString());

            return Task.FromResult(HttpStatusCode.OK);
        }
    }
}