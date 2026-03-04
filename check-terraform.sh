if which terraform; then
    terraform --version
else
    echo "terraform nie jest zainstalowany"
fi


if [ -f "main.tf" ]; then
    echo "projekt znaleziony"
else
    echo "nie widze projektu"
fi