# Documentación para Ejecutar la Página en tu maquina

**Nota:** Esta documentación está diseñada para sistemas Ubuntu.

## Pasos para Clonar y Ejecutar el Repositorio

1. Clona el repositorio:
   ```bash
   git clone <URL_del_repositorio>
   cd <nombre_del_repositorio>
   sudo apt install ruby-full build-essential zlib1g-dev libv8-node
   gem install bundler
   sudo bundle install
   bundle exec jekyll serve --lsi
   ```

Ahora deberías poder acceder a tu página localmente.
