#!/bin/bash

[[ `./hello.sh johnny` = "hello johnny! from master" ]] && (echo "test passed!"; exit 0) || (echo "test failed :-("; exit 1)

