#!/usr/bin/env bash

# Looks at the includes. Runs the tests
# Run this command from the directory where the code is located.


for file in $@
do
    echo $file

    for inc in $(grep include $file | awk '{ print $2 }')
    do
        git checkout $file
        sed -i "" -e "/include $inc/d" $file
        if [ -n $(bundle exec ruby $file 2> /dev/null | grep '\([[:space:]]0[[:space:]]\)failures,\1errors') ]
        then
            # There were no failures
            echo "\tCan remove: $inc"
        fi
        git checkout $file
    done
done
