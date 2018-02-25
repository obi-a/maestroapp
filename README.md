== README

First time setup: Build the containers
```
docker-compose -f docker-compose.dev.yml build
```

Run Rake db migrate

```
 docker-compose -f docker-compose.dev.yml run \
  --entrypoint "bundle exec rake db:migrate" \
  --rm  maestroapp
```

Start the containers:
```
docker-compose -f docker-compose.dev.yml up -d
```



Access Rails console:

```
 docker-compose -f docker-compose.dev.yml run \
  --entrypoint "bundle exec rails c" \
  --rm  maestroapp
```