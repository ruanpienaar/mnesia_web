# mnesia_web
mnesia_web

Getting started

```
$ make
$ ./console.sh
```

Example create

```
$ curl -X POST -d 'tsst' localhost:9876/create/mnesia_web_table/a
```

Example read

```
$ curl -X GET localhost:9876/read/mnesia_web_table/a
```