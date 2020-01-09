## Web DNS
The Web DNS is a sample project which makes possible to sent DNS entries by passing an IP address and its related hostnames. Also, it is possible to query all the entries in a paginated way, being possible to apply some inclusion and exclusion filters. This sample is part of the Intricately challenge, following [this API documentation](https://redocly.github.io/redoc/?url=https://bitbucket.org/cloudrupt/openapi-specs/raw/master/api_challange.yml).

### Architectural overview

In this project, I basically created two entities: `DNSRecord` and `RelatedHostname`, and related them by using a `has_and_belongs_to_many` relation, in that case is possible to relate one `DNSRecord` to Many `RelatedHostnames`, and also a `RelatedHostname` can belongs to many `DNSRecords`. To make possible accepts nested attributes for `RelatedHostnames` in the request, since we have a join table between theese two entities, I used a Builder approach when creating the entries, so it is possible assign new `DNSRecords` to already existing `RelatedHostnames` without duplicating the current entries and making it unique. To make this project as much simple as possible, I've not added a way to update `DNSRecords` by sending new POSTs or PUTs, also because it is not defined in the challenge requirements.

> For this project, I've used Ruby on rails 5.2.4, mysql 5.7 and some basic gems(e.g: jbuilder, rspec, etc...)

### Running the system locally

To run this project, you gonna need to have `Docker` and `docker-compose` installed in your system. Then, you just gonna need to run the following command in your machine:

```
walter in ~/Workspace/web_dns (master ✔) ➜  docker-compose up -d
Building app
Step 1/10 : FROM ruby:2.6.3
2.6.3: Pulling from library/ruby
4ae16bd47783: Pull complete
bbab4ec87ac4: Pull complete
2ea1f7804402: Pull complete
96465440c208: Pull complete
6ac892e64b94: Pull complete
1f85508cf3dd: Pull complete

(...)
```

So, the two base images(ruby 2.6.3 and mysql 5.7) gonna be pulled from upstream to your local docker images repository, and the next steps of the system building gonna be performed. After that you can see the services being started:

```
walter in ~/Workspace/web_dns (master ✔) ➜  docker-compose up -d

(...)


Starting webdns_mysql_1 ... 
Starting webdns_mysql_1 ... done
Starting webdns_app_1 ... 
Starting webdns_app_1 ... done

walter in ~/Workspace/web_dns (master ✔) ➜  docker ps
CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS                    PORTS                                                                                        NAMES
ca055c051862        webdns_app                  "bash -c 'rm -f tmp/…"   19 minutes ago      Up 14 minutes             0.0.0.0:3000->3000/tcp                                                                       webdns_app_1
c03f5b2fb28c        mysql:5.7                   "docker-entrypoint.s…"   22 minutes ago      Up 14 minutes             0.0.0.0:3306->3306/tcp, 33060/tcp                                                            webdns_mysql_1
```

At this point, you gonna be able to perform curl commands to the app:
```
walter in ~/Workspace/web_dns (master ✔) ➜  curl -k -d '{"dns_records":{"ip":"1.1.1.2", "hostnames_attributes": [{"hostname": "lorem.ipsum"}]}}' -H "Content-Type: application/json" -X POST localhost:3000/dns_records
{"id":1}⏎

walter in ~/Workspace/web_dns (master ✔) ➜  curl -k -d '{"dns_records":{"ip":"1.1.1.3", "hostnames_attributes": [{"hostname": "lorem.ipsum"}, {"hostname":"localhost.com"}]}}' -H "Content-Type: application/json" -X POST localhost:3000/dns_records
{"id":2}⏎ 
```
And also perform some query(GET) commands:

```
walter in ~/Workspace/web_dns (master ✔) ➜  curl 'localhost:3000/dns_records?page=1'
{"dns_records":{"total_records":2,"records":[{"id":1,"ip_address":"1.1.1.2"},{"id":2,"ip_address":"1.1.1.3"}],"related_hostnames":[{"hostname":"lorem.ipsum","count":2},{"hostname":"localhost.com","count":1}]}}⏎  
```

If you want, you can apply an include filter:

```
walter in ~/Workspace/web_dns (master ✔) ➜  curl 'localhost:3000/dns_records?page=1&included=localhost.com'
{"dns_records":{"total_records":1,"records":[{"id":2,"ip_address":"1.1.1.3"}],"related_hostnames":[{"hostname":"localhost.com","count":1}]}}⏎                      
```

And also, an exclusion filter:

```
walter in ~/Workspace/web_dns (master ✔) ➜  curl 'localhost:3000/dns_records?page=1&included=localhost.com'
{"dns_records":{"total_records":1,"records":[{"id":2,"ip_address":"1.1.1.3"}],"related_hostnames":[{"hostname":"localhost.com","count":1}]}}⏎ 
```

Whether you would like to pass more than one data in the included/excluded params, you can send it divided by comma:

```
walter in ~/Workspace/web_dns (master ✔) ➜  
curl 'localhost:3000/dns_records?page=1&excluded=localhost.com,lorem.ipsum'
{"dns_records":{"total_records":0,"records":[],"related_hostnames":[]}}⏎ 

walter in ~/Workspace/web_dns (master ✔) ➜  
curl 'localhost:3000/dns_records?page=1&included=localhost.com,lorem.ipsum'
{"dns_records":{"total_records":2,"records":[{"id":1,"ip_address":"1.1.1.2"},{"id":2,"ip_address":"1.1.1.3"}],"related_hostnames":[{"hostname":"lorem.ipsum","count":2},{"hostname":"localhost.com","count":1}]}}⏎
```

### Running the automated tests

To run the automated tests, you just need to use the docker-compose exec command:

```
walter in ~/Workspace/web_dns (master ✔) ➜  docker-compose exec app bundle exec rspec
...........................

Finished in 0.5805 seconds (files took 0.52092 seconds to load)
27 examples, 0 failures
```

