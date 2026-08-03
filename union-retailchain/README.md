-- RetailChain — UNION y UNION ALL

-- 1. ¿Cuántas filas devuelve cada una y por qué son distintas?
UNION devuelve 14 filas y UNION ALL también devuelve 14. No hay diferencia
entre ambas en este caso: aunque los productos 103 (Monitor 4K), 104 (Teclado
Mecánico) y 106 (SSD Externo) existen en ambas sucursales con el mismo id y
nombre, cada uno tiene un valor de stock distinto (ej. producto 103: stock 5
en Norte, stock 3 en Sur). UNION compara la fila completa como unidad, así que
al no ser idénticas en todas sus columnas, ninguna se considera duplicado y
no se elimina nada.

-- 2. ¿Por qué UNION ALL es más eficiente?
UNION debe comparar todas las filas del resultado combinado para detectar
posibles duplicados exactos, lo que implica una operación interna de
ordenamiento o hash. UNION ALL concatena directamente sin esa comparación,
por eso es más rápido, incluso cuando el resultado final tiene el mismo
número de filas (como en este caso).

-- 3. ¿En qué casos usarías cada uno?
UNION: generar una lista única de emails de clientes provenientes de dos
campañas de marketing distintas, evitando enviar el mismo correo dos veces.
UNION ALL: consolidar logs de errores de dos servidores para contar el
volumen total de incidentes, donde cada registro repetido importa para el
conteo real.

-- 4. ¿Qué pasa si las columnas no coinciden?
SQL Server devuelve un error indicando que todas las consultas combinadas con
UNION deben tener el mismo número de expresiones en la lista de columnas. Si
el número coincide pero los tipos son incompatibles, devuelve un error de
conversión de tipos.