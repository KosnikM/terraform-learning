#!/bin/bash
validate() {
    echo -e "\e[32mRunning terraform validate...\e[0m"
  terraform validate
}
apply() {
    echo -e "\e[32mRunning terraform apply...\e[0m"
    terraform apply
}
plan() {
  echo -e "\e[32mRunning terraform plan...\e[0m"
  terraform plan
}

if [ $# -eq 0 ]; then
  echo "Nie podałeś argumentu!"
  exit 1
fi
NAME=$1
if [ "$1" == "validate" ]; then
    validate
elif [ "$1" == "plan" ]; then
    plan
elif [ "$1" == "apply" ]; then
    apply
else
    echo -e "\e[31m unknown argument...\e[0m"
    exit 1
fi

