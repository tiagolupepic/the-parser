# The Parser

> Simple parser to index url content.

## Features

- Store content urls and tags
- List urls with contents using pagination


## Requirements

- Ruby 2.3.0
- Postgresql 9.4+


## Installation

Download The Parser source code:

	git clone https://github.com/tiagolupepic/the-parser.git

Enter the directory

   cd the-parser

Then execute:

	bundle install

Copy database.yml and configure `username` and `password`

	cp config/database.yml.sample config/database.yml

Create development database:

	bundle exec rake db:create

Then run migrations:

	bundle exec rake db:migrate

Run it!

	bundle exec notgun -s puma config.ru

The Parser url address is: `http://127.0.0.1:9393`

## Usage

This API have two endpoints to use:

1. GET to list urls
2. POST to parse content and create

####1. GET

You can use cURL to get

```
curl http://127.0.0.1:9393/urls
```

Response (with empty objects):

```json
[{
   "id":"",
   "url":"",
   "h1":[],
   "h2":[],
   "h3":[],
   "links":[]
}
...
]
```


This will list most recent `10` urls on database. You can sent `page` param on request to paginate results.

This request contains information on headers to use pagination on your client.

```
X-Total-Pages:
X-Total-Count:
X-Per-Page:
```

#####1.1 Paging

You can sent `page` param on URL to fetch another list of urls.

```
curl http://127.0.0.1:9393/urls?page=2
```

####2. POST

This endpoint will receive `url` param and fetch content from html.

> **This API accept only valid URLs**
>
> Tags will be parsed: h1, h2, h3 and only valid links (with http or https) and only a valid url is required to store content.


Example with url: `https://regex101.com`

```
curl -H "Content-type: application/json" -X POST -d '{"url":"https://regex101.com"}' http://127.0.0.1:9393/urls
```

Response:

```json
{
   "id":"2ca29a1b-3fb2-4016-adcc-04a8bf2bd71d",
   "url":"https://regex101.com",
   "h1":["regular expressions 101 regex 101"],
   "h2":[],
   "h3":[],
   "links":[
      "https://twitter.com/regex101",
      "https://www.paypal.com/cgi-bin/webscr?cmd=_donations\u0026business=firas%2edib%40gmail%2ecom\u0026lc=US\u0026item_name=Regex101\u0026no_note=0\u0026currency_code=USD\u0026bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHostedGuest",
      "https://github.com/firasdib/Regex101/issues",
      "http://webchat.freenode.net/?nick=regex101-....\u0026channels=regex",
      "http://enable-javascript.com/",
      "https://www.paypal.com/cgi-bin/webscr?cmd=_donations\u0026business=firas%2edib%40gmail%2ecom\u0026lc=US\u0026item_name=Regex101\u0026no_note=0\u0026currency_code=USD\u0026bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHostedGuest"
   ]
}
```

#####2.1 POST with invalid URL

Example with: `google.com`

```
curl -H "Content-type: application/json" -X POST -d '{"url":"google.com"}' http://127.0.0.1:9393/urls
```

Response:

```json
{"errors":["This is not valid URL."]}
```


## Run Tests

First, create a test database:

	DATABASE_ENV=test bundle exec rake db:create

Then run migrations:

	DATABASE_ENV=test bundle exec rake db:migrate

Run tests

	bundle exec rspec

## TODOs

1. Authentication
2. CORS (Javascript)
3. Page links on Headers
4. Sorting ascending and descending sorting with multiple fields

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for your feature.
4. Add your feature.
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2016, Tiago Lupepic
