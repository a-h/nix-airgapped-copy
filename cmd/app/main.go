package main

import (
	"log/slog"
	"net/http"
	"os"
)

func main() {
	log := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	log.Info("Starting server", slog.Int("port", 8080))
	h := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Info("Request received", slog.String("path", r.URL.Path))
		w.Write([]byte("Hello, world!"))
	})
	http.ListenAndServe(":8080", h)
}
