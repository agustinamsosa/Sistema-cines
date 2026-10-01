-- =========================================================
-- SCRIPT DE CREACIÓN DE ESQUEMA: SISTEMA DE CINES
-- Motor: PostgreSQL
-- =========================================================

-- Limpieza total del esquema para eliminar tablas e índices huérfanos
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- 1. TABLA CINE
CREATE TABLE cine (
    idcine SERIAL PRIMARY KEY,
    cod_cine INTEGER NOT NULL CONSTRAINT uq_cine_cod UNIQUE,
    email VARCHAR(100) NOT NULL CONSTRAINT uq_cine_email UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    num_calle VARCHAR(20) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    telefono VARCHAR(50) NOT NULL
);

-- 2. TABLA PELICULA
CREATE TABLE pelicula (
    idpelicula SERIAL PRIMARY KEY,
    cod_peli INTEGER NOT NULL CONSTRAINT uq_pelicula_cod UNIQUE,
    titulo VARCHAR(150) NOT NULL CONSTRAINT uq_pelicula_titulo UNIQUE,
    director VARCHAR(150) NOT NULL,
    actores TEXT NOT NULL,
    productora VARCHAR(150),
    argumento TEXT,
    genero VARCHAR(50) NOT NULL
);

-- 3. TABLA MEDIO DE PAGO
CREATE TABLE medio_pago (
    idmedio_pago SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL CONSTRAINT uq_medio_pago_nombre UNIQUE
);

-- 4. TABLA PROMOCION
CREATE TABLE promocion (
    idpromocion SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descuento_porcentaje NUMERIC(5,2) NOT NULL CHECK (descuento_porcentaje >= 0 AND descuento_porcentaje <= 100)
);

-- 5. TABLA EMPLEADO
CREATE TABLE empleado (
    idempleado SERIAL PRIMARY KEY,
    legajo INTEGER NOT NULL CONSTRAINT uq_empleado_legajo UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cuil VARCHAR(20) NOT NULL CONSTRAINT uq_empleado_cuil UNIQUE,
    cargo VARCHAR(50) NOT NULL,
    idcine INTEGER NOT NULL,
    CONSTRAINT fk_empleado_cine FOREIGN KEY (idcine) REFERENCES cine(idcine) ON DELETE CASCADE
);

-- 6. TABLA SALA
CREATE TABLE sala (
    idsala SERIAL PRIMARY KEY,
    cod_sala INTEGER NOT NULL,
    tamano_pantalla NUMERIC(10,2) CHECK (tamano_pantalla > 0),
    idcine INTEGER NOT NULL,

    CONSTRAINT uq_sala_cine
        UNIQUE (cod_sala, idcine),

    CONSTRAINT fk_sala_cine
        FOREIGN KEY (idcine)
        REFERENCES cine(idcine)
        ON DELETE CASCADE
);

-- 7. TABLA BUTACA
CREATE TABLE butaca (
    idbutaca SERIAL PRIMARY KEY,
    asiento INTEGER NOT NULL CHECK (asiento > 0),
    fila VARCHAR(5) NOT NULL,
    idsala INTEGER NOT NULL,
    CONSTRAINT uq_butaca_asiento_fila_sala UNIQUE (asiento, fila, idsala),
    CONSTRAINT fk_butaca_sala FOREIGN KEY (idsala) REFERENCES sala(idsala) ON DELETE CASCADE
);

-- 8. TABLA FUNCION
CREATE TABLE funcion (
    idfuncion SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    horario TIME NOT NULL,
    idpelicula INTEGER NOT NULL,
    idsala INTEGER NOT NULL,
    CONSTRAINT uq_funcion_espacio_tiempo UNIQUE (fecha, horario, idsala),
    CONSTRAINT fk_funcion_pelicula FOREIGN KEY (idpelicula) REFERENCES pelicula(idpelicula),
    CONSTRAINT fk_funcion_sala FOREIGN KEY (idsala) REFERENCES sala(idsala)
);

-- 9. TABLA ENTRADA
CREATE TABLE entrada (
    identrada SERIAL PRIMARY KEY,
    idbutaca INTEGER NOT NULL,
    idfuncion INTEGER NOT NULL,
    idempleado INTEGER NOT NULL,
    idmedio_pago INTEGER NOT NULL,
    idpromocion INTEGER,
    importe NUMERIC(10,2) NOT NULL CHECK (importe >= 0),
    CONSTRAINT uq_entrada_funcion_butaca UNIQUE (idfuncion, idbutaca),
    CONSTRAINT fk_entrada_butaca FOREIGN KEY (idbutaca) REFERENCES butaca(idbutaca),
    CONSTRAINT fk_entrada_funcion FOREIGN KEY (idfuncion) REFERENCES funcion(idfuncion),
    CONSTRAINT fk_entrada_empleado FOREIGN KEY (idempleado) REFERENCES empleado(idempleado),
    CONSTRAINT fk_entrada_medio_pago FOREIGN KEY (idmedio_pago) REFERENCES medio_pago(idmedio_pago),
    CONSTRAINT fk_entrada_promocion FOREIGN KEY (idpromocion) REFERENCES promocion(idpromocion)
);

