#!/bin/bash

NAME=$1
echo "Nazwa projektu: $NAME"
mkdir "$NAME"
cd "$NAME"
touch main.tf variables.tf outputs.tf providers.tf terraform.tfvars
touch README.md
echo "Nazwa projektu: $NAME" > README.md
echo "Projekt jest gotowy"