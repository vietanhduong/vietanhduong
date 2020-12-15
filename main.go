package main

import (
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
	res, err := http.Get("https://anhdv.dev/api/README.md?fetch=true")
	if err != nil {
		os.Exit(1)
	}
	f, err := os.Create("./README.md")
	if err != nil {
		os.Exit(1)
	}
	defer f.Close()
	bytes, _ := ioutil.ReadAll(res.Body)
	f.Write(bytes)
}
