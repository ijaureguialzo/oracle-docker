# Oracle 12c con Docker

## Descarga de la imagen

En el navegador:

1. Registrarse en [Docker Hub](https://hub.docker.com).
2. Buscar la imagen oficial de [Oracle Database Enterprise Edition](https://hub.docker.com/_/oracle-database-enterprise-edition).
3. Pulsar en "Proceed to Checkout" para _comprar_ la imagen (es gratis, a cambio de los datos personales, para desarrolladores).

Desde en un terminal:

4. Iniciar sesión con `docker login` y las credenciales de Docker Hub.
5. Descargar la imagen con `docker pull store/oracle/database-enterprise:12.2.0.1-slim`

## Arrancar la base de datos

1. Levantar el contenedor con:

`docker run -d -it --name oracle12c -p 1521:1521 -v oracle12c_data:/ORCL store/oracle/database-enterprise:12.2.0.1-slim`

2. Cuando haya arrancado (tarda unos minutos) aparecerá `(healthy)` en la salida de `docker ps` 

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
