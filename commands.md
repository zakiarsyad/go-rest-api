## create a migration
1. create a migration file
`migrate create -ext sql -dir db/migration -seq init_schema`

2. create the migration script

3. create migration command
`migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5434/simple-bank?sslmode=disable" -verbose up`
`migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5434/simple-bank?sslmode=disable" -verbose down`

## CRUD opration
1. database/sql
- fast & straighforward
- manual mapping to variable
- easy to make mistake, not caught until runtime

2. gorm
- short production code
- different query
- slower

3. sqlx
- fast & easy
- mapping via query text
- failure wont occur until runtime

4. sqlc
- fast & easy
- automatic code generation
- catch sql error before generating codes
- only support postgres atm