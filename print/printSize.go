package print

import "log"

func PrintSize(n int) {
	if n < 10 {
		show("SMALL")
	} else {
		show("LARGE")
	}
}

var show = func(v ...interface{}) {
	log.Println(v...)
}
