using Newtonsoft.Json;
using System;


    class OrderSimple
    {
        [JsonProperty("productid")]
        public String ProductId { get; set; }

        [JsonProperty("customerid")]
        public String CustomerID { get; set; }
    }

    class PayloadOrderSimple
    {
        [JsonProperty("order")]
        public String order { get; set; }
    }
