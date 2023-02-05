# Función para comprimir uno o mas archivos

El siguiente script permite comprimir uno, dos o más archivos en diferentes formatos:

```bash
#!/bin/bash

function compress() {
  format=$1
  shift
  files=$@

  case $format in
    zip)
      zip -9 -r "${files[0]}.zip" "${files[@]}"
      ;;
    rar)
      rar a -m5 "${files[0]}.rar" "${files[@]}"
      ;;
    7z)
      7z a -mx=9 "${files[0]}.7z" "${files[@]}"
      ;;
    arj)
      arj a "${files[0]}.arj" "${files[@]}"
      ;;
    gz)
      tar czvf "${files[0]}.tar.gz" "${files[@]}"
      ;;
    bz2)
      tar cjvf "${files[0]}.tar.bz2" "${files[@]}"
      ;;
    *)
      echo "Formato de compresión no soportado"
      ;;
  esac
}

if [ $# -lt 2 ]; then
  echo "Uso: compress (zip|rar|7z|arj|gz|bz2) nombres_archivos.ext | *.*"
else
  format=$1
  shift
  files=$@
  compress $format $files
fi
```

Este script verifica si se han pasado al menos dos argumentos (el formato de compresión y el nombre de archivo o los nombres de archivo). Si se cumplen las condiciones, se llama a la función **compress** pasándole el formato de compresión y los nombres de archivo como argumentos. La función **compress** utiliza el formato de compresión especificado para comprimir los archivos. Si se especifica un formato de compresión que no está soportado, se muestra un mensaje de error.

En la función **compress**, se utiliza la mejor compresión posible para cada formato. Por ejemplo, para el formato **zip**, se utiliza la compresión máxima (**-9**) y se crea un archivo con la extensión **.zip**. Para el formato **rar**, se utiliza una compresión de 5 (**-m5**) y se crea un archivo con la extensión **.rar**. Para el formato **7z**, se utiliza una compresión máxima (**-mx=9**) y se crea un archivo con la extensión **.7z**. Y así sucesivamente para los otros formatos.
