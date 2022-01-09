package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	// open the file
	of, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when opening file: %s", err)
		os.Exit(1)
	}
	defer of.Close()

	lstlen, err := strconv.Atoi(os.Args[2])
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when strconv.Atoi: %s", err)
		os.Exit(1)
	}
	//handle errors while opening
	var sc *bufio.Scanner = bufio.NewScanner(of)
	var i int
	var time []float64
	// read line by line
	for sc.Scan() {
		line := sc.Text()
		if !strings.Contains(line, "file") {
			ret, err := strconv.ParseFloat(line, 64)
			time = append(time, ret)
			if err != nil {
				log.Fatal(err)
			}
			i++
		} else {
			fmt.Println(line, ":average")
		}
		if i == lstlen {
			var total float64
			for i := 0; i < lstlen; i++ {
				total = time[i] + total
			}
			f := total / float64(lstlen)
			fmt.Printf("%.6f\n", f)
			i = 0
		}
	}
	// handle first encountered error while reading
	if err := sc.Err(); err != nil {
		log.Fatalf("Error while reading file: %s", err)
	}
}
