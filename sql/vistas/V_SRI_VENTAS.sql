CREATE OR REPLACE FORCE VIEW V_SRI_VENTAS
AS WITH ventas AS
  (SELECT f.COD_DOCUMENTO codigo,
  f.NUM_FACTURA numero,
  NVL(pkg_sri.fun_get_establecimiento_venta(f.COD_DOCUMENTO, f.NUM_FACTURA), '999') establecimiento,
  TO_CHAR(f.FECHA_FACTURA, 'rrrr') anio,
  TO_CHAR(f.FECHA_FACTURA, 'mm') mes,
  f.FECHA_FACTURA AS fecha,
  DECODE(c.COD_DOCUMENTO, 1, '04', 2, '05', 4, '07', '06') tipo_documento,
  c.DOCUMENTO,
  c.RAZON_SOCIAL,
  'NO' relacionado,
  DECODE(f.COD_DOCUMENTO, 'FAC', '18') tipo_comprobante,
  DECODE(pkg_sri.fun_verifica_electronico(f.COD_DOCUMENTO, f.NUM_FACTURA), NULL, 'F', 'E') tipo_Emision,
  0 base_no_iva,
    round(sum(decode(d.PORCENTAJE_IVA,0,d.TOTAL_REG,0)),2) base_IVA_0,
  round(sum(decode(d.PORCENTAJE_IVA,0,0,d.TOTAL_REG)),2) base_IVA,
  ROUND(f.IVA, 2) iva,
  0 ice,
  0 RETENCION_IVA,
  0 retencion_renta
FROM FAC_FACTURA_C f
INNER JOIN V_CLIENTE c
ON f.COD_EMPRESA  = c.COD_EMPRESA
AND f.COD_CLIENTE = c.COD_CLIENTE
INNER JOIN FAC_FACTURA_D d
ON d.COD_EMPRESA        = f.COD_EMPRESA
AND d.COD_DOCUMENTO     = f.COD_DOCUMENTO
AND d.NUM_FACTURA       = f.NUM_FACTURA
WHERE f.COD_DOCUMENTO   = 'FAC'
AND NVL(f.ESTADO, 'G') <> 'A'
group by f.COD_DOCUMENTO ,
  f.NUM_FACTURA ,
  NVL(pkg_sri.fun_get_establecimiento_venta(f.COD_DOCUMENTO, f.NUM_FACTURA), '999') ,
  TO_CHAR(f.FECHA_FACTURA, 'rrrr') ,
  TO_CHAR(f.FECHA_FACTURA, 'mm') ,
  f.FECHA_FACTURA,
  DECODE(c.COD_DOCUMENTO, 1, '04', 2, '05', 4, '07', '06') ,
  c.DOCUMENTO,
  c.RAZON_SOCIAL,
  'NO' ,
  DECODE(f.COD_DOCUMENTO, 'FAC', '18') ,
  DECODE(pkg_sri.fun_verifica_electronico(f.COD_DOCUMENTO, f.NUM_FACTURA), NULL, 'F', 'E') ,
  0 ,
  f.TOTAL_SIN_IVA                      - DECODE(f.IVA, 0, f.DESCUENTOS, 0) ,
  DECODE(f.IVA, 0, 0, (f.TOTAL_FACTURA - f.TOTAL_SIN_IVA - f.DESCUENTOS) - f.IVA) ,
  ROUND(f.IVA, 2) ,
  0 ,
  0 ,
  0 
  UNION
  SELECT d.COD_DOCUMENTO codigo,
    d.NUM_DEVOLUCION numero,
    NVL(pkg_sri.fun_get_establecimiento_venta(d.COD_DOCUMENTO,d.NUM_DEVOLUCION),'999') establecimiento,
    TO_CHAR(d.FECHA_DEVOLUCION,'rrrr') anio,
    TO_CHAR(d.FECHA_DEVOLUCION,'mm') mes,
    d.FECHA_DEVOLUCION fecha,
    DECODE(c.COD_DOCUMENTO,1,'04',2,'05',4,'07','06') tipo_documento,
    c.DOCUMENTO,
    c.RAZON_SOCIAL,
    'NO' relacionado,
    DECODE(d.COD_DOCUMENTO,'DVC','04') tipo_comprobante,
    DECODE(pkg_sri.fun_verifica_electronico(d.COD_DOCUMENTO,d.NUM_DEVOLUCION),NULL,'F','E') tipo_Emision,
    0 base_no_iva,
    ROUND(d.TOTAL_SIN_IVA,2) base_IVA_0,
    ROUND(d.TOTAL_CON_IVA-d.DESCUENTOS,2) base_IVA,
    ROUND(d.IVA,2),
    0 ice,
    0 RETENCION_IVA,
    0 retencion_renta
  FROM FAC_DEVOLUCION_C d
  INNER JOIN V_CLIENTE c
  ON d.COD_EMPRESA       = c.COD_EMPRESA
  AND d.COD_CLIENTE      = c.COD_CLIENTE
  AND NVL(d.estado,'G') <>'A'
  AND (d.COD_DOCUMENTO,d.NUM_DEVOLUCION) NOT IN
      (SELECT cod_documento,
        num_devolucion
      FROM fac_devolucion_d
      WHERE NVL(cod_factura,'NVE')='NVE'
      )
      union SELECT nc.COD_DOCUMENTO,
  nc.NUM_ABONO,
  NVL(pkg_sri.fun_get_establecimiento_venta(nc.COD_DOCUMENTO, nc.NUM_ABONO), '999') establecimiento,
  
  TO_CHAR(nc.FECHA_ABONO,'rrrr') anio,
    TO_CHAR(nc.FECHA_ABONO,'mm') mes,
    nc.FECHA_ABONO AS fecha,
      DECODE(c.COD_DOCUMENTO,1,'04',2,'05',4,'07','06') tipo_documento,
    c.DOCUMENTO,
    c.RAZON_SOCIAL,
    'NO' relacionado,
     DECODE(nc.COD_DOCUMENTO,'NCC','04') tipo_comprobante,
    DECODE(pkg_sri.fun_verifica_electronico(nc.COD_DOCUMENTO,nc.NUM_ABONO),NULL,'F','E') tipo_Emision,
    0 base_no_iva,
    0 base_IVA_0,
    round(nc.TOTAL_CAPITAL/(FUN_GET_PORCENTAJE_IVA/100+1),2) base_IVA,
    round(round(nc.TOTAL_CAPITAL/(FUN_GET_PORCENTAJE_IVA/100+1),2)*FUN_GET_PORCENTAJE_IVA/100,2) iva,
    0 ice,
    0 RETENCION_IVA,
    0 retencion_renta
  
FROM V_CLIENTE c
INNER JOIN CXC_ABONO_C nc
ON c.COD_EMPRESA         = nc.COD_EMPRESA
AND c.COD_CLIENTE        = nc.COD_CLIENTE
WHERE nc.COD_DOCUMENTO   = 'NCC'
AND NVL(nc.ESTADO, 'G') <> 'A'
  )
SELECT "CODIGO",
  "NUMERO",
  "ESTABLECIMIENTO",
  "ANIO",
  "MES",
  "FECHA",
  "TIPO_DOCUMENTO",
  "DOCUMENTO",
  "RAZON_SOCIAL",
  "RELACIONADO",
  "TIPO_COMPROBANTE",
  "TIPO_EMISION",
  "BASE_NO_IVA",
  "BASE_IVA_0",
  "BASE_IVA",
  "IVA",
  "ICE",
  "RETENCION_IVA",
  "RETENCION_RENTA"
FROM ventas;