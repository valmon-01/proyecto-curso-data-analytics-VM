# ETL — Ventas_export_legacy

## Transformaciones
1. Renombré columnas técnicas a nombres descriptivos (COD_OP → id_venta)
2. Eliminé filas vacías y duplicados por id_venta
3. Normalicé canal_venta (mayúsculas)
4. Tipeé fecha_venta y fecha_alta_cliente como Fecha
5. Reemplacé nulos de descuento_pct por 0
6. Recalculé total_venta nulo con columna personalizada
7. Reemplacé nulos de email/teléfono por "Sin dato"
8. Eliminé COD_MON (constante)
9. Separé en tablas Clientes y Ventas

## Tipos de datos
- **Texto**: IDs (id_venta, id_cliente, id_producto) — son identificadores, no cantidades
- **Fecha**: fecha_venta, fecha_alta_cliente — necesario para filtros temporales y DAX
- **Entero**: cantidad — no admite decimales
- **Decimal**: precio_unitario, descuento_pct, total_venta — montos con precisión

## Nulos y duplicados
- Duplicados: quitados por id_venta (misma operación cargada dos veces) descuento nulo → 0 (sin descuento aplicado)
- total_venta nulo → recalculado: `cantidad * precio_unitario * (1 - descuento)`
- email/teléfono nulos → "Sin dato" (no crítico, no justifica borrar la venta)

## Separación cliente/transacción
El archivo repetía los datos del cliente en cada venta. Separé lo que describe a la persona (Clientes) de lo que describe la operación puntual (Ventas), conectadas por id_cliente.