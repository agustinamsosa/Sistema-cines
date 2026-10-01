-- =========================================================
-- 02_data.sql
-- DATOS INICIALES DEL PROYECTO
-- Motor: PostgreSQL
-- =========================================================


-- =========================================================
-- 1. CINES
-- =========================================================

INSERT INTO cine (cod_cine, email, nombre, calle, num_calle, ciudad, telefono) VALUES
(101, 'contacto@cinemaxpergamino.com', 'CinemaX Pergamino',
 'Av. de Mayo', '450', 'Pergamino', '02477-412345'),

(102, 'info@cinemaxjunin.com', 'CinemaX Junín',
 'Sarmiento', '120', 'Junín', '0236-4432100'),

(103, 'contacto@cinemaxrosario.com', 'CinemaX Rosario',
 'Córdoba', '1850', 'Rosario', '0341-4256789'),

(104, 'info@cinemaxcolon.com', 'CinemaX Colón',
 '17', '980', 'Colón', '02473-421567'),

(105, 'contacto@cinemaxvenadotuerto.com', 'CinemaX Venado Tuerto',
 'Belgrano', '1350', 'Venado Tuerto', '03462-456789');


-- =========================================================
-- 2. PELÍCULAS
-- =========================================================

INSERT INTO pelicula (cod_peli, titulo, director,actores, productora, argumento, genero) VALUES
(501, 'Inception',
 'Christopher Nolan',
 'Leonardo DiCaprio, Joseph Gordon-Levitt',
 'Warner Bros',
 'Un ladrón especializado en infiltrarse en los sueños recibe la misión de implantar una idea en la mente de una persona.',
 'Ciencia ficción'),

(502, 'The Dark Knight',
 'Christopher Nolan',
 'Christian Bale, Heath Ledger',
 'Warner Bros',
 'Batman enfrenta a un criminal que lleva el caos a Gotham y pone a prueba sus límites.',
 'Acción'),

(503, 'Spider-Man: Across the Spider-Verse',
 'Joaquim Dos Santos',
 'Shameik Moore, Hailee Steinfeld',
 'Sony Pictures',
 'Miles Morales viaja por diferentes universos y se encuentra con distintas versiones de Spider-Man.',
 'Animación'),

(504, 'Interstellar',
 'Christopher Nolan',
 'Matthew McConaughey, Anne Hathaway',
 'Paramount Pictures',
 'Un grupo de astronautas viaja a través de un agujero de gusano en busca de un nuevo hogar para la humanidad.',
 'Ciencia ficción'),

(505, 'The Matrix',
 'Lana Wachowski, Lilly Wachowski',
 'Keanu Reeves, Laurence Fishburne',
 'Warner Bros',
 'Un programador descubre que la realidad que conoce es una simulación creada por máquinas.',
 'Ciencia ficción'),

(506, 'Gladiator',
 'Ridley Scott',
 'Russell Crowe, Joaquin Phoenix',
 'DreamWorks',
 'Un general romano es traicionado y obligado a convertirse en gladiador para buscar venganza.',
 'Drama'),

(507, 'Jurassic Park',
 'Steven Spielberg',
 'Sam Neill, Laura Dern, Jeff Goldblum',
 'Universal Pictures',
 'Un parque temático con dinosaurios clonados se convierte en una amenaza cuando los animales escapan.',
 'Aventura'),

(508, 'Toy Story',
 'John Lasseter',
 'Tom Hanks, Tim Allen',
 'Pixar',
 'Un grupo de juguetes cobra vida cuando los humanos no están presentes.',
 'Animación'),

(509, 'Avengers: Endgame',
 'Anthony Russo, Joe Russo',
 'Robert Downey Jr., Chris Evans, Scarlett Johansson',
 'Marvel Studios',
 'Los Vengadores intentan revertir las consecuencias de una batalla que cambió el destino del universo.',
 'Acción'),

(510, 'Parasite',
 'Bong Joon-ho',
 'Song Kang-ho, Lee Sun-kyun',
 'CJ Entertainment',
 'Una familia de bajos recursos comienza a relacionarse con una familia adinerada y las situaciones se vuelven cada vez más complejas.',
 'Drama'),

(511, 'The Godfather',
 'Francis Ford Coppola',
 'Marlon Brando, Al Pacino',
 'Paramount Pictures',
 'La historia de una poderosa familia dedicada al crimen organizado y los conflictos por la sucesión.',
 'Drama'),

(512, 'Coco',
 'Lee Unkrich, Adrian Molina',
 'Anthony Gonzalez, Gael García Bernal',
 'Pixar',
 'Un niño viaja al mundo de los muertos y descubre secretos sobre la historia de su familia.',
 'Animación'),

(513, 'Mad Max: Fury Road',
 'George Miller',
 'Tom Hardy, Charlize Theron',
 'Warner Bros',
 'En un mundo postapocalíptico, un grupo de sobrevivientes intenta escapar de un poderoso tirano.',
 'Acción'),

(514, 'La La Land',
 'Damien Chazelle',
 'Ryan Gosling, Emma Stone',
 'Lionsgate',
 'Una actriz y un músico intentan alcanzar sus sueños mientras mantienen una relación.',
 'Musical'),

(515, 'Oppenheimer',
 'Christopher Nolan',
 'Cillian Murphy, Emily Blunt, Matt Damon',
 'Universal Pictures',
 'La historia del científico que lideró el desarrollo de las primeras armas nucleares.',
 'Drama');


-- =========================================================
-- 3. MEDIOS DE PAGO
-- =========================================================

INSERT INTO medio_pago (nombre) 
VALUES
('Efectivo'),
('Tarjeta Débito'),
('Tarjeta Crédito'),
('Mercado Pago'),
('Transferencia');


-- =========================================================
-- 4. PROMOCIONES
-- =========================================================

INSERT INTO promocion (nombre, descuento_porcentaje) 
VALUES
('Sin Promoción', 0.00),
('Descuento Banco', 50.00),
('Miércoles de Cine', 20.00),
('Club CinemaX', 15.00),
('Promoción Estudiantil', 25.00);


-- =========================================================
-- 5. EMPLEADOS
-- =========================================================

INSERT INTO empleado (legajo, nombre, apellido, cuil, cargo, idcine) 
VALUES
(1001, 'Agustina', 'Sosa',
 '27-40123456-8', 'Cajera Senior', 1),

(1002, 'Lucas', 'Gómez',
 '20-38987654-2', 'Cajero', 1),

(1003, 'Martina', 'Pérez',
 '27-41234567-9', 'Cajera', 2),

(1004, 'Tomás', 'Fernández',
 '20-40112233-5', 'Supervisor', 2),

(1005, 'Sofía', 'Rodríguez',
 '27-39876543-1', 'Cajera Senior', 3),

(1006, 'Mateo', 'García',
 '20-42345678-6', 'Cajero', 3),

(1007, 'Valentina', 'López',
 '27-43567890-2', 'Cajera', 4),

(1008, 'Nicolás', 'Martínez',
 '20-37894561-7', 'Supervisor', 4),

(1009, 'Camila', 'Díaz',
 '27-44678901-3', 'Cajera', 5),

(1010, 'Santiago', 'Romero',
 '20-41239876-4', 'Cajero', 5);


-- =========================================================
-- 6. SALAS
-- =========================================================

INSERT INTO sala (cod_sala, tamano_pantalla, idcine) 
VALUES

-- CinemaX Pergamino
(1, 120.50, 1),
(2, 95.00, 1),

-- CinemaX Junín
(1, 150.00, 2),
(2, 110.00, 2),

-- CinemaX Rosario
(1, 180.00, 3),
(2, 140.00, 3),

-- CinemaX Colón
(1, 100.00, 4),

-- CinemaX Venado Tuerto
(1, 160.00, 5),
(2, 125.00, 5);


-- =========================================================
-- 7. BUTACAS
-- =========================================================

-- ---------------------------------------------------------
-- Sala 1 - Pergamino
-- 6 filas x 5 asientos = 30 butacas
-- ---------------------------------------------------------

INSERT INTO butaca (asiento, fila, idsala)
SELECT
    asiento,
    chr(64 + fila),
    1
FROM generate_series(1, 6) AS fila
CROSS JOIN generate_series(1, 5) AS asiento;


-- ---------------------------------------------------------
-- Sala 2 - Pergamino
-- 4 filas x 5 asientos = 20 butacas
-- ---------------------------------------------------------

INSERT INTO butaca (asiento, fila, idsala)
SELECT
    asiento,
    chr(64 + fila),
    2
FROM generate_series(1, 4) AS fila
CROSS JOIN generate_series(1, 5) AS asiento;


-- ---------------------------------------------------------
-- Sala 1 - Junín
-- 6 filas x 6 asientos = 36 butacas
-- ---------------------------------------------------------

INSERT INTO butaca (asiento, fila, idsala)
SELECT
    asiento,
    chr(64 + fila),
    3
FROM generate_series(1, 6) AS fila
CROSS JOIN generate_series(1, 6) AS asiento;


-- ---------------------------------------------------------
-- Sala 2 - Junín
-- 5 filas x 5 asientos = 25 butacas
-- ---------------------------------------------------------

INSERT INTO butaca (asiento, fila, idsala)
SELECT
    asiento,
    chr(64 + fila),
    4
FROM generate_series(1, 5) AS fila
CROSS JOIN generate_series(1, 5) AS asiento;


-- ---------------------------------------------------------
-- Sala 1 - Rosario
-- 6 filas x 7 asientos = 42 butacas
-- ---------------------------------------------------------

INSERT INTO butaca (asiento, fila, idsala)
SELECT
    asiento,
    chr(64 + fila),
    5
FROM generate_series(1, 6) AS fila
CROSS JOIN generate_series(1, 7) AS asiento;


-- ---------------------------------------------------------
-- Sala 2 - Rosario
-- 6 filas x 5 asientos = 30 butacas
-- ---------------------------------------------------------

INSERT INTO butaca (asiento, fila, idsala)
SELECT
    asiento,
    chr(64 + fila),
    6
FROM generate_series(1, 6) AS fila
CROSS JOIN generate_series(1, 5) AS asiento;


-- ---------------------------------------------------------
-- Sala 1 - Colón
-- 4 filas x 5 asientos = 20 butacas
-- ---------------------------------------------------------

INSERT INTO butaca (asiento, fila, idsala)
SELECT
    asiento,
    chr(64 + fila),
    7
FROM generate_series(1, 4) AS fila
CROSS JOIN generate_series(1, 5) AS asiento;


-- ---------------------------------------------------------
-- Sala 1 - Venado Tuerto
-- 6 filas x 6 asientos = 36 butacas
-- ---------------------------------------------------------

INSERT INTO butaca (asiento, fila, idsala)
SELECT
    asiento,
    chr(64 + fila),
    8
FROM generate_series(1, 6) AS fila
CROSS JOIN generate_series(1, 6) AS asiento;


-- ---------------------------------------------------------
-- Sala 2 - Venado Tuerto
-- 5 filas x 5 asientos = 25 butacas
-- ---------------------------------------------------------

INSERT INTO butaca (asiento, fila, idsala)
SELECT
    asiento,
    chr(64 + fila),
    9
FROM generate_series(1, 5) AS fila
CROSS JOIN generate_series(1, 5) AS asiento;

-- =========================================================
-- 8. FUNCIONES
-- =========================================================

INSERT INTO funcion (fecha, horario, idpelicula,idsala) 
VALUES

-- CINE 1 - SALA 1
('2025-06-20', '14:00', 1, 1),
('2025-06-20', '17:00', 2, 1),
('2025-06-20', '20:00', 3, 1),

-- CINE 1 - SALA 2
('2025-06-20', '15:00', 4, 2),
('2025-06-20', '18:00', 5, 2),
('2025-06-20', '21:00', 6, 2),

-- CINE 2 - SALA 3
('2025-06-20', '13:00', 7, 3),
('2025-06-20', '16:00', 8, 3),
('2025-06-20', '19:00', 9, 3),
('2025-06-20', '22:00', 10, 3),

-- CINE 2 - SALA 4
('2025-06-20', '14:00', 11, 4),
('2025-06-20', '17:00', 12, 4),
('2025-06-20', '20:00', 13, 4),

-- CINE 3 - SALA 5
('2025-06-20', '13:00', 14, 5),
('2025-06-20', '16:00', 15, 5),
('2025-06-20', '19:00', 1, 5),
('2025-06-20', '22:00', 2, 5),

-- CINE 3 - SALA 6
('2025-06-20', '14:00', 3, 6),
('2025-06-20', '17:00', 4, 6),
('2025-06-20', '20:00', 5, 6),

-- CINE 4 - SALA 7
('2025-06-20', '15:00', 6, 7),
('2025-06-20', '18:00', 7, 7),
('2025-06-20', '21:00', 8, 7),

-- CINE 5 - SALA 8
('2025-06-20', '13:00', 9, 8),
('2025-06-20', '16:00', 10, 8),
('2025-06-20', '19:00', 11, 8),
('2025-06-20', '22:00', 12, 8),

-- CINE 5 - SALA 9
('2025-06-20', '14:00', 13, 9),
('2025-06-20', '17:00', 14, 9),
('2025-06-20', '20:00', 15, 9);

-- =========================================================
-- 9. ENTRADAS
-- =========================================================

-- Se generan 5 entradas por función utilizando las primeras
-- 5 butacas disponibles de cada sala.
--
-- El importe se calcula directamente porque los triggers
-- todavía no fueron creados al ejecutar este archivo.
-- El Trigger 4 realizará este cálculo automáticamente
-- para las nuevas entradas posteriores.


INSERT INTO entrada ( idbutaca, idfuncion, idempleado, idmedio_pago, idpromocion, importe)
SELECT b.idbutaca, f.idfuncion,

    -- Empleado correspondiente al cine de la función
    ((s.idcine - 1) * 2 + 1),

    -- Medio de pago distribuido entre los 5 disponibles
    ((b.idbutaca + f.idfuncion) % 5) + 1,

    -- Distribución de promociones
    CASE
        WHEN b.asiento % 5 = 0 THEN 2
        WHEN b.asiento % 4 = 0 THEN 3
        WHEN b.asiento % 3 = 0 THEN 4
        WHEN b.asiento % 2 = 0 THEN 5
        ELSE 1
    END,

    -- Importe final aplicando el descuento
    ROUND(
        (
            CASE
                WHEN b.asiento % 3 = 0 THEN 5500.00
                WHEN b.asiento % 2 = 0 THEN 5000.00
                ELSE 4500.00
            END
        ) * (
            1 - (
                CASE
                    WHEN b.asiento % 5 = 0 THEN 50.00
                    WHEN b.asiento % 4 = 0 THEN 20.00
                    WHEN b.asiento % 3 = 0 THEN 15.00
                    WHEN b.asiento % 2 = 0 THEN 25.00
                    ELSE 0.00
                END
            ) / 100.00
        ),
        2
    )

FROM funcion f
JOIN sala s ON f.idsala = s.idsala
JOIN butaca b ON b.idsala = f.idsala
WHERE b.idbutaca IN (
    SELECT b2.idbutaca
    FROM butaca b2
    WHERE b2.idsala = f.idsala
    ORDER BY b2.idbutaca
    LIMIT 5
);

























