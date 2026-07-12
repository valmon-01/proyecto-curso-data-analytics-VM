# sql-select-fundamentals

Consultas SQL basicas sobre la tabla `sales` de TechStore, para el equipo de finanzas

## Por que es mala practica usar `SELECT *` en produccion?

1. **Rendimiento**: trae todas las columnas aunque solo se necesiten dos o tres, lo que aumenta el trafico de red y el uso de memoria, especialmente en tablas grandes
2. **Mantenibilidad**: si alguien agrega o renombra una columna en la tabla, el resultado de la consulta cambia sin previo aviso y puede romper reportes o codigo que dependen de un orden o cantidad fijo de columnas
3. **Seguridad**: puede exponer columnas sensibles (por ejemplo datos de clientes) que no deberian llegar a un reporte o a una capa de la aplicacion que no las necesita

## Por que son importantes los alias para un stakeholder no tecnico?

Un alias traduce el nombre tecnico de una columna a un termino que el negocio entiende sin conocer la base de datos. Por ejemplo, `total_amount` no le dice nada a alguien de finanzas a simple vista, pero `total_amount AS monto_total` devuelve una columna llamada `monto_total`, que es exactamente el concepto que esa persona espera ver en un reporte
