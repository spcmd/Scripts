#!/bin/bash
pgrep "$1" > /dev/null || "$@"
