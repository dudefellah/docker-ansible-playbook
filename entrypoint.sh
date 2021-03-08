#!/bin/bash

if [ "$1" = "ansible-playbook" ]; then
    shift 1

    # Don't do anything fancy yet.
    exec ansible-playbook -- "$@"
fi

exec -- "$@"
