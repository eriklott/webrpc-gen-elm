# webrpc-gen Elm templates
This repo contains the templates used by the webrpc-gen cli to code-generate webrpc Elm client code.

## Usage
```
webrpc-gen -schema=example.ridl -target=github.com/eriklott/webrpc-gen-elmg@v0.11.0 -module=API -out=./API.elm

# or

webrpc-gen -schema=example.ridl -target=./local-go-templates-on-disk -module=API -out=./API.elm

As you can see, the -target supports default golang, any git URI, or a local folder :)
```

### Set custom template variables
Change any of the following values by passing `-option="Value"` CLI flag to `webrpc-gen`.

| webrpc-gen -option                  | Description                                  | Default value      |
|-------------------------------------|----------------------------------------------|--------------------|
| `-module=<name>`                    | module name                                  | `"Api"`            |
| `-baseurl=<url>`                    | base url for api requests                    | `""`               |
| `-credentials`                      | send credentials with cross-site requests    | false              |
| `-timeout=3000`                     | request timeout duration in milliseconds     | no timeout         |

Example:
```
webrpc-gen -schema=example.ridl -target=github.com/eriklott/webrpc-gen-elmg@v0.11.0 -module=API -baseurl=http://localhost:8080 -credentials -timeout=2000 -out=./API.elm
```

## Tests

```
$ cd tests
$ npm i
$ npm run test
```

## LICENSE

[MIT LICENSE](./LICENSE)