#!/bin/bash

set -ex

# 1: Crear red
docker network create test

# 2: Ejecutar los mocks
docker run --rm -d --hostname mocks --network test --name mocks karate-mocks

# 3: Ejecutar los tests de los mocks
rm -rf target
docker run --name tests --network test karate-tests
docker ps -a
docker cp tests:/target target

# Decomisionar
docker stop mocks
docker rm tests
docker network rm test
