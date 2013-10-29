## POST /endpoint

Just a test document


### Request

```
POST /endpoint

{
   "params" : {
      "page" : 1,
      "category" : "technology",
      "limit" : 10
   },
   "method" : "get_entries"
}

```

### Parameters

* `page` - Page number you want to get.
** Isa: Int
** Default: 1
** Optional: 1
* `category` - Category of articles.
** Isa: Str
** Default: 
** Optional: 
* `limit` - Limitation numbers per page.
** Isa: Int
** Default: 20
** Optional: 1

### Response

```
Status: 200

{
   "result" : {
      "message" : "hello"
   }
}

```

