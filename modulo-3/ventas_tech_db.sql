-- ========================================
-- Modelo de Datos Relacional para Retail
-- ========================================

-- ========================================
-- 1. DROP TABLES (orden inverso de dependencias)
-- ========================================
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS territorios;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

-- ========================================
-- 2. CREATE TABLES
-- ========================================

-- Tabla: territorios
CREATE TABLE territorios (
    id_territorio INT PRIMARY KEY,
    region VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    zona VARCHAR(50) NOT NULL,
    cuota_trimestral DECIMAL(12,2) NOT NULL
);

-- Tabla: clientes
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    segmento VARCHAR(50),
    fecha_registro DATE NOT NULL
);

-- Tabla: productos
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    subcategoria VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2) NOT NULL
);

-- Tabla: vendedores
CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_territorio INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    cuota_individual DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio)
);

-- Tabla: ventas (tabla de hechos)
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    id_vendedor INT NOT NULL,
    id_territorio INT NOT NULL,
    cantidad INT NOT NULL,
    total_venta DECIMAL(12,2) NOT NULL,
    canal VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio)
);

-- ========================================
-- 3. INSERT DATA
-- ========================================

-- Territorios (3 registros)
INSERT INTO territorios VALUES (1, 'AMBA', 'Argentina', 'Norte', 50000.00);
INSERT INTO territorios VALUES (2, 'Litoral', 'Argentina', 'Centro', 35000.00);
INSERT INTO territorios VALUES (3, 'Cuyo', 'Argentina', 'Oeste', 25000.00);

-- Clientes (5 registros)
INSERT INTO clientes VALUES (1, 'María López', 'maria@mail.com', 'Buenos Aires', 'Premium', '2024-01-05');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz', 'carlos@mail.com', 'Córdoba', 'Estándar', '2024-01-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez', 'ana@mail.com', 'Rosario', 'Premium', '2024-02-01');
INSERT INTO clientes VALUES (4, 'Pedro Sanz', 'pedro@mail.com', 'Mendoza', 'Básico', '2024-02-15');
INSERT INTO clientes VALUES (5, 'Laura Torres', 'laura@mail.com', 'Tucumán', 'Estándar', '2024-03-01');

-- Productos (6 registros)
INSERT INTO productos VALUES (1, 'Laptop Pro 15', 'Computación', 'Laptops', 1200.00, 650.00);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico', 'Accesorios', 'Periféricos', 28.00, 12.00);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"', 'Computación', 'Monitores', 450.00, 280.00);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro', 'Audio', 'Auriculares', 120.00, 55.00);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB', 'Almacenamiento', 'Discos', 130.00, 70.00);
INSERT INTO productos VALUES (6, 'Teclado Mecánico', 'Accesorios', 'Periféricos', 95.00, 45.00);

-- Vendedores (3 registros)
INSERT INTO vendedores VALUES (1, 'Juan Pérez', 1, '2023-06-01', 15000.00);
INSERT INTO vendedores VALUES (2, 'Sofia García', 2, '2023-08-15', 12000.00);
INSERT INTO vendedores VALUES (3, 'Roberto López', 3, '2023-09-01', 10000.00);

-- Ventas (10 registros)
INSERT INTO ventas VALUES (1, '2024-03-05', 1, 1, 1, 1, 2, 2400.00, 'Presencial');
INSERT INTO ventas VALUES (2, '2024-03-06', 2, 2, 1, 1, 5, 140.00, 'Online');
INSERT INTO ventas VALUES (3, '2024-03-07', 3, 3, 2, 2, 1, 450.00, 'Presencial');
INSERT INTO ventas VALUES (4, '2024-03-08', 1, 4, 1, 1, 2, 240.00, 'Online');
INSERT INTO ventas VALUES (5, '2024-03-10', 4, 5, 3, 3, 3, 390.00, 'Presencial');
INSERT INTO ventas VALUES (6, '2024-03-11', 2, 6, 2, 2, 4, 380.00, 'Online');
INSERT INTO ventas VALUES (7, '2024-03-12', 5, 1, 3, 3, 1, 1200.00, 'Presencial');
INSERT INTO ventas VALUES (8, '2024-03-13', 3, 2, 2, 2, 8, 224.00, 'Online');
INSERT INTO ventas VALUES (9, '2024-03-14', 4, 4, 1, 1, 1, 120.00, 'Presencial');
INSERT INTO ventas VALUES (10, '2024-03-15', 5, 3, 2, 2, 2, 900.00, 'Online');

-- ========================================
-- 4. VERIFICACIÓN
-- ========================================
-- SELECT * FROM territorios;
-- SELECT * FROM clientes;
-- SELECT * FROM productos;
-- SELECT * FROM vendedores;
-- SELECT * FROM ventas;
