#!/bin/bash

docker run --rm -p 8888:80 -v `pwd`/server:/var/www --name dev-server briann/dev-server:latest
