## POST /endpoint

get_entries


### Request

```
POST /endpoint

{
   "params" : {
      "page" : 1,
      "category" : "technology",
      "limit" : 1
   },
   "jsonrpc" : "2.0",
   "method" : "get_entries",
   "id" : 1
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
   "jsonrpc" : "2.0",
   "id" : 1,
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

