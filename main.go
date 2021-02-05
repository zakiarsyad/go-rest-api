package main

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
	"github.com/zakiarsyad/simple-bank/api"
	db "github.com/zakiarsyad/simple-bank/db/sqlc"
)

const (
	dbDriver      = "postgres"
	dbSource      = "postgresql://postgres:postgres@localhost:5555/simple-bank?sslmode=disable"
	serverAddress = "localhost:8888"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
