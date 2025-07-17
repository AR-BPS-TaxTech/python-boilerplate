# Python Boilerplate ![status](https://github.com/AR-BPS-TaxTech/python-boilerplate/actions/workflows/app.yml/badge.svg)

- Este repositorio está diseñado para ser usado como punto de partida rápido.
- La versión de Python es 3.12.
- El proyecto tiene configurada una [Github Action](https://github.com/AR-BPS-TaxTech/python-boilerplate/actions) que se ejecuta en cada push a la rama `main`.

## Requisitos

- Necesitas tener [uv](https://docs.astral.sh/uv) instalado.
- Necesitas tener [Make](https://www.gnu.org/software/make/) instalado (detalles debajo).

## Estructura de carpetas

- Hay una carpeta `tests` con los archivos de pruebas.
  - Para agregar nuevas pruebas, por favor sigue las recomendaciones de [pytest](https://docs.pytest.org/en/7.1.x/getting-started.html).
- El código de producción va dentro de la carpeta `src`.
- Dentro de la carpeta `scripts` puedes encontrar los archivos de git hooks.

## Comandos del proyecto

El proyecto usa [Makefiles](https://www.gnu.org/software/make/manual/html_node/Introduction.html) para ejecutar las tareas más comunes:

- `add-package package=XXX`: Instala el paquete XXX en la aplicación, ej: `make install package=requests`.
- `build`: Construye la aplicación.
- `check-format`: Verifica el formato del código.
- `check-lint`: Verifica el estilo del código.
- `check-typing`: Ejecuta un analizador estático sobre el código para encontrar problemas.
- `format`: Formatea el código.
- `lint`: Analiza el código.
- `help` : Muestra esta ayuda.
- `install`: Instala los paquetes de la aplicación.
- `local-setup`: Configura el entorno local (ej: instala git hooks).
- `run`: Ejecuta la aplicación.
- `test`: Ejecuta todas las pruebas.
- `update`: Actualiza los paquetes de la aplicación.
- `watch`: Ejecuta todas las pruebas en modo observación.

**Importante: Por favor ejecuta el comando `make local-setup` antes de comenzar con el código.**

_Para crear un commit tienes que pasar la fase de pre-commit que ejecuta los comandos check y test._

## Paquetes

Este proyecto usa [uv](https://docs.astral.sh/uv) como gestor de paquetes.

### Pruebas

- [pytest](https://docs.pytest.org/en/7.1.x/contents.html): Ejecutor de pruebas.
- [doublex](https://github.com/davidvilla/python-doublex): Framework poderoso de dobles de prueba para Python.
- [expects](https://expects.readthedocs.io/en/stable/): Una librería de aserciones expresiva y extensible para TDD/BDD en Python.
- [doublex-expects](https://github.com/jaimegildesagredo/doublex-expects): Una librería de matchers para la librería de aserciones Expects.

### Estilo de código

- [ty](https://github.com/astral-sh/ty): Un verificador de tipos estático.
- [ruff](https://github.com/astral-sh/ruff): Un linter de Python extremadamente rápido, escrito en Rust.

## Instalación de Make en Windows

1. Descarga el archivo [`make-3.81.exe`](https://sitsa.dl.sourceforge.net/project/gnuwin32/make/3.81/make-3.81.exe?viasf=1).
2. Instálalo desde DRV.
3. Agrega la siguiente ruta a la variable de entorno `PATH` de tu usuario:

  ```
  C:\Program Files (x86)\GnuWin32\bin
  ```

Esto permitirá ejecutar `make` desde la terminal.
