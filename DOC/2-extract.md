# Funcion para extraer archivos comprimidos facilemente

Esta es una funcion para extraer archivos comprimidos.

```bash
function extract() {
  for file in "$@"; do
    if [ -f "$file" ] ; then
      case "$file" in
        *.tar.bz2)   tar xvjf "$file"     ;;
        *.tar.gz)    tar xvzf "$file"     ;;
        *.bz2)       bunzip2 "$file"      ;;
        *.rar)       unrar x "$file"      ;;
        *.gz)        gunzip "$file"       ;;
        *.tar)       tar xvf "$file"      ;;
        *.tbz2)      tar xvjf "$file"     ;;
        *.tgz)       tar xvzf "$file"     ;;
        *.zip)       unzip "$file"        ;;
        *.Z)         uncompress "$file"   ;;
        *.7z)        7z x "$file"         ;;
        *)           echo "No se puede descomprimir el archivo $file" ;;
      esac
    else
      echo "$file no existe"
    fi
  done
}
```

Puedes pasar uno, dos o más nombres de archivo como argumentos a la función **extract** y se descomprimirán todos ellos. Además, si se desea descomprimir todos los archivos comprimidos en la carpeta, se puede utilizar el comodín **'*'**

```bash
extract *.tar.gz
```

>Esto descomprimirá todos los archivos comprimidos con el formato **.tar.gz** en la carpeta actual.
