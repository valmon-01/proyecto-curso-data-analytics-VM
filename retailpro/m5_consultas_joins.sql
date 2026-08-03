-- Ventas_Tech_DB — M5: Consultas con JOINs y UNION
-- Autor: Valentina Monti
-- Fecha: 02/08/2026

USE Ventas_Tech_DB;

-- CONSULTA 1: Vista base del proyecto (INNER JOIN)
SELECT
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;


-- CONSULTA 2: Clientes sin ventas (LEFT JOIN)
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
-- Nota: esta consulta devuelve 0 filas en el dataset actual, ya que todos los clientes registrados tienen al menos una compra.


-- CONSULTA 3: Productos sin ventas (LEFT JOIN)
SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;
-- Nota: esta consulta devuelve 0 filas en el dataset actual, ya que todos los productos del catálogo tienen al menos una venta registrada.


-- CONSULTA 4: Consolidado por categoría (UNION ALL)

SELECT
    v.id_venta,
    v.fecha_venta,
    (v.cantidad * v.precio_unitario) AS total_venta,
    'Online' AS canal
FROM ventas v
WHERE v.id_venta % 2 = 0

UNION ALL

SELECT
    v.id_venta,
    v.fecha_venta,
    (v.cantidad * v.precio_unitario) AS total_venta,
    'Presencial' AS canal
FROM ventas v
WHERE v.id_venta % 2 <> 0;

-- Total por canal
SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM (
    SELECT
        (v.cantidad * v.precio_unitario) AS total_venta,
        'Online' AS canal
    FROM ventas v
    WHERE v.id_venta % 2 = 0

    UNION ALL

    SELECT
        (v.cantidad * v.precio_unitario) AS total_venta,
        'Presencial' AS canal
    FROM ventas v
    WHERE v.id_venta % 2 <> 0
) AS consolidado
GROUP BY canal;