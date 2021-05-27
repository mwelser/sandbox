BLUE   := $(shell tput -Txterm setaf 4)
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)

.PHONY: all test build

all: help

build: swagger
	mkdir -p bin
	go build -o bin/ .

watch:
	air -c .air.conf

test:
	go test -v -race ./...

clean:
	go mod tidy
	go clean
	rm -fr ./bin

swagger:
	swagger generate spec -m -o ./swagger.yml&&swagger serve ./swagger.yml --port=8090


help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@echo "  ${YELLOW}help            ${RESET} ${GREEN}Show this help message${RESET}"
	@echo "  ${YELLOW}build           ${RESET} ${GREEN}Build your project and put the output binary in out/bin/$(BINARY_NAME)${RESET}"
	@echo "  ${YELLOW}swagger         ${RESET} ${GREEN}Build swagger docs${RESET}"
	@echo "  ${YELLOW}watch           ${RESET} ${GREEN}Run the code with cosmtrek/air to have automatic reload on changes${RESET}"
	@echo "  ${YELLOW}test            ${RESET} ${GREEN}Run the tests of the project${RESET}"
	@echo "  ${YELLOW}clean           ${RESET} ${GREEN}Remove build related file${RESET}"
