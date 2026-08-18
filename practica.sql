-- retención (días sin comprar por cliente)
CREATE VIEW vista_retencion_clientes AS
SELECT 
    c.cliente_id,
    c.nombre,
    MAX(t.fecha) AS fecha_ultima_compra,
    CURRENT_DATE - MAX(t.fecha) AS dias_sin_comprar
FROM clientes c
JOIN transacciones t ON c.cliente_id = t.cliente_id
GROUP BY c.cliente_id, c.nombre;


-- LTV (valor total por cliente) sin los pedidos cancelados
CREATE VIEW vista_ltv_clientes AS
SELECT 
    c.cliente_id,
    c.nombre,
    SUM(t.total) AS valor_cliente,
    COUNT(*) AS cantidad_compras
FROM clientes c
JOIN transacciones t ON c.cliente_id = t.cliente_id
WHERE t.estado_envio <> 'Cancelado'
GROUP BY c.cliente_id, c.nombre;


-- Ingresos por categoria sin los pedidos cancelados
CREATE VIEW vista_ingresos_categoria AS
SELECT 
    p.categoria,
    SUM(t.total) AS ingresos_totales,
    COUNT(t.transaccion_id) AS n_transacciones,
    SUM(t.cantidad) AS unidades_vendidas
FROM transacciones t
JOIN productos p ON t.producto_id = p.producto_id
WHERE t.estado_envio <> 'Cancelado'
GROUP BY p.categoria;



-- Top 10 clientes más "fríos"
SELECT * FROM vista_retencion_clientes
ORDER BY dias_sin_comprar DESC
limit 10


-- Top 10 clientes de mayor valor, con más de 5 compras
SELECT * FROM vista_ltv_clientes
WHERE cantidad_compras > 5
ORDER BY valor_cliente DESC
limit 10




