-- Consulta SQL para obtener los productos vendidos 
-- digitando tipo de documento y número de documento

SELECT type_doc.type_doc_ref as 'Tipo documento', 
customer.cus_doc as 'Documento', product.prod_name as 'Producto' 
FROM product 
JOIN item ON item.item_prod_id = product.prod_id 
JOIN sale ON sale.sale_id = item.item_sale_id
JOIN customer ON customer.cus_id = sale.sale_cus_id
JOIN type_doc ON type_doc.type_doc_id = customer.cus_type_doc_id
WHERE cus_type_doc_id = 1
AND cus_doc = '1156472856';

-- Consultar productos por medio del nombre, 
-- el cual debe mostrar quien o quienes han sido sus proveedores

SELECT prod_name as 'Producto', sup_name as 'Proveedor' FROM supplier 
JOIN product ON product.prod_sup_id = supplier.sup_id
WHERE prod_name = 'boligrafo Retractil Job';

-- Crear una consulta que me permita ver qué producto ha sido el más vendido
-- y en qué cantidades de mayor a menor

SELECT product.prod_name as 'Producto', SUM(item.item_quantity) as 'Más Vendido' FROM item
JOIN product ON product.prod_id = item.item_prod_id
GROUP BY item.item_prod_id
ORDER BY SUM(item.item_quantity) DESC;