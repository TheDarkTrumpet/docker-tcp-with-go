package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"net"
	"os"
	"time"
)

func main() {
	if len(os.Args) != 3 {
		fmt.Println("Syntax: ./main <host> <port>")
	}

	connHost := fmt.Sprintf("%v:%v", os.Args[1], os.Args[2])

	fmt.Printf("Attempting to connect to %v\n", connHost)

	connection, err := net.Dial("tcp", connHost)
	if err != nil {
		fmt.Println(err)
		return
	}

	for {
		randMessage := fmt.Sprintf("Message! %v\n", rand.Intn(100000))
		fmt.Printf("%v => %v: and %v!", connection.LocalAddr(), connection.RemoteAddr(), randMessage)
		connection.Write([]byte(randMessage))

		time.Sleep(time.Duration(rand.Int31n(15)) * time.Second)

		data, err := bufio.NewReader(connection).ReadString('\n')
		if err != nil {
			fmt.Println(err)
			return
		}
		fmt.Printf("%v <= %v: and %v!", connection.LocalAddr(), connection.RemoteAddr(), data)
	}
}
