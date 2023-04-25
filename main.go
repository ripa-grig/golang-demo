package main

import (
	"fmt"
	"time"

	"github.com/ripa-grig/golang/operators"
	"github.com/ripa-grig/golang/print"
)

func main() {
	fmt.Println("Hello, world.")
	a := []int{7, 12, 3, 4, 5, 26, 7, 8, 9, 10}
	b := []int{7, 1, 13, 8, 11, 17, 25, 8, 13, 10}
	for _, i := range a {
		for _, j := range b {
			z := operators.Average(i, j)
			print.PrintSize(z)
			time.Sleep(3 * time.Second)
		}
	}

}
