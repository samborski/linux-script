#!/bin/bash


# Verificar la distribución y elegir el gestor de paquetes adecuado
if [ -x "$(command -v dnf)" ]; then
  # Fedora o derivados de Fedora
  PACKAGE_MANAGER="dnf"
elif [ -x "$(command -v pacman)" ]; then
  # Arch o derivados de Arch
  PACKAGE_MANAGER="pacman"
elif [ -x "$(command -v pamac)" ] || [ -x "$(command -v yay)" ]; then
  # Distribuciones basadas en Arch con Pamac o Yay
  PACKAGE_MANAGER="pamac"
elif [ -x "$(command -v apt)" ] || [ -x "$(command -v apt-get)" ] || [ -x "$(command -v aptitude)" ]; then
  # Debian o derivados de Debian
  PACKAGE_MANAGER="apt"
else
  # Distribución desconocida
  echo "No se reconoce la distribución o el gestor de paquetes."
  exit 1
fi

echo $PACKAGE_MANAGER