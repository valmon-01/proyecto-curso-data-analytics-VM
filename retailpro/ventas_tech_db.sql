-- ══════════════════════════════════════════
-- Ventas_Tech_DB (RetailPro) — Esquema completo
-- ══════════════════════════════════════════

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS territorios;

-- ── TERRITORIOS ──────────────────────────
CREATE TABLE territorios (
    id_territorio INT PRIMARY KEY,
    region VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    zona VARCHAR(50) NOT NULL
);

INSERT INTO territorios VALUES
(1,'Norte','Argentina','Tucumán'),
(2,'Centro','Argentina','Córdoba'),
(3,'AMBA','Argentina','CABA'),
(4,'AMBA','Argentina','GBA'),
(5,'Cuyo','Argentina','Mendoza'),
(6,'Litoral','Argentina','Rosario'),
(7,'Patagonia','Argentina','Neuquén'),
(8,'Litoral','Argentina','Santa Fe');

-- ── CATEGORIAS ───────────────────────────
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);

INSERT INTO categorias VALUES
(1,'Computación','Laptops, PCs y monitores'),
(2,'Accesorios','Periféricos y complementos'),
(3,'Audio','Auriculares y parlantes'),
(4,'Almacenamiento','Discos y memorias');

-- ── CLIENTES ─────────────────────────────
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    segmento VARCHAR(30) NOT NULL,        -- Consumer / Corporate / Home Office
    id_territorio INT,
    fecha_registro DATE NOT NULL,
    FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio)
);

INSERT INTO clientes VALUES
(1,'María López','maria@mail.com','Buenos Aires','Consumer',3,'2024-01-05'),
(2,'Carlos Ruiz','carlos@mail.com','Córdoba','Corporate',2,'2024-01-10'),
(3,'Ana Gómez','ana@mail.com','Rosario','Consumer',6,'2024-02-01'),
(4,'Pedro Sanz','pedro@mail.com','Mendoza','Home Office',5,'2024-02-15'),
(5,'Laura Torres','laura@mail.com','Tucumán','Consumer',1,'2024-03-01'),
(6,'Diego Fernández','diego@mail.com','Buenos Aires','Corporate',3,'2024-03-05'),
(7,'Julieta Blanco','julieta@mail.com','GBA','Consumer',4,'2024-03-10'),
(8,'Martín Suárez','martin@mail.com','Neuquén','Home Office',7,'2024-03-15'),
(9,'Camila Rojas','camila@mail.com','Santa Fe','Consumer',8,'2024-03-20'),
(10,'Federico Paz','federico@mail.com','Córdoba','Corporate',2,'2024-03-25'),
(11,'Valentina Ríos','valentina@mail.com','Rosario','Consumer',6,'2024-04-01'),
(12,'Nicolás Vega','nicolas@mail.com','Mendoza','Home Office',5,'2024-04-05'),
(13,'Sofía Molina','sofia@mail.com','Tucumán','Consumer',1,'2024-04-10'),
(14,'Tomás Herrera','tomas@mail.com','Buenos Aires','Corporate',3,'2024-04-15'),
(15,'Agustina Castro','agustina@mail.com','GBA','Consumer',4,'2024-04-20'),
(16,'Lucas Ortega','lucas@mail.com','Neuquén','Home Office',7,'2024-04-25'),
(17,'Florencia Silva','florencia@mail.com','Santa Fe','Consumer',8,'2024-05-01'),
(18,'Ignacio Acosta','ignacio@mail.com','Córdoba','Corporate',2,'2024-05-05'),
(19,'Milagros Domínguez','milagros@mail.com','Rosario','Consumer',6,'2024-05-10'),
(20,'Bruno Navarro','bruno@mail.com','Mendoza','Home Office',5,'2024-05-15');

-- ── PRODUCTOS ────────────────────────────
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT,
    subcategoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

INSERT INTO productos VALUES
(1,'Laptop Pro 15',1,'Laptops',1200.00,850.00,15,1),
(2,'Mouse Inalámbrico',2,'Periféricos',28.00,18.00,80,1),
(3,'Monitor 4K 27"',1,'Monitores',450.00,310.00,12,1),
(4,'Auriculares BT Pro',3,'Auriculares',120.00,75.00,35,1),
(5,'SSD Externo 1TB',4,'Discos',130.00,85.00,18,1),
(6,'Teclado Mecánico',2,'Periféricos',95.00,55.00,40,1),
(7,'Laptop Basic 14',1,'Laptops',650.00,480.00,20,1),
(8,'Webcam HD 1080p',2,'Periféricos',85.00,50.00,25,1),
(9,'Parlante Bluetooth',3,'Audio',60.00,35.00,45,1),
(10,'Hub USB-C 7 puertos',2,'Periféricos',45.00,25.00,60,1);

-- ── VENTAS (tabla de hechos) ─────────────
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    id_territorio INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    total_venta DECIMAL(10,2) NOT NULL,
    canal VARCHAR(20) NOT NULL,           -- Online / Presencial
    fecha_venta DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio)
);

INSERT INTO ventas VALUES
(1,1,1,3,2,1200.00,2400.00,'Online','2024-03-05'),
(2,2,2,2,5,28.00,140.00,'Presencial','2024-03-06'),
(3,3,3,6,1,450.00,450.00,'Online','2024-03-07'),
(4,1,4,3,2,120.00,240.00,'Presencial','2024-03-08'),
(5,4,5,5,3,130.00,390.00,'Online','2024-03-10'),
(6,2,6,2,4,95.00,380.00,'Presencial','2024-03-11'),
(7,5,1,1,1,1200.00,1200.00,'Online','2024-03-12'),
(8,3,2,6,8,28.00,224.00,'Presencial','2024-03-13'),
(9,4,4,5,1,120.00,120.00,'Online','2024-03-14'),
(10,5,3,1,2,450.00,900.00,'Presencial','2024-03-15'),
(11,6,7,3,1,650.00,650.00,'Online','2024-03-16'),
(12,7,8,4,3,85.00,255.00,'Presencial','2024-03-17'),
(13,8,9,7,2,60.00,120.00,'Online','2024-03-18'),
(14,9,10,8,4,45.00,180.00,'Presencial','2024-03-19'),
(15,10,1,2,1,1200.00,1200.00,'Online','2024-03-20'),
(16,11,2,6,6,28.00,168.00,'Presencial','2024-03-21'),
(17,12,3,5,1,450.00,450.00,'Online','2024-03-22'),
(18,13,4,1,2,120.00,240.00,'Presencial','2024-03-23'),
(19,14,5,3,3,130.00,390.00,'Online','2024-03-24'),
(20,15,6,4,2,95.00,190.00,'Presencial','2024-03-25'),
(21,16,7,7,1,650.00,650.00,'Online','2024-03-26'),
(22,17,8,8,2,85.00,170.00,'Presencial','2024-03-27'),
(23,18,9,2,5,60.00,300.00,'Online','2024-03-28'),
(24,19,10,6,3,45.00,135.00,'Presencial','2024-03-29'),
(25,20,1,5,1,1200.00,1200.00,'Online','2024-03-30'),
(26,1,2,3,4,28.00,112.00,'Presencial','2024-04-01'),
(27,2,3,2,2,450.00,900.00,'Online','2024-04-02'),
(28,3,4,6,1,120.00,120.00,'Presencial','2024-04-03'),
(29,4,5,5,2,130.00,260.00,'Online','2024-04-04'),
(30,5,6,1,3,95.00,285.00,'Presencial','2024-04-05'),
(31,6,7,3,2,650.00,1300.00,'Online','2024-04-06'),
(32,7,8,4,1,85.00,85.00,'Presencial','2024-04-07'),
(33,8,9,7,4,60.00,240.00,'Online','2024-04-08'),
(34,9,10,8,2,45.00,90.00,'Presencial','2024-04-09'),
(35,10,1,2,1,1200.00,1200.00,'Online','2024-04-10'),
(36,11,2,6,3,28.00,84.00,'Presencial','2024-04-11'),
(37,12,3,5,2,450.00,900.00,'Online','2024-04-12'),
(38,13,4,1,1,120.00,120.00,'Presencial','2024-04-13'),
(39,14,5,3,5,130.00,650.00,'Online','2024-04-14'),
(40,15,6,4,2,95.00,190.00,'Presencial','2024-04-15'),
(41,16,7,7,1,650.00,650.00,'Online','2024-04-16'),
(42,17,8,8,3,85.00,255.00,'Presencial','2024-04-17'),
(43,18,9,2,2,60.00,120.00,'Online','2024-04-18'),
(44,19,10,6,4,45.00,180.00,'Presencial','2024-04-19'),
(45,20,1,5,1,1200.00,1200.00,'Online','2024-04-20'),
(46,1,3,3,1,450.00,450.00,'Presencial','2024-04-21'),
(47,2,4,2,2,120.00,240.00,'Online','2024-04-22'),
(48,3,5,6,3,130.00,390.00,'Presencial','2024-04-23'),
(49,4,6,5,1,95.00,95.00,'Online','2024-04-24'),
(50,5,7,1,1,650.00,650.00,'Presencial','2024-04-25');