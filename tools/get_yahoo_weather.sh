#!/bin/bash

#script que usa o curl para pegar dados de uma api de clima

curl -X GET \
  'https://weather-ydn-yql.media.yahoo.com/forecastrss?woeid=455832&u=c&oauth_consumer_key=dj0yJmk9d1p6a3pnNU1qV0lxJmQ9WVdrOU1USjVSbTVETjJVbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PWUz&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1571364497&oauth_nonce=I5QkvBhnUFU&oauth_version=1.0&oauth_signature=AXO/fBrfDGc6vF8TJX6Vr4w/4ic=' \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Host: weather-ydn-yql.media.yahoo.com' \
  -H 'Postman-Token: 822eac1f-8915-4bbb-8778-cf5d3d54dc4f,0f356835-eeb6-46db-84ea-9214c14249d0' \
  -H 'User-Agent: PostmanRuntime/7.18.0' \
  -H 'cache-control: no-cache' | gunzip > ~/.cache/weather.xml
