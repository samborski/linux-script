# Verifica que distro esta corriendo

Este script verifica si la distro es **Fedora**, **Arch** o **Debian** para poder utilizar algunos de los siguientes comandos: **dnf**, **yay** o **apt**.

```sh
#!/bin/bash

# Detectar la distribución de Linux
if [ -f /etc/fedora-release ]; then
  # Utilizar DNF en Fedora
  PACKAGE_MANAGER="dnf"
elif [ -f /etc/arch-release ]; then
  # Utilizar Yay en Arch Linux
  PACKAGE_MANAGER="yay"
else
  # Utilizar apt en Debian y derivados
  PACKAGE_MANAGER="apt"
fi

# Actualizar todos los paquetes
if [ "$PACKAGE_MANAGER" == "dnf" ]; then
  sudo dnf update -y
elif [ "$PACKAGE_MANAGER" == "yay" ]; then
  yay -Syu
else
  sudo apt update && sudo apt upgrade -y
fi
```

> Se podria agregar mas parámetros y condiciones para lograr mantener el sistema con un solo script:
> update, install, remove, search

Para poder utilizar esto, se llamaria al script de la sigueinte manera:

```bash
miScript install nano
miScript update
miScript remove htop
miScript search neofetch
```

Simplemente, se deberia agergar lo siguiente para recivir parametros:

```sh
# Nombre del paquete
package=$1

# Comprobar si se ha proporcionado un nombre de paquete
if [ -z "$package" ]; then
  echo "Debe proporcionar un nombre de paquete."
  exit 1
fi
```

Otro ejemplo del script, mas completo:

```sh
#!/bin/bash

# Nombre del paquete
package=$1

# Comprobar si se ha proporcionado un nombre de paquete
if [ -z "$package" ]; then
  echo "Debe proporcionar un nombre de paquete."
  exit 1
fi

# Verificar la distribución y elegir el gestor de paquetes adecuado
if [ -x "$(command -v dnf)" ]; then
  # Fedora o derivados de Fedora
  sudo dnf install -y --best --allowerasing $package
elif [ -x "$(command -v pacman)" ]; then
  # Arch o derivados de Arch
  sudo pacman -S --needed $package
elif [ -x "$(command -v pamac)" ] || [ -x "$(command -v yay)" ]; then
  # Distribuciones basadas en Arch con Pamac o Yay
  pamac build --no-confirm $package
elif [ -x "$(command -v apt)" ] || [ -x "$(command -v apt-get)" ] || [ -x "$(command -v aptitude)" ]; then
  # Debian o derivados de Debian
  sudo apt-get install -y --no-install-recommends $package
else
  # Distribución desconocida
  echo "No se reconoce la distribución o el gestor de paquetes."
  exit 1
fi

# Actualizar todos los paquetes
if [ -x "$(command -v dnf)" ]; then
  sudo dnf update -y
elif [ -x "$(command -v pacman)" ]; then
  sudo pacman -Syu
elif [ -x "$(command -v pamac)" ] || [ -x "$(command -v yay)" ]; then
  pamac update
elif [ -x "$(command -v apt)" ] || [ -x "$(command -v apt-get)" ] || [ -x "$(command -v aptitude)" ]; then
  sudo apt update && sudo apt upgrade -y
else
  # Distribución desconocida
  echo "No se reconoce la distribución o el gestor de paquetes."
  exit 1
fi
```

Aqui otro más:

```sh
#!/bin/bash

# Verificar que se haya proporcionado una acción y al menos un paquete
if [ $# -lt 2 ]; then
  echo "Uso: miScript <accion> <paquete1> [paquete2] ... [paqueteN]"
  exit 1
fi

# Verificar la acción
action=$1
if [ "$action" != "install" ] && [ "$action" != "update" ] && [ "$action" != "search" ] && [ "$action" != "remove" ]; then
  echo "Acción desconocida: $action"
  echo "Las acciones permitidas son: install, update, search, remove"
  exit 1
fi
```
