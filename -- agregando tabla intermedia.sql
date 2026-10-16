-- agregando tabla intermedia
CREATE TABLE detalle_pedido(
    id SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL, 
    cantidad INT NOT NULL,
    CONSTRAINT fk_pedidos_detalle_pedido
    FOREIGN KEY (pedido_id)
    REFERENCES pedidos(id),
    CONSTRAINT fk_detalle_producto
    FOREIGN KEY (producto_id)
    REFERENCES productos(id)
)

INSERT INTO productos(nombre, precio)
VALUES ('arroz',10),('azucar',50),('fideo',20),('quinua',100),('pañales',200)
INSERT INTO productos(nombre, precio)
VALUES ('chicle',0.50),('chupete',5),('gomita',1),('quinua',100),('pañales',200)


SELECT * from productos
SELECT * from pedidos
SELECT * FROM detalle_pedido
--45.5
INSERT INTO detalle_pedido(pedido_id, producto_id, cantidad)
VALUES(6,5,2),(6,4,1)

-- join multiples tablas

SELECT 
    c.nombre AS cliente_nombre,
    p.id AS nro_pedido,
    pr.nombre AS producto, 
    dp.cantidad,
    pr.precio
FROM clientes c 
INNER JOIN pedidos p ON c.id = p.cliente_id
INNER JOIN detalle_pedido dp ON p.id = dp.pedido_id
INNER JOIN productos pr ON dp.producto_id = pr.id

/* 
    ejercicio 1: obten una lista de todas las ciudades registradas en la tabla 
    clientes y la cantidad de pedidos asociados

    ejercicio 2: encuentra que pedidos no tienen ningun cliente asociado

    ejercicio 3: muestra el listado de todos los clientes con el monto total acumulado de sus compras 
    los clientes sin pedidos deben mostrar 0.00 en lugar de NULL 
 */