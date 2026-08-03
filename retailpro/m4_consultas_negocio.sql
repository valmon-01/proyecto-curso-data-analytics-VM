USE Ventas_Tech_DB;
GO

-- Consulta 1

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2
 
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- Consulta 3
 
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- Consulta 4
 
SELECT
    v.mes,
    v.total_facturado,
    CASE
        WHEN v.total_facturado > promedios.promedio_mensual THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparativa_promedio
FROM (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
) AS v
CROSS JOIN (
    SELECT AVG(total_mes) AS promedio_mensual
    FROM (
        SELECT SUM(cantidad * precio_unitario) AS total_mes
        FROM ventas
        GROUP BY MONTH(fecha_venta)
    ) AS totales_por_mes
) AS promedios
ORDER BY v.mes;

-- Hallazgos
-- 1. Marzo fue el unico mes con facturacion por encima del promedio mensual ($6444 vs. promedio de $2589,75)
-- 2. El producto 1 es el que mas factura ($6000), aunque no es el mas vendido en unidades ya que el producto 2 lidera con 23 unidades vendidas
-- 3. El cliente 1 fue el de mayor gasto acumulado ($3202) y los 5 clientes registrados resultaron recurrentes (mas de un pedido cada uno)
