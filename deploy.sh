#!/bin/bash
docker pull haritechhub/dev:latest
docker compose down
docker compose up -d
