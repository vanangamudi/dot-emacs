#!/bin/bash
set -euo pipefail

emacsclient --create-frame \
            #--socket-name "capture" \
            --alternate-editor="" \
            --frame-parameters="(quote (name . \"capture\"))" \
            --no-wait \
            --eval "(my/org-capture-frame)"
