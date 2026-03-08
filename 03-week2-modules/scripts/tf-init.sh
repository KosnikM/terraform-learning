#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Nie podałeś argumentu!"
  exit 1
fi
NAME=$1
if [ "$1" == "dev" ] || [ "$1" == "staging" ] || [ "$1" == "prod" ]; then
    echo -e "\e[32m Initializing Terraform for ${NAME}...\e[0m"
    terraform init
else
    echo -e "\e[31m error - unknown environment\e[0m"
    exit 1
fi

