-- ============================================
-- Modulo 2 - Unidad 1: Diseño de tablas
-- Sistema de Gestion de Ventas
-- ============================================

-- Tabla: clientes
CREATE TABLE clientes (
    id_cliente INT,                    -- Entero: identificador unico, no requiere decimales
    nombre VARCHAR(100),               -- Texto corto de longitud acotada, suficiente para nombres
    perfil_bio TEXT,                   -- Texto largo de longitud variable, sin limite practico fijo
    fecha_registro DATE                -- Solo fecha, no se necesita hora
);

-- Tabla: productos
CREATE TABLE productos (
    id_producto INT,                   -- Entero: identificador unico del producto
    descripcion VARCHAR(255),          -- Texto corto acotado, estandar para descripciones breves
    precio DECIMAL(10,2),              -- DECIMAL en vez de FLOAT: evita errores de redondeo en dinero,
                                        -- 10 digitos totales y 2 decimales cubren montos grandes con centavos
    esta_activo BIT                -- BOOLEAN: representa claramente si/no (a la venta o no)
);
