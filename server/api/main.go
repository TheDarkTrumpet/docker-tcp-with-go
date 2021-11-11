package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"math/rand"
	"net"
	"net/http"
	"time"
)

var clients []string

func main() {
	rand.Seed(time.Now().Unix())

	fmt.Printf("Calling setupHandlers()\n")
	go setupHandlers()
	fmt.Printf("Calling handleConnection() til finished\n")
	handleConnections()
}

/*****
HTTP API Endpoint Handling
*****/
func setupHandlers() {
	http.HandleFunc("/api/getClients", getClients)
	http.ListenAndServe("localhost:8081", nil)
}

func getClients(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
	w.Header().Set("Content-Type", "application/json")

	json.NewEncoder(w).Encode(clients)
}

/*****
Handle Client Communication
******/
func handleConnections() {
	listener, err := net.Listen("tcp4", ":9999")
	if err != nil {
		fmt.Println(err)
	}
	defer listener.Close()

	for {
		connection, err := listener.Accept()
		if err != nil {
			fmt.Println(err)
			return
		}
		fmt.Printf("!! Got connection from %v!!\n", connection.RemoteAddr().String())
		clients = append(clients, connection.RemoteAddr().String())
		go handleClient(connection)
	}
}

func handleClient(connection net.Conn) {
	for {
		data, err := bufio.NewReader(connection).ReadString('\n')
		if err != nil {
			fmt.Println(err)
			return
		}
		fmt.Printf("%v <= %v: and %v", connection.LocalAddr(), connection.RemoteAddr(), data)

		time.Sleep(time.Duration(rand.Int31n(15)) * time.Second)

		randMessage := fmt.Sprintf("Message! %v\n", rand.Intn(100000))
		fmt.Printf("%v => %v: and %v", connection.LocalAddr(), connection.RemoteAddr(), randMessage)
		connection.Write([]byte(randMessage))
	}
}