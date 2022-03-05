-- Se crea el esquema tienda

DROP SCHEMA IF EXISTS store;
CREATE SCHEMA IF NOT EXISTS store;
USE store;


-- Se crea la tabla de proveedores

CREATE TABLE IF NOT EXISTS supplier (
  sup_id INT NOT NULL AUTO_INCREMENT,
  sup_name VARCHAR(45) NOT NULL,
  sup_phone VARCHAR(15) NOT NULL,
  sup_email VARCHAR(256) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NULL,
  deleted_at DATETIME NULL,
  PRIMARY KEY (sup_id))
ENGINE = InnoDB;


-- Se crea la tabla producto

CREATE TABLE IF NOT EXISTS product (
  prod_id INT NOT NULL AUTO_INCREMENT,
  prod_sup_id INT NOT NULL,
  prod_name VARCHAR(45) NOT NULL,
  prod_price DOUBLE NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NULL,
  deleted_at DATETIME NULL,
  PRIMARY KEY (prod_id),
  INDEX fk_product_supplier_idx (prod_sup_id ASC) VISIBLE,
  CONSTRAINT fk_product_supplier
    FOREIGN KEY (prod_sup_id)
    REFERENCES supplier (sup_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Se crea la tabla  vendedor

CREATE TABLE IF NOT EXISTS seller (
  sel_id INT NOT NULL AUTO_INCREMENT,
  sel_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (sel_id))
ENGINE = InnoDB;


-- Se crea la tabla tipo de documento

CREATE TABLE IF NOT EXISTS type_doc (
  type_doc_id INT NOT NULL AUTO_INCREMENT,
  type_doc_ref VARCHAR(2) NULL,
  PRIMARY KEY (type_doc_id))
ENGINE = InnoDB;


-- Se crea la tabla de cliente

CREATE TABLE IF NOT EXISTS customer (
  cus_id INT NOT NULL AUTO_INCREMENT,
  cus_type_doc_id INT NOT NULL,
  cus_doc VARCHAR(11) NOT NULL,
  PRIMARY KEY (cus_id),
  UNIQUE INDEX cus_doc_UNIQUE (cus_type_doc_id ASC, cus_doc ASC) INVISIBLE,
  INDEX fk_customer_type_doc1_idx (cus_type_doc_id ASC) VISIBLE,
  CONSTRAINT fk_customer_type_doc1
    FOREIGN KEY (cus_type_doc_id)
    REFERENCES type_doc (type_doc_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Se crea la tabla venta

CREATE TABLE IF NOT EXISTS sale (
  sale_id INT NOT NULL AUTO_INCREMENT,
  sale_sel_id INT NOT NULL,
  sale_cus_id INT NOT NULL,
  created_at DATETIME NOT NULL,
  deleted_at TIMESTAMP,
  PRIMARY KEY (sale_id),
  INDEX fk_sale_seller_idx (sale_sel_id ASC) VISIBLE,
  INDEX fk_sale_customer_idx (sale_cus_id ASC) VISIBLE,
  CONSTRAINT fk_sale_seller
    FOREIGN KEY (sale_sel_id)
    REFERENCES seller (sel_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_sale_customer
    FOREIGN KEY (sale_cus_id)
    REFERENCES customer (cus_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Se crea la tabla item

CREATE TABLE IF NOT EXISTS item (
  item_id INT NOT NULL AUTO_INCREMENT,
  item_sale_id INT NOT NULL,
  item_prod_id INT NOT NULL,
  item_quantity VARCHAR(45) NOT NULL,
  PRIMARY KEY (item_id),
  INDEX fk_item_sale_idx (item_sale_id ASC) VISIBLE,
  INDEX fk_item_product_idx (item_prod_id ASC) VISIBLE,
  CONSTRAINT fk_item_sale
    FOREIGN KEY (item_sale_id)
    REFERENCES sale (sale_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_item_product
    FOREIGN KEY (item_prod_id)
    REFERENCES product (prod_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Se llena la tabla de proveedores

INSERT INTO supplier (sup_name, sup_phone, sup_email, created_at)
VALUES ('Lapiceros Cool', '315678453', 'contacto@lapiceroscool.com', now());

INSERT INTO supplier (sup_name, sup_phone, sup_email, created_at)
VALUES ('Colores Rayón', '320758996', 'contacto@coloresrayon.com', now());

INSERT INTO supplier (sup_name, sup_phone, sup_email, created_at)
VALUES ('Marcado Real', '310432113', 'contacto@marcadoreal.com', now());

-- Se llena la tabla de productos

INSERT INTO product (prod_sup_id, prod_name, prod_price, created_at)
VALUES (1, 'boligrafo 062-M', 2000, now());

INSERT INTO product (prod_sup_id, prod_name, prod_price, created_at)
VALUES (1, 'boligrafo Retractil Job', 1500, now());

INSERT INTO product (prod_sup_id, prod_name, prod_price, created_at)
VALUES (1, 'boligrafo Basic', 1000, now());

INSERT INTO product (prod_sup_id, prod_name, prod_price, created_at)
VALUES (2, 'colores x 12 unidades', 16900, now());

INSERT INTO product (prod_sup_id, prod_name, prod_price, created_at)
VALUES (2, 'colores x 15 unidades', 20800, now());

INSERT INTO product (prod_sup_id, prod_name, prod_price, created_at)
VALUES (3, 'marcadores lavables x 12 unidades', 18600, now());

INSERT INTO product (prod_sup_id, prod_name, prod_price, created_at)
VALUES (3, 'marcadores doble punta x 5 unidades', 19000, now());

-- Se llena la tabla vendedor

INSERT INTO seller (sel_name)
VALUES ('Marcos Rodriguez');

-- Se llena la tabla de tipo de documento

INSERT INTO type_doc ( type_doc_ref)
VALUES ('TI');

INSERT INTO type_doc ( type_doc_ref)
VALUES ('CC');

-- Se llena la tabla cliente

INSERT INTO customer (cus_type_doc_id, cus_doc)
VALUES (1, '1156472856');

INSERT INTO customer (cus_type_doc_id, cus_doc)
VALUES (1, '1174629674');

INSERT INTO customer (cus_type_doc_id, cus_doc)
VALUES (2, '1052548793');

INSERT INTO customer (cus_type_doc_id, cus_doc)
VALUES (2, '1165847352');

INSERT INTO customer (cus_type_doc_id, cus_doc)
VALUES (2, '1184736212');

-- se llena la tabla venta

INSERT INTO sale (sale_sel_id, sale_cus_id, created_at)
VALUES (1, 1, now());

INSERT INTO sale (sale_sel_id, sale_cus_id, created_at)
VALUES (1, 2, now());

INSERT INTO sale (sale_sel_id, sale_cus_id, created_at)
VALUES (1, 3, now());

INSERT INTO sale (sale_sel_id, sale_cus_id, created_at)
VALUES (1, 4, now());

INSERT INTO sale (sale_sel_id, sale_cus_id, created_at)
VALUES (1, 5, now());

-- Se llena la tabla item

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (1, 1, 2);

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (1, 4, 1);

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (2, 2, 4);

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (2, 7, 1);

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (3, 1, 2);

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (3, 4, 1);

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (4, 3, 4);

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (4, 4, 1);

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (5, 2, 4);

INSERT INTO item (item_sale_id, item_prod_id, item_quantity)
VALUES (5, 7, 2);

-- Se realizan los borrados lógicos de la tabla venta

UPDATE sale
SET deleted_at = now()
WHERE sale_id = 1;

UPDATE sale
SET deleted_at = now()
WHERE sale_id = 2;

-- Se realizan los borrados físicos de la tabla venta

DELETE FROM sale
WHERE sale_id = 3;

DELETE FROM sale
WHERE sale_id = 4;

-- Se modifica el nombre y el proveedor de 3 producto

UPDATE product 
SET prod_name = 'boligrafo LOOM',  prod_sup_id = 2
WHERE prod_id = 1;

UPDATE product 
SET prod_name = 'colores doble punta x 12 unidades',  prod_sup_id = 3
WHERE prod_id = 4;

UPDATE product 
SET prod_name = 'marcadores pastel x 5 unidades',  prod_sup_id = 1
WHERE prod_id = 6;




 