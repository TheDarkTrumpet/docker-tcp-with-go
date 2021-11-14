package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"math/rand"
	"net"
	"net/http"
	"strings"
	"time"
)

var clients []string
var serverLog []string

func main() {
	rand.Seed(time.Now().Unix())

	logAndPrint("Calling setupHandlers()")
	go setupHandlers()
	logAndPrint("Calling handleConnection() til finished")
	handleConnections()
}

/*****
HTTP API Endpoint Handling
*****/
func setupHandlers() {
	http.HandleFunc("/api/getClients", getClients)
	http.HandleFunc("/api/getLogs", getLogs)
	http.ListenAndServe("localhost:8081", nil)
}

type nodeAndEdge struct {
	nodes []map[string]string
	edges []map[string]string
}
func getClients(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
	w.Header().Set("Content-Type", "application/json")

	var nodes []map[string]string
	var edges []map[string]string
	nodes = append(nodes, map[string]string{ "id": "1", "label": "Server"})
	for index, value := range clients {
		nodes = append(nodes, map[string]string{ "id": string(index + 1), "label": value})
		edges = append(edges, map[string]string{ "id": "1", "from": "1", "to": string(index + 1)})
	}
	nodesAndEdges := nodeAndEdge{edges: edges, nodes: nodes}
	json.NewEncoder(w).Encode(nodesAndEdges)
}

func getLogs(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
	w.Header().Set("Content-Type", "application/json")

	json.NewEncoder(w).Encode(serverLog)
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
		logAndPrint(fmt.Sprintf("!! Got connection from %v!!\n", connection.RemoteAddr().String()))
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
		logAndPrint(fmt.Sprintf("%v <= %v: and %v", connection.LocalAddr(), connection.RemoteAddr(), data))

		time.Sleep(time.Duration(rand.Int31n(15)) * time.Second)

		randMessage := fmt.Sprintf("Message! %v\n", rand.Intn(100000))
		logAndPrint(fmt.Sprintf("%v => %v: and %v", connection.LocalAddr(), connection.RemoteAddr(), randMessage))
		connection.Write([]byte(randMessage))
	}
}

func logAndPrint(logMessage string) {
	serverLog = append(serverLog, logMessage)

	logMessage = strings.Trim(logMessage, "\n")
	if len(serverLog) > 100{
		serverLog = serverLog[1:101]
	}

	fmt.Println(logMessage)
}