Project name: Module training

Project uses child modules multiple times and create resource group.
This project gave me first experience with modules. Root and child.
Today I learned how to write a modules and use childs multiple times from root module.
Another think what I learn is script writing with instruction verifying how many arguments we give and what it should do when is equal or not.
After today I know what is remote module, what is difference betwen module{} and resource{}

Project structure:
./README.md
./main.tf
./modules
./modules/resource-group
./modules/resource-group/main.tf
./modules/resource-group/outputs.tf
./modules/resource-group/variables.tf
./outputs.tf
./providers.tf
./scripts
./scripts/tf-init.sh
./terraform.tfvars
./variables.tf
