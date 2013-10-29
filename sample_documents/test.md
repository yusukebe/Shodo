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

### Response

```
Status: 200

{
   "result" : {
      "message" : "hello"
   }
}

```

