-- =========================================================
-- CONSULTAS Y REPORTES DE NEGOCIO: SISTEMA DE CINES
-- Motor: PostgreSQL
-- =========================================================

-- =========================================================
-- 1. RECAUDACIÓN POR CINE Y MEDIO DE PAGO
-- =========================================================

SELECT c.nombre AS cine, mp.nombre AS medio_pago,
    COUNT(e.identrada) AS cantidad_entradas,
    SUM(e.importe) AS total_recaudado
FROM entrada e
JOIN funcion f ON e.idfuncion = f.idfuncion
JOIN sala s ON f.idsala = s.idsala
JOIN cine c ON s.idcine = c.idcine
JOIN medio_pago mp ON e.idmedio_pago = mp.idmedio_pago
GROUP BY c.nombre, mp.nombre
ORDER BY total_recaudado DESC;

-- =========================================================
-- 2. OCUPACIÓN Y PORCENTAJE DE CAPACIDAD POR FUNCIÓN
-- =========================================================

SELECT p.titulo AS pelicula, f.fecha, f.horario, s.cod_sala,
    COUNT(DISTINCT e.identrada) AS entradas_vendidas,
    COUNT(DISTINCT b.idbutaca) AS capacidad_total,
    ROUND(
        (
            COUNT(DISTINCT e.identrada)::DECIMAL /
            NULLIF(COUNT(DISTINCT b.idbutaca), 0)
        ) * 100,
        2
    ) AS porcentaje_ocupacion
FROM funcion f
JOIN pelicula p ON f.idpelicula = p.idpelicula
JOIN sala s ON f.idsala = s.idsala
JOIN butaca b ON s.idsala = b.idsala
LEFT JOIN entrada e ON f.idfuncion = e.idfuncion AND b.idbutaca = e.idbutaca
GROUP BY f.idfuncion, p.titulo, f.fecha, f.horario, s.cod_sala
ORDER BY f.fecha, f.horario;


-- =========================================================
-- 3. DESEMPEÑO DE VENTAS POR EMPLEADO
-- =========================================================

SELECT emp.legajo,  emp.nombre || ' ' || emp.apellido AS empleado,
    c.nombre AS cine,
    COUNT(e.identrada) AS entradas_vendidas,
    COALESCE(SUM(e.importe), 0.00) AS total_vendido
FROM empleado emp
JOIN cine c ON emp.idcine = c.idcine
LEFT JOIN entrada e ON emp.idempleado = e.idempleado
GROUP BY emp.legajo, emp.nombre, emp.apellido, c.nombre
ORDER BY total_vendido DESC;

-- =========================================================
-- 4. PELÍCULAS CON FACTURACIÓN SUPERIOR AL PROMEDIO
-- =========================================================

SELECT p.titulo, p.genero,
    COUNT(e.identrada) AS total_entradas,
    SUM(e.importe) AS total_recaudado
FROM pelicula p
JOIN funcion f ON p.idpelicula = f.idpelicula
JOIN entrada e ON f.idfuncion = e.idfuncion
GROUP BY p.idpelicula, p.titulo, p.genero
HAVING SUM(e.importe) > (
    SELECT AVG(total_pelicula)
    FROM (
        SELECT
            SUM(e2.importe) AS total_pelicula
        FROM entrada e2
        JOIN funcion f2 ON e2.idfuncion = f2.idfuncion
        GROUP BY f2.idpelicula
    ) AS sub
)
ORDER BY total_recaudado DESC;


-- =========================================================
-- 5. RECAUDACIÓN POR GÉNERO
-- =========================================================

SELECT p.genero,
    COUNT(e.identrada) AS entradas_vendidas,
    SUM(e.importe) AS total_recaudado
FROM entrada e
JOIN funcion f ON e.idfuncion = f.idfuncion
JOIN pelicula p ON f.idpelicula = p.idpelicula
GROUP BY p.genero
ORDER BY total_recaudado DESC;


-- =========================================================
-- 6. USO DE PROMOCIONES
-- =========================================================

SELECT  pr.nombre AS promocion, pr.descuento_porcentaje,
    COUNT(e.identrada) AS cantidad_entradas_vendidas
FROM entrada e
JOIN promocion pr ON e.idpromocion = pr.idpromocion
GROUP BY pr.idpromocion, pr.nombre, pr.descuento_porcentaje
ORDER BY cantidad_entradas_vendidas DESC;


-- =========================================================
-- 7. TOP 3 FUNCIONES CON MAYOR RECAUDACIÓN
-- =========================================================

SELECT c.nombre AS cine, p.titulo AS pelicula, f.fecha, f.horario,
    SUM(e.importe) AS recaudacion_funcion
FROM entrada e
JOIN funcion f ON e.idfuncion = f.idfuncion
JOIN pelicula p ON f.idpelicula = p.idpelicula
JOIN sala s ON f.idsala = s.idsala
JOIN cine c ON s.idcine = c.idcine
GROUP BY c.nombre, p.titulo, f.fecha, f.horario
ORDER BY recaudacion_funcion DESC
LIMIT 3;

-- =========================================================
-- 8. PELÍCULAS SIN FUNCIONES PROGRAMADAS
-- =========================================================

SELECT p.idpelicula, p.titulo, p.genero
FROM pelicula p
LEFT JOIN funcion f ON p.idpelicula = f.idpelicula
WHERE f.idfuncion IS NULL
ORDER BY p.titulo;


-- =========================================================
-- 9. RECAUDACIÓN TOTAL POR CINE
-- =========================================================

SELECT c.idcine, c.nombre AS cine,
    COUNT(e.identrada) AS entradas_vendidas,
    COALESCE(SUM(e.importe), 0.00) AS total_recaudado
FROM cine c
LEFT JOIN sala s ON c.idcine = s.idcine
LEFT JOIN funcion f ON s.idsala = f.idsala
LEFT JOIN entrada e ON f.idfuncion = e.idfuncion
GROUP BY c.idcine, c.nombre
ORDER BY total_recaudado DESC;


-- =========================================================
-- 10. RECAUDACIÓN POR FECHA
-- =========================================================

SELECT f.fecha, COUNT(e.identrada) AS entradas_vendidas, SUM(e.importe) AS total_recaudado
FROM entrada e
JOIN funcion f ON e.idfuncion = f.idfuncion
GROUP BY f.fecha
ORDER BY f.fecha;


-- =========================================================
-- 11. CLASIFICACIÓN DE FUNCIONES SEGÚN OCUPACIÓN
-- =========================================================

SELECT
    p.titulo AS pelicula, f.fecha, f.horario, s.cod_sala,
    COUNT(DISTINCT e.identrada) AS entradas_vendidas,
    COUNT(DISTINCT b.idbutaca) AS capacidad_total,
    ROUND(
        (
            COUNT(DISTINCT e.identrada)::DECIMAL /
            NULLIF(COUNT(DISTINCT b.idbutaca), 0)
        ) * 100,
        2
    ) AS porcentaje_ocupacion,
    CASE
        WHEN (
            COUNT(DISTINCT e.identrada)::DECIMAL /
            NULLIF(COUNT(DISTINCT b.idbutaca), 0)
        ) * 100 >= 80
            THEN 'Alta'

        WHEN (
            COUNT(DISTINCT e.identrada)::DECIMAL /
            NULLIF(COUNT(DISTINCT b.idbutaca), 0)
        ) * 100 >= 50
            THEN 'Media'

        ELSE 'Baja'
    END AS nivel_ocupacion
FROM funcion f
JOIN pelicula p ON f.idpelicula = p.idpelicula
JOIN sala s ON f.idsala = s.idsala
JOIN butaca b ON s.idsala = b.idsala
LEFT JOIN entrada e ON f.idfuncion = e.idfuncion
    AND b.idbutaca = e.idbutaca
GROUP BY f.idfuncion, p.titulo, f.fecha, f.horario, s.cod_sala
ORDER BY porcentaje_ocupacion DESC;

