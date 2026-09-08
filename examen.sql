-- Consultas y trigger del examen 

-- Consulta 1
SELECT DISTINCT  c.nombre, c.id_cliente, p.monto, p.fecha_pago, c2.valor, c2.id_contrato
FROM cliente c, pago p, contrato c2 
WHERE estado_pago = 'pagado' AND fecha_pago <= CURRENT_DATE();

-- consulta 2
SELECT estado_pago, fecha_pago
FROM pago
WHERE estado_pago = 'pendiente' AND fecha_pago > CURDATE();

-- consulta 3                           X
SELECT nombre, estado_pago COUNT(estado_pago)
FROM cliente, pago
where estado_pago = 'atrasado' and estado_pago > 2;

-- consulta 4  (trigger)
DELIMITER $$

CREATE TRIGGER actualizar_estado_pago
AFTER UPDATE ON pago
FOR EACH ROW
BEGIN
    IF OLD.fecha_esperada < CURRENT_DATE() THEN
        INSERT INTO pago (id_pago, estado_pago)
        VALUES (
            NEW.id_pago,
            (SELECT estado_pago FROM pago WHERE estado_pago = OLD.estado_pago),
            (SELECT estado_pago FROM pago WHERE estado_pago = 'atrasado'),
            CURRENT_USER()
        );
    END IF;
END$$

DELIMITER ;

-- consulta 5
SELECT c.nombre, c.telefono, p.id_propiedad, tp.nombre_tipo
FROM cliente c, propiedad p, tipo_propiedad tp 
WHERE id_propietario = id_cliente AND nombre_TIPO = 'arrendado';

 


























