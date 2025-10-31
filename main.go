package main

import (
	"os"

	"github.com/ComputerScienceHouse/home/server"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

func InitLogger() {
	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stdout})
}

func main() {
	InitLogger()

	if err := server.Serve(); err != nil {
		log.Error().Err(err).Msg("Failed to start server")
	}
}
