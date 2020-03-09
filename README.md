# nuxt rails boilerplate

* ruby 2.6
* rails 6.0.2.1
* nuxt 2.11.0
* etc...

## requirements

* make
* docker

## setup

### credentials

```sh
make credentials/edit
```

create credentials.yml.enc, master.key and edit database configuration for production.

```
...
database:
  socket: '...'
  database: '...'
  username: '...'
  password: '...'
```

### // FIXME:

grep `FIXME` in this project, and fix your configuration. (e.g. config/database.yml, config/environments/production.rb, ...)

### initialize

```sh
make init
```

## up server

```sh
make up
```

front: http://localhost:43030/

api: http://localhost:43000/api/
