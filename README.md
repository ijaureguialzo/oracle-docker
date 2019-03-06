# Oracle 12c con Docker

Instrucciones y fichero de configuración para arrancar una base de datos Oracle 12c en local mediante Docker.

## Prerrequisitos

1. Instalar [Docker](https://www.docker.com/get-started).
2. Clonar o descargar este repositorio.

## Descarga de la imagen

En el navegador:

1. Registrarse en [Docker Hub](https://hub.docker.com).
2. Buscar la imagen oficial de [Oracle Database Enterprise Edition](https://hub.docker.com/_/oracle-database-enterprise-edition).
3. Pulsar en "Proceed to Checkout" para _comprar_ la imagen (es gratis, a cambio de los datos personales, para desarrolladores).

Desde en un terminal:

4. Iniciar sesión con `docker login` y las credenciales de Docker Hub.
5. Descargar la imagen con `docker pull store/oracle/database-enterprise:12.2.0.1-slim`

## Arrancar la base de datos

1. En un terminal, situarse en la carpeta que contiene el fichero `docker-compose.yml`.
2. Iniciar el servicio con el comando `docker-compose up -d`
3. Cuando haya arrancado (tarda unos minutos) aparecerá `(healthy)` en la salida del comando `docker ps`

## Datos de conexión para SQL Developer

| Clave | Valor |
|---|---|
| Usuario | `sys` |
| Contraseña | `Oradoc_db1` |
| Tipo de conexión | Básico |
| Rol | `SYSDBA` |
| Host | `localhost` |
| Puerto | `1521` |
| SID | `ORCLCDB` |

## Script para crear usuario

Para crear un usuario _normal_ con el que trabajar, en el fichero [crear_usuario.sql](crear_usuario.sql) hay un script que se puede adaptar y lanzar desde SQL Developer.
