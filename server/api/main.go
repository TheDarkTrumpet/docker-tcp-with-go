package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"net"
	"net/http"
	"time"
)

func main() {
	rand.Seed(time.Now().Unix())

	fmt.Printf("Calling setupHandlers()\n")
	setupHandlers()
	fmt.Printf("Calling handleConnection() til finished\n")
	handleConnections()
}

/*****
HTTP API Endpoint Handling
*****/
func setupHandlers() {
	http.HandleFunc("/api/getClients", getClients)
}

func getClients(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "getClients API call")
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
		fmt.Printf("Got connection from %v\n", connection.RemoteAddr().String())
		fmt.Printf("=> Calling handleClient()")
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

		fmt.Printf("Received %v from %v", data, connection.RemoteAddr())
		time.Sleep(time.Duration(rand.Int31n(15)) * time.Second)

		message := fmt.Sprintf("%v, %v!", connection.RemoteAddr(), rand.Intn(100000))
		connection.Write([]byte(message))
	}
}