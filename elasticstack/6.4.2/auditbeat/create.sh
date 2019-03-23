#!/bin/bash

if [ "$1" = "clean" ]; then
	docker build --no-cache -t log-auditbeat .
else
	docker build -t log-auditbeat .
fi