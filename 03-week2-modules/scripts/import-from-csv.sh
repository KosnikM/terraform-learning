#!/bin/bash

while IFS="," read name id; do
    echo "Nazwa: $name, ID: $id"
    terraform import azurerm_resource_group.$name $id
done < import-from-csv.csv
  



