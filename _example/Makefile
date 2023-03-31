.PHONY: all generate diff

all: generate diff

generate:
	webrpc-gen -schema=test.ridl -target=../ -module=API   -out=./RPC.elm
	
diff:
	git diff --color --ignore-all-space --ignore-blank-lines --exit-code .
