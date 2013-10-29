## POST /endpoint

JSON-RPC like method "get_entries"


### Request

```
POST /endpoint

{
   "params" : {
      "page" : 1,
      "category" : "technology",
      "limit" : 1
   },
   "method" : "get_entries"
}

```

### Parameters

* `page` - Page number you want to get.
  * Isa: Int
  * Default: 1
  * Optional: 1
* `category` - Category of articles.
  * Isa: Str
  * Default: 
  * Optional: 
* `limit` - Limitation numbers per page.
  * Isa: Int
  * Default: 20
  * Optional: 1

### Response

```
Status: 200

{
   "result" : {
      "entries" : [
         {
            "body" : "This is an example.",
            "title" : "Hello"
         }
      ]
   }
}

```

