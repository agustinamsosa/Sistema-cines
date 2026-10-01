-- =========================================================
-- 05_indexes.sql
-- ÍNDICES PARA OPTIMIZACIÓN DE CONSULTAS
-- Motor: PostgreSQL
-- =========================================================


-- Índice para búsquedas de funciones por sala y fecha.
CREATE INDEX idx_funcion_sala_fecha
ON funcion(idsala, fecha);


-- Índice para búsquedas de funciones por película.
CREATE INDEX idx_funcion_pelicula
ON funcion(idpelicula);


-- Índice para búsquedas de entradas por empleado.
CREATE INDEX idx_entrada_empleado
ON entrada(idempleado);


-- Índice para búsquedas de entradas por promoción.
CREATE INDEX idx_entrada_promocion
ON entrada(idpromocion);


-- Índice para búsquedas de butacas pertenecientes a una sala.
CREATE INDEX idx_butaca_sala
ON butaca(idsala);