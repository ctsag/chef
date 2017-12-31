#!/bin/env bash

readonly COOKBOOK="nothingness"
readonly TEST="test/integration"

status=0

if [ $# -ne 1 ] ; then
    echo "No environment provided. Aborting" >&2
    exit 1
else
    environment="${1}"
fi

echo 'Extracting FQDN :'
knife search "chef_environment:${environment}" 2>&1 | grep 'FQDN:' | tr -d ' ' | cut -d':' -f2
echo 'Extracting recipes :'
knife search "chef_environment:${environment}" 2>&1 | grep 'Recipes:' | tr -d ' ' | cut -d':' -f2- | sed -e "s/${COOKBOOK}:://g" -e "s/^${COOKBOOK},//g" -e 's/,/ /g' -e 's/export-attributes//g'

fqdn=`knife search "chef_environment:${environment}" 2>&1 | grep 'FQDN:' | tr -d ' ' | cut -d':' -f2`
recipes=( `knife search "chef_environment:${environment}" 2>&1 | grep 'Recipes:' | tr -d ' ' | cut -d':' -f2- | sed -e "s/${COOKBOOK}:://g" -e "s/^${COOKBOOK},//g" -e 's/,/ /g' -e 's/export-attributes//g'` )

echo "InSpec tests starting for environment ${environment} on host ${fqdn}"
for recipe in "${recipes[@]}" ; do
    echo "- Running test ${TEST}/${recipe}/${recipe}_test.rb on host ${fqdn}"
    inspec exec ${TEST}/${recipe}/${recipe}_test.rb -t ssh://${fqdn} -i ~/.ssh/id_rsa
    if [ $? -ne 0 ] ; then
        status=1
    fi
done

echo "InSpec tests done. Exit code is ${status}"
exit ${status}