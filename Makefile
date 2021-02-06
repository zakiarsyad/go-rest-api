postgres:
	docker run --name postgres12 -p 5555:5432 -e POSTGRES_DB=simple-bank -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d postgres:12-alpine

dropdb:
	docker exec -it postgres12 dropdb simple-bank

migrate-up:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5555/simple-bank?sslmode=disable" -verbose up

migrate-up1:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5555/simple-bank?sslmode=disable" -verbose up 1

migrate-down:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5555/simple-bank?sslmode=disable" -verbose down

migrate-down1:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5555/simple-bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

start:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/zakiarsyad/simple-bank/db/sqlc Store

create-migration:
	@read -p "Enter migration name:" migration; \
	migrate create -ext sql -dir db/migration -seq $$migration

.PHONY: postgres dropdb migrate-up migrate-down sqlc start mock create-migration migrate-up1 migrate-down1