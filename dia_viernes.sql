CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(150)
)

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    total NUMERIC(8,2) NOT NULL CHECK (total > 0),
    CONSTRAINT fk_pedidos_cliente
    FOREIGN KEY (cliente_id)
    REFERENCES clientes(id)
)
SELECT * from pedidos

CREATE TABLE productos(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(8,2) NOT NULL  CHECK (precio > 0)
)

--insertando clientes(algunos q tendran pedidos, otros q no tendran ningun pedido)
INSERT INTO clientes (nombre, ciudad)
VALUES ('Carlos Gomez', 'La paz'),('Mariana Rios', 'Cochabamba'),
('Lucia Mendoza', 'Santa Cruz'),('Fernando Silva', 'La paz')

--insertar pedidos
INSERT INTO pedidos(total,cliente_id)
VALUES(500 ,NULL)

SELECT * FROM pedidos


--INNER JOIN
select * from clientes

SELECT clientes.nombre,
    pedidos.id AS pedido_id,
    clientes.id AS cliente_id,
    pedidos.fecha,
    pedidos.total
FROM clientes
INNER JOIN pedidos ON clientes.id = pedidos.cliente_id
WHERE clientes.nombre = 'Carlos Gomez'

--LEFT JOIN

SELECT
    c.nombre,
    c.ciudad,
    p.id as pedido_id,
    p.total
FROM clientes c 
LEFT JOIN pedidos p ON c.id = p.cliente_id

-- identificar a los clientes q nunca han comprado nada

SELECT c.nombre,
    c.ciudad,
    p.id
FROM clientes c 
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE p.id IS NULL

--RIGTH JOIN

SELECT c.nombre,
    p.id AS pedido_id,
    p.total
FROM clientes c 
RIGHT JOIN pedidos p ON c.id = p.cliente_id

--FULL OUTER JOIN
SELECT 
    c.nombre,
    p.id AS pedido_id,
    p.total
FROM clientes c 
FULL OUTER JOIN pedidos p ON c.id = p.cliente_id