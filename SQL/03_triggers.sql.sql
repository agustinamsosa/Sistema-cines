-- =========================================================
-- SCRIPT DE TRIGGERS Y FUNCIONES: SISTEMA DE CINES
-- Motor: PostgreSQL (PL/pgSQL)
-- =========================================================

-- Tabla de auditoría para el Trigger 3
CREATE TABLE IF NOT EXISTS auditoria_promocion (
    idauditoria SERIAL PRIMARY KEY,
    idpromocion INTEGER NOT NULL,
    nombre_promocion VARCHAR(100),
    descuento_anterior NUMERIC(5,2),
    descuento_nuevo NUMERIC(5,2),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(50) DEFAULT CURRENT_USER
);
--TRIGGER 1: VALIDAR CAPACIDAD MÁXIMA DE LA SALA
CREATE OR REPLACE FUNCTION fn_validar_capacidad_sala()
RETURNS TRIGGER AS $$
DECLARE
    v_capacidad_sala INTEGER;
    v_entradas_vendidas INTEGER;
BEGIN

    -- Obtener la cantidad real de butacas de la sala
    SELECT COUNT(*)
    INTO v_capacidad_sala
    FROM butaca b
    JOIN funcion f ON b.idsala = f.idsala
    WHERE f.idfuncion = NEW.idfuncion;

    -- Contar entradas vendidas para la función
    SELECT COUNT(*)
    INTO v_entradas_vendidas
    FROM entrada
    WHERE idfuncion = NEW.idfuncion;

    IF v_entradas_vendidas >= v_capacidad_sala THEN
        RAISE EXCEPTION
            'Capacidad máxima alcanzada para esta función (Límite: % entradas)',
            v_capacidad_sala;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_validar_capacidad_sala
BEFORE INSERT ON entrada
FOR EACH ROW
EXECUTE FUNCTION fn_validar_capacidad_sala();
-- TRIGGER 2: VALIDAR QUE LA BUTACA PERTENEZCA A LA SALA
-- DE LA FUNCIÓN

CREATE OR REPLACE FUNCTION fn_validar_butaca_funcion()
RETURNS TRIGGER AS $$
DECLARE
    v_sala_butaca INTEGER;
    v_sala_funcion INTEGER;
BEGIN

    -- Obtener la sala a la que pertenece la butaca
    SELECT idsala
    INTO v_sala_butaca
    FROM butaca
    WHERE idbutaca = NEW.idbutaca;

    -- Obtener la sala donde se realiza la función
    SELECT idsala
    INTO v_sala_funcion
    FROM funcion
    WHERE idfuncion = NEW.idfuncion;

    IF v_sala_butaca <> v_sala_funcion THEN
        RAISE EXCEPTION
            'La butaca % no pertenece a la sala de la función %',
            NEW.idbutaca,
            NEW.idfuncion;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_butaca_funcion
BEFORE INSERT ON entrada
FOR EACH ROW
EXECUTE FUNCTION fn_validar_butaca_funcion();

-- TRIGGER 3: AUDITORÍA DE CAMBIOS EN PROMOCIONES
CREATE OR REPLACE FUNCTION fn_auditar_cambio_promocion()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.descuento_porcentaje <> NEW.descuento_porcentaje THEN
        INSERT INTO auditoria_promocion (
            idpromocion,
            nombre_promocion,
            descuento_anterior,
            descuento_nuevo
        ) VALUES (
            OLD.idpromocion,
            OLD.nombre,
            OLD.descuento_porcentaje,
            NEW.descuento_porcentaje
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditar_cambio_promocion
AFTER UPDATE ON promocion
FOR EACH ROW
EXECUTE FUNCTION fn_auditar_cambio_promocion();


-- TRIGGER 4: CÁLCULO AUTOMÁTICO DEL IMPORTE
CREATE OR REPLACE FUNCTION fn_calcular_importe_descuento()
RETURNS TRIGGER AS $$
DECLARE
    v_porcentaje_descuento NUMERIC(5,2) := 0.00;
BEGIN
    IF NEW.idpromocion IS NOT NULL THEN
        SELECT descuento_porcentaje INTO v_porcentaje_descuento
        FROM promocion
        WHERE idpromocion = NEW.idpromocion;
    END IF;

    IF v_porcentaje_descuento > 0 THEN
        NEW.importe := NEW.importe - (NEW.importe * (v_porcentaje_descuento / 100.00));
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calcular_importe_descuento
BEFORE INSERT ON entrada
FOR EACH ROW
EXECUTE FUNCTION fn_calcular_importe_descuento();


-- TRIGGER 5: RESTRICCIÓN HORARIA (SUPERPOSICIÓN)
CREATE OR REPLACE FUNCTION fn_validar_superposicion_horaria()
RETURNS TRIGGER AS $$
DECLARE
    v_conflictos INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_conflictos
    FROM funcion
    WHERE idsala = NEW.idsala
      AND fecha = NEW.fecha
      AND ABS(EXTRACT(EPOCH FROM (horario - NEW.horario))) < 10800;

    IF v_conflictos > 0 THEN
        RAISE EXCEPTION 'Conflicto de horario: Ya existe una función programada en la sala % en un rango menor a 3 horas', NEW.idsala;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_superposicion_horaria
BEFORE INSERT ON funcion
FOR EACH ROW
EXECUTE FUNCTION fn_validar_superposicion_horaria();




