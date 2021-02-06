package api

import (
	"github.com/gin-gonic/gin"
	db "github.com/zakiarsyad/simple-bank/db/sqlc"
)

// Server serves HTTP requests for our banking service
type Server struct {
	store  db.Store
	router *gin.Engine
}

// NewServer creates a new HTTP server ans setup routing
func NewServer(store db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	router.POST("/account", server.createAccount)
	router.GET("/account/:id", server.getAccount)
	router.GET("/account", server.listAccount)

	server.router = router
	return server
}

// Start runs the HTTP server pn a specific address
func (server *Server) Start(addres string) error {
	return server.router.Run(addres)
}

func errorResponse(e error) gin.H {
	return gin.H{"error": e.Error()}
}
