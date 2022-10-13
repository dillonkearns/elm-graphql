#!/bin/bash

function doit() {
    bin/tcr-approve \
      && echo "COMMIT!!!" || echo "REVERT!!!"
    # && git commit -am 'TCR.' || git reset --hard
}

doit
fswatch -0 $(git ls-files generator/) --latency=1 | while read -d "" event
do
  doit
done
