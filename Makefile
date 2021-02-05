postgres:
	docker run --name postgres12 -p 5555:5432 -e POSTGRES_DB=simple-bank -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d postgres:12-alpine

dropdb:
	docker exec -it postgres12 dropdb simple-bank

migrate-up:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5555/simple-bank?sslmode=disable" -verbose up

migrate-down:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5555/simple-bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

start:
	go run main.go

.PHONY: postgres dropdb migrate-up migrate-down sqlc start