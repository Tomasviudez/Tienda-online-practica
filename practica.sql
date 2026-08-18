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






