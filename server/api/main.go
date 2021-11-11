package main

import (
	"fmt"
	"net/http"
)

func main() {
	setupHandlers()
}

func setupHandlers() {
	http.HandleFunc("/api/getClients", getClients)
}

func getClients(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "getClients API call")
}