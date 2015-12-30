#!/usr/bin/env bash

set -x

(
    (
        cd /vagrant
        sudo nohup python -m SimpleHTTPServer 5000
    ) &
) &
