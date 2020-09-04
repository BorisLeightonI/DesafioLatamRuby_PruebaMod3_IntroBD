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
--subtotal INT,
--iva FLOAT,
--precio_total FLOAT,
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
-- valor_por_prod INT NOT NULL, SE CALCULA NO SE INGRESA
CONSTRAINT fk_factura
    FOREIGN KEY(id_factura)
        REFERENCES facturas(numero_factura),
CONSTRAINT fk_producto
    FOREIGN KEY(id_producto)
        REFERENCES productos(id)
);
-- ------------------------------------------------------------

INSERT INTO clientes(nombre,rut,direccion) VALUES
('cliente 1','rut clt1','direccion clt1'),
('cliente 2','rut clt2','direccion clt2'),
('cliente 3','rut clt3','direccion clt3'),
('cliente 4','rut clt4','direccion clt4'),
('cliente 5','rut clt5','direccion clt5')
;

INSERT INTO categorias(nombre, descripcion) VALUES 
('categoria1','descripcion de categoria 1'),
('categoria2','descripcion de categoria 2'),
('categoria3','descripcion de categoria 3')
;

INSERT INTO productos(nombre, descripcion, valor_unitario, categoria_id) VALUES 
('producto 1','descripcion producto 1', 20, 1),
('producto 2','descripcion producto 2', 40, 2),
('producto 3','descripcion producto 3', 60, 3),
('producto 4','descripcion producto 4', 80, 1),
('producto 5','descripcion producto 5', 100, 2),
('producto 6','descripcion producto 6', 120, 3),
('producto 7','descripcion producto 7', 120, 1),
('producto 8','descripcion producto 8', 200, 1)
;

INSERT INTO facturas(cliente_id,fecha) VALUES (1,'2020-01-01'),(1,'2020-01-15'),
(2,'2020-02-02'),(2,'2020-02-20'),(2,'2020-02-22'),
(3,'2020-03-01'),
(4,'2020-03-10'),(4,'2020-03-10'),(4,'2020-03-30'),(4,'2020-04-05')
;

INSERT INTO listado_productos(id_factura,id_producto, cantidad) VALUES 
(1,1,2),(2,2,3),
(3,3,3),(4,4,2),(5,5,3),
(6,6,1),
(7,7,2),(8,8,3),(9,1,4),(10,2,1)
;-- Está distribuido por cliente

---------------------------------------------------------

--SELECT id_factura,cantidad*valor_unitario AS precio_por_producto  FROM listado_productos INNER JOIN productos ON id_producto=productos.id ORDER BY precio_por_producto DESC LIMIT(1);

--select cliente_id FROM facturas where numero_factura=8;

-- CLIENTE ID que más pagó
SELECT cliente_id as cliente_ID_mas_Caro FROM facturas where numero_factura IN 
(SELECT id_factura FROM (SELECT id_factura,cantidad*valor_unitario AS precio_por_producto  FROM listado_productos INNER JOIN productos ON id_producto=productos.id ORDER BY precio_por_producto DESC LIMIT(1)) as foo);
