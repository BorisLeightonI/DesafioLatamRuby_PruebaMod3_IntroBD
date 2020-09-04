CREATE DATABASE prueba;
\c prueba

CREATE TABLE clientes(
id SERIAL PRIMARY KEY,
nombre VARCHAR(50),
rut VARCHAR(10),
direccion VARCHAR(100)
);

CREATE TABLE facturas(
numero_factura SERIAL PRIMARY KEY,
cliente_id INT NOT NULL,
fecha DATE NOT NULL,
subtotal INT,
iva FLOAT,
precio_total FLOAT,
CONSTRAINT fk_cliente
    FOREIGN KEY(cliente_id)
        REFERENCES clientes(id)
);

CREATE TABLE categorias(
id SERIAL PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
descripcion VARCHAR(100)
);

CREATE TABLE productos(
id SERIAL PRIMARY KEY,
categoria_id INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
descripcion VARCHAR(100),
valor_unitario INT NOT NULL,
CONSTRAINT fk_categoria
    FOREIGN KEY(categoria_id)
        REFERENCES categorias(id)
);

CREATE TABLE listado_productos(
id_factura INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
valor_por_prod INT NOT NULL,
CONSTRAINT fk_factura
    FOREIGN KEY(id_factura)
        REFERENCES facturas(numero_factura),
CONSTRAINT fk_producto
    FOREIGN KEY(id_producto)
        REFERENCES productos(id)
);
-- ------------------------------------------------------------

