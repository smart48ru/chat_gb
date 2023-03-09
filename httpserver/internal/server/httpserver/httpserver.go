package httpserver

import (
	"fmt"
	"net/http"
)

func HandleRequest() {
	http.HandleFunc("/", homepage)
	http.ListenAndServe(":8080", nil)
}

func homepage(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "Hello World!")

}
