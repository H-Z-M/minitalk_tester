package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	lst := []int{10, 100, 1000, 10000, 100000, 200000}
	// lst := []int{1, 10, 100, 1000, 10000, 100000, 200000}
	for i := 0; i < len(lst); i++ {
		fp, err := os.OpenFile(strconv.Itoa(lst[i])+".txt",
			os.O_RDWR|os.O_CREATE|os.O_EXCL, 0664)
		if err != nil {
			fmt.Println(err)
		} else {
			for j := 0; j < lst[i]/5; j++ {
				fp.WriteString("AbcdE")
			}
		}
	}
}
