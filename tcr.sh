#!/bin/bash

fswatch -0 $(git ls-files generator/) --latency=1 | while read -d "" event
do
#    npx elm-test \
    bin/tcr-approve \
      && echo "COMMIT!!!" || echo "REVERT!!!"
    # && git commit -am 'TCR.' || git reset --hard
done
