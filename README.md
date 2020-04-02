# Oracle 12c con Docker

Instrucciones y fichero de configuración para arrancar una base de datos Oracle 12c en local mediante Docker.

## Prerrequisitos

1. Instalar [Docker Desktop](https://www.docker.com/products/docker-desktop).
2. Instalar [Oracle SQL Developer](https://www.oracle.com/es/database/technologies/appdev/sql-developer.html) (requiere iniciar sesión con una cuenta de Oracle o crear una nueva si todavía no se dispone de una).
3. Clonar o descargar este repositorio.

## Descarga de la imagen

1. Registrarse en [Docker Hub](https://hub.docker.com).
2. Buscar la imagen oficial de [Oracle Database Enterprise Edition](https://hub.docker.com/_/oracle-database-enterprise-edition).
3. Pulsar en `Proceed to Checkout` para _comprar_ la imagen (es gratis, a cambio de los datos personales, para desarrolladores).

## Iniciar sesión en Docker Hub

1. Hacer click en el icono de Docker en la barra de estado e iniciar sesión con la cuenta de Docker Hub haciendo click en `Sign In / Create Docker ID`.
2. Iniciar sesión con el usuario y contraseña de Docker Hub creado en el apartado anterior.

## Arrancar la base de datos

1. En un terminal, situarse en la carpeta que contiene el fichero `docker-compose.yml`.
2. Iniciar el servicio con el comando `docker-compose up -d`.
3. Cuando haya arrancado (tarda unos minutos) aparecerá `(healthy)` en la salida del comando `docker ps`.

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

![](conexion.png)

## Script para crear usuario

Para crear un usuario _normal_ con el que trabajar, en el fichero [crear_usuario.sql](crear_usuario.sql) hay un script que se puede adaptar y lanzar desde SQL Developer.
