mkdir -p environments/dev environments/staging environments/prod
touch environments/dev/main.tf environments/staging/main.tf environments/prod/main.tf

for dir in environments/*/; do
  echo "Walidacja: $dir"
  cd $dir
  terraform validate
  cd ../..

done