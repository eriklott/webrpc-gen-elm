#!/bin/bash

export PORT=9988

webrpc-test -version
webrpc-test -print-schema > ./test.ridl
webrpc-gen -schema=./test.ridl -target=../ -out=./src/Api.elm -module=Api
elm make ./src/Main.elm --output=./dist/index.html

npx http-server -p 8080 -P http://localhost:9988 ./dist &
webrpc-test -server -port=9988 -timeout=30s &

# Wait until http://localhost:$PORT is available, up to 10s.
for (( i=0; i<100; i++ )); do nc -z localhost 8080 && break || sleep 0.1; done
for (( i=0; i<100; i++ )); do nc -z localhost 9988 && break || sleep 0.1; done

# npm run elm-test
npx cypress run