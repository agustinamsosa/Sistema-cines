# Sistema de Gestión de Cines

## 1. Descripción del proyecto

El presente proyecto consiste en el diseño e implementación de una base de datos relacional destinada a la gestión de un sistema de cines. La solución fue desarrollada utilizando PostgreSQL y tiene como finalidad representar, administrar, centralizar y organizar la información y  las principales operaciones relacionadas con la gestión de sucursales, salas, películas, funciones y venta de entradas.

Además del almacenamiento de información, se incorporan mecanismos destinados a garantizar la integridad y consistencia de los datos, automatizar determinadas reglas de negocio y facilitar el análisis de la información mediante consultas SQL.

El proyecto está orientado a la aplicación práctica de conceptos de bases de datos relacionales, incluyendo modelado de datos, claves primarias y foráneas, restricciones de integridad, funciones almacenadas, triggers, auditoría e índices.

---

## 2. Objetivo

El objetivo principal es desarrollar una base de datos relacional que permita representar las operaciones fundamentales de una cadena de cines y mantener la información de manera consistente.

La solución busca permitir la administración de las diferentes sucursales, sus salas y butacas, la programación de funciones cinematográficas, el registro de entradas vendidas y la gestión de medios de pago y promociones.

A su vez, se implementan mecanismos de control a nivel de base de datos para evitar situaciones inconsistentes y automatizar determinados procesos, como el cálculo de descuentos, el control de capacidad de las salas y la validación de horarios.

Finalmente, se incorporan consultas orientadas al análisis de la información, permitiendo obtener indicadores relacionados con la recaudación, ocupación, promociones, empleados y funciones.

---

## 3. Alcance

El sistema contempla la gestión de diferentes aspectos relacionados con la operación de un sistema de cines.

En cuanto a la infraestructura, se registran las distintas sucursales, las salas disponibles en cada cine y las butacas correspondientes a cada sala.

Respecto de la programación, se registran las películas disponibles y se generan funciones indicando la película que será proyectada, la sala, la fecha y el horario.

En relación con las ventas, cada entrada permite registrar la butaca seleccionada, la función correspondiente, el empleado que realizó la operación, el medio de pago utilizado, la promoción aplicada y el importe final.

El sistema también contempla la gestión de promociones y descuentos, junto con un mecanismo de auditoría que permite registrar modificaciones realizadas sobre los porcentajes de descuento.

Finalmente, se incorporan consultas destinadas al análisis de la información almacenada y se agregan índices para optimizar determinadas operaciones de consulta.

---

## 4. Modelo de datos

El modelo relacional está compuesto por entidades que representan los principales elementos involucrados en la gestión de un cine.

### Cine

La tabla `cine` almacena la información correspondiente a cada sucursal, incluyendo su código, nombre, dirección, ciudad, teléfono y correo electrónico.

Cada cine puede contar con una o varias salas y empleados asociados.

### Película

La tabla `pelicula` contiene la información de las producciones cinematográficas disponibles.

Entre los datos registrados se encuentran el código, título, director, actores, productora, argumento y género.

### Sala

La tabla `sala` representa los espacios físicos disponibles dentro de cada cine.

Cada sala pertenece a un cine y posee un código que debe ser único dentro de dicha sucursal.

### Butaca

La tabla `butaca` representa los asientos disponibles dentro de cada sala.

Cada butaca posee una fila y un número de asiento. La combinación de asiento, fila y sala permite evitar la existencia de butacas duplicadas dentro de una misma sala.

### Función

La tabla `funcion` relaciona una película con una sala en una fecha y horario determinados.

Además, se establece una restricción que evita programar dos funciones diferentes en la misma sala y horario.

### Entrada

La tabla `entrada` representa las entradas vendidas para las funciones.

Cada registro contiene información sobre la butaca seleccionada, la función, el empleado responsable de la venta, el medio de pago, la promoción aplicada y el importe correspondiente.

También se establece una restricción que impide vender una misma butaca dos veces para una misma función.

### Empleado

La tabla `empleado` contiene la información de los empleados que trabajan en las diferentes sucursales.

Cada empleado se encuentra asociado a un cine determinado.

### Medio de pago

La tabla `medio_pago` registra los diferentes medios disponibles para realizar el pago de una entrada.

### Promoción

La tabla `promocion` almacena las promociones disponibles y el porcentaje de descuento asociado a cada una.

---

## 5. Reglas de negocio implementadas

Las principales reglas de negocio se implementan directamente en la base de datos mediante restricciones, funciones y triggers.

### Capacidad de las salas

La cantidad de entradas vendidas para una función no puede superar la cantidad real de butacas disponibles en la sala correspondiente.

La capacidad se obtiene a partir de las butacas registradas en la tabla `butaca`.

### Correspondencia entre butaca y sala

Una entrada solamente puede utilizar una butaca perteneciente a la misma sala donde se desarrolla la función.

Esta validación se realiza mediante un trigger.

### Venta única de una butaca

Una misma butaca no puede ser vendida dos veces para una misma función.

### Separación horaria de funciones

No se permite programar funciones en una misma sala con una diferencia inferior a tres horas.

Esta regla se implementa mediante un trigger que controla las funciones existentes antes de insertar una nueva programación.

### Aplicación de promociones

Cuando una entrada posee una promoción, el importe final se calcula automáticamente aplicando el porcentaje de descuento correspondiente.

### Auditoría de promociones

Cuando se modifica el porcentaje de descuento de una promoción, se genera un registro en la tabla `auditoria_promocion`.

La auditoría almacena el porcentaje anterior, el nuevo porcentaje, la promoción modificada, la fecha de modificación y el usuario que realizó la operación.

---

## 6. Triggers y funciones

El proyecto utiliza funciones y triggers destinados a automatizar validaciones y procesos.

Se desarrollaron cinco triggers principales:

### Validación de capacidad

Controla que una función no supere la cantidad máxima de butacas disponibles.

### Validación de butaca

Comprueba que la butaca seleccionada pertenezca a la sala donde se desarrolla la función.

### Auditoría de promociones

Registra las modificaciones realizadas sobre el porcentaje de descuento de las promociones.

### Cálculo automático del importe

Calcula el importe final de una entrada teniendo en cuenta la promoción seleccionada.

### Restricción horaria

Controla que no existan funciones demasiado próximas en una misma sala.

---

## 7. Consultas y reportes

El archivo `04_queries.sql` contiene consultas destinadas al análisis de la información almacenada en la base de datos.

Entre los análisis realizados se encuentran:

* Recaudación por cine y medio de pago.
* Ocupación y porcentaje de capacidad por función.
* Desempeño de ventas por empleado.
* Películas con facturación superior al promedio.
* Recaudación por género.
* Utilización de promociones.
* Funciones con mayor recaudación.
* Películas sin funciones programadas.
* Recaudación total por cine.
* Recaudación por fecha.
* Clasificación de funciones según su nivel de ocupación.

---

## 8. Índices y optimización

El proyecto incorpora un conjunto de índices destinados a mejorar el rendimiento de determinadas consultas.

Los índices se encuentran definidos en el archivo: `05_indexes.sql`

Se implementan índices sobre columnas utilizadas frecuentemente en búsquedas, relaciones y filtros, principalmente en las tablas funcion, entrada y butaca.

La definición de los índices se mantiene separada del esquema principal para diferenciar la estructura funcional de la base de las estrategias de optimización.

---

## 9. Integridad de los datos

La integridad de la información se garantiza mediante diferentes mecanismos proporcionados por PostgreSQL.

Se utilizan claves primarias para identificar de manera única los registros y claves foráneas para mantener la integridad referencial entre las distintas entidades.

También se utilizan restricciones NOT NULL, UNIQUE y CHECK para evitar valores inválidos o duplicados.

Entre las restricciones implementadas se encuentran:

* Códigos únicos para cines y películas.
* Títulos de películas únicos.
* Legajos y CUIL únicos para empleados.
* Correos electrónicos únicos para los cines.
* Identificación única de salas dentro de cada cine.
* Identificación única de butacas dentro de una sala.
* Venta única de una butaca para una función.
* Porcentajes de descuento entre 0% y 100%.
* Importes de entradas mayores o iguales a cero.

Estas restricciones se complementan con los triggers implementados para cubrir reglas que requieren validaciones dinámicas.

---

## 10. Tecnologías y herramientas

El proyecto fue desarrollado utilizando las siguientes tecnologías y herramientas:

Sistema gestor de base de datos: PostgreSQL

Lenguaje: SQL / PL/pgSQL

Herramienta de administración: pgAdmin 4

Documentación y control del proyecto: GitHub

---

## 11. Estructura del proyecto

La estructura del repositorio es la siguiente:

Cada archivo SQL posee una responsabilidad específica dentro del proyecto.

### `01_schema.sql`

Contiene la creación del esquema, tablas, claves primarias, claves foráneas y restricciones principales.

### `02_data.sql`

Contiene los datos iniciales y de prueba utilizados para poblar la base de datos.

### `03_triggers_functions.sql`

Contiene las funciones, triggers y la tabla de auditoría.

### `04_queries.sql`

Contiene las consultas y reportes utilizados para analizar la información.

### `05_indexes.sql`

Contiene los índices implementados para optimizar determinadas consultas.

---

## 12. Orden de ejecución

Para realizar una instalación completa de la base de datos, los archivos deben ejecutarse en el siguiente orden:

01_schema.sql
02_data.sql
03_triggers_functions.sql
04_queries.sql
05_indexes.sql

Primero se crea la estructura de la base de datos. A continuación se cargan los datos iniciales. Luego se crean las funciones y triggers necesarios para implementar las reglas de negocio.

Una vez creada y poblada la base de datos, pueden ejecutarse las consultas de análisis. Finalmente, se crean los índices destinados a optimizar el acceso a los datos.

---

## 13. Datos de prueba

El proyecto incluye un conjunto de datos de prueba diseñado para representar un escenario realista de funcionamiento de una cadena de cines.

La carga inicial contempla:

* 5 cines.
* 15 películas.
* 5 medios de pago.
* 5 promociones.
* 10 empleados.
* 9 salas.
* 264 butacas.
* 30 funciones.
* 150 entradas.

Los datos permiten comprobar el funcionamiento de las relaciones, restricciones, triggers y consultas desarrolladas.

---

## 14. Pruebas de reglas de negocio

Se realizaron pruebas sobre los principales triggers implementados para verificar su funcionamiento.

Entre las situaciones comprobadas se encuentran:

* Intento de superar la capacidad máxima de una sala.
* Intento de asignar una butaca perteneciente a otra sala.
* Modificación del porcentaje de descuento de una promoción y generación del correspondiente registro de auditoría.
* Cálculo automático del importe aplicando una promoción.
* Intento de programar funciones con una diferencia inferior a tres horas en una misma sala.

Las pruebas permitieron comprobar que las reglas definidas son aplicadas directamente por la base de datos.

---

## 15. Conclusión

El proyecto presenta una implementación de una base de datos relacional orientada a la gestión de un sistema de cines, integrando mecanismos de almacenamiento, validación, automatización y análisis de información.

La utilización de claves primarias, claves foráneas y restricciones permite mantener la integridad de los datos, mientras que las funciones y triggers permiten implementar reglas de negocio directamente en PostgreSQL.

La incorporación de una tabla de auditoría permite registrar modificaciones relevantes, mientras que las consultas SQL proporcionan diferentes perspectivas para analizar el funcionamiento del sistema.

Finalmente, la utilización de índices y la separación del proyecto en diferentes scripts permiten mantener una estructura organizada y facilitar la instalación, mantenimiento y posterior evolución de la base de datos.
